package ru.norealt;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.test.context.support.WithUserDetails;
import org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultMatcher;
import org.springframework.test.web.servlet.request.MockMultipartHttpServletRequestBuilder;
import ru.norealt.controller.CrudMessageController;

import java.io.SequenceInputStream;

import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.*;
import static org.springframework.security.test.web.servlet.response.SecurityMockMvcResultMatchers.authenticated;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.multipart;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc
@WithUserDetails("admin@admin.com")
public class CrudMessageControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private CrudMessageController crudMessageController;

    @Test
    public void messageAddTest() throws Exception {
        this.mockMvc.perform(get("/messageAdd"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(xpath("//*[@id=\"navbarSupportedContent-555\"]/ul[2]/li[2]/a").string("Новое объявление"));
    }

    @Test
    public void messageListTest() throws Exception {
        this.mockMvc.perform(get("/main"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(xpath("//*[@id=\"message-list\"]/div").nodeCount(24));
    }

    @Test
    public void filterMessageListTest() throws Exception {
        this.mockMvc.perform(get("/main")
                .param("size", "24")
                .param("page", "0")
                .param("group", "price")
                .param("sort", "desc")
                .param("min", "4743822")
                .param("max", "5341510")
                .param("city", "Балаково")
                .param("countRooms", "2"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(xpath("//*[@id=\"message-list\"]/div").nodeCount(2))
                .andExpect(xpath("//*[@id=\"message-list\"]/div/div[@data-id=1051396]").exists())
                .andExpect(xpath("//*[@id=\"message-list\"]/div/div[@data-id=1051067]").exists());

    }

    @Test
    public void addMessageToListTest() throws Exception {
        MockMultipartHttpServletRequestBuilder multipart = (MockMultipartHttpServletRequestBuilder) multipart("/messageAdd")
                .file("file", "123".getBytes())
                .param("city", "Саратов")
                .param("street", "test")
                .param("house", "11")
                .param("object_type", "Квартира")
                .param("count_rooms", "1")
                .param("square", "110")
                .param("floor", "1")
                .param("num_storeys", "10")
                .param("text", "texttexttext")
                .param("price", "7654321")
                .with(csrf());

        this.mockMvc.perform(multipart)
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(redirectedUrl("/main"));


        this.mockMvc.perform(get("/main"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(xpath("//*[@id=\"message-list\"]/div").nodeCount(24))
                .andExpect(xpath("//*[@id=\"message-list\"]/div[1]/div/div[2]/p[4]").string("№: 5000013 | 2020-10-19"));
    }
}
