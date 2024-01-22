Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AC9C47DAF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 14:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OlEwXI7/9tgtRZ0gMV1802YZCyrvAfhYPlAdhysqw0A=; b=avpxQiHxF2E7vVxW49RKlTz1Yp
	cMa8LGhkH/SClvcQ/juTcf25BguhabZuOhIWA/1+7Rh/5HhO2QQ+J4qrlP1UneZfclBhu7vDzU7Xf
	Aoy+lJZY9wMrjY4297QNpun9QjMQGAUjw4H5EqMPQ8Zc75XcJatevH0o7jmjZV55nXTKrBmeDXXb7
	/D6jwDsOcrq9b50TYJDy320fSjpEjJ1skN3NIq4tconM34b6jXgfdaRLzsU9LHd4tbVoIPlNwsIcP
	MFQDWxd48VdhNbl3HiA7dE/e/q8aBDXWQoWvEUW89owevam5PbKdFnPE3wVnWP5Lp3hghYSmEnR4G
	Y3W6058g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRvkW-00CW5F-0K;
	Mon, 22 Jan 2024 14:58:08 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRvkS-00CW13-0o
	for linux-nvme@bombadil.infradead.org;
	Mon, 22 Jan 2024 14:58:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OlEwXI7/9tgtRZ0gMV1802YZCyrvAfhYPlAdhysqw0A=; b=oanOmI95Ja6QT5LNf0sE1VtblC
	E0IqkV3A2q/99Fud7YdeZ65Y7PQ/M9B976dPRcoX/5irBnjacBAdH47Av1hZTeNjFfClMYREnrH0V
	qkjg9wplX0inRbJ25GNthH9yY6yZkORRhd/xxL+4/uszF3WkzYCdEsLl9onmLoB+1ZBvPss9zkQ+Y
	NhUlo9G729+/3NQL3cCPP2VrQK2cBj2o3TPBmNMDFFxn4nF/93l97pM7E/V8G6QCKrnJUJ/tKtHxC
	O5oV8nVBYg3dSp5Ch9L+ZMRKIW3r1OuePYwvS9B2LY6+j/TU5wdsJTJnEYO4KhuxOysl4owiw7Xph
	LgUAFNGw==;
Received: from mail-dm6nam10on20607.outbound.protection.outlook.com ([2a01:111:f400:7e88::607] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRvkO-00000003LKA-2zsy
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 14:58:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEMkpGdc8HKh/sceTIEfcV4E9LGssjM2W0hdTG00EzB68s9Pn8poN2PjxF6iKWW6qfTxuMcYCKDYwRziwynYXfdvGRt+sbnSPymJk9wpgCDxc1p1pnVI5s3K2JEQZKMnHY8rR0H72viEOv3p8yvHQKBXyCqqXosfkce+EgaRiuBwaN9DqRQ3mKn4a8Fu0mlvc6XSn3/Aeq8cG/Gf7TBPrcuExCIH+4Pfs1T+dhQip1aaT72cAJ8sSP9pf8mbUEu9G4hfyVtuFc8w/LvPn3ASlLO1I0ZMMiKplpqyxhD8calHNcmA8hn/pFzeM4psHVdxorJ3oAs7+OfnYlLxEqTiGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlEwXI7/9tgtRZ0gMV1802YZCyrvAfhYPlAdhysqw0A=;
 b=gZCWvLQFjCuO3w0NU08Vh9vVU6bUGESLJtW2fxvvXCB5X1DO2bMCLzKOmxmL/zFPpGmUY4xaKOAuadf0oeZ7dl6+tfGR3105UagkqaNV8+JTgi22xqjETkRS/dB25Agy1SLkgKtADJEGH1NWtbeWg+PUM/nGOqinkpj6TQrtY0/0lVlcsRa17itmlxpBVxQt9MThoBjimJ95JyGgYnZlwiLxcnPNF7GkfUqmqjDZaSu/e7rqyh5YUv04kz3+pebdV9LVgH8KjQW4JFmFb+lpIMIhNmSlfNgkZQoXyNNG+VJOhyWWxz6+UAo9NwomZ2An3XJxacGp7pEEitmtypy5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlEwXI7/9tgtRZ0gMV1802YZCyrvAfhYPlAdhysqw0A=;
 b=goq6qj3+4yLJjih7PmWaVO0trNdzvHKMhMt+FstYZIslSM7At6HctXu4PYE4Ti0kswq2CT03wT6cPx12QHW5mOPFZ2dRtQTVvkDGoxWivW/5pGg9+Pd/oJWRW2Nd7hvqxrGygblzcXzuIKHqVbk9Nfbpcb3YtOdz7+OXHSIO7X3pMimhdrQl/xnMx6tUUxyCrFYXvXvfgx2Acdpc1KksjY6OxMBwOO1yJzTTOh5WIT7JMmxRQY/E5XN+wo3QuoEwOWvlspNBhQ9uvejmtcWiLQZOJbSDfD7q6CZNtKrwYML6YT/wkXUmXktEClGMzgH6l36zsq8XxBlt0336EvSkwg==
Received: from CY5PR20CA0018.namprd20.prod.outlook.com (2603:10b6:930:3::35)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 14:57:36 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:3:cafe::76) by CY5PR20CA0018.outlook.office365.com
 (2603:10b6:930:3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 14:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 14:57:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 06:57:14 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 22 Jan 2024 06:57:13 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 22 Jan 2024 06:57:11 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <dwagner@suse.de>,
	<oevron@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 4/8] nvme: add nvme_queue_scan_sync helper
