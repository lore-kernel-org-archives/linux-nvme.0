Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9323FC77B61
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Apr 2023 07:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wfjggkERA2Y8tt/Kgk4ibukvxEvEpLQka3HhT9ebZvM=; b=GMw2SYS267mH0k/lynRGTDTsUv
	wQPMnLPoQaVVjL7EdwDcYYKXggRkxdXdlT3i4SA0B3tgHitH5WMKHz8tQmPSOAqF7ocJWPi2XtMoT
	q+zmGGthGs1EbIpcVo/G+HuJqMErxuHnc15in3gJHZa/h/xpFZ6klVrOQEgFgf3f13JThAiNS7UOL
	s0+8UZh/5MtbcdBvR444cRkGuB+8+aMv80mEFFOybF1SdYWEhXOXwzInVJjcCndMcuU2h6Ee2nAbK
	3EjFTAOF8C5jp+0Pcv/dGpp+7hVK3S6G2o2RHNZq2TaZYm+wm+M7GYpbp1P+Fix2Ujm+q0IPxELrX
	npj6xKTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psIaA-008QMv-38;
	Fri, 28 Apr 2023 07:31:54 +0000
Received: from mail-dm3nam02on2062d.outbound.protection.outlook.com ([2a01:111:f400:7e83::62d] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psIa7-008QLu-2C
	for linux-nvme@lists.infradead.org;
	Fri, 28 Apr 2023 07:31:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iV8iBZWnVoGN3rVp5DUK0ORbzZdu6WwajYML5plj9SbU7WrxY+SMhQVaVCxDD5cS5AWdzkNGml2Nh+72Jne7ACG3CKLGL+jOQKoL5aPJNG5bWRH2AbxwvUmcBhlQNShRkGE1gCq6USRzm08NR/pRgq0z2Gf89qeUeKY4oYcrPKdLiGqEZOT7EYCAwky+UOtXMWgGuCxG3qFQ76Oeb7r46KErCScL0bYZBKCUgzUAyiyZf0waaFgT2gLxtmNwLiAUEkhulKZ5s7KeiKW5+A6/sXefQ8ZEhouaB8sTRUmNCls+hI1V6yf0PWNc6fF9BZWuL6xnjO58BOUbwXGU8Ya4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfjggkERA2Y8tt/Kgk4ibukvxEvEpLQka3HhT9ebZvM=;
 b=JkBE2ip1wbV/AloBrjirmqrUdSNId1fdg3JhQFvHEmpOyZ4p43dWt1nL+tXm4DpIwH9BEUXpMl6D7ZHVwF8Ndh4QuoM9DEAfhSU53Rls+najC3jXGkfLssBneBs4L2GSZuB9oVAc0xwqHjzm47dCvTmXm2GO9d1DEfhvwjrSblQR2E1KIrAHkgtww/R1HYzv3gFyq9ZhM4/asbu6xUDkUKETwfoL+ooeu6qPPGzoDlIvp+lfGeyoyofRbg+5BP/jnIOK7Kyn9dEyMC/XWv3VVVJoYyv8+hFnDtQrOVGDkM7+oz4nzZVZBJGtk07M2MfvZVjPpqk1uapAQskSp+6pEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfjggkERA2Y8tt/Kgk4ibukvxEvEpLQka3HhT9ebZvM=;
 b=W05Be2szw3QtX6bDOgutgZHRlcErwUqFsGiGc1so51vB1NaueRzht845F/DLP47Op2+xt4c9QyPB95LwW0DmjDQfVRjWr8eBT6tBKFhkTB0UEQBnUI8QbZkY1D64I4ViqEUS1R5fS99aC4viNNmhan0nWkc5tx/d4+75GWNGqsAzJmcRHW0YMO9P1U6qpv6AaDluyFT7tuGoM4JO3iOc4/gJ7mQQoi+Nst/fR2sB05XGcE1OJS3+pT1n37HYBE1JeN/0RUgD8SzxBwbwDWCKXOygmvbyDYrssdvH7PtE35oJwSE9F9OHsyYxpCt3bwBguPSRhXOJNBbBtLP8dFXYKQ==
Received: from DM6PR02CA0059.namprd02.prod.outlook.com (2603:10b6:5:177::36)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.24; Fri, 28 Apr 2023 07:31:47 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::9c) by DM6PR02CA0059.outlook.office365.com
 (2603:10b6:5:177::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 07:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.23 via Frontend Transport; Fri, 28 Apr 2023 07:31:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 28 Apr 2023
 00:31:34 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 28 Apr
 2023 00:31:34 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hare@suse.de>, <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH V2 1/4] nvme-core: fix memory leak in dhchap_secret_store
