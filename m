Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B12C35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 21:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u9wEKH9HN/qmfDURE6Qw0cIJT1VVse0zXxf1ybIG2PM=; b=o1y53OcijyKovGmLDxRGwpvPNL
	ru26j0Kfg4AaAJluXYr/4VxCHcBKTa4TACefVkXlnnIoX7sLAx+TPMHka2eOS6d4dcXYTZzqUMXnN
	UjGfHa+qn73qaTCPSEmxtKFdZeI7vGjEUp819t24CV67Y0IRNSU2PKubPDbFZLajF0xVfE8Jbx+h5
	RxDqjH/A4/A4yy4loOueNFlb3NFOSrtTgBlBmeq/Ln/OtnWa/npgzWKTPfUTfgzilRPXR+VQbK0Qq
	4IQMMsW+TSGAfV1s9fiUrEIlXakSoJOBQHzlBgx7AsgOOMraXwKfkBqyL8HqeMlulW1zXFPyzuCT8
	ZxJwKiEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGQh0-004BIM-1f;
	Thu, 21 Dec 2023 21:34:58 +0000
Received: from mail-bn8nam04on2062f.outbound.protection.outlook.com ([2a01:111:f400:7e8d::62f] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGQgm-004B1R-2V
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 21:34:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEmILq1gn6DUmnPzC10Dt3enoynGAKwaXf14inMeZOOnafHtdNQwwpQ4cr2vGqGzvYA8wDoM4t4/qz9CW9ZKxz3HXupbh7oEvBS+yvBcrLKWSkY+l5SGacvwMAMd6vZPpo5OYhd11b7qBJE4drb8ITaD6afZvKKR6gB1Orj1GTbUfhQFGeYtcLIbNZiD7xhGW0n2gNEWzcerSmV7TItzyZaHpZrbgeD8wgFOzxcUhEPT+VuErQYb50UjQgSc+1K28i5MCQ/ZnBGqz6ec2QeLp0EUyGI6rwXkUP7AqDjUKC5v06MwHWDp1Rx8jrNMb8u7Jl+OSFsQKJZai/dltfYLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9wEKH9HN/qmfDURE6Qw0cIJT1VVse0zXxf1ybIG2PM=;
 b=FwoVbRjF2oNv5mRJOEuXXfup4+uEabcGOyiIpGh0F5XyPR7pHMGfxtHU7BxcQHjF/RxQgvU9uTN9M3ekQwO/RER5EC2aYKtzIm+24AowqDFN2uUQEdXSmuDO6orT0moKkzByITNJxoVBb+zMwFMsABvCFv+jEZx8oj/4V19T122YayCjiWgWZyRUjPcdn1uv0lv5KWtxG1kdsM85Fj3+aWMXavDxHhJufrlv+lpFSkyQ6IMY9ZXSc1cN3mINTJgepvjuArFFvLZjAQBfepYeDe1sTMHMSUVr8f9wI/BxdxHa4gi6mbNen/zT/UqKniRAvAlYybXuPdAKac+G/MsgbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9wEKH9HN/qmfDURE6Qw0cIJT1VVse0zXxf1ybIG2PM=;
 b=k8iZm4u4SkB7ly16ynE/H77isg5e1utUOamHQ01Paikh9HdyluyBq66ZW8Jhp2TduT0JfSeLIqMEAfAMLNcCFc9OO3xcueQdOl9PDXAea87yxbXZ9DuCO3sWUO9TQrOQBlPyk/y8Q1akA5JtLkCf7R0u29+xoBjw7wUvxsxF4Xg0F2sYoQkDx+/onSeqCSH+XI41VzNFGag55c38nX7nKS9jn2fQON58Xcrg9e6eWBLCE3vjEuzyJXX3ZIJQn+kOsLHpa0jYbpq54FCAX3ch/EKHkr0D2BDQv2s4RZaziwfOvtXny8Pv9DLld3syaxCo/4wS15KlCEAGDJ3AI+qK3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19; Thu, 21 Dec
 2023 21:34:39 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 21:34:39 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v22 07/20] nvme-tcp: RX DDGST offload
