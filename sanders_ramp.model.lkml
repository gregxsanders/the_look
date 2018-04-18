connection: "thelook_events"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: sanders_ramp_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

datagroup: sanders_ramp_longer_datagroup {
  max_cache_age: "4 hours"
}

persist_with: sanders_ramp_default_datagroup

explore: order_items {
  label: "1. US Orders"
  group_label: "Sanders TheLook Exercise"
  persist_with: sanders_ramp_longer_datagroup
  sql_always_where: ${users.country} = 'USA' ;;
  join: users {
    view_label: "Customers"
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: inner
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
    fields: [id, name, count]
  }
}

explore: events {
  label: "2. Events"
  group_label: "Sanders TheLook Exercise"
#non-sensically join the users as two groups by country
  join: us_users {
    view_label: "US Users"
    from: users
    type: left_outer
    sql_on: ${us_users.id} = ${events.user_id} AND ${us_users.country} = 'USA';;
    relationship: many_to_one
  }
  join: uk_users {
    view_label: "UK Users"
    from: users
    type: left_outer
    sql_on: ${uk_users.id} = ${events.user_id} AND ${uk_users.country} = 'UK';;
    relationship: many_to_one
  }
  always_filter: {
    filters: {
      field: created_year
      value: "2018"
    }
  }
}


explore: company_list {
  label: "3. Company List"
  group_label: "Sanders TheLook Exercise"

}

explore: bsandell {
  label: "4. Bsandell Data"
  group_label: "Sanders TheLook Exercise"
}
