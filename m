Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A413C47077
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Dec 2023 00:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ee3+7H4vFWJXHe4UmPuPp5Cl6Yq3KjNczcPZe/pnhXw=; b=4W3+5/VMGxcZCtsiR0DyX0n9bq
	l2FzUmOxL/M8XAvIAuqi2byHQE6mto+QIy9NKKlRgjSa+LWz5aZ0KWX44JRxD799AvnjS4lzFeplP
	DjEwzivaok/Q42+l/jaWBfCdZpNlkFWT/Omv3VUD6NpjwaKB4FrEX0TaJPs/Sfq+jlwru1cQk27r2
	FcfhFC2o1vPJ8neKV9CWprxbYzk/oZv5DeE7YvqYckOGVNJv5UgSvK8C1Xv9fKh6UJvK2j3bQ7w/Z
	iRJdIDR/vpLZK5UflxNYjJJsHSrFMCRsuEz+2NGB7ZnLke3LMM8cbLTKkf87JO6pH3suHvTP6UC3l
	hEghAFBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk4s-003fzh-2G;
	Sun, 31 Dec 2023 00:53:18 +0000
Received: from mail-dm6nam10on20625.outbound.protection.outlook.com ([2a01:111:f400:7e88::625] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk4p-003fyd-0x
	for linux-nvme@lists.infradead.org;
	Sun, 31 Dec 2023 00:53:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYgTP/bfLSOEkaqjSECuVmq0nW1RO7Wb73B+YM/TAx2sOiJpfYdu7pcik3XGuA4O2e3He+EbgSgBQQC1zw5R4hz/Fbt0En53+RxSiIWu525a9rI+jMpeJv3Snc94jwDWOZU/vHfW6aWVnVmW8UhE2qGxaYtx59nArdinWeS87GFifOqEJoigj68VfL52mQpz+CuKwoO69yw/ijD3FlMuaM9Mow/51/qfHOS+g1hD+gquVoS64YFu8wVJPl13cN3SZkCltAu+jWZb4gs+mgoEB+d++6n0H72rMr3YvWj/lAMAg6z0bKzsV4NDJZGbkZix4zTWdmyM9aGkq6JNjj8Z8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ee3+7H4vFWJXHe4UmPuPp5Cl6Yq3KjNczcPZe/pnhXw=;
 b=l2KtHhdviYqb1Ml2yQAxyfl/9Z6OpOLuMU131RQA5DkdBPjs9g4uzQFQLQ/5rLQB6zn6HmPuqvtFDGY8mdhdBv3nqWvQu+yJXUiB87Kyfv3IQChXpJjtnqZmNlA8QUV83E/3zzM3OMMeN5ivlYsAnoUZXOm8P7SvtM46Qh4egztzlEmAhzvgT7pw5O+aBYAlLsCFCBGx9fjGJX2LIuz89WqFZX0UZ/wG8Wmtw4pLjr6EEpW3viiOI01pZ65+OqIjyMTvF4dVLHH9N0Wrl8g1iP6p7eCml96To1XCNCTq08v/oZB44xkpyQHndoalW+oGNtFcfNHp/gSzwTXjRYYnvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ee3+7H4vFWJXHe4UmPuPp5Cl6Yq3KjNczcPZe/pnhXw=;
 b=stLxv+e+BiXY4tAbQ9x9X4yd7J1FC7174qAGXllaTcJh810AC54QvLuALQ6SldE2e4Bq0Pyw5QuKSEjGfFbVk+1T+8dtg0LF0dIx7JO+oyZh3bj/ADg2nr6Cn7iW5CTmw8U6MdHeApw2xEYvEsmiP+nXCUKw2agbp9CMNFfwecUsS97JQ+IKiUcGfLs5QSA/J6Lv5B3YiRY/RuhUCwmN0ikqyBHuQjpnbu8kEzNtLJ5/Y/JLsC+1Rxzlgefu7MfzesMF5v5BgActrTsGOi0UscHObyJwLXTwMKXl/8+ERxZJP1580tr87vtoUuhP5lw2eorS63pOrlnXBEEpT/JiyA==
Received: from DS7PR05CA0016.namprd05.prod.outlook.com (2603:10b6:5:3b9::21)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.23; Sun, 31 Dec
 2023 00:53:10 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::97) by DS7PR05CA0016.outlook.office365.com
 (2603:10b6:5:3b9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.8 via Frontend
 Transport; Sun, 31 Dec 2023 00:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 00:53:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:53:03 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:53:03 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sat, 30 Dec 2023 16:53:01 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <kanie@linux.alibaba.com>, <oren@nvidia.com>, <israelr@nvidia.com>,
	<kch@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 04/10] nvmet: remove NVMET_QUEUE_SIZE definition
