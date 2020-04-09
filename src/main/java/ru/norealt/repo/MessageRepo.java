package ru.norealt.repo;

import org.springframework.data.repository.CrudRepository;
import ru.norealt.domain.Message;

import java.util.List;

public interface MessageRepo extends CrudRepository<Message, Long> {

    //метод для поиска в БД по тегу
//    List<Message> findByTag(String tag);

    //метод для поиска в БД по тексту
    //имя метода составляется из документации Spring JPA
    List<Message> findByTextContainingIgnoreCase(String text);

    Iterable<Message> findAllById(Long id);
}

