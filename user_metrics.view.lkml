view: user_metrics {
  derived_table: {
    sql: SELECT
        user_id as user_id,
        COUNT(DISTINCT order_id) as lifetime_orders,
        SUM(sale_price) as lifetime_revenue,
        MIN(NULLIF(created_at,0)) AS first_order,
        MAX(NULLIF(created_at,0)) AS latest_order,
        COUNT(DISTINCT DATE_TRUNC('month', NULLIF(created_at,0))) AS number_of_distinct_months_with_orders
      FROM order_items
      GROUP BY user_id
      ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: user_id {
    description: "Unique ID for each user that has ordered"
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: lifetime_orders {
    description: "The total number of orders for each user"
    type: number
    sql: ${TABLE}.lifetime_orders ;;
  }

  dimension: lifetime_revenue {
    description: "The total sales revenue for each user"
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
  }

  dimension: number_of_distinct_months_with_orders {
    type: number
    sql: ${TABLE}.number_of_distinct_months_with_orders ;;
  }
  dimension: days_as_customer {
    type: number
    sql: ${latest_order_date} - ${first_order_date} ;;
  }

  dimension_group: first_order {
    description: "The date when each user first ordered"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.first_order ;;
  }

  dimension_group: latest_order {
    description: "The date when each user latest ordered"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.latest_order ;;
  }
}
