Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60B6C63797
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 11:06:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8551C60725
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 11:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8551C60725
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GszYvlPjERXAoEDct3XoGG6yEytW5kGpURz6wqtP7pQ=; b=Z8KuEoosowhvaX
	TfA2QJD4xAKe5uTie22L5ucmOw49q6aIEAC72L3R0AvND4399dhKqJ4189ynNcVvBz/7RYQgqWe/7
	Otbo5JMxCSq4FWfjxKktcJ+I8tEISZD0kjkFnragULa+d678aGb7GOop9NiGwwdwPokuy+KNqXCsq
	9NM+FK8v8YNwbG5QaWAHC7VdjSU571SsUdtrvFWqf+uVG7alVaUBPu+kc38Mm1FMYcLDX91GA93EM
	8p0uGTSR8Xj9dfO1CYMtm61JCQtZtaZmPnQqTWrte+hWgIldyhnpOZmRNvKmIvgpCQ2aakl3j/bGd
	cw/YxZSRg79nW9H2SrHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6WXB-001IuM-J4; Thu, 22 Jul 2021 11:06:33 +0000
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com
 ([40.107.244.72] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6WVR-001IHg-QL
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 11:04:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7L7ajaAez1yLPkcuLhP5ZRgiliRQ5B70vKS7shDFdEQo7pmJM8vniROnsy+AfKoLiHaSjDCyCTsbklCY972aYSs1+IruuS3mXnt7vW4+rE+mZQ6NEus1R20Xi+HBeA09IaDUaantiMYsXO6hl4EuQ4sDwEVTDa24S1/iLhlPfwIRUaLKVPShCn+nVU7b0f2I856n5rDyAvRjQYxCCvjj5SOMtfTC74Ht23UrEQJR3N8N+gc/C9JdZYoat7YjQz7dxTk10rIXULZ59t6YcilNSYBIGlATu0wKDrhZaRWDZUDBp6OCLm4HXXBmsJl9cKjztx3sQFPZmqO7JQIdvrPRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ivLTFyfz8S9XoKV9ew/wjIE3HWri6kJ+VYDIRqosno=;
 b=KIjYOqgiLTwNMjzMlyRxyCtwAsrrKcSa+HEbrMM24bYRPVlVcYmaAtDevfnx7LFwq/GzFiWnb9wTBtKHpA4UsK3QVRJpJ7G2S5yGhl+18Srn+sVDLsAzbm7tELmcK509w9OfvZd1yizT7YuQCr9vnpaeFHZABAVDWoBq3g4twjiA6C9QV9xYljSuFGqjZCfmxyGGZRnSQXw/vDJIP+GUTxvyQYt5LklBs0Xhqzc8snH4gZOwKELD+vq+c5TYxO4bhMGpf0ZdUEf9++44s3WGGOhqGwxaJuBbfQTGqHu9BcEopdcJ8bJefEmcnGblV1Vq2APkKN3taTWPh6XjzowDUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=marvell.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ivLTFyfz8S9XoKV9ew/wjIE3HWri6kJ+VYDIRqosno=;
 b=pTvYLTIahaKsOl7go1dl6uGCCCyiqH32MQ7Gobs+uuwd6t9ymJ2oxnbSfJX8PebQnIbYdWZniWFxGMAhw7RMhyHTNmuvxJnR1iPiCUS3ROwavUyB+NFq+yl45ymrYqWRgdEupeU7Iub7cYeYzgcHuFxsWzSGZ+B33Ws0ZczNWz0mvvGeRsdye7BiEPUmhqqCMXTpnnl3WJr5hSzPBPpZ9l2YGJt8A2eafYjVVw/DqoSGOAhlb6K4F5gu8+iM4IJZhu4I4rEOOawRtnhs/DHSXA7i8I7BcofuETW6f1TvrpvPfho5QozUpYQSLqfPMW3wmtsHnlb8ixo9qQfvvhgR5w==
Received: from BN6PR21CA0002.namprd21.prod.outlook.com (2603:10b6:404:8e::12)
 by DM5PR1201MB0121.namprd12.prod.outlook.com (2603:10b6:4:56::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Thu, 22 Jul
 2021 11:04:43 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::79) by BN6PR21CA0002.outlook.office365.com
 (2603:10b6:404:8e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.2 via Frontend
 Transport; Thu, 22 Jul 2021 11:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 11:04:43 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Jul
 2021 11:04:43 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Jul 2021 11:04:38 +0000
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
Subject: [PATCH v5 net-next 06/36] nvme-tcp: Add DDP data-path
Date: Thu, 22 Jul 2021 14:02:55 +0300
Message-ID: <20210722110325.371-7-borisp@nvidia.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210722110325.371-1-borisp@nvidia.com>
References: <20210722110325.371-1-borisp@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 109c339d-6529-4726-d122-08d94d0082a0
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0121:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01210D210E921439FC33C8DFBDE49@DM5PR1201MB0121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGTjr/F5feO6RdBg6BvxQXmXvHNQr9rH4Ac1ODSaJ7gNXkrDfI8gqqK4RTu9eJ5D0JGkkvO19R5yVg4hfhH+OiSMV3fe4AO4CzX3ncYuZQSGlT4dM7Of9dqzvaoIdgx4nG4u8/Hj/kN7guwBgJTaz8WCIVvHjuV9WjxjcSzxAZ3P5e+w98Hjy16fvWR99/T3RkvFy/FPqFk0LfQif7tIagcoPION5K7YImH6TYkXXZ+oRSRSoiPjI8ToWQ+ghMIiuVqbFDm1M3+fh62DewC84jSiCPi/UeGjAfrlhUugb/wb8jCV+RylHPHaa72AUYf5owjZXEVDlfOJXzJqt+6rJbr6ZLc+eB6yOZ1hzjuD1qcmPxiIHb/6P8MH07C1sR7/e1g50mAunEwwalvw1QAd4WGJ8Z8HtQhD7ZFdDYrYrSIbo3FiUpQ87gpTUTstPFrFbclzT8p7D40MLMEpgCxDD37HffCon3wvTKVaoSmNx6Rn5/GmTCQiFuHkOYsw2s1KxiOiIf6SpQoHXFL/s3Vu6fmPY6PwdxNZnTa0PZnJp0Em6VTsQqOnhSmopypQ1aDVH4ZRH7cfoJwcsCX2qF7UVtcJzTtk5zdCKfkqHH8Ul/j4uMyS/OjfgFiLuOXmCCwyA4HnQDmR4MlY9Odrgj8MbsTh2r2/Rt7DLOM+g6hdmEXcz64PNoHLSJsUnqEHqz7TtOHEw/h19jjVhxgsqGjDc0LClhVm1yJc44CwocXHhhk=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(46966006)(36840700001)(186003)(7416002)(8936002)(36906005)(336012)(70206006)(478600001)(70586007)(2616005)(426003)(6666004)(82310400003)(110136005)(54906003)(5660300002)(316002)(83380400001)(36860700001)(7696005)(107886003)(86362001)(2906002)(921005)(1076003)(4326008)(7636003)(36756003)(8676002)(26005)(356005)(47076005)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 11:04:43.4972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 109c339d-6529-4726-d122-08d94d0082a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_040445_945132_10C278BF 
X-CRM114-Status: GOOD (  18.58  )
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

Introduce the NVMe-TCP DDP data-path offload.
Using this interface, the NIC hardware will scatter TCP payload directly
to the BIO pages according to the command_id in the PDU.
To maintain the correctness of the network stack, the driver is expected
to construct SKBs that point to the BIO pages.

The data-path interface contains two routines: tcp_ddp_setup/teardown.
The setup provides the mapping from command_id to the request buffers,
while the teardown removes this mapping.

For efficiency, we introduce an asynchronous nvme completion, which is
split between NVMe-TCP and the NIC driver as follows:
NVMe-TCP performs the specific completion, while NIC driver performs the
generic mq_blk completion.

Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Ben Ben-Ishay <benishay@mellanox.com>
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 drivers/nvme/host/tcp.c | 150 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 138 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index f1a5520cabec..34982fb0c655 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -57,6 +57,11 @@ struct nvme_tcp_request {
 	size_t			offset;
 	size_t			data_sent;
 	enum nvme_tcp_send_state state;
+
+	bool			offloaded;
+	struct ulp_ddp_io	ddp;
+	__le16			status;
+	union nvme_result	result;
 };
 
 enum nvme_tcp_queue_flags {
@@ -225,13 +230,76 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 	return nvme_tcp_pdu_data_left(req) <= len;
 }
 
+static int nvme_tcp_req_map_sg(struct nvme_tcp_request *req, struct request *rq)
+{
+	int ret;
+
+	req->ddp.sg_table.sgl = req->ddp.first_sgl;
+	ret = sg_alloc_table_chained(&req->ddp.sg_table, blk_rq_nr_phys_segments(rq),
+				     req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
+	if (ret)
+		return -ENOMEM;
+	req->ddp.nents = blk_rq_map_sg(rq->q, rq, req->ddp.sg_table.sgl);
+	return 0;
+}
+
 #ifdef CONFIG_ULP_DDP
 
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
+static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
 static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
 	.resync_request		= nvme_tcp_resync_request,
+	.ddp_teardown_done	= nvme_tcp_ddp_teardown_done,
 };
 
+static int nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
+				 u16 command_id,
+				 struct request *rq)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct net_device *netdev = queue->ctrl->offloading_netdev;
+	int ret;
+
+	ret = netdev->ulp_ddp_ops->ulp_ddp_teardown(netdev, queue->sock->sk,
+						    &req->ddp, rq);
+	sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+	return ret;
+}
+
+static void nvme_tcp_ddp_teardown_done(void *ddp_ctx)
+{
+	struct request *rq = ddp_ctx;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (!nvme_try_complete_req(rq, req->status, req->result))
+		nvme_complete_rq(rq);
+}
+
+static int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			      u16 command_id,
+			      struct request *rq)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct net_device *netdev = queue->ctrl->offloading_netdev;
+	int ret;
+
+	if (!test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) ||
+	    !blk_rq_nr_phys_segments(rq) || !(rq_data_dir(rq) == READ))
+		return -EINVAL;
+
+	req->ddp.command_id = command_id;
+	ret = nvme_tcp_req_map_sg(req, rq);
+	if (ret)
+		return -ENOMEM;
+
+	ret = netdev->ulp_ddp_ops->ulp_ddp_setup(netdev,
+						 queue->sock->sk,
+						 &req->ddp);
+	if (!ret)
+		req->offloaded = true;
+	return ret;
+}
+
 static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 {
 	struct net_device *netdev = queue->ctrl->offloading_netdev;
@@ -342,7 +410,7 @@ static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
 		return;
 
 	if (unlikely(!netdev)) {
-		pr_info_ratelimited("%s: netdev not found\n", __func__);
+		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
 		return;
 	}
 
@@ -367,6 +435,20 @@ static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
 
 #else
 
+static int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			      u16 command_id,
+			      struct request *rq)
+{
+	return -EINVAL;
+}
+
+static int nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
+				 u16 command_id,
+				 struct request *rq)
+{
+	return -EINVAL;
+}
+
 static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 {
 	return -EINVAL;
@@ -650,6 +732,24 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
+static void nvme_tcp_complete_request(struct request *rq,
+				      __le16 status,
+				      union nvme_result result,
+				      __u16 command_id)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_tcp_queue *queue = req->queue;
+
+	if (req->offloaded) {
+		req->status = status;
+		req->result = result;
+		nvme_tcp_teardown_ddp(queue, command_id, rq);
+	} else {
+		if (!nvme_try_complete_req(rq, status, result))
+			nvme_complete_rq(rq);
+	}
+}
+
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
@@ -664,10 +764,8 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		return -EINVAL;
 	}
 
