Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914C8C43219
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OtWrGoPE+pUUamZzeq037iBu5jV3fDWwrfAybGRJkvQ=; b=Tl2uLDfr07HyO7AmZP2hSf9hmx
	lyAReTaqQ/yJPTKLNQASRPwYsRJhEAelOOU8wFta6mxPb2Dcm/dgXWAZXXiPtFRHbNuKOLlk6oEKH
	PyXdqi1nfdXx0/7LO8mQePxhHyMJFmELtk079tOkBDkV0zDpTnBNHDGxkitt7yc5maq0KsFdrGrKp
	81D3SV6A3WgfDPD/xf4OhkvQHRvQedT6lJzJqkDruyBwH+gBMIG5CUBFinDlA7U9AXf5oZxplBMsS
	f50kaJ+VHiePWdpxMVGfid95tlWxwqcc68LRS6Vn8JcCUXQz7uxxNuonJ7vOb08fiaYZ7D/F10BNU
	EgsRL4QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olSxj-00DfWu-Vs; Thu, 20 Oct 2022 10:39:44 +0000
Received: from mail-dm6nam11on2069.outbound.protection.outlook.com ([40.107.223.69] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olSdt-00DSv4-7F
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 10:19:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WL8s3FENBuTzZwv+L+H+IaaPvJqgNT1I831bRGKcH1lfe5ZkkUCY8Z8nwf0MaBrjJKGuIPLzU+NtWkNIAcF+RphtvIGL3H7Yo2acLMYhU/gNUe5r1sRD0cf4f7rhIpiP63ger9Asg99zXv7hj+MJWuWyHAjvfzT64y+d8Jt5F0Iu3k0RVskQcUljyem6nd5C5SNNwrF/bJ8CvTGIaYqZOZPh0hZ5eSYOGZ1Zd+fE8urY95xIF0OzKkTCJKHI6TITjur5p/71uKDWJfqoKXNZQWuRr4i3LIpXks+Kce/suhDf8PgVjiWLsyNR2JHJtjXRBpfQzOUUt0iCEwoF5oOBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtWrGoPE+pUUamZzeq037iBu5jV3fDWwrfAybGRJkvQ=;
 b=I3QdoVGeTe0+Aehv1wi2alYARB9vjfg/tLVNmJ2XyiNkVoCNL+HYcXaC7mKWjpt5M0NEZ5GFrv6hUt+W2L5AYMlXS5O7gKA16gXKRnc1JHfYFhTb+77jc9kHwXEGUN3XDlZ+DMER2CO9592A7BTuHDGp2TP6eBviPJ5zphcp8NtJzgx130SRUiQEgL9h37tgMgj1mbcvMN5HOeKDyhlrw/8UhwZ0WIrJ4mhAC+clVHbtK4B3h2yIjMX4OsssqJlgeTZr1lia9vsU438M85hf8A37u8NUPphtrWHIP4xjuvxzCJFbtsFVyjKx0wovFewrScEmSstidc4f8WC+6JVFqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtWrGoPE+pUUamZzeq037iBu5jV3fDWwrfAybGRJkvQ=;
 b=h+tAwEoImkimZC4BNmUkVA9/Agym6FGAmFkodl+6gQu66TwYleqV1t35WTNO1hgbS3pzyMgFqHi8XrTmOk1zkACWFOntFdy7UZNrQmfDDwJM7gKjgTe5c8REnVxLOtCYPkvEQaw3fpWPHWYkvL8+NcLxdwemMpYByK5zbmXHjwB1Xow9DlDA0kUj7Gy97ZDr4hLCi44tYJv6LO1vIYnmMOdrYN4CCYHV4qbwppOdY/iaV1lmPZf0sJD8QlP+NYUl4MsL1pe1eJvBWcQBy0KX4PoYOM5m3afN4kQx7RvZi/u+zmGYfHQLFdNfHUY9heDoV7w4RevrL36TKmHO0KqnWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 10:19:08 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::b8be:60e9:7ad8:c088]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::b8be:60e9:7ad8:c088%3]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 10:19:08 +0000
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
Subject: [PATCH v6 04/23] Revert "nvme-tcp: remove the unused queue_size member in nvme_tcp_queue"
Date: Thu, 20 Oct 2022 13:18:19 +0300
Message-Id: <20221020101838.2712846-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221020101838.2712846-1-aaptel@nvidia.com>
References: <20221020101838.2712846-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0289.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::6) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d096d1-0244-4426-22a2-08dab2848665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	gTWHLwlXRyrvc4jvgMbVn0lVMvBrO3nCeVDufn7B36xtkFpMEoTA13FB1Vvitsdfsy3Baxuv70NcfJIBEGNKR6qRPIu/UYW4dPOxmKFK5pNQJOrQCIGuPLSg5SLdtCVc+4FzTaakjy0j1QHCdFKiLgCCuFZTHbBzxn3b8Jf7ym0ZeMI2y4AYCdIhbCYWfBg+DeJuqDj3ADFEyokgK5sX3y7WyFOui7Oc8uFePUbU0kkFDahUNnMtILssFbii/rCETn3ccLzeyIR2BB1UdlxIxF/DyJKnvIv6Z4fmSR+w0uVcvIfhqKs1ZQfg4pn9PIDFuKY6PeuOV+X4W2Jm3lNAg8x2E/FJSTzPJVGn10wytQjIWKqnJk/xSvYzK5BGJ09IwbR5Q3OJrym+PKtyGP8UgfgBQlrnoEqvxszlExpp+Rz/2BQViwCl8rm/8hokwJxjYz/Kp+sx8sSaPM8neL2Q10l8ssOqQV+Z3bYx52YhD1nocosev6vcAPqrYlDJS3Dv5NZY7clnFPLB4zklW3zYTKNcNrHLhBoS9WSJsq5C87u+GWcdYJdRSFWQwDPYHERtHNFw0RTgCvxvAawmyM/0bcUbN/MF7GOkjM+HMPYqvLJmagpSI1Ik5F0znJ535h+eisx+SksI5NAjG9w9WNjNs0ErtUtICie1L1xHxMrZI5rk1Cioot76gWuZXLJPEtMeqoF0PLYZ0ENPxRX28ah5p0b7dAjx9Ni4btxCr64wmHHK7FmCqkflJtrwOqYvKRja
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199015)(921005)(6486002)(38100700002)(478600001)(6506007)(36756003)(2616005)(4326008)(6636002)(86362001)(316002)(66946007)(66556008)(8676002)(6666004)(186003)(66476007)(5660300002)(1076003)(6512007)(26005)(2906002)(8936002)(7416002)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?r5fMxHJaE6lV1W9MpXMC0qbOs5WQBX8/ghPL0tVbVOgBbBU1xDQ1az910Ku9?=
 =?us-ascii?Q?/M+9ztG/RAj9/kZll8WAPll0G35Z7OJnUYHplu0uGDKB3oddws/+phC6wTDn?=
 =?us-ascii?Q?scKc2vK54AxJW4wkm+cpntTf2g/vej3K2QboAtUNUzBlI9gBLd1gyqo892HF?=
 =?us-ascii?Q?MAFwtmzLD6ghZEGj4zB8PK0lUNPYPfBg5ncdGr7nzTWrhz0LuDmJ4Nr4WISs?=
 =?us-ascii?Q?crAV+y7PriFs6y0wuABxq5qxW6ON9NRnmJS9l/DN9a+KnrPRA6C1FH4XfITr?=
 =?us-ascii?Q?0r7s6z1C0XWLHj83kGytz3FDHCXHg7fx/Dnwts/GOAgYNOYBJYAnINCOvRjd?=
 =?us-ascii?Q?owZyOR3S4GJ5M6N6U7Nix9Dwp3my6jnRb56irOXX+BQYJuK/BCqXppOE9Zd7?=
 =?us-ascii?Q?gwGqIt+OtlkQ/0G/x4OmAnNhZcwSmybqZ3IdoN19xNo/W6v9ttZ6mBkIxmkg?=
 =?us-ascii?Q?L9ahUg29h72xcuGx5ygZSEntCF/wNZyf4defVN6nnnGeA4bOd1+w1Ew0HjsB?=
 =?us-ascii?Q?at3l7g7PCzmJ0lXiitGKb2QExdEEWNHL8XHKR6DofKuaA53A/ZWbH2RMoIRA?=
 =?us-ascii?Q?YPTSVcNa8gcVEgA7g5Go4xyah0lj+AfxQV8+k5so94G1pdg781U3SL9/Fw3W?=
 =?us-ascii?Q?oPHk2QPAb5Ho0tnIWChrYHOCvz0q+bTVCq+2nJmT5e88buWh9IDZYtYSxzcd?=
 =?us-ascii?Q?u19xghHfwAHxCRWFA3fIx9vWR/d1B8s3bOya9F1GhDX+XlxFEu0z6VroAOsx?=
 =?us-ascii?Q?jvkR7klEyMpGWbt2WoS43fEEMiO3iGHv7GaUPK/e8BZi8VTQ0wFbNIz/fq1V?=
 =?us-ascii?Q?7YU36vrRioXJSB4LI3oZSa8E9IL8DoZ8p0Sa37cXukJYMBcWfb1L5jv+Klpc?=
 =?us-ascii?Q?CvOxLw7G9P7PoVEsKpEKsdZ1XZIPBE16bdkXKyy6Vg7cYG3MQ/R8rfs3Brg1?=
 =?us-ascii?Q?x9kI1g1x80MrcQffvdGYx4rrI3QcXr8S/s+nKfZkPlQe4iRBV6pEh7SpMVyM?=
 =?us-ascii?Q?/Hsu6cCTiv2SCjtOvSTo3UVn91oZtdUdpEZtzgyhLqL1W68YNXF2FNqXk0t5?=
 =?us-ascii?Q?qRrwrRIWDXpzR7MM2y/bRkVCrDBtR3PfHWsszu+uylgAs9OoIb5TKXDWajlo?=
 =?us-ascii?Q?v7R3z4nHu7bJdMRdOwcW7uMKM4m6pbPVKh9CZLKGxldMiTMCE/YVUjK7syJt?=
 =?us-ascii?Q?1p+vAs+5g8qzkoER57IiCTFHpAGIfyFq2N+Enb21pJ5xlQ7lNDaWT8Bjc8pL?=
 =?us-ascii?Q?9V52mwDpQD2qUcR4s2A6z7JKqMIvKxYb+bzTEZeCyxth7KOPMjoAPu/wPubP?=
 =?us-ascii?Q?+Sik29VJvJ2RhG4hnCUmwEKS/98xbTzx0udNco05GZBl11B/qbtitN/IHkw+?=
 =?us-ascii?Q?oY7MjVN4T6Ic4TqKlPZ/B0klNkMnEpnyD+ssIb2M2NuLkurHhYejQU5VrC7P?=
 =?us-ascii?Q?kxwwDWmuFCNwuq9GWlcXTR+iYCf3y/7DDKED4sSQAtfH+Woq64YgPGgp2qNE?=
 =?us-ascii?Q?clsRLoIRCc2g7znkox0erbrebK3f6kai+XNShBosurMJ87IwxDkK6ciULIb7?=
 =?us-ascii?Q?dDvx8SQQHd+ouquCISqa+DRI7tVDnJeAnri2E9J6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d096d1-0244-4426-22a2-08dab2848665
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 10:19:08.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TM1sGCTU5R0GL+stY5uCU1hHH/1zJPPoGs1WgzPvrd8r/lZsNDxGOd16Ba3Tdi37qfojoHJdGI5CmRpELeR7ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_031913_310193_5B0CE0F8 
X-CRM114-Status: GOOD (  12.34  )
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

