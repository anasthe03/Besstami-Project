package ma.bankati.web.controllers.mainController;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jdk.jshell.Snippet;
import ma.bankati.dao.compteDao.CompteDao;
import ma.bankati.dao.compteDao.ICompteDao;
import ma.bankati.dao.creditDao.CreditDao;
import ma.bankati.dao.creditDao.ICreditDao;
import ma.bankati.dao.userDao.IUserDao;
import ma.bankati.dao.userDao.UserDao;
import ma.bankati.model.compte.Compte;
import ma.bankati.model.credit.Credit;
import ma.bankati.model.users.ERole;
import ma.bankati.model.users.User;
import java.io.IOException;
import java.util.List;


public class HomeController {

    private ICompteDao<Compte,Long> compteDao  ;
    private IUserDao userDao ;
    private ICreditDao creditDao ;

    public HomeController()  {
        this.compteDao = new CompteDao();
        this.userDao   = new UserDao();
        this.creditDao = new CreditDao();
    }

    public void show(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("connectedUser");
        Compte compte = (Compte) compteDao.findByClientId(user.getId());

        if (user.getRole() == ERole.USER && compte != null) {

              var  result = compte.getSolde();
              request.setAttribute("result", result);

        }

        if (user.getRole() == ERole.ADMIN) {

        this.showCredit(request, response);

        }
        // 🔁 Récupérer le chemin de la vue injecté par le filtre
        String viewPath = (String) request.getAttribute("viewPath");

        if (viewPath == null) {
            // Cas de sécurité si quelqu’un arrive ici sans rôle (non connecté ?)
            response.sendRedirect("login");
            return;
        }

        request.getRequestDispatcher(viewPath).forward(request, response);

    }


    public void deposer(HttpServletRequest request, HttpServletResponse response) throws IOException {

        Compte compte = (Compte) compteDao.findByClientId(Long.parseLong(request.getParameter("id")));
        compteDao.deposer(compte,Double.parseDouble(request.getParameter("montant")));
        response.sendRedirect(request.getContextPath() + "/home");
    }

    public void retirer(HttpServletRequest request, HttpServletResponse response) throws IOException {

        Double montantAretiter = Double.parseDouble(request.getParameter("montant"));
        Compte compte = (Compte) compteDao.findByClientId(Long.parseLong(request.getParameter("id")));

        if(montantAretiter <= compte.getSolde())
            compteDao.retirer(compte,montantAretiter);

        response.sendRedirect(request.getContextPath() + "/home");
    }


    public void showCredit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<Credit> creditsEnAttente = creditDao.creditsEnAttente();
        List<Credit> creditsApprouve = creditDao.creditsApprouve();
        List<Credit> creditsRefeuse = creditDao.creditsRefuse();
        List<User> users = userDao.findAll();

        int creditsRefuse = creditsRefeuse.size();
        request.setAttribute("creditsRefuse", creditsRefuse);
        int creditsApprouveCount = creditsApprouve.size();
        request.setAttribute("creditsApprouve", creditsApprouveCount);
        int usersCount = users.size();
        request.setAttribute("usersCount", usersCount);
        int creditsCount = creditsEnAttente.size();
        request.setAttribute("creditsCount", creditsCount);

    }

}
