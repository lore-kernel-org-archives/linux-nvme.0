Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6609C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 10:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CVywwnKh4nDbAmUopXMFH0UMdAdtl2n6pqq8wyWFSsk=; b=kRJ3N5QuLptZ40s4mN4Ch1Jhxv
	wCwKcl3egILOUWs7dLgMIZh8zTGxxLRdJKl2QdigtmFmMYNBPei1C3stB0Q/OlMtKNUc9C2eUfaBM
	7SpEeIXBZ+LnsewBrX0sjSoqjvMlo57jhv5ffNPAaB0x2OU8DlJurS7HK6oeSpONAqcprctys32Pz
	Nsx1XQe5Al8U3l5vuEjvvTG0WjcfFs754YsDHJEUE8eew0xiA1xx/FMfalb0V7kauefnk2ALI90Fp
	oOzasgiXQ52o3As+vtlxAUGU82zt+uY00lD6pJ731ot8z/UbYpyvyXZNUdgWq2bRA/kPELzptXytT
	tXnbl6+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olT4e-00DkBO-Nt; Thu, 20 Oct 2022 10:46:52 +0000
Received: from mail-co1nam11on2065.outbound.protection.outlook.com ([40.107.220.65] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olSeM-00DTED-B2
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 10:19:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uy772JO2UJ2K1/h2IQJedpGYNVywK1bBV7XnGeemUh2AUjQVshW6UMzDUAYoakRtJrUdMZAoAYPkYP58isLsuxroL2i4I2x4Ah6n0F7TArVQcfPwVbfjHPZe6YaBhspwK103hgRmSKcrt/8p0D8WRDa8jLQ2IMBo+sQekodqyesgKsQeTLzz4WKFDAx8SUApKPjc8/sys04FmovMKYF6OzLi0jMeapPWI5k2PB7cszD3DbtltDVPcvq6PxzeWgud/pyKH5Zunoxebbhx0zEcaseElqDl1mPFLq8nk458xuZlU8aVps/mEbwynocsOq73BvK2nJ7THoYBofiFdg1hDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVywwnKh4nDbAmUopXMFH0UMdAdtl2n6pqq8wyWFSsk=;
 b=YuIBQq8rKGC6qQwPwd5dSCZKXPcP4N66LK0SHuUVL1alYPu0u1c96Keiy/bUSo2PRePNltoIIzhVccGFWpQyPyLRPymqTr2WZjghRU9DrkOOZtwQDGcUw14kr7Nomnvu45yVsZ6UnJ90+kAjeInCAMaTVZ4x9CuM6BqwXBksusCBjHywO/kJHva7E7N5fGVvwhmGBGchhTxVud3uJUxb6SI8qZ/I52mHH7uLuYCL7RblOQ9Ew3zRb6lawjZy3K3jzthvDh6OtmFzYSLF+/CrAf/x1Mk5ljy5Szez7fncuyGx/UKQB6tUWFdSN3EMsBxu32AusLu68NbHrgDFj79MxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVywwnKh4nDbAmUopXMFH0UMdAdtl2n6pqq8wyWFSsk=;
 b=uRdDV2Qga/3Aq4HGlUrfV1lmrvwP1GRVLCT+6N83pqWRmp3cumSsV/O3aPIO5a3aQAEP7Bn14eztbbppBtQU/aHFxiT3Gx5qQyKBPqu6/vyOyEvDVvhm8R45i1oLA4hueR4/uMtkEZxyaoB6xk0nhHxFQArnYZvqIeDmogUK8ziJenZvF0JEuegQ8xAgeO2JJRlSOtLBcojirPnHtyhg7dmrBpUlS0sa0TIxphVnPz7uY1CY4ZI0rphhy6IbNTeOd1HwzZ5lwy66WvLlzr1OLHAINzOHlDpXj6swAWex5MJYD0h4PCOckT19FCPzGVytEFH8OPvNC5ky/mO6J/oVfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 10:19:38 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::b8be:60e9:7ad8:c088]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::b8be:60e9:7ad8:c088%3]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 10:19:38 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com
Cc: smalin@nvidia.com,
	aaptel@nvidia.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	aurelien.aptel@gmail.com,
	malin1024@gmail.com
