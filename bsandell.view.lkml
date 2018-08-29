view: bsandell {
  sql_table_name: public.bsandell ;;

  dimension: car_id {
    type: number
    sql: ${TABLE}.car_id ;;
  }

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      time,
      minute15,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.end_time ;;
  }

  dimension: number_of_pit_crew_members {
    type: number
    sql: ${TABLE}.number_of_pit_crew_members ;;
  }

  dimension: pitstop_id {
    type: number
    sql: ${TABLE}.pitstop_id ;;
    primary_key: yes
  }

  dimension: racer_id {
    type: number
    sql: ${TABLE}.racer_id ;;
  }

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      time,
      minute15,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.start_time ;;
  }

  dimension: pittime {
    type: number
    sql: DATEDIFF(second,${start_time}::timestamp,${end_time}::timestamp) ;;
    value_format_name: decimal_2
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: sum_pittime {
    type: sum
    sql:${pittime} * 1.00 ;;
    value_format_name: decimal_2
  }

  measure: avg_pittime {
    type: average
    sql: ${pittime} * 1.00 ;;
    value_format_name: decimal_2
    }
}
