package ma.bankati.model.credit;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import ma.bankati.model.users.User;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Credit {
   // private static final DateTimeFormatter DATE_FORMATTER =  DateTimeFormatter.ofPattern("dd/MM/yy");
    private Long id; // Identifiant unique de la demande
    private User client;
    private Long clientId;// Référence au client demandeur
    private double montant; // Montant demandé
    private LocalDate dateDemande = LocalDate.now(); // Seulement la date (YYYY-MM-DD)
    private Etat statut; // Statut: "EN_ATTENTE", "APPROUVE", "REFUSE"
    private String motif; // Motif optionnel pour la demande
    private LocalDate dateTraitement; // Date de traitement par l'admin
   // private String commentaireAdmin; // Commentaire éventuel de l'admin


    public Credit( Long id , Long clientId , double montant ,  String motif, LocalDate dateDemande, Etat statut, LocalDate dateTraitement ){
       this.id = id;
        this.clientId = clientId;
        this.montant = montant;
        this.dateDemande = dateDemande;
        this.motif = motif;
        this.statut = statut;
        this.dateTraitement = dateTraitement;
    }


    @Override
    public String toString() {
        return "Demande de crédit #" + id + " - Montant: " + montant + " " +  " - Statut: " + statut;
    }
}