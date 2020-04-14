package ru.norealt.service;

import com.querydsl.core.types.Predicate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import ru.norealt.domain.Message;
import ru.norealt.repo.MessagePageAndSortRepo;

import java.util.ArrayList;
import java.util.List;

@Service
public class SortMessageService {

    @Autowired
    MessagePageAndSortRepo repository;

    public List<Message> getAllMessagesImproved(Integer page, Integer size, String group, String sort, Predicate predicate)
    {

        if (sort.equals("desc")) {
            Pageable pageable = PageRequest.of(page, size, Sort.by(group).descending());

            Page<Message> pagedResult = repository.findAll(predicate, pageable);

            if(pagedResult.hasContent()) {
                return pagedResult.getContent();
            } else {
                return new ArrayList<>();
            }
        } else {
            Pageable pageable = PageRequest.of(page, size, Sort.by(group).ascending());

            Page<Message> pagedResult = repository.findAll(predicate, pageable);

            if(pagedResult.hasContent()) {
                return pagedResult.getContent();
            } else {
                return new ArrayList<>();
            }
        }

    }


    public long getTotalPagesImproved(Integer page, Integer size, String group, Predicate predicate)
    {
        Pageable pageable = PageRequest.of(page, size, Sort.by(group));

        Page<Message> pagedResult = repository.findAll(predicate, pageable);

        return pagedResult.getTotalPages();

    }

    public long getTotalElementsImproved(Integer page, Integer size, String group, Predicate predicate)
    {

        Pageable pageable = PageRequest.of(page, size, Sort.by(group));

        Page<Message> pagedResult = repository.findAll(predicate, pageable);

        return pagedResult.getTotalElements();

    }

}
