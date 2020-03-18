package ru.norealt.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import ru.norealt.domain.Role;
import ru.norealt.domain.User;
import ru.norealt.repo.UserRepo;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private MailService mailService;

    @Value("${serverAddress}")
    private String serverAddress;

    @Autowired
    private PasswordEncoder passwordEncoder;


    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userRepo.findByEmail(email);
        if (user == null) {
            throw new UsernameNotFoundException("Not found!");
        }
        return user;
    }

    public void addLastVisit(User user) {
        user.setLastVisit(LocalDateTime.now().toString());
        userRepo.save(user);
    }

    public boolean addUser(User user) {
//      checked email in DB
        User emailFromDb = userRepo.findByEmail(user.getEmail());
        if (emailFromDb != null) {
            return false;
        }
        user.setActive(false);
        user.setRoles(Collections.singleton(Role.USER));
        user.setActivationCode(UUID.randomUUID().toString());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRegistrationDate(LocalDateTime.now().toLocalDate().toString());

        userRepo.save(user);

        sendEmailActivationCode(user);

        return true;
    }

    /*   email writing activation code   */
    private void sendEmailActivationCode(User user) {
        if (!StringUtils.isEmpty(user.getEmail())) {
            String message = String.format(
                    "Привет, %s! \n" +
                            "Чтобы активировать аккаунт, перейдите по ссылке: \n" +
                            "%s/activate/%s",
                    user.getUsername(),
                    serverAddress,
                    user.getActivationCode()
            );

            mailService.send(user.getEmail(), "Активация аккаунта", message);
        }
    }

    /*   email writing restore code   */
    private void sendEmailRestoreCode(User user) {
        if (!StringUtils.isEmpty(user.getEmail())) {
            String message = String.format(
                    "Привет, %s! \n" +
                            "Мы получили запрос на восстановление доступа к вашей учётной записи, если это были вы, перейдите по ссылке: \n" +
                            "%s/restore/%s\n" +
                            "Скопируйте ссылку и откройте через адресную строку браузера, если она не работает.\n" +
                            "Если вы не запрашивали изменение пароля, проигнорируйте это письмо.",
                    user.getUsername(),
                    serverAddress,
                    user.getPhone()
            );

            mailService.send(user.getEmail(), "Сброс пароля", message);
        }
    }

    /*   activate User   */
    public boolean activateUser(String code) {
        User user = userRepo.findByActivationCode(code);
        if (user == null) {
            return false;
        }
        user.setActivationCode(null);
        user.setActive(true);
        userRepo.save(user);

        return true;
    }

    /*   check restore code User   */
    public boolean checkedRestoreCode(String code) {
        User user = userRepo.findByRestoreCode(code);
        if (user == null) {
            return false;
        }
        return true;
    }

    /*   find user by restore code   */
    public User returnUser(String code) {
        User user = userRepo.findByRestoreCode(code);
        return user;
    }

    /*   check email, set and send restore code   */
    public boolean sendToken(String email) {
        User user = userRepo.findByEmail(email);
        if (user == null) {
            return false;
        }
        user.setRestoreCode(UUID.randomUUID().toString());
        userRepo.save(user);
        sendEmailRestoreCode(user);

        return true;
    }

    /*   update new Password   */
    public boolean updateNewPassword(User user, String password) {

        if (!StringUtils.isEmpty(password)) {
            user.setPassword(password);
        }

        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRestoreCode(null);
        userRepo.save(user);

        return true;
    }



    public List<User> findAll() {
        return userRepo.findAll();
    }

    public void saveUser(User user, String username,
                         boolean active,
                         Map<String, String> form) {
        user.setUsername(username);
        user.setActive(active);

        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());

        user.getRoles().clear();

        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }

        userRepo.save(user);
    }

    public void updateProfile(User user, String password, String email) {
        String userEmail = user.getEmail();

        boolean isEmailChanged = (email != null && !email.equals(userEmail)) ||
                (userEmail != null && !userEmail.equals(email));

        if (isEmailChanged) {
            user.setEmail(email);

            if (!StringUtils.isEmpty(email)) {
                user.setActivationCode(UUID.randomUUID().toString());
            }
        }

        if (!StringUtils.isEmpty(password)) {
            user.setPassword(password);
        }

        user.setPassword(passwordEncoder.encode(user.getPassword()));

        userRepo.save(user);

        if (isEmailChanged) {
            sendEmailActivationCode(user);
        }
    }


}
