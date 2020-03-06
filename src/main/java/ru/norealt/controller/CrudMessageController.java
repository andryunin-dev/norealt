package ru.norealt.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import ru.norealt.domain.Message;
import ru.norealt.domain.User;
import ru.norealt.repo.MessageRepo;
import ru.norealt.service.SaveService;

import javax.validation.Valid;
import java.io.IOException;
import java.util.Map;

@Controller
public class CrudMessageController {

    @Autowired
    private MessageRepo messageRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    private SaveService saveService;



    //форма добавления сообщения
    @GetMapping("/messageAdd")
    public String messageAdd() {
        return "messageAdd";
    }

    @PostMapping("/messageAdd")
    public String add(
            @AuthenticationPrincipal User user,
            @Valid Message message,
            BindingResult bindingResult,
            Model model,
            @RequestParam("file") MultipartFile file
    ) throws IOException {

        message.setAuthor(user);

        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);

            model.mergeAttributes(errorsMap);
            model.addAttribute("message", message);

            //добавить временный редирект на страницу ошибки
//            return "redirect:/messageAdd";
            return "messageAdd";

        } else {
            saveService.save(user, message, file);

            //очистить форму после успешной валидации
            model.addAttribute("message", null);

            //сохраняем в БД
            messageRepo.save(message);

        }

        //получить весь список из БД
        Iterable<Message> messages = messageRepo.findAll();
        model.addAttribute("messages", messages);

        return "redirect:/main";

    }


    //Редактирование сообщения с файлом
    @GetMapping("/messageEdit/{user}")
    public String messageEdit(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            Model model,
            @RequestParam(required = false) Message message
    ) {
        Iterable<Message> messages;
        messages = messageRepo.findAllById(message.getId());

        model.addAttribute("messages", messages);
        model.addAttribute("message", message);
        model.addAttribute("isCurrentUser", currentUser.equals(user));

        return "messageEdit";
    }

    //Редактирование сообщения с файлом
    @PostMapping("/messageEdit/{user}")
    public String messageEdit(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long user,
            @RequestParam("id") Message message,
            @RequestParam("text") String text,
            @RequestParam("tag") String tag,
            @RequestParam("filename") String filename,
            @RequestParam("file") MultipartFile file
    ) throws IOException {
        if (message.getAuthor().equals(currentUser) || currentUser.getUsername().equals("admin")) {

            if (!StringUtils.isEmpty(text)) {
                message.setText(text);
            }

            if (!StringUtils.isEmpty(tag)) {
                message.setTag(tag);
            }

            //загрузка нового файла в репозиторий
            saveService.save(message.getAuthor(), message, file);

            //сохранить сообщение в БД
            messageRepo.save(message);

            //удалить старый файл из репозитория
            if (!(filename.equals(saveService.resultFilename)) && !(saveService.resultFilename == null)) {
                saveService.deleteAll(message.getAuthor(), filename);
            }

            //имя нового файла в null
            saveService.resultFilename = null;

        }

        return "redirect:/user-messages/" + user;
    }

    //Удаление сообщения с файлом
    @RequestMapping("/remove/{message.author.id}/{message.id}/{message.filename}")
    public String messageDelete(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("message.author.id") Long idauthor,
            @PathVariable("message.id") Long idmessage,
            @PathVariable("message.filename") String filename
            //@RequestParam Message message
    ) {
        // удаляет только текущий пользователь или админ
        if ( idauthor.equals(currentUser.getId()) || currentUser.getUsername().equals("admin") ) {

            String n = "null";
            if (filename.equals(n)) {
                //удалить сообщение из БД
                messageRepo.deleteById(idmessage);
            } else {

                //удалить сообщение из БД
                messageRepo.deleteById(idmessage);

                //удалить файл
                if (!(filename == null)) {
                    saveService.deleteAll(currentUser, filename);
                }

            }

        }
        return "redirect:/user-messages/" + currentUser.getId().toString();
    }
}
