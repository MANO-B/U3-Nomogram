library(ggplot2)
library(dplyr)

# パラメータ範囲
T_values <- seq(0.05, 1, length.out = 500)  # T=0 は分母ゼロ回避
C_values <- 1:4
M_values <- 1:3

# TAR関数
compute_TAR <- function(T, C, M) {
  numerator <- 2*T*M -(1-T)*(T*(C-2) + 2)
  denominator <- 2 * T * ((C-2)*T + 2)
  TAR <- numerator / denominator
  return(TAR)
}

# 条件を満たすパラメータの組み合わせを生成
param_grid <- expand.grid(T = T_values, C = C_values, M = M_values) %>%
  filter(C >= M) %>%
  mutate(
    TAR = mapply(compute_TAR, T, C, M),
    group = paste0("C=", C, ", M=", M)
  )

# 描画
g1 = ggplot(param_grid, aes(x = T, y = TAR, color = group)) +
  geom_line(size = 1) +
  labs(
    title = "Somatic TAR over Tumor content",
    x = "Tumor content",
    y = "[Somatic TAR]",
    color = "Condition"
  ) +
  scale_y_continuous(
    limits = c(-4, 2),
    breaks = seq(-4, 2, by = 1)  # 整数目盛り
  ) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    axis.text = element_text(size = 14),     # 軸の目盛りラベル
    axis.title = element_text(size = 16),    # x軸・y軸ラベル
    plot.title = element_text(size = 18, face = "bold") # タイトル
  )


################

# パラメータ範囲
T_values <- seq(0.05, 1, length.out = 500)  # T=0 は分母ゼロ回避
C_values <- 1:4
M_values <- 1:3

# TAR関数
compute_TAR <- function(T, C, M) {
  numerator <- (T - 1) * (C - 2) + 2*M
  denominator <- 2 * ((C - 2)*T + 2)
  TAR <- numerator / denominator
  return(TAR)
}

# 条件を満たすパラメータの組み合わせを生成
param_grid <- expand.grid(T = T_values, C = C_values, M = M_values) %>%
  filter(C >= M) %>%
  mutate(
    TAR = mapply(compute_TAR, T, C, M),
    group = paste0("C=", C, ", M=", M)
  )

# 描画
g2 = ggplot(param_grid, aes(x = T, y = TAR, color = group)) +
  geom_line(size = 1) +
  labs(
    title = "Germline TAR over Tumor content",
    x = "Tumor content",
    y = "[Germline TAR]",
    color = "Condition"
  ) +
  scale_y_continuous(
    limits = c(-4, 2),
    breaks = seq(-4, 2, by = 1)  # 整数目盛り
  ) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    axis.text = element_text(size = 14),     # 軸の目盛りラベル
    axis.title = element_text(size = 16),    # x軸・y軸ラベル
    plot.title = element_text(size = 18, face = "bold") # タイトル
  )

####################

# パラメータ範囲
T_values <- seq(0.05, 1, length.out = 500)
C_values <- 1:4
M_values <- 1

# TAR定義1（元の式）
compute_TAR1 <- function(T, C, M) {
  numerator <- 2*T*M - (1 - T)*(T*(C - 2) + 2)
  denominator <- 2 * T * ((C - 2)*T + 2)
  TAR <- numerator / denominator
  return(TAR)
}

# TAR定義2（通分・整理後）
compute_TAR2 <- function(T, C, M) {
  numerator <- (T - 1)*(C - 2) + 2*M
  denominator <- 2 * ((C - 2)*T + 2)
  TAR <- numerator / denominator
  return(TAR)
}

# パラメータグリッド作成（C >= M の条件付き）
param_grid <- expand.grid(T = T_values, C = C_values, M = M_values) %>%
  filter(C >= M) %>%
  mutate(
    TAR_1 = mapply(compute_TAR1, T, C, M),
    TAR_2 = mapply(compute_TAR2, T, C, M),
    TAR_diff = TAR_1 - TAR_2,
    group = paste0("C=", C, ", M=any")
  )

