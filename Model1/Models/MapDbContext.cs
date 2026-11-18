using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace Model1.Models;

public partial class MapDbContext : DbContext
{
    public MapDbContext(DbContextOptions<MapDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Congestion> Congestions { get; set; }

    public virtual DbSet<Restaurant> Restaurants { get; set; }

    public virtual DbSet<Review> Reviews { get; set; }

    public virtual DbSet<ScenicSpot> ScenicSpots { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Congestion>(entity =>
        {
            entity.HasKey(e => e.CongestionId).HasName("PK__Congesti__00400BFCF3232143");

            entity.Property(e => e.CongestionLevel).HasMaxLength(20);
            entity.Property(e => e.DelayTime).HasMaxLength(30);
            entity.Property(e => e.EndAddress).HasMaxLength(200);
            entity.Property(e => e.EndLatitude).HasColumnType("decimal(9, 4)");
            entity.Property(e => e.EndLongitude).HasColumnType("decimal(9, 4)");
            entity.Property(e => e.RoadName).HasMaxLength(100);
            entity.Property(e => e.StartAddress).HasMaxLength(200);
            entity.Property(e => e.StartLatitude).HasColumnType("decimal(9, 4)");
            entity.Property(e => e.StartLongitude).HasColumnType("decimal(9, 4)");
        });

        modelBuilder.Entity<Restaurant>(entity =>
        {
            entity.HasKey(e => e.RestaurantId).HasName("PK__Restaura__87454C951B1B5615");

            entity.Property(e => e.Address).HasMaxLength(200);
            entity.Property(e => e.BusinessHours).HasMaxLength(30);
            entity.Property(e => e.Description).HasMaxLength(500);
            entity.Property(e => e.Distance).HasColumnType("decimal(6, 1)");
            entity.Property(e => e.ImageUrl).HasMaxLength(200);
            entity.Property(e => e.Phone).HasMaxLength(30);
            entity.Property(e => e.PriceRange).HasMaxLength(30);
            entity.Property(e => e.Rating).HasColumnType("decimal(2, 1)");
            entity.Property(e => e.RestaurantName).HasMaxLength(100);
            entity.Property(e => e.RestaurantType).HasMaxLength(50);
        });

        modelBuilder.Entity<Review>(entity =>
        {
            entity.HasKey(e => e.ReviewId).HasName("PK__Reviews__74BC79CE1EDF6DCD");

            entity.Property(e => e.BusinessType).HasMaxLength(20);
            entity.Property(e => e.ImageUrls).HasMaxLength(1000);
            entity.Property(e => e.ReviewContent).HasMaxLength(1000);
            entity.Property(e => e.ReviewTime)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");

            entity.HasOne(d => d.User).WithMany(p => p.Reviews)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Reviews__UserId__52593CB8");
        });

        modelBuilder.Entity<ScenicSpot>(entity =>
        {
            entity.HasKey(e => e.SpotId).HasName("PK__ScenicSp__61645F8754C48F4C");

            entity.Property(e => e.Address).HasMaxLength(200);
            entity.Property(e => e.Description).HasMaxLength(500);
            entity.Property(e => e.Distance).HasColumnType("decimal(6, 1)");
            entity.Property(e => e.ImageUrl).HasMaxLength(200);
            entity.Property(e => e.Latitude).HasColumnType("decimal(9, 4)");
            entity.Property(e => e.Longitude).HasColumnType("decimal(9, 4)");
            entity.Property(e => e.OpeningHours).HasMaxLength(30);
            entity.Property(e => e.Phone).HasMaxLength(30);
            entity.Property(e => e.Rating).HasColumnType("decimal(2, 1)");
            entity.Property(e => e.SpotName).HasMaxLength(100);
            entity.Property(e => e.TicketPrice).HasMaxLength(30);
            entity.Property(e => e.TouristPeriod).HasMaxLength(30);
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__Users__1788CC4C3B5DA582");

            entity.HasIndex(e => e.Username, "UQ__Users__536C85E40CC7A8EE").IsUnique();

            entity.Property(e => e.Avatar).HasMaxLength(200);
            entity.Property(e => e.CreateTime)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Email).HasMaxLength(100);
            entity.Property(e => e.NickName).HasMaxLength(50);
            entity.Property(e => e.Password).HasMaxLength(100);
            entity.Property(e => e.Phone).HasMaxLength(30);
            entity.Property(e => e.Username).HasMaxLength(50);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
