From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  2 Jul 2017 11:20:50 +0300
Subject: [PATCH v2 1/3] RDMA/core: make ib_device.add method optional
In-Reply-To: <1498983652-18250-1-git-send-email-sagi@grimberg.me>
References: <1498983652-18250-1-git-send-email-sagi@grimberg.me>
Message-ID: <1498983652-18250-2-git-send-email-sagi@grimberg.me>

ib_clients can indeed fill .add to NULL, but then they will not see
any device removal notifications. The reason is that that
ib_register_client and ib_register_device checked existence of .add
before adding the creating a corresponding client_data and adding
it to the list. Simple condition reverse fixes the issue.

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/infiniband/core/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 81d447da0048..26eb428af473 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -414,7 +414,7 @@ int ib_register_device(struct ib_device *device,
 	device->reg_state = IB_DEV_REGISTERED;
 
 	list_for_each_entry(client, &client_list, list)
-		if (client->add && !add_client_context(device, client))
+		if (!add_client_context(device, client) && client->add)
 			client->add(device);
 
 	down_write(&lists_rwsem);
@@ -499,7 +499,7 @@ int ib_register_client(struct ib_client *client)
 	mutex_lock(&device_mutex);
 
 	list_for_each_entry(device, &device_list, core_list)
-		if (client->add && !add_client_context(device, client))
+		if (!add_client_context(device, client) && client->add)
 			client->add(device);
 
 	down_write(&lists_rwsem);
-- 
2.7.4
