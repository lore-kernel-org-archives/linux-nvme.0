Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3925C76195
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 05:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Zfwhj5uvGehr76Ji3jDXOrOFMYcrbmKaHzBYVuNEBpU=; b=CVaMb0yqxGK8CXSy3uer3fb6Qr
	fvOF02Rq/fATFzI1KKhhwkPCuM7JAcRkMZDeK1pxKu17/IXhxtfYDjKJgT9O388YmKqBmYTbW2xMw
	TcRLH1KfqHX5ef3bNCI9VE0BpAUf59VF/91NaR3OdTxHtHpP984eP9V/NTvT5ql2sMV/gmqoSQGdd
	I5EcWAaCw4tMktTzG7UTF7Xs+SOJFcr+B/PGIWczgpVQ54+MI6pL7zCupX+CKe4dmNu2wc7gRb0QE
	kYwhhp9qWtGHwuw1huLvSfknD/x7QSLhIcl+8E9FyzhdqqqE7gq2Mh2fLCsCXEQZqWQ+PiQv8TgEr
	dnKrdzwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfjF-009r5E-1w;
	Mon, 27 Mar 2023 05:49:13 +0000
Received: from mail-co1nam11on20629.outbound.protection.outlook.com ([2a01:111:f400:7eab::629] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfjC-009r4g-1z
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 05:49:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfVM/MlIj6A5q2Dvp/Bi720J6s8+yv0ZUx793k3zMOUvoDVG/8tlpawnNNr9QA1BsaXxXFtF4WdSX5xIieoLnVyCGYNGPG5KN6pru7CXQUnbwc8qv5ClY2tNsIY/nIjTb9Kwm56QcURwEzC4OAkOAljzMxjfmkrV1OPEYgpNdRchdLmzIzvdja8BKDFPef4L4JDV/j0/jiZdTpwDoNecsrlhQnGAUpHC/+X+IuW7vhld3wvY6r35gayoPa/eFIc6jL2fpoeMjM1TpvNtaUxdppYVpVXmOCFHbh2cOcZU+wT2aVndVmyht5nlwNAv5mDt0g2WYn+QaAHOoL6c5sl0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zfwhj5uvGehr76Ji3jDXOrOFMYcrbmKaHzBYVuNEBpU=;
 b=B0SQJTnbOOLMCxJGljspTr+o65Pe1FNashYxgDLiGhmixCO3akr+BpuX6Awx0jn3kFGJ4+cHSvKAuxV/8mkGc+35qaQMlbiW8+HwEbo6M89ckvBoC3sXGtFPvcTOI8vGnTC5CtANDVKT+x7SsdQdo2QdUaxt7E8LN9+ArRepfSdIxNZM4QGRIs0ybUXZyxeOpc4Mkt4TT72Hke1EXtboye3j22EJLHJMibXYxKsgc0XSol63162jq/IKHdl+2PDWGPx6H3ZYgxu2iCQGdOuRUumgjovnHnSh7IvDXhRZH2fZeJVdYkV5tT2vSlT7g/x0n3ZpOmsi5zmEIqYMWOqKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=marcan.st smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zfwhj5uvGehr76Ji3jDXOrOFMYcrbmKaHzBYVuNEBpU=;
 b=EDwiNTCbcR9HfrELtxvVB2pizSMAIQRQfUSxrsP8F9iTAU1LuII9rlpcRucF7ns0sXX9UGKTlXcV9WWf7I4w5RPUFGdQSAjPWbGY/OuqOGUDLVcSGf4COUBZdE6FQl0r8FAaymaCMyZQFWn9j9217CwVI3Pyi0I0tchwpKtWwWtMPRVnQ149HdelPZKEjzcTSXiBYh8je7GE90p5S3T+Ko6TlFtQWebRytT2HhYAa6ctH8HKCsjF1QpX0aaVMZkO5cd4oKCkqMJWMOik7gAkwTOTgcr5UmSduFwvWdOm1lIBsONFG7+nhAq6vcpRffZvp/c8kBXDaCOUBN8gdDG1vQ==
Received: from BN9PR03CA0163.namprd03.prod.outlook.com (2603:10b6:408:f4::18)
 by IA1PR12MB8518.namprd12.prod.outlook.com (2603:10b6:208:447::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 05:49:06 +0000
Received: from BL02EPF000108E9.namprd05.prod.outlook.com
 (2603:10b6:408:f4:cafe::5b) by BN9PR03CA0163.outlook.office365.com
 (2603:10b6:408:f4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 05:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF000108E9.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 05:49:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 26 Mar 2023
 22:48:47 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 26 Mar
 2023 22:48:45 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <marcan@marcan.st>, <sven@svenpeter.dev>, <alyssa@rosenzweig.io>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<asahi@lists.linux.dev>, <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH 1/2] nvme-apple: return directly instead of else
Date: Sun, 26 Mar 2023 22:48:37 -0700
Message-ID: <20230327054838.67353-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E9:EE_|IA1PR12MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: d8bfba1d-3c07-4509-32fa-08db2e86fa58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	givR1NF/YkhmR3KfGBqXtFahvOkIyqAUiesoGjD+uXvANErTO3x2UBaa5XKl2UFYS9fT0ugUr8rt7qeGZMkkdjMJN9MbEhc8jcgK5JLl+tnVbFitkaAUfwXgyzt1gkt20EytYTe5Ae21kPEcy9NYE9pI5QFFH2fHLaT45l7vP+x8Brh7yoIpRHyVfyWOhUsOtQuakBjBD+2RkmfGiwmiCJlgZyz/Ufa33EFpzQoR/VBBPvA1ZqDv2bywNlCXtzwAlMzC4dCLufQ8CEx3ABAptvm2cvbLzGwVluYNjGYW7CkY21THl2Y3v0jVcqeWb3AHVAP6VvvSSdLF8kV33l6Vo0dLlxczeH33gd3dnIe9i8TLx5/dan7DHaLpmLK0QyRP49bAqMV0sMtauUEf+TiC0KAiAuR8YIwqQpgPXRcJzHbjlxkJY9OL9fxXyqVe1fs2pXT+AuG3WMsh27lLFPLESuAIETeIlz3utjwufQt3S+JNk0BxppWei8UVf8dCFbPd1D8wYnsPEpGK7QC9Gnupjw/LddrdzXm6kRtyI5TyRc/PR/eaYhZBS488GGxuPZIFb4fuBkwxPy3+mnGoSzkJq2r6ojg2cV4wV5fIH8SrUiYVRx3nMw7S0FEtW5fr6LfoVMOXjkSwY3c0rBBc+1te+cRljzsoumDLRJ0Z67GME8h4myTlpIj7obXhzS9sgH/OKHfRZoJE7z3tADtk0oUImnN3LUV6ZlBUjV7XROILpnXqDNmY5eqGrof/PDOzdm31g0ZqpANcTn6gfNxzTXLWf1pc4dqDlfn0+0aiP6DejjI=
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(47660400002)(451199021)(40470700004)(36840700001)(46966006)(36756003)(40480700001)(82310400005)(356005)(40460700003)(2906002)(107886003)(6666004)(186003)(2616005)(16526019)(1076003)(478600001)(41300700001)(316002)(4326008)(70206006)(8676002)(54906003)(5660300002)(110136005)(70586007)(4744005)(8936002)(7696005)(7636003)(26005)(82740400003)(83380400001)(336012)(426003)(47076005)(36860700001)(46800400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 05:49:06.1605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bfba1d-3c07-4509-32fa-08db2e86fa58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BL02EPF000108E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8518
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_224910_660812_364372CC 
X-CRM114-Status: GOOD (  10.87  )
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

There is no need for the else when direct return is used at the end of
the function.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/apple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 5fc5ea196b40..942a3b71a6d5 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -209,8 +209,8 @@ static inline struct apple_nvme *queue_to_apple_nvme(struct apple_nvme_queue *q)
 {
 	if (q->is_adminq)
 		return container_of(q, struct apple_nvme, adminq);
-	else
-		return container_of(q, struct apple_nvme, ioq);
+
+	return container_of(q, struct apple_nvme, ioq);
 }
 
 static unsigned int apple_nvme_queue_depth(struct apple_nvme_queue *q)
-- 
2.29.0


