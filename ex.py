import redis
import time

r = redis.Redis(
    host='redis-10710.c247.eu-west-1-1.ec2.cloud.redislabs.com',
    port="10710",
    password='pnlkeRQkXuSHVoB5SLNMT8qIgzv3wmr7')
print(r)

# ex1
customers = []
orders = []
customers.append({"customer_numb": '001', "first_name": 'Jane', "last_name": 'Doe'})
customers.append({"customer_numb": '002', "first_name": 'John', "last_name": 'Doe'})
customers.append({"customer_numb": '003', "first_name": 'Jane', "last_name": 'Smith'})
customers.append({"customer_numb": '005', "first_name": 'Jane', "last_name": 'Jones'})
customers.append({"customer_numb": '006', "first_name": 'John', "last_name": 'Jones'})

orders.append({"order_number": '1001', "customer_numb": '002', "order_date": '10/10/09', "order_total": '250.85'})
orders.append({"order_number": '1002', "customer_numb": '002', "order_date": '2/21/10', "order_total": '125.89'})
orders.append({"order_number": '1003', "customer_numb": '003', "order_date": '11/15/09', "order_total": '1567.99'})
orders.append({"order_number": '1004', "customer_numb": '004', "order_date": '11/22/09', "order_total": '180.92'})
orders.append({"order_number": '1005', "customer_numb": '004', "order_date": '12/15/09', "order_total": '565.00'})
orders.append({"order_number": '1006', "customer_numb": '006', "order_date": '11/22/09', "order_total": '25.00'})
orders.append({"order_number": '1007', "customer_numb": '006', "order_date": '10/8/09', "order_total": '85.00'})
orders.append({"order_number": '1008', "customer_numb": '006', "order_date": '12/29/09', "order_total": '109.12'})

# ex2
profile = []
profile.append({"login": 'DonaldTrump', "id": 0, "Followers": [], "Following": [], "Posts": []})
profile.append({"login": 'JoBiden', "id": 1, "Followers": [], "Following": [], "Posts": []})

profile[0]['Followers'].append(1)
profile[1]['Followers'].append(0)
profile[0]['Following'].append(1)
profile[1]['Following'].append(0)

posts = [{"post_id": 0, "user_id": 0, "time": time.time()}, {"post_id": 1, "user_id": 1, "time": time.time()}]

profile[0]['Posts'].append(0)
profile[1]['Posts'].append(1)

with r.pipeline() as pipe:
    for i in range(len(customers)):
        pipe.hmset('Customers' + str(i), customers[i])
    pipe.execute()

with r.pipeline() as pipe:
    for i in range(len(orders)):
        pipe.hmset('Orders' + str(i), orders[i])
    pipe.execute()

for i in range(len(profile)):
    pipe.hmset('profile' + str(i), profile[i])

for i in range(len(posts)):
    pipe.hmset('post' + str(i), posts[i])

print('Customers')
for i in range(len(customers)):
    print(r.hgetall('Customers' + str(i)))

print('Orders')
for i in range(len(orders)):
    print(r.hgetall('Orders' + str(i)))

print('Profiles')
for i in range(len(profile)):
    print(r.hgetall('profile' + str(i)))

print('Posts')
for i in range(len(posts)):
    print(r.hgetall('post' + str(i)))
