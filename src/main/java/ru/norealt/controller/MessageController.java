package ru.norealt.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import ru.norealt.domain.Message;
import ru.norealt.domain.User;
import ru.norealt.repo.MessageRepo;
import ru.norealt.service.SaveService;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

@Controller
public class MessageController {

    @Autowired
    private MessageRepo messageRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    private SaveService saveService;

    @GetMapping("/")
    public String greeting(Map<String, Object> model) {
        return "greeting";
    }

    @GetMapping("/main")
    public String main(
            @RequestParam(required = false, defaultValue = "") String filter,
            @RequestParam(required = false, defaultValue = "") String filter2,
            Model model
    ) {

        //получить весь список из БД
        Iterable<Message> messages;

        if (filter != null && !filter.isEmpty()) {
            messages = messageRepo.findByTag(filter);
        } else if (filter2 != null && !filter2.isEmpty()) {
            messages = messageRepo.findByTextContainingIgnoreCase(filter2);
        } else {
            messages = messageRepo.findAll();
        }

        model.addAttribute("messages", messages);
        model.addAttribute("filter", filter);
        model.addAttribute("filter2", filter2);

        return "main";
    }

    //сообщения пользователя
    @GetMapping("/user-messages/{author}")
    public String userMessages(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User author,
            Model model
    ) {

        Set<Message> messages = author.getMessages();
        model.addAttribute("messages", messages);
        model.addAttribute("isCurrentUser", currentUser.equals(author));

        return "userMessages";
    }

    // отображение одного сообщения на станице
    @GetMapping("/message/{message.id}")
    public String rootMessage(
            @PathVariable("message.id") Long idmessage,
            Model model
    ) {
        //получить весь список из БД
        Iterable<Message> messages;

//        messages = messageRepo.findAll();
        messages = messageRepo.findAllById(idmessage);

        model.addAttribute("messages", messages);

        return "rootMessage";
    }





}
