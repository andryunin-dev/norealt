package ru.norealt.controller;

import com.querydsl.core.types.Predicate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.querydsl.binding.QuerydslPredicate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import ru.norealt.domain.Role;
import ru.norealt.domain.User;
import ru.norealt.repo.UserRepo;
import ru.norealt.service.SortUserService;
import ru.norealt.service.UserService;

import java.util.Map;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private SortUserService sortUserService;

    @Autowired
    UserRepo userRepo;

//    @PreAuthorize("hasAuthority('ADMIN')")
//    @GetMapping("/administration/user_list")
//    public String getUserList(Model model) {
//        model.addAttribute("users", userService.findAll());
//
//        return "userList";
//    }

    //Удаление пользователя
    @PreAuthorize("hasAuthority('ADMIN')")
    @RequestMapping("/administration/remove/{user.id}")
    public String userDelete(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("user.id") Long iduser
    ) {
        // удаляет только админ
        if ( currentUser.getEmail().equals("admin@admin.com") ) {

            userRepo.deleteById(iduser);

        }
        return "redirect:/administration/user_list";
    }

    /////////////////////////
    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/administration/user_list")
    public String getUserList(
            @RequestParam(defaultValue = "0") Long min,
            @RequestParam(defaultValue = "2000000000") Long max,
            @RequestParam(defaultValue = "0") Integer page,
            @RequestParam(defaultValue = "100") Integer size,
            @RequestParam(defaultValue = "id") String group,
            @RequestParam(defaultValue = "asc") String sort,
            Model model,
            @QuerydslPredicate(root = User.class) Predicate predicate
    ) {
        long totalpages = sortUserService.getTotalPages(min, max, page, size, group);
        long totalelements = sortUserService.getTotalElements(min, max, page, size, group);
        long max_id = userRepo.findMaxId();

        Iterable<User> users = sortUserService.getAllUsers(min, max, predicate, page, size, group, sort);

        model.addAttribute("users", users);
        model.addAttribute("totalpages", totalpages);
        model.addAttribute("totalelements", totalelements);
        model.addAttribute("max_id", max_id);
        model.addAttribute("min", min);
        model.addAttribute("max", max);
        model.addAttribute("page", page);
        model.addAttribute("size", size);
        model.addAttribute("group", group);
        model.addAttribute("sort", sort);
        model.addAttribute("url", "/administration/user_list");

        return "userList";
    }

    //////////////////////////


    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/administration/edit/{user}")
    public String getUpdateUserAdministrator(@PathVariable User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());

        return "userEdit";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/administration/edit/{user}")
    public String updateUserAdministrator(
            @RequestParam String username,
            @RequestParam String phone,
            @RequestParam("active") boolean active,
            @RequestParam Map<String, String> form,
            @RequestParam("userId") User user
    ) {
        userService.updateUserAdministrator(user, username, phone, active, form);

        return "redirect:/administration/user_list";
    }

    @GetMapping("/profile")
    public String getUpdateUserProfile(
            @AuthenticationPrincipal User user,
//            @PathVariable User user,
            Model model
    ) {
        model.addAttribute("user", user);

        if (true) {
            model.addAttribute("messageUpdateUserProfile", "success");
            model.addAttribute("message", "Чтобы увидеть изменения, заново войдите в систему.");
        }

        return "profileUpdate";
    }

    @PostMapping("/profile")
    public String updateUserProfile(
            @RequestParam("username") String username,
            @RequestParam("phone") String phone,
            @AuthenticationPrincipal User user,
            Model model
    ) {
        boolean isEmptyUsername = StringUtils.isEmpty(username);
        boolean isEmptyPhone = StringUtils.isEmpty(phone);

        if (isEmptyUsername) {
            model.addAttribute("usernameErrorEmpty", "Не может быть пустым");
            return "profileUpdate";
        }

        if (isEmptyPhone) {
            model.addAttribute("phoneErrorEmpty", "Не может быть пустым");
            return "profileUpdate";
        }

        userService.updateUserProfile(user, username, phone);

        return "redirect:/main";
    }


    /*   Update user password   */
    @GetMapping("/profile/password_update")
    public String getUpdateUserPassword(
            @AuthenticationPrincipal User user,
            Model model
    ) {
        model.addAttribute("user", user);

        return "passwordUpdate";
    }

    @PostMapping("/profile/password_update")
    public String updateUserPassword(
            @RequestParam("old_password") String old_password,
            @RequestParam("password") String password,
            @RequestParam("password2") String password2,
            @AuthenticationPrincipal User user,
            Model model
    ) {

        boolean isEmptyOldPass = StringUtils.isEmpty(old_password);
        boolean isEmptyPass = StringUtils.isEmpty(password);
        boolean isEmptyPass2 = StringUtils.isEmpty(password2);
        boolean checkOldPassword = userService.checkOldPassword(user, old_password);

        if (isEmptyOldPass) {
            model.addAttribute("old_passwordErrorUpdate", "Не может быть пустым");
            return "/passwordUpdate";
        }

        if (!checkOldPassword) {
            model.addAttribute("old_passwordErrorUpdate", "Неверный пароль");
            return "/passwordUpdate";
        }

        if (isEmptyPass) {
            model.addAttribute("passwordErrorUpdate", "Не может быть пустым");
            return "/passwordUpdate";
        }

        if (isEmptyPass2) {
            model.addAttribute("password2ErrorUpdate", "Не может быть пустым");
            return "/passwordUpdate";
        }

        if (!password.equals(password2)) {
            model.addAttribute("passwordErrorUpdate", "Пароли не совпадают!");
            return "/passwordUpdate";
        }

        userService.updateNewPassword(user, password);

        return "redirect:/main";
    }




}
