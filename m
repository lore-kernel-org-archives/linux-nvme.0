Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061E5C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 23:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t3rWL2x09TyBEs7SEIReh7DydZht886KvWZnXAU4XZg=; b=wowy29Tm2r3XBjI+yLHXKUvcav
	qim2N8hT9FV7/hwJQy0tTENJDMOrePEjGZF8ojw81i2fF5CR8PXJg3+/5O65mTa/gcBSpnF22qQyt
	5YA+xf3eD97VO6pkQhTTz00lKQEICL6QG4HuTmLjKJXi6rz/95GFOLG6JatCAPNAo0VhXdlaNjVOW
	HD6+Fh41VsaLOXA0NqgjeAyTcCg82wBLiAy7goRv+7Z9n3AHCDz2tdHxl8/QHjn+fFzvXEtur4vX2
	PdHjqQ+5QY61bVfNDNhnUkYZLZK/yCAA5s8szvW9Z6D65sCFLusQNSjV4B5g5HSQCSDlXsVWxa7kT
	+mHqBjSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDZv8-002Woj-Uz; Mon, 18 Jul 2022 23:12:58 +0000
Received: from mail-dm6nam12on2058.outbound.protection.outlook.com ([40.107.243.58] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDZv6-002Wna-Dr
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 23:12:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOUA7w5x9uy1f194lZEfZbJS4VZ6Lbib8u2Op4U8R5Fr1B0Ay/kCeqeK4Nq+8PQ/MUnd7AWhhXKNKF7oAExKKY6CuMOhLJSatnu1psbhz0J7dEhNSLTkjY/ltBTRcxxyq4zUu8kRyKKtby82cdAjH8WqBuHJJKk50Ngy5gPPcI8WGszvLKxSsX7bNiz9tiuF/KssWokXaSTbBLcZkPBkKt9DmWI3XO9xNY/ePHN4/VSzvKYnA4Y1t1OrLNi/a7cxTKAwy3v9dM92ZD4q4DjnXOSx8id5qJIxAzH6pGr8UmLRp46ujnSI0qQ+qMAuHUhAMhm4zcJEpXoyVDC+j2AF2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3rWL2x09TyBEs7SEIReh7DydZht886KvWZnXAU4XZg=;
 b=Kebig58twrDFk2mWocw5POgYiBRY8KEiKpg2B5Jw+D32y99dtaiEK6Az37IPcyMqisS12+iH1iFSnNjRG5wE6E/vTDosqMBQMWeBZmhinAZ5TkoDNxLmgY+96VCSFYvcc8nj+S/RritFAFlgCl1VVOFJGG2P2O+r5jL6bUfBL8ksGM23wtRtHcXNR+NlFqk3k5AI3KirLs16rs6trLFpxi970Gvu7U9h1Ui9HZ6KK2rpUibOJOOO/ZA6LfHGJ1Y1LdL5HYKf5qUQuzLusls9YBoYHnk4ofFNi5lj7/7C0wgAen0tCuaGDkk+s7P/BEH8jQodgtmQFKl6JSrNS7xmkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3rWL2x09TyBEs7SEIReh7DydZht886KvWZnXAU4XZg=;
 b=R1BZMllSjCRARE18jct8cif2Djq+0f/kQZamzuJ977Lxt8kimiDBdUM5UExHOhjv+eqtTpKwIFF1DG6pDaIU7+lPPeSWci1vSIIAgURHzDoSUrW8fqLLJFHSA9wAk0syPSGCF4njHXtA81eCn/7wDVe+LqOEPkb/ZLT1edXdUnjp9bCRtEBizkB73apG8urG1w8nit8oquulRor2z+0AUSbvwJ/K20lGXpeWQS7m6vF7JtTzxa/zGCx/uY14YUb/PqBlCNm9cqQv0G3arrY9EGeB8RcYTSxvVmOwLS6/uMT78KRTEpn4J3BArpeIs9fDr+FPQuuUNi0SjIUkQF1+uQ==
Received: from MW4PR04CA0377.namprd04.prod.outlook.com (2603:10b6:303:81::22)
 by BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Mon, 18 Jul
 2022 23:12:52 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::ab) by MW4PR04CA0377.outlook.office365.com
 (2603:10b6:303:81::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Mon, 18 Jul 2022 23:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Mon, 18 Jul 2022 23:12:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 18 Jul
 2022 23:12:51 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 18 Jul
 2022 16:12:50 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/2] nvmet: fix return value check in auth send
