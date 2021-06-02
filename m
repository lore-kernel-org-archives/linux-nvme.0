Return-Path: <SRS0=uBfD=K4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E26C47083
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 11:12:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB5866135D
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 11:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5866135D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OrjqvikoYUevWIi9sfy+edOEecjxaX1yDfpnXSqsTzE=; b=4xRg6udCd66tRt
	EUxVd4RAgIPFosQY/zKCmycX/F7wZ69h7xIYh7z97st3XdcmsTYgYknE3bPk/pc7e2uZh502oJTpm
	1ouNxsoWZQgvuDLh+vsPhz0d6kYUpjI3A31qO/PMtHgbv7fmsCheQdN+Wbh+KuVZa6gSlA3pis+CW
	kF43QQlxYU2iodLCUWHTzah+Nh5NyLeIBba7WZtLP6kV8RuG6l2qxGdJQX8HSjTXIDMyNhnLB3sJM
	56s0AfECsr35pT+WPb2aJtSnOv+X00xHo0qSgyMrT2X/pZ46lYho0ASrPUCulKPGBt3ZYOD8vwWm1
	xQNHKOM+t0lNd8tCcCug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loOnO-003dJm-Aq; Wed, 02 Jun 2021 11:12:22 +0000
Received: from mail-bn8nam12on2069.outbound.protection.outlook.com
 ([40.107.237.69] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loOmG-003cr6-Bt
 for linux-nvme@lists.infradead.org; Wed, 02 Jun 2021 11:11:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKI9OgsdUUWYcTcgv/8V3ZAOWcLZh3nR1rRy9QFbu0p1mypS0eWCTohsDykWbB94YsXiYCL1oyWHq6Hfjc5DcuuZOEcJlK8P53dalUexpLro1qt27zSfjCo0vZwTt4FNkXh9mmfsTZXKCLEtbE5afRi3sF5VoaRcmGdqpxkpFtu8NFFJwAmIwSPcwGvmkdNfvGR9SzGwpvWiDw1qpOIKjLurote2IryQcUIv4irlDGR20N0e1G6sAcycCO0No7GF/+R1SB45YT20I8qPI7PlsOHOSbaviAsmJAqH7ntLmup/vHk/h1KVuJhDJ7jlvI2krSVuZPJT40QYcvlEZumjvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWLZrSPPs2xcmex5XRXU+Es+Jq9BcI/nCSfgQmVEd8Y=;
 b=nOqqB+JoJB8Qbss8/KeVhHFIOyc/OFebVcjWttWfiXl6csz4YKSNSGu32+uL391bUGqxhtJ0iApP0ps2BsatlcaJY3h9aCmAdbncpegNxwMNbNu8XXYHYXkXKdOrExF5wATAlBwo1oxCK0LpftDa2unAzt/kveSYftr9S7o3npeoa2Y9WXeFaxgNB8LWfzkOwuHzZ0MvveNE17oEFr/diZgs+iVLafTmhr6g5GylNWmiBQ0hwMdD5ZvQ03HoPDBua6QDGSCM2R4t+q3PtLysmx/HyLd2CnrG3B7EGjedBkXpm8axDeaCa1S3nxavXiXD8JXVKk07ulbG4bTR7QZkqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=deltatee.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWLZrSPPs2xcmex5XRXU+Es+Jq9BcI/nCSfgQmVEd8Y=;
 b=jdOyaWBeapWYkQ7NdOwfA8cedCkhWFsgsZ5BQGvjmMLeCSlB9Z9eiHxmxnAGfMTkFonZuFFTDhOkIWCPga+gteRMkjHyivqTJ8w1cHm0qc2wY9H+VTdSuNugqwjXtcdGrcdKcYAQABaZusR9kxqGZkX8PuaxaokLJkSDPWAMNMaNAZdXMToCDDB1WWRk5Era5MVB81Jn1i/O+EjcAybIOhABo/GPWpgysrUtBvZHWi3uLiuq9xbM/0MKNix/R5GWEbnQLy+2SEcR21EYw5kWDOaWYjAzc4ptyaPpHotvRrQ39RN9DHHiuC6kmOj+lNgOsRlRT9Qsw7ZptK9bDQ0Fog==
Received: from BN6PR13CA0011.namprd13.prod.outlook.com (2603:10b6:404:10a::21)
 by DM6PR12MB3244.namprd12.prod.outlook.com (2603:10b6:5:18c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 11:11:09 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::20) by BN6PR13CA0011.outlook.office365.com
 (2603:10b6:404:10a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.10 via Frontend
 Transport; Wed, 2 Jun 2021 11:11:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 11:11:08 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun
 2021 04:11:07 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun
 2021 11:11:07 +0000
Received: from r-arch-stor03.mtr.labs.mlnx (172.20.187.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Jun 2021 11:11:04 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <dan.j.williams@intel.com>,
 <logang@deltatee.com>, <linux-mm@kvack.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, <david@redhat.com>, <oren@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>, Max Gurtovoy
 <mgurtovoy@nvidia.com>
Subject: [PATCH 1/3] mm,memory_hotplug: export mhp min alignment
Date: Wed, 2 Jun 2021 14:10:53 +0300
Message-ID: <20210602111055.10480-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210602111055.10480-1-mgurtovoy@nvidia.com>
References: <20210602111055.10480-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1961e6ff-87e5-4867-4430-08d925b71f80
X-MS-TrafficTypeDiagnostic: DM6PR12MB3244:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3244C4CB9E544F329F6DAEDFDE3D9@DM6PR12MB3244.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qiecgvgCKdjfUKWq8mqcuWaB7Uq05uC3hxqv+M2MEwk+m+mn4TVpc6iVarwFvMIXVQeyHfSAe8lLgPitHnDs7MuLZ+cyB4oUSjPSTFag55SMoOHneD0gm06EdxOlNBiJmXQ0jdU2G/xG10XR7Kd0SWooYecInrYvPYN1Ens6vsBP3trayZuJf+Q+092h5xOjothozJqfBKb/vbCMeW2Qv2dXn0Kn/hG31wpWnxUy0xr0/tDPNmHbU4+SqTt20oEen4Q/yNTCnj64q1FnnM6FuPulGUvgxdpw6gRGKQKJvXUqyNpcphquW/w2pJeQlncjJDn2c53p5QSRuQtiFBs0V1aiWj96bIWEIXCLHsNT+PKFIsc2fLEfbIVS07jif5oPiw6oXCRieUtqdJw13El/sVHWhZxqdQg6GP4d7HL03sMFAqcHcoFs4ax0AD/kdg6Q9lJLUuvnY7Vwr6jugdrMfAs8PiwYHcniay895zRi4sxsRKczASGhCRTNEitoW1L6jbbDxmmxlC6MXkK1HYfvyE7Q0BfPnzNPb9Bou943I6zYHPc002+E7MHuNc1G6Xds3TZdPKte72uxNI7gDKWY/OEiSbPI9Ov9o1182s5ZAf1FBu5eYw2f+BaGKis9Py0z4WHSYHPSewwEtUAlkFxXhkHtJCcgZ9GmZA5rUUByvcs=
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966006)(36840700001)(5660300002)(2906002)(316002)(336012)(82310400003)(107886003)(36860700001)(2616005)(478600001)(70586007)(82740400003)(186003)(86362001)(26005)(426003)(54906003)(110136005)(8936002)(83380400001)(7636003)(356005)(1076003)(4326008)(8676002)(36756003)(70206006)(6666004)(47076005)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 11:11:08.5499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1961e6ff-87e5-4867-4430-08d925b71f80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3244
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210602_041112_457366_69A3F39A 
X-CRM114-Status: GOOD (  12.59  )
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

Hotplugged memory has alignmet restrictions. E.g, it disallows all
operations smaller than a sub-section and only allow operations smaller
than a section for SPARSEMEM_VMEMMAP. Export the alignment restrictions
for mhp users.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 include/linux/memory_hotplug.h |  5 +++++
 mm/memory_hotplug.c            | 33 +++++++++++++++++++--------------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 28f32fd00fe9..c55a9049b11e 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -76,6 +76,7 @@ struct mhp_params {
 
 bool mhp_range_allowed(u64 start, u64 size, bool need_mapping);
 struct range mhp_get_pluggable_range(bool need_mapping);
+unsigned long mhp_get_min_align(void);
 
 /*
  * Zone resizing functions
@@ -248,6 +249,10 @@ void mem_hotplug_done(void);
 	___page;				\
  })
 
+static inline unsigned long mhp_get_min_align(void)
+{
+	return 0;
+}
 static inline unsigned zone_span_seqbegin(struct zone *zone)
 {
 	return 0;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9e86e9ee0a10..161bb6704a9b 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -270,24 +270,29 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
 }
 #endif /* CONFIG_HAVE_BOOTMEM_INFO_NODE */
 
+/*
+ * Disallow all operations smaller than a sub-section and only
+ * allow operations smaller than a section for
+ * SPARSEMEM_VMEMMAP. Note that check_hotplug_memory_range()
+ * enforces a larger memory_block_size_bytes() granularity for
+ * memory that will be marked online, so this check should only
+ * fire for direct arch_{add,remove}_memory() users outside of
+ * add_memory_resource().
+ */
+unsigned long mhp_get_min_align(void)
+{
+	if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
+		return PAGES_PER_SUBSECTION;
+	return PAGES_PER_SECTION;
+}
+EXPORT_SYMBOL_GPL(mhp_get_min_align);
+
+
 static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
 		const char *reason)
 {
-	/*
-	 * Disallow all operations smaller than a sub-section and only
-	 * allow operations smaller than a section for
-	 * SPARSEMEM_VMEMMAP. Note that check_hotplug_memory_range()
-	 * enforces a larger memory_block_size_bytes() granularity for
-	 * memory that will be marked online, so this check should only
-	 * fire for direct arch_{add,remove}_memory() users outside of
-	 * add_memory_resource().
-	 */
-	unsigned long min_align;
+	unsigned long min_align = mhp_get_min_align();
 
-	if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
-		min_align = PAGES_PER_SUBSECTION;
-	else
-		min_align = PAGES_PER_SECTION;
 	if (!IS_ALIGNED(pfn, min_align) || !IS_ALIGNED(nr_pages, min_align)) {
 		WARN(1, "Misaligned __%s_pages min_align: %#lx start: %#lx end: %#lx\n",
 		     reason, min_align, pfn, pfn + nr_pages - 1);
-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
