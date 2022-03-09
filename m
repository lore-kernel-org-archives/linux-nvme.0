Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73910C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 17:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K9nvjLAf23BesISJ9cHHFlJjpeShNCVsUBZDCBEouUM=; b=l0a+mWzeMm+UfvR9WRyhjKunr/
	4AnQ7J9K31flFA480mp7QcYIfB1Rq+cKFdnTQ8fBw1XE+0dI6oeKKUJnbY6JVqwlnqTcDFpsrPNqz
	tp3POuKG6oSKEi0H8uMJxPPrdlVZHJ+1cyMEriNactlGAdusvQEMlDw0LYndRceaQGhzxxRSceOXz
	tufuCUsXHLT78mzLTzftbWl5xJIrfwLR1N6bOoSAT0detaRu4pkyte7pm47aHriQ6WEQNa/nFz1zX
	1xRKcuBeVXxteVxBTS13Hd+CnV0O3uNmnmEu6/0/1Pmh3fYJvmAcI+6rTdEp0DUT3OM9qc9ZLb/Zs
	L2OdIfPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRzo6-009htt-VV; Wed, 09 Mar 2022 17:09:03 +0000
Received: from mail-mw2nam10on20607.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::607]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRzkr-009gBR-0i
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 17:05:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/5cBu2c9s9W0gaWp0ngmlrjQvB79ZqJTwePHuf2CevqIn3vR6ku+D9WehFu/dFmdAohoUajrnRNrAQFlSqLxYgcLBqW6U+xcfXWmsa/MV8wZIiXtCwh4i5ARn42GcmqC5GjKVlkZQuNoSJZsgMbXkHYE93RXgbrk3IPhUfR2Ve4dmxqDvKXEfgU0o/KKzmDZC8KXaokOL4OMY1sP3bNkD3c35aXVFxLivEDHUQcmBWQndsDgafAQgCSN7s4DPRz+QOfRMih3O6pViUEkjHdNFRA8b9tqUIRaRtYY0+y6T53jpEReVcvaEaA9eEIOeEpHXtPQa6Fr6itttcjZu6jaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9nvjLAf23BesISJ9cHHFlJjpeShNCVsUBZDCBEouUM=;
 b=m5AAUs1/c8jiXltbJ55ZJuNoSMSUgnYBobOsQD5eX4NZ8vQs1S05f6DK19QKVr7LbVmlq4Y3pdwuT2MVnSWAya1A5zq2Qxd3nMTRA4Z5YY37cEWIJyMM2H/WgczsYGxStHYhl2KNiMYQa14ZgCy6ARpKmHpskQ6wzjjRvUlm7gfeHCxFKEaiaPS0VFqZF5b/6f0WYkrOJMebcu5+urB7D8Nj0vDPGkD4DbRH8vTAFja0Rkjyo+9RguJSWvFu2edeGSVQiv3f3N2zjXi3z+QLC5pD7ccvmMS9TEisADXA56uMCWlOQfsSCTWa8xg3Snvb3oxNgiWYqT4IyXn0CWuoSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9nvjLAf23BesISJ9cHHFlJjpeShNCVsUBZDCBEouUM=;
 b=D3y7lsq1bqQ/i9rGy1N0Ct1hA8HSFpTpnXvml5O+OarU3WuSHrS2imOHjnnYj4IZnt4Uk5844JUGoTkwkh4KhnR9+mEScVBJNIeaINgRMX4rftsq8pHTD06XsKIqIeeTI4E/6t9E6j+pxvIAscHpJuNJXpue8vrU5I0GU+h2itnIp+InadxPhQE90d9qv69zgxjrkt+JqSmvF0rJ4RRPH6NVdMsCk6cDG/71tvz3ElBE/g/WCzfOnnQ7xKj63fZIWu9sXw6XY8gBJ9ezkwWZpaC3U8OCpvCeDkT9hEKew5hfcJ2l3lnocyEkuibqnUaF9gP/MDYQVYYkbBRY3chvEw==
