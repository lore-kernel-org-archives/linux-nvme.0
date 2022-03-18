Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E761C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Mar 2022 01:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pyn3IDwAEVbsNCPvMlQSSLWY0UIAs05X0H2b3DMdcxU=; b=RiRubqqtMC3mjwaanB09PQFmKV
	VkpFUUzHMpGn7uHdO1W7us3V/MmLHwnGCwfl1Qo1BH7Ml4cSZ++DVo214Zthpu8QWfHMPEoPPcJBx
	nHH+jkcneXbRhDr3yldmRORWP0JTgCfjaKxwcgXVVVgPjztdp29+qIu4wTuQQg+Bw2MtOfMiErnXM
	6YcRc/U6RtYSu2X/czNkmT71Vi7BMm5vV0XoJE5F3Ty63dnmMKGvdor7zImqs2PRx2AbSfkJ3/ldp
	IVjGqP8WgsQ2PsmBKNYbm/iDfyC1hxkgoGVIBgZ/Z1WRkjPRSWupWKs5f/u91h3sw4Q5/awYKX0ri
	lXj29zBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nV1Lw-00072x-AE; Fri, 18 Mar 2022 01:24:28 +0000
Received: from mail-dm6nam11on20631.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::631]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nV1Ls-00071s-Rn
 for linux-nvme@lists.infradead.org; Fri, 18 Mar 2022 01:24:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EO1iuqS7X5piI5+z1lmp77ESlHnZQJ2ZZZZdpYNF6p9BYLQzIze9SrvvXUBnIAIR9tnOAUwybxCEVQOcmBwiblD65FRvWlI/q5hOiVt8Bpyn2rIXolYjcxnbvJyF/B1LjwDFLI1fCKZnNDlErrTjBFnevYw1fQFjZcRBj1BvulJMo8wcd2jPHMR2V45YEnkEocjP/H/hg1trd6o/zQtpjMGY174tPRVzGS/rGzqIY7Btx7ywSGGZ2jACMezuCA6CA1LHIpSi/8IABUm65UlsPlVPsWSXHczB52sSu7a/lj4UffMRFORTs6M5RIj0qIjp9J4Ot2/Qfarni4TVJ0doxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyn3IDwAEVbsNCPvMlQSSLWY0UIAs05X0H2b3DMdcxU=;
 b=d9y+M2DN3KuLCVr48ERMg974jmgJwB5acFub73Uo4b3dDcm4CgV1ZJ25fXyBmUN+sUA7JbSZLn3Z+dkVNcRifSs+2C9Lww1YZUPl/TRPwl4/MibD3TfBrJtBnmC5AfMZqWrZeiDEbDqfmUZVphwjDgyDxZiDKyTBAIWIzM0zj/1kdHvexRoz8Jx1s58N1pUH6AN+0wni7Sbd9ezM5yHelFILBPszkdG6NHYUy92og2FcquH40Kp+d0tOdORiyJ3NwwmZOkmP11+CghTFmsrEKsKAP49GoOVnKWFORNC7BqaKmKxX1NyiDfB8fD7xyH0UA7Vokr5+QzrPVq1Qz9i+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyn3IDwAEVbsNCPvMlQSSLWY0UIAs05X0H2b3DMdcxU=;
 b=JwcdaWvTD5b5O1d/Wki+WVWEwz1f5wO+BhX4AjvypaVNwo4DjfnnJ7iyylL8ixvHYG2pcM2/OGJ54VLQb8D1x6AzNPE9F6hZ2BoCx5YyG817OZvYfzwmYbpBhGACaHOqhoxtGvS3Hide2nIiokAbeLzF52AOzu24UZG0NnTsYo6PMFzME8UfiFOOGgx8QOmq3fhzdexWvDg250D4MvsmIYubzdzD6hIcvEubh6XDcMbD+HwlT7qAWEg32nJ3ATaNrf+us/ZuCfCa/Fy8nMDbZu3VEb2awkuALLXWhmWHsj54085EsIIC29vDm8K1emP2Yog5dQ1Yu3wV5k+K1tjp5w==
