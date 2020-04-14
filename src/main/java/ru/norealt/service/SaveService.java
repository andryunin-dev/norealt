package ru.norealt.service;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import ru.norealt.domain.Message;
import ru.norealt.domain.User;
import ru.norealt.repo.MessageRepo;

import javax.validation.Valid;
import java.io.*;
import java.time.LocalDateTime;
import java.util.UUID;

@Service
public class SaveService {

    public String resultFilename;

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    MessageRepo messageRepo;

    // метод save
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


    // метод save с превью и поворотом изображения
    public boolean saveThumbnail(
            @AuthenticationPrincipal User user,
            @Valid Message message,
            @RequestParam("file") MultipartFile multipartFile
    ) throws IOException {

        if (multipartFile != null && !multipartFile.getOriginalFilename().isEmpty()) {

            //создание нового имени файла
            transfomFilename(multipartFile);

            //проверка существует ли дирректория
//            String resultDir = dirExist(user);

            //читаем файл в массив байт
            byte[] data = multipartFile.getBytes();

            //создание превью и новой оригинальной картинки
//            createSquarePreview(resultDir, data, 800, 800);
            createSquarePreview(uploadPath, data, 640, 480);
//            createOriginalPreview(resultDir, data, 1280, 1280);

            //загрузка оригинального файла на сервер
//            multipartFile.transferTo(new File(resultDir + "/" + resultFilename));

            //Запись имени файла в БД
            message.setFilename(resultFilename);

        }

        return true;
    }


    //создание нового имени файла
    private void transfomFilename(@RequestParam("file") MultipartFile multipartFile) {
        // получаем расширение от MultipartFile
        String[] contentType = multipartFile.getOriginalFilename().split("\\.");
        String fileType = contentType[contentType.length - 1].toLowerCase();

        // присваеваем уникальное имя файла + расширение
        String uuidFile = UUID.randomUUID().toString();
        resultFilename = uuidFile + "." + fileType;
    }


    //проверка существует ли дирректория
    private String dirExist(@AuthenticationPrincipal User user) {
        String resultDir = uploadPath + "/" + user.getId().toString();
        File uploadDir = new File(resultDir);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        return resultDir;
    }


    //общий метод создания квадратного превью
    private void createSquarePreview(String resultDir, byte[] data, int width, int height) throws IOException {
        ByteArrayInputStream input = new ByteArrayInputStream(data);
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        Thumbnails.of(input)
                .useExifOrientation(true)
                .crop(Positions.CENTER)
                .size( width, height)
                .outputQuality(0.90)
                .toOutputStream(outputStream);

        byte[] dataOut = outputStream.toByteArray();

//        String pathFile = resultDir + "/" + width + "X" + height + "_" + resultFilename;
        String pathFile = resultDir + "/" + resultFilename;

        uploadToServer(dataOut, pathFile);
    }


    //общий метод создания оригинального превью
    private void createOriginalPreview(String resultDir, byte[] data, int width, int height) throws IOException {
        ByteArrayInputStream input = new ByteArrayInputStream(data);
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        Thumbnails.of(input)
                .useExifOrientation(true)
                .size(width, height)
                .outputQuality(0.90)
                .toOutputStream(outputStream);

        byte[] dataOut = outputStream.toByteArray();

        String pathFile = resultDir + "/" + resultFilename;

        uploadToServer(dataOut, pathFile);
    }


    //отправка файла на сервер
    private void uploadToServer(byte[] dataOut, String pathFile) throws IOException {
        FileOutputStream fos = new FileOutputStream(new File(pathFile));
        fos.write(dataOut);
        fos.close();
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
        String path = uploadPath + "/" + filename;
        File file = new File(path);
        file.delete();
    }

}
