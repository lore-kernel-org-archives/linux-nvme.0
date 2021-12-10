Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365F5C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Dec 2021 11:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3b9Qt3Gk1R4LJwdOhpqtGSV4gLhVYdbRj4q7QIhK4R0=; b=etgKWPMiLMbSBn69KZGogRyuoE
	U1bLxE5uMQMW0qVzNvWe6UUXcgkgWFbCfAwdJajq0zkxPwFvsDaizWGaAoR26iKX7mB45DRBtmMH8
	riCTn/zQwQCrXoJElGvDFc8r0mhqZxvxDP53HRQf9JFyiYm1TdrWFk2vDQM0oRU8guV35FE1yw5xA
	4M4ndAAAlm6+AWBBTaVLpSVZgjNgsAk3fSfl5kXp8QKtxU4BfuUXYQMnaDZuLXsu1AwVidXa5YxNU
	5sUc5MKyFUlnyljJPJ7dBlLB2hrlervtIgovKkMXKcD9g+do2R1Irr/tku4ZK3TXVFQdjUirCNThd
	o+IaYVRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mvdyS-001dn2-TI; Fri, 10 Dec 2021 11:22:01 +0000
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com
 ([40.107.243.43] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvdyD-001dhd-8R
 for linux-nvme@lists.infradead.org; Fri, 10 Dec 2021 11:21:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHzBJHjXpPTCB6gXHFFkgRypsoMB5kxBmW/zIdRwvl4/m5QSPfUq9TJrfdEcn3WSwQv1a2pTarLdnlUvwY/oSXEDlBjxyuSZg0TdPuAyY7jGl7MSEcy4Fe+VAOxXdh9p0UazdnogvhqII1BZKz38eGEdrs5r/UvCswm/M4luC4CRwvB+0/UqN/Kp+zBmRs4JHRuXBFwsuaCPiyrHCvPSQ0z5TZenI0AF7dFcRLG2afjHS52Q6RQY5w+RTmr0oRQ60iSayuqzwIldFF7EjyY+22o64mZg0AQ+6eEa+tq5ilLd9PvJJQRAb4UysiQ+UR0KMdMA4B0LzGTgWRw/enPz2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3b9Qt3Gk1R4LJwdOhpqtGSV4gLhVYdbRj4q7QIhK4R0=;
 b=Fddk5qAQ9SyAkeqtdCaws3Bo7B1UUtfGg0cnsmXGqN6ehYKTSPcnZZeNUxftCXA9SVJALyUMxoSPrDl/Yd4N01IKZiQgplO8UHkT3ILO4tQ5PSQnlxsztImIUDu9n3HK+yixG7HltUltlqumM/Jvr52cRrElkXLdS3ck/Tlcy36YRmagTLqkJtJWoJDvak/8mCUqswl2RTWNb2qWclHFV62iLEZiWors5l+soWpYEeXO4QekrJco0yB2PTDs1EmWvLOknwI1WftcaROTH+XTc3u9TLLryA/iD65tme0Z+rrwBBmnFJNkMRcSsoNz1Vbp3oaWEyiMFn5M3QmbT4G1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3b9Qt3Gk1R4LJwdOhpqtGSV4gLhVYdbRj4q7QIhK4R0=;
 b=sdypkzGB8/9Fka/c/QNuwB5Ny1Krp13iW49N2PD4wNdWBFFdARXNz5P4xD34UDGqvNcIYxasssp60XDibxNQ73rlIRlNO8MfXc4nX9sziz+YRhWm9XUlABYvjY37Y23lN4upzlFmzTRDtlwa+vNTekNLJJstHkENsQz8tusvXIg8tZggA4njx60vqJoIsgTry+e/akAtvxI3RiCvXr+mABIrvht8CSG06GxZqpKd3ixojqLC/ZOVrRDAhTJRF6qNPauUy7Cv5LtGdpEMTmWHlLLMPwArbGcyAX1+CC21yzOKz6WsOJhSMnUxh9NeIY2xZdc/lNEKIytCW8ZErofiQw==
Received: from DM5PR2201CA0001.namprd22.prod.outlook.com (2603:10b6:4:14::11)
 by DM5PR1201MB0075.namprd12.prod.outlook.com (2603:10b6:4:54::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 11:21:43 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::2f) by DM5PR2201CA0001.outlook.office365.com
 (2603:10b6:4:14::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Fri, 10 Dec 2021 11:21:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 11:21:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 10 Dec
 2021 11:21:41 +0000
Received: from dev.nvidia.com (172.20.187.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Fri, 10 Dec 2021
 03:21:39 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/3] nvme-core: make cid gencounter configurable
Date: Fri, 10 Dec 2021 03:21:14 -0800
Message-ID: <20211210112116.9299-2-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211210112116.9299-1-chaitanyak@nvidia.com>
References: <20211210112116.9299-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2afafc2-0bb7-47db-0224-08d9bbcf3e7e
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0075:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0075CFA178869A8F43A9B676A3719@DM5PR1201MB0075.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: et2DbzTmM71rCLBksXhBqOdti6vF/HtL5AGDrKEBWPrNZTURpbhbhZUv7mb/qozt1LvIkF64HLwg+fFx062FRIe/aK9v9ORvaBfEW8rfO5AQ9ZborJESj03viPSN8BzBFrtVPd+0TxXXbhb/2THPzAKdn9Xi1prasnPAS0jdgq60HHPrNygL2KGMFLvx6B+xvLGb8PAGuctWC7jY9IDmvuYXKC60pM5BHF5bNCNCU1F3jC2RgLhvUKQ7IzvZDKrSM7jdgvJhaRRcJL3ZZUmnybtSvwVVTduqEWos3Jf7S8u6N3woCam9YSsrwjjCFyhOwzjSBjU/Zm8Ux2+FbWV3pR7XhDnn4LlCqEI+f8ie0A4UrdA06VWJWBmhZE4wHftqdifkP/hPPLYJy6zIZinXWGq2Pz17Q8X9aD709hDm9iFqJkeDwPZm+19AbcS/xTuTtrDjiHQBqawe4Syh0ido+593KlPyLOyA34Ns3aR20wrAdizRBMjdarP4H2vxkai1ne7vXAPr94VfdTrMaQbsp1YKDyQwI0oKPvarzyyAkqk7vEAR61P7N7lCQ6TCrZR2MsczTeS2otXooTmOy2kjN3ByWpv37teq+62NQSHmEt36srcinMwwlmYVqfI6AD8y4vWe6oIFJ8jj/ZOiSmFeR9Z4mdEmgHptCXKHTMcwfAsXXt67Ji53PmCcQvnE6Zm0rfL1zIQ861HMDGFwSzaqxg5iLOw352C0mtMMwquXTyXAE0lYzZMfIwr5BZhgDk/D/CwG0pmUici/peLPaOu9XhsBlsG/jJ+Hl/+ulBP5tsU=
X-Forefront-Antispam-Report: CIP:203.18.50.12; CTRY:HK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:hkhybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(82310400004)(8676002)(8936002)(36860700001)(70206006)(6666004)(54906003)(1076003)(508600001)(110136005)(316002)(70586007)(2906002)(86362001)(83380400001)(4326008)(107886003)(7636003)(2616005)(26005)(186003)(16526019)(426003)(336012)(356005)(34020700004)(5660300002)(47076005)(36756003)(40460700001)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 11:21:42.6248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2afafc2-0bb7-47db-0224-08d9bbcf3e7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[203.18.50.12];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0075
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211210_032145_341070_12C6DDD4 
X-CRM114-Status: GOOD (  12.12  )
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

The recent commit uses a combination of command id and a gencounter
to calculate the command id so that we can call out buggy controllers
for spurious completions and that also avoids use after free.
This commit adds various if statements and bitwise operations
such as &, <<, >>, & along with comparison operations to validate the  
gencounter and print out the errors.
 
This feature is required to catch the buggy controller, but in the  
production environment where controller is validated and known to be
stable this achieves nothing but adds additional code and runtime CPU  
instructions for the PCIe controller.
Worst case scenario when NVMeOF setup is using passthru backend then
these instructions get duplicated on the host and on the target side
for each controller.
 
This patch makes the gencounter feature configurable by   
using new macro CONFIG_NVME_DEBUG_USE_CID_GENCTR. We move the current
tag + gencounter code when CONFIG_NVME_DEBUG_USE_CID_GENCTR is defined
and keep the original code where we use tag-based command id where
NVME_DEBUG_USE_CID_GENCTR is not defined.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/nvme.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b334af8aa264..98d7627cfdce 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -153,7 +153,9 @@ enum nvme_quirks {
 struct nvme_request {
 	struct nvme_command	*cmd;
 	union nvme_result	result;
+#ifdef CONFIG_NVME_DEBUG_USE_CID_GENCTR
 	u8			genctr;
+#endif
 	u8			retries;
 	u8			flags;
 	u16			status;
@@ -496,6 +498,7 @@ struct nvme_ctrl_ops {
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
 };
 
+#ifdef CONFIG_NVME_DEBUG_USE_CID_GENCTR
 /*
  * nvme command_id is constructed as such:
  * | xxxx | xxxxxxxxxxxx |
@@ -538,6 +541,32 @@ static inline struct request *nvme_cid_to_rq(struct blk_mq_tags *tags,
 {
 	return blk_mq_tag_to_rq(tags, nvme_tag_from_cid(command_id));
 }
+#else
+#define nvme_tag_from_cid(cid)			(cid)
+static inline u16 nvme_cid(struct request *rq)
+{
+	return rq->tag;
+}
+
+static inline struct request *nvme_cid_to_rq(struct blk_mq_tags *tags,
+		u16 command_id)
+{
+	return blk_mq_tag_to_rq(tags, command_id);
+}
+
+static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
+		u16 command_id)
+{
+	u16 tag = nvme_tag_from_cid(command_id);
+	struct request *rq;
+
+	rq = blk_mq_tag_to_rq(tags, tag);
+	if (unlikely(!rq))
+		pr_err("could not locate request for tag %#x\n", tag);
+
+	return rq;
+}
+#endif /* CONFIG_NVME_DEBUG_USE_CID_GENCTR */
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
-- 
2.29.0


