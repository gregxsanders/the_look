view: order_items {
  sql_table_name: public.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: shipping_duration {
    type: number
    sql:  ${delivered_date} - ${shipped_date} ;;
  }

#   measure: wrong_total_shipping_duration {
#     type: sum
#     sql: ${shipping_duration} ;;
#   }
#
#   measure: total_shipping_duration {
#     type: sum_distinct
#     sql_distinct_key: ${order_id} ;;
#     sql: ${shipping_duration} ;;
#   }

  dimension: handling_duration {
    type: number
    sql:  ${shipped_date} - ${created_date} ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
    value_format_name: usd
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    html:
    {% if value == 'Complete' %}
    <div style="background-color:#D5EFEE">{{ value }}</div>
    {% elsif value == 'Processing' or value == 'Shipped' %}
    <div style="background-color:#FCECCC">{{ value }}</div>
    {% elsif value == 'Cancelled' or value == 'Returned' %}
    <div style="background-color:#EFD5D6">{{ value }}</div>
    {% endif %}
    ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: sum_of_sales {
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd
#     drill_fields: [id, sale_price, products.category, products.name]
    drill_fields: [detail*]
  }

  measure: sum_of_returns {
    type: sum
    filters: {
      field: status
      value: "Returned"
    }
    sql: ${sale_price} ;;
    value_format_name: usd
  }

  dimension: is_returned {
    type: yesno
    sql: ${status} = 'Returned' ;;
  }

  measure: return_rate_by_price {
    type: number
    description: "Return rate by sale value"
    sql: ${sum_of_returns} / NULLIF(${sum_of_sales}, 0) ;;
    value_format_name: percent_2
  }

  measure: count_complete {
    type: count
    filters: {
      field: status
      value: "Complete"
    }
    drill_fields: [detail*]
  }

  measure: count_returned {
    type: count
    filters: {
      field: status
      value: "Returned"
    }
    drill_fields: [detail*]
  }

  measure: return_rate_pct {
    type: number
    sql: 1.00* ${count_returned} / NULLIF(${count_complete}, 0) ;;
    value_format_name: percent_2
  }

  dimension: gross_margin {
    description: "Sale price - product cost"
    sql: ${sale_price} - ${products.cost} ;;
    value_format_name: usd
    drill_fields: [detail*]
  }

  measure: sum_gross_margin {
    description: "Sum of gross margin of complete orders"
    type: sum
    filters: {
      field: status
      value: "Complete"
    }
    sql: ${gross_margin} ;;
    value_format_name: usd
    drill_fields: [detail*]
  }

  measure: cumulative_total_revenue {
    description: "Cumulative revenue"
    type: running_total
    sql: ${sum_of_sales} ;;
    value_format_name: usd
    drill_fields: [detail*]
  }

  measure: avg_shipping_duration {
    type:  average
    sql: 1.00 * ${shipping_duration} ;;
    value_format_name: decimal_2
    drill_fields: [detail*]
  }

  measure: avg_handling_duration {
    type:  average
    sql: 1.00 * ${handling_duration} ;;
    value_format_name: decimal_2
    drill_fields: [detail*]
  }

  measure: avg_sale_price {
    type: average
    sql: ${sale_price} ;;
    value_format_name: usd
    drill_fields: [detail*]
  }

  measure: min_sale {
    label: "Smallest Sale"
    description: "Least Item Sale Value"
    type: min
    sql: ${sale_price} ;;
    value_format_name: usd
    drill_fields: [detail*]
  }

  measure: max_sale {
    label: "Biggest Sale"
    description: "Largest Item Sale Value"
    type: max
    sql: ${sale_price} ;;
    value_format_name: usd
    drill_fields: [detail*]
  }

  measure: cost_sum {
    description: "Sum of product cost"
    type: sum
    sql: ${products.cost} ;;
    value_format_name: usd
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [id, order_id, status, created_date, sale_price, products.brand, products.name, users.gender, users.name, users.email]
  }
}
