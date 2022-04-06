Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3115FC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Apr 2022 16:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+GAakmhE4oPLxTyD1b9oiXt4GQKNHLAimFQj7GLguPQ=; b=sWNeJE19hysUTA1YsVNC9Rnty2
	YgD76OlYEMTB7Mo4h2BfxW13MIgrJ2mglEhJMt2rBZRTEL7ChgeOkaFyYyV+Zq1C/tH1r8VvfrEj5
	n3+2cxZEkF4laX2dp/JQSjmwkV///JnV6suk3sDMr9UTgW3cuunbrJ4oXT0S8PzY/Y5j2YQvwpc8E
	6QMhusvd9dk3oeRue4u4pl1AW85xOBWNqahyVbCNAQc344ZP1++8n9ig4zxXBVMDtN+y5G5ps8Gw9
	988aOmxTAfWjDd4U6nkblKnKMp84B8ID3PJvJmjmvCkzFrp0F4+NfQ2oIxhrGfSsL+vPbM5SPJ99W
	63xgZvFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nc8in-007EYJ-Tl; Wed, 06 Apr 2022 16:41:29 +0000
Received: from mail-bn1nam07on20627.outbound.protection.outlook.com
 ([2a01:111:f400:7eb2::627]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nc8ig-007EVb-RB
 for linux-nvme@lists.infradead.org; Wed, 06 Apr 2022 16:41:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXYDrAXEBPqJmG9y0LV25SoQPCy6QpxpOdr1KtSVgfsY7SIiw44DdYF8raEoyPaHgmkegA2NRVCvTX6IkqrrwFMCr+hFTgXb5D+uo0/nZu2PGLgWgQk7SFssPxZTb1ipaXZpyyhulG+h/qB9Fbk5IOBh3DdweIwY4VF6PwNbQ/0giUmndPIJ6KtuOQtMSoyx0WwcCngr0PnlW1iKekaLb4ZxZmbr/7ZeLv9kMug9Hrb5NOYiuGJ0RE9pS88wyIWs5Rw9HFbctLbFSh7RcbuuGAqvQedpRhjCzp4QrH0h9m/1r28mS+nCRvirXIPUWxBYaR5hSg2uZEGUTL3BTHNFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GAakmhE4oPLxTyD1b9oiXt4GQKNHLAimFQj7GLguPQ=;
 b=HZd3vyx6yNk7c6aVTJZvxsnGE1mgjNsYHxLlU6cvDTyG8EO6H7UaMpiqbg/31A5RQxRaqPt3G+IXAWlFGQIJdrq7QOGVxxB0sUK3pBD1oVXUBjk7qUtZN3n/TuudGHoncle+gQgE4OgLjjdqaVVSzlDEr7Yitt/84ImemnTUPAL0h+kce+3B2TlEHE2bM4miav3Lf7w8eVexcPkQAkBW2WXQHC2PDlarOuOyieAqlMTYVnadBy1OOiwztvpImc8VmdnsUpxfk1uHMmGc35GRjiu+NVKGpFZMzmRvZfP0rIk3OFm+JB9pKckz1ZxZBGGmXny+JGjw0CWLI8qeChOEWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GAakmhE4oPLxTyD1b9oiXt4GQKNHLAimFQj7GLguPQ=;
 b=blcxFu8bD3bKCVhKD2j32SQHeaHgfh+L6Hb+0Z3EigrcF92i9+fyLsYC4wJOaU4ib7tBYtjZDxmVsYlkCibqZ+PkJQu/z6GUv+VZ0xKD5vd9kHSgC+xPlkHjP088AD2/Zpw45t7Wrp4Lub6JN7Izuftk9n0NAHr5A4Gnby5qxhICgAjd7Zmqf1JahBV8wyzbS4XwMPIy/e+6kYBzmdYrHDU5OavcPRstpKE8MU0JraURqEkcEv2vluNDh7Na8WlosjnC/x0+shPBGtc1rI2UWSzLFyJlfKeLhSYYKMP2zqRNe2N3iE2/Ht2WyfjDsSy/elpa+9xk4vInBpMAXirkUw==
Received: from MW4P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::22)
 by CH2PR12MB4874.namprd12.prod.outlook.com (2603:10b6:610:64::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 16:41:18 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::70) by MW4P223CA0017.outlook.office365.com
 (2603:10b6:303:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.22 via Frontend
 Transport; Wed, 6 Apr 2022 16:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Wed, 6 Apr 2022 16:41:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Wed, 6 Apr 2022 16:41:17 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Apr 2022
 09:41:16 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <alan.adamson@oracle.com>, "Chaitanya
 Kulkarni" <kch@nvidia.com>
Subject: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Date: Wed, 6 Apr 2022 09:41:09 -0700
Message-ID: <20220406164109.30449-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12fb050d-da72-4086-ba20-08da17ec45e7
X-MS-TrafficTypeDiagnostic: CH2PR12MB4874:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB487491C8212534A0EA4C8DE6A3E79@CH2PR12MB4874.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZhJGuMFCF1pKDhD9oIMPrfw+gLFPycbtygb88Y6xDNwxdSYvOFvbmMYRZzhvhp4TLjl2VtaTkEc6Zs8W/w1gljGI8qxZQMM3x05N7H0FbqX+uQT7x+CE8jMmIRv2Rd6vLGtr8BJNyTEx24dy4YUgPz53GnNj9swxa9ex6UWZ9wx5F2SOJ8BZVxuYMhyfFjmUhbtHUVs+7OLNERThpipWHfJxaO88nWUXj2OIC2qK4EGyTm6KKnJUIrDuDoInKJ4ouFkiOWO93fqeq8haS7EHjCIPHoIm2olZaXfe904wYwu6JHniZd8uckIo2PiTVkNf4ISseDKYVZj4kuB8TqMsh1uSGHwsU7A5iWhvYo/JPOUzYJ6azHcTZOS4lEdxxaUUrAzCY2BTvRHhuYiwwzJdZTgbl9DvpSfUYIapMoU/4VolQfx7nl8lBniaTLU88DAo3bszTigiYTd0mRTnOFw/fXFrRPcRjt/15//onXVeKD3vOhp88DCuIWfHY+YWXPAEz7kJX3O9T8E02ZQkKNOmth9TabAA924e3oIFv0y1t6ubLUplwBs8VdQ+xC4pL/7vz9JrJt+kp2C6PGqjKujD5cf3nzIxgQScsjv6654fAAvxKiqbfQjQCQ7VSYy4l+lcY3W00GGy/1oypDbQXwC5vPFPSiUGfm/x/Z5A2lHuewWY8PlI0LZIx+ukOC3eZl20oYkNo8z2NcNzDx8FqPrkYw==
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(336012)(82310400005)(81166007)(356005)(426003)(40460700003)(4326008)(2906002)(6666004)(47076005)(7696005)(8676002)(508600001)(2616005)(26005)(54906003)(8936002)(5660300002)(186003)(70586007)(316002)(6916009)(16526019)(107886003)(1076003)(70206006)(83380400001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 16:41:17.7787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fb050d-da72-4086-ba20-08da17ec45e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4874
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_094122_924263_50B8D32B 
X-CRM114-Status: GOOD (  12.47  )
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

From: Christoph Hellwig <hch@lst.de>

Since addition of the nvme_log_error() we are getting error message
when running block tests framework due to internal passthru commands :-

[  612.754938] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  616.361730] run blktests nvme/012 at 2022-04-06 09:26:43
[  616.382902] loop0: detected capacity change from 0 to 2097152
[  616.392680] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  616.400913] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  616.401001] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR

