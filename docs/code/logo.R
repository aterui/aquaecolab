
pacman::p_load(tidyverse,
               igraph,
               mcbrnet,
               ggraph,
               tidygraph,
               extrafont)

set.seed(1)
list_brnet <- brnet(n_patch = 100,
                    p_branch = 0.4,
                    randomize_patch = FALSE)

m <- list_brnet$adjacency_matrix
m[lower.tri(m)] <- 0
adj <- graph.adjacency(m)

V(adj)$area <- list_brnet$df_patch %>% pull(n_patch_upstream)
V(adj)$env <- list_brnet$df_patch %>% pull(environment)
E(adj)$area <- list_brnet$df_patch %>% slice(get.edgelist(adj)[,2]) %>%  pull(n_patch_upstream)
E(adj)$env <- list_brnet$df_patch %>% slice(get.edgelist(adj)[,2]) %>%  pull(environment)

graph <- as_tbl_graph(adj)

logo <- ggraph(graph, layout = "tree") +  
  geom_edge_diagonal(width = 0.8,
                     color = grey(0.90),
                     lineend = "round") +
  # geom_node_point(aes(size = area,
  #                     color = env),
  #                 alpha = 0.8) +
  annotate(geom = "text",
           label = "AquatiQuE",
           x = -4,
           y = 13,
           size = 20,
           family = "mono",
           fontface = "bold",
           color = "steelblue") +
  theme_void() +
  theme(panel.background = element_rect(alpha("steelblue", 0.7),
                                        color = NA)) +
  MetBrewer::scale_color_met_c("Hiroshige") +
  guides(size = "none",
         fill = "none",
         color = "none",
         edge_color = "none",
         edge_width = "none")

logo

ggsave(plot = logo,
       device = png,
       filename = here::here("image/logo.png"), width = 8, height = 1)