Subject: [PATCH v6 09/23] nvme-tcp: Add ulp_offload modparam to control enablement of ULP offload
Date: Thu, 20 Oct 2022 13:18:24 +0300
Message-Id: <20221020101838.2712846-10-aaptel@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221020101838.2712846-1-aaptel@nvidia.com>
References: <20221020101838.2712846-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::33) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a80715-6d81-4037-e0d2-08dab28497cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	vTZ/ajiO1aY1+dSvynCSrrCnkehs+6O2jm/+ExXm3aUJTJmTV5AK7GnTxVF2okY0xF3AhMtNwXNj87pA8MFIBic7UPmFqqGIGKJ/snbnJ80RAaZwo1OrFZRVrQyq5eQ8+JjM+LLOi7XUke9PhRtpjKMaFlRAKPytz5txlx0GezRgbvuQx5Ucv75D78Ddv1h5pWPYc2vPsUwFgza52PJ/9SgulYwpdeEGtURE0c3xMNbrpges5tSH/q8o7fsQCAveDwr7Djn9a3mIj6E2/0Yjx+U/lP30sRl6gj20Q4K4fZGcTF/SrzgAMHP5K7bEsKrjgOTOIf6znx/2ddZwHClZhT/pElxUupdRKfNlHMaMH1kLr5wVHyiVL5T7ysc/K5QpxKAHwxqvBtojGuDBzKpBUu1pUZH5pphFRxQK+sBEXoJNSwt/1uK+Cb1FmkEV2pW2wp5KNqd9bTDiQRndxljGcoy6Ig/C8Z7cw26UK5athhdamuVs9vy16HiPh6WeNddM9nmzaYTIRz/qg6N301Ksuvi0uD58klG4MfqZ8+md0uVARWsw4sab/mqgWgmTgbVrWDLsb3pOzEJ92Ny2wjGIxi3PrbHYpBdr0VCsOPpSWmSB6xVjIcQesZQKw10RcSeg4GIPgnU7cSVZcrYXUHP3N8fWPxGcEQLm9EIZYvgy2mlwWNgDBiB4UyyvICZGTET5PkWed+lKXT27ViPYY3xdYKTjk6UK4ekfLOztGI6Gt5bETGLNLPcy0QP+uLYaGHuo
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(6506007)(6512007)(26005)(4326008)(86362001)(2906002)(921005)(8936002)(7416002)(5660300002)(36756003)(41300700001)(66476007)(8676002)(66556008)(38100700002)(83380400001)(66946007)(316002)(6486002)(6636002)(186003)(2616005)(1076003)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?N1DM2U/wzaPSHUh3kRYA8UwcbYkK4UjeI8PYGvp77V4D4AXpR0tCayCN3G5g?=
 =?us-ascii?Q?3V1bJsgnVqNHpLQnkAsEARcros1AJeupuzaRopWWE//nVfQd4SGPiVH6HNsU?=
 =?us-ascii?Q?SFbfaWAdBzZEpVdHE4Wj2QHazCWZosaYR7AZ2Mz+QEFGlh6XEkV+pXQhr4XP?=
 =?us-ascii?Q?bLkjpIQam6Vse4AzcPvibkrcXoCVeolZ85M38uu+RTV9Ot6v13AUjteojI4z?=
 =?us-ascii?Q?xhxEgXUY2EY/gIYBXxge/hjGT/6jRfp5Xuq29R2mg0SL0CdPCDsoj89Kx8Xi?=
 =?us-ascii?Q?SVZyLRCW3ckDsovCwlurXnEFNIGM5G/VdaNWYEIfiS7J7fF3oOykNzi8BIAu?=
 =?us-ascii?Q?ucJK+sF1DaLFXTX9VKp03d6kD4OgALKJDgWQidC0Jxg9UM+/CxIL8n+fpeEW?=
 =?us-ascii?Q?195ZQcsA/KxPan7mA5iQkIbAecPb1z4pM5gJVzFDo8PTwqkajjY8w1CNUM8s?=
 =?us-ascii?Q?xUVqh3XmWGXr6+QD3hAd2/f35JyYjO+y2HtsatRZ1krGZ3Q0529vzav8lkJW?=
 =?us-ascii?Q?AYOdR4DS44Iyhz3HV/SOHgXiN3kqhvtlU6OLfymkXP8NziDNY1Vk0C8NoS/+?=
 =?us-ascii?Q?lkgsj2SJav1NEE5diUXEf1sLCM8WexxYDumOFq/NoYtM2cJ+L8YAaJ+QsFiL?=
 =?us-ascii?Q?/XtX4jaRPGQaXzpssK3ocYZP1BNRlfjae7pMY6rTZzVEBqGbbyxHiHVrVVku?=
 =?us-ascii?Q?/YPY9p0IbMwl6MY+5yNJk4cjptdkwrJbTDdP7BgiiXo875G+Q6CI1Leg+uTu?=
 =?us-ascii?Q?iShq+lx9JnJkYeUjH4VpoT8cfo6/4Tq5h5w1Ym24h2XJ0xDAbm58fymhd3kC?=
 =?us-ascii?Q?aFB/svPRtL7SE348/KUY9osWPX/qawFRaexwjlp9zBFxKAyFcwrZ/kpSI2lF?=
 =?us-ascii?Q?YOwXHdFLQs2l8oLnt+6sP9Gyoh2ZTb2U51R51GAu1u2Ay6MUJEXXBmUGs5Q8?=
 =?us-ascii?Q?TlIrAouKsQqvXSdcPsfOlS+3ikuVK/Wlnkyc615t8IWa82urkxZleQYAi5zj?=
 =?us-ascii?Q?rEaoGKIxNqFQDPiaeu1pAKDgHfC/f/CGJEKQXM6UXWCUcEOOdfsuMDwmcGuu?=
 =?us-ascii?Q?qOOFq82GHH4/6DBUG0ZL0bZZRPieJ1bALQh82+xIhzcURCexboGL1xNCfwoa?=
 =?us-ascii?Q?pLiZ60+tRE3Wt1gi6r6PLu/t9WHgSq+hbPuB0L/MliOk6PKUHrhi/ki0clUz?=
 =?us-ascii?Q?QRAWte/6tM52OBFCDp0CMqOOgf+jP6pLWHpEfOBhcZUlyw8HHZ15gmKDVjru?=
 =?us-ascii?Q?2/+nGpG9FyCqo+bl+5u/skdxxNRTXwAW3tCBNJ8GNXTnu3CQ/mQzzPBtUEE2?=
 =?us-ascii?Q?nOQB2qslDR2JLZYx5ieSjbazfsPbAIxZjyt8HhmpGWJanQPe9OO8fxNQaB1k?=
 =?us-ascii?Q?bioTNVazAynpJsaBAwTfqp9gmKPPnAa36f+dqhBg0tJoP2AtS4M9LLeW37Su?=
 =?us-ascii?Q?ouo2Tvztkd4UyUqiaAG0PwpEKD2boPiuGraUOSIeDJmq2IHiAysVar/ghuG3?=
 =?us-ascii?Q?4Eg9uvWhZLk7k1Eh9yq8Z8OAzd5h4bG+p9TZynA5tpRr1MNAt8evxZ8dtjRF?=
 =?us-ascii?Q?EQO7+T323NOGR4LQu2yLM5650YRvrkCiUQZPSVLZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a80715-6d81-4037-e0d2-08dab28497cc
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 10:19:38.0591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ceAuqbVyWySiJyFgwifoX8nTGJpqoemyGZGB8wcc6xhljptuiX37lv0iwIlrKh6xMpZUO+G+99Gyk46aDlmGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_031942_499576_FFE2B7DC 
X-CRM114-Status: GOOD (  11.97  )
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

