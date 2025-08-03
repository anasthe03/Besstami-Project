package ma.bankati.config;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.util.Enumeration;
import java.util.Properties;
import ma.bankati.dao.compteDao.ICompteDao;
import ma.bankati.dao.creditDao.ICreditDao;
import ma.bankati.dao.userDao.IUserDao;
import ma.bankati.service.authentification.IAuthentificationService;


@WebListener
public class WebContext implements ServletContextListener {


    static void loadApplicationContext(ServletContext application){
        var configFile = Thread.currentThread().getContextClassLoader().getResourceAsStream("configFiles/beans.properties");

        if (configFile != null) {
            Properties properties = new Properties();
            try {
                properties.load(configFile);
                String userDaoClassName = properties.getProperty("userDao");
                String authServClassName = properties.getProperty("authService");
                String creditDaoClassName = properties.getProperty("creditDao");
                String compteDaoClassName = properties.getProperty("compteDao");

                Class<?> cUserDao = Class.forName(userDaoClassName);
                IUserDao userDao = (IUserDao) cUserDao.getDeclaredConstructor().newInstance();

                Class<?> cAuthService = Class.forName(authServClassName);
                IAuthentificationService authService = (IAuthentificationService) cAuthService.getDeclaredConstructor(IUserDao.class).newInstance(userDao);

                Class<?> cCreditDao = Class.forName(creditDaoClassName);
                ICreditDao creditDao = (ICreditDao) cCreditDao.getDeclaredConstructor().newInstance();

                Class<?> cCompteDao = Class.forName(compteDaoClassName);
                ICompteDao compteDao = (ICompteDao) cCompteDao.getDeclaredConstructor().newInstance();


                // Enregistrement des beans aussi avec des noms explicites
               application.setAttribute("userDao", userDao);
               application.setAttribute("authService", authService);
               application.setAttribute("creditDao", creditDao);
               application.setAttribute("compteDao", compteDao);



            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            System.err.println("Erreur : Le fichier beans.properties est introuvable !");
        }
    }



    @Override
    public void contextInitialized(ServletContextEvent ev) {

        var application = ev.getServletContext();
        application.setAttribute("AppName", "Besstami");
        loadApplicationContext(application);

        System.out.println("Application Started and context initialized");
    }

    @Override
    public void contextDestroyed(ServletContextEvent ev) {

        var application = ev.getServletContext();

        Enumeration<String> attributeNames = application.getAttributeNames();

        while (attributeNames.hasMoreElements()) {
            String name = attributeNames.nextElement();
            application.removeAttribute(name);
        }

        System.out.println("Application Stopped");
    }
}
