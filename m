Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D191EB8FA5
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Sep 2023 11:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pRFyHG3Gcp/ozfzrx+Og4F6a0BDySVwR6/w9kq7T+Ug=; b=NhdVKkrUmfIxzXBIVGogX1M/66
	BSxWd2d3RTm6ip8ELpBfpDeG1eJYP/JHXeE/uQBWaJdDYbHSguHQDeIF34ydD6qhedWpbrQtRlMWR
	wsL7GXc/00v1+kVPdcPRiXPkayKHrTQ5OTeCl+/k7IGihsiz4gcOO+zq3H/zecRi9KIFuBI9VQxO6
	+kNmUqoK+KaKw7+cZOtoF24BxmXz+F/LnNnLflVHnHofjywPqkWbvcx2RbiDwm0xwsOMUkUegxdgP
	ph6SJFTawhzJdZovzBb3T+4j+ZmamKDNPOU8q9xr+zXBe1s0TztrNYWrJp7cwBU0TinhZrwQoG8pl
	mvuC88KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdqks-008mUv-0p;
	Wed, 06 Sep 2023 11:31:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdqkp-008mR8-0n
	for linux-nvme@bombadil.infradead.org;
	Wed, 06 Sep 2023 11:31:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=pRFyHG3Gcp/ozfzrx+Og4F6a0BDySVwR6/w9kq7T+Ug=; b=QMIyTsmTejsxTLh8XHLy0Ux3Jm
	McD+GoR5Ph2MBOV+xWeSeKcn0YrwM7HdSBSkmtP1r5MNNw2lAkYVLKjfO4NKQRfHttLYbft6j+Ij4
	YmRyDMXyh/CFZ62/KNWPze5uB7QcVSQWG+ch5MBO/uim9H/BmR84SdcZkI6dhQ+aoACpmQprq3fji
	0EsTv6WxT0qEt7A3Bx1QKTUS+IlatM6J3kkdE9FA0CtirOA29G7y/vuLDGJhIdtVJldyrMD3eHmv3
	ZDEVXrkP25TxjhZEzqflqfNK8F4dcfeR8DYGe2KPXSaPsjuALu5PvgDouL9x8oVsiOf5Cfzwo+GJ/
	ero1ZCOw==;