Add ulp_offload module parameter to the nvme-tcp module to control
ULP offload at the NVMe-TCP layer.

Turn ULP offload off be default, regardless of the NIC driver support.

In summary, to enable ULP offload:
- nvme-tcp modparam must be set to 1
- the NIC driver must set
  - NETIF_F_HW_ULP_DDP flag in netdev->features
  - ULP_DDP_C_NVME_TCP and/or ULP_DDP_C_NVME_TCP_DDGST_RX
    flags in ulp_limits->offload_capabilities

Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 drivers/nvme/host/tcp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 11d9197f59ab..7ee14b8a392e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -34,6 +34,17 @@ static int so_priority;
 module_param(so_priority, int, 0644);
 MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
 
+#ifdef CONFIG_ULP_DDP
+/* NVMeTCP direct data placement and data digest offload will not
+ * happen if this parameter false (default), regardless of what the
+ * underlying netdev capabilities are.
+ */
+static bool ulp_offload;
+module_param(ulp_offload, bool, 0644);
+MODULE_PARM_DESC(ulp_offload, "Enable or disable NVMeTCP ULP support");
+#endif
+
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /* lockdep can detect a circular dependency of the form
  *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
@@ -298,6 +309,9 @@ static bool nvme_tcp_ddp_query_limits(struct net_device *netdev,
 {
 	int ret;
 
+	if (!ulp_offload)
+		return false;
+
 	if (!netdev || !(netdev->features & NETIF_F_HW_ULP_DDP) ||
 	    !netdev->ulp_ddp_ops || !netdev->ulp_ddp_ops->ulp_ddp_limits)
 		return false;
@@ -497,6 +511,9 @@ static int nvme_tcp_offload_limits(struct nvme_tcp_queue *queue, struct net_devi
 {
 	struct nvme_tcp_ddp_limits limits = {{ULP_DDP_NVME}};
 
+	if (!ulp_offload)
+		return 0;
+
 	if (!nvme_tcp_ddp_query_limits(netdev, &limits)) {
 		queue->ctrl->offloading_netdev = NULL;
 		return -EOPNOTSUPP;
-- 
2.31.1


