package ma.bankati.web.controllers.creditController;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.bankati.dao.compteDao.CompteDao;
import ma.bankati.dao.compteDao.ICompteDao;
import ma.bankati.dao.creditDao.CreditDao;
import ma.bankati.dao.creditDao.ICreditDao;
import ma.bankati.model.compte.Compte;
import ma.bankati.model.credit.Credit;
import ma.bankati.model.credit.Devise;
import ma.bankati.model.credit.Etat;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class CreditController {

    private final ICreditDao<Credit,Long> creditDao;
    private final ICompteDao<Compte,Long> compteDao;

    public CreditController() {
        this.creditDao = new CreditDao();
        this.compteDao = new CompteDao();
    }

    public void showAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Credit> credits = creditDao.findAll();
        req.setAttribute("credits", credits);
        req.getRequestDispatcher("/admin/credits.jsp").forward(req, resp);

    }

    public void approuverDemande(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Credit credit =  creditDao.findById(Long.parseLong(req.getParameter("id")));
        credit.setStatut(Etat.APPROUVE);
        credit.setDateTraitement(LocalDate.now());
        Compte c = compteDao.findByClientId(credit.getClientId());
        compteDao.deposer(c,credit.getMontant());
        creditDao.ApprouverOuRefuserDemande(credit);
        resp.sendRedirect(req.getContextPath() + "/credits");
    }

    public void refuserDemande(HttpServletRequest req, HttpServletResponse resp) throws IOException {
      Credit credit =  creditDao.findById(Long.parseLong(req.getParameter("id")));
      credit.setStatut(Etat.REFUSE);
      credit.setDateTraitement(LocalDate.now());

        creditDao.ApprouverOuRefuserDemande(credit);
        resp.sendRedirect(req.getContextPath() + "/credits");
    }
    public void saveOrUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        String idClt = (req.getParameter("idClient"));
        Long id = (idStr == null || idStr.isEmpty()) ? null : Long.parseLong(idStr);

        Credit credit = Credit.builder()
                .id(id)
                .clientId(Long.parseLong(idClt))
                .montant(Long.parseLong(req.getParameter("montant")))
                .motif(req.getParameter("motif"))
                .dateDemande(LocalDate.parse(req.getParameter("dateDemande"), DateTimeFormatter.ofPattern("dd/MM/yy")))
                .statut(Etat.valueOf(req.getParameter("statut")))
                .dateTraitement(LocalDate.parse(req.getParameter("dateTraitement"),DateTimeFormatter.ofPattern("dd/MM/yy")))
                .build();


            creditDao.save(credit);


        resp.sendRedirect(req.getContextPath() + "/credits");
    }


}
