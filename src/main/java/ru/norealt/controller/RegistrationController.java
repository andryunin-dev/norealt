package ru.norealt.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import ru.norealt.domain.User;
import ru.norealt.domain.dto.CaptchaResponseDto;
import ru.norealt.service.UserService;

import javax.validation.Valid;
import java.util.Collections;
import java.util.Map;

@Controller
public class RegistrationController {

    private final static String CAPTCHA_URL = "https://www.google.com/recaptcha/api/siteverify?secret=%s&response=%s";

    @Autowired
    private UserService userService;

    @Value("${recaptcha.secret}")
    private String secret;

    @Autowired
    private RestTemplate restTemplate;



    /*   Registration user   */
    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }

    @PostMapping("/registration")
    public String addUser(
            @RequestParam("password2") String password2,
            @RequestParam("phone") String phone,
            @RequestParam("g-recaptcha-response") String captchaResponce,
            @Valid User user,
            BindingResult bindingResult,
            Model model
    ) {

        String url = String.format(CAPTCHA_URL, secret, captchaResponce);
        CaptchaResponseDto response = restTemplate.postForObject(url, Collections.emptyList(), CaptchaResponseDto.class);

        if (!response.isSuccess()) {
            model.addAttribute("captchaError", "Fill captcha");
        }

        boolean isEmptyPass2 = StringUtils.isEmpty(password2);
        boolean isEmptyPhone = StringUtils.isEmpty(phone);

        if (isEmptyPhone) {
            model.addAttribute("phoneError", "Введите телефон");
        }

        if (isEmptyPass2) {
            model.addAttribute("password2Error", "Повторите пароль");
        }

        if (user.getPassword() != null && !user.getPassword().equals(password2)) {
            model.addAttribute("passwordError", "Пароли не совпадают!");
        }

        if (    isEmptyPhone ||
                isEmptyPass2 ||
                bindingResult.hasErrors() ||
                model.containsAttribute("passwordError") ||
                !response.isSuccess()
        ) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);

            model.mergeAttributes(errors);

            return "registration";
        }

        if (!userService.addUser(user)) {
            model.addAttribute("emailError", "Пользователь с таким email уже существует!");
            return "registration";
        }

        return "redirect:/login";
    }




    /*   Activation user account   */
    @GetMapping("/activate/{code}")
    public String activate(Model model, @PathVariable String code) {
        boolean isActivated = userService.activateUser(code);

        if (isActivated) {
            model.addAttribute("messageType", "success");
            model.addAttribute("message", "Аккаунт успешно активирован!");
        } else {
            model.addAttribute("messageType", "danger");
            model.addAttribute("message", "Код активации не найден!");
        }

        return "login";
    }





    /*   Restore user password   */
    @GetMapping("/restore")
    public String getRestore() {
        return "restore_email";
    }

    @PostMapping("/restore")
    public String sendRestoreToken(
            Model model,
            @RequestParam("email") String email

    ) {
        boolean isRestore = userService.sendToken(email);

        if (isRestore) {
            model.addAttribute("messageRestore", "success");
            model.addAttribute("message", "Ссылка для восстановления пароля отправлена на ваш email.\nУбедитесь, что письмо не попало в папку \"Спам\"");
        } else {
            model.addAttribute("messageRestore", "danger");
            model.addAttribute("message", "Пользователь с таким email не найден!");
        }

        return "restore_email";
    }

    @GetMapping("/restore/{code}")
    public String getRestoreCode(Model model, @PathVariable String code) {
        boolean isRestore = userService.checkedRestoreCode(code);

        if (isRestore) {
            model.addAttribute("messageRestorePass", "success");
            model.addAttribute("message", "Введите новый пароль.");
        } else {
            model.addAttribute("messageRestorePass", "danger");
            model.addAttribute("message", "Ошибка! Неправильная ссылка.");
        }

        return "restore_password";
    }

    @PostMapping("/restore/{code}")
    public String updateProfile(
            @PathVariable String code,
            @RequestParam("password") String password,
            @RequestParam("password2") String password2,
            Model model
    ) {

        boolean isEmptyPass = StringUtils.isEmpty(password);
        boolean isEmptyPass2 = StringUtils.isEmpty(password2);

        if (isEmptyPass) {
            model.addAttribute("passwordErrorRestore", "Не может быть пустым");
            return "/restore_password";
        }

        if (isEmptyPass2) {
            model.addAttribute("password2ErrorRestore", "Не может быть пустым");
            return "/restore_password";
        }

        if (!password.equals(password2)) {
            model.addAttribute("passwordErrorRestore", "Пароли не совпадают!");
            return "/restore_password";
        }

        User user = userService.returnUser(code);

        userService.updateNewPassword(user, password);

        return "redirect:/login";
    }




}

