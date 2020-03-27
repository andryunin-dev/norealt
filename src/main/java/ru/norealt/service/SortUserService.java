package ru.norealt.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import ru.norealt.domain.User;
import ru.norealt.repo.UserPageAndSortRepo;

import java.util.ArrayList;
import java.util.List;

@Service
public class SortUserService {

    @Autowired
    UserPageAndSortRepo repository;

    public List<User> getAllUsers(Integer page, Integer size, String group, String sort)
    {
        if (sort.equals("desc")) {
            Pageable pageable = PageRequest.of(page, size, Sort.by(group).descending());

            Page<User> pagedResult = repository.findAll(pageable);

            if(pagedResult.hasContent()) {
                return pagedResult.getContent();
            } else {
                return new ArrayList<User>();
            }
        } else {
            Pageable pageable = PageRequest.of(page, size, Sort.by(group).ascending());

            Page<User> pagedResult = repository.findAll(pageable);

            if(pagedResult.hasContent()) {
                return pagedResult.getContent();
            } else {
                return new ArrayList<User>();
            }
        }

    }

    public int getTotalPages(Integer page, Integer size)
    {

        Pageable pageable = PageRequest.of(page, size);

        Page<User> pagedResult = repository.findAll(pageable);

        return pagedResult.getTotalPages();

    }

}
