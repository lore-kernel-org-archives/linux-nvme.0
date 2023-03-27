Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B32C7619A
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 06:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fRF35tisHXwo/OTfnqq80vbenYWbcsl18OaU9OaAOzo=; b=msFJ3fq+CfIaGA1P8nNFKJNP63
	uCOw8cQ53357zRPOs8c5EtMgH8uf9SkKUDFORk/pVQ2WSqphHVS7OGYlMo26jRYfGhnFWlwJaptkk
	0CfXdySnyeZnXRgZSriDu9unhl1JxbYlc8kjtnsdAbmYxRG0ceDz/dRX/5Hlr6uEwuyHbbp9imJVY
	6XF1+usEAEb4WcVPZLkQm/U5s4+PlgJfUWcl377840ldHl1T6T8Lp5wfCFIkmQKx1u1CsS7N/2DkS
	0xXUqKhqOzbSf1J0lIsjDl3bfxnsDG+6Cy3//slweRjTCVBukskOpwUmlMu9RrRMvQuZ58TeVHrlg
	8u+QCNog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfyv-009u8r-2X;
	Mon, 27 Mar 2023 06:05:25 +0000
Received: from mail-dm6nam11on2061c.outbound.protection.outlook.com ([2a01:111:f400:7eaa::61c] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfyt-009u7e-18
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 06:05:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZguTkooDY0QeW7uE3LgR6QJgs+yWYdJneJlG8OclVOa1Yi4wf4GAcY+Gw1U6a3qckpO2Tgi8PCXxGLC29v74lj71W/AEqaMSL7a9On2lYurG/I5+gX1f2nCiuqzZY4S8s+tASmbiOfdu8bxCSZp78a6gvYpWbybjeCbILGnrlOE3jgLLOhzrJQ02zpcC95xPnVOxbMtAZbQ2z3c7LH88mIfd89RW1xil6I80JynpauLwR/zXnKhlsQC77Pfzyjf/M1MRCpyehBEULmIYZNT0lnYBmEjNXJPmfWmME0AOGQg81M+1VfHmNFYqMpxhly1jPWLE+0nBwj7W9AKVXhwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRF35tisHXwo/OTfnqq80vbenYWbcsl18OaU9OaAOzo=;
 b=ap5mnU5AonHr9TmBB8fWtHC6SkAARISX0wAc2Cn4bG+1JoXDP5cQKYs5Z9tQdnZoMr2qYdFM08CAETQX4+QKhE4wp5TJx7uPsml0vkqiTjHFTqYSn58FiuwsTKhqLkC9G5N0i7KB8uCkAi6sb+bPcbave28MLkcL3pbiecP5A7iOJMJJhhebuJ2WDxokvUnSnm+QjpdEGO9WMMGC0HmUdxhELDvmAYQDhoT/8PrMTK+4mC6ohBwGrrEvLkEocufVlcI31jyIF4jCvh1YhDqHVxruLeVC7wCECEFfSxfDNKwGO5ySKY5f8TkJNxtZg5qwjKtbmJLY8ARdRGv7fOhlTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRF35tisHXwo/OTfnqq80vbenYWbcsl18OaU9OaAOzo=;
 b=cU4EJVVjjIbem6y0qqZ1YdxN30ycgnB8hG56m419VoMxYFVsK5rkVMoear9jbU/AKEsm4WN2wDik7V2d4R3St4aeNSaYhE8oPSY4PqyNRlbi7ba/lE1o6XwK/mGLaCDdm8M0HcfFWUp+l2V748W/Q24oidTglRMcExkZ2c9s0lCz58mOrHf0P0gksc91wM1GCy9i1t0J/Y01KgAkl0aplqb1NQmxJTiCPIAYW0/9TKGbYDpI7bhNSHv3vR3xdTqaYUEUPTgNeR342POyg01xjtIPBfD8Nw2CBL5y9BaNU78H2tsML2R/k/tbGp7JGed3dcko63KC5TT/czrpR8OGkw==
Received: from BL1PR13CA0128.namprd13.prod.outlook.com (2603:10b6:208:2bb::13)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 06:05:19 +0000
Received: from BL02EPF0000C408.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::4c) by BL1PR13CA0128.outlook.office365.com
 (2603:10b6:208:2bb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Mon, 27 Mar 2023 06:05:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C408.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.26 via Frontend Transport; Mon, 27 Mar 2023 06:05:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 26 Mar 2023
 23:05:04 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 26 Mar
 2023 23:05:03 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 3/8] nvme-core: code cleanup for __nvme_check_ready()
