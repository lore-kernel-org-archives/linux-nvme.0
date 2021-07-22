Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADF5C63793
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 11:06:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 896246120D
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 11:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896246120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WVCp+NJX/F98CX5jamjnprCbZgZXofvfaSq5un/bbtM=; b=RMjU3wCu1k9fB5
	6G+4CIoLnUHjbn/5gEHxbnX+1Ai2DlyRnqNpLaGpT3BOzqQg7X5TU3ObIEVeqVGbKgGLLDtn1CMPs
	97dWIJebufEafE4n05WaCQrCfNJ6sG3sNaGQ9IAxUbqJ/24hOnumq2L2wHuuXGtYmaLWcc5VgueEi
	cq7BzHgF3gdG2/za8YC1jimnhOB0+UP7H/0OSwz5r0Xv47b90VrQJZl2MChfXaomBW0LPtlbR3N+h
	Z9K9O8BpnshU7QKuPjGv0V+oSBqTMyyLtYY7CQEgl3wH2fetfSXNnoAh6CZHAj0igq+eGS3IBmazU
	T6kJJ61yKdDJ97RMWoNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6WWa-001IjK-Io; Thu, 22 Jul 2021 11:05:56 +0000
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com
 ([40.107.236.68] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6WVN-001IGf-2m
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 11:04:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNuy9ZxXoc11r1+N6QV4ieKvp31jjg3bPu8pCnsXbzYFLKKvimU8MDxs/M2rwbTQoKeoTm3HB1mZ21BvTai1YzRZXpfoLaaGi62IYQ31gVWVRTAfE0QqpqIyPiRokeWYwmIvoG5fERixVyG4juN9fqp7ovduZM1dXIdtN+1aLSoA60a2ukR2ksFbpBRmIzfbAFcGYvXmyd0bu8Ymel3TvN1rRfw+pO+03zK0H4xqgy5FO9qeHO+qZUvvVy3604f2OT6dht010T3gSslO/PFjiJhIqaI19Qp83PUXAdTAB4rE6O0P0iu1VBR71okN6YVnUNTq8Vumg7aEIZOvytDvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtBrg4VgmD3102l6GupTqKopXJPsV6z+Jgoz23AiywA=;
 b=L4c5+LlZhaSGzW/lveA35saJc6wzFbJGLsmZgwaALYNU0aswBwRKgYwCU5+4EDN9t1+3VPiR2TYk0/Eb70/v+QUMF+KAEh+CUoZYIrzVURYL3eDpmvHrXpLj0sLsd4NfNYzh5/5RXyx9tBLQSyspM/PtTzITlXicQy2bFgKPmSrxrM6By2ie442L23fPVi4E6DD5BdwSBzul9AkTi1JZ/g18nVGWXpyrQs87qQEmlgVm/PP83TYLAXkuUmMijaIR7aasg18l1K5ETO+fvIeMqVeGYRKCZw63i/SQM7HS6HUAmUyM5O3qRZPPCM3NOUz+IREjg7cEfBImZIrPaMWG2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtBrg4VgmD3102l6GupTqKopXJPsV6z+Jgoz23AiywA=;
 b=I/t9vpyErC16bPVkpz0cyo1niN2M9eVefC7MXfanbIH+gvna5PNJhS7fBnjCe8rNHoYq3gcW1tjAoxMH53u3VntOKVuAI0k3ntWGFJBKBmUVkfi8miTdafY9G4pDhl+8m07avYU7M9AWXQ+ST9fHiQqlh8xWzgddSdx39+YbZAhCZitgQM7jyNKNHX+/uqY+d1tXwvBgx3V1uTASwr+8KMYutShJ2hP6k1GRPWOk21x84DELPxVizaKCAzfOzMZab8pOClf9pc2SScstqtmbWrbgq/n6Jt52fPXwKgAJw0HsTd+sl12+EvIJAAh2SYCQ8588MWIkU2Z5MH/RDZluvw==
Received: from BN0PR02CA0053.namprd02.prod.outlook.com (2603:10b6:408:e5::28)
 by SN1PR12MB2557.namprd12.prod.outlook.com (2603:10b6:802:22::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Thu, 22 Jul
 2021 11:04:39 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::46) by BN0PR02CA0053.outlook.office365.com
 (2603:10b6:408:e5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Thu, 22 Jul 2021 11:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 11:04:38 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Jul
 2021 11:04:38 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Jul
 2021 11:04:38 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Jul 2021 11:04:33 +0000
From: Boris Pismenny <borisp@nvidia.com>
To: <dsahern@gmail.com>, <kuba@kernel.org>, <davem@davemloft.net>,
 <saeedm@nvidia.com>, <hch@lst.de>, <sagi@grimberg.me>, <axboe@fb.com>,
 <kbusch@kernel.org>, <viro@zeniv.linux.org.uk>, <edumazet@google.com>,
 <smalin@marvell.com>
CC: <boris.pismenny@gmail.com>, <linux-nvme@lists.infradead.org>,
 <netdev@vger.kernel.org>, <benishay@nvidia.com>, <ogerlitz@nvidia.com>,
 <yorayz@nvidia.com>, Boris Pismenny <borisp@mellanox.com>, Ben Ben-Ishay
 <benishay@mellanox.com>, Or Gerlitz <ogerlitz@mellanox.com>, Yoray Zack
 <yorayz@mellanox.com>
Subject: [PATCH v5 net-next 05/36] nvme-tcp: Add DDP offload control path
Date: Thu, 22 Jul 2021 14:02:54 +0300
Message-ID: <20210722110325.371-6-borisp@nvidia.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210722110325.371-1-borisp@nvidia.com>
References: <20210722110325.371-1-borisp@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06f67630-6359-41e3-6df9-08d94d007ff0
X-MS-TrafficTypeDiagnostic: SN1PR12MB2557:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2557C4F42C46744095D69E87BDE49@SN1PR12MB2557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awCoTXfpfwOjGNc8luNrUwePr8R1o9/QhKK+n0GGtwg0ZKU+uTcjkIl0FEDoLr2zZA2Ni6ebaR480uB0pxZfzFqwvA/7msh+l7TGM+g8Sp8Cpi4PgJfRbCfUBqkVEavcYw8qdCfExMQZjTaiB0fgcwkVxr+Zz+D96sXF2luvYBEQCR3Xew4Riut0D4RY6HtXe2cE8p4gyOZafIb9HO2imUhA5MfpO2WxTc3nVB1J1nY0qA0A8WTnNow4+AQ8+Ld29xf0UhyBu3PnXrZ1B7JN30axAJZJDCdTHHHcWxYT+mWuikWWfbYXFrUrO7VcSULmLI3FH/jPeGvM4ooitI4TwIPJff7dp1IoZqTZBrqpM40sDfid9n44t1ScYzMad59+NeSNZapZpz/NNiZ8ToY8rv0yEcJR33Ds2HGO9cyfvyZepuikxuwfoIX7FhuGV6SeJ8UTvlT6ZbvYaFK6ZgE5GQAw3Y+eFdOLxzGqyl3nb+/qTI1KypJHt69nJ5/3oaLUQDwPVzFyWPH7xJ4curlGVFr7k+e09HrjpqzK6RkIBgf8WSsVEH2O4BdxE2NkdLSZjklFm3458WCzlLxidXGvdGHMRil/bEPauYA4d6djpxL8lf6PpQjYESzE5Sq6iK0/K21FMfsNSpzI6bj4Y2EjnVI1Q37uocnGczxoKEoiIMG1bp/UXfgjJxTb2Qt2TW3CykhAGIdkZxKzip0n+Tv01Q08B1ACHVjVSpcVp0w4YNs=
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(36840700001)(46966006)(86362001)(36860700001)(2906002)(70586007)(47076005)(2616005)(110136005)(36906005)(4326008)(36756003)(54906003)(8676002)(70206006)(7696005)(478600001)(336012)(7636003)(186003)(316002)(356005)(107886003)(1076003)(5660300002)(82740400003)(83380400001)(921005)(30864003)(7416002)(26005)(8936002)(6666004)(82310400003)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 11:04:38.9269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f67630-6359-41e3-6df9-08d94d007ff0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2557
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_040441_257272_1D4D52F1 
X-CRM114-Status: GOOD (  24.19  )
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

From: Boris Pismenny <borisp@mellanox.com>

This commit introduces direct data placement offload to NVME
TCP. There is a context per queue, which is established after the
handshake using the ulp_ddp_sk_add/del NDOs.

Additionally, a resynchronization routine is used to assist
hardware recovery from TCP OOO, and continue the offload.
Resynchronization operates as follows:

1. TCP OOO causes the NIC HW to stop the offload

2. NIC HW identifies a PDU header at some TCP sequence number,
and asks NVMe-TCP to confirm it.
This request is delivered from the NIC driver to NVMe-TCP by first
finding the socket for the packet that triggered the request, and
then finding the nvme_tcp_queue that is used by this routine.
Finally, the request is recorded in the nvme_tcp_queue.

3. When NVMe-TCP observes the requested TCP sequence, it will compare
it with the PDU header TCP sequence, and report the result to the
NIC driver (ulp_ddp_resync), which will update the HW,
and resume offload when all is successful.

Furthermore, we let the offloading driver advertise what is the max hw
sectors/segments via ulp_ddp_limits.

A follow-up patch introduces the data-path changes required for this
offload.

Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Ben Ben-Ishay <benishay@mellanox.com>
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 drivers/nvme/host/tcp.c | 180 +++++++++++++++++++++++++++++++++++++++-
 include/linux/skbuff.h  |   4 +-
 net/core/datagram.c     |   4 +-
 3 files changed, 182 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c7bd37103cf4..f1a5520cabec 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -14,6 +14,7 @@
 #include <linux/blk-mq.h>
 #include <crypto/hash.h>
 #include <net/busy_poll.h>
+#include <net/ulp_ddp.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -62,6 +63,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_ALLOCATED	= 0,
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
+	NVME_TCP_Q_OFF_DDP	= 3,
 };
 
 enum nvme_tcp_recv_state {
@@ -111,6 +113,8 @@ struct nvme_tcp_queue {
 	void (*state_change)(struct sock *);
 	void (*data_ready)(struct sock *);
 	void (*write_space)(struct sock *);
+
+	atomic64_t  resync_req;
 };
 
 struct nvme_tcp_ctrl {
@@ -130,6 +134,8 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+
+	struct net_device       *offloading_netdev;
 };
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
@@ -219,6 +225,167 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 	return nvme_tcp_pdu_data_left(req) <= len;
 }
 
+#ifdef CONFIG_ULP_DDP
+
+static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
+static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
+	.resync_request		= nvme_tcp_resync_request,
+};
+
+static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	struct net_device *netdev = queue->ctrl->offloading_netdev;
+	struct nvme_tcp_ddp_config config = {};
+	int ret;
+
+	if (!netdev || !(netdev->features & NETIF_F_HW_ULP_DDP))
+		return -EOPNOTSUPP;
+
+	config.cfg.type		= ULP_DDP_NVME;
+	config.pfv		= NVME_TCP_PFV_1_0;
+	config.cpda		= 0;
+	config.dgst		= queue->hdr_digest ?
+		NVME_TCP_HDR_DIGEST_ENABLE : 0;
+	config.dgst		|= queue->data_digest ?
+		NVME_TCP_DATA_DIGEST_ENABLE : 0;
+	config.queue_size	= queue->queue_size;
+	config.queue_id		= nvme_tcp_queue_id(queue);
+	config.io_cpu		= queue->io_cpu;
+
+	dev_hold(netdev); /* put by unoffload_socket */
+	ret = netdev->ulp_ddp_ops->ulp_ddp_sk_add(netdev,
+						  queue->sock->sk,
+						  &config.cfg);
+	if (ret) {
+		dev_put(netdev);
+		return ret;
+	}
+
+	inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = &nvme_tcp_ddp_ulp_ops;
+	if (netdev->features & NETIF_F_HW_ULP_DDP)
+		set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+
+	return ret;
+}
+
+static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{
+	struct net_device *netdev = queue->ctrl->offloading_netdev;
+
+	if (!netdev) {
+		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
+		return;
+	}
+
+	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+
+	netdev->ulp_ddp_ops->ulp_ddp_sk_del(netdev, queue->sock->sk);
+
+	inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = NULL;
+	dev_put(netdev); /* held by offload_socket */
+}
+
+static int nvme_tcp_offload_limits(struct nvme_tcp_queue *queue)
+{
+	struct net_device *netdev = get_netdev_for_sock(queue->sock->sk, true);
+	struct ulp_ddp_limits limits;
+	int ret = 0;
+
+	if (!netdev) {
+		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
+		queue->ctrl->offloading_netdev = NULL;
+		return -ENODEV;
+	}
+
+	if ((netdev->features & NETIF_F_HW_ULP_DDP) &&
+	    netdev->ulp_ddp_ops &&
+	    netdev->ulp_ddp_ops->ulp_ddp_limits)
+		ret = netdev->ulp_ddp_ops->ulp_ddp_limits(netdev, &limits);
+	else
+		ret = -EOPNOTSUPP;
+
+	if (!ret) {
+		queue->ctrl->offloading_netdev = netdev;
+		dev_dbg_ratelimited(queue->ctrl->ctrl.device,
+				    "netdev %s offload limits: max_ddp_sgl_len %d\n",
+				    netdev->name, limits.max_ddp_sgl_len);
+		queue->ctrl->ctrl.max_segments = limits.max_ddp_sgl_len;
+		queue->ctrl->ctrl.max_hw_sectors =
+			limits.max_ddp_sgl_len << (ilog2(SZ_4K) - 9);
+	} else {
+		queue->ctrl->offloading_netdev = NULL;
+	}
+
+	/* release the device as no offload context is established yet. */
+	dev_put(netdev);
+
+	return ret;
+}
+
+static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
+				     struct sk_buff *skb, unsigned int offset)
+{
+	u64 pdu_seq = TCP_SKB_CB(skb)->seq + offset - queue->pdu_offset;
+	struct net_device *netdev = queue->ctrl->offloading_netdev;
+	u64 pdu_val = (pdu_seq << 32) | ULP_DDP_RESYNC_REQ;
+	u64 resync_val;
+	u32 resync_seq;
+
+	resync_val = atomic64_read(&queue->resync_req);
+	/* Lower 32 bit flags. Check validity of the request */
+	if ((resync_val & ULP_DDP_RESYNC_REQ) == 0)
+		return;
+
+	/* Obtain and check requested sequence number: is this PDU header before the request? */
+	resync_seq = resync_val >> 32;
+	if (before(pdu_seq, resync_seq))
+		return;
+
+	if (unlikely(!netdev)) {
+		pr_info_ratelimited("%s: netdev not found\n", __func__);
+		return;
+	}
+
+	/**
+	 * The atomic operation gurarantees that we don't miss any NIC driver
+	 * resync requests submitted after the above checks.
+	 */
+	if (atomic64_cmpxchg(&queue->resync_req, pdu_val,
+			     pdu_val & ~ULP_DDP_RESYNC_REQ) != atomic64_read(&queue->resync_req))
+		netdev->ulp_ddp_ops->ulp_ddp_resync(netdev, queue->sock->sk, pdu_seq);
+}
+
+static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
+{
+	struct nvme_tcp_queue *queue = sk->sk_user_data;
+
+	atomic64_set(&queue->resync_req,
+		     (((uint64_t)seq << 32) | flags));
+
+	return true;
+}
+
+#else
+
+static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	return -EINVAL;
+}
+
+static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{}
+
+static int nvme_tcp_offload_limits(struct nvme_tcp_queue *queue)
+{
+	return -EINVAL;
+}
+
+static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
+				     struct sk_buff *skb, unsigned int offset)
+{}
+
+#endif
+
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
 		unsigned int dir)
 {
@@ -649,6 +816,9 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_resync_response(queue, skb, *offset);
+
 	ret = skb_copy_bits(skb, *offset,
 		&pdu[queue->pdu_offset], rcv_len);
 	if (unlikely(ret))
@@ -1555,6 +1725,9 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_calls(queue);
 	cancel_work_sync(&queue->io_work);
+
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_unoffload_socket(queue);
 }
 
 static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
