package ma.bankati.web.controllers.creditUserController;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/demandes/*" , loadOnStartup = 6)
public class CreditServlet  extends HttpServlet {

        private CreditController creditController;

        @Override
        public void init() throws ServletException {
            System.out.println("CreditUserController créé et initialisé");
            creditController = new CreditController();

        }

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String path = req.getPathInfo();
            if (path == null || "/".equals(path)) {
                creditController.showAll(req, resp);
            }  else if (path.equals("/delete")) {
                creditController.delete(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String path = req.getPathInfo();
            if (path.equals("/save")) {
                creditController.save(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        }

        @Override
        public void destroy() {
            System.out.println("CreditUserController détruit");
        }
    }


