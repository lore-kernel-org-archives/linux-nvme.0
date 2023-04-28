Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5DAC77B60
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Apr 2023 07:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2QBqiWTMefj1MoGLqpY5vvLBbIo4IYGithRVhPG5QQs=; b=QP1xhJ0KsdVWvtm1cYdecGnePX
	lRG2QHp+bKuEAplriiRoxO4Q/BNrBnORspsoJHbxR+K2hZMWR9ohi/oR/XFD1PUe+sPzL42tSd+la
	LYBVIqHDA67z8auYfpbcMcQHjwNWeUaH+72Sd0CwB1qV6NvFLo1PPWjy/rcZCN7Pm+IDWPx/xAES0
	p3Jn0QYNKmm4PbUR+HJ/cc9Eabb1pfv/pEni8wwngm5zfxvIdSwfMgbUnXz/LpsjjTUe6zHgvFMVV
	fmZw94qrQH3WinedskRF+ZXM68crPQCAwJ8E7mVeYSbjrM2btio79zvIsZrjcEzihz+Jihap4Gy3E
	YbHfFEXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psIaM-008QP5-0u;
	Fri, 28 Apr 2023 07:32:06 +0000
Received: from mail-bn8nam12on20625.outbound.protection.outlook.com ([2a01:111:f400:fe5b::625] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psIaJ-008QOD-2H
	for linux-nvme@lists.infradead.org;
	Fri, 28 Apr 2023 07:32:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g41rvv4bbK9IRiweZh3DR86qrXuHFEZ0IPjGe9biu7VEmn0+LDcVD61DJprvON5L14SjcogZTsCW3vYspm2sjMYPgtGf0j+enyvb0ygBOrTyPVP8UEo7A87g4N8eukqcx6pf8IG9jxQXu1YyXKBMQhwYjULK9WOj+G5+D4e8IctsuvveO2Lopgah3y9X3B/AQiqcIWFw0tJKiKXn3hXqx4O8A/Lu0L17+ZmVDb1jxIT7lfHkYUq+7QCztKBnV8a/kS2iGL63GC51ubi8CH+FZfHOLJ0HVs4u3l53lCKHUsGzTXGVDTQh2q//5xnqyTVeWGLEaRgr/yRnjUpc6yjGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QBqiWTMefj1MoGLqpY5vvLBbIo4IYGithRVhPG5QQs=;
 b=jYtNadNmS8erUr5cKYZ4mcYuU56hTn7XypMF5/06JMYU7/USu++Ax2M2mZJQ39lsT8lkGCtX7xwuA4pdokAx8j2CisMG/VnRFsKBgW/zy2UEZtvSn05s5yv8ftaChB69tUCPnu1FkW/GO3NEzVLXyKUrCHKx1zN5nctquF8HUVqjziwCBYZL5BmvqZL5GigvVsGHqjU1IAj0c7kgFio0fkuH+5kzf0UW10XWiWkGndP1vkzpzW+a54MfYF7DQDJIDdAb4trAL9uIJ5rO2nCrEF1RkPDoTm/SuGEhgviBCNe0w7My0K3/k5zxC+ImIeRQFbgK2j6qrsvyjdt+s+4NwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QBqiWTMefj1MoGLqpY5vvLBbIo4IYGithRVhPG5QQs=;
 b=jXprIfIof1TC1uV6d7nCIEfEi4zopaOrr433xzfsxwPOGUpTgxYdVHvwkfJjxsiao7247s/NMh1k4zrfUqUiJVgAr2bb0pc5S8ZKPJWwsrKs+6i935LEsu5Pedavv1fvZpuoK0dRupK6s3e39U8gNbV6aOaMA8G7k33B05q8L0jpMLvzTGJs3PWW/eMmr//o5+H3qqEQb2FkezcM4vzrG6xqsYrI38y6T8V9IwOVumGakEoeTHS8uElZSXrIJjHE5SHeOr/OyWQVkcu3xPYPcTEVjjVdlkD/U3VUspyxFKgqXdhDienZVV+xcADn/ItxlrrPP7Hr5XqqM3HBqkIvRA==
Received: from MW4PR03CA0196.namprd03.prod.outlook.com (2603:10b6:303:b8::21)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 07:31:59 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::83) by MW4PR03CA0196.outlook.office365.com
 (2603:10b6:303:b8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 07:31:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.23 via Frontend Transport; Fri, 28 Apr 2023 07:31:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 28 Apr 2023
 00:31:45 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 28 Apr
 2023 00:31:45 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hare@suse.de>, <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 2/4] nvme-core: fix memory leak in dhchap_ctrl_secret
