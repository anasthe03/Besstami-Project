package ma.bankati.web.controllers.mainController;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.bankati.dao.compteDao.ICompteDao;
import ma.bankati.model.compte.Compte;
import ma.bankati.model.credit.Credit;
import ma.bankati.model.users.User;

import java.io.IOException;

@WebServlet(urlPatterns = "/home/*", loadOnStartup = 1)
public class HomeServlet extends HttpServlet
{

    private HomeController homeController;

    @Override
    public void init() throws ServletException {
        System.out.println("HomeServlet créé et initialisé");
        homeController = new HomeController();
    }



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String path = request.getPathInfo();

        if (path == null || "/".equals(path)) {
            homeController.show(request, response);
        }
        else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);

        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String path = req.getPathInfo();
        if (path.equals("/deposer")) {
            homeController.deposer(req, resp);
        }  else if (path.equals("/retirer")) {
            homeController.retirer(req, resp);
        }
        else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }


    @Override
    public void destroy() {
        System.out.println("HomeController détruit");
    }
}
