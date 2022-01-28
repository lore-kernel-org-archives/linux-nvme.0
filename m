Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2545CC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 09:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0xq0X493ZOt0t2PSU2TwVOuXciz/1mCUGCOOincjfaM=; b=K5HsLMdswSmrKp8DJsyhF2iBlO
	3Q3WWrYCOHaeOeNHQ+YH2Bc2vNwg7ZZa8heJxoymmBMApCB/pIQ7Kz6N24neK5t9eccqadn3csR+V
	/27KDmnDPCUv6FiMGLElqCvuBkGlNU+x9RrsKlIqRro/2WLQ4ehy0wVxTGPPCfW5FzxWPEmc8DMb0
	7z0qqsh65NYVxuXIG+IfpC7PFiSk5TNvEW+Ud16WsYRPwai6iKZH6xmVqco1xoWaNo0vi6+in32PZ
	CiUHRguznTyG5aramwuOI+utSm5qGhiQLrDD5wjF+rCWy6yLo76AeEXHMB/bg5QPY3Rq3W+ENsJWu
	OZOsA8+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDNWP-001Efs-Hw; Fri, 28 Jan 2022 09:26:22 +0000
Received: from mail-bn7nam10on2042.outbound.protection.outlook.com
 ([40.107.92.42] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDNRw-001DAP-4u
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 09:21:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/kq0x+zTAb3e/ijeyPRXWw15n7pHRD4NlM3FqfV8DSSAGOy1HwRW9BroAdehKUee2XLziKtMe8UYXjADJv652Ezw02XMHdxynV4ZHxiy9mU2IwBvL3cOeS+UjkP3dvvE75IJ6e9gYbmnOVXi4K7ZF/3popgfH4vZHNc6/QDT5T9+GWlEqT786SXj/IUIN0U6kAlTSXaeHn8aVOjB2T153RMXuIs79xwtxET729TbxE9DF3/waxH+cOXpZh1GIAStc7/OG1fqQGbMa10Y6JbLyyuHQmbZhLl7m5BJS0H1FTAVOvEK5fd0f7YE/h+kUfeikcDQ0SDbsPGoFxh338POg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xq0X493ZOt0t2PSU2TwVOuXciz/1mCUGCOOincjfaM=;
 b=SAjlHPbLB5cdHKrufcIb9s7MNyxZh3d6Fa44R3mbLLHpVB/ly5sffyQLgBIqZTy8k0bBnvj9a+JIYMOX0qFLbdu6hQrM06F7npUXZ5MFNejm3xAS02B/5nsQ3WpDsU7WQAX1voenwuJEeISnF+XQjkgY9arP3pdx8/h0vEJ626HJeTNCO7mUFF1NNk92bLNiJgrLZpRfh5MBviULmKeHvOCnij/aHsBATAolihFuGQxWDATBwpKP0a99qH2uYx3bpGskjdqHiOBW5j+8kWfsBox9nITizZtIaYF4+VrnuB6E6v4CuFmm1GxsUMuoyhGaIFJqhOYppbO+M6szhHc5ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xq0X493ZOt0t2PSU2TwVOuXciz/1mCUGCOOincjfaM=;
 b=RWuLaUr8H3ILtuY0clKrhldPybvNwJWLCf/soFuzP1+GPXVvvh9Cy+oHys7YIjr747tUFDFe6yODAzmNpWvAXfkyFpUiyrwZXxVi2A8FPsp/bQx+yPV+yYRNaZLmxyy1fRULYxK6BbyiZAQ7XRqmy5+g9uL90m3RB6euMjaIUG53aspTWHClC4rmRpPo8FO6eIjYFQgnLv55yUihcoIyGrd6DdwomguWsqwTzb4CIlbGkpDp1xyRp7NjrMpNnuYbD2yMJXBaTmfpKI99YZAmHg/ai5BnywzMxauriVJr6fWwWDyiRmeOkljkFPO7pucGyEUiuzQjji65eltv8pXIQA==
Received: from BN0PR04CA0051.namprd04.prod.outlook.com (2603:10b6:408:e8::26)
 by BYAPR12MB3192.namprd12.prod.outlook.com (2603:10b6:a03:139::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 09:21:41 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::ba) by BN0PR04CA0051.outlook.office365.com
 (2603:10b6:408:e8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 09:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 09:21:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Fri, 28 Jan 2022 09:21:39 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 28 Jan 2022
 01:21:38 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH 5/9] nvme-fc: centralize admin tagset initialization
Date: Fri, 28 Jan 2022 01:20:11 -0800
Message-ID: <20220128092015.19289-6-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220128092015.19289-1-chaitanyak@nvidia.com>
References: <20220128092015.19289-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: drhqmail202.nvidia.com (10.126.190.181) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c923db9-51ff-45ce-fb3f-08d9e23f97b0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3192:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3192547CD2531525EEFF0868A3229@BYAPR12MB3192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DoBZJY4X0Qf6USlgStLXwxwz8ZzT0FpfG/m1UFnFZvT7cl833KPhhs7B7ygaGTAZf5oIitdwgacr5lwo4PSECt7S0bcZbcbLN9mFGYpbpp3Vt8Gx7gMmMTvnSmQSwOnqlPC3cN4zuBpR/l/UhociNvmeZRHXHicJXFhWisZVhpp46TCWK3f3BqBE4so5/a+1V9BIniLR4FoYodBb2kvhj8meXH0ca5e78fHP1YC4cbG//DzNFRQYrlcNjM0GLMTWZm0fTa+rY9NV8qu7JFoCSmVzYiYLng7gRHnyBovIIWlzKQGw2sw5KqLD5/SOGJGRyks3xZ+aqRENT1Rb2JdSQXUj66Y1VY+Qa2dkaV/WpKPQsu239UyUcm9DtX1Ca1Fjcsv7PIHCXXMmUwXTf6Aq4frEOaoQ4vFRRwchtXC0HdeNlS62fvMXAxAalsXIBjx8gRRcywtqI3kLq31vdd0BiGiRytXYF+bUP1UcGE35fFaGfnojfXbSZwOrDAOuP8icqQfwzbfilBk82WKHmadqtZGxh0wqEY5cvPDnG+mhlTXEgu9w16yh1PSxTOgmlw2CBA9oYXDMLq7xaQiMEtpANiajLgADyO3kG4yuogb+PH7/0BTOdXyqbUESaFU/aH9xosrjZ8AcFb8fsSxCfFwH1Cpzk8/fK2042bwTOBeOH49ZlN/54n7gAL6eNgHwCG9mUiQDZARoUsoRe9ABKADo6A==
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(70586007)(86362001)(7696005)(70206006)(26005)(8676002)(4326008)(8936002)(2616005)(81166007)(36756003)(83380400001)(107886003)(356005)(508600001)(82310400004)(47076005)(426003)(336012)(316002)(6666004)(40460700003)(5660300002)(186003)(1076003)(6916009)(16526019)(2906002)(54906003)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 09:21:40.3848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c923db9-51ff-45ce-fb3f-08d9e23f97b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3192
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_012144_246224_83217ED3 
X-CRM114-Status: GOOD (  10.36  )
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

From: Chaitanya Kulkarni <kch@nvidia.com>

Add and use helper to remove duplicate code for admin tag initialization
for all transports.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/fc.c   | 12 +++---------
 drivers/nvme/host/nvme.h | 17 +++++++++++++++++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 23c896a138a3..ec2afedfa991 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3529,18 +3529,12 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	nvme_fc_init_queue(ctrl, 0);
 
-	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
-	ctrl->admin_tag_set.ops = &nvme_fc_admin_mq_ops;
-	ctrl->admin_tag_set.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-	ctrl->admin_tag_set.reserved_tags = NVMF_RESERVED_TAGS;
-	ctrl->admin_tag_set.numa_node = ctrl->ctrl.numa_node;
+	nvme_init_admin_tagset(&(ctrl->admin_tag_set), ctrl,
+			       ctrl->ctrl.numa_node, &nvme_fc_admin_mq_ops,
+			       BLK_MQ_F_NO_SCHED, NVMF_RESERVED_TAGS);
 	ctrl->admin_tag_set.cmd_size =
 		struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
 			    ctrl->lport->ops->fcprqst_priv_sz);
-	ctrl->admin_tag_set.driver_data = ctrl;
-	ctrl->admin_tag_set.nr_hw_queues = 1;
-	ctrl->admin_tag_set.timeout = NVME_ADMIN_TIMEOUT;
-	ctrl->admin_tag_set.flags = BLK_MQ_F_NO_SCHED;
 
 	ret = blk_mq_alloc_tag_set(&ctrl->admin_tag_set);
 	if (ret)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f8658f984d64..6a3fd759415a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -938,4 +938,21 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
 }
 
+static inline void nvme_init_admin_tagset(struct blk_mq_tag_set *set,
+					  void *driver_data, int numa_node,
+					  const struct blk_mq_ops *ops,
+					  unsigned int flags,
+					  unsigned int reserved_tags)
+{
+	memset(set, 0, sizeof(*set));
+	set->driver_data = driver_data;
+	set->numa_node = numa_node;
+	set->ops = ops;
+	set->flags = flags;
+	set->reserved_tags = reserved_tags;
+	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
+	set->nr_hw_queues = 1;
+	set->timeout = NVME_ADMIN_TIMEOUT;
+}
+
 #endif /* _NVME_H */
-- 
2.29.0