# 差分プロット
g3 = ggplot(param_grid, aes(x = T, y = TAR_diff, color = group)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray") +
  geom_line(size = 1) +
  labs(
    title = "Difference between TAR origin",
    x = "Tumor content",
    y = "[Somatic TAR] - [Germline TAR]",
    color = "Condition"
  ) +
  scale_y_continuous(
    limits = c(-4, 2),
    breaks = seq(-4, 2, by = 1)
  ) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    axis.text = element_text(size = 14),     # 軸の目盛りラベル
    axis.title = element_text(size = 16),    # x軸・y軸ラベル
    plot.title = element_text(size = 18, face = "bold") # タイトル
  )

ggsave("~/TAR_somatic.png",plot = g1,width = 6,height = 10) 
ggsave("~/TAR_germline.png",plot = g2,width = 6,height = 10) 
ggsave("~/TAR_diff.png",plot = g3,width = 6,height = 9.65) 


#################

library(ggplot2)
library(dplyr)

################
# Data Preparation
################

# 1. パラメータ範囲
T_values <- seq(0.05, 1, length.out = 500)
C_val <- 2
M_val <- 1

# 2. TAR関数 (Somatic)
compute_TAR_somatic <- function(T, C, M) {
  numerator <- 2*T*M -(1-T)*(T*(C-2) + 2)
  denominator <- 2 * T * ((C-2)*T + 2)
  TAR <- numerator / denominator
  return(TAR)
}

# 3. TAR関数 (Germline)
compute_TAR_germline <- function(T, C, M) {
  numerator <- (T - 1) * (C - 2) + 2*M
  denominator <- 2 * ((C - 2)*T + 2)
  TAR <- numerator / denominator
  return(TAR)
}

# 4. データフレームを個別に作成
# Somaticデータ
data_somatic <- data.frame(T = T_values) %>%
  mutate(
    TAR = compute_TAR_somatic(T, C_val, M_val),
    Type = "Somatic" # 色分け用の識別子
  )

# Germlineデータ
data_germline <- data.frame(T = T_values) %>%
  mutate(
    TAR = compute_TAR_germline(T, C_val, M_val),
    Type = "Germline" # 色分け用の識別子
  )

# 5. 2つのデータフレームを縦に結合
combined_data <- bind_rows(data_somatic, data_germline)

################
# Plotting
################

# 6. 結合したデータを使ってプロット
# aes(color = Type) で Somatic と Germline を色分け
g_combined <- ggplot(combined_data, aes(x = T, y = TAR, color = Type)) +
  geom_line(size = 1) + # 2本のラインが描画される
  labs(
    title = "Somatic vs Germline TAR over Tumor content (C=2, M=1)",
    x = "Tumor content",
    y = "[TAR]",
    color = "Mutation Type" # 凡例のタイトル
  ) +
  scale_y_continuous(
    limits = c(-4, 2),
    breaks = seq(-4, 2, by = 1)
  ) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 16),
    plot.title = element_text(size = 18, face = "bold")
  )

# 7. グラフをPNGとして保存
ggsave("~/TAR_Somatic_vs_Germline.png", plot = g_combined, width = 6, height = 10)

# (オプション) PDFとして保存する場合
# ggsave("~/TAR_Somatic_vs_Germline.pdf", plot = g_combined, width = 8, height = 6)



#########
library(ggplot2)
library(dplyr)

################
# Data Preparation
################

# 1. パラメータ範囲
T_values <- seq(0.05, 1, length.out = 500)

# 2. TAR関数 (Somatic, C=2, M=1)
compute_TAR_somatic_C2M1 <- function(T) {
  C <- 2
  M <- 1
  numerator <- 2*T*M -(1-T)*(T*(C-2) + 2)
  denominator <- 2 * T * ((C-2)*T + 2)
  TAR <- numerator / denominator
  return(TAR)
}