-	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
-		nvme_complete_rq(rq);
+	nvme_tcp_complete_request(rq, cqe->status, cqe->result, cqe->command_id);
 	queue->nr_cqe++;
-
 	return 0;
 }
 
@@ -863,10 +961,39 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
 static inline void nvme_tcp_end_request(struct request *rq, u16 status)
 {
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_tcp_queue *queue = req->queue;
+	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
 	union nvme_result res = {};
 
-	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
-		nvme_complete_rq(rq);
+	nvme_tcp_complete_request(rq, cpu_to_le16(status << 1), res, pdu->command_id);
+}
+
+
+static int nvme_tcp_consume_skb(struct nvme_tcp_queue *queue, struct sk_buff *skb,
+				unsigned int *offset, struct iov_iter *iter, int recv_len)
+{
+	int ret;
+
+#ifdef CONFIG_ULP_DDP
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags)) {
+		if (queue->data_digest)
+			ret = skb_ddp_copy_and_hash_datagram_iter(skb, *offset, iter, recv_len,
+					queue->rcv_hash);
+		else
+			ret = skb_ddp_copy_datagram_iter(skb, *offset, iter, recv_len);
+	} else {
+#endif
+		if (queue->data_digest)
+			ret = skb_copy_and_hash_datagram_iter(skb, *offset, iter, recv_len,
+					queue->rcv_hash);
+		else
+			ret = skb_copy_datagram_iter(skb, *offset, iter, recv_len);
+#ifdef CONFIG_ULP_DDP
+	}
+#endif
+
+	return ret;
 }
 
 static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
