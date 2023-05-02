Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFB2C77B7E
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 05:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6W7SxMjJOTsLWYRl0aWvZxj6YfFjWPAJkIa7PySbltI=; b=3R/XvOAtaOR5AEB73CqEOS666F
	JbS2Ma0nAVInojzeB9IVrmrFkqZammysNe69ocEc4m1uOsrEnmeWdlMJrGjWbQHSdleGubHr8yasn
	dI+I0fjbIkvhP0QoVM1XQ5Iv2WJzSMO82qOSIXJTwPd+k40vpH1Io+Bnv8xXWYX6GvROfCYM4IHWl
	8spdL5k8s3iWKYMDEyLvop/hPPrU5PGGylEchP+82+TPNhoSAQA2/2ZfT9NnEdZehrmRdLp/kjKMp
	/aBfobRLWb+xlKl1VQgnXoZFN+FLostwyHXYAvoB+oHYI8oP5muNPmgy9Sio+YG7QZZE/8UWEXxFK
	C7jzJLPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptibi-000Ch4-0N;
	Tue, 02 May 2023 05:31:22 +0000
Received: from mail-dm3nam02on2062e.outbound.protection.outlook.com ([2a01:111:f400:7e83::62e] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptibe-000Cfd-0g
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 05:31:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2svTdv61a+gKoXfUsVe9PPb4kkKBHTZ72VCHUMwwCoen1HUuhwjZ3ODD63Ln+hEhN6Xk82OMr3ezSLj4myrRAWbivdKVawyJ1CLUlVY2ifjGy6zmAmg+fuFTq5nLdbKK/HO8ebt6hD/hl7J7OrJN2uhRE1Rsv1Feeyk28msROVhBjABMFiRxlE20IknxyU3svUU3mNUBegaUqLzDV/4Q4plnMCpvP8dPP0MowfiOvyjPZRB0TWtlEgrdxecJL8L+yHLERv0bPQ50pRBfB/sZcr06Lc+BJDQicrpPcVMv4cZ5+ASWklJPj7M7J6nebRewpot9rmJk06B/qxPZQxkgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6W7SxMjJOTsLWYRl0aWvZxj6YfFjWPAJkIa7PySbltI=;
 b=UYeLRqdJNclElGZPsQNb0ogLOUGLJtSmX0QgP4yMhi4ReeN2ED4rm/zQBV4Njt8JbzyDdloI4AHaEyLQL5m21SWWD1KZQO3dbFZL3Fu6+3jNJqruXGPU52TwX7vmBTkxUp4Kljl7SmWc+O6xb8LhwdghzixPIM/z/N7+yh8DuKCAA81cVLxQ/JtK1cqnQ4xm2Lo2yEiDjFDrGPonBwYw9q/YnENR/J2M/lnBG6hPM+UIa2/DCUiyQdtGofElNuXxGY3f1dWgynRmxNM1eqoPj3JU6TWgGlhfkiIzA+LSY1aKfTl0tsnVsDwmhpF3ivphKMJmaWR7JLmUGL3ijg9vWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6W7SxMjJOTsLWYRl0aWvZxj6YfFjWPAJkIa7PySbltI=;
 b=MRNvKYjjuG9KyIekfwh3TwglXoGt5jg7Ix0rfcTx0fKn2BRWIpolOOIk9wHot/Z4y4tTc+4xmXpvEIwuegYW4DcBOU2x9VktYiAMkk54+uHYgF4sVi3qnndgQI9twqIhMXCu4XR0dWwuRG6r+pJACwqfqeWUkfJ9fGqkzsQosPbQluk9eeHH4pw8HBgJrohMeYa/ZExJ8BLtWtL+AnpuHyyqdB/XvgXM8WGGrfMdrhokfdROUop7TkzsPb+CaqF4Fwd/LIzOTbspI43MiguGVC+0PV1JrI+gLza4wQSY3/tw/3esXhK6q27Mj1Tmz0bwg6stycwix2yq0QvkmCmNtw==
Received: from DS7PR03CA0150.namprd03.prod.outlook.com (2603:10b6:5:3b4::35)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 05:31:10 +0000
Received: from DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::8a) by DS7PR03CA0150.outlook.office365.com
 (2603:10b6:5:3b4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 05:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT072.mail.protection.outlook.com (10.13.173.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 05:31:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 1 May 2023
 22:30:57 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 1 May 2023
 22:30:57 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvmet: dynamically allocate nvmet_ns->nguid
Date: Mon, 1 May 2023 22:30:51 -0700
Message-ID: <20230502053051.14621-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT072:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f49c3a-3fdf-4004-c225-08db4ace6fa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	UI7SpGxLBPidclls+pFRdhF1nbYKNr1Nq5tpwcZo24EeUj/roYNauwEVMCwH88DNzzbxS+BOreZ9cNASJNdSq7AFw1Y6SOaD0R/Kdyp38vTwpAz9iLcO4bgwQEkl2wd4xqcptTnfy9KT7sv51ITMHwAMkGAPEURzATSWOecKIelHT5XR7vEHEzdV/fZ98fTDKk1Edqy5GEzJdxFUfPyYqlDIT4RdQnP+ManPl8ZjlaV7lI0VolDZcK52Oth6N6k0RoLmNocwbGYp2rEtHd08kps3e4Uh1lxjGL47/YiXexP/VwS2OKPtHWeTMPsy7e3+JfmbdmG/OjjR+Z8y8fk/liHoFUZwN6+jn/zn5qqyZba7lQKErWky7180bQM96MiHz9dFKzH0YjQc1P0Y0HMGGF1pLGyANjqZrIaNbC5wDOPwGnq5Yf05hOePHqHvHUu0THYraiG4Y/x0gnrzfWpGHXWKhY9ERG3tAPlUE73wnhk1O5n7mxY5uGA4256B4B73j8BoKqdwS66u0R4nyEE1K/fuKa8jn/h/m00Pl6N9S9gyNt55D64E8feUJ63ILr5nZZNA1k2nlb9T588V3xa9RByafg4TaTVvDRwcImjN+BdMUqWF7RqqS1X5uIMC5oVa9vt5OHCqd+g9A4LDlmdkAjGeLqF/N0NvEEdeXen/7eiz2KhPVFQfTJmaaIUbdgpDGlFTPp+LrAP+aIk47sR2eokoi4xB3xWEU/p387P5vbys/0Apvwht1e/rNsbnx0FidUFu7F+kDcWHsVdw2ZFojA==
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(70206006)(2616005)(83380400001)(107886003)(478600001)(36860700001)(186003)(16526019)(54906003)(4326008)(6916009)(47076005)(426003)(966005)(7696005)(6666004)(336012)(1076003)(26005)(316002)(7636003)(8936002)(8676002)(70586007)(5660300002)(41300700001)(40460700003)(82740400003)(2906002)(40480700001)(356005)(82310400005)(36756003)(21314003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 05:31:09.8765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f49c3a-3fdf-4004-c225-08db4ace6fa9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_223118_315030_456E9837 
X-CRM114-Status: GOOD (  18.23  )
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

The nvmet_ns struct is critical to I/O operations in each backend bdev
and file, but its static nguid array is not accessed in the fast path.
This means that pulling all the memory for the array on each access
is inefficient.

This patch dynamically allocates the nvmet_ns->nguid array, reducing the
size of the nvmet_ns struct. This optimization should reduce unnecessary
memory access in the fast path that is required for the array vs pointer.
For allocation of nguid with kzalloc() use same policy GFP_KERNEL that is
used to allocate nvmet_ns struct iself.

struct nvmet_ns size difference with pahole :-

with this patch		:- /* size: 440, cachelines: 7, members: 23 */
without this patch	:- /* size: 448, cachelines: 7, members: 23 */

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---

Following is the difference with pahole:

With this patch :-

struct nvmet_ns {
	struct percpu_ref          ref;                  /*     0    16 */
	struct block_device *      bdev;                 /*    16     8 */
	struct file *              file;                 /*    24     8 */
	bool                       readonly;             /*    32     1 */

	/* XXX 3 bytes hole, try to pack */

	u32                        nsid;                 /*    36     4 */
	u32                        blksize_shift;        /*    40     4 */

	/* XXX 4 bytes hole, try to pack */

	loff_t                     size;                 /*    48     8 */
	u8 *                       nguid;                /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	uuid_t                     uuid;                 /*    64    16 */
	u32                        anagrpid;             /*    80     4 */
	bool                       buffered_io;          /*    84     1 */
	bool                       enabled;              /*    85     1 */

	/* XXX 2 bytes hole, try to pack */

	struct nvmet_subsys *      subsys;               /*    88     8 */
	const char  *              device_path;          /*    96     8 */
	struct config_group        device_group;         /*   104   136 */
	/* --- cacheline 3 boundary (192 bytes) was 48 bytes ago --- */
	struct config_group        group;                /*   240   136 */
	/* --- cacheline 5 boundary (320 bytes) was 56 bytes ago --- */
	struct completion          disable_done;         /*   376    32 */
	/* --- cacheline 6 boundary (384 bytes) was 24 bytes ago --- */
	mempool_t *                bvec_pool;            /*   408     8 */
	struct pci_dev *           p2p_dev;              /*   416     8 */
	int                        use_p2pmem;           /*   424     4 */
	int                        pi_type;              /*   428     4 */
	int                        metadata_size;        /*   432     4 */
	u8                         csi;                  /*   436     1 */

	/* size: 440, cachelines: 7, members: 23 */
	/* sum members: 428, holes: 3, sum holes: 9 */
	/* padding: 3 */
	/* last cacheline: 56 bytes */
};

Without this patch :-

struct nvmet_ns {
	struct percpu_ref          ref;                  /*     0    16 */
	struct block_device *      bdev;                 /*    16     8 */
	struct file *              file;                 /*    24     8 */
	bool                       readonly;             /*    32     1 */

	/* XXX 3 bytes hole, try to pack */

	u32                        nsid;                 /*    36     4 */
	u32                        blksize_shift;        /*    40     4 */

	/* XXX 4 bytes hole, try to pack */

	loff_t                     size;                 /*    48     8 */
	u8                         nguid[16];            /*    56    16 */
	/* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
	uuid_t                     uuid;                 /*    72    16 */
	u32                        anagrpid;             /*    88     4 */
	bool                       buffered_io;          /*    92     1 */
	bool                       enabled;              /*    93     1 */

	/* XXX 2 bytes hole, try to pack */

	struct nvmet_subsys *      subsys;               /*    96     8 */
	const char  *              device_path;          /*   104     8 */
	struct config_group        device_group;         /*   112   136 */
	/* --- cacheline 3 boundary (192 bytes) was 56 bytes ago --- */
	struct config_group        group;                /*   248   136 */
	/* --- cacheline 6 boundary (384 bytes) --- */
	struct completion          disable_done;         /*   384    32 */
	mempool_t *                bvec_pool;            /*   416     8 */
	struct pci_dev *           p2p_dev;              /*   424     8 */
	int                        use_p2pmem;           /*   432     4 */
	int                        pi_type;              /*   436     4 */
	int                        metadata_size;        /*   440     4 */
	u8                         csi;                  /*   444     1 */

	/* size: 448, cachelines: 7, members: 23 */
	/* sum members: 436, holes: 3, sum holes: 9 */
	/* padding: 3 */
};

Please note that this patch is generated on the top of 
("nvmet: Reorder fields in 'struct nvmet_ns'") :-

https://www.spinics.net/lists/kernel/msg4773169.html

 drivers/nvme/target/admin-cmd.c | 6 +++---
 drivers/nvme/target/configfs.c  | 4 ++--
 drivers/nvme/target/core.c      | 7 +++++++
 drivers/nvme/target/nvmet.h     | 2 +-
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 39cb570f833d..21129ad15320 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -551,7 +551,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	id->nmic = NVME_NS_NMIC_SHARED;
 	id->anagrpid = cpu_to_le32(req->ns->anagrpid);
 
-	memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
+	memcpy(&id->nguid, req->ns->nguid, sizeof(id->nguid));
 
 	id->lbaf[0].ds = req->ns->blksize_shift;
 
@@ -646,10 +646,10 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 		if (status)
 			goto out;
 	}
-	if (memchr_inv(req->ns->nguid, 0, sizeof(req->ns->nguid))) {
+	if (memchr_inv(req->ns->nguid, 0, NVME_NIDT_NGUID_LEN)) {
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_NGUID,
 						  NVME_NIDT_NGUID_LEN,
-						  &req->ns->nguid, &off);
+						  req->ns->nguid, &off);
 		if (status)
 			goto out;
 	}
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 907143870da5..463ae31d5d71 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -444,7 +444,7 @@ CONFIGFS_ATTR(nvmet_ns_, device_uuid);
 
 static ssize_t nvmet_ns_device_nguid_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%pUb\n", &to_nvmet_ns(item)->nguid);
+	return sprintf(page, "%pUb\n", to_nvmet_ns(item)->nguid);
 }
 
 static ssize_t nvmet_ns_device_nguid_store(struct config_item *item,
@@ -480,7 +480,7 @@ static ssize_t nvmet_ns_device_nguid_store(struct config_item *item,
 			p++;
 	}
 
-	memcpy(&ns->nguid, nguid, sizeof(nguid));
+	memcpy(ns->nguid, nguid, sizeof(nguid));
 out_unlock:
 	mutex_unlock(&subsys->lock);
 	return ret ? ret : count;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index f66ed13d7c11..cc95ba3c2835 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -665,6 +665,7 @@ void nvmet_ns_free(struct nvmet_ns *ns)
 	up_write(&nvmet_ana_sem);
 
 	kfree(ns->device_path);
+	kfree(ns->nguid);
 	kfree(ns);
 }
 
@@ -676,6 +677,12 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	if (!ns)
 		return NULL;
 
+	ns->nguid = kzalloc(NVME_NIDT_NGUID_LEN, GFP_KERNEL);
+	if (!ns) {
+		kfree(ns);
+		return NULL;
+	}
+
 	init_completion(&ns->disable_done);
 
 	ns->nsid = nsid;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c50146085fb5..4c2a20dc9eed 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -64,7 +64,7 @@ struct nvmet_ns {
 	u32			nsid;
 	u32			blksize_shift;
 	loff_t			size;
-	u8			nguid[16];
+	u8                      *nguid;
 	uuid_t			uuid;
 	u32			anagrpid;
 
-- 
2.40.0


