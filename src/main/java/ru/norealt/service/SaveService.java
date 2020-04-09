package ru.norealt.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import ru.norealt.domain.Message;
import ru.norealt.domain.Role;
import ru.norealt.domain.User;
import ru.norealt.repo.MessageRepo;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.UUID;

@Service
public class SaveService {

    public String resultFilename;

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    MessageRepo messageRepo;

    public boolean saveMessage(
            @AuthenticationPrincipal User user,
            @Valid Message message,
            @RequestParam("file") MultipartFile file
    ) throws IOException {

        message.setAuthor(user);

        if (file != null && !file.getOriginalFilename().isEmpty()) {
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + "/" + resultFilename));

            message.setFilename(resultFilename);


        }

        message.setPost_date(LocalDateTime.now().toLocalDate().toString());

        messageRepo.save(message);

        return true;
    }

//    public boolean addMessage(User user) {
////      checked email in DB
//        User emailFromDb = userRepo.findByEmail(user.getEmail());
//        if (emailFromDb != null) {
//            return false;
//        }
//        user.setActive(false);
//        user.setRoles(Collections.singleton(Role.USER));
//        user.setActivationCode(UUID.randomUUID().toString());
//        user.setPassword(passwordEncoder.encode(user.getPassword()));
//        user.setRegistrationDate(LocalDateTime.now().toLocalDate().toString());
//
//        userRepo.save(user);
//
//        sendEmailActivationCode(user);
//
//        return true;
//    }


    public void deleteAll(
            @AuthenticationPrincipal User user,
            @PathVariable("message.filename") String filename
    ) {

//        deletePreview(user, filename, "800X800_");

        deleteOriginal(user, filename);

    }

    private void deletePreview(@AuthenticationPrincipal User user, @PathVariable("message.filename") String filename, String s) {
        String path = uploadPath + "/" + user.getId().toString() + "/" + s + filename;
        File file = new File(path);
        file.delete();
    }

    private void deleteOriginal(@AuthenticationPrincipal User user, @PathVariable("message.filename") String filename) {
        String path = uploadPath + "/" + user.getId().toString() + "/" + filename;
        File file = new File(path);
        file.delete();
    }

}