Received: from mail-dm6nam10on20626.outbound.protection.outlook.com ([2a01:111:f400:7e88::626] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdqkg-0014wI-2C
	for linux-nvme@lists.infradead.org;
	Wed, 06 Sep 2023 11:31:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJdkPWapc8zZ7PV4lesgLFu/CEcM/1WK19CDjgvf1c3ZZlR5kWrwjybazwgofSnDcvGQGTxALUSktrmv2zrqrXnVZoIopI+y8WMqWopg+T/vD3YCXd8CZ3/vyDYmya/QEiIJT4xCRo3uzyl59XTT0n4tsgc7YqxktlWqjiwRJ5a1iDikf2m8uqFOOiwYOVkiIoDgFU86MYtaOK2/OTX2KUbZJt9dFYHuXnspo76Z/bjgvsN6PCWt3hpUih098Q5W1N4lm5u3f8qFmwfAFsTR2EhRpo0d+kd26o/7UqhWHSaefDrsXOh02M2FfrT1GdZpJAVNyvU+AEYPzT2JLsgqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRFyHG3Gcp/ozfzrx+Og4F6a0BDySVwR6/w9kq7T+Ug=;
 b=X5usZNHdRaZ7MEP6sxik877lUwwcxD2XGgr3gImtP8iKDR/gZ+8Jo8V80vrGbI32VcB2z1JJWBGDDWzTdhAk6crm3lQepyFiyTv+BErpaaX6y2Ut6KHa73QqxwvOHGtPvYsA/1SmnoLT/87MiLdLKNbRUjpzQJp4XcTDu+eVe5rlRcIMQpL5G84Qoss/v5Yj4cTn9DOmI5gwQoGJ1A2piGrMTwCJOAUfl4JwEafrD3U7FEJvn+LwGyHGXw6wOz9LHCbU1EnlkaIAjJKZxeXm1SkoEYr27skUEV0ZUiuPRrLtuJI9GUMpwlwaH6T17o9gkfUaD6wy233Nlc0YUNweug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRFyHG3Gcp/ozfzrx+Og4F6a0BDySVwR6/w9kq7T+Ug=;
 b=oivTXEqR70zotthz8ZL/isHVqeZ5+RybkaPCGZcCI2spKJUMI9+yf3kLsniFZV68uRMpxrdkYkpdR4VdXh+LFMvAKMxVYbJ/5OWewciARD8KWW6w9nMxSbGsh9LxJvcIqXvueSybytYazG0jEkj6SdDcjYhM2M1Qu7c9LdBe0XZQbPLhFuPFp8OrOZTKaXFB0AbolCUSUQWNwei2HlisvjxelSjdwWuk8SpQ6z32O/P3Zco2T0HY1YNxnYPqC8T9208fP5vq4vng/CESWcF1keHz4QqDzMho5ayJOH5WJB2mUO4ENR9ObRpyqVRHilAN/UgzsKmWFXnMSYPHOGNC9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 11:31:12 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 11:31:11 +0000
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
Cc: Boris Pismenny <borisp@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v14 06/20] nvme-tcp: Add DDP data-path
Date: Wed,  6 Sep 2023 11:30:04 +0000
Message-Id: <20230906113018.2856-7-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906113018.2856-1-aaptel@nvidia.com>
References: <20230906113018.2856-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::19) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MN0PR12MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e255fd4-afaa-42bf-e251-08dbaeccc5c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LhcXFFzSsRLrpF9yve7DjdteVH6t2M0eWj2HdcNVXB8PyGGsF37qfj5K2tmJDhRnjksyohI0icvS1OMFf0KttXbCPgaHp13OTde/URn7pn2NP6XmZhYEQgEPvgp5qaqrc/EPR/WeL6Kisl5dC4VY/3LeJCoSxnPWzjdk/yfSf9ZgVRi5OeVD32jv4Fj7DO58e+U1upeBk9zW5vSoHJxpODDl4tT9UXvAWHo8G6bKN+GprcTXr4dodyQkvRU9q5SSDLHxOz2+BLcnxPm9/n1RZC+Q3c1oY+2PpMit/0o9ycIYteaAE6z0rM4jidfpc+nkaUzsF5LTAJkrN05oJkfjKWNQSJdoWvI8PzFSWK5K+Tv2hdTP8DbQVCAJ0JDzKReeE5tkwNL2JGvP0qIwe4YyGdeDa2ez/Fk26lfCTyqdD92M2adlbE9LnRBwGHnUH09zklob6eHxhVmWUM0m4u/y7mjZNLoS2t3Q+8u6G8f516LP01/xC5Hop+TL7qyPOUmnMyZcYyFuX9O0B0r19ScrMf5dNN2RKwBPTJir+bnf/OXX5hkXCV74kMxcs5HCN0C3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199024)(1800799009)(186009)(2616005)(1076003)(8936002)(66556008)(316002)(8676002)(66946007)(107886003)(66476007)(4326008)(6486002)(6506007)(6512007)(41300700001)(478600001)(7416002)(26005)(83380400001)(5660300002)(6666004)(2906002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gz/+mvoXQ3dnPmEtwxp11pIAkrBjpIyTU4nkQ9mj2ejiCMxt3eZFWfFP+ogN?=
 =?us-ascii?Q?64Neq7GJJPfQcVVJb/2Gab9uBOnzzH55arPIBFXf4NizU0mLhLSZQEHkz5ak?=
 =?us-ascii?Q?k19v1mhmiNpbvVcHVxLBCefqhqAsmi74ejJI6q8b3n4afmZ/YMATIecJltHk?=
 =?us-ascii?Q?ZAj7EuB7sWoOidfeRFwftRWkqZIlgN+qRomlzqAG49T1eKyfRczI8nMvwhGa?=
 =?us-ascii?Q?Geq8//4PVR2FXNZcYMih8Du9jrPsLLOxbxYP9ZXO+N+10B9Fux//R8uqjP6d?=
 =?us-ascii?Q?1hHamjZ2y7D45cwkk70LHQdC3yvsxgY/6V1hleuPY73aLLUHgxhcVSsigpVh?=
 =?us-ascii?Q?mHcpQXHgpuLyLG7vLPAMMUrdRdkIQ91ZDifrntSzLLpV+W1fYmGCsA6P5po7?=
 =?us-ascii?Q?tgk8k89f2xT1a5izA4WRuKmNoXbV/fXY8nvZ/BnzGfsmcbh65o9OdgcUg2iX?=
 =?us-ascii?Q?Fn65FN+WF7L+/d5sh0wmUujjQ/Ri63D50kwdUnv/Q93+ThdNpejdBka6XSdw?=
 =?us-ascii?Q?DwwT/KpWjNE4cga1OYPXamP39ubS5H55eZfOEU8OUnbxaWkHJDbvlxGsbNE3?=
 =?us-ascii?Q?jl5Soh7kkXx+78uEZ1ueMAlXtoWSQgV0Xq1cxXP4zi8c35dPg9JCPnfa2qBq?=
 =?us-ascii?Q?sqUpc/RH/TGLYrT2aRyeooBLJPi7jzQnvjfORpdyqOF1QjuuZoPsa56xMtU+?=
 =?us-ascii?Q?SgRI8gn5iuN0CCj7s8oNGg914VT9ctKBxYaqg6TCkUSJ52/kZk/ffyGbD7z/?=
 =?us-ascii?Q?4IDZgaXpg94yhnOesOnuVSIIAN22JuBYxEfEOCQ8k9AjnkNwFTy+7V4pmshO?=
 =?us-ascii?Q?eKAtKP/ykoxKkH7sD94AMoF1tzJDTRZ58at6I8U7ohowVB6HXuVFtrtHtrgD?=
 =?us-ascii?Q?qPyjr9D1f0XYC/cl9lNDleIsbOGhA5IBrAfi//aG8BujsE9br1WJ5jR/5vNV?=
 =?us-ascii?Q?qOohHbDoTcf2uOjuPUYfkr0NsSamLeG11gHr1GW9z2PJUitadeYVXwXyUMjI?=
 =?us-ascii?Q?QJIDfeHj9pn2fJfsbnHrGrNYny3PCPyLPRhSF9i8gt/wab2AYsB9+nfnqc+H?=
 =?us-ascii?Q?D7Yx/emOptViPooyrIykaEkWVs8mpLZVNwIo8ZXtejklKhkTQR2H29fvIye5?=
 =?us-ascii?Q?qlT5ILwfzwexIVLRZeJnS5pqHC//vStum1sb+SNjAuBx+GDR3bDjmPxGcbee?=
 =?us-ascii?Q?J4T69PPJ+7+De0rGLeBYz8CBhjh3d/qgN7Omc8BNAcxVS/6oQgpOACmPkImo?=
 =?us-ascii?Q?3LhqcWu4IUA8Tcmrn8hvaGkcqDsLdREtAm1YlL2I5aGcnfS9TcSL6EimrjPN?=
 =?us-ascii?Q?ngQ5xkhz9YbN6p4pugxjV5ij9J4QJUO5llol71vagccWfhmONKcHVDNFS0sm?=
 =?us-ascii?Q?/8eKO1sv8VoEyrHH7eEuvkWvDlW3mBi31NV7mpzdN9UdPbY36j54+DYa0r0y?=
 =?us-ascii?Q?O2qoTjiq+1TCG6lH196poaACJg1h2EiaOh2ypzZgTi4KqZOkqKoo9RszMgs0?=
 =?us-ascii?Q?yuCJtg0dsKeWbO6KlEDlT8/YotqhgqDV8c4QK/ywNy1ukb9EnLZ07h9THs+x?=
 =?us-ascii?Q?AObR4oe8xKyEEAyRRT76aspOsBN1vSouOHftNjnE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e255fd4-afaa-42bf-e251-08dbaeccc5c1
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:31:11.8952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VipJIt2SC8s0Y4Zf4oo0oRr1MbxsRba9kbmvJCtXmr9Yx7NkbCu2d+3oHXDed1XANhC9W0kvgtSsI5oeYweWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_123120_689190_91B60433 
X-CRM114-Status: GOOD (  18.10  )
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

From: Boris Pismenny <borisp@nvidia.com>

Introduce the NVMe-TCP DDP data-path offload.
Using this interface, the NIC hardware will scatter TCP payload directly
to the BIO pages according to the command_id in the PDU.
To maintain the correctness of the network stack, the driver is expected
to construct SKBs that point to the BIO pages.

The data-path interface contains two routines: setup/teardown.
The setup provides the mapping from command_id to the request buffers,
while the teardown removes this mapping.

For efficiency, we introduce an asynchronous nvme completion, which is
split between NVMe-TCP and the NIC driver as follows:
NVMe-TCP performs the specific completion, while NIC driver performs the
generic mq_blk completion.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/tcp.c | 111 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 106 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index f8322a07e27e..48bc8afe272d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -112,6 +112,13 @@ struct nvme_tcp_request {
 	size_t			offset;
 	size_t			data_sent;
 	enum nvme_tcp_send_state state;
+
+#ifdef CONFIG_ULP_DDP
+	bool			offloaded;
+	struct ulp_ddp_io	ddp;
+	__le16			ddp_status;
+	union nvme_result	result;
+#endif
 };
 
 enum nvme_tcp_queue_flags {
@@ -319,10 +326,72 @@ static bool nvme_tcp_ddp_query_limits(struct nvme_tcp_ctrl *ctrl)
 }
 
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
+static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
 static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
 	.resync_request		= nvme_tcp_resync_request,
+	.ddp_teardown_done	= nvme_tcp_ddp_teardown_done,
 };
 
