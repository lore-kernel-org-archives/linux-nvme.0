Return-Path: <SRS0=adoP=K2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE8EC47082
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 23:04:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8966124B
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 23:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8966124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2EGwW01LT0hm1faOx3RTcjV9HFVuPJ/bSEKqzSQZnrg=; b=cyAuPTAJUN8+rc
	KE7I9w3byh5Bl8E2dgqSAbcTIZVQ1eiKO7+v/AARHJ/a/TJpanBwxEwqaBdV60KlZlYnp3YR22EyL
	NtX6ZxpEIP36SWUkk8BYiekoceEHvEhC7JRUB/EPLL0EXYZoG2p4a8rnosoTuyVy264g0AAGHuO4Z
	n05VSUg3pFpyPiUTMbFhJx+tEmqlIBYHQZ/vwJiFDde6cJfWtA94XiHcprQ1HrH0MJgBA7ASZwuPx
	3bPZ61umKR4f7pTaIBxwJpH1NU+uKeR4uUU5yoEh5ORQhlFyRQNKxGHnqqdKrcpeCOqN2ok/VKKLl
	Y8otXEagKA2duwH9duTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lnqxJ-00Dk4G-Ji; Mon, 31 May 2021 23:04:21 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lnqo9-00DhfA-81
 for linux-nvme@lists.infradead.org; Mon, 31 May 2021 22:54:55 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14VMporL002250; Mon, 31 May 2021 15:54:47 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 38vtnja4pn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 31 May 2021 15:54:47 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 31 May 2021 15:54:45 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 31 May 2021 15:54:41 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <davem@davemloft.net>, <kuba@kernel.org>, <sagi@grimberg.me>,
 <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <prabhakar.pkin@gmail.com>,
 <malin1024@gmail.com>, <smalin@marvell.com>,
 Nikolay Assa <nassa@marvell.com>
Subject: [RFC PATCH v7 15/27] qed: Add IP services APIs support
Date: Tue, 1 Jun 2021 01:52:10 +0300
Message-ID: <20210531225222.16992-16-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210531225222.16992-1-smalin@marvell.com>
References: <20210531225222.16992-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: iCq8OAynNLj6tvgYjlMZWNYgmFfMFvOk
X-Proofpoint-ORIG-GUID: iCq8OAynNLj6tvgYjlMZWNYgmFfMFvOk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-31_15:2021-05-31,
 2021-05-31 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210531_155453_457086_0269377A 
