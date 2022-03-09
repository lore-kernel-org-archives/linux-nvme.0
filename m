Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07F5C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 06:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2g3ZhEjkCRwUNEVs6XNAL18ioZRrtmqqw30i16plm10=; b=XdPqOuN157HVgYBAusA0uZxfgT
	hY5MHCexLPjBqDUwKexllF2gs3dtQaSQwOCAaAlMDfsMgbfJEKZKMSW8S2B6gAsI0nqUY5melaBXo
	BoTC3vjyFfiWA788Lr4cFSc3TwrkAbCsbbmO1wLQCjulbDux9hHgE3wjnNgmJcRWY7YBi8aatvtI5
	zoMeNeEzPoGIVRJkwIRsq9OgWm8r55+A1tfWVKjpaMPoKh/8OvGyb4GMKGEHMfgydc3zjN2KcFcGv
	DRzQixaS+IuQElx232l7yPICy/47hxKQOWcWl/RIIIK0KoCr9Jhi1N7NdUtd6GXlqKMuT/hOdV5JI
	tbIYUm2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRpN4-007PSl-5Q; Wed, 09 Mar 2022 06:00:26 +0000
Received: from mail-mw2nam10on20629.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::629]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRpN1-007PRn-R6
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 06:00:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSQOF6bfh+YWrnd3nGOJOr1RsmhV3QKT6eDgQJqnRx3GIWPQUk39UWDjJR4MnO/NUwQkpewHdFSEU2QTrHxtSX6xW3Ifv4DGsl8yVQADP8jl8x3WD1ON2IDSc6R6OnTlinV6QufMmVIE629FlikyRltp+f42YHuA06IWf/Gn3NPHjpHfBTfGXM1iy7eGflCtxll6g0ePkKv/QcuQV33rM20cgJnbSr2I3UmGWK2IWF/S+ATtgfGbdzf4y2kCpw2ExJDVQxiFZuNKPT6Xm1HWR+RjI+mgne26u0fnPbn0Q0/cp254IIHVxiSwe+ISYW5+uSpKfSyJ7zOMjYBzhuzr6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2g3ZhEjkCRwUNEVs6XNAL18ioZRrtmqqw30i16plm10=;
 b=Dg9KeH7eFgsfovVvl4f0QR2FAjDWnvpbtHIB7y+qOlPWIg56BRVWHI5qJi8XrnAhl/8PtYcj0+DhuEmfAvcrnqyY6fbpD3CtCjUOuCtyLWZVfAV1lVzOCuO36CcLQSFBn+er0heH0YS8NkXuhlLTwue6yNi98BWpzRGVYB6dGiyWnt8NhuKdGIYyvSPSRho5PkCA3jKbelOVAKHgE17UIALZ6WZADBt9gOwnicdFVk01EqHKc2KO9b4fTYfxjeq2I4rw+s7SLIPyP1MDE+GvbQJ9Gd/XqRAJVGRP6PtByhBPxr/jvfkRnRnj3IssuiKECX+4oVPWG2JNDe3q3+SJ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2g3ZhEjkCRwUNEVs6XNAL18ioZRrtmqqw30i16plm10=;
 b=cLRC6OjoyBG0iMBbfRNufJWMXagxZmduT+KA+uOl2fA0U6Ctwj+eWhjdA3ATybTyspQnaBP15dZdFHem8DSFhHHx9rqJqLBw8gYHGt5oxwcGyiwpJoKlelWzmYs90U0itak2ZywsjMCK2dOS2ufDVUxmoqjl+krOKi9p2m1P32U+uTQk4lKDxKYKFXK9qsUhIfP++79JL4xM3kU1xci220DA4UUxox1xkB78s9im1YoLcFvjXdlHOPytY4lHMIpbuAyTz7JHTp3u1lrtFgsbCoo/Ugq1xfGP6+QRg4ekJwzaXmu0D7E6XvmALH1B8MF3SMH0WmM+KdeSZvwEWNWVIg==