Date: Sun, 31 Dec 2023 02:52:43 +0200
Message-ID: <20231231005249.18294-5-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231231005249.18294-1-mgurtovoy@nvidia.com>
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 1524add1-f233-483e-dcd4-08dc099adc0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGcp5hR0u2K1M3lvU/+blPOZyGBQSlzdxPahBzPNnuAWWqXTOpIpy53wEbvWrdFMhyk9z2Lm/MeWIqq2+y+6cEZ1X0y/UaYM2OrnEb9+zaVCmpW0ZbVgiw7phwmDOqmYDO5t2wLJY/BX9tSDPFpjyk66FvtlMrOXXyRZ7dt2k6XQiL4p5w22QETTcEYibt52QzCUC1SQ3k2ICwe27oeOaWUbyONXjJvw/j2dsJXEEm/Aajs6NDViIcS+DNQj+uQ3OItlqd26iiKKHg2MsidkJQ41nk7o7LfdxIOZxKsoXI5JfkL3aj5oQRsyF50z3x2RRMByfirJxDBckvg4ArjRnxUgNqHnWod9AKvOwQ7D9tc3GysaVvalpJ/jPpPqhh+c1R2gYY/J9LV07N3Mjm2OEeBWWn+QkwsjKhMLlW8u4Zrjm3pVjao/FXf6eqQPZCqsBIa02RBKQyBI1uL0JDDWhh9KC3P+EJdIIa02O75m1usmgcb1JJXqt3XRcE4JnefoTnSsl9OB0uW+TNpJHR653ohPbJOokQOmzqgI67y/UTuWw+8ZAIjH6+Ozswmi5R/7ok+tuPdpMZMwzAeDpjK6L2xxyqSl/JMOXqUkkK/7sw/08va7JTcjL7Hj1Mr66nVLGqByQ0mWpqVGC7hQm5siaR+yb/KCFXp0ARm3IUfIp+VfIMTXsbr33nCBYuCH3+IssIFYbYwqQaaNC/zEjb4YvgJtjClD1sGuQKhsqmE1K77SI4DTlwfcpL/FT1SwKtPI
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(40470700004)(46966006)(36840700001)(40480700001)(426003)(83380400001)(107886003)(1076003)(26005)(2616005)(40460700003)(336012)(478600001)(6666004)(47076005)(41300700001)(316002)(54906003)(110136005)(70206006)(70586007)(36756003)(4326008)(8936002)(8676002)(36860700001)(356005)(7636003)(86362001)(82740400003)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 00:53:09.9714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1524add1-f233-483e-dcd4-08dc099adc0d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231230_165315_337062_30191512 
X-CRM114-Status: GOOD (  10.29  )
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

Use the common NVMF_MAX_QUEUE_SIZE definition instead.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/core.c  | 2 +-
 drivers/nvme/target/nvmet.h | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d26aa30f8702..128156145d29 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1225,7 +1225,7 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 	if (ctrl->ops->get_max_queue_size)
 		ctrl->cap |= ctrl->ops->get_max_queue_size(ctrl) - 1;
 	else
-		ctrl->cap |= NVMET_QUEUE_SIZE - 1;
+		ctrl->cap |= NVMF_MAX_QUEUE_SIZE - 1;
 
 	if (nvmet_is_passthru_subsys(ctrl->subsys))
 		nvmet_passthrough_override_cap(ctrl);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6c8acebe1a1a..bf99c58aab52 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -543,9 +543,8 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page);
 
-#define NVMET_QUEUE_SIZE	1024
 #define NVMET_NR_QUEUES		128
-#define NVMET_MAX_CMD		NVMET_QUEUE_SIZE
+#define NVMET_MAX_CMD		NVMF_MAX_QUEUE_SIZE
 
 /*
  * Nice round number that makes a list of nsids fit into a page.
-- 
2.18.1


