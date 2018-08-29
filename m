From: sshah@solarflare.com (Shradha Shah)
Date: Wed, 29 Aug 2018 10:58:20 +0100
Subject: [PATCH 2/3] nvme-tcp: TLS encrytion support using netlink sockets
In-Reply-To: <697ba799-b8b4-c7b5-734d-09e898295a4f@solarflare.com>
References: <697ba799-b8b4-c7b5-734d-09e898295a4f@solarflare.com>
Message-ID: <5df614fe-c8d7-137d-f8a1-d32273fdfcd2@solarflare.com>

Signed-off-by: Shradha Shah <sshah at solarflare.com>
---
 drivers/nvme/host/nvme.h          |   1 +
 drivers/nvme/host/tcp.c           | 150 ++++++++++++++++++++++++++++++++++++--
 include/uapi/linux/nvme_netlink.h |  43 +++++++++++
 3 files changed, 186 insertions(+), 8 deletions(-)
 create mode 100644 include/uapi/linux/nvme_netlink.h

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 06ebc7302aed..1a54f18eb345 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -207,6 +207,7 @@ struct nvme_ctrl {
 	u16 maxcmd;
 	int nr_reconnects;
 	bool tls_enable;
+	struct sock *nl_sk;
 	struct nvmf_ctrl_options *opts;
 	struct delayed_work reconnect_work;
 	struct work_struct err_work;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a1e16457b74e..8ac282b7ecf6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -20,7 +20,7 @@
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <linux/blk-mq.h>
-
+#include <uapi/linux/nvme_netlink.h>
 #include "nvme.h"
 #include "fabrics.h"
 
@@ -108,6 +108,8 @@ struct nvme_tcp_queue {
 	struct nvme_tcp_queue_tx_context tx;
 
 	struct nvme_tcp_request async_req;
+	struct nvme_tcp_uevent tls_handshake_uevent;
+	wait_queue_head_t tls_handshake_wait;
 
 	void (*sc)(struct sock *);
 	void (*dr)(struct sock *);
@@ -996,6 +998,79 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	return ret;
 }
 
+static void nl_data_ready(struct sk_buff *skb)
+{
+	struct nlmsghdr *nlh;
+	struct nvme_tcp_uevent *tls_handshake_response_ptr;
+	struct nvme_tcp_queue *queue;
+	int err;
+
+	queue = skb->sk->sk_user_data;
+
+	nlh = (struct nlmsghdr *)skb->data;
+	tls_handshake_response_ptr = (struct nvme_tcp_uevent *)NLMSG_DATA(nlh);
+
+	if (tls_handshake_response_ptr->ev_type == TLS_HANDSHAKE_COMPLETE) {
+		queue->tls_handshake_uevent.ev_type = TLS_HANDSHAKE_COMPLETE;
+		queue->tls_handshake_uevent.qid = tls_handshake_response_ptr->qid;
+		queue->tls_handshake_uevent.tlsrep.sd = tls_handshake_response_ptr->tlsrep.sd;
+		queue->tls_handshake_uevent.tlsrep.pid = tls_handshake_response_ptr->tlsrep.pid;
+		queue->sock = sockfd_lookup(queue->tls_handshake_uevent.tlsrep.sd,
+					    &err);
+		if (queue->sock == NULL) {
+			pr_err("sockfd_lookup error code is %d\n", err);
+			queue->tls_handshake_uevent.ev_type = TLS_HANDSHAKE_ERROR;
+		}
+	} else {
+		queue->tls_handshake_uevent.ev_type = TLS_HANDSHAKE_ERROR;
+		pr_err("TLS handshake failed, KTLS socket not created\n");
+	}
+	wake_up(&queue->tls_handshake_wait);
+}
+
+static int  nvme_netlink_handshake(struct nvme_ctrl *nctrl,
+				   struct nvme_tcp_queue *queue, int qid)
+{
+	struct sk_buff *skb = NULL;
+	struct nlmsghdr *nlh = NULL;
+	int msg_size;
+
+	queue->tls_handshake_uevent.ev_type = TLS_HANDSHAKE_INIT;
+	strncpy(queue->tls_handshake_uevent.tlsreq.hostnqn,
+		nctrl->opts->host->nqn, NVMF_NQN_SIZE);
+	strncpy(queue->tls_handshake_uevent.tlsreq.subsysnqn,
+		nctrl->opts->subsysnqn, NVMF_NQN_SIZE);
+	queue->tls_handshake_uevent.qid = qid;
+
+	msg_size = sizeof(struct nvme_tcp_uevent);
+
+	skb = nlmsg_new(msg_size, GFP_KERNEL);
+	if (skb == NULL) {
+		pr_err("NVMe TCP tls netlink skb NULL\n");
+		return -1;
+	}
+
+	nlh = nlmsg_put(skb, 0, 1, NLMSG_DONE, msg_size, 0);
+	if (!nlh) {
+		kfree_skb(skb);
+		pr_err("NVMe TCP tls nlh NULL\n");
+		return -1;
+	}
+
+	memcpy((nlmsg_data(nlh)),
+	       (const unsigned char *)&queue->tls_handshake_uevent,
+	       sizeof(struct nvme_tcp_uevent));
+
+	NETLINK_CB(skb).portid = 0;
+	NETLINK_CB(skb).dst_group = TLS_HANDSHAKE_GRP;
+
+	nctrl->nl_sk->sk_user_data = queue;
+
+	netlink_broadcast(nctrl->nl_sk, skb, 0, TLS_HANDSHAKE_GRP, GFP_KERNEL);
+
+	return 0;
+}
+
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 		int qid, size_t queue_size)
 {
@@ -1009,18 +1084,44 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
 	queue->queue_size = queue_size;
 
+	init_waitqueue_head(&queue->tls_handshake_wait);
+
 	if (qid > 0)
 		queue->cmnd_capsule_len = ctrl->ctrl.ioccsz * 16;
 	else
 		queue->cmnd_capsule_len = sizeof(struct nvme_command) +
 						NVME_TCP_ADMIN_CCSZ;
 
-	ret = sock_create(ctrl->addr.ss_family, SOCK_STREAM,
-			IPPROTO_TCP, &queue->sock);
-	if (ret) {
-		dev_err(ctrl->ctrl.device,
-			"failed to create socket: %d\n", ret);
-		return ret;
+	if (nctrl->tls_enable == true) {
+		ret = nvme_netlink_handshake(nctrl, queue, qid);
+		if (ret) {
+			dev_err(ctrl->ctrl.device,
+				"failed to create KTLS socket: %d\n", ret);
+			return ret;
+		}
+
+		ret = wait_event_interruptible_timeout(queue->tls_handshake_wait,
+						       ((queue->tls_handshake_uevent.ev_type == TLS_HANDSHAKE_COMPLETE) |
+							(queue->tls_handshake_uevent.ev_type == TLS_HANDSHAKE_ERROR)),
+						       msecs_to_jiffies(5000));
+		if (ret == 0)
+			pr_err("TLS handshake failed, timeout elapsed\n");
+		else if (ret < 0)
+			pr_err("Interrupted by signal\n");
+
+		if (queue->sock == NULL) {
+			dev_err(ctrl->ctrl.device,
+				"failed to create socket\n");
+			return -ENOTSOCK;
+		}
+	} else {
+		ret = sock_create(ctrl->addr.ss_family, SOCK_STREAM,
+				  IPPROTO_TCP, &queue->sock);
+		if (ret) {
+			dev_err(ctrl->ctrl.device,
+				"failed to create socket: %d\n", ret);
+			return ret;
+		}
 	}
 
 	/* Single syn retry */
@@ -1363,6 +1464,14 @@ int nvme_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 }
 EXPORT_SYMBOL_GPL(nvme_configure_io_queues);
 
+void nvme_release_netlink_socket(struct nvme_ctrl *ctrl)
+{
+	if ((ctrl->tls_enable == true) && (ctrl->nl_sk != NULL)) {
+		netlink_kernel_release(ctrl->nl_sk);
+		ctrl->nl_sk = NULL;
+	}
+}
+
 void nvme_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
 {
 	nvme_tcp_stop_admin_queue(ctrl);
@@ -1372,6 +1481,7 @@ void nvme_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
 		nvme_tcp_free_tagset(ctrl, ctrl->admin_tagset);
 	}
 	nvme_tcp_free_admin_queue(ctrl);
+	nvme_release_netlink_socket(ctrl);
 }
 EXPORT_SYMBOL_GPL(nvme_destroy_admin_queue);
 
