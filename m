Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC41C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jun 2022 01:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ufrMB5Rh8696dDOzzwJmImhlQQPDaDKsCFaswoKLRj0=; b=aUTW1vcOBhPkbS1uG1mYjRKpAK
	GYWKQihklpgye28HBFxImn5C4T7G/goXZ4QzhN8+pqfat6vg/6C88gLIjqd46aD2duP+EJcLz5aDh
	X8Oo8ysuaP5vjb4/PlOe4/0ujhGzpI0MzOw7aGDRL+buZkoPxIVB2YruSFKAcvkeFgFJk/MWVV+2L
	4Fbc331Qj/IolCGcYKJb2R/8OEvKPW/BMjjrL+eVLbzGBB4G01NvbN8Vwqz/LHca16LNaUkVW1KV/
	EcC64mqH8j/fg9zT5bkrDnxxOZCYtNKAId9Y5eUVQqxmayV/1sMMWQ11rlPxe1OgoNZhSpLEIT+9Z
	Dk97z9yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwZuk-0011v3-Hx; Thu, 02 Jun 2022 01:46:18 +0000
Received: from mail-dm6nam12on20626.outbound.protection.outlook.com ([2a01:111:f400:fe59::626] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwZuh-0011uM-CQ
	for linux-nvme@lists.infradead.org; Thu, 02 Jun 2022 01:46:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxdaqftUpnONUAabcn6Bja8ci9GNqd0oJf04fvRPd2xhImt/S3w9R3ZhtBC4lZsTHJM/LMzGrO3tH0hVcUU1sKFOVxW9H/0ZTvX6O4xDUJsyKyYUlPtFl6CIsdkZ9D0QtuAUc37AVqdJz/d4fxkEWBtLKkD4l5qfgJlTD7WSJVp4Muh/eNEPxzjVMdUBXO6C3VipTJZYKpGpvHzS5t9i1IzHN5isVW0H5MW3amPkRHTLvVHQyFOe5XFgEL8+QZeHRPZNCVIawnH5/OLshmlH4m1QXzJkUW0cGjWf2lHbVYxIWW2a2nVFd3y3K/BY00vx4Lqmn2DOSR9KXvIvl0X12Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufrMB5Rh8696dDOzzwJmImhlQQPDaDKsCFaswoKLRj0=;
 b=Ca7D/2xJlV91StjpWyE0WWIh8JszgiDiiOW1kXLKsYLw8URLtTf33NJCaX7PbMg3sqQmX4VovS3iwrkSlmFULMy3gX2RTg36fODeVqCAFUzho9VkoOyeBv5s9NBKGykTP9BZiLbOhMCf9HkuMjbRudqLPXlZ+soc9u2+ND89bsfu680Y1LJrpB7iyLC7svbIkZ4dRIS04bOgbcqPNwKMmP0Q0d2/Ykst5/UibnJLKjqFJnWuP4B7JHWA4UsjUWjay30oy17tAaHk/gqhDGdQvAQb7v2Joq+AOPqD027SIo4gkEYtsbilvfDRAFwOuOT1xRF0b7wrMrRdW9VdBwz7GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufrMB5Rh8696dDOzzwJmImhlQQPDaDKsCFaswoKLRj0=;
 b=WM6roIGAkdBiqQUpgCZ31C87bj5lsAYFBek+hapnLWcaXtNX+DpAcnGwl1nSn3v/5CBWNnjRuHqJ8vUHJFLM/X2vOH65Zw/I/3AmD28N+HlqAaY6YRzIwZjH+XksnYXeR4kfKU+JlWo77dpqkx1T66UMNlana0CEjB91FGJcWc0cFnzBL2f4jnROlhh1ISy1SQsa5Vzt6OolbVUcUtQGh2M0T4tjbmpC23W3absnZIBW6AEFyI/RuhPoRxZRjNwYkV4IYp7VR9z2Okq/hAU+X9W19wBdnXmkzCwK/1+yXKbRKFGuEnDNkAfq1x+D6gAxKLiL1I5zrfGoq/+mf/xzOg==
Received: from BN9P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::8)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 01:46:11 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::ed) by BN9P220CA0003.outlook.office365.com
 (2603:10b6:408:13e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 2 Jun 2022 01:46:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 01:46:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 2 Jun
 2022 01:45:12 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 1 Jun 2022
 18:45:11 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvme-core: fix oops in dhchap_ctrl_secret_show()
Date: Wed, 1 Jun 2022 18:45:04 -0700
Message-ID: <20220602014504.7873-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4707361-cf4e-460d-8175-08da4439ab6d
X-MS-TrafficTypeDiagnostic: SA0PR12MB4495:EE_
X-Microsoft-Antispam-PRVS: 	<SA0PR12MB44958AADC1AAAB3BDB34510CA3DE9@SA0PR12MB4495.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	PLsArYJDOYOesJOrTe1RkeZikDgZ9LIOHo6xgTg0S2epS0O9hL6P4z7X7X7s1FSQs9JjDteVBMWhX3C//7AKtm9jUoZw7bPRvQ30te6Fdq2sxU3GKH0q5GWToHulFyP5jmZGqVBdd9FhEdvev9uZJFmFYYzOkUehGrgmZKcYPTmGFm5qVQ0kHZKIcmIgsOy+5tfktldNmhaIy4OY7CvWcnxb+6fSu/LzOP1yQMMmGmGAEyTnd8GEwBssLewpwcCuMqxvcxHCJ33b7rJ0vpnLwQyQIY+MF8YUWdYdboN7IQ6CyjtdGXqZMofICbsbvHh3QkWh1W+kYE6t3UCprQ1zdfLCird7HeIRDGnVsCr6Sa9pOQGFl01s8XKFz5ENuDCnOHKzHRud3ezQVdMez396wBiMFHGLzJ2/ECQbc0jRVOYdpzgHLAwbfhH+Hw9PXN9n5NWnw83wwnyx3tzERZD/mQxaV9VQKtTJf09/uVAEj1FcAWRSRJBtfgW/cuuX/4dXZfsYITHwdPq/wtsvTIzJynk9NaNAlTE4EwOKizzXYurov0ZftdaDWA66DtnzK3477mIpNqt7hE2l8lH1kVSAGAqbK7WpcrLHrIC6RZgU+7Ci2eDN0zgrlGsFzku5l7ECrs5tummhJT6d/zuM84dMiChNfrenF+QE6T3/maQSk/J5sfsh+5oo8FJXImcKl7iosKY9A8JO25TCWoyjR4rIYJ30O++6PkTYJ6G2v2SPQiidgk8iXwVOUi9YwzoyJpSf
X-Forefront-Antispam-Report: 	CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(107886003)(4326008)(8676002)(356005)(2616005)(81166007)(70206006)(26005)(70586007)(186003)(16526019)(6916009)(5660300002)(7696005)(316002)(36756003)(8936002)(426003)(336012)(6666004)(54906003)(47076005)(83380400001)(36860700001)(40460700003)(1076003)(82310400005)(2906002)(508600001)(219293001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 01:46:10.4376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4707361-cf4e-460d-8175-08da4439ab6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220601_184615_464377_8F9A8026 
X-CRM114-Status: GOOD (  13.01  )
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

In current implementation when we try to disconnect the subsystem
that doesn't exists nvme_ctrl_dhchap_ctrl_secrete_show() ends up in
OOPS:-

RIP: 0010:nvme_ctrl_dhchap_ctrl_secret_show+0x16/0x40 [nvme_core]
Code: c6 78 a1 16 c0 e8 5a ad 2d c1 48 98 c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 49 89 f8 48 89 d7 49 8b 40 78 48 8b 80 98 0b 00 00 <48> 8b 50 68 48 85 d2 74 0f 48 c7 c6 46 a0 16 c0 e8 25 ad 2d c1 48
RSP: 0018:ffffc90000f3fdb8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffffc01731e0 RCX: 0000000000000000
RDX: ffff888104b44000 RSI: ffffffffc01731e0 RDI: ffff888104b44000
RBP: ffffffff822f7380 R08: ffff88810274a2b8 R09: ffff8881782fbdb8
R10: 0000000000020000 R11: 0000000000000000 R12: ffffc90000f3fe80
R13: ffffc90000f3fe58 R14: ffff88817f0944d8 R15: 0000000000000001
 ? nvme_subsys_show_type+0x50/0x50 [nvme_core]
 dev_attr_show+0x19/0x40
 sysfs_kf_seq_show+0xa8/0xe0
 seq_read_iter+0x11c/0x4b0
 new_sync_read+0x106/0x180
 vfs_read+0x138/0x190
 ksys_read+0x5f/0xe0
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fdeccbdf702
Code: c0 e9 b2 fe ff ff 50 48 8d 3d ca 2a 0a 00 e8 b5 e8 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
RSP: 002b:00007ffe0dfb4f28 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00000000017df780 RCX: 00007fdeccbdf702
RDX: 0000000000000fff RSI: 00007ffe0dfb4f30 RDI: 0000000000000003
RBP: 00007ffe0dfb4f30 R08: 00000000017df9f0 R09: 00007fdecccb1a60
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00000000017e75a3 R14: 00000000017df760 R15: 00000000017e75a3

Add guard to make sure opts is not NULL in the
nvme_ctrl_dhchap_ctrl_secret_show() to avoid the OOPs.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5bdeb7134ede..3df8e6bef589 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3671,9 +3671,12 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 	struct nvmf_ctrl_options *opts = ctrl->opts;
 
-	if (!opts->dhchap_ctrl_secret)
-		return sysfs_emit(buf, "none\n");
-	return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
+	if (opts) {
+		if (!opts->dhchap_ctrl_secret)
+			return sysfs_emit(buf, "none\n");
+		return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
+	}
+	return 0;
 }
 
 static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
-- 
2.29.0


