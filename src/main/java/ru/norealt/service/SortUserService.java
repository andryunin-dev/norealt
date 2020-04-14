package ru.norealt.service;

import com.querydsl.core.types.Predicate;
import com.querydsl.core.types.dsl.BooleanExpression;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import ru.norealt.domain.QUser;
import ru.norealt.domain.User;
import ru.norealt.repo.UserPageAndSortRepo;

import java.util.ArrayList;
import java.util.List;

@Service
public class SortUserService {

    @Autowired
    UserPageAndSortRepo repository;

//    public List<User> getAllMessages(Predicate predicate, Integer page, Integer size, String group, String sort)
//    {
//        if (sort.equals("desc")) {
//            Pageable pageable = PageRequest.of(page, size, Sort.by(group).descending());
//
//            Page<User> pagedResult = repository.findAll(predicate, pageable);
//
//            if(pagedResult.hasContent()) {
//                return pagedResult.getContent();
//            } else {
//                return new ArrayList<User>();
//            }
//        } else {
//            Pageable pageable = PageRequest.of(page, size, Sort.by(group).ascending());
//
//            Page<User> pagedResult = repository.findAll(predicate, pageable);
//
//            if(pagedResult.hasContent()) {
//                return pagedResult.getContent();
//            } else {
//                return new ArrayList<User>();
//            }
//        }
//
//    }

    public List<User> getAllUsers(Long min, Long max, Predicate predicate, Integer page, Integer size, String group, String sort)
    {
        if (sort.equals("desc")) {
            Pageable pageable = PageRequest.of(page, size, Sort.by(group).descending());

            BooleanExpression booleanExpression = QUser.user.id.between(min, max);

            Page<User> pagedResult = repository.findAll(booleanExpression, pageable);

            if(pagedResult.hasContent()) {
                return pagedResult.getContent();
            } else {
                return new ArrayList<User>();
            }
        } else {
            Pageable pageable = PageRequest.of(page, size, Sort.by(group).ascending());

            BooleanExpression booleanExpression = QUser.user.id.between(min, max);

            Page<User> pagedResult = repository.findAll(booleanExpression, pageable);

            if(pagedResult.hasContent()) {
                return pagedResult.getContent();
            } else {
                return new ArrayList<User>();
            }
        }

    }

    public long getTotalPages(Long min, Long max, Integer page, Integer size, String group)
    {
        Pageable pageable = PageRequest.of(page, size, Sort.by(group));

        BooleanExpression booleanExpression = QUser.user.id.between(min, max);

        Page<User> pagedResult = repository.findAll(booleanExpression, pageable);

        return pagedResult.getTotalPages();

    }


    public long getTotalElements(Long min, Long max, Integer page, Integer size, String group)
    {

        Pageable pageable = PageRequest.of(page, size, Sort.by(group));

        BooleanExpression booleanExpression = QUser.user.id.between(min, max);

        Page<User> pagedResult = repository.findAll(booleanExpression, pageable);

        return pagedResult.getTotalElements();

    }

}
