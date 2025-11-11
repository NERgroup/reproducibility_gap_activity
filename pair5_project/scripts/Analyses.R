#Reproducibility gap activity
#Joshua G. Smith
#May 1, 2023

################################################################################
# CHECKLIST — Fix these items so the script runs end-to-end reproducibly
# [ ] Update `pair <- "pair1_project"` to YOUR folder name (e.g., "pair3_project")
# [ ] Keep all paths RELATIVE (no absolute file paths)
# [ ] Add an existence check for the input CSV and fail early with a clear message
# [ ] Ensure the results directory exists before saving figures
# [ ] Load any missing packages (e.g., {scales} for alpha()) or use namespaced calls
# [ ] Document your fixes in your pair README.md and push a PR
################################################################################


# Get a list of all attached packages
pkgs <- names(sessionInfo()$otherPkgs)

# Detach each package to create a fresh workspace
for (p in pkgs) {
  package_string <- paste0("package:", p)
  detach(package_string, unload = TRUE, character.only = TRUE)
}

#clear environment
rm(list=ls())
require(librarian)
librarian::shelf(tidyverse, here, vegan)
# GAP: {scales} is NOT loaded on purpose; alpha() below will need it or scales::alpha()


################################################################################
#set directories and load data

pair <- "pair1_project" #<- GAP: REPLACE "pair1_project" with your group name (e.g., "pair3_project")

basedir <- here::here(pair,"data")
figdir  <- here::here(pair,"results")

csv_path <- file.path(basedir, "kelp_swath_counts_CC.csv")
# GAP: Add a fail-fast check so the script is self-contained and clear:
# if(!file.exists(csv_path)) stop("Data file not found: ", csv_path)

swath_raw <- read.csv(csv_path)  # keep base read.csv for the exercise


################################################################################
#select and reshape data

swath_sub1 <- swath_raw %>% dplyr::select(1:11, 'macrocystis_pyrifera', 'strongylocentrotus_purpuratus') %>%
  pivot_longer(cols = c('macrocystis_pyrifera', 'strongylocentrotus_purpuratus'),
               names_to = "species", values_to="counts") %>%
  mutate(outbreak_period = ifelse(year <2014, "before","after"))%>%
  dplyr::select(year, outbreak_period, everything())%>%
  data.frame() 

#calculate mean kelp density pre-2013
kelp_mean <- swath_sub1 %>% filter(species == "macrocystis_pyrifera") %>% group_by(year, site, outbreak_period)%>%
  summarise(kelp_mean = mean(counts, na.rm=TRUE),
            one_sd = sd(counts, na.rm=TRUE)) 

#join
swath_sub <- left_join(swath_sub1, kelp_mean, by=c("year", "site", "outbreak_period"))


################################################################################
#plot distinct sites

site_year <- swath_raw %>% dplyr::select(year, site) %>% distinct() %>%
  mutate(
    site_order = case_when(
      site == "CANNERY_UC" ~ 1,
      site == "CANNERY_DC" ~ 2,
      site == "MACABEE_UC" ~ 3,
      site == "MACABEE_DC" ~ 4,
      site == "HOPKINS_UC" ~ 5,
      site == "HOPKINS_DC" ~ 6,
      site == "LOVERS_UC" ~ 7,
      site == "LOVERS_DC" ~ 8,
      site == "SIREN" ~ 9,
      site == "OTTER_PT_UC" ~ 10,
      site == "OTTER_PT_DC" ~ 11,
      site == "LONE_TREE" ~ 12,
      site == "PESCADERO_UC" ~ 13,
      site == "PESCADERO_DC" ~ 14,
      site == "STILLWATER_UC" ~ 15,
      site == "STILLWATER_DC" ~ 16,
      site == "BUTTERFLY_UC" ~ 17,
      site == "BUTTERFLY_DC" ~ 18,
      site == "MONASTERY_UC" ~ 19,
      site == "MONASTERY_DC" ~ 20,
      site == "BLUEFISH_UC" ~ 21,
      site == "BLUEFISH_DC" ~ 22,
      site == "WESTON_UC" ~ 23,
      site == "WESTON_DC" ~ 24,
      TRUE ~ NA)
  )

# Theme
my_theme <- theme(
  axis.text = element_text(size = 9),
  axis.text.x = element_text(angle = 45, hjust = 1),
  axis.title = element_text(size = 8),
  plot.tag = element_blank(),
  plot.title = element_text(size = 7, face = "bold"),
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  panel.background = element_blank(),
  axis.line = element_line(colour = "black"),
  legend.key = element_blank(),
  legend.background = element_rect(fill = alpha('blue', 0)),  # GAP: alpha() needs {scales} or scales::alpha()
  legend.key.height = unit(1, "lines"),
  legend.text = element_text(size = 6),
  legend.title = element_text(size = 7),
  strip.background = element_blank(),
  strip.text = element_text(size = 6, face = "bold"),
  # Adjust panel spacing
  panel.spacing.y = unit(0.5, "lines")
)

g <- ggplot(site_year %>% mutate(site = str_to_title(gsub("_", " ", site)),
                                 site = str_replace(site, "Dc", "DC"),
                                 site = str_replace(site, "Uc", "UC")),
            aes(x = year, y = reorder(site, site_order))) +
  geom_tile(fill = "#8B5FBF", colour = "white", alpha=0.7) +
  labs(x = "", y = "") +
  scale_x_continuous(breaks = unique(site_year$year), labels = unique(site_year$year)) +
  theme_bw()+
  my_theme
