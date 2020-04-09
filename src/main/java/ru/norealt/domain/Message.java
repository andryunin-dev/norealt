package ru.norealt.domain;

import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;

@Entity
public class Message {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Length(max = 2048, message = "Message too long (more than 2kB)")
    private String text;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User author;

    private String filename;

    private String city;

    private String street;

    private String house;

    private String object_type;

    private String count_rooms;

    private String square;

    private String floor;

    private String num_storeys;

    private String price;

    private String post_date;

    public Message() {
    }

    public Message(User user, String text,
                   String city, String street, String house,
                   String object_type, String count_rooms,
                   String square, String floor, String num_storeys, String price
    ) {
        this.author = user;
        this.text = text;
        this.city = city;
        this.street = street;
        this.house = house;
        this.object_type = object_type;
        this.count_rooms = count_rooms;
        this.square = square;
        this.floor = floor;
        this.num_storeys = num_storeys;
        this.price = price;
    }

    //дополнительный метод для проверки есть автор или нет
    public String getAuthorName() {
        // если автор не равен null тогда(?) author.getUsername() иначе(:) вернуть строчку "<none>"
        return author != null ? author.getUsername() : "none";
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getHouse() {
        return house;
    }

    public void setHouse(String house) {
        this.house = house;
    }

    public String getObject_type() {
        return object_type;
    }

    public void setObject_type(String object_type) {
        this.object_type = object_type;
    }

    public String getCount_rooms() {
        return count_rooms;
    }

    public void setCount_rooms(String count_rooms) {
        this.count_rooms = count_rooms;
    }

    public String getSquare() {
        return square;
    }

    public void setSquare(String square) {
        this.square = square;
    }

    public String getFloor() {
        return floor;
    }

    public void setFloor(String floor) {
        this.floor = floor;
    }

    public String getNum_storeys() {
        return num_storeys;
    }

    public void setNum_storeys(String num_storeys) {
        this.num_storeys = num_storeys;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getPost_date() {
        return post_date;
    }

    public void setPost_date(String post_date) {
        this.post_date = post_date;
    }
}