Received: from DM6PR06CA0024.namprd06.prod.outlook.com (2603:10b6:5:120::37)
 by CH2PR12MB3829.namprd12.prod.outlook.com (2603:10b6:610:2c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 01:24:17 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::eb) by DM6PR06CA0024.outlook.office365.com
 (2603:10b6:5:120::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17 via Frontend
 Transport; Fri, 18 Mar 2022 01:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 01:24:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Fri, 18 Mar 2022 01:24:16 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 17 Mar
 2022 18:24:15 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <dwagner@suse.de>, <kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH nvme-cli] fabrics: keep the backward compatibility
Date: Thu, 17 Mar 2022 18:24:08 -0700
Message-ID: <20220318012408.24779-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c1419ca-44ee-4565-b0aa-08da087e0578
X-MS-TrafficTypeDiagnostic: CH2PR12MB3829:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3829EE301125FE887A327263A3139@CH2PR12MB3829.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aknwR1S6mTiw4YK73ZdBj/vlwFQozUrmfNQ0KYANMjRKQFXWQkM4HF9PFnGZZsXczS4d8zpuNIykXkuJZLx5GUR1aDVyZHnLIud/bJAv3u68spZRtPAL5B3SSWCZuXe68ZtCVFuajJrGqfS0ZA7oly8okR8PJu0T8QSBbc7zCBNttgFqBekvnS/fJWRzoIQkmQpjN6nmuv0GLSBwSiFSCnJtXkkT658+R3Vg97lcxsFDeXBBMgj+4PEoZJ9JQ+IRDmUCT/yUPuZ6QNKEYr5B0f57zmkCNDFBBaL0kk0pAzcdcuNOV1xiTR+T+vd+oRvEhnd0eSabU6EagnFXv5CuG5juw0zCLakLJL/jXLaW7hOXAYaBASQ2Y2Jx+AlFH760HLsxExopTMm6qNrjqzhpjsUcM90yQ+0HZDBobJh/RpER3T+ymQnVsH+E3oA/9t1pgfv46KZatg9HpbZTWojbk/UP/z5ueL5i20tSEUbSyxy1dBY8GUhsctxyp6JEaUSw9VRID2XVNCRNa0xzvxGKQuauplqwpJzmDO4aa2JgK9h4dLAEtzMO/uG+r+awEPIXF0eUOKbqweDIQcOWFRZxVsDNjob/3mvPMQpDz8j4RdQSPeNkNmkEliR0ZbnpVvOXV4zwPrP0NE0cg4YkWx6rT3CPabfdzt0JMSE8aIZ/hOb1lkN64d3w5pnH87lUx46VTFLlL6eaeeOvzOTSePgU8Q==
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4326008)(82310400004)(8676002)(83380400001)(70206006)(47076005)(70586007)(107886003)(16526019)(336012)(1076003)(426003)(2616005)(186003)(36860700001)(26005)(6666004)(356005)(81166007)(5660300002)(8936002)(508600001)(2906002)(54906003)(40460700003)(7696005)(6916009)(316002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 01:24:17.5793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1419ca-44ee-4565-b0aa-08da087e0578
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3829
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220317_182424_932027_5A81CBA7 
X-CRM114-Status: UNSURE (   7.86  )
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

Don't print the message while disconnecting it is breaking blktests,
see below without this patch :-

nvme/005 (reset local loopback target)                       [failed]
    runtime  6.799s  ...  6.814s
    --- tests/nvme/005.out	2021-08-29 01:09:20.287901783 -0700
    +++ /mnt/data/blktests/results/nodev/nvme/005.out.bad	2022-03-17 18:11:16.198191553 -0700
    @@ -1,2 +1,3 @@
     Running nvme/005
    +Disconnected nvme1
     Test complete

With this patch :-

blktests (master) # ./check nvme/005
nvme/005 (reset local loopback target)                       [passed]
    runtime  6.807s  ...  6.801s

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 fabrics.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index e08ffd6..f51c8b7 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -791,9 +791,7 @@ int nvmf_disconnect(const char *desc, int argc, char **argv)
 				return errno;
 			}
 			ret = nvme_disconnect_ctrl(c);
-			if (!ret)
-				printf("Disconnected %s\n", p);
-			else
+			if (ret)
 				fprintf(stderr,
 					"Failed to disconnect %s: %s\n",
 					p, nvme_strerror(errno));
-- 
2.29.0