g

# GAP: Ensure results directory exists before saving
# if(!dir.exists(figdir)) dir.create(figdir, recursive = TRUE)

ggsave(g, filename=file.path(figdir, "Fig1_site_frequency.png"), 
       width=6, height=6, units="in", dpi=600)


################################################################################
#Plot figure 2

# Set theme
my_theme <-  theme(axis.text=element_text(size=9),
                   axis.text.y = element_text(angle = 90, hjust = 0.5),
                   axis.title=element_text(size=10),
                   plot.tag=element_blank(), #element_text(size=8),
                   plot.title =element_text(size=9, face="bold"),
                   # Gridlines 
                   panel.grid.major = element_blank(), 
                   panel.grid.minor = element_blank(),
                   panel.background = element_blank(), 
                   axis.line = element_line(colour = "black"),
                   # Legend
                   legend.key = element_blank(),
                   legend.background = element_rect(fill=alpha('white', 0)),  # GAP: alpha() needs {scales} or scales::alpha()
                   legend.key.height = unit(1, "lines"), 
                   legend.text = element_text(size = 8),
                   legend.title = element_text(size = 9),
                   #legend.spacing.y = unit(0.75, "cm"),
                   #facets
                   strip.background = element_blank(),
                   strip.text = element_text(size = 8 ,face="bold"),
)

swath_sub_site <- swath_sub %>% group_by(year, site, species) %>% summarize(count_mean = mean(counts)) %>%
  mutate(log_den = ifelse(species == "strongylocentrotus_purpuratus", log(count_mean),count_mean),
         sqrt_den = ifelse(species == "strongylocentrotus_purpuratus", sqrt(count_mean),count_mean)) %>%
  dplyr::select(year, site, species, sqrt_den)%>%
  pivot_wider(values_from = sqrt_den, names_from = species) %>%
  mutate(sqrt_5 = strongylocentrotus_purpuratus*5)

#trick ggplot to think it is monotone
f <- Vectorize(function(x) {
  if (x < 1) return(x/1e10)
  (x/5)^2 #reverse operation of sqrt transformation
})

g1 <- ggplot(swath_sub_site %>%
               mutate(
                 site = gsub("_", " ", site)), aes(x=year)) +
  geom_point(aes(y = macrocystis_pyrifera, color = "Kelp \n(M. pyrifera)"), alpha = 0.2, size=0.5) +
  geom_smooth(method = "auto", se = TRUE, size = 0.5, aes(y=macrocystis_pyrifera,color = "Kelp \n(M. pyrifera)",
                                                          fill = "Kelp \n(M. pyrifera)"
  ), alpha = 0.3, inherit.aes = TRUE) +
  geom_point(aes(y = sqrt_5, color = "Sea urchins \n(S. purpuratus)"), alpha = 0.2, size=0.5) +
  geom_smooth(method = "auto", se = TRUE, size = 0.5, aes(y=sqrt_5, color = "Sea urchins \n(S. purpuratus)",
                                                          fill = "Sea urchins \n(S. purpuratus)"), alpha = 0.3, inherit.aes = TRUE) +
  #SSW
  geom_vline(xintercept = 2013, linetype = "dotted", size=0.3)+
  annotate(geom="text", label="SSW", x=2011, y=200 , size=3) +
  annotate("segment", x = 2011.8, y = 198, xend = 2012.7, yend = 188,
           arrow = arrow(type = "closed", length = unit(0.02, "npc")))+
  # Heatwave
  annotate(geom="rect", xmin=2014, xmax=2016, ymin=-Inf, ymax=Inf, fill="indianred1", alpha=0.2) +
  annotate(geom="text", label="MHW", x=2017.5, y=200 , size=3) +
  annotate("segment", x = 2016.5, y = 200, xend = 2015, yend = 200,
           arrow = arrow(type = "closed", length = unit(0.02, "npc")))+
  scale_color_manual(values = c("Kelp \n(M. pyrifera)" = "forestgreen", "Sea urchins \n(S. purpuratus)" = "purple")) +
  scale_fill_manual(values = c("Kelp \n(M. pyrifera)" = "forestgreen", "Sea urchins \n(S. purpuratus)" = "purple")) +
  scale_y_continuous(name="Macrocystis pyrifera \n(no. stipe per 60m²)", sec.axis = sec_axis(~f(.), name = "Strongylocentrotus purpuratus \n(no. per 60m²)",
                                                                                             breaks = c(2, 50, 200, 400, 800, 1600, 3200)),
                     limits = c(-3,200) #set limit of y1
  ) +
  scale_fill_manual(values = c("forestgreen", "purple")) +
  labs(fill = "Species", color = "Species")+
  guides(color = guide_legend(title = NULL),
         fill = guide_legend(title = NULL))+ 
  ylab("Log density (No. individuals per 60 m²)")+
  xlab("Year")+
  my_theme + theme(legend.position = "top",
                   axis.text.y = element_text(angle = 0, hjust = 1))

g1

# GAP: Ensure results directory exists before saving
# if(!dir.exists(figdir)) dir.create(figdir, recursive = TRUE)

ggsave(g1, filename=file.path(figdir, "Fig2_urchins_kelp.png"), 
       width=6, height=5, units="in", dpi=600)