[  627.427947] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  627.437084] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  627.437161] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR
[  627.438984] nvme nvme1: creating 48 I/O queues.
[  627.442620] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  628.506885] XFS (nvme1n1): Mounting V5 Filesystem
[  628.516895] XFS (nvme1n1): Ending clean mount
[  628.519966] xfs filesystem being mounted at /mnt/blktests supports timestamps until 2038 (0x7fffffff)
[  704.852721] XFS (nvme1n1): Unmounting Filesystem
[  704.864724] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"

This patch adds the passthru request with RQF_QUIET flag and ignores
the error reporting for nvme_log_error() if RQF_QUIET flag is set
when request is failed. With this patch we don't get the above error
message.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
[kch: make a formal patch & test with blktests]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f204c6f78b5b..b913a89c743e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -370,7 +370,8 @@ static inline void nvme_end_req(struct request *req)
 {
 	blk_status_t status = nvme_error_status(nvme_req(req)->status);
 
-	if (unlikely(nvme_req(req)->status != NVME_SC_SUCCESS))
+	if (unlikely(nvme_req(req)->status != NVME_SC_SUCCESS &&
+		    !(req->rq_flags & RQF_QUIET)))
 		nvme_log_error(req);
 	nvme_end_req_zoned(req);
 	nvme_trace_bio_complete(req);
@@ -651,6 +652,7 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
 	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
 
 	req->cmd_flags |= REQ_FAILFAST_DRIVER;
+	req->rq_flags |= RQF_QUIET;
 	if (req->mq_hctx->type == HCTX_TYPE_POLL)
 		req->cmd_flags |= REQ_POLLED;
 	nvme_clear_nvme_request(req);
-- 
2.29.0


