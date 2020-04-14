package ru.norealt.controller;

import com.querydsl.core.types.Predicate;
import com.querydsl.core.types.dsl.BooleanExpression;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.querydsl.binding.QuerydslPredicate;
import org.springframework.lang.NonNull;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import ru.norealt.domain.Message;
import ru.norealt.domain.QMessage;
import ru.norealt.domain.User;
import ru.norealt.repo.MessageRepo;
import ru.norealt.service.SortMessageService;

import java.util.Map;
import java.util.Set;

@Controller
public class MessageController {

    @Autowired
    private MessageRepo messageRepo;

    @Autowired
    private SortMessageService sortMessageService;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String greeting() {
        return "redirect:/main";
    }

//    @GetMapping("/main")
//    public String main(
//            @RequestParam(required = false, defaultValue = "") String filter,
//            @RequestParam(required = false, defaultValue = "") String filter2,
//            Model model
//    ) {
//
//        //получить весь список из БД
//        Iterable<Message> messages;
//
//        if (filter != null && !filter.isEmpty()) {
////            messages = messageRepo.findByTag(filter);
//            messages = messageRepo.findByTextContainingIgnoreCase(filter2);
//        } else if (filter2 != null && !filter2.isEmpty()) {
//            messages = messageRepo.findByTextContainingIgnoreCase(filter2);
//        } else {
//            messages = messageRepo.findAll();
//        }
//
//        model.addAttribute("messages", messages);
//        model.addAttribute("filter", filter);
//        model.addAttribute("filter2", filter2);
//
//        return "main";
//    }

    /////////////////////////
    @GetMapping("/main")
    public String getMessageList(
            @RequestParam(defaultValue = "0") Integer page,
            @RequestParam(defaultValue = "24") Integer size,
            @RequestParam(defaultValue = "id") String group,
            @RequestParam(defaultValue = "desc") String sort,
            @RequestParam(defaultValue = "0") Long min,
            @RequestParam(defaultValue = "2000000000") Long max,
            @RequestParam(defaultValue = " ") String city,
            @RequestParam(defaultValue = " ") String countRooms,
            Model model,
            @QuerydslPredicate(root = Message.class) Predicate predicate
    ) {

        BooleanExpression predicateNew = QMessage.message.price.between(min, max).and(predicate);
        long totalpages = sortMessageService.getTotalPagesImproved(page, size, group, predicateNew);
        long totalelements = sortMessageService.getTotalElementsImproved(page, size, group, predicateNew);
        long min_price = messageRepo.findMinPrice();
        long max_price = messageRepo.findMaxPrice();

        Iterable<Message> messages = sortMessageService.getAllMessagesImproved(page, size, group, sort, predicateNew);

        model.addAttribute("messages", messages);
        model.addAttribute("totalpages", totalpages);
        model.addAttribute("totalelements", totalelements);
        model.addAttribute("min_price", min_price);
        model.addAttribute("max_price", max_price);
        model.addAttribute("min", min);
        model.addAttribute("max", max);
        model.addAttribute("page", page);
        model.addAttribute("size", size);
        model.addAttribute("group", group);
        model.addAttribute("sort", sort);
        model.addAttribute("city", city);
        model.addAttribute("countRooms", countRooms);
        model.addAttribute("url", "/main");

        return "main";
    }

    //////////////////////////


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
