- dashboard: sanders_ramp_events_lookml_db
  title: Sanders Ramp Events Lookml Db
  layout: tile
  tile_size: 120

  filters:

  elements:
    - name: add_a_unique_name_1524087790
      title: Event Count by Event Type
      model: sanders_ramp
      explore: events
      type: looker_bar
      fields: [events.count, events.event_type]
      filters:
        events.created_year: '2018'
      sorts: [events.count desc]
      limit: 500
      query_timezone: America/Los_Angeles
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      limit_displayed_rows: false
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      x_axis_reversed: false
      y_axis_reversed: false
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      leftAxisLabelVisible: false
      leftAxisLabel: ''
      rightAxisLabelVisible: false
      rightAxisLabel: ''
      barColors: [red, blue]
      smoothedBars: false
      orientation: automatic
      labelPosition: left
      percentType: total
      percentPosition: inline
      valuePosition: right
      labelColorEnabled: false
      labelColor: "#FFF"
      series_types: {}

    - name: add_a_unique_name_1524087840
      title: Event Count by Traffic Source
      model: sanders_ramp
      explore: events
      type: looker_bar
      fields: [events.count, events.traffic_source]
      filters:
        events.created_year: '2018'
      sorts: [events.count desc]
      limit: 500
      query_timezone: America/Los_Angeles
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      limit_displayed_rows: false
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      x_axis_reversed: false
      y_axis_reversed: false
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      leftAxisLabelVisible: false
      leftAxisLabel: ''
      rightAxisLabelVisible: false
      rightAxisLabel: ''
      barColors: [red, blue]
      smoothedBars: false
      orientation: automatic
      labelPosition: left
      percentType: total
      percentPosition: inline
      valuePosition: right
      labelColorEnabled: false
      labelColor: "#FFF"
      series_types: {}

    - name: add_a_unique_name_1524088004
      title: Event Count by Traffic Source and Age Tier
      model: sanders_ramp
      explore: events
      type: looker_column
      fields: [events.count, events.traffic_source, us_users.age_tier]
      pivots: [us_users.age_tier]
      fill_fields: [us_users.age_tier]
      filters:
        events.created_year: '2018'
      sorts: [events.count desc 0, us_users.age_tier]
      limit: 500
      query_timezone: America/Los_Angeles
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      limit_displayed_rows: false
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      x_axis_reversed: false
      y_axis_reversed: false
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      leftAxisLabelVisible: false
      leftAxisLabel: ''
      rightAxisLabelVisible: false
      rightAxisLabel: ''
      barColors: [red, blue]
      smoothedBars: false
      orientation: automatic
      labelPosition: left
      percentType: total
      percentPosition: inline
      valuePosition: right
      labelColorEnabled: false
      labelColor: "#FFF"
      series_types: {}
