package com.gradago.identity.domain;

import jakarta.persistence.*;
import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "users") // Mapea esta entidad a la tabla users
public class User {

  @Id
  // Usamos UUID definido por app (no autogenerado por DB) para ids no predecibles
  private UUID id;

  @Column(nullable = false, unique = true, length = 254)
  private String email;

  // Guardamos el hash, no el password
  @Column(name = "password_hash", nullable = false, length = 100)
  private String passwordHash;

  @Column(name = "created_at", nullable = false)
  private Instant createdAt;

  // Constructor vacío requerido por JPA
  protected User() {}

  // Constructor de dominio: crea un usuario válido
  public User(String email, String passwordHash) {
    this.id = UUID.randomUUID();
    this.email = email;
    this.passwordHash = passwordHash;
    this.createdAt = Instant.now();
  }

  public UUID getId() { return id; }
  public String getEmail() { return email; }
  public String getPasswordHash() { return passwordHash; }
  public Instant getCreatedAt() { return createdAt; }
}
