Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DD3C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 19:32:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5777E613EA
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 19:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5777E613EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ORk05kExENcEaEV4uabg2eNo797Dbt9j13qmcDIo1J4=; b=cmHS/qX8tTWCcsN6JtWcZZzyQ
	0sbtiDVXhc8tacQpWlyhNH+bbevkHRVAuPbd4S942mTWQDjICFf24GAPqLT4Gewlxg3GJWVBYtcV9
	Ei/tnga+jr9WxplvU3KQK/dBGKjQP1tNiv4JHQsqhChw3gP8kf0K/OGejUqKOlGdOEnsBp8ShR+E+
	FE0Mq0E0Ifqxbe04Vv7Hq+pOEihq22MDqPJ0AIbXeJP5wEvZlwoGR74ggERpP6gvvdbKLG+xRP9ee
	lUS1hTXAQJSJq7GEqlK1/yOoZSu8FzbxH2lbUxPKaaSrMumpfDsvinAJZ/AySdwWosQr0lhJ4VAtM
	VJZ08q71w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcCO6-006IPT-Gy; Thu, 29 Apr 2021 19:31:50 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcC3y-006FWn-FP
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 19:11:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=W5bQWgP4HHjvxrYL0KYL2R8RFNn/101Em28p8iFkbBE=; b=eU7asEr1vwXShKqIgRWh8SqMVU
 95HwGeCiaMYY5O265I8KvFCZa4Hr2uHMkdmpmCjnPqEbmzRsZqCEezkc5juUaDzcm9cHdlBjn0saD
 q0UkaYJVYl2dJn2jTIpknUh8aWIK5gvhY7HdgkDoMYnu34GDMg/xlwSjw7TnpJzCfrvnGPL2vlqnE
 JkSP/bmMwRqVBI6kmPrZrT4EXYouBxJCqCWkUeoO3iaEzU7Khhts3KWtbrpGsqWVsLBprwuME/Nco
 fBDaA+euYuDU7icxrG9Fwp4jbM+FJyiA1jk78A/JBUuBEYrQdlam7B63eldrna1QsbEqSXUfrB+aV
 Jof/AWcg==;
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcC3v-000sg2-JX
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 19:11:01 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13TJ5GSr027367; Thu, 29 Apr 2021 12:10:55 -0700
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0b-0016f401.pphosted.com with ESMTP id 387rpnamsv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 29 Apr 2021 12:10:55 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 29 Apr 2021 12:10:53 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 29 Apr 2021 12:10:50 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <sagi@grimberg.me>, <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: =?UTF-8?q?David=20S=20=2E=20Miller=20davem=20=40=20davemloft=20=2E=20net=20=C2=A0--cc=3DJakub=20Kicinski?=
 <kuba@kernel.org>,
 <smalin@marvell.com>, <aelior@marvell.com>, <mkalderon@marvell.com>,
 <okulkarni@marvell.com>, <pkushwaha@marvell.com>,
 <malin1024@gmail.com>, Nikolay Assa <nassa@marvell.com>
Subject: [RFC PATCH v4 18/27] qedn: Add qedn_claim_dev API support
Date: Thu, 29 Apr 2021 22:09:17 +0300
Message-ID: <20210429190926.5086-19-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210429190926.5086-1-smalin@marvell.com>
References: <20210429190926.5086-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: JNay_2PNs0-8k6GGjFuyCvYOPGSTGelf
X-Proofpoint-ORIG-GUID: JNay_2PNs0-8k6GGjFuyCvYOPGSTGelf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-29_10:2021-04-28,
 2021-04-29 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210429_121059_780489_45B800A9 
X-CRM114-Status: GOOD (  15.43  )
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

This patch introduces the qedn_claim_dev() network service which the
offload device (qedn) is using through the paired net-device (qede).
qedn_claim_dev() returns true if the IP addr(IPv4 or IPv6) of the target
server is reachable via the net-device which is paired with the
offloaded device.

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Nikolay Assa <nassa@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
---
 drivers/nvme/hw/qedn/qedn.h      |  4 +++
 drivers/nvme/hw/qedn/qedn_main.c | 42 ++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/hw/qedn/qedn.h b/drivers/nvme/hw/qedn/qedn.h
index c1ac17eabcb7..7efe2366eb7c 100644
--- a/drivers/nvme/hw/qedn/qedn.h
+++ b/drivers/nvme/hw/qedn/qedn.h
@@ -8,6 +8,10 @@
 
 #include <linux/qed/qed_if.h>
 #include <linux/qed/qed_nvmetcp_if.h>
+#include <linux/qed/qed_nvmetcp_ip_services_if.h>
+#include <linux/qed/qed_chain.h>
+#include <linux/qed/storage_common.h>
+#include <linux/qed/nvmetcp_common.h>
 
 /* Driver includes */
 #include "../../host/tcp-offload.h"
diff --git a/drivers/nvme/hw/qedn/qedn_main.c b/drivers/nvme/hw/qedn/qedn_main.c
index e3e8e3676b79..52007d35622d 100644
--- a/drivers/nvme/hw/qedn/qedn_main.c
+++ b/drivers/nvme/hw/qedn/qedn_main.c
@@ -27,9 +27,47 @@ static int
 qedn_claim_dev(struct nvme_tcp_ofld_dev *dev,
 	       struct nvme_tcp_ofld_ctrl_con_params *conn_params)
 {
-	/* Placeholder - qedn_claim_dev */
+	struct pci_dev *qede_pdev = NULL;
+	struct net_device *ndev = NULL;
+	u16 vlan_id = 0;
+	int rc = 0;
 
-	return 0;
+	/* qedn utilizes host network stack through paired qede device for
+	 * non-offload traffic. First we verify there is valid route to remote
+	 * peer.
+	 */
+	if (conn_params->remote_ip_addr.ss_family == AF_INET) {
+		rc = qed_route_ipv4(&conn_params->local_ip_addr,
+				    &conn_params->remote_ip_addr,
+				    &conn_params->remote_mac_addr,
+				    &ndev);
+	} else if (conn_params->remote_ip_addr.ss_family == AF_INET6) {
+		rc = qed_route_ipv6(&conn_params->local_ip_addr,
+				    &conn_params->remote_ip_addr,
+				    &conn_params->remote_mac_addr,
+				    &ndev);
+	} else {
+		pr_err("address family %d not supported\n",
+		       conn_params->remote_ip_addr.ss_family);
+
+		return false;
+	}
+
+	if (rc)
+		return false;
+
+	qed_vlan_get_ndev(&ndev, &vlan_id);
+	conn_params->vlan_id = vlan_id;
+
+	/* route found through ndev - validate this is qede*/
+	qede_pdev = qed_validate_ndev(ndev);
+	if (!qede_pdev)
+		return false;
+
+	dev->qede_pdev = qede_pdev;
+	dev->ndev = ndev;
+
+	return true;
 }
 
 static int qedn_create_queue(struct nvme_tcp_ofld_queue *queue, int qid,
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
