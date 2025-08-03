package ma.bankati.model.compte;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import ma.bankati.model.users.User;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Compte {
    private Long id; // Identifiant unique du compte
    private User proprietaire; // Référence à l'utilisateur propriétaire
    private Long clientId; // ID de l'utilisateur (utile pour la base de données)
    private double solde; // Solde actuel du compte

    public Compte(Long id, Long clientId, double solde) {
        this.id = id;
        this.clientId = clientId;
        this.solde = solde;

    }


    @Override
    public String toString() {
        return "Compte #" + id + " - Solde: " + solde;
    }
}
