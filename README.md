# billboardr

Information from Billboard in a friendly R intervace

## Installation

Use devtools and their Github magic:

```
devtools::install_github("dominoFire/billboardr")
```

## Usage

```
library(billboardr)

# Billboard Hot 100 from a specific date
chart_list = billboardr::hot100("1996-06-21")
chart_df = dplyr::bind_rows(chart_list)
print(head(chart_df))
```

You should see something like this:

```
# A tibble: 6 x 10
  song_rising song_performance song_falling song_award song_steady song_name                                             song_artist                  song_r~ song_ra~ chart~
  <lgl>       <lgl>            <lgl>        <lgl>      <lgl>       <chr>                                                 <chr>                          <int>    <int> <chr> 
1 F           F                F            F          T           Tha Crossroads                                        Bone Thugs-N-Harmony               1        1 1996-~
2 T           T                F            F          F           You're Makin' Me High/Let It Flow                     Toni Braxton                       2        4 1996-~
3 F           T                F            F          T           Give Me One Reason                                    Tracy Chapman                      3        3 1996-~
4 F           F                T            F          F           Always Be My Baby                                     Mariah Carey                       4        2 1996-~
5 F           F                F            F          T           "Because You Loved Me (From \"Up Close & Personal\")" Celine Dion                        5        5 1996-~
6 T           T                F            F          F           How Do U Want It/California Love                      2Pac Featuring K-Ci And JoJo       6       64 1996-~
```
## Comments

Create an issue on the repo, please.