+static void nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
+				  struct request *rq)
+{
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	ulp_ddp_teardown(netdev, queue->sock->sk, &req->ddp, rq);
+	sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+}
+
+static void nvme_tcp_ddp_teardown_done(void *ddp_ctx)
+{
+	struct request *rq = ddp_ctx;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (!nvme_try_complete_req(rq, req->ddp_status, req->result))
+		nvme_complete_rq(rq);
+}
+
+static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			       struct request *rq)
+{
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	int ret;
+
+	if (rq_data_dir(rq) != READ ||
+	    queue->ctrl->ddp_threshold > blk_rq_payload_bytes(rq))
+		return;
+
+	/*
+	 * DDP offload is best-effort, errors are ignored.
+	 */
+
+	req->ddp.command_id = nvme_cid(rq);
+	req->ddp.sg_table.sgl = req->ddp.first_sgl;
+	ret = sg_alloc_table_chained(&req->ddp.sg_table,
+				     blk_rq_nr_phys_segments(rq),
+				     req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
+	if (ret)
+		goto err;
+	req->ddp.nents = blk_rq_map_sg(rq->q, rq, req->ddp.sg_table.sgl);
+
+	ret = ulp_ddp_setup(netdev, queue->sock->sk, &req->ddp);
+	if (ret) {
+		sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+		goto err;
+	}
+
+	/* if successful, sg table is freed in nvme_tcp_teardown_ddp() */
+	req->offloaded = true;
+
+	return;
+err:
+	WARN_ONCE(ret, "ddp setup failed (queue 0x%x, cid 0x%x, ret=%d)",
+		  nvme_tcp_queue_id(queue),
+		  nvme_cid(rq),
+		  ret);
+}
+
 static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 {
 	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
@@ -427,6 +496,10 @@ static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
 
 #else
 
+static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			       struct request *rq)
+{}
+
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {}
 
@@ -705,6 +778,26 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
+static void nvme_tcp_complete_request(struct request *rq,
+				      __le16 status,
+				      union nvme_result result,
+				      __u16 command_id)
+{
+#ifdef CONFIG_ULP_DDP
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (req->offloaded) {
+		req->ddp_status = status;
+		req->result = result;
+		nvme_tcp_teardown_ddp(req->queue, rq);
+		return;
+	}
+#endif
+
+	if (!nvme_try_complete_req(rq, status, result))
+		nvme_complete_rq(rq);
+}
+
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
@@ -724,10 +817,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))
 		req->status = cqe->status;
 
-	if (!nvme_try_complete_req(rq, req->status, cqe->result))
-		nvme_complete_rq(rq);
+	nvme_tcp_complete_request(rq, req->status, cqe->result,
+				  cqe->command_id);
 	queue->nr_cqe++;
-
 	return 0;
 }
 
@@ -925,10 +1017,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
 static inline void nvme_tcp_end_request(struct request *rq, u16 status)
 {
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_tcp_queue *queue = req->queue;
+	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
 	union nvme_result res = {};
 
-	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
-		nvme_complete_rq(rq);
+	nvme_tcp_complete_request(rq, cpu_to_le16(status << 1), res,
+				  pdu->command_id);
 }
 
 static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
@@ -1235,6 +1330,9 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	else
 		msg.msg_flags |= MSG_EOR;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_setup_ddp(queue, blk_mq_rq_from_pdu(req));
+
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
@@ -2541,6 +2639,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_ULP_DDP
+	req->offloaded = false;
+#endif
 	req->state = NVME_TCP_SEND_CMD_PDU;
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
-- 
2.34.1