Date: Fri, 28 Apr 2023 00:31:12 -0700
Message-ID: <20230428073115.22987-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428073115.22987-1-kch@nvidia.com>
References: <20230428073115.22987-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT045:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 69080a3e-4d93-4591-2459-08db47ba9ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	/rSs1EjEVzYzwH6irgFdXwDj+7HmpVUM9DmlmJxCGBjIP6xqCKgcNRtddx48gwasT0tW2Rhp9quZALFdF6KYTJTa8FZAhnJjg94YIDQvTTclulsqcbrQqto/f9dnvE/KKXTlPyaudA5AoK8thlB7kwZAnp+AH512h+IyviAtxil7SNJXwSR/4VqSM2aUGRSlmGy+k1/9c+HX0hVdgHVk+ijx4Kha6Pwyk4VHd0f1Tr+IUG212SobIfSCIemcfh/a5s3SM4bawza24TR3RYNq4dwXaOl5Ra701TVcRLvRNW6g3F+wUH4s3sR/JCYZT9Xn5R+S9mIfNEzCZ1hyjF5wAcoALUZmVob+EqKqAbIDXZUZ9nnks/xVwTxHU/6P+nAnPgnIJAiYmxwieOqJsO0oRM5+JpnoJWVcyYdsnHJJU5fdS0Rxi2TDEIz/3kbJ96y01zx1+O7eTJEA3jGGSnpI0sTkOVPQ2L4lOFVlJYOT0Rp/OJW6J26UR50pvYHvlJYcydfQVeoWBXTN0SMsAytB7x1AzCTucZBCgsnHzkouZadMQU0+SN/0UIuqiFU78kInT2MOXIosmHs+lr01q30ncy2q0DCwR4txSptwjKIcqkYcfVOorAPk+XxyX5fHtHe+x4TjTNgZHMMICBKJitSoAXpih75lk3kkIJGQgMi32rRm4NovmUNzeT5r3xWJAksFPIkBoDc7gzK+Cbbtx6VSrARKBU9/4JRyH97IPfsO1qesI0dLHHbeJjmJGDSGSlUlKOHurVWY5+O3IqkKye3Dbg==
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(16526019)(186003)(1076003)(26005)(426003)(336012)(7636003)(356005)(41300700001)(6666004)(7696005)(36860700001)(83380400001)(47076005)(2616005)(40460700003)(34020700004)(478600001)(54906003)(82310400005)(82740400003)(40480700001)(4326008)(6916009)(70206006)(70586007)(316002)(5660300002)(36756003)(2906002)(8676002)(8936002)(219293001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 07:31:47.5372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69080a3e-4d93-4591-2459-08db47ba9ffe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230428_003151_818698_0423219A 
X-CRM114-Status: UNSURE (   9.81  )
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

Free dhchap_secret in nvme_ctrl_dhchap_secret_store() before we return
fix following kmemleack:-

unreferenced object 0xffff8886376ea800 (size 64):
  comm "check", pid 22048, jiffies 4344316705 (age 92.199s)
  hex dump (first 32 bytes):
    44 48 48 43 2d 31 3a 30 30 3a 6e 78 72 35 4b 67  DHHC-1:00:nxr5Kg
    75 58 34 75 6f 41 78 73 4a 61 34 63 2f 68 75 4c  uX4uoAxsJa4c/huL
  backtrace:
    [<0000000030ce5d4b>] __kmalloc+0x4b/0x130
    [<000000009be1cdc1>] nvme_ctrl_dhchap_secret_store+0x8f/0x160 [nvme_core]
    [<00000000ac06c96a>] kernfs_fop_write_iter+0x12b/0x1c0
    [<00000000437e7ced>] vfs_write+0x2ba/0x3c0
    [<00000000f9491baf>] ksys_write+0x5f/0xe0
    [<000000001c46513d>] do_syscall_64+0x3b/0x90
    [<00000000ecf348fe>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
unreferenced object 0xffff8886376eaf00 (size 64):
  comm "check", pid 22048, jiffies 4344316736 (age 92.168s)
  hex dump (first 32 bytes):
    44 48 48 43 2d 31 3a 30 30 3a 6e 78 72 35 4b 67  DHHC-1:00:nxr5Kg
    75 58 34 75 6f 41 78 73 4a 61 34 63 2f 68 75 4c  uX4uoAxsJa4c/huL
  backtrace:
    [<0000000030ce5d4b>] __kmalloc+0x4b/0x130
    [<000000009be1cdc1>] nvme_ctrl_dhchap_secret_store+0x8f/0x160 [nvme_core]
    [<00000000ac06c96a>] kernfs_fop_write_iter+0x12b/0x1c0
    [<00000000437e7ced>] vfs_write+0x2ba/0x3c0
    [<00000000f9491baf>] ksys_write+0x5f/0xe0
    [<000000001c46513d>] do_syscall_64+0x3b/0x90
    [<00000000ecf348fe>] entry_SYSCALL_64_after_hwframe+0x72/0xdc

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
---
 drivers/nvme/host/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1bfd52eae2ee..c7793991faeb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3825,8 +3825,10 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		int ret;
 
 		ret = nvme_auth_generate_key(dhchap_secret, &key);
-		if (ret)
+		if (ret) {
+			kfree(dhchap_secret);
 			return ret;
+		}
 		kfree(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
 		host_key = ctrl->host_key;
@@ -3834,7 +3836,8 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		ctrl->host_key = key;
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		nvme_auth_free_key(host_key);
-	}
+	} else
+		kfree(dhchap_secret);
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-- 
2.40.0


