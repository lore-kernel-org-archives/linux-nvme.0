Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF21AC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 00:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UvF1C9RjdxJVYbFm/vr+yqxuMmps3re2bd+DaTIhCPE=; b=EHoVPNNI/yfdKtqrz9QNJvZh0T
	mp7CnY21b56c1McJT1nofRZyNOPv8n/2WPZRH0Hl5kBmjcQT2kyeF63RhfqkxJe2gR2GsC3wLYNYY
	UAcN7sSLMmRJRFkeHiHg4FMZ+gBJOm34uy71OpYzFQ9ASVBwQchvdzpCdFl36RFMV8TvSiWTKu8Hp
	njRJjQNZseVU3i1Q/OB/7kDr2ATAeje2mlT8IKl1aeV86NKgXrK4RVtObGKt4dBVqSeo9B5E9B2rJ
	Z9Eh78SgifNLgAxNZ0mMo9Iqh7YE5Q5A/WH83UOtPeu7MzgHqIrFoeoXEbGIu/pFAOWDT3Ag7VA74
	JPFZT96g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXBEP-00FC2J-RL; Thu, 24 Mar 2022 00:21:37 +0000
Received: from mail-bn8nam12on2062e.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::62e]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXBEM-00FC1z-Gm
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 00:21:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqhZvdSAz/JRyDahu2pVeRtvWtjiQKdZJzYbIccy7AC+eEPlTJCUuyOq5iLN47z6Gty52LKONb/Z6KZqgqcJskkVu8U3huBLd8t4OL4njYgTkb6CherEwwhk9hTS3SfqrfbrbV+bxCtVPGEJQwpcQVs0fXjNHCjFvhG2AmTZ4tRovKOzRN1WnuqfT5ZoFp2j+Q5fzElzXEgMF1Scr57W4DBp7+td8up/whGFP5/QRsTAdJL6tin+Ki3SnAEvLGOzHOuZfJ/Wu81YDs0cEPupeLAXtH/mpmonJ3B/paluhhJibOEvkGnKdYXw+otcf91ug8hd2wz1wJ7t7e6FmuRwSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvF1C9RjdxJVYbFm/vr+yqxuMmps3re2bd+DaTIhCPE=;
 b=f4G0Zsjl7O9IIlZ7u/VS8o9ORWKZqbWYlrsilqk/2A/UBPjJSlFcAT8fU1dlWj5AQyNe3PIEJ+Ih3m1H4iBiQN7JQYY9wlwi7yX4vvLjNQRpXm9Cndc9QNPROmDgHTNJHS8Ausr6AJ+f4tZQix71ue1f2d4iYzaUPPx4ElO5HxqASeKSAqgdiwPO4u5pnwpJeqSH6HgGtNStdWlW7Uf1khKGuAhC5hjcXoogMK3Z+ukpwyyLucP1W+U3DH5mn9Y1S/Z3y88GMGdezQtou87IKdtCXJ6kIb5LUmTo18DMv2ZqOeY09q1xahajto2rhM0RRgSLjJT9wkl8o+BTeurtfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvF1C9RjdxJVYbFm/vr+yqxuMmps3re2bd+DaTIhCPE=;
 b=me3O3a0g719YKxoAAvAqYbprsBB341BIduWJ7QRLvTzoguIhEktKuNUwDWhWBH0HAgzHRZWC1HpEWQxirdThwMQd99Ka4SPwfnquKuAxOP/segtCC8bbAXOnkP8LOGQ6ElU5WIyjwpzCK6s8xEmYXiTBDxjXFcZ5K6rxeATt8cLMUs3pB0IazflA0HeewPhbOdgY17q+++BQk9gGNeTYjKX80kT30IbIB8DldjW9d30eyzeYoY8Xh5gsdkJ3BFYqv4G4hp/FLLkdBnFVcR2P1cofsbCW1G7xPy/W+GcgsxF1KuqqefwLnULeRlIHB7udmivZ96G7aXsv20kI0paRqw==
