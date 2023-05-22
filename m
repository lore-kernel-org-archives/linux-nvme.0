Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E126C7EE26
	for <linux-nvme@archiver.kernel.org>; Mon, 22 May 2023 13:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SjT5OOCQUa38bgshSbkpNTZ9MNBN+lbX+1Ew8S5h0mY=; b=5AVoEGgiurzIMSYfgLEpW/j4zs
	f8G0OB9WIvC1aN1RMHkEyDD/V5aaBigepAFtgucxgtcaXWpuqdo6pqodkolJkycr3c6MnhEQRcPRe
	lDwFLMysnpbtIvJJgDKltmZp9d3otAnOXSiDn0cl+3gD66K6NYxi76WViHMy29MRsFNQ1uEcVAkM+
	qAxNX9Iq7zr3W/gIBpDmLIwvo3GQVoTESPL0mRkF3obNwRZmxpSt5fM51x/rSeTjGmay/2CtZkq++
	BQTDxqvfSDHP81g8R7LM2uXG4ivioqkKX6PpIdKcVJir7Qp7AnEMFSghCbg1/7FSZ+nDMSMZLpvSV
	tB/nxWMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q15Do-006b2C-1f;
	Mon, 22 May 2023 13:05:08 +0000
Received: from mail-mw2nam12on2060e.outbound.protection.outlook.com ([2a01:111:f400:fe5a::60e] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q15Dm-006b0I-0M
	for linux-nvme@lists.infradead.org;
	Mon, 22 May 2023 13:05:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpXJ8IO5CCVOUWEDrP+mkCb6DMlCJTZM2pCQ7/b4tZg+OJeek1flX8OSxb2/TveEUCcTrjXRdR0ZhfiRiehrpANHY5PIQwNV+cUPY9s2hvCyZSVOa1xPmce/IZ6vZZwYV2lKC1wvQfYGVIsnhUDY91eIaUaWQmfsmY93RvooP7GlJUi/1Myuk8PxaBSzF/pjeMF1mI+olFeYgdwey/kmm6i2piaXz8HC0ay/eHMlsU+a2G+/s2KIfwKMZiy/7dMdE2g42Z71ZrUQDMZwleil4y8O6wug0N2fcXIqid5vuZZ08q65egMTzm6GVAtleXao0UOoiMXKhMiYiOFEgfAqRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjT5OOCQUa38bgshSbkpNTZ9MNBN+lbX+1Ew8S5h0mY=;
 b=OWmH4ZGTzVQ32VCmDGIwKQJUg9Ar+kd0eruNevmAlDbmo6yV/Yfg79Bp3X8t5fIjCqZ8zUk9/kl72o2QWIjnHfLSOqKPhIR7iLn692ovq2mDJ8bs3yMW8gqm4ZDwseXhcia8Kt2sac3704LZuSXO6MYIEfIU4wW+w12HY//tRpeFUtNCeif18m2Ya5Dtc6eZSBOjEWjzcymbnitGxj2ZnAPmbR8re5k7XInquxA7d/TO3hg/xhQAjaSM9iZrsLhlJS9tTrUXi9XmlzfQBuP4Mp6t7B9LbLGcXaRiqcQmJLFVJcUGRnVgKBCpncuWD4UBTyVQklhmYa5ONzjVonVBgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjT5OOCQUa38bgshSbkpNTZ9MNBN+lbX+1Ew8S5h0mY=;
 b=inn25nWi+TiPrkW9Hyghr4u+fMEC3+PsL9hRLbo2EGXwZIQj3WTPO2yiEDhCpLd7b/mbZltbblntU8eHvOf//vsQLXpAh1SEGnRPGFinxIP0LQeUalV0Gyyj9O0GcQm873K53YK8ADi0pQrLuMz7AUJD5DK+bm5K++JzIvr585Co97n/D8TQL/FwdhV4N0KXU8h9wjsdos9nArnNLP0Dd8uyEvI8Szlpry1WR7c1VT+o1NivuMKp7mXed2p5F/UMXIsjLq30EinZR9QxdT5KdZ4irUSj93VJDHNdl/MTjGKMxcf0dKEyQoy2zCfyOxP3zRlfcqaiPr/rjpjfK69OSQ==
Received: from BY5PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:1e0::13)
 by IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 13:05:01 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1e0:cafe::64) by BY5PR03CA0003.outlook.office365.com
 (2603:10b6:a03:1e0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 13:05:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 13:05:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 22 May 2023
 06:04:49 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 22 May
 2023 06:04:48 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/3] nvme-fabrics: factor out common for auth
