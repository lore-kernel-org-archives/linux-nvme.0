Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E033FC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jan 2022 15:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eeg/m7scd1/yQ+GtZ33vkeY1VCXyGhlOMKGb3sI3ir4=; b=RZuTdDSzfnmKiVbpCDYbZdRYa4
	FXgmNdSTWNXTwfoHuuztP8OOSf3V1DlqeBK3Wl1PXr0qAOo1RCZ5KP3oGcPmjgE6BnoNOwuLHWGau
	gKB8lhT0MIQH9fMg4wqaWi2PK/OXsiozjZRyFMcJd1ZwHTigrmYglM76wZfu+lpRPdV/Ly9/Hyoxj
	rTKQooWg7sIfjgnpdasa9K3KdNVL1s1+FkFVuzVSP+AJElXeHbPqvsbHinOALIOK437uTQ3x7B5DV
	xjJygfVr7aSCS3On+CBbM9Qgy4/1Oek1qtmY/2RKl77/0IRCzSh459EUWt9LYvNZ5m/ln9sZVTE9N
	xcSWGTAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCNlz-008OOo-JS; Tue, 25 Jan 2022 15:30:20 +0000
Received: from mail-bn8nam12olkn2105.outbound.protection.outlook.com
 ([40.92.21.105] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCNXk-008KGP-My
 for linux-nvme@lists.infradead.org; Tue, 25 Jan 2022 15:15:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFx8M7sf5SX43dqJ4Xm/yWodKgSmrXpD1RUEsJbHi94oaRhfXzD58m8KkKl9K0JVMk4EL/UHMbsKP9s8/6tB3GLRb/DB7CVU5iJ8TSCuI1EhER2X12LEnH/n+0pPntdemOsrJNmD4Q/ToAs154/BHDpPLqjRnBEIf2wh57P09Rdtt+uv5yGwnXZ4y5XR5wg4FkFqe9Hjpaq2uQVyRlF2Wo7bbpYgd4GbNNtDrRCKuwJ3bLKtSj+60VI7WEoGY98WB2sVJ+X2XmYTVkT+AF5SrXEAKa+1OqEK8gOLsEVX5ePr97G4IQJlaFPyiXgdGVjwvTClG2N+VND9D07U1zow0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eeg/m7scd1/yQ+GtZ33vkeY1VCXyGhlOMKGb3sI3ir4=;
 b=kf0VMgd0famatrllR4ofLrb3xxFv0J9MS+FU6uQMbpSJVN0ya2hyeaAC97fcV8LAWBZ7Z00V7i9xaVs+MbbBJl05AwNsDSOotSkhmIJKhn4uFRzkrgsUDMp2jgd/j7sv5C9rCHGDM32/GgMQ/EBplSv1J1Q/hrpZXxlZRvKp7QnaBB9qBrP7uMLiOZnO0eAC79x6PLuE8TEQ/HWxDX7mauEbRO3lzJ2Yr53ULxAHFn+ONJK75sn+D6KvUY6+sg6ahtNe2xCFFig8jjaIOZ/XaQVc+dzfv2YARwZhGJ/qB+5RyRFEHkNGrtVSpaCK0MTgs4f5Z2MkWhNLdmSAzIZXtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eeg/m7scd1/yQ+GtZ33vkeY1VCXyGhlOMKGb3sI3ir4=;
 b=NB9PLwUda2CcVtJ+R/cF75leaxsRLYygcGirdjONd+XY51II2a61rpXF/jXGWMYApX+rEI0LYUsFp/5wKrKMOqROw05l9gZtplNrZrQCQI9wjSTIU2gYdq6fkxhVbwjb/CYLwzPmm1NgDH62Oaeez/FxZWXQpSFsOyRKhOa9+MceSAYLgX36IpU9wcuc1jQKmR5UES+UJ4v5tF/HL3YOLSDVZZkMvtlV+z5IRknqpnmTeb/HN+D+dOVW5YI6f2oxt4jtCVtvWqHtaRRAmmLyFwnidXEtVhiHNHK7GeWt3uMYVuVoQCl/cTOAM5D8P8YjjXCMFV3purujHibKM8kNLg==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MN2PR13MB2590.namprd13.prod.outlook.com (2603:10b6:208:ea::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.8; Tue, 25 Jan
 2022 15:00:34 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::8078:8a78:bc1d:43f1]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::8078:8a78:bc1d:43f1%4]) with mapi id 15.20.4930.015; Tue, 25 Jan 2022
 15:00:34 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, Martin Belanger <martin.belanger@dell.com>
