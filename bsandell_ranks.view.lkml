view: bsandell_ranks {
  derived_table: {
    sql: SELECT pitstop_id AS pitstop_id,
    RANK () OVER(PARTITION BY racer_id ORDER BY start_time) AS pitstop_rank,
    LAG (start_time) OVER(PARTITION BY racer_id ORDER BY start_time) AS prior_start,
    LAG (end_time) OVER(PARTITION BY racer_id ORDER BY start_time) AS prior_finish
    FROM public.bsandell ;;
  }

  dimension: pitstop_id {
    hidden: yes
    type: number
    sql: ${TABLE}.pitstop_id ;;
    primary_key: yes
  }

  dimension: prior_pittime {
    type: number
    sql: DATEDIFF(second,${TABLE}.prior_start::timestamp,${TABLE}.prior_finish::timestamp)::numeric ;;
    }

  dimension: delta_pittime {
    type: number
    value_format_name: percent_1
    sql: (${bsandell.pittime} - ${prior_pittime})/(${bsandell.pittime}) ;;
  }

  dimension: pitstop_rank {
    type: number
    sql: ${TABLE}.pitstop_rank ;;
  }

  measure: avg_delta_pittime {
    type: average
    value_format_name: percent_1
    sql: ${delta_pittime} ;;
  }
}
