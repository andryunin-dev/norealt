package ru.norealt.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import ru.norealt.domain.Message;
import ru.norealt.domain.User;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Service
public class SaveService {

    public String resultFilename;

    @Value("${upload.path}")
    private String uploadPath;

    public void save(
            @AuthenticationPrincipal User user,
            @Valid Message message,
            @RequestParam("file") MultipartFile file
    ) throws IOException {

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
    }


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