This reverts commit fb8745d040ef5b9080003325e56b91fefe1022bb.

The newly added NVMeTCP offload requires the field
nvme_tcp_queue->queue_size in the patch "nvme-tcp: Add DDP offload control path"
in nvme_tcp_offload_socket(). The queue size is part of struct ulp_ddp_config
parameters.

Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 drivers/nvme/host/tcp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 93e2e313fa70..10080cfd541b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -133,6 +133,7 @@ struct nvme_tcp_queue {
 	/* send state */
 	struct nvme_tcp_request *request;
 
+	int			queue_size;
 	u32			maxh2cdata;
 	size_t			cmnd_capsule_len;
 	struct nvme_tcp_ctrl	*ctrl;
@@ -1475,7 +1476,8 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
 }
 
-static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
+static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
+		int qid, size_t queue_size)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
@@ -1487,6 +1489,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 	INIT_LIST_HEAD(&queue->send_list);
 	mutex_init(&queue->send_mutex);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
+	queue->queue_size = queue_size;
 
 	if (qid > 0)
 		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
@@ -1734,7 +1737,7 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 {
 	int ret;
 
-	ret = nvme_tcp_alloc_queue(ctrl, 0);
+	ret = nvme_tcp_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
 	if (ret)
 		return ret;
 
@@ -1754,7 +1757,7 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 	int i, ret;
 
 	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = nvme_tcp_alloc_queue(ctrl, i);
+		ret = nvme_tcp_alloc_queue(ctrl, i, ctrl->sqsize + 1);
 		if (ret)
 			goto out_free_queues;
 	}
-- 
2.31.1


