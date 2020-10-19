SELECT 
dates_rollup.date as Dates,
COALESCE(SUM(Orders),0) as Orders,
COALESCE(SUM(Items),0) as Items,
COUNT (*) as Rows
FROM dsv1069.dates_rollup
LEFT JOIN 
  (SELECT 
  date(paid_at) as Date,
  COUNT (Distinct invoice_id) as Orders,
  COUNT (Distinct line_item_id) as Items
  
  FROM dsv1069.orders
  
  GROUP BY 
    Date
  ) daily_orders
  ON dates_rollup.date >= daily_orders.date AND daily_orders.date > dates_rollup.d7_ago
  
  GROUP BY 
    Dates
LIMIT 100
