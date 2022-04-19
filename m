Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6796C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Apr 2022 22:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZFhjC5O4igZzBExqDnhMu1RWwvD7OOK4qSD5FDhHsaw=; b=ne5tUBm6licefheCdYfE08POU+
	qMwfnP0lDuHw9ViFRyzlu1ncYGtGHSO49yFZGG2KlXFoNsCBpIAwH6RJ+DpY80Ezd9tJeCAxJqFXe
	VtXERorNjSUTAemhC2vmchd1UYrfLIBvGg1Ph+Mw/FKYwN942xtHT4T8rikAkssqZ7SA8KiMU8L3Y
	NBQtcBNn6XQiMcsc26h9Ilw+JHXRjjvECAMx9Lx8U1i7VNiMCIBliSpZpIxng7nyZ6QXtR27wJkh2
	l6E50WUxvqxRTlrMrxkWJY0n+FYJRpY+gvDmtoZJOMNqngABSnWYy5hiKhZ28yvB73ecaobdADAG1
	SCD/gIwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngwjX-006aDy-LS; Tue, 19 Apr 2022 22:54:07 +0000
Received: from mail-mw2nam10on20627.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::627]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngwjV-006aCs-8U
 for linux-nvme@lists.infradead.org; Tue, 19 Apr 2022 22:54:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5Kp5/ZGlwRqlIPlCdzowJcsuPih6YpG2so6tMFCtrWAmOOl+HuSzdPQSKimknm++LTnUWIAp+/ELlC6zZ0QPwFRCTT59gmq2LB6W4PEm0ElNV5CelI06IqrOrzfLYBkS9rPs3Yzi7/BYgWZMejHjiolOvC0sCv6wIgRp0dJArLMCrgiXd9NFqNQnsKvj/lEAg+wkGY0Cb7FHsJpqy8MeBOGmOu/6B68Vp+YrWeubqlKj7ZWTqUg7NTwJmp5K/1Rx/QC30BAsdGmSU/JuY0My9wkGkNz95Hcy9Te0rLFlwYwQoqbHIYvR+6Jr0G48EtAC7/hr3o3Dbx7JoVX/vdNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFhjC5O4igZzBExqDnhMu1RWwvD7OOK4qSD5FDhHsaw=;
 b=N2TGJMvrh2tR5RRS1Pu4jlIU8pdXsuycFvoRbexnvCvUM8FXmACANuTWGxgPfI1XKWMcYHgBdVLMlf0hybW9R33s0pCYbBygBaspVkjrgVF7YZBq22hYG3nsWc1Ib4BBkduRAezkjx/0+t36iW4BE/EUkBgeCK/eBhQ8Whil8LhRPWZblCnS1Krgd7FJRIi9TstDNR0UJfYI/OwBN4u8uFJ3IadQBvwjr8UlTqBOtKMGYbvQjew7FL7zrhBlQtvvLGLckae9WJDLc9mEMi0DtB2K89wlZyxDzbQ0pXcNsLjYak62rfRNTj8F3OuCLEmNBTUsjdrxRe81YnKADk/hqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFhjC5O4igZzBExqDnhMu1RWwvD7OOK4qSD5FDhHsaw=;
 b=mFIA/2gvwP/bTxkNwgiPSCmSK0v7IHaRLUyiU/WSqpoE9KWnihG9Ob8LK/DA8lADn2fHBxYRXImTYIatd/8h82Z2wFpX0sulXuhkc59hC2uiuzT2JG6Ev3qE1mjfJR3yAZuG578mAelYtTvaq7Ycl9tgGyAVBG8oyHWboPgDLRNOMN1TEGiCaNMD6HMERIyvG8fPniR9ISjzEzD+40OmYmEvGKiUw/3EotRb1DyEOHSEnZjOLeQPn7AQqJBU3jizSP6I7fJypqxCB8pnGM3q1srZPuDoEE8g//EtKOYSYe7I5E1uuuHrU5IEzw0IL3kqYS59I6Rgz0n6pKA+2/p2OA==
Received: from BN9P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::8)
 by BY5PR12MB3857.namprd12.prod.outlook.com (2603:10b6:a03:196::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 22:54:00 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::4f) by BN9P220CA0003.outlook.office365.com
 (2603:10b6:408:13e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Tue, 19 Apr 2022 22:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Tue, 19 Apr 2022 22:54:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Tue, 19 Apr 2022 22:53:59 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Apr
 2022 15:53:58 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <sagi@grimberg.me>, <hch@lst.de>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH] nvme: mark internal passthru request RQF_QUIET