Date: Mon, 18 Jul 2022 16:12:32 -0700
Message-ID: <20220718231233.3886-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220718231233.3886-1-kch@nvidia.com>
References: <20220718231233.3886-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98de1882-529b-4af4-5ad6-08da69130a33
X-MS-TrafficTypeDiagnostic: BL3PR12MB6523:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	MyPRhH5AWEzbbYtbwlAKUFUy8GPprCqlspFQ4TDNkS/WPHCgz5npRJan5f5tUHGmaZU6D8jWsBMEFgAJkeVUgdiwp7q28ki7TiKlkTPDkCNK45o3dLIVN65lYz/iunzwA/iZwJko1RBc4I5UiSQ6d4e7HKkG9bdCUdFLlA3wHnWzsUggC4xVv2gvrvTM1GooW4/ULeWXQdMm6oEtgi9EB5jEoNL0x/Z8t53qYjsgN26mFmtwv9GkLTFmn274gu974O/2OzIODze9/6jwaYrB4A1GYBmdF+1wXJ6d4ZY+kZVRVJRkPYfAF9QkDPX0h/wsqC9NWkWrIvh4/ZYGxUUpsQZ2HcGjBMiixjhVBRp4ZCY3WKvoVpNpNLA6gi/ZxZyaVb7Mrzrd4M7InPgVILEM5wJppaBtQHEBq53uSaYihze6iaTib8D+FPW2sVwnrv4F2eORaWlnBPfEPs6y5mjpKg/O+10gubq+58VFcJIbD9kCwJJGwthM6RoXlRveuC259WsVmc2BCK4TmJnqyWBLSPFuIepRALi3ii4+FX0w2qw6ZBvCi2wmXwoNBBBJ5i7Y8EX1rCfYJCYb4H/TW61frfWtJJB9/LdTjxTgm02URJ3EBIzwzuVsW4rMIu4INx3rO3EOd1ffhJrXDUfQKYRlVZp4iyFX3k1VEQBEoxHthh2HS9B6/dav8kFXzOHPlItvEF2oQa8CpEnF01EAHaKtmeF3JKK60YHh5/oisA14VtWTii1TNWL22PWmN0Fp6z///Bggs7ykiQQqbwbosQeYVKMCWozv9LpcVgq+bbKseSYXcXGjcQNOK0kwd6XmVGfJfXVSVZ2xO9mV/E5vj7udHw==
X-Forefront-Antispam-Report: 	CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(376002)(36840700001)(40470700004)(46966006)(7696005)(356005)(82310400005)(26005)(82740400003)(41300700001)(6666004)(81166007)(83380400001)(186003)(47076005)(1076003)(2906002)(40480700001)(426003)(2616005)(16526019)(36860700001)(8676002)(6916009)(4326008)(70586007)(316002)(54906003)(8936002)(478600001)(70206006)(36756003)(5660300002)(40460700003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 23:12:52.1529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98de1882-529b-4af4-5ad6-08da69130a33
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_161256_485572_E29B106E 
X-CRM114-Status: GOOD (  11.47  )
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

nvmet_setup_auth() return type is int and currently it uses status
variable that is of type u16 in nvmet_execute_auth_send().

Catch the return value of nvmet_setup_auth() into int and set the
NVME_SC_INTERNAL as status variable before we jump to error.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index cc56e8c821ce..f1c9c2f51afb 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -247,8 +247,10 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			pr_debug("%s: ctrl %d qid %d reset negotiation\n", __func__,
 				 ctrl->cntlid, req->sq->qid);
 			if (!req->sq->qid) {
-				status = nvmet_setup_auth(ctrl);
-				if (status < 0) {
+				int ret = nvmet_setup_auth(ctrl);
+
+				if (ret < 0) {
+					status = NVME_SC_INTERNAL;
 					pr_err("ctrl %d qid 0 failed to setup"
 					       "re-authentication",
 					       ctrl->cntlid);
-- 
2.29.0


