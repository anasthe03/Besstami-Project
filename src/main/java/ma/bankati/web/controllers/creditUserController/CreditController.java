package ma.bankati.web.controllers.creditUserController;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ma.bankati.dao.creditDao.CreditDao;
import ma.bankati.dao.creditDao.ICreditDao;
import ma.bankati.dao.userDao.IUserDao;
import ma.bankati.dao.userDao.UserDao;
import ma.bankati.model.credit.Credit;
import ma.bankati.model.credit.Etat;
import ma.bankati.model.users.User;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class CreditController {

    private final ICreditDao<Credit,Long> creditDao;

    public CreditController() {
        this.creditDao = new CreditDao();

    }

    public void showAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("connectedUser");
        List<Credit> credits = creditDao.findByClientId(user.getId());
        req.setAttribute("credits", credits);
        req.getRequestDispatcher("/public/demandes.jsp").forward(req, resp);

    }


    public void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {

            Long id = Long.parseLong(req.getParameter("id"));
            creditDao.deleteById(id);
            resp.sendRedirect(req.getContextPath() + "/demandes");
    }



    public void save(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        User user = (User) req.getSession().getAttribute("connectedUser");
        String idStr = req.getParameter("id");
        Long id = (idStr == null || idStr.isEmpty()) ? null : Long.parseLong(idStr);

        Credit credit = Credit.builder()
                .id(id)
                .clientId(user.getId())
                .montant(Long.parseLong(req.getParameter("montant")))
                .motif(req.getParameter("motif"))
                .build();


        creditDao.save(credit);
        resp.sendRedirect(req.getContextPath() + "/demandes");
    }
}