Received: from DM6PR14CA0060.namprd14.prod.outlook.com (2603:10b6:5:18f::37)
 by DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 17:04:57 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::b6) by DM6PR14CA0060.outlook.office365.com
 (2603:10b6:5:18f::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.27 via Frontend
 Transport; Wed, 9 Mar 2022 17:04:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 17:04:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 9 Mar 2022 17:04:55 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 9 Mar 2022
 09:04:54 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [RFC PATCH 1/2] nvme: derive zone-mgmt-act from struct request
Date: Wed, 9 Mar 2022 09:04:36 -0800
Message-ID: <20220309170437.4448-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220309170437.4448-1-kch@nvidia.com>
References: <20220309170437.4448-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f940d1d-033f-4a53-96c2-08da01eeeffa
X-MS-TrafficTypeDiagnostic: DM6PR12MB3114:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3114770C95E7F186AC32D38DA30A9@DM6PR12MB3114.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWBQvmEJ6FZIbIfwttXycu9xjotkf2sM3E/hy7uw9TC10IXYbY8+hxt8bic4rk54kYv+4+xjKi7L9GlowzShqLx4sR6i4zkuqnakqipxkez1XIwG4DZwNVg0Euogtg587v87LJFO4k4EaoSewC7+8OKW+biuDy201UCxr75Ip/IW39ZSk0p8UYXoKrFfrc3Zh1yGVGXRWXMKfxjPuvKzf+fn48l0f+fKkEBDUoVeLGPl9pS73g077bOAdDW5iA//53cNldnOYttIvUJUJXqMZHMlz7+MfOob8ylgVoFbsZ5T+oB9JjeHYlxKAgFbNTLe/4qrTyDHjuhpgXCGhu9FuA00oL7QWaE9Sn6jon+Wo6VXwaJhqPWImciKZ0MWOy6ew+5Jp8pJ/U1v9wn5S7lqnkydlffQvZ9fyAvCcwFX/nAC7vk/uWypcJROxpjqVsC6V1/G1ug0Phr24Ugc/kZukyVd7dmqye60iCRvZDxMV1b2oCDKIQqkw2ddmH1rMAOtanFoccMR1EelCAvwKwgPCOGaOJJAQADDE8WCfpYf0K0WuevMFcI9yo+miLiZf9emGR6jgq/qxrDMvV7tnMw9iTnlaSaftnKgYuk8FTrvG8dyBemYzZx4fn1o5FMZZ+M+l2swntI8ArnSPwaDEF6gGu2Evk63y8VrKBF90cZfUyKbbgX9XIR9I0pe+6SydC+l8IPGQAyf1nbMBsjZpE/9bpoPtN5NEs8mGgTrVB+Y2Mk=
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(40460700003)(508600001)(16526019)(336012)(26005)(83380400001)(70586007)(1076003)(186003)(426003)(2616005)(107886003)(6666004)(47076005)(7696005)(2906002)(4326008)(81166007)(5660300002)(70206006)(8676002)(316002)(54906003)(36860700001)(356005)(8936002)(82310400004)(36756003)(6916009)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 17:04:56.4336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f940d1d-033f-4a53-96c2-08da01eeeffa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_090541_110953_4895CA36 
X-CRM114-Status: GOOD (  10.84  )
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

Instead of having 4 calls of nvme_setup_zone_mgmt_send() with
zone-mgmt-act as a separate parameter, have one call from nvme
setup_cmd() and derive zome-mgmt-act from struct request that we are
already passing to nvme_setup_zone_mgmt_send().

This reduces duplicate calls and break statements with removal of extra
function parameter.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c |  8 +-------
 drivers/nvme/host/nvme.h |  6 ++----
 drivers/nvme/host/zns.c  | 13 +++++++++++--
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f8084ded69e5..b5d36e09e763 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1042,16 +1042,10 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 		break;
 	case REQ_OP_ZONE_RESET_ALL:
 	case REQ_OP_ZONE_RESET:
-		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_RESET);
-		break;
 	case REQ_OP_ZONE_OPEN:
-		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OPEN);
-		break;
 	case REQ_OP_ZONE_CLOSE:
-		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_CLOSE);
-		break;
 	case REQ_OP_ZONE_FINISH:
-		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);
+		ret = nvme_setup_zone_mgmt_send(ns, req, cmd);
 		break;
 	case REQ_OP_WRITE_ZEROES:
 		ret = nvme_setup_write_zeroes(ns, req, cmd);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 587d92df118b..a85dc4e29870 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -878,12 +878,10 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 #ifdef CONFIG_BLK_DEV_ZONED
 int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf);
 blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
-				       struct nvme_command *cmnd,
-				       enum nvme_zone_mgmt_action action);
+				       struct nvme_command *cmnd);
 #else
 static inline blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns,
-		struct request *req, struct nvme_command *cmnd,
-		enum nvme_zone_mgmt_action action)
+		struct request *req, struct nvme_command *cmnd)
 {
 	return BLK_STS_NOTSUPP;
 }
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 9f81beb4df4e..7bbbd24ba6b6 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -234,14 +234,23 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 }
 
 blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
-		struct nvme_command *c, enum nvme_zone_mgmt_action action)
+		struct nvme_command *c)
 {
+	static enum nvme_zone_mgmt_action req_op_to_nvme_zmgmt_act[] = {
+		[REQ_OP_ZONE_OPEN] = NVME_ZONE_OPEN,
+		[REQ_OP_ZONE_CLOSE] = NVME_ZONE_CLOSE,
+		[REQ_OP_ZONE_FINISH] = NVME_ZONE_FINISH,
+		[REQ_OP_ZONE_RESET] = NVME_ZONE_RESET,
+		[REQ_OP_ZONE_RESET_ALL] = NVME_ZONE_RESET
+	};
+
 	memset(c, 0, sizeof(*c));
 
 	c->zms.opcode = nvme_cmd_zone_mgmt_send;
 	c->zms.nsid = cpu_to_le32(ns->head->ns_id);
 	c->zms.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
-	c->zms.zsa = action;
+	/* caller already validates REQ_OP_ZONE_XXX */
+	c->zms.zsa = req_op_to_nvme_zmgmt_act[req_op(req)];
 
 	if (req_op(req) == REQ_OP_ZONE_RESET_ALL)
 		c->zms.select_all = 1;
-- 
2.29.0