Date: Tue, 19 Apr 2022 15:53:51 -0700
Message-ID: <20220419225351.29762-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d123208-0b2e-4d86-288b-08da22577e7c
X-MS-TrafficTypeDiagnostic: BY5PR12MB3857:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB38575EAF642C513A498E9FBEA3F29@BY5PR12MB3857.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sBLx/eo4RuDjrrvGHyy6XOqKRG/vOHSRn9KiLoOYGg8jQJIxozjOsPVY0rftO3jQ/tn8zz8HAsGNfC56XD0gNd6F1jF0Nzf5tuvWyguizeCiw5ercgSY5sWXf/KrizHmrMJz9L1MtL13cqgTQsXWI9c+6nlSMoMeby8iy+HJviGd52YaknIn4ppBKACQ6wwmleictFHHC9+p1rzMbmtR2c5fgGJE2yBPdX1M4eRZaKIFzzM5dP95V6v4dOBRupK1qLspXELdwdhpxKrnlzqaF2tItKeKycwpve1mHkbIr2S8M4S2q5bIQT059xRUEmYkQ0QLIeVpG2jin+Ql2QBxwIlucSS0PboVbSdfKbyDbOeF78fKE1H71CMiaqZcf/Ywrn6OxcwwNuJw1UKWO35OAAkzi6zNWmI3Ab7NComsDJLztSlRczWepao42aYlu2QpuxxH/UGmpQgDv3T7K6GAuj/I0EkLc7CU9lNKljTeWroZkFKgOb5FQXyPqE+P+GkhXV4Uc5oKIsgK/kB7mBiQ74na4tW62m/1ZWYjJMjy+DQ87+CVDvl+lBlHBh+yjICmicXGnK9R821i69ojlchZqf0GR8wceDMGrKEMA+HbwMtKRRFQQj6/bTD2502Kw4vSqx7vi8uuQxUStkZztcERoBJrW6c6H7FNBXT7JGlS9WsJ6iHH1tj0bCK93urRPfJhhkBHhHmdLFE9yFuaZQdzWw==
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(186003)(70206006)(8676002)(70586007)(81166007)(4326008)(6666004)(36756003)(82310400005)(36860700001)(316002)(8936002)(40460700003)(356005)(26005)(5660300002)(1076003)(2616005)(6916009)(508600001)(107886003)(83380400001)(47076005)(16526019)(7696005)(426003)(336012)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 22:54:00.4193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d123208-0b2e-4d86-288b-08da22577e7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3857
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220419_155405_344339_E330F66F 
X-CRM114-Status: UNSURE (   7.62  )
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

Most of the internal passthru commands use __nvme_submit_sync_cmd()
interface. There are few places we open code the request submission :-

1. nvme_keep_alive_work(struct work_struct *work)
2. nvme_timeout(struct request *req, bool reserved)
3. nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)

Mark the internal passthru request quiet so that we can skip the verbose
error message from nvme_log_error() in nvme_end_req() completion path,
this will be consistent with what we have in __nvme_submit_sync_cmd().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 1 +
 drivers/nvme/host/pci.c  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e1846d04817f..c6809045aec3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1207,6 +1207,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
 
 	rq->timeout = ctrl->kato * HZ;
 	rq->end_io_data = ctrl;
+	rq->rq_flags |= RQF_QUIET;
 	blk_execute_rq_nowait(rq, false, nvme_keep_alive_end_io);
 }
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3aacf1c0d5a5..f326261456ac 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1439,6 +1439,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	nvme_init_request(abort_req, &cmd);
 
 	abort_req->end_io_data = NULL;
+	abort_req->rq_flags |= RQF_QUIET;
 	blk_execute_rq_nowait(abort_req, false, abort_endio);
 
 	/*
@@ -2486,6 +2487,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	req->end_io_data = nvmeq;
 
 	init_completion(&nvmeq->delete_done);
+	req->rq_flags |= RQF_QUIET;
 	blk_execute_rq_nowait(req, false, opcode == nvme_admin_delete_cq ?
 			nvme_del_cq_end : nvme_del_queue_end);
 	return 0;
-- 
2.29.0