# 3. TAR関数 (Germline, C=2, M=1)
compute_TAR_germline_C2M1 <- function(T) {
  C <- 2
  M <- 1
  numerator <- (T - 1) * (C - 2) + 2*M
  denominator <- 2 * ((C - 2)*T + 2)
  TAR <- numerator / denominator
  return(TAR)
}

# 4. TAR関数 (Germline, C=1, M=1) - ご指定の簡略式
compute_TAR_germline_C1M1 <- function(T) {
  TAR <- 1/2 + 1/(4 - 2*T)
  return(TAR)
}

# 5. データフレームを個別に作成
data_somatic_C2M1 <- data.frame(T = T_values) %>%
  mutate(
    TAR = compute_TAR_somatic_C2M1(T),
    Type = "Somatic (C=2, M=1)" # 凡例用の識別子
  )

data_germline_C2M1 <- data.frame(T = T_values) %>%
  mutate(
    TAR = compute_TAR_germline_C2M1(T),
    Type = "Germline (C=2, M=1)" # 凡例用の識別子
  )

data_germline_C1M1 <- data.frame(T = T_values) %>%
  mutate(
    TAR = compute_TAR_germline_C1M1(T),
    Type = "Germline (C=1, M=1)" # 凡例用の識別子
  )

# 6. 3つのデータフレームを縦に結合
combined_data <- bind_rows(
  data_somatic_C2M1, 
  data_germline_C2M1, 
  data_germline_C1M1
)

################
# Plotting
################

# 7. 結合したデータを使ってプロット
g_combined <- ggplot(combined_data, aes(x = T, y = TAR, color = Type)) +
  geom_line(size = 1) + 
  
  # 関数を注釈として追記
  annotate(
    "text",
    x = 0.05, # X座標 (左端)
    y = 1.2, # Y座標 (下端)
    label = "Germline (C=1, M=1), TAR = 1/2 + 1/(4-2T)",
    hjust = 0,    # 0 = 左揃え
    vjust = 0,    # 0 = 下揃え
    size = 5.5,
    color = "black" # 目立つように黒色
  ) +
  annotate(
    "text",
    x = 0.05, # X座標 (左端)
    y = 0.3, # Y座標 (下端)
    label = "Germline (C=2, M=1), TAR = 1/2",
    hjust = 0,    # 0 = 左揃え
    vjust = 0,    # 0 = 下揃え
    size = 5.5,
    color = "black" # 目立つように黒色
  ) +
  annotate(
    "text",
    x = 0.25, # X座標 (左端)
    y = -1.2, # Y座標 (下端)
    label = "Somatic (C=2, M=1), TAR = 1 - 1/2T",
    hjust = 0,    # 0 = 左揃え
    vjust = 0,    # 0 = 下揃え
    size = 5.5,
    color = "black" # 目立つように黒色
  ) +
  
  labs(
    title = "Somatic vs Germline TAR over Tumor content",
    x = "Tumor content",
    y = "[TAR]",
    color = "" # 凡例のタイトルを更新
  ) +
  scale_y_continuous(
    limits = c(-4, 2),
    breaks = seq(-4, 2, by = 1)
  ) +
  # # 色を手動で設定 (オプション: 凡例の順序を固定し、色を区別しやすくする場合)
  # scale_color_manual(
  #   breaks = c("Somatic (C=2, M=1)", "Germline (C=2, M=1)", "Germline (C=1, M=1)"),
  #   values = c("Somatic (C=2, M=1)" = "red", 
  #              "Germline (C=2, M=1)" = "blue", 
  #              "Germline (C=1, M=1)" = "green")
  # ) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 16),
    plot.title = element_text(size = 18, face = "bold"),
    legend.text = element_text(size = 12) # 凡例テキストのサイズ
  )

# 8. グラフをPNGとして保存
ggsave("~/TAR_Somatic_vs_Germline_3lines.png", plot = g_combined, width = 6, height = 10)

# (オプション) PDFとして保存する場合
# ggsave("~/TAR_Somatic_vs_Germline_3lines.pdf", plot = g_combined, width = 8, height = 7)