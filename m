Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304C1C6FD18
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Apr 2023 14:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D8nmwQsNxBCNLUdxpQo0CuuUF6jcsFhD6ki8Bq/5KUg=; b=KqCzkNm0Eag3222OGe6cHYc3Ra
	XyPCYAJiMnXipW9TLAVbmoKcG66w0baHV86GMfusXswCcig7p9PJcHYo9KHN9WajbJhp4OYAzThI/
	lwkYDbUH2oDrP6rhGCei6C5yv8svEc4GBjTwGDLTaVGydZtMoIIGCIZn4+VjNPx7v9+VueSwT5aOs
	+ECa5bUTV5Wm8OUuskZSnik5bZXMjD0CBlHQ3DTbWiXjjb092LVk3AEw89T9EMjv1Ur1AsSru0jeo
	xEM+HLwhgWQwDHSB4I8OZJqcUoFojdAsueLsnMl6vo/ki5YqC9rqkEEmnaOX7aAquR561U6ki0y//
	lWdyBoKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqaTL-00EOUK-1F;
	Sun, 23 Apr 2023 14:13:47 +0000
Received: from mail-bn8nam04on20614.outbound.protection.outlook.com ([2a01:111:f400:7e8d::614] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqaTG-00EORF-2g
	for linux-nvme@lists.infradead.org;
	Sun, 23 Apr 2023 14:13:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqRhgCj1besjdNz9ObyDPhUV63pNzl9IEKPhccP1XLzr3uOeJbURCQUG7B2DyqlQyRtsp7X33Sju+DlqWTsLS90RKHPcHV/xfuMPOu1NjijWsCInTS041kBd5CHIrxu43C/096V2M5KMdjjZuG7iyIuKSrPMharMIarNKxGVjZo8i3pLQ+7fGDNTNOtjl8GZSLoRQhFQMHDyV/S4x4Z9DMc3PC44xqaYNUwy1SA6NeXElSJJTXl9Cq4VaVNHgxIUMMBB/R07Gb9U9YYyVYSR8Sgyx8B7bYRpPlTu84k1lsf1sNAQEjyOYoKanKnPIdlMN6htTJpKa+DVk2HMy2pcxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8nmwQsNxBCNLUdxpQo0CuuUF6jcsFhD6ki8Bq/5KUg=;
 b=NlsZHWNuLG5ntoZCMG8rX8QPxOMkcGVeg4TD+OQYQZZFwatZm+AYaVmp/0xQP0RyCWVrxgI/bjHunepfYDFr9XO7yxbXrEbJxSY8rM3x4tv8nMSNbD337QnAAfb2lavpKrYOmU7eGPzNKjMJ1XQiccDLVxtoI0tZZ/0CREqFevUVk/2KWQ7oy4EaIaFK4ED7nFvk3SUEvyiTJlIRERRUBKNEROBBdoIfFv7fOgo/rcLhVbwY+BDVe1Ut34uRnjrpHb3EiQO3EdzDGOnEm14sQA6zYAapIMthmvwHWSn9qHOnnN/nqWkibMGbbTqw4pVjhZJKyUk1iyMTw+obS4b7gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8nmwQsNxBCNLUdxpQo0CuuUF6jcsFhD6ki8Bq/5KUg=;
 b=oho4sckpAU8Q0Qg+Pqemjs6TmftusGo0915kY+zHwTpUn5j229QlP6vmZag8FV8VIhFJD0cTsROob6gEyWcGbTu87/yssB7ER6ipvT1hmHvcoEavuahFbwhZF0rSDvjfJ7tHsd80afK0aRXwGAK/CX7alsEUbcieZ0kDm/xyOWFW6N/p+ys+xahuMjRKrN3OY5MfjCl5Iq7ZevJ0Lr81TQt1D5UhKiLsVKeH5VJSu5lMajY+MqWg8Awsx1DHyCwJ1Mrjte+jI/c9220bAGVrdaeGYKWVGYwZn/nRioeRfZNv6acEk+EQNR1zo1/d6JPopuEgV6r+cqLERSwVAXF0Rw==
Received: from DS7PR06CA0047.namprd06.prod.outlook.com (2603:10b6:8:54::27) by
 PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.32; Sun, 23 Apr 2023 14:13:38 +0000
Received: from DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::14) by DS7PR06CA0047.outlook.office365.com
 (2603:10b6:8:54::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32 via Frontend
 Transport; Sun, 23 Apr 2023 14:13:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT115.mail.protection.outlook.com (10.13.173.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.18 via Frontend Transport; Sun, 23 Apr 2023 14:13:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 23 Apr 2023
 07:13:37 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 23 Apr
 2023 07:13:36 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Sun, 23 Apr 2023 07:13:34 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <martin.petersen@oracle.com>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<oren@nvidia.com>, <oevron@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH v1 1/2] block: bio-integrity: export bio_integrity_free func
Date: Sun, 23 Apr 2023 17:13:29 +0300
Message-ID: <20230423141330.40437-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20230423141330.40437-1-mgurtovoy@nvidia.com>
References: <20230423141330.40437-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT115:EE_|PH7PR12MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: b4204af7-9bf4-48bf-f161-08db4404eefa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	Zf8OLDweHYSbtIi5E1VH1Yt4SoQr4rc3ZzRDtcRR7zHAaEzva4muGlR+FoEHogYyba1m6ClNKowXsgu9N4ULrgD4naq4fadeE6Ob4PhGtoomYzCQrX3ZSBSFf/DL0Yl9LxMsy3r3z1OR7rFaP+/nWVw+1tC2e8xqRy9heiOsiTwnlaoNYUYAJUvhy5KenuKPvRlSPOOwCU2LLzW/W+Lf4KcUzHOHb9ID6LaEeJpuoq6k0gVGSb3gkPFQrkLtADVwtfA8G2eZvUHrEcOEP4wbtIPK1m3mS+lcSam6Ym/c3mgRQUjzQYKcBGTwcBKM1LmzBuIuFvUGLJCV6C88lgMFFifj1svPnmX47w4A7WJ5oDRscinqoxA1K55HfYDGDf9R9fH36qjv9JuhHDjyMBX5nWnplKUIjHyk1O/ikdEOuRAhYJUfg77Xd3WSj+uA9Hx3oxRTIs+pnEqUJ2cw0dzx9t8/gRnHFtvJjgDMNv3+8wOuBO3ZW03MV6KwyS4HqCrdqEvxSikNxkDUd8RBnd7ohcOY3OLHD70+GGehXcKMFK9yUvTOrIfKeXa/gUhVmbYBcZnsDJXdx2Gg/QI0fgjeynwrK5N/KKPJGxd92hTAqWZDwmhRSN7knpsfsvnh4H1TGK4DVEV72WeqyjUN7z88sbvLo8XemWXQeDWlBl9SWupGQFwTwKZfBELa0lhISa6BwxGl5DtdAoPWOXKZ/i7r8BrVxZ9hxoH+vw06gsDthkU=
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(107886003)(1076003)(26005)(8676002)(8936002)(4326008)(70206006)(70586007)(54906003)(316002)(36756003)(110136005)(41300700001)(478600001)(40460700003)(6666004)(5660300002)(40480700001)(36860700001)(47076005)(7636003)(356005)(82740400003)(34020700004)(86362001)(2906002)(2616005)(186003)(83380400001)(82310400005)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2023 14:13:38.1632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4204af7-9bf4-48bf-f161-08db4404eefa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230423_071342_926862_9935BB17 
X-CRM114-Status: UNSURE (   8.53  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This function is the complementary function to bio_integrity_alloc.
Export it for users that would like to free the integrity context
explicitly.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 block/bio-integrity.c | 1 +
 include/linux/bio.h   | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 4533eb491661..276ca86fc1d3 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -110,6 +110,7 @@ void bio_integrity_free(struct bio *bio)
 	bio->bi_integrity = NULL;
 	bio->bi_opf &= ~REQ_INTEGRITY;
 }
+EXPORT_SYMBOL(bio_integrity_free);
 
 /**
  * bio_integrity_add_page - Attach integrity metadata
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d766be7152e1..3888a609b4bb 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -700,6 +700,7 @@ static inline bool bioset_initialized(struct bio_set *bs)
 		bip_for_each_vec(_bvl, _bio->bi_integrity, _iter)
 
 extern struct bio_integrity_payload *bio_integrity_alloc(struct bio *, gfp_t, unsigned int);
+extern void bio_integrity_free(struct bio *);
 extern int bio_integrity_add_page(struct bio *, struct page *, unsigned int, unsigned int);
 extern bool bio_integrity_prep(struct bio *);
 extern void bio_integrity_advance(struct bio *, unsigned int);
@@ -764,6 +765,10 @@ static inline void *bio_integrity_alloc(struct bio * bio, gfp_t gfp,
 	return ERR_PTR(-EINVAL);
 }
 
+void bio_integrity_free(struct bio *bio)
+{
+}
+
 static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
 					unsigned int len, unsigned int offset)
 {
-- 
2.18.1