@@ -913,12 +1040,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		recv_len = min_t(size_t, recv_len,
 				iov_iter_count(&req->iter));
 
-		if (queue->data_digest)
-			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
-				&req->iter, recv_len, queue->rcv_hash);
-		else
-			ret = skb_copy_datagram_iter(skb, *offset,
-					&req->iter, recv_len);
+		ret = nvme_tcp_consume_skb(queue, skb, offset, &req->iter, recv_len);
 		if (ret) {
 			dev_err(queue->ctrl->ctrl.device,
 				"queue %d failed to copy request %#x data",
@@ -1142,6 +1264,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	bool inline_data = nvme_tcp_has_inline_data(req);
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) + hdgst - req->offset;
+	struct request *rq = blk_mq_rq_from_pdu(req);
 	int flags = MSG_DONTWAIT;
 	int ret;
 
@@ -1150,6 +1273,8 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	else
 		flags |= MSG_EOR;
 
+	nvme_tcp_setup_ddp(queue, pdu->cmd.common.command_id, rq);
+
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
@@ -2486,6 +2611,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	if (req->curr_bio && req->data_len)
 		nvme_tcp_init_iter(req, rq_data_dir(rq));
 
+	req->offloaded = false;
 	if (rq_data_dir(rq) == WRITE &&
 	    req->data_len <= nvme_tcp_inline_data_size(queue))
 		req->pdu_len = req->data_len;
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
