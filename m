Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF44DC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Dec 2021 11:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l+TBw0Rk+5yqta0f9uEhbI84fjg7aLwYRasNj7I0KS0=; b=uTunNiljXAANB67saDSg704c31
	OP01+QH26s7htH4R+/Z82zZpo4toT8mQSI0ao4z/sZGuA7yOlhMNwG6BQJFEG96am7cLjwuxx021f
	F/aFUZ+fCupGoFI06Jhi6hWpbEIIAJs5uPOnami0ovJcEVSFo7Cw6yYMzNe4Y5GfxIQ1/HshsnyYK
	OY0ycvJAlafme83QckKYKGViBIp1xJVl7sS/qdUznV9QdrQ30nRLeKUMnNraTWknLvsemyZVlcXy+
	yTHNoHfst8nT08zKAxjzkbEu3ivYRUWnDJEChUgCFGIXjr3pyv4eCTQmGVci7zWhgh5lGAdeJ2b1h
	YZz0YgMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mvdyr-001dvb-0R; Fri, 10 Dec 2021 11:22:25 +0000
Received: from mail-dm6nam10on2052.outbound.protection.outlook.com
 ([40.107.93.52] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvdyT-001dmt-JO
 for linux-nvme@lists.infradead.org; Fri, 10 Dec 2021 11:22:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kd6aVhTNjS/OtidQ0PdgINegccoBnE432xLMjxxaQ0b7o1KooepIrQRRce0x/8CejtlQkD/IXv92y68jKNzd5Mk9iM1IByA4ZYkE1IYK+Ka4Rq5bmsEzKEI14kOFv88He8MMO0ExtsCLYCl6xzuEazYidVUIrC3kjaTsT/EPk+RNc6w37kVfmarX28Nm5H1c97ptw8rZW5AaIjRG4nWvFItU1CpfMNTfvqzcdRg7lrenqB37L2sjunEzulsHqwwApYGBIYT30UZYd2suw3IUxX90poES9pMpOIlS0tXx8vDIDzdIYb5HkBySAw3sP+MolEOgBuc6OtB3OBJ5ZEeUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+TBw0Rk+5yqta0f9uEhbI84fjg7aLwYRasNj7I0KS0=;
 b=mYIx2DjqYQan+pXrE76nRiy3fa1N4RJKIr9dRcJX/smmGQdFklOKLIl9FmMCaRH0omDLeV6QAVJ42NVEy0yn5vkooZKqG21ALfq5d8mewlfQf3XgPfRgMu2QDJPLRReLVKHWbhId6J3SfwRsWFqIgwt5wC/yNll9GNlqpd1rAOxUVyGILtb/BgxF5SulgFYUuvZZZn1IDqrPg+HAnfuwGzQMIrYeiiYBDfwQWblCd/FjTo/zTADTpwtq4p1AuCsploI0RlX8W64/JxpTMPzSLt3Xhoq8zjy4+rB+0dldMoRX0HRRReTSiJcDWn/4IBI4iRnjI0+kYh3cbjODv00ymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.14) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+TBw0Rk+5yqta0f9uEhbI84fjg7aLwYRasNj7I0KS0=;
 b=OZVEFBLGRPYx2I4en0FX/UDU+39Q8jRUWWAHqI6QBUQDivAOGvR00M2ZQBBGuydxjyJ+Go2+yul81jZoWJSqtx29qtpWMVFr7hvoR/l/QD+jGQ8cD5Fgoq+j9p965xz4MQ8X4jhJROSiwqq7pSGCkEnQ1CQ6Z5HSNpsWaHyFf5jow98JKiSse21XU6qxYRz+d99edlv7yMXR50/QfcNQsOjChVJZ/Ko1U6gPZ59LorhrZckiMX37DBqbxUPZVEJsdR5R+M4g1xWpY/caAwwBA72dWPZ0yz5k0VMAsSWXWYVxusG1er8m7Cuuh+v28DmlKXloCVW0AqiQNoCp2ytFvQ==
Received: from BN9PR03CA0074.namprd03.prod.outlook.com (2603:10b6:408:fc::19)
 by CH2PR12MB5002.namprd12.prod.outlook.com (2603:10b6:610:6d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Fri, 10 Dec
 2021 11:21:59 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::5f) by BN9PR03CA0074.outlook.office365.com
 (2603:10b6:408:fc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Fri, 10 Dec 2021 11:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.14)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.14; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.14) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Fri, 10 Dec 2021 11:21:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 10 Dec
 2021 11:21:57 +0000
