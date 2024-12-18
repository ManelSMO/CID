package br.edu.unoesc.CID.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "endereco_pessoa")
public class EnderecoPessoa {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idendpes", nullable = false)
    protected long idEnderecoPessoa;

    @Column(name = "logrpes",nullable = false)
    protected String logradouroPessoa;

    @Column(name = "numednpes", nullable = false)
    protected String numEnderecoPessoa;

    @Column(name = "comendpes", nullable = false)
    protected String complementoPessoa;

    @ManyToOne
    @JoinColumn(name = "bairroidbai", nullable = false)
    protected Bairro bairro;

    @ManyToOne
    @JoinColumn(name = "cidadeidcid", nullable = false)
    protected Cidade cidade;

    @ManyToOne
    @JoinColumn(name = "pessoaidpes", nullable = false)
    private Pessoa pessoa;
}