Received: from MWHPR19CA0062.namprd19.prod.outlook.com (2603:10b6:300:94::24)
 by DM5PR12MB1419.namprd12.prod.outlook.com (2603:10b6:3:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 00:06:28 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::49) by MWHPR19CA0062.outlook.office365.com
 (2603:10b6:300:94::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Thu, 24 Mar 2022 00:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Thu, 24 Mar 2022 00:06:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Thu, 24 Mar 2022 00:06:27 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 23 Mar
 2022 17:06:27 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH] Revert "nvme-multipath: fix hang when disk goes live over
 reconnect"
Date: Wed, 23 Mar 2022 17:06:20 -0700
Message-ID: <20220324000620.4127-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 173ee323-08ff-4916-22ec-08da0d2a24e5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1419:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1419250A5570B642A274756AA3199@DM5PR12MB1419.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5cdTqv7fQc+P/T+hjNLqcjW1IzvdkgUMswqxwyIwCByweCFc6MYcOI6+VuNGQ5WU27/mrQCKTW/RKJ0v35b6HcE+27aZXiZ53RqChZt5+bLQ9ERKlWbd86mDA7O5HJyFrhoC2+6/XSjo0ToSvUKpA6zTuDDZFAnT9hwfBlahY72eK3mvQag5hOq8dpE7yVYwnPELScKrDkHXnDFd8I2DEW31BJCIuQpVsJbN1jI8XGo5yYuqtPNvNYxLicdTt/UP/MlClN7AqbJUxQlDDQ1iencR7ynvdYz0TT3ZH4JOSnPDqIy+bQ+s8vxhqkLKtocq4shsfiWxFSURscGyN6emtZerFoVndTKxbHbEu5fg0zGXt8C5il/pgmoCav39YkIT8d79BZ2ffa1sjbBhvPrw0XO+IWyigxaAtBoG8ILLtHPj1WwaNu+1Z79obvomJAHxGIbdUILnX8aR8y1bSb35vcY3kiLyWxarvFESeGArnby2FjSLztJNeU3moM4WQKa/8SZriiRVIQ8MAK3wGBYKHYP9ibYp42T3VmZzLh/1bTPat6SDKDtCZHDKBB/6jzPMkWAfeCa02bb+UReXKxqVPgEOIY6XSIFKfXOjHwRVxbnon91er1VCe4F4zJx6x7PDJV6JUQyae2+v3A6bjL1eJ2dADF2i+xDVfUv3QMbpz6j8HXcihHrBGM9Za3kDhTZzQHDL/Zg61BQPQDZL2Fsog==
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(356005)(81166007)(26005)(82310400004)(186003)(426003)(336012)(16526019)(36756003)(508600001)(83380400001)(7696005)(5660300002)(2906002)(70206006)(36860700001)(8676002)(4326008)(8936002)(316002)(54906003)(6916009)(47076005)(107886003)(1076003)(40460700003)(70586007)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 00:06:28.4036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 173ee323-08ff-4916-22ec-08da0d2a24e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_172134_576079_13461CD8 
X-CRM114-Status: GOOD (  15.69  )
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