@@ -1573,10 +1746,13 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	int ret;
 
-	if (idx)
+	if (idx) {
 		ret = nvmf_connect_io_queue(nctrl, idx, false);
-	else
+		nvme_tcp_offload_socket(&ctrl->queues[idx]);
+	} else {
 		ret = nvmf_connect_admin_queue(nctrl);
+		nvme_tcp_offload_limits(&ctrl->queues[idx]);
+	}
 
 	if (!ret) {
 		set_bit(NVME_TCP_Q_LIVE, &ctrl->queues[idx].flags);
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 8c1bfd7081d1..55dc858ff349 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3613,7 +3613,7 @@ __poll_t datagram_poll(struct file *file, struct socket *sock,
 			   struct poll_table_struct *wait);
 int skb_copy_datagram_iter(const struct sk_buff *from, int offset,
 			   struct iov_iter *to, int size);
-#ifdef CONFIG_TCP_DDP
+#ifdef CONFIG_ULP_DDP
 int skb_ddp_copy_datagram_iter(const struct sk_buff *from, int offset,
 			       struct iov_iter *to, int size);
 #endif
@@ -3627,7 +3627,7 @@ int skb_copy_and_csum_datagram_msg(struct sk_buff *skb, int hlen,
 int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
 			   struct iov_iter *to, int len,
 			   struct ahash_request *hash);
-#ifdef CONFIG_TCP_DDP
+#ifdef CONFIG_ULP_DDP
 int skb_ddp_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
 					struct iov_iter *to, int len,
 					struct ahash_request *hash);
diff --git a/net/core/datagram.c b/net/core/datagram.c
index d346fd5da22c..5ad5fb22d3f8 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -495,7 +495,7 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 	return 0;
 }
 
-#ifdef CONFIG_TCP_DDP
+#ifdef CONFIG_ULP_DDP
 /**
  *	skb_ddp_copy_and_hash_datagram_iter - Copies datagrams from skb frags to
  *	an iterator and update a hash. If the iterator and skb frag point to the
@@ -534,7 +534,7 @@ int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
 }
 EXPORT_SYMBOL(skb_copy_and_hash_datagram_iter);
 
-#ifdef CONFIG_TCP_DDP
+#ifdef CONFIG_ULP_DDP
 static size_t simple_ddp_copy_to_iter(const void *addr, size_t bytes,
 				      void *data __always_unused,
 				      struct iov_iter *i)
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