Subject: [PATCH 4/4] nvme-fabrics: add explicit deregistration on disconnect.
Date: Tue, 25 Jan 2022 09:59:56 -0500
Message-ID: <BL0PR13MB4291B32271567EB19DC312B79C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220125145956.14746-1-nitram_67@hotmail.com>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [EWXFapfpGkGy0oDL6CrmC3Hgz4AtjvlV]
X-ClientProxiedBy: SA0PR11CA0170.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::25) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20220125145956.14746-5-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e896c00-39e0-437e-ef5a-08d9e0137057
X-MS-TrafficTypeDiagnostic: MN2PR13MB2590:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dexHkHZvMJNm5U2WWQVYSpqRlV/E9+PONZZgodmy8LPdFRe/t0UtCr9ERZ5OHFjiw46KhdQSCElI2oWw1VLXbKsE1OoWVXHvgzPldGfOksjc4NOBr16ozxKfzF0dKh0KPPDFD8Ba/JD1d64NkD2Aghg9pMHrKhPYWyMSyF0qeNRSIqVSNbzZV3qZWRKPLBECBu4//n606sZOkc8LXHFrd0ncgqjIajeAIaSUFzVJx/ZcyNM7AqqE8ftIfQwO+m4qDHpbfhYNjgPDQmDOvWNfaaDwXvXW2seaDQ0W0CcpD+7NHZzmRno7gimqS775+1C242/PSrOcmzuXBYNJWhTeSL44yO0FJneOtXZBcp+01JfMNRjU5d/ylDbNPz0wHSGTi3rJSEkqBSb2yOWgb0P1G++HgqpgTyTR4MhVgqgDtwTcDB+fndgw/5K9tuYBW3vfZkDCwJcMPP7B6EqIUaO9DTx5R+uIzYP+KNG01t3NeEl/rQTfEY3SNGqLanOuZAzwkDh1NTHNPw7MYE3Tj8SnVzNMLgwc8zxe6Q9PQm4CB4I=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s8+qLGQd1aPAz0kBqRENP+U5Ec3WtoX3/e4mjRPLqQ0gFpJdhfv1IeSxsl/g?=
 =?us-ascii?Q?itM3AMddSuuVZAoJbeGkzPI9HV8KEqk74BakIe5rA2T6ZEhA44nBMu4aa0Vx?=
 =?us-ascii?Q?a7BPNO4ISwS2vQNoJyg0sr8VbeR5yhf/I+4dIdX2iEObJgTRlmKxc/du1PEb?=
 =?us-ascii?Q?ktDqBVdEVkVKgooQGkxqYTdzdD2lItBqfpDgsrNZK5/J46Rgy8l6iuLmMH2a?=
 =?us-ascii?Q?1+pYNY/Im1g9NPYXht7lk0YEAz7vxbcXgNlpLeyHnofsnRm/mRL0rI6qqYBr?=
 =?us-ascii?Q?5z2JCXc8FJmhd+xXxdCF7bqkSh+pi8/qMFIAU0qaOwFkWoidjlIFudfl+6Rx?=
 =?us-ascii?Q?hnvzx07MvtfsB0K1o8KaGLsntmnEmYIcZokHRWFI5Cr/Y7TrrkUFhbFmgVLW?=
 =?us-ascii?Q?7KgPIizdyCx9X9EcNc1n4DRLRbvuI4Zw+gaypCxHevb/QcRyyBBV9pGA5UJd?=
 =?us-ascii?Q?uYD/Wa1DbnLokFnYki0aRZMRBP5FHWYcTBHvYNTg8Xkw06lsZ+EXVPPb6a6J?=
 =?us-ascii?Q?E75TBll8G1MDi1bh4WQ3nFP0gG9LmD1MHNRT2yMk9DU4W3UUYZIOQjdXovP7?=
 =?us-ascii?Q?AbX2zm4eHxQeWYh1egoO1JqF2f6a++Vvq8aEYDYlDXDjamsb+uerT6ocQTnq?=
 =?us-ascii?Q?XRMO2oII7XqPAUAtgwxMM/hZPsYMZ7oPYaS3p4ze26tBLWQ1MszjdXYKOlm3?=
 =?us-ascii?Q?9lpPOP/Lp6s+kDDx+A9CI+rPqKnwmOmIbonvY5NV6KnMTneFnHu8pPn4E0WD?=
 =?us-ascii?Q?vhvjhdlqb3oG0n4GG9g7IQToc/7DOM+BJ8qtdZskCj16yORRVuk43N6glBW3?=
 =?us-ascii?Q?qdQFfOnZnqAQAC3/c6669SQoGVQMwJljBMxt2O9HBneI2v0n5iY3Izjph9m1?=
 =?us-ascii?Q?AbuEGQwRMXK1CLRcW7L0btzYCCKvt1ZJZDkLnMD77X4I3UgxOIpUZ8JAcJ12?=
 =?us-ascii?Q?vIPcsuRgtF28SFxO5W/quw=3D=3D?=
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-da780.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e896c00-39e0-437e-ef5a-08d9e0137057
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 15:00:34.5322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2590
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220125_071536_773709_DB61D073 
X-CRM114-Status: GOOD (  11.02  )
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

From: Martin Belanger <martin.belanger@dell.com>

Per TP8010, a host explicitly registered with a Discovery
Controller (DC) must deregister on disconnect. This patch
sends a DIM PDU to DCs to deregister the host on disconnect.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/tcp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 970b7df574a4..804d927b4b81 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2176,6 +2176,16 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 
 static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
 {
+	if (ctrl->opts->explicit_registration &&
++	    ((ctrl->dctype == NVME_DCTYPE_DDC) ||
+	     (ctrl->dctype == NVME_DCTYPE_CDC))) {
+		/* Deregister from discovery controller */
+		union nvmf_tsas tsas = {.tcp.sectype = NVMF_TCP_SECTYPE_NONE};
+
+		nvmf_disc_info_mgmt(ctrl, NVME_TAS_DEREGISTER, NVMF_TRTYPE_TCP,
+				    nvme_get_adrfam(ctrl), "", &tsas);
+	}
+
 	nvme_tcp_teardown_ctrl(ctrl, true);
 }
 
-- 
2.34.1