Date: Thu, 21 Dec 2023 21:33:45 +0000
Message-Id: <20231221213358.105704-8-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221213358.105704-1-aaptel@nvidia.com>
References: <20231221213358.105704-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::31) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b988af1-2fd9-4759-2af6-08dc026ca2db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QC9UBEn/5MtKsbUAuzXChh9KOfIPOTU6aDDIKHLewI7YlK0tzrkuGZlke3tSsu3ENvv/zgr2egXx3tsPwNiUKK6FUFiMeBr5pHYunVAAwuzLsCFAfdKc9jlCS0ZytHUwn7d7U3bSSNoyDGHHwLkUezWbkFPJiuk5Xu7oKiYUKXMER5nL4umA/iiNOXLPgIV+wX8+d/rXpfBv64rvwWHdjIAzlOMIrSSicApzTHUHV2AoTfru9rtOh/cRuXc4BvUJZuhuwxJ7uSJ1pxmBeNnxdEfl6q1YjquHDclmGz7giAc9wZ8vSLWWvT4i3VlgwUxBPF9/6UrRXIix8oS1zVYfv2XkA9QokTTzZkx/vHdKlOfawdpGPDTgTJhtCM55DK2mKtpYdPit72Dzjl2YjhQTS/5Z05O0UtsTYz9FMO3dMxxbqLx9mu+X0sqJOwYGAhw0aV+FbkcEp3h/w1KP8vEdQ0CnVxkf9GugdGyOjIlhxG91nvo/SXgP3juCvVGDAr1WgNBnGlh4N+lVZtvJ0qGOPk0mbD5fDS6h+3zU+pr+bhtis00/utLS59pkhRYhTLNYNNfWLeOMPYYCxu2n+ea+hH7g5+EkNJoKzpRSyYtoxNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66946007)(8676002)(8936002)(66556008)(478600001)(66476007)(83380400001)(316002)(6666004)(7416002)(4326008)(6506007)(6512007)(6486002)(2906002)(2616005)(107886003)(26005)(1076003)(41300700001)(36756003)(5660300002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VO1rTYwcWJiG7hByMXRMJ1hKv+ZW7ATUvOB7zJ5HfSrhTowaXrc2+N+6U671?=
 =?us-ascii?Q?BLALih71gQ69xlD/6tT6eINYvnT1OP2aO99HFT62N1ruJy8P6cqcWcsGwQOA?=
 =?us-ascii?Q?vuO4RQ3zdtXQiwr8//8bsPwnfh2W3aOS2C/QWpvT62axQRCTZyCGfYQRuUVw?=
 =?us-ascii?Q?Lb80uXdnXcPiZurDYP9yA2ljos4+14z3b8/c+BqSXkWSkbaB7lPOieS/aWl9?=
 =?us-ascii?Q?pUvv2z88MkCOaxHCQc+7/3UKUktzQ4/3TxPui4D69kyR32V5cqzi6DWfaT1J?=
 =?us-ascii?Q?henysU9MLODPHWIJSCVzWi2uZluzx5P6qPQwJsyqN1Gov7VUlqaeq7wjuVdX?=
 =?us-ascii?Q?SrvsEZ45Jdli7pcUfM+AyLHKhDUwty2ltv0aN4oKjUWv1bvPYsfG8O/f91X0?=
 =?us-ascii?Q?HFFnRSaGjX2J32EYveTi9CA8obej24xs/Ap+woxl9JlJ8zcC/mPJNuEdVLnC?=
 =?us-ascii?Q?k65o5b8GPGp55/WogcgF5tgMItX5FQ60RWRI90wZMOKla0kflfB6Z2zfhHxO?=
 =?us-ascii?Q?MvzrIue20Gf7wc4xMUSUmz2NpKwkk4IK53bfkcYTke74cyWb7QzOyk0dbmf2?=
 =?us-ascii?Q?AG5JTBmnqGRCx2INgg9yQBCVFKwZH+PxSiCEQNabiJZqv2hNr0cBxrtFAMql?=
 =?us-ascii?Q?Hpd0V5lfZgVzrUvb+hei6TWwx/Oy5blAGxnmZboIHBoL1I7FSNBF3vILyLEl?=
 =?us-ascii?Q?9a4fmlWbykr+Z2CVl5DJ6D5Y6sgK9zuvkhhJKsZw8eDvLPkO+JJsc54JcJGM?=
 =?us-ascii?Q?FZKgCTwaH5tt3w9ZshIFyg0WrXmy3VVgOS/yxFTegEqU/9Vkj3oudeE5dn5K?=
 =?us-ascii?Q?mHvBAX94x3yH5MD2MFbn5AhEAfcZNMAnPk9znJzMTuyCdQIEwoeQP5oICrUa?=
 =?us-ascii?Q?MBHVQhHTexSIdGvknAM1XSutPQHI1J93UQk2bMikgidfedk9akkthSp0mdvX?=
 =?us-ascii?Q?MNVS9995jCiUsOIMQJQgV0YJ4NRa8LfCoJd8eBFLSeeiDCCkPUW9MrDicplr?=
 =?us-ascii?Q?A0W27dTt1oWegP1Y+8fdBDh8wgdZaejjG9KvxMv6+ZYgJWUfv5droMq+W9kC?=
 =?us-ascii?Q?KY36MV6s0gHINPQzRzw4bmj/mY7CSyUYtBwOl+rA+D/M13C87ZvqCyqHYEnM?=
 =?us-ascii?Q?a5QyjKePnK2FLfrvgtkXkkiFANNumwKJSwem0wxPM435otJWX8L/6/2rloVN?=
 =?us-ascii?Q?JgOUD9yAPsicBKJ40BdyObHw/D1Cqcl+Rg1gBXWgcWXxVgl39J3z3UbLUABY?=
 =?us-ascii?Q?Vn7BNGD4Mm4VgkjlkJ3dC83FgAfy9Y0WvFIzbe3vTjzrJ2rXEyQVATikVu22?=
 =?us-ascii?Q?W5hgccS05ZzwTDK/l8MZmb4jEGkok1Zr5pbUKDqJn8X3fRJQgXA3CNvSIkJK?=
 =?us-ascii?Q?S7YkDfdjya9ZVDhkqPSPS8fbnV8zMgXGwdd30rCdSFhLaQ7051Iu24Uwmkok?=
 =?us-ascii?Q?ufjQOjxWS7941Rp5Yktn2tRsLXt6CSOzktlrBz4Lqo8ckGxqVr+MtGpxWqqG?=
 =?us-ascii?Q?sxrc3AyXzRC9JnYZONCK9wGnWmN62Zu2IFcRDKhsWQKpLcPjNLfnwisrpn0R?=
 =?us-ascii?Q?33UNR56inBWyoJBzwEci9pbeaRkROjtOQpd11v3q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b988af1-2fd9-4759-2af6-08dc026ca2db
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 21:34:39.3069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87t+zdniny7nArJm1hVmiFXLYDD+Z0JtglXE78++W7G1VlLHr7Qgr0/66jHYVuLRgJLQUE2ohdJSA7/OewrsZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_133444_851303_298FA781 
X-CRM114-Status: GOOD (  16.94  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Yoray Zack <yorayz@nvidia.com>

Enable rx side of DDGST offload when supported.

At the end of the capsule, check if all the skb bits are on, and if not
recalculate the DDGST in SW and check it.

Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/tcp.c | 80 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 420b8be309a4..6eed24b5f90c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -143,6 +143,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_OFF_DDP	= 3,
+	NVME_TCP_Q_OFF_DDGST_RX = 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -180,6 +181,7 @@ struct nvme_tcp_queue {
 	 *   is pending (ULP_DDP_RESYNC_PENDING).
 	 */
 	atomic64_t		resync_tcp_seq;
+	bool			ddp_ddgst_valid;
 #endif
 
 	/* send state */
@@ -379,6 +381,30 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 	return NULL;
 }
 
+static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
+{
+	return queue->ddp_ddgst_valid;
+}
+
+static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
+					     struct sk_buff *skb)
+{
+	if (queue->ddp_ddgst_valid)
+		queue->ddp_ddgst_valid = skb_is_ulp_crc(skb);
+}
+
+static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
+				      struct request *rq,
+				      __le32 *ddgst)
+{
+	struct nvme_tcp_request *req;
+
+	req = blk_mq_rq_to_pdu(rq);
+	ahash_request_set_crypt(hash, req->ddp.sg_table.sgl, (u8 *)ddgst,
+				req->data_len);
+	crypto_ahash_digest(hash);
+}
+
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
 static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
 static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
