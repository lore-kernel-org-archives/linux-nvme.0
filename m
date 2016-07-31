From: roland@kernel.org (Roland Dreier)
Date: Sun, 31 Jul 2016 00:27:40 -0700
Subject: [PATCH 2/2] nvme-rdma: Add handling for connecting to IPv6 targets
In-Reply-To: <1469950060-18098-1-git-send-email-roland@kernel.org>
References: <1469950060-18098-1-git-send-email-roland@kernel.org>
Message-ID: <1469950060-18098-2-git-send-email-roland@kernel.org>

From: Roland Dreier <roland@purestorage.com>

If a target address does not parse as IPv4, try parsing it as IPv6
(including handling '%<scope-id>' suffixes for link-local addresses).

Signed-off-by: Roland Dreier <roland at purestorage.com>
---
 drivers/nvme/host/rdma.c | 55 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index b96b88369871..dd4aa54cd709 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -138,6 +138,7 @@ struct nvme_rdma_ctrl {
 	union {
 		struct sockaddr addr;
 		struct sockaddr_in addr_in;
+		struct sockaddr_in6 addr_in6;
 	};
 
 	struct nvme_ctrl	ctrl;
@@ -1847,19 +1848,51 @@ out_free_io_queues:
 	return ret;
 }
 
-static int nvme_rdma_parse_ipaddr(struct sockaddr_in *in_addr, char *p)
+static int nvme_rdma_parse_ipaddr(struct sockaddr *addr, char *p)
 {
-	u8 *addr = (u8 *)&in_addr->sin_addr.s_addr;
 	size_t buflen = strlen(p);
 
-	/* XXX: handle IPv6 addresses */
+	if (buflen <= INET_ADDRSTRLEN) {
+		struct sockaddr_in *addr4 = (struct sockaddr_in *) addr;
+		if (in4_pton(p, buflen, (u8 *) &addr4->sin_addr.s_addr,
+			     '\0', NULL) > 0) {
+			addr4->sin_family = AF_INET;
+			return 0;
+		}
+	}
 
-	if (buflen > INET_ADDRSTRLEN)
-		return -EINVAL;
-	if (in4_pton(p, buflen, addr, '\0', NULL) == 0)
-		return -EINVAL;
-	in_addr->sin_family = AF_INET;
-	return 0;
+	if (buflen <= INET6_ADDRSTRLEN) {
+		struct sockaddr_in6 *addr6 = (struct sockaddr_in6 *) addr;
+		const char *scope_delim;
+
+		if (in6_pton(p, buflen, (u8 *) &addr6->sin6_addr.s6_addr,
+			     '%', &scope_delim) == 0)
+			return -EINVAL;
+		addr6->sin6_family = AF_INET6;
+
+		if (ipv6_addr_type(&addr6->sin6_addr) & IPV6_ADDR_LINKLOCAL &&
+		    p + buflen != scope_delim && *scope_delim == '%') {
+			char scope_id[16];
+			size_t scope_len = min_t(size_t, sizeof scope_id,
+						 p + buflen - scope_delim - 1);
+			struct net_device *dev;
+
+			memcpy(scope_id, scope_delim + 1, scope_len);
+			scope_id[scope_len] = '\0';
+
+			/* XXX: what network namespace should we use? */
+			dev = dev_get_by_name(&init_net, scope_id);
+			if (dev) {
+				addr6->sin6_scope_id = dev->ifindex;
+				dev_put(dev);
+			} else if (kstrtouint(scope_id, 0, &addr6->sin6_scope_id))
+				return -EINVAL;
+		}
+
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
 static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
@@ -1875,7 +1908,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	ctrl->ctrl.opts = opts;
 	INIT_LIST_HEAD(&ctrl->list);
 
-	ret = nvme_rdma_parse_ipaddr(&ctrl->addr_in, opts->traddr);
+	ret = nvme_rdma_parse_ipaddr(&ctrl->addr, opts->traddr);
 	if (ret) {
 		pr_err("malformed IP address passed: %s\n", opts->traddr);
 		goto out_free_ctrl;
@@ -1949,7 +1982,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
 	WARN_ON_ONCE(!changed);
 
-	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISp\n",
+	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISpcs\n",
 		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
 
 	kref_get(&ctrl->ctrl.kref);
-- 
2.7.4
