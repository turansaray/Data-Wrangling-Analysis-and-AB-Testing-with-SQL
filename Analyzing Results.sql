SELECT
test_assignment,
COUNT(user_id)   as users
--SUM(order_binary) as orders_completed
FROM
(SELECT
  assignments.user_id,
  assignments.test_id,
  assignments.test_assignment,
  MAX(CASE WHEN orders.created_at > assignments.event_time then 1 ELSE 0 END) as orders_after_assignment
  FROM
    (SELECT
    event_id,
    event_time,
    user_id,
    MAX(CASE WHEN parameter_name = 'test_id'
        then Cast(parameter_value as Int)
        ELSE NULL
        END) as test_id,
    MAX(CASE WHEN parameter_name = 'test_assignment'
        Then Cast(parameter_value as Int)
        Else NULL
        END) as test_assignment
        
    FROM dsv1069.events
    WHERE event_name = 'test_assignment'
    
    GROUP BY 
    event_id,
    event_time,
    user_id
    ) assignments
  LEFT JOIN
    dsv1069.orders
  ON assignments.user_id = orders.user_id
  
  GROUP BY 
  assignments.test_id,
  assignments.test_assignment,
  assignments.user_id 
) order_binary

WHERE test_id = 7
GROUP BY
test_assignment
LIMIT 100