Date: Mon, 22 Jan 2024 16:56:55 +0200
Message-ID: <20240122145659.5574-5-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240122145659.5574-1-mgurtovoy@nvidia.com>
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a41193-f81e-4644-380b-08dc1b5a7894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ud1eyyiE6GsbGKMT5n4KIrVgFXE+51/Mq9FhC2fkyocsa3CFp+MpOY509qQIkrnvmLp1lsGSFYrHymjDIHy1yfWUeHzNogm2dvbkK9H4m/Gk1diOcrJmeRNG0GRf+mBdr4pBYN694pMI5ly3gcvQuxQlujW30OezuhxtWj1+YebZbjfC3HyeTPcl8mzhprzEhesBUtVBJ7I7QD2DT2z6YUW/w2x3bbbChgOp2T9vj0UFo7K5iPz1Lu3Km3jxv3C2M7OL3qfXvZkHPG4hcMGRz36ccp2pmCmaEQQFESEI06QXo5FMamarPvlFEqsfu8a/odpKPzW6sGRDK014e7Tqyi58vS3JALGl+FJ9wDSLIv77RXwufoFEHT10woIr59mvj2xme8Zfy6g6IJvHDcHn67ZPOX/ia+/RClfogZYMJflLWVd3sLGpeS3GM1015GRPVX/i5WobgMFsCF2RbGVmHbe0BTDwuBWxDnuFz8SmiqeiGvTM5SZL2gskSpvGlmI45MMKKxfAdWDNwdiNTSxctzgXgDE7Zpv48waXftQG5gzrT4tT/0YGvbfbeEgUM7wAEl9I/PEcjGF6oKVF1Y0MVTmdpaF2qBXy18MjSGXaz+QPTxluqlU1mUv+7K5EJ0UFNWqEJd9DejoyvxUsRVBgOdNcuDeueSk0bEwKQpKR+4wmsi4BGauKdwh+r9nknTWiQPwov6RSluXwWj1Xk2TfjjGg0i2k23Gfbe2F/0Ovtz3sA+1QuTRDRJb2NoL19otJ
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(82310400011)(64100799003)(1800799012)(186009)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(5660300002)(110136005)(54906003)(70206006)(26005)(2906002)(70586007)(6666004)(8676002)(478600001)(4326008)(8936002)(426003)(336012)(316002)(2616005)(1076003)(107886003)(36860700001)(82740400003)(7636003)(356005)(83380400001)(36756003)(86362001)(47076005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 14:57:36.2660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a41193-f81e-4644-380b-08dc1b5a7894
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_145800_987526_EA66C07A 
X-CRM114-Status: GOOD (  12.46  )
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

This is a preparation patch for synchronizing the scanning during the
start of the controller.

This patch doesn't change any logic.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4fd3612b7570..d0e4888041aa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -144,6 +144,12 @@ void nvme_queue_scan(struct nvme_ctrl *ctrl)
 		queue_work(nvme_wq, &ctrl->scan_work);
 }
 
+static void nvme_queue_scan_sync(struct nvme_ctrl *ctrl)
+{
+	nvme_queue_scan(ctrl);
+	flush_work(&ctrl->scan_work);
+}
+
 /*
  * Use this function to proceed with scheduling reset_work for a controller
  * that had previously been set to the resetting state. This is intended for
@@ -1156,10 +1162,8 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 "controller capabilities changed, reset may be required to take effect.\n");
 		}
 	}
-	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)) {
-		nvme_queue_scan(ctrl);
-		flush_work(&ctrl->scan_work);
-	}
+	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
+		nvme_queue_scan_sync(ctrl);
 	if (ns)
 		return;
 
-- 
2.18.1


