Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70649C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 11:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SlLab3zG/PhkwPktXebLtJhyncKbA2k0w2x6wRVm3O4=; b=A5ORlq+yDCFI6UiMye2qGxlhP4
	7cht2VomqIHyQNW0H76kwdffImxT8/yDmxZrCvwmvLI26hmHiisLsryWf4ClSmsaynpP2znEVaNeX
	Qvy6hI7TWitSJ7E4ifGkNYPq1EBv2L/4dn27yscHxqN3OEoU9MSu09FT28pTNqNptM+Lcz/qz2C6e
	lHoqzrhI+IDC6weM0ITVTSFENwvHcjQkb2/g5hU4QllfYzyNaw7sL1PFt+sP6qSYjx3aBt7/WG9u9
	TM4LBSp4Y0g5emCRymcuJ+4EHmTEx8VYp+uPLqYoKJMpvegjs9UDzcF4qgHgxTlY79lN+f6wNFyCd
	W37YhOiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJZdK-00ErAk-8W; Mon, 14 Feb 2022 11:35:06 +0000
Received: from mail-bn8nam11on20620.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::620]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJYMv-00ERbk-61
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 10:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZEI4H/UcdRW6mraWao0BpYlL918Jp85tx/ya2RbvE/JRpBzvwtZuFUdSf7IAABOQSysTN+895CY0uKmwdL7QykSqq4pQgHi08TJSdzfLcCEtwkp7RHTQmZFWfm6e+SsekT9KJXQLQ1OxfBfPBcSY0yf+dj99P3lHWHlFqTpR7iRTZrmpoFgaZdYqvWrBg5wR3hLCYw7f7U+QUF+9pDI1qs5q3xGLpSDkAtLCBUy+WbYB0CuFfm5XLVg8+A3wv3krngxqIV4Qw6XFAab8xASQd4JE4A2jwWQL8pn9rm8jU3UVGZHL2GK5geJb/FrOBLFfwsdBNv2Ila25Dj650p6Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlLab3zG/PhkwPktXebLtJhyncKbA2k0w2x6wRVm3O4=;
 b=HCdKiL6p1HowXsIZuTpmbPX1QZ2HRjDbN1QxnrPYyCX0ulRCGaZwqSSlJ5UARSOfF3Cxk+woJ9okrmxqbOUep3jxz10d85m6Qo57INCP3BGsATg+oZfDNaxpUwXtLXm9r//w+MFpYmazPH9Y2sKJPIp3kttK0di7oMa1ceikwHmTbQuMOq5R649Rb5ieHlZky8ZZ/PA5gXeMa5shDcXaN118Y1nOdw7z+U0uocUbH/Ue6f9qKWh9zq91WJktEr/AKlkDWN/kDW0wne15lTE8oj5MTq1oqAOjowEPKMg8LP3GgITSWSeT5jcqAkKjJLbjLHQfAnSkwfqj2jP3EF1L+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlLab3zG/PhkwPktXebLtJhyncKbA2k0w2x6wRVm3O4=;
 b=V5xXuaL0Bk/1+o6Wzs+2QRUODPJ3QtZQTeRYpoWO3mn6UAZGAyQYPCIUMTBAoSLLENVq619yLgikZJzDSOTfA6lZA28fXfMZc+mgf8wsJdJGLkQdLZO+p9FaCyZeUfxyREFN4j70y93ylUeuHLtAVU+XhDVzCkG16NiRvv1JGXx2XwQIQIRTWGl5WxuzNmsALUHmcjk4MvnPAnqoGZxfpZnPlVywvG/VyzPvq/BGLTJNaz9Oejg87RFZVlFcr9Y3RXPiKT17Y3g4nvIqPuKBRJviZ58JKLBz8WK3w9Wx3tZ9PkhD8+ASjAz3o1dc/iA+g6XCHzd20XR8fj06Vn+b0g==