Received: from dev.nvidia.com (172.20.187.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Fri, 10 Dec 2021
 03:21:55 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/3] nvme-core: move gencounter check into nvme_cid()
Date: Fri, 10 Dec 2021 03:21:15 -0800
Message-ID: <20211210112116.9299-3-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211210112116.9299-1-chaitanyak@nvidia.com>
References: <20211210112116.9299-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d67caed1-b33f-4d61-d398-08d9bbcf47c9
X-MS-TrafficTypeDiagnostic: CH2PR12MB5002:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB5002B9505984AF8C14256E13A3719@CH2PR12MB5002.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3yxvfUm5uLKny8b++TSMaC+IVEQrHTDcVnhfVAnSvy+Ab0LKgeQUiXD7LpLQ6kUYrzbG7nhuab0041blZHCiW0ex4L1WVuPOY+1/GFBdoBu1QP3h9zHfV8GrNJxlnqknJiaQY5NOIiHzLHAZW1rzUZBHkwzBYvg120DlTKONEZ31i9UbR+VNbRCacjWWc+jiIvdHwp2n/Z+phu0UHLnlLgUS1OiAjUfxgJxx/osSyCoCttOq1LuM30jXCebA/6HpKBS+yFiFpVWzEou3WLTnhpNpZiJYdh0KPtbCvX2uF2UyDodX4x/rZaNJzDqLthYp47N0dgHPQQmgrA5y1h/Zv5QjoCd0WJYyNgSGR+jBq0jq+z9JO1bdxKhcolx1PgVPa2cnxiP97gcrQi1lwioUh1zWR85K8hOZtF27pq2bPV86L4QA2MMs9YxDsehyj6VSYEypmokrQ2kKZ6oYG9U+xl4dQKTtwyeeeCM6q5dR6e/LOnib9kMVHWIvGfH0nAwM/WU7kV3hX/+GmSSJIda6fwB8iwfdM7fzIsT/Pbr/MJE+MXotNMcmJCiLa3CBgO97osk3BxLERbcx8CONExMZKZg1xJlLVDa8o8MWsc3063j+Myv2Rdnwih50jiRhYPV2RK/PzhrXbgFTw9S/LqZWZpySMPqMWDMekhVqDAg/kxLAhM8BtjJlsvhajS8wGOSjwG5XdXe94NXb8MB1+DBUK/bsVXVTz3fzz78Q3jFtKI5bKWyjx5+p3u4UIZqMMGlkSbLq8hwQClcESIJVeWeGK+KNgicYauIMza0jur+TTP8=
X-Forefront-Antispam-Report: CIP:203.18.50.14; CTRY:HK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:hkhybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(7696005)(70206006)(2906002)(70586007)(8936002)(86362001)(5660300002)(4326008)(6666004)(83380400001)(426003)(26005)(34020700004)(356005)(2616005)(7636003)(47076005)(336012)(508600001)(36756003)(82310400004)(36860700001)(316002)(8676002)(16526019)(186003)(54906003)(40460700001)(1076003)(107886003)(110136005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 11:21:58.1826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d67caed1-b33f-4d61-d398-08d9bbcf47c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[203.18.50.14];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5002
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211210_032201_693367_6C886FCF 
X-CRM114-Status: GOOD (  11.38  )
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

Move gencounter related code to nvme_cid to keep the code under its own
interface, this also avoids any open coding and if condition when
gencounter feature is turned off.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 3 ---
 drivers/nvme/host/nvme.h | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3c9f221379bd..7008cea69400 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -990,7 +990,6 @@ EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 {
 	struct nvme_command *cmd = nvme_req(req)->cmd;
-	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
 	blk_status_t ret = BLK_STS_OK;
 
 	if (!(req->rq_flags & RQF_DONTPREP))
@@ -1037,8 +1036,6 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 		return BLK_STS_IOERR;
 	}
 
-	if (!(ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN))
-		nvme_req(req)->genctr++;
 	cmd->common.command_id = nvme_cid(req);
 	trace_nvme_setup_cmd(req, cmd);
 	return ret;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 98d7627cfdce..2be0191e1a1f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -511,6 +511,8 @@ struct nvme_ctrl_ops {
 
 static inline u16 nvme_cid(struct request *rq)
 {
+	if (!(nvme_req(rq)->ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN))
+		nvme_req(rq)->genctr++;
 	return nvme_cid_install_genctr(nvme_req(rq)->genctr) | rq->tag;
 }
 
-- 
2.29.0