X-CRM114-Status: GOOD (  19.20  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Nikolay Assa <nassa@marvell.com>

This patch introduces APIs which the NVMeTCP Offload device (qedn)
will use through the paired net-device (qede).
It includes APIs for:
- ipv4/ipv6 routing
- get VLAN from net-device
- TCP ports reservation

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Nikolay Assa <nassa@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 .../qlogic/qed/qed_nvmetcp_ip_services.c      | 239 ++++++++++++++++++
 .../linux/qed/qed_nvmetcp_ip_services_if.h    |  29 +++
 2 files changed, 268 insertions(+)
 create mode 100644 drivers/net/ethernet/qlogic/qed/qed_nvmetcp_ip_services.c
 create mode 100644 include/linux/qed/qed_nvmetcp_ip_services_if.h

diff --git a/drivers/net/ethernet/qlogic/qed/qed_nvmetcp_ip_services.c b/drivers/net/ethernet/qlogic/qed/qed_nvmetcp_ip_services.c
new file mode 100644
index 000000000000..2904b1a0830a
--- /dev/null
+++ b/drivers/net/ethernet/qlogic/qed/qed_nvmetcp_ip_services.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Copyright 2021 Marvell. All rights reserved.
+ */
+
+#include <linux/types.h>
+#include <asm/byteorder.h>
+#include <asm/param.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
+#include <linux/etherdevice.h>
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/errno.h>
+
+#include <net/tcp.h>
+
+#include <linux/qed/qed_nvmetcp_ip_services_if.h>
+
+#define QED_IP_RESOL_TIMEOUT  4
+
+int qed_route_ipv4(struct sockaddr_storage *local_addr,
+		   struct sockaddr_storage *remote_addr,
+		   struct sockaddr *hardware_address,
+		   struct net_device **ndev)
+{
+	struct neighbour *neigh = NULL;
+	__be32 *loc_ip, *rem_ip;
+	struct rtable *rt;
+	int rc = -ENXIO;
+	int retry;
+
+	loc_ip = &((struct sockaddr_in *)local_addr)->sin_addr.s_addr;
+	rem_ip = &((struct sockaddr_in *)remote_addr)->sin_addr.s_addr;
+	*ndev = NULL;
+	rt = ip_route_output(&init_net, *rem_ip, *loc_ip, 0/*tos*/, 0/*oif*/);
+	if (IS_ERR(rt)) {
+		pr_err("lookup route failed\n");
+		rc = PTR_ERR(rt);
+		goto return_err;
+	}
+
+	neigh = dst_neigh_lookup(&rt->dst, rem_ip);
+	if (!neigh) {
+		rc = -ENOMEM;
+		ip_rt_put(rt);
+		goto return_err;
+	}
+
+	*ndev = rt->dst.dev;
+	ip_rt_put(rt);
+
+	/* If not resolved, kick-off state machine towards resolution */
+	if (!(neigh->nud_state & NUD_VALID))
+		neigh_event_send(neigh, NULL);
+
+	/* query neighbor until resolved or timeout */
+	retry = QED_IP_RESOL_TIMEOUT;
+	while (!(neigh->nud_state & NUD_VALID) && retry > 0) {
+		msleep(1000);
+		retry--;
+	}
+
+	if (neigh->nud_state & NUD_VALID) {
+		/* copy resolved MAC address */
+		neigh_ha_snapshot(hardware_address->sa_data, neigh, *ndev);
+
+		hardware_address->sa_family = (*ndev)->type;
+		rc = 0;
+	}
+
+	neigh_release(neigh);
+	if (!(*loc_ip)) {
+		*loc_ip = inet_select_addr(*ndev, *rem_ip, RT_SCOPE_UNIVERSE);
+		local_addr->ss_family = AF_INET;
+	}
+
+return_err:
+
+	return rc;
+}
+EXPORT_SYMBOL(qed_route_ipv4);
+
+int qed_route_ipv6(struct sockaddr_storage *local_addr,
+		   struct sockaddr_storage *remote_addr,
+		   struct sockaddr *hardware_address,
+		   struct net_device **ndev)
+{
+	struct neighbour *neigh = NULL;
+	struct dst_entry *dst;
+	struct flowi6 fl6;
+	int rc = -ENXIO;
+	int retry;
+
+	memset(&fl6, 0, sizeof(fl6));
+	fl6.saddr = ((struct sockaddr_in6 *)local_addr)->sin6_addr;
+	fl6.daddr = ((struct sockaddr_in6 *)remote_addr)->sin6_addr;
+
+	dst = ip6_route_output(&init_net, NULL, &fl6);
+	if (!dst || dst->error) {
+		if (dst) {
+			dst_release(dst);
+			pr_err("lookup route failed %d\n", dst->error);
+		}
+
+		goto out;
+	}
+
+	neigh = dst_neigh_lookup(dst, &fl6.daddr);
+	if (neigh) {
+		*ndev = ip6_dst_idev(dst)->dev;
+
+		/* If not resolved, kick-off state machine towards resolution */
+		if (!(neigh->nud_state & NUD_VALID))
+			neigh_event_send(neigh, NULL);
+
+		/* query neighbor until resolved or timeout */
+		retry = QED_IP_RESOL_TIMEOUT;
+		while (!(neigh->nud_state & NUD_VALID) && retry > 0) {
+			msleep(1000);
+			retry--;
+		}
+
+		if (neigh->nud_state & NUD_VALID) {
+			neigh_ha_snapshot((u8 *)hardware_address->sa_data, neigh, *ndev);
+
+			hardware_address->sa_family = (*ndev)->type;
+			rc = 0;
+		}
+
+		neigh_release(neigh);
+
+		if (ipv6_addr_any(&fl6.saddr)) {
+			if (ipv6_dev_get_saddr(dev_net(*ndev), *ndev,
+					       &fl6.daddr, 0, &fl6.saddr)) {
+				pr_err("Unable to find source IP address\n");
+				goto out;
+			}
+
+			local_addr->ss_family = AF_INET6;
+			((struct sockaddr_in6 *)local_addr)->sin6_addr =
+								fl6.saddr;
+		}
+	}
+
+	dst_release(dst);
+
+out:
+
+	return rc;
+}
+EXPORT_SYMBOL(qed_route_ipv6);
+
+void qed_vlan_get_ndev(struct net_device **ndev, u16 *vlan_id)
+{
+	if (is_vlan_dev(*ndev)) {
+		*vlan_id = vlan_dev_vlan_id(*ndev);
+		*ndev = vlan_dev_real_dev(*ndev);
+	}
+}
+EXPORT_SYMBOL(qed_vlan_get_ndev);
+
+struct pci_dev *qed_validate_ndev(struct net_device *ndev)
+{
+	struct pci_dev *pdev = NULL;
+	struct net_device *upper;
+
+	for_each_pci_dev(pdev) {
+		if (pdev && pdev->driver &&
+		    !strcmp(pdev->driver->name, "qede")) {
+			upper = pci_get_drvdata(pdev);
+			if (upper->ifindex == ndev->ifindex)
+				return pdev;
+		}
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(qed_validate_ndev);
+
+__be16 qed_get_in_port(struct sockaddr_storage *sa)
+{
+	return sa->ss_family == AF_INET
+		? ((struct sockaddr_in *)sa)->sin_port
+		: ((struct sockaddr_in6 *)sa)->sin6_port;
+}
+EXPORT_SYMBOL(qed_get_in_port);
+
+int qed_fetch_tcp_port(struct sockaddr_storage local_ip_addr,
+		       struct socket **sock, u16 *port)
+{
+	struct sockaddr_storage sa;
+	int rc = 0;
+
+	rc = sock_create(local_ip_addr.ss_family, SOCK_STREAM, IPPROTO_TCP, sock);
+	if (rc) {
+		pr_warn("failed to create socket: %d\n", rc);
+		goto err;
+	}
+
+	(*sock)->sk->sk_allocation = GFP_KERNEL;
+	sk_set_memalloc((*sock)->sk);
+
+	rc = kernel_bind(*sock, (struct sockaddr *)&local_ip_addr,
+			 sizeof(local_ip_addr));
+
+	if (rc) {
+		pr_warn("failed to bind socket: %d\n", rc);
+		goto err_sock;
+	}
+
+	rc = kernel_getsockname(*sock, (struct sockaddr *)&sa);
+	if (rc < 0) {
+		pr_warn("getsockname() failed: %d\n", rc);
+		goto err_sock;
+	}
+
+	*port = ntohs(qed_get_in_port(&sa));
+
+	return 0;
+
+err_sock:
+	sock_release(*sock);
+	sock = NULL;
+err:
+
+	return rc;
+}
+EXPORT_SYMBOL(qed_fetch_tcp_port);
+
+void qed_return_tcp_port(struct socket *sock)
+{
+	if (sock && sock->sk) {
+		tcp_set_state(sock->sk, TCP_CLOSE);
+		sock_release(sock);
+	}
+}
+EXPORT_SYMBOL(qed_return_tcp_port);
diff --git a/include/linux/qed/qed_nvmetcp_ip_services_if.h b/include/linux/qed/qed_nvmetcp_ip_services_if.h
new file mode 100644
index 000000000000..3604aee53796
--- /dev/null
+++ b/include/linux/qed/qed_nvmetcp_ip_services_if.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/*
+ * Copyright 2021 Marvell. All rights reserved.
+ */
+
+#ifndef _QED_IP_SERVICES_IF_H
+#define _QED_IP_SERVICES_IF_H
+
+#include <linux/types.h>
+#include <net/route.h>
+#include <net/ip6_route.h>
+#include <linux/inetdevice.h>
+
+int qed_route_ipv4(struct sockaddr_storage *local_addr,
+		   struct sockaddr_storage *remote_addr,
+		   struct sockaddr *hardware_address,
+		   struct net_device **ndev);
+int qed_route_ipv6(struct sockaddr_storage *local_addr,
+		   struct sockaddr_storage *remote_addr,
+		   struct sockaddr *hardware_address,
+		   struct net_device **ndev);
+void qed_vlan_get_ndev(struct net_device **ndev, u16 *vlan_id);
+struct pci_dev *qed_validate_ndev(struct net_device *ndev);
+void qed_return_tcp_port(struct socket *sock);
+int qed_fetch_tcp_port(struct sockaddr_storage local_ip_addr,
+		       struct socket **sock, u16 *port);
+__be16 qed_get_in_port(struct sockaddr_storage *sa);
+
+#endif /* _QED_IP_SERVICES_IF_H */
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