This reverts commit d50c992edf10b95d2034097405c94fecfbe1ef7f which is
causing following OOPs:
<1>[    1.943642] BUG: kernel NULL pointer dereference, address: 0000000000000008
<1>[    1.943645] #PF: supervisor read access in kernel mode
<1>[    1.943646] #PF: error_code(0x0000) - not-present page
<6>[    1.943648] PGD 0 P4D 0 
<4>[    1.943649] Oops: 0000 [#1] PREEMPT SMP NOPTI
<4>[    1.943651] CPU: 0 PID: 7 Comm: kworker/u96:0 Not tainted 5.17.0-rc2nvme+ #58
<4>[    1.943653] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
<4>[    1.943654] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
<4>[    1.943662] RIP: 0010:nvme_parse_ana_log+0x1e/0x160 [nvme_core]

<4>[    1.943670] RSP: 0018:ffffc90000043e00 EFLAGS: 00010286
<4>[    1.943672] RAX: 0000000000000000 RBX: ffff888103fd4210 RCX: 0000000000000000
<4>[    1.943673] RDX: ffffffffc00b62c0 RSI: ffffc90000043e44 RDI: ffff888103fd4210
<4>[    1.943673] RBP: ffff888103fd4210 R08: 0000000000000001 R09: ffff888100051828
<4>[    1.943674] R10: 0000000000000000 R11: fffffffffff4a904 R12: 0000000000000000
<4>[    1.943675] R13: ffff88817daa6500 R14: 0000000000000000 R15: ffff88817daa6505
<4>[    1.943677] FS:  0000000000000000(0000) GS:ffff888fff200000(0000) knlGS:0000000000000000
<4>[    1.943678] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[    1.943678] CR2: 0000000000000008 CR3: 00000001788a4000 CR4: 0000000000350ef0
<4>[    1.943680] Call Trace:
<4>[    1.943683]  <TASK>
<4>[    1.943684]  ? nvme_update_ns_ana_state+0x40/0x40 [nvme_core]
<4>[    1.943690]  nvme_mpath_update+0x4a/0x70 [nvme_core]
<4>[    1.943695]  nvme_start_ctrl+0x110/0x140 [nvme_core]
<4>[    1.943700]  process_one_work+0x1af/0x380
<4>[    1.943709]  worker_thread+0x50/0x3a0
<4>[    1.943711]  ? rescuer_thread+0x370/0x370
<4>[    1.943712]  kthread+0xe7/0x110
<4>[    1.943714]  ? kthread_complete_and_exit+0x20/0x20
<4>[    1.943716]  ret_from_fork+0x22/0x30
<4>[    1.943719]  </TASK>

[0]kdb>                    

With this revert not testing can proceed forward.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c      |  1 -
 drivers/nvme/host/multipath.c | 23 ++---------------------
 drivers/nvme/host/nvme.h      |  4 ----
 3 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8cb1197aac42..ccc5877d514b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4511,7 +4511,6 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	if (ctrl->queue_count > 1) {
 		nvme_queue_scan(ctrl);
 		nvme_start_queues(ctrl);
-		nvme_mpath_update(ctrl);
 	}
 
 	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 12d4afde3662..c97d7f843977 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -612,18 +612,8 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
 	ns->ana_grpid = le32_to_cpu(desc->grpid);
 	ns->ana_state = desc->state;
 	clear_bit(NVME_NS_ANA_PENDING, &ns->flags);
-	/*
-	 * nvme_mpath_set_live() will trigger I/O to the mpath
-	 * device node and in turn to this path device, however we
-	 * cannot accept this I/O if the ctrl is not live.
-	 * This may deadlock if called from the nvme_mpath_init_identify()
-	 * and the ctrl will never complete initialization,
-	 * preventing I/O from completing.
-	 * For this case we will reprocess the ANA log page
-	 * in nvme_mpath_update() once the ctrl ready.
-	 */
-	if (nvme_state_is_live(ns->ana_state) &&
-	    ns->ctrl->state == NVME_CTRL_LIVE)
+
+	if (nvme_state_is_live(ns->ana_state))
 		nvme_mpath_set_live(ns);
 }
 
@@ -710,15 +700,6 @@ static void nvme_ana_work(struct work_struct *work)
 	nvme_read_ana_log(ctrl);
 }
 
-void nvme_mpath_update(struct nvme_ctrl *ctrl)
-{
-	u32 nr_change_groups = 0;
-
-	mutex_lock(&ctrl->ana_lock);
-	nvme_parse_ana_log(ctrl, &nr_change_groups, nvme_update_ana_state);
-	mutex_unlock(&ctrl->ana_lock);
-}
-
 static void nvme_anatt_timeout(struct timer_list *t)
 {
 	struct nvme_ctrl *ctrl = from_timer(ctrl, t, anatt_timer);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 76f7a5f37379..1ea908d43e17 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -781,7 +781,6 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
 void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl);
-void nvme_mpath_update(struct nvme_ctrl *ctrl);
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
 void nvme_mpath_stop(struct nvme_ctrl *ctrl);
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
@@ -853,9 +852,6 @@ static inline int nvme_mpath_init_identify(struct nvme_ctrl *ctrl,
 "Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.\n");
 	return 0;
 }
-void nvme_mpath_update(struct nvme_ctrl *ctrl)
-{
-}
 static inline void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 {
 }
-- 
2.29.0