Date: Mon, 22 May 2023 06:04:08 -0700
Message-ID: <20230522130408.105328-4-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230522130408.105328-1-kch@nvidia.com>
References: <20230522130408.105328-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f01053-7247-4036-956f-08db5ac526ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	FqGkwz+4eBZcKux7yUj4mP0gl5CGYH2EQ7EupAGtoj3GlyAtPODvOsPsRcpiSgIX4WhPRWgDBRhxXxXo5l1PtFbkELT7JQySkBo4Yc3Y89km2sdb8Kx47YgOjBcKTyK2M3QkCnozG84Z6lpy37sCwLvsgSoac7fcNLNDymv26SHDXsLvQrwW4Nqn3xRD/URPRo/SBjKTM3XVRp8ycGTTTHl7AkALhXGPpcw7Mn8lVK5zVWvvSIsz+EDBzCIJHXpcOr7xWKfrTz8jTUxIryUwy8o9tH4LGgaaQU7w7dKeGlg/dmF+GkP7eqkENSKxqNwzpbwUAmYNbMt/5Ex7vtAyxXs7u6v9ZBEo+YF+PA89eb53D7qh3nFJ+1WuTpngGj3XCnm0zmn/CFRRvdmIF9j2chaOoO/qy8o0/Se26nSo+KSCBkfPJ/viwtZjU5yvGdCfEqvk253ZhS84jMxcSNCpPoU+HJlw48Ky8eDm7kiCxN8ywWleDLEKVxo9TFZDxfngJa4ZUxH2LPS7VU51UyDzDCW5eXRfVI71soFhPllvZ/N2qVA+JR7GJyIa2jSh8Hmw/zdrpo7eFu3gRsBWbDHaFi29s+pw9lmLr9BNtu0R5ofVzKq5C7mTQkH0vErjPDUH/20EzYBIzQX8ANpe2tsWHRVTbZJLI3zkioS5Q+/TWn+2jvcdA+uzjC7Pfye9flcLM9gE78pmvCSPt+V6aGDCZxjWyE1FdizOh0OorHXZH3PR3u6O7wdbmZI3AMqGxAph
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(316002)(54906003)(4326008)(6916009)(356005)(7636003)(70586007)(70206006)(82740400003)(41300700001)(7696005)(82310400005)(6666004)(478600001)(8936002)(8676002)(40460700003)(5660300002)(16526019)(186003)(40480700001)(107886003)(1076003)(26005)(336012)(36756003)(426003)(36860700001)(83380400001)(2906002)(2616005)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 13:05:00.9616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f01053-7247-4036-956f-08db5ac526ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230522_060506_158208_016A5FF1 
X-CRM114-Status: GOOD (  13.86  )
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

nvmf_connect_admin_queue and nvmf_connect_io_queue() shares common code
for post connect command authentication processing that includes,
returning appropriate NVMe authentication status based on the
command result, authentication negotiation per qid, waiting on
negotiation per qid.

Add a common helper function to reduce the code duplication with
necessary aruments of qid and result of connect command.

No functional changes in this patch.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 81 ++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 46 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 9d3df63eb49a..1d48c0b77cd0 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -433,6 +433,39 @@ static void nvmf_connect_cmd_prep(struct nvme_ctrl *ctrl, u16 qid,
 		cmd->connect.cattr |= NVME_CONNECT_DISABLE_SQFLOW;
 }
 
+static u16 nvmf_auth_post_queue_connect(struct nvme_ctrl *ctrl, u16 qid,
+					u32 result)
+{
+	int ret;
+
+	if (!(result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR)))
+		return NVME_SC_SUCCESS;
+
+	/* Secure concatenation is not implemented */
+	if (result & NVME_CONNECT_AUTHREQ_ASCR) {
+		dev_warn(ctrl->device,
+			  "qid %d: secure concatenation is not supported\n",
+			  qid);
+		return NVME_SC_AUTH_REQUIRED;
+	}
+	/* Authentication required */
+	ret = nvme_auth_negotiate(ctrl, qid);
+	if (ret) {
+		dev_warn(ctrl->device,
+			 "qid %d: authentication setup failed\n", qid);
+		return NVME_SC_AUTH_REQUIRED;
+	}
+	ret = nvme_auth_wait(ctrl, qid);
+	if (ret) {
+		dev_warn(ctrl->device, "qid %u: authentication failed\n", qid);
+		return ret;
+	}
+	if (!ret && qid == 0)
+		dev_info(ctrl->device, "qid 0: authenticated\n");
+
+	return NVME_SC_SUCCESS;
+}
+
 /**
  * nvmf_connect_admin_queue() - NVMe Fabrics Admin Queue "Connect"
  *				API function.
@@ -478,30 +511,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 
 	result = le32_to_cpu(res.u32);
 	ctrl->cntlid = result & 0xFFFF;
-	if (result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR)) {
-		/* Secure concatenation is not implemented */
-		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
-			dev_warn(ctrl->device,
-				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
-			goto out_free_data;
-		}
-		/* Authentication required */
-		ret = nvme_auth_negotiate(ctrl, 0);
-		if (ret) {
-			dev_warn(ctrl->device,
-				 "qid 0: authentication setup failed\n");
-			ret = NVME_SC_AUTH_REQUIRED;
-			goto out_free_data;
-		}
-		ret = nvme_auth_wait(ctrl, 0);
-		if (ret)
-			dev_warn(ctrl->device,
-				 "qid 0: authentication failed\n");
-		else
-			dev_info(ctrl->device,
-				 "qid 0: authenticated\n");
-	}
+	ret = nvmf_auth_post_queue_connect(ctrl, 0, result);
 out_free_data:
 	kfree(data);
 	return ret;
@@ -551,28 +561,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		goto out_free_data;
 	}
 	result = le32_to_cpu(res.u32);
-	if (result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR)) {
-		/* Secure concatenation is not implemented */
-		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
-			dev_warn(ctrl->device,
-				 "qid %d: secure concatenation is not supported\n",
-				 qid);
-			ret = NVME_SC_AUTH_REQUIRED;
-			goto out_free_data;
-		}
-		/* Authentication required */
-		ret = nvme_auth_negotiate(ctrl, qid);
-		if (ret) {
-			dev_warn(ctrl->device,
-				 "qid %d: authentication setup failed\n", qid);
-			ret = NVME_SC_AUTH_REQUIRED;
-		} else {
-			ret = nvme_auth_wait(ctrl, qid);
-			if (ret)
-				dev_warn(ctrl->device,
-					 "qid %u: authentication failed\n", qid);
-		}
-	}
+	ret = nvmf_auth_post_queue_connect(ctrl, qid, result);
 out_free_data:
 	kfree(data);
 	return ret;
-- 
2.40.0


