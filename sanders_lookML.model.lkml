connection: "thelook_events"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

# Select the views that should be a part of this model,
# and define the joins that connect them together.

explore: order_items {
  label: "3. Adv LookML"
  group_label: "Sanders TheLook Exercise"
  join: inventory_items {
    relationship: one_to_one
    sql_on: ${inventory_items.id} = ${order_items.inventory_item_id} ;;
    type: full_outer
  }

  join: users {
    relationship: many_to_one
    sql_on: ${users.id} = ${order_items.user_id} ;;
  }

  join: products {
    relationship: many_to_one
    sql_on: ${products.id} = ${inventory_items.product_id} ;;

  }
  join: distribution_centers {
    relationship: many_to_one
    sql_on: ${distribution_centers.id} = ${products.distribution_center_id} ;;
  }
  join: user_metrics {
    relationship: one_to_one
    sql_on: ${order_items.user_id} = ${user_metrics.user_id} ;;
  }
}

explore: bsandell {
  label: "5. Pit Boss"
  group_label: "Sanders TheLook Exercise"
  join: bsandell_ranks {
    view_label: "Bsandell"
    relationship: one_to_one
    sql_on: ${bsandell_ranks.pitstop_id} = ${bsandell.pitstop_id} ;;
  }

}
