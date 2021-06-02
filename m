Return-Path: <SRS0=uBfD=K4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C0EC4708F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 11:11:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3768660E08
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 11:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3768660E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MuUZKZvd99i2giN6TIhrYfe81IR/1JOh/w5wqhFBE1Q=; b=U6N4Q+KjR5iSyO
	+7vDkpNnbcvAmrw/liYiGnYWaJGctaOIyk7B/a5fsRj8iAiUFAMGK4n3aJa/yv4EcxTaG/qluFpVE
	E6q2UfHztS7Wp6C3sArbh4aJqnTmqh1kvihSq/MZ7aBRFPIfo/8P0NTFX8OAXK5xIOROZjkLol6lF
	5aDK10mIY9JmAEU616M2Zb+Zdbu2SfUGDoOwNpjl7gDTfADtzfNDWmQnktNEe06OXnZ5uL7FnAV7r
	qOonOVbGnJ+xFHbZ6Q4lahIRgUmot/ZqoAamgfDVDbYKygKpLidClGK4jUZrFDc9BiHLgrR6KflZ6
	0ADBvqoI4mVeyG5k72OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loOmN-003cx0-C5; Wed, 02 Jun 2021 11:11:19 +0000
Received: from mail-dm3nam07on2065.outbound.protection.outlook.com
 ([40.107.95.65] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loOmC-003coD-9b
 for linux-nvme@lists.infradead.org; Wed, 02 Jun 2021 11:11:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vh/mNuM+oEt9ripo8xodW46NJ86wnAVBlHRyQX7maZGC1ItTUe92Z0OEMdlF/TeBs2IeY+AdaJg8fgOkDSQHleDg+WU4BqCmJjdZpfH7Av2SwK73oIMfTcFCg9FdH1BT3pvoLzdINdIIcw/hobjosgin+vLG35jZL60vlB6FzdVIqDWRGDQmZvzFnQVzYeU7Qp2X7EkEDeZPupkN0ghq0sGPiWE8E1J2ENAyMAO7g1YohEyPR8IudnyMRoHXDrBMofFMykfwWUK6WPQUQ1heQ4m6ifhMKgf1x3jO9L3jAATyyeooK64jZESjj37Ebrk0R2UDcvSR6Gkbpc8uiWhy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSaWKlw5ZeRmeP2Gc29abjp9jKKPN91HhU47wtwb4Xg=;
 b=TikZqD3nGzdDYS7KH24Q8Ej1MvrUVVlZjS4PFt8Vo+PKkHZLLgngadMegib6Wv9vvQS3r2tA5vlcvjiMHM1KebhwdFKvy1xH1/LFj9GHbvnYJgMruoCExXjPJJz1mVl1AO5J00b8wuN7qR6vCcc6vR1Y7/D+EZv+QLdVObRaxYKwkQOjAbJ749SlIPVocIg83PrLTHBH5jKzcuJoJTUGE/qlssAAyv7mrKDZ1sZ051mKWdijJ5C8LjIs2pTACvCXXiQR+/xLdykeO+N8GLr0KMeLNB83JWN3XweDDWeglSUDIgsQwSi8EKpTs49EGErj5yfbcFaro8iHRdWqujdZHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSaWKlw5ZeRmeP2Gc29abjp9jKKPN91HhU47wtwb4Xg=;
 b=JUSzyInraGwFZBQk/gOApZMdCnjr4o4dwXWkEdAuYTT44O1bdJR3W9pv/y8R8qoM+a20BSpudE0SeFxcU9GXY+emXsghYw2GBYmyxbf94RrkIdBi2zPqTPhGgPaZ9q//5Ar7jc078N47ZjyA8VnzCHSLZ6bv5HGqjmHbrFeNfPDPDgkQxC+bs6DGrfWkmGIu8wPiMM0DM5zkT8k7+oB/WVsCd8akQlnJz72EPwZmQ5uSurgOfiY8bGaX74wQfrH6YXelYZhbX/clvLYDYrC4+79n7ZtSvuYvxbQp0Kl38xRWrTPjX6DCeRRL3BdXVuaZLhekDL3mj5BZH27GFM0T/Q==
Received: from BN6PR2001CA0019.namprd20.prod.outlook.com
 (2603:10b6:404:b4::29) by DM6PR12MB3259.namprd12.prod.outlook.com
 (2603:10b6:5:180::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.26; Wed, 2 Jun
 2021 11:11:06 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::63) by BN6PR2001CA0019.outlook.office365.com
 (2603:10b6:404:b4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Wed, 2 Jun 2021 11:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 11:11:05 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun
 2021 11:11:04 +0000
Received: from r-arch-stor03.mtr.labs.mlnx (172.20.187.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Jun 2021 11:10:56 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <dan.j.williams@intel.com>,
 <logang@deltatee.com>, <linux-mm@kvack.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, <david@redhat.com>, <oren@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>, Max Gurtovoy
 <mgurtovoy@nvidia.com>
Subject: [RFC PATCH 0/3] PCI/P2PMEM: introduce pci_p2pdma_align_size API
Date: Wed, 2 Jun 2021 14:10:52 +0300
Message-ID: <20210602111055.10480-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8761c5cf-3660-4312-b7ab-08d925b71dcf
X-MS-TrafficTypeDiagnostic: DM6PR12MB3259:
X-Microsoft-Antispam-PRVS: <DM6PR12MB32596D3C7A8B7E5CC015C898DE3D9@DM6PR12MB3259.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAt8o6q6ucgAmo2fFioY0KiqGisUfYRlOm+goakZ3nQdvG6MIvlhJI3t3WSUCOaBhbew+STw3TySyEWUeh1+l+ReyEFy8PLmlW9RBpgJVX9oF3PHBpBBuLdsH0FqVsA4fISth4tsQkFcn0a60CoyciqzPJOTE3Xl/qp2sru2hmnkkgJNkCWwche/b0LXG/gLXcAP03249ySFafrw0BPQj3W1G7HyqEU4h2mb2yD+id5HOlBJXDZRiFM10uSW+2G0ioW/7ea7fu2/3a1ZzKCMqewa9qh85vG6fEEOYNv8UQdDqqb6dg1S7WDAcgCQfAkqflRpM394+8gY5aQX9nzg9/k222Q9l0Ppy7OINjQ1gxQcey32bwd3L3tcM2z7iQpHkcsBx7Xck0zQ9unh16opKclwLgSpxy2gExKYV9MSl+PvPvPtIDOCqB4v/tfTIwSSGHiVXeH5kmTpXOxymX9DQzm/sv4jXqnK90Svty2dXRnMWsJmtkEkVvPs2Z6z8+iZs3jziRCiZvyH6XEV+Xl3n/w0ew9JCgEs9U0oPQU0gtMVRNADIOveeOhPiM+t7RCuJbSWF2QQzJkHEx7lXuiPSXCH/HrNxAG2PpOOvJ+w63jluXseMqjb3Kbcs7pI3galfvCm1KVZ+xOPP5owRljBHbfC4/IWDrl4heTm1N3s9Y8=
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(36840700001)(46966006)(5660300002)(426003)(2906002)(36756003)(82740400003)(26005)(2616005)(110136005)(36906005)(1076003)(36860700001)(4326008)(70206006)(86362001)(8936002)(316002)(8676002)(70586007)(54906003)(6666004)(356005)(7636003)(47076005)(83380400001)(186003)(478600001)(336012)(107886003)(82310400003)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 11:11:05.7172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8761c5cf-3660-4312-b7ab-08d925b71dcf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3259
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210602_041108_547039_095C7090 
X-CRM114-Status: UNSURE (   8.60  )
X-CRM114-Notice: Please train this message.
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

Hi all,
In hotplugged memory (from check_pfn_span function):
"
Disallow all operations smaller than a sub-section and only
allow operations smaller than a section for
SPARSEMEM_VMEMMAP. Note that check_hotplug_memory_range()
enforces a larger memory_block_size_bytes() granularity for
memory that will be marked online, so this check should only
fire for direct arch_{add,remove}_memory() users outside of
add_memory_resource()
"

This restriction will disqualify, for example, large NVMe CMBs that might have
non power of 2 number of pages (e.g. 32767 pages of 4KB). For these
devices, the CMB size will be rounded down from 0x7fff000 to 0x7e00000
but it's better than having un-mapped CMB.

If we all agree on the approach, this RFC can assist as-is to these NVMe
devices and other P2PMEM devices in the future and can considered for
the next merge window.

Max Gurtovoy (3):
  mm,memory_hotplug: export mhp min alignment
  PCI/P2PMEM: introduce pci_p2pdma_align_size API
  nvme-pci: align CMB size according to P2PMEM alignment

 drivers/nvme/host/pci.c        |  7 +++++++
 drivers/pci/p2pdma.c           | 23 +++++++++++++++++++++++
 include/linux/memory_hotplug.h |  5 +++++
 include/linux/pci-p2pdma.h     |  5 +++++
 mm/memory_hotplug.c            | 33 +++++++++++++++++++--------------
 5 files changed, 59 insertions(+), 14 deletions(-)

-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
