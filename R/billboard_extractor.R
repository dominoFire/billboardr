#' Row Chart information extraction
#'
#' Extracts the song info from a Billboard chart row
#'
#' @param html_row A rvest HTML node that contains the chart row nodes (an element whose CSS class is .chart-row)
#'
#' @importFrom rvest html_node html_nodes html_text
#' @importFrom stringr str_extract
#'
#' @return A list with information of a song in the chart
extract_info = function(html_row) {
    node_primary = rvest::html_node(html_row, css='.chart-row__primary')

    song_features = c(
      ".chart-row__history--rising",
      ".chart-row__bullet",
      ".chart-row__history--falling",
      ".chart-row__award-indicator",
      ".chart-row__history--steady")

    feat_search = lapply(song_features, FUN=function(y) {
       rvest::html_nodes(node_primary, css=y)
    })

    song_node = rvest::html_node(node_primary, css=".chart-row__main-display")
    info_node = rvest::html_node(song_node, css=".chart-row__container")
    song_name_node = rvest::html_node(info_node, css=".chart-row__song")
    song_artist_node = rvest::html_node(info_node, css=".chart-row__artist")
    rank_node = rvest::html_node(song_node, css=".chart-row__rank")
    rank_num_node = rvest::html_node(rank_node, css=".chart-row__current-week")
    rank_last_week_node = rvest::html_node(rank_node, css=".chart-row__last-week")

    clean_html_text = function(node) trimws(rvest::html_text(node))

    li_ret = list(
      song_rising = length(feat_search[[1]]) > 0,
      song_performance = length(feat_search[[2]]) > 0,
      song_falling = length(feat_search[[3]]) > 0,
      song_award = length(feat_search[[4]]) > 0,
      song_steady = length(feat_search[[5]]) > 0,
      song_name = clean_html_text(song_name_node),
      song_artist = clean_html_text(song_artist_node),
      song_rank_num = as.integer(clean_html_text(rank_num_node)),
      song_rank_last_week =  as.integer(stringr::str_extract(string=clean_html_text(rank_last_week_node), pattern="\\d+"))
    )

    return(li_ret)
}


#' Extract information from Billboard chart
#'
#' Given a Billboard chart URL, extracts the chart information
#' to a list
#'
#' @param url A Billboard URL that points to a chart
#'
#' @return A list whoose entries are the rows of the extracted billboard chart
#'
#' @importFrom rvest hmtl_nodes
#' @importFrom xml2 read_html
extract_chart = function(url) {
  webpage = xml2::read_html(url)

  chart = rvest::html_nodes(webpage, css='.chart-data')

  rows = rvest::html_nodes(chart, css='.chart-row')

  li_songs = lapply(rows, extract_info)

  return(li_songs)
}


#' Billboard Hot 100 chart
#'
#' Returns the Billboard Hot 100 chart from a specifed date
#'
#' @param top_date A Date object or a string in YYYY-DD-MM format
#' @return A list whoose entries are the billboard chart
#'
#' @importFrom lubridate year month day
#'
#' @export
hot100 = function(top_date) {
  date_obj = as.Date(top_date)
  stopifnot(class(date_obj) == "Date")
  yy = lubridate::year(date_obj)
  mm = lubridate::month(date_obj)
  dd = lubridate::day(date_obj)

  date_part = sprintf("%04d-%02d-%02d", yy, mm, dd)

  target_url = sprintf("http://www.billboard.com/charts/hot-100/%s", date_part)

  lst_chart = extract_chart(target_url)

  lst_chart_complete = lapply(lst_chart, FUN=function(x) c(x, chart_date_str=date_part))

  return(lst_chart_complete)
}
