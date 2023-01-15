Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CE7C46467
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Jan 2023 10:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VFMSZzMXVyK1o8zX/dzZMYcAf0N+f/mjXB6td5Mjc/c=; b=GLkDKvkvfcRDEZrgc3abGDb8pJ
	oNprvt2HS1vTtL3pPcW6FzC78EbdUXIpS0+uxoNA+0Tf0XygmCs2Q9jHzFF1KcJWbF0SJ8MuOfEMm
	pVajxQC5QnQZPkpR+K0HoOS793+GcIDeg4zbDbavCMrvKTSkp4uxuwGbvNe0TMFm/1GoYWkyABHM6
	OzJw5gmeik56swezkLc6+nIqwDvoIPsn14z1LlxmM81l9jDITbKi3xFpwdB3QTOhb0rivrDNLvkqY
	oJWJ3s7ZjWJr36t+cQ2XFExjVFxEiq6MoISd+bdDvBSY9NplX0mJ+w0mxOZ0KS0I/43wCS2xsyvQH
	qO7we9qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGzrp-0079te-Sd; Sun, 15 Jan 2023 10:03:58 +0000
Received: from mail-dm6nam04on2067.outbound.protection.outlook.com ([40.107.102.67] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGzrn-0079sc-1V
	for linux-nvme@lists.infradead.org; Sun, 15 Jan 2023 10:03:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0S+jfkM06zPpjRQmBoHvVLiX7Bk9P5kCryPqqIodprwg1pMMrykbH9AVyvuzspyNJFjWde4tBbKmuJ5Bj8W7d6y7/3NGmKPIovV6k09m54VPHkdr2jyHZEdYQR+/uiTksGzVMBOQDpTqEx0DsLx+Qb3xzs63I0LBVKbS7LkGgCXvvq/UiA/Fg5vx8oHZJcASdSRegkew4eaa0Jibfz2Kg293IMW89cRFmWlV26y5YVAvirZyxIyINNpN86YUxyAM9MKBeVAaRf2xZFSNTWnKRJyWXZM4tsRkUs+YzZuk59wxYje3jlkPKkiOEHA7mh8fGc2b20lWKNAxibEvdJHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFMSZzMXVyK1o8zX/dzZMYcAf0N+f/mjXB6td5Mjc/c=;
 b=keh7iw5xZ0q0gzGIsGMqjIcPub1Mm2E08rE0xYLkpTPuYAzdzeKgIvNx/UNoZLBmowlaDlEmCvVLHbPzw7mW5X4de8a9qydhIk6zQQ27JfPhoigvneolu0kMdmqjcTWaklcD7w7FtiNKN4fRMTonWj2AmT5Q4lscQrNqdBYUPel54lsnxyL2htfBGSkJNr+iZWYW8+eIY75DCORAK5UB0suhP23GkrSkhsYIbATwpGuvCxwp9JyC5TpbsXM4NNEQRXJSzDFD8uZW1MbSQbrNBYoNF93JEPD05+1U215p0S2NL70vHl8krNSwIj29ygOzK1u5Bt4o7+4yAOU+SvVS4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFMSZzMXVyK1o8zX/dzZMYcAf0N+f/mjXB6td5Mjc/c=;
 b=bDaMrunrpRvc/fjoNjo2yzzNKFtV+v6dYbhVLN7AuG/cmvDtLOV9YQDJKuqcLLNRqkDGj2cpzKcE61IiUen27X7bf4NIirOywHpu7om34PSbWBhD4IsRPnOJQwVYOCJrRwjyBpqO246FNZnkq3qgHhjoFW1gV1C05ooesvKrHLjgZIn1TK89dYmXmn2JQKQWSUao0oUMdpfsubl7kXE+gGiCe5t7puFIZ+wBtFGSK7guRcOOPc3P8kHr5H3u+9obsx4AgiwjJ7fglpu+xfKTOrt9iS2xSOvfCiS2G0bqaMzI2DFKJmz9hh0Wuhqx8qtWtq03lGGSaNFBHhE4x4XsIQ==
Received: from DS7PR03CA0164.namprd03.prod.outlook.com (2603:10b6:5:3b2::19)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Sun, 15 Jan
 2023 10:03:48 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::ec) by DS7PR03CA0164.outlook.office365.com
 (2603:10b6:5:3b2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Sun, 15 Jan 2023 10:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Sun, 15 Jan 2023 10:03:47 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 02:03:44 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 15 Jan 2023 02:03:44 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Sun, 15 Jan 2023 02:03:42 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@infradead.org>,
	<kbusch@kernel.org>, <sagi@grimberg.me>
CC: <israelr@nvidia.com>, <chaitanyak@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 1/3] nvme-fabrics: introduce existing_ctrl operation
Date: Sun, 15 Jan 2023 12:03:39 +0200
Message-ID: <20230115100341.40347-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|MN2PR12MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d301a4-19bc-4c2e-fd58-08daf6dfcb8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	asBc4F/OFuDF76QgU3+R30WyhIca17KsJIj2Sm950i53Ac5B64ktdZ5aQEy/B7qrXJUjxw/Njl1cbrajskN9RHzQXszahP55NZE9INq6fV86Rl+epQxpzmWtb8PMQdCTrdghGcZiDeqSSrSPXse+LCMj0ZAzJvyQkYEaP+yyEaSQJ9xKfD31nq564klQXF8HtwnO7u+xsAtW1LytjJkpWT9cYGRezpvfaCnotCIgD+JZUbujmGoUOjyqTZuMrX/3xtphKtyqbdAttaIiOnEMlt09xBMT0VF8r6lzYOr9VFZyMHcMz12MZ5EULfb/R24ZjU3VpnWc2kLcW+JgutYUvPmwnqqP5pypauEIF8RKTFp4SvVHUS6ZmbOBgBZsdmzNpCNrqhUv0JtEFEQbMZgLtoUZSWXakLUEw6EK0iloUT782u9NcAcXk5TyJfCGOncisMNzJ3ENcbtnsfNSktJPxWfnylYvVoxWwIu2NOlwZVe8NhLWtPLBgiYjnszZqC3/whC1VHgMhQZ/Elq11a78Ijn0oc5OX5dHVJ9HzU9da132n20ytBYSaKRTF02ovj5rNqEk98sd33QQfNw4gLpthNpuBMgxz7bLH2qXcdhi+BMtbT+PfoddWdPKWr9cGzzXmCbomZLHWGryb+3FE4iGCwM4wwMyeI7/X3/FMtrETX91ea/6Ghx6bLf/BDfNG6mwopWfK3pxV/aJ+0o4voB+Ew==
X-Forefront-Antispam-Report: 	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(6666004)(107886003)(36860700001)(5660300002)(2906002)(8676002)(8936002)(83380400001)(36756003)(40460700003)(70586007)(478600001)(7636003)(4326008)(47076005)(41300700001)(356005)(426003)(82740400003)(336012)(26005)(82310400005)(186003)(40480700001)(86362001)(70206006)(1076003)(2616005)(54906003)(110136005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 10:03:47.8029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d301a4-19bc-4c2e-fd58-08daf6dfcb8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230115_020355_111219_C5F383E8 
X-CRM114-Status: GOOD (  11.28  )
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

The check if the connection request matches an existing controller is
duplicated in several transports (such as RDMA and TCP). Move it to
common code as optional operation.

Also, this check can be done before creating the controller to simplify
the flow.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 7 +++++++
 drivers/nvme/host/fabrics.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ce27276f552d..3d5035331b9f 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1100,6 +1100,13 @@ nvmf_create_ctrl(struct device *dev, const char *buf)
 	if (ret)
 		goto out_module_put;
 
+	if (ops->existing_ctrl) {
+		if (!opts->duplicate_connect && ops->existing_ctrl(opts)) {
+			ret = -EALREADY;
+			goto out_module_put;
+		}
+	}
+
 	ctrl = ops->create_ctrl(dev, opts);
 	if (IS_ERR(ctrl)) {
 		ret = PTR_ERR(ctrl);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a6e22116e139..587b92575a9b 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -153,6 +153,8 @@ struct nvmf_ctrl_options {
  *			that would go into starting up that fabric
  *			for the purpose of conneciton to an NVMe controller
  *			using that fabric technology.
+ * @existing_ctrl():	optional function pointer that checks if a connection
+ * 			request matches an existing controller.
  *
  * Notes:
  *	1. At minimum, 'required_opts' and 'allowed_opts' should
@@ -170,6 +172,7 @@ struct nvmf_transport_ops {
 	int			allowed_opts;
 	struct nvme_ctrl	*(*create_ctrl)(struct device *dev,
 					struct nvmf_ctrl_options *opts);
+	bool			(*existing_ctrl)(struct nvmf_ctrl_options *opts);
 };
 
 static inline bool
-- 
2.18.1