Date: Sun, 26 Mar 2023 23:04:13 -0700
Message-ID: <20230327060418.86655-4-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230327060418.86655-1-kch@nvidia.com>
References: <20230327060418.86655-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C408:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d69588b-10ba-4b09-6431-08db2e893e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	aC4+PBY6MxYH/myytku8RGvaU90llHAgZ7vDFWRBOtW9tazIaQ2YkcrfH46SqfbsuKBCpz/Q4UJ3giyGS25VdQJgN8fyxypULeHfzQyx3kWJ7JzC8AVd+knTikDmcFcs097D3bxSfTdmtucxdfxHNU29uER4nliFczVAwWV4vJEt2afPtEFovd2h6JdC8DauqHsmS4B4mPEN26B0O63wFdMhm/WbHMQNhROenSV5CMoLHrjPF+8Q7DTiXW+06Y+86Eyg4DQJ69yoqAgfS6qa+alUIXix01IaGygnCONFyzCBnNLmS2P5/zNqf0kHLYVbu9x1JoonovONX/HQ7gR4DQE0nnq1yfQZTjiKortHAx6QY1aOJdPm+Txw5aJNAShpmG2lsaZA/4SRi1k06uBf/AXues3LQGDWti9ZsD9h+humsa2iZJ+EmNrGn95i6gUmch6HQGyVk21QHoACAxtNXH0jnp/F308v8eRi+6o4yWY8pBOnyyPO+Yitrz7/FpqnEjrOXXQgj16h3+rmugkEsO9uZ/NCgPLJdK/WJlwiiCfxqU6ug0pzhCE0zzMd6JbcrirdFFp9fUcovbl433fHqN5RlfeNt6uS/+jE6KyX6IB1JxdX+YiDeTLEJbp0GYPnWPf5pPasVnVuwMqGH+By97Zb8t9pC8OGewNWewQ4sG+ES/ZKwHbeF7uRUuoY9G1aKHJQ+rlOgTa6jKkhRPg8rQF+HsAa856Ck8NHPYfVroIFR7BU3Qw0ObHWhp/A+l2f
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(478600001)(36756003)(16526019)(186003)(54906003)(336012)(36860700001)(316002)(82740400003)(8676002)(70586007)(70206006)(41300700001)(82310400005)(2906002)(1076003)(8936002)(5660300002)(26005)(83380400001)(7636003)(6916009)(4326008)(7696005)(107886003)(6666004)(356005)(2616005)(47076005)(40480700001)(40460700003)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 06:05:19.3910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d69588b-10ba-4b09-6431-08db2e893e6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BL02EPF0000C408.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_230523_398314_B556D609 
X-CRM114-Status: GOOD (  16.14  )
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

We can avoid using nested indentation by returning early if the
controller is not fabrics. Additionally, instead of using comparisons,
we can use a switch statement to determine if the required command is
connect/auth_send/auth_recv. This will also help to reduce the length of
the lines in the code and makes code easy to read since we don't have to
verify three different comparisons. Lastly, fix the spelling of
"appropriate" in the second comment.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 41 +++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 725ffa66fa6a..5a12be27bea7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -721,25 +721,32 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 	if (rq->q == ctrl->admin_q && (req->flags & NVME_REQ_USERCMD))
 		return false;
 
-	if (ctrl->ops->flags & NVME_F_FABRICS) {
-		/*
-		 * Only allow commands on a live queue, except for the connect
-		 * command, which is require to set the queue live in the
-		 * appropinquate states.
-		 */
-		switch (ctrl->state) {
-		case NVME_CTRL_CONNECTING:
-			if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(req->cmd) &&
-			    (req->cmd->fabrics.fctype == nvme_fabrics_type_connect ||
-			     req->cmd->fabrics.fctype == nvme_fabrics_type_auth_send ||
-			     req->cmd->fabrics.fctype == nvme_fabrics_type_auth_receive))
+	if (!(ctrl->ops->flags & NVME_F_FABRICS))
+		return queue_live;
+
+	/*
+	 * Only allow commands on a live queue, except for connect/auth_send/
+	 * auth_recv commands which are require to set the queue live in the
+	 * appropriate states.
+	 */
+	switch (ctrl->state) {
+	case NVME_CTRL_CONNECTING:
+		if (blk_rq_is_passthrough(rq) &&
+		    nvme_is_fabrics(req->cmd)) {
+			switch (req->cmd->fabrics.fctype) {
+			case nvme_fabrics_type_connect:
+			case nvme_fabrics_type_auth_send:
+			case nvme_fabrics_type_auth_receive:
 				return true;
-			break;
-		default:
-			break;
-		case NVME_CTRL_DEAD:
-			return false;
+			default:
+				break;
+			}
 		}
+		break;
+	default:
+		break;
+	case NVME_CTRL_DEAD:
+		return false;
 	}
 
 	return queue_live;
-- 
2.29.0


