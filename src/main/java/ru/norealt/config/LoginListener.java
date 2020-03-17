package ru.norealt.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.security.authentication.event.InteractiveAuthenticationSuccessEvent;
import org.springframework.stereotype.Component;
import ru.norealt.domain.User;
import ru.norealt.service.UserService;

@Component
public class LoginListener implements ApplicationListener<InteractiveAuthenticationSuccessEvent> {

    @Autowired
    private UserService userService;

    @Override
    public void onApplicationEvent(InteractiveAuthenticationSuccessEvent event)
    {
        User user = (User) event.getAuthentication().getPrincipal();
        userService.addLastVisit(user);
    }

}
