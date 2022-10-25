Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C636C38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 14:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CgcebzpYjn6XXcMOBmx9qMp4+UVXRnoJ8IvKT4kLqAY=; b=t+fd7XOh4TAqKRb7UXqsywBFej
	s74lhWfcv5B1oCqL2gy9Hefbzi7+aVN/VuVWoV0nCdsE4e8sqq7sS1A3F3Nn8EqImWAxKiEg5vvRb
	uYI0b6Ol2BAlF3XJeAOGknxu5VYVMzuGuMqXtR4fi63oe3pVSZVLXKjGHmQ3QehmVacB3SqK9CraD
	jhjR+L08m774u/cHt98OzRo/QXHOQv+lAxVfxw4g2m8+iJRpqEW7782zBypLGJScSMur5RmRKWyFG
	Xtcn1AuvOFZE/ZVYqeeH7Q4PitJaL0faxgW31tGuX/OE7XeGmsPaBZj4kis9cbEMxEmNysIebgwv+
	RRznZT7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKTz-005eLP-CE; Tue, 25 Oct 2022 14:00:43 +0000
Received: from mail-dm3nam02on2066.outbound.protection.outlook.com ([40.107.95.66] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKTp-005eHq-W1
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 14:00:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBWhe6RD83Vw0uE/YayPk1OEnm3RC3gP1sIvuFg1bNHRngy97Oqc0/Kzq1iKsy/zS5JcStvPIydGs2QquC5Q8jd4IfPVUL0GEWOblOoicddXWFyET/sNjxz0zuZsYKfjWc0AMuUY3BdwHPGgddOrdg4dQNCL/RofXJdvPNSsAAKkQHRHA9RTCPAqI76t4wVCQTUIIA95PrSMoBTEXGFckorKeAXHvCBQA7PLirb2MfZGYL/jPHlhWwSCx7t/MkK0r7QDWsrgaYiRJVC+YvGO+NXk14l0Oamlvi6+edt37lk/cv+AFCOZx+xct3N+yc4N7vd4u9bT/qNtxVGEaA+H9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgcebzpYjn6XXcMOBmx9qMp4+UVXRnoJ8IvKT4kLqAY=;
 b=hBsibGiMM5NHIaXKDducvuRrwDKCjNH0svYx8xWWJJgL0aYkI+pf6HEv3nx+/5CnBG/gb1oD2HXOuYtu/4y0CtPD0qrSjCC1cFzysVk7O9DbJTzazjVXuFaGJ8Cv5OvzUqOPDe+mSwvSa4GkeHFkkogJ2hYzoARgE+CPQ5QGW7To1sTbPzDFd1emAqwV/zEH8tjpjQe7e8yec4SKnpy5m410k0rFT4ar1mR4MZC5XbS1W/5aOZ8W+zgVgjUquOcL6QITlSoe2qndFFP9VCFu0pV9/ubIxYikUu76+DmMIoXJ4fUObROLf2v1zjPC//A0FnQariqKjK7644J0Sj1t7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgcebzpYjn6XXcMOBmx9qMp4+UVXRnoJ8IvKT4kLqAY=;
 b=P7atqzrPSv+mB8tr0IP62WztqzBsczjgHc629e4U04Oi6Ws1Ua/SzG1saF0ZLTSEwjEkD7iLCO8HVOUyNXNqmbru/3nFCCDN2MhosopEWmyLOIoF72Hfj8vbnY4JVgcANlt2xiX6fXjr3Vx5OkYRUeuzPIT0UqeKvzKYdi0/IGMw6J7b5/F68Hqw6mUqwLlvU3tujYSauyD8QuNUYIM4KnfS/4mtyUiq/XwI3DjI769sYZ7YB95zQeMYsHVwjev1zAu/4bjSY3s04miw+66N7WAwunmJ5qJaov1smc4m2u1Zf7GGgLYv92VtpYeVfHP7BJ+BwXWk0JZpHOxZBXfYUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BL3PR12MB6521.namprd12.prod.outlook.com (2603:10b6:208:3bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 14:00:30 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::6713:a338:b6aa:871]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::6713:a338:b6aa:871%3]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 14:00:30 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org,
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
Subject: [PATCH v7 04/23] Revert "nvme-tcp: remove the unused queue_size member in nvme_tcp_queue"
Date: Tue, 25 Oct 2022 16:59:39 +0300
Message-Id: <20221025135958.6242-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221025135958.6242-1-aaptel@nvidia.com>
References: <20221025135958.6242-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0197.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::17) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BL3PR12MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3b46ce-c1e7-431e-ff30-08dab6914709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	H/KjOsWYO1gjTpbyBXnoLYJW9jS+Y7s1oDLsAooSPwLKZ1RLsk9w+q2ZKO3VtkMHaioGKzuxHFcGhTwV5TigBrAqDYsl9JfiKtSinaXG/LGdIDdvVDebICjPCEzazLK/5X0LXDO7+IrRW4dNOWhm5vicZvmKrmXuvUS2va+fuRKEtfXsf6g8S322VenPZxvLZM5b7J+WKWHi9SpE7vxuT2VSQCAdCmSdhwD6DMsW2D0Qli9F7uBZ6w2jB8Rhet+2PFmL7nM0+9HbYfwkIv0eOJhg+Ynlbf/lukvWjXS8GBMJivlw7S4Tql0vzfuh3uL9PBcGtDgrYRHme50ASnyBFmeCcPGMcyltKA+FZIWkglSFh2U8ZKQZcF1M3NSy/o4kz0wbId9RJ7xnvhH9vQUBpskjA+9hqQRUweSuMo+2BGxVAgmoS2P1T/IWg5/jJ0Fp0MLvACvAMSJaVRThiu3UmH5YDGW2pH7E4wpbijQYl7wkoY7/Eak6M3/CO/UxZXnxbqijssdkUBMaT6wKJCc+ncYmjMAtYSU8lUY7i4YZktJV7HDy6nQA6C8aRQasikBw9ClTBXE2WV+XEylAPYpohd0f1wpHixSlmofmOiFTpy9v9NTmRBB4R8OWGI3QKhT0ddebuy+tII74IPmEMMG5MnbgQW5legve2p6RJA7majwzFZv5A2M3oUJ7JOestaCyNmVN8pAJEl6Qa05XcATmoB4zOkw9Cvja4L3wL/C3iNesKpvsKfmhWJ10jttKJ2it
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199015)(921005)(83380400001)(1076003)(186003)(2616005)(86362001)(38100700002)(2906002)(41300700001)(8936002)(5660300002)(478600001)(7416002)(26005)(6506007)(6486002)(4326008)(8676002)(66556008)(66476007)(316002)(6636002)(66946007)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?YMfpSnXcafMq2EwM+RKtMEMJ9uIXtIQ8vmYAWty/ztndFRBMm3YZjyEF45zg?=
 =?us-ascii?Q?U+GAjyJVEmhLhXOT58Le2/xprm1uf4phKCF8M21c8FYxAerYSLX0Qmas1OHZ?=
 =?us-ascii?Q?HmtWL7CR8gBZ+SMbzwpw3AaBlDG8rw4JTxKMhe5js5fSWVTJX+Hvl937Btn+?=
 =?us-ascii?Q?mtWazCUZO9RN7axAlUJCeCLseDyavjMkHZYP7KTtwouSRu+7wbLlm61OB+P/?=
 =?us-ascii?Q?PzPw5MLcI6bt0cGhKQakdZ+T/xedCr0DWdOXvfwyT17Rlw44odI2gEm+n/3X?=
 =?us-ascii?Q?oOKWZqnW1/tFQbS8ebzGBORHEJJH+DdbfeGHMF0ksF7zmn4CSPImvwJjhhl8?=
 =?us-ascii?Q?c7mdmDrv+UO5G3Zt1bdc/sBud/gHx5uTkZmdOdJfzfmY51tnU16n/iRoCUJs?=
 =?us-ascii?Q?6zag9Nr7f5WdfY7fwaR8OWER6zSsTok6daNaMMKbXPsIIeqvmyOZmREpmGiU?=
 =?us-ascii?Q?YKgcU55HdowqFyaDD2dKK5wMuAPMhlUjg3mtEIgYpXnHKXXiEGdbnhyXyRih?=
 =?us-ascii?Q?bFTPy2Dw9/gwFzbJ35DAqRl7kQqzez16MaDKC+VyriDe5dKZb3ZYu8gcpHA/?=
 =?us-ascii?Q?9UyhuQuz6GiEh0a8AVXFh6t2NLTBAWSebB4ldBD0rX4skUmQtLPI0U1AX5pq?=
 =?us-ascii?Q?GvNDRRpeaZFlWDT4SaCfRWvKOYIlMGvFOmkRxQmF4gCK1onOHyNbTVUHVxbP?=
 =?us-ascii?Q?pxYnvcHsQ5l4wopEO4kvGn6pgsA8F3rVveUuuG9gAipgmF+s5RE+YxT2S23k?=
 =?us-ascii?Q?7Vu5v+7zDXiVulEA8Z6tFNuhSu6ll5fphvkGxCOb7Cg/sGFAoHD4qebcdtQM?=
 =?us-ascii?Q?HKX4X+ooggBlu5TJnaiA10vrecaLI9szZ4crvIDtFWOzsfjUEikcl6um9bxx?=
 =?us-ascii?Q?aYYuC5v4MEO+XTIKckPOul1VETUzBorcl/zesOnX2X1KRZCBNKIo6A1q4l7+?=
 =?us-ascii?Q?5BL2Tqs42wjlWubw9UBRIn0EpCubcTyhe+MIoEEn/drcnZsZzns4IiB+Rgo1?=
 =?us-ascii?Q?iR6N2quek3OqoRJlbKTepXS63/FBS+ZIzvhdcJc7TKJ3kdhqqV+hEDZLIFjv?=
 =?us-ascii?Q?oj8GlxWyzTHu7SHRYMNlH4ivwV629AoUFx9DpkeZvyNmQ+kV43gxhrN8bN19?=
 =?us-ascii?Q?f3Nl0nlrS7m3kyY2LzTCY4avNJ3tNpTywiHXg8dDli0mC+KcAhkQ6kdCygeB?=
 =?us-ascii?Q?BmT36DgZNFqw+i6l7WnpWD+pWdcBlGNB7RPlqL8xm2B8Ig9JuMX+hGKP4DqB?=
 =?us-ascii?Q?8AjDrDaqQ5IBfCu9ZmthcmkU+a7zUK4bAD4EoqIBXtMZVSC5NPLvVogV33lv?=
 =?us-ascii?Q?fCSBszcOrKTFYBtQhw3SCDZ83wS5hlBhezjKwnCY9y0Dv4Ib2Uxff3SgcCsP?=
 =?us-ascii?Q?vHeM3obsMw61PiEtcqH2uqELeiG+kDiI2DlFruPWmhPyiBZQ7xVe2Ru0uDnO?=
 =?us-ascii?Q?pyLWYgsWbFFY0CX4IE3qbQnod5RTa1h7KwO8Ds16/lYD9cuDX99e3M8v6eRg?=
 =?us-ascii?Q?/SVIhbVXPmMI8z1o6WOOV9JpEh7NffQit9swS6962dj/uZFdILewGbtmvDAb?=
 =?us-ascii?Q?fsz3Lrynw/t5+IqQ3SkMHAz+7mMZs4jRVjMu79vB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3b46ce-c1e7-431e-ff30-08dab6914709
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 14:00:30.5790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChId7/rztW0Mda8QEtTBbyjVGvKYB5WBv4D2iF5Q7AKoxBzqKkwzvUCkivmSA2DpnMrtEBk07Dfx0cCygMew/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6521
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_070034_052061_652ECB27 
X-CRM114-Status: GOOD (  12.31  )
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
nvme_tcp_queue->queue_size in the patch
"nvme-tcp: Add DDP offload control path" in nvme_tcp_offload_socket().
The queue size is part of struct ulp_ddp_config
parameters.

Fixed space alignment to open parenthesis from the original patch.

Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 drivers/nvme/host/tcp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1eed0fc26b3a..42b2d86dcfc2 100644
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
+				int qid, size_t queue_size)
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