Received: from MW4PR03CA0015.namprd03.prod.outlook.com (2603:10b6:303:8f::20)
 by LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 09:57:59 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::f3) by MW4PR03CA0015.outlook.office365.com
 (2603:10b6:303:8f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 09:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 09:57:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Mon, 14 Feb 2022 09:57:58 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 01:57:57 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <james.smart@broadcom.com>, "Chaitanya
 Kulkarni" <kch@nvidia.com>
Subject: [PATCH 6/6] nvmet-tcp: use non-deprecated ida_simple_xxx APIs
Date: Mon, 14 Feb 2022 01:56:39 -0800
Message-ID: <20220214095639.5125-7-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220214095639.5125-1-kch@nvidia.com>
References: <20220214095639.5125-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3249b71a-f31b-47cd-7fc3-08d9efa07af2
X-MS-TrafficTypeDiagnostic: LV2PR12MB5920:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB5920A7780ECE8E34FE2F4E47A3339@LV2PR12MB5920.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mj7TpTgn052D66bwnztx+mZoU7cckuWZzYJZUPVJsknxmkmd4eDfq25gp43JBffQbeDVIuxx/mlZ0uuyI1jvrxASE4GIKM+FyzUulCRD9IL/QsnJrIncSABTlybSpR9b5r/IPyqIHpiFoTazNLnhVYckbbp7yPwH74BtD6JE4lzSKwihYjw6++F5w1ZdAebY6OLUjzy8Uld1HCQZNe1l/URtYR6WXUH7h4t8BO5msQVl6hXSRoJD/dX3J6S1nCEjNcckhtGCa6sEEoyiE9c+XwGmEJ1nfRnK+UHI79u88ga0bclndp59eXmnx0pGhdQw00vaR7VJPLW2+eXgzqlqU5s04DVP6dZt9LJtuX8oj3PSEgehr/Gw5AbsiIWuXZt5RXdiSWVB4iwwZUUWAVWY54/S+lJJtkQtwPv8E3UMu1ruZVX3apbwVoDC0ZHdsVBLk8T3ziMI5cuqAjvwOSfDvcftxH7QcipCqXL2no+of8b8FoJxKpuqiiicpZCEIztyFFtgmdh65vxSVGwupS+6NcbABiQmH0/REbwPdRADs9J+Jm+Jn6EcafQsjqvLOOHhSDkZb1qI9zr9blCwP782jVLyxAfZyukUbqgUsriUsKFD/6BlqHkdZdryfPAuLVnwWWnMgtBma3Orv2k1pV8M81Wx/Szcs/Xws6Y7PuTjOGNYmmSAFyhSM8RD7jErHqDvVW6jxM7ytj2ZhN0C99LJDg==
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(508600001)(4326008)(426003)(16526019)(186003)(5660300002)(336012)(36756003)(70206006)(8676002)(6916009)(54906003)(316002)(2906002)(26005)(1076003)(107886003)(2616005)(83380400001)(40460700003)(36860700001)(81166007)(356005)(47076005)(6666004)(8936002)(7696005)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 09:57:58.5060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3249b71a-f31b-47cd-7fc3-08d9efa07af2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_021405_253209_B62F3FA2 
X-CRM114-Status: UNSURE (   9.33  )
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

As per the documentation present in the file include/linux/idr.h
ida_simple_get() and ida_simple_remove() are deprecated and we should
be using ida_alloc() and ida_free() instead respectively.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/tcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c1c43ce466b..83ca577f72be 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1473,7 +1473,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	nvmet_tcp_free_cmds(queue);
 	if (queue->hdr_digest || queue->data_digest)
 		nvmet_tcp_free_crypto(queue);
-	ida_simple_remove(&nvmet_tcp_queue_ida, queue->idx);
+	ida_free(&nvmet_tcp_queue_ida, queue->idx);
 
 	page = virt_to_head_page(queue->pf_cache.va);
 	__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
@@ -1613,7 +1613,7 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	init_llist_head(&queue->resp_list);
 	INIT_LIST_HEAD(&queue->resp_send_list);
 
-	queue->idx = ida_simple_get(&nvmet_tcp_queue_ida, 0, 0, GFP_KERNEL);
+	queue->idx = ida_alloc(&nvmet_tcp_queue_ida, GFP_KERNEL);
 	if (queue->idx < 0) {
 		ret = queue->idx;
 		goto out_free_queue;
@@ -1646,7 +1646,7 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 out_free_connect:
 	nvmet_tcp_free_cmd(&queue->connect);
 out_ida_remove:
-	ida_simple_remove(&nvmet_tcp_queue_ida, queue->idx);
+	ida_free(&nvmet_tcp_queue_ida, queue->idx);
 out_free_queue:
 	kfree(queue);
 	return ret;
-- 
2.29.0