@@ -1648,6 +1758,22 @@ static int nvme_tcp_post_configure(struct nvme_ctrl *ctrl)
 	return 0;
 }
 
+static int open_netlink_socket(struct nvme_ctrl *ctrl)
+{
+	struct netlink_kernel_cfg cfg = {
+		.groups = TLS_HANDSHAKE_GRP,
+		.input =  nl_data_ready,
+	};
+
+	ctrl->nl_sk = netlink_kernel_create(&init_net, NETLINK_USERSOCK, &cfg);
+	if (!ctrl->nl_sk) {
+		pr_err("Error creating netlink socket\n");
+		return -ENOTSOCK;
+	}
+
+	return 0;
+}
+
 int nvme_probe_ctrl(struct nvme_ctrl *ctrl)
 {
 	bool changed;
@@ -1655,9 +1781,15 @@ int nvme_probe_ctrl(struct nvme_ctrl *ctrl)
 
 	INIT_WORK(&ctrl->reset_work, nvme_reset_ctrl_work);
 
+	if (ctrl->tls_enable == true) {
+		ret = open_netlink_socket(ctrl);
+		if (ret)
+			goto err;
+	}
+
 	ret = nvme_configure_admin_queue(ctrl, true);
 	if (ret)
-		goto err;
+		goto out_remove_netlink_socket;
 
 	ret = nvme_tcp_post_configure(ctrl);
 	if (ret)
@@ -1677,6 +1809,8 @@ int nvme_probe_ctrl(struct nvme_ctrl *ctrl)
 	return 0;
 out_remove_admin_queue:
 	nvme_destroy_admin_queue(ctrl, true);
+out_remove_netlink_socket:
+	nvme_release_netlink_socket(ctrl);
 err:
 	if (ret > 0)
 		ret = -EIO;
diff --git a/include/uapi/linux/nvme_netlink.h b/include/uapi/linux/nvme_netlink.h
new file mode 100644
index 000000000000..65801fa24aae
--- /dev/null
+++ b/include/uapi/linux/nvme_netlink.h
@@ -0,0 +1,43 @@
+/*
+ * Definitions for the NVM Express over fabrics netlink interface
+ * Copyright (c) 2011-2014, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifndef _UAPI_LINUX_NVME_NETLINK_H
+#define _UAPI_LINUX_NVME_NETLINK_H
+
+#include <linux/types.h>
+
+#define TLS_HANDSHAKE_INIT 1
+#define TLS_HANDSHAKE_COMPLETE 2
+#define TLS_HANDSHAKE_ERROR 3
+
+#define TLS_HANDSHAKE_GRP 21
+
+#define NVMF_NQN_SIZE		223
+
+struct nvme_tcp_uevent {
+	__u32	ev_type;
+	__u32 qid;
+	struct tls_uconnect_request {
+		char			hostnqn[NVMF_NQN_SIZE];
+		char			subsysnqn[NVMF_NQN_SIZE];
+	} tlsreq;
+	struct tls_uconnect_reply {
+		__u32			 sd;
+		__u32			pid;
+	} tlsrep;
+};
+
+#endif
-- 
2.14.4