Received: from BN6PR2001CA0010.namprd20.prod.outlook.com
 (2603:10b6:404:b4::20) by CH2PR12MB3782.namprd12.prod.outlook.com
 (2603:10b6:610:23::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 06:00:20 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::cc) by BN6PR2001CA0010.outlook.office365.com
 (2603:10b6:404:b4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 06:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 06:00:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 9 Mar 2022 06:00:12 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Mar 2022
 22:00:11 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <axboe@kernel.dk>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [V2 3/3] nvmet-rdma: fix kernel-doc warning
Date: Tue, 8 Mar 2022 21:59:27 -0800
Message-ID: <20220309055927.11267-4-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220309055927.11267-1-kch@nvidia.com>
References: <20220309055927.11267-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 996116da-f06f-42de-ffe4-08da019217ca
X-MS-TrafficTypeDiagnostic: CH2PR12MB3782:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB378291D06B3A33174CFE95DFA30A9@CH2PR12MB3782.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tTprSZi3ldkPnmMqumtzNzdKZixiu7FAG9TH16Eimny+FOIJwJYsAGCgZSR+ino8oYTWPZqX2jecKfRuJXsZVmph3DI415HyblGmIiBO1SVSLZ3GYBv1G/vzmZ1e3pTr5I2YYs4nOj/L9EkAxI1cHZx5m0YEVqyg98vYyr6/RmpQGLykxg6p36ukkI1MDKVJCsTHEQHQ/vZmeHKZfOsvohAONOrUWckttRHND8s1Bvmcn48S0sOUV6/XCDO71aa/ggJl+NjdprBHCi+2pNknQqJCoOCPZph0LHeWe70E8MsplNJ5zrkFMRZO1usrpRjzkdUBqx7fKmdxpTDvXjWeXMTR/9beRa4LDc9h8uwmlRTGOY6jER0OBgmntsamAnzIR6XKkZmVr+Mw2yBUvRsojN/5/7UeXlfy2Ly0IBo8fsYkD6HniGMzgPvCwliNJt8VCDUxMBg4y3N1Asf/rHVO2GvK9LaOyfwtNG77Hf3lNwtGL7s4F52igNK9+RV++pMGYos2L2HC0z34/gVw/Qekch1L7xTAJPzURCCMHVwrQL+/qWEprQnkx6sGtqjNbaS8QIyUWLbjIGhGJOp+snptdfmnMX4CRKHx44+1cApArAeWfSXnOrxdgE82RssxA5Ck36RNtb4kNYzlY/Nc91Oczr3C18ezQmP0HmIcTLVBfylto8T/XYEVjkY/MHEcHY73aShIGUcOz/7fy/LvGwC5DA==
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(4744005)(6666004)(26005)(7696005)(83380400001)(2616005)(1076003)(40460700003)(356005)(5660300002)(8676002)(2906002)(16526019)(81166007)(426003)(8936002)(508600001)(70586007)(70206006)(36860700001)(82310400004)(316002)(47076005)(186003)(107886003)(54906003)(36756003)(4326008)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 06:00:20.0504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 996116da-f06f-42de-ffe4-08da019217ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3782
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_220023_907995_D6F93B2F 
X-CRM114-Status: UNSURE (   9.22  )
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

This fixes following kernel-doc warning:-

drivers/nvme/target/rdma.c:1722: warning: expecting prototype for nvme_rdma_device_removal(). Prototype was for nvmet_rdma_device_removal() instead

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 00656754e331..2446d0918a41 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1703,7 +1703,7 @@ static void nvmet_rdma_queue_connect_fail(struct rdma_cm_id *cm_id,
 }
 
 /**
- * nvme_rdma_device_removal() - Handle RDMA device removal
+ * nvmet_rdma_device_removal() - Handle RDMA device removal
  * @cm_id:	rdma_cm id, used for nvmet port
  * @queue:      nvmet rdma queue (cm id qp_context)
  *
-- 
2.29.0