Date: Fri, 28 Apr 2023 00:31:13 -0700
Message-ID: <20230428073115.22987-3-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 6480ab51-89ce-4205-a5a5-08db47baa6fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	5JIE9l8MDUCHUVjkQaBo0nPvgKmKbPk1d8T2CYs3YAcRAnSzVL7I/R8Cx9F7+Q/wKFIuABXgn2aYfvXSdoMIUrQviu9VdHdq8DlcnKGlMaz0Pfe944l9pG+VQV3hDQHMRkfM2Id+GLTMWBKFPlH/oClKBZ/3pKrzzTY7pTmkQBtFOzKyOPFOffhkm1BWdv6Rhbs21Zn4fmk0Zb2aI/DB3Jfun/6nxfj3eUc7Cqt0DDJ5hagmTCATUuwOfkUWDOSAvy/vUVEkAwrG/jADFOPOzzcs60G2oTg1M2YyIekakEJ/ckqjMLMUaLPhv8az61GAu/GpSCNlp70RZw7IO8eEMGlGUGRXoUq5LJ5x0VYXcQC8p+1nbSWAl8XFUtv6zEac/4qocxsVGuPGMPVYZVQvwo+HY3srBJkA56Qvv2BzRgXxijGRydzQst+OglKn/B3jGrUYqk+ax4lwqCAqzsuMzNhW+N27aS9QeaJVF5w2ptEPF+Bktpfq0ke/9+PVVL+CjPf3s+G9y895Hg2FHgXL/rxsgyj5UsZklPW4LcZqTLKFpspudpDaPFNw2DbktB2hwugm6BsnlaKsI2J1K+2Sjkq1wrN70XcWRfSR+GfB4YVcpJ0FqEW2DOdmf4rUkZgXnmTH55PBwjLhchGoVDJH/SWfh/Kv+SRRVNvERcqu2LZAh17bd7mOv3K957Ksb4n+8cbdDVat3Qgm7ZnO/ceh4uHyqs08wwNeuqW78pcnPyUVB03tlqGfSMHooS9nG1HjU6bqUQ5XweLwfG3hnNitXA==
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(70206006)(2906002)(70586007)(336012)(2616005)(8676002)(5660300002)(8936002)(40460700003)(36756003)(316002)(6916009)(4326008)(41300700001)(54906003)(478600001)(40480700001)(6666004)(7696005)(1076003)(26005)(356005)(7636003)(82740400003)(47076005)(36860700001)(426003)(107886003)(16526019)(82310400005)(34020700004)(186003)(83380400001)(219293001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 07:31:59.2559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6480ab51-89ce-4205-a5a5-08db47baa6fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230428_003203_771755_D0823433 
X-CRM114-Status: UNSURE (   9.64  )
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

Free dhchap_secret in nvme_ctrl_dhchap_ctrl_secret_store() before we
return when nvme_auth_generate_key() returns error.

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c7793991faeb..42e90d00fc40 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3882,8 +3882,10 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		int ret;
 
 		ret = nvme_auth_generate_key(dhchap_secret, &key);
-		if (ret)
+		if (ret) {
+			kfree(dhchap_secret);
 			return ret;
+		}
 		kfree(opts->dhchap_ctrl_secret);
 		opts->dhchap_ctrl_secret = dhchap_secret;
 		ctrl_key = ctrl->ctrl_key;
@@ -3891,7 +3893,8 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		ctrl->ctrl_key = key;
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		nvme_auth_free_key(ctrl_key);
-	}
+	} else
+		kfree(dhchap_secret);
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-- 
2.40.0


