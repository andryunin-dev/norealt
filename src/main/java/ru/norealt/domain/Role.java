package ru.norealt.domain;

import org.springframework.security.core.GrantedAuthority;

public enum Role implements GrantedAuthority {
    USER, ADMIN, TT;

    @Override
    public String getAuthority() {
        return name();
    }
}
