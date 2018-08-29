view: thelook_orderitems {
  sql_table_name: looker_test.thelook_orderitems ;;

  dimension: order_items_average_sale_price {
    type: string
    sql: ${TABLE}.OrderItemsAverageSalePrice ;;
  }

  dimension: order_items_created_date {
    type: string
    sql: ${TABLE}.OrderItemsCreatedDate ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