@@ -468,6 +494,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 		return ret;
 
 	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	if (queue->data_digest &&
+	    ulp_ddp_is_cap_active(queue->ctrl->ddp_netdev,
+				  ULP_DDP_CAP_NVME_TCP_DDGST_RX))
+		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 
 	return 0;
 }
@@ -475,6 +505,7 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {
 	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 	ulp_ddp_sk_del(queue->ctrl->ddp_netdev, queue->sock->sk);
 }
 
@@ -583,6 +614,20 @@ static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
 				     struct sk_buff *skb, unsigned int offset)
 {}
 
+static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
+{
+	return false;
+}
+
+static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
+					     struct sk_buff *skb)
+{}
+
+static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
+				      struct request *rq,
+				      __le32 *ddgst)
+{}
+
 #endif
 
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
@@ -843,6 +888,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->pdu_offset = 0;
 	queue->data_remaining = -1;
 	queue->ddgst_remaining = 0;
+#ifdef CONFIG_ULP_DDP
+	queue->ddp_ddgst_valid = true;
+#endif
 }
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
@@ -1108,6 +1156,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
+
 	while (true) {
 		int recv_len, ret;
 
@@ -1136,7 +1187,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		recv_len = min_t(size_t, recv_len,
 				iov_iter_count(&req->iter));
 
-		if (queue->data_digest)
+		if (queue->data_digest &&
+		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
 				&req->iter, recv_len, queue->rcv_hash);
 		else
@@ -1178,8 +1230,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	char *ddgst = (char *)&queue->recv_ddgst;
 	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
 	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
+	struct request *rq;
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
 	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
 	if (unlikely(ret))
 		return ret;
@@ -1190,9 +1245,25 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	if (queue->ddgst_remaining)
 		return 0;
 
+	rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
+			    pdu->command_id);
+
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags)) {
+		/*
+		 * If HW successfully offloaded the digest
+		 * verification, we can skip it
+		 */
+		if (nvme_tcp_ddp_ddgst_ok(queue))
+			goto out;
+		/*
+		 * Otherwise we have to recalculate and verify the
+		 * digest with the software-fallback
+		 */
+		nvme_tcp_ddp_ddgst_recalc(queue->rcv_hash, rq,
+					  &queue->exp_ddgst);
+	}
+
 	if (queue->recv_ddgst != queue->exp_ddgst) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 		req->status = cpu_to_le16(NVME_SC_DATA_XFER_ERROR);
@@ -1203,9 +1274,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 			le32_to_cpu(queue->exp_ddgst));
 	}
 
+out:
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 		nvme_tcp_end_request(rq, le16_to_cpu(req->status));
-- 
2.34.1


