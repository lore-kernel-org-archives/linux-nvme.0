Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7FBC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Feb 2022 04:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eJxo3g1K+sijJLVu9MH6fwbekHq+u5oFvD0l166GG3s=; b=QrtnrQlvHy00Z1jIhdoWA1xg8r
	NhzbxwuBYmeX+5C9Yna0oUB4KzETeYuPn602jmpfQVJqHSVK5NLDXU0ffmgxYz7TQeUF2/wWd2a9J
	82QioSklumiAo6aBfykupHRJwI6umir1YdLakk1taMzBrAjJxYeSVPSS0EtE8WlmOw/fykEuYIfBv
	8eLyxAEBAO4ADq9UtN8mzHxayncXLIZ1Si+ZUO2I5D/C9KBr5uaUL7wg39XZepW5IIKsenN5ZSV9l
	md/SUYdc1LST/PU/WTIlzivI7q/4C0hd6SCcRg5h/fyMdUdto/pRjCqzP6E4k0kLOOsvuYZ9/BeKB
	0qJD7Kmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMiov-00Cgu3-3C; Wed, 23 Feb 2022 04:00:05 +0000
Received: from mail-dm6nam11on2060f.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::60f]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMiiY-00Ce9J-RN
 for linux-nvme@lists.infradead.org; Wed, 23 Feb 2022 03:53:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C238M86ZZG35zpf88wU+dDXJF8xLehCWkCETwonM9I/gSB4nHWF0HFKmWRYvbdzg7crXh+NiXA5FdTlf/3Uunikl1zibfiyUO/mYbHX1fGoyqnOd2raPjmtXm62tw8xR0FsVriycCR5A2aXh3gAt4xDrOhyOhJejkLVKCuArCep4iM082phzwa9I1Giuciw4W7SqWPl2GSjYFTe9f9SN4dvqMRv3fHOZ5vD5mDIWSZNJPdKDuqW0QqIhEcghKBdTQPxddbEYb+w6SC8UU+vSbmeaDh47p6v9BsL1UxzLHNrux59Q1zfj77cZBX9VSwckfg7+UpuVlasI9jcqG4S3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJxo3g1K+sijJLVu9MH6fwbekHq+u5oFvD0l166GG3s=;
 b=f3fp0QM3CvS7b+GREb9wClOAnsblzMf4rAYR3w/eTnCEAREvDtg1BKGx8Bxz9fI7CCJcxLlPg3kbZwiHUZYchF6p5dgamlo28AjgWUZYq0csu7TMDw4MhYXSGZztRTHGVrvSpwjhAAAJRpnoOsZW6qAlec0ZagId0AeRUcEMQrEYHV4ckpCeZ6ltcbpxaXJr/jDy1JV37UQPfDM8+QFCnTk99t5RMVRi5oXiiB6Z302Wc2/CSqz/ltLZsmwL+D7iGK+qRoY8mUQsiBj41op+hnzW0ixLf5h/KtKZ3io3mSg0OnNkZIerLRoU4eUhRbOPve/deNAF3ws8Ls25Qpq8ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJxo3g1K+sijJLVu9MH6fwbekHq+u5oFvD0l166GG3s=;
 b=ZN3iMZ0wT3uAET+RnNkoFv6LeVc4sZl5wxPFtzQjUw6q8BfHHULobPwgyuHFU08gvCzzPoK81BAEPVTf6MfQePt9y1BHYc5nBjjuUJxSp6Bl+r/I8ZAYUhq9gVcOUc7k9k8AesUn4g6Nh+/zrdK1PGVSVhuiBAIf1J26NlDMrSyfQeZMrSTmL6X0PSkRM3XMAPHMuERRyHnlk41eoC3af2+5UzYtFhYfk8zKOkCaDh9pFKKj9+XtLEmXuxxjAbl0B0qiEzYUy6Y9ZQPEQaxV9ahH4Q4FAFA/55By8S+EZihIDUv2WBkF/ib8hwdm5a5TTgvG+ZGVQ6Buk+F848mkTg==
Received: from MWHPR13CA0043.namprd13.prod.outlook.com (2603:10b6:300:95::29)
 by DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Wed, 23 Feb
 2022 03:37:28 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::9d) by MWHPR13CA0043.outlook.office365.com
 (2603:10b6:300:95::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.9 via Frontend
 Transport; Wed, 23 Feb 2022 03:37:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 03:37:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 23 Feb 2022 03:37:26 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 22 Feb 2022
 19:37:25 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH 2/2] nvme-tcp: don't fold the line
Date: Tue, 22 Feb 2022 19:36:57 -0800
Message-ID: <20220223033657.208747-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220223033657.208747-1-kch@nvidia.com>
References: <20220223033657.208747-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e632db94-e508-4de2-aeeb-08d9f67dd025
X-MS-TrafficTypeDiagnostic: DS7PR12MB5816:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5816CE001AAED9CDB1ABB0B5A33C9@DS7PR12MB5816.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7GS6WK2vXzByMw5Hasb09ldK6yeyRngO4l68qTJ/IxgdDGKFzZh+JTfsr7xbAaVfT4DZA6QWFzNu2vhlBxlPG5VQdpttJoqVZkJLPOEKc9vNtWj+aJwpHCTlfUhzIh5RCMNkUbuB0WZkEACsRVLceWL7DA/jgsyBOAzd9wNGbmsVUK/JT2yVGE5IlWtIXdqSMDDDtvW6fq/7g7pCNe7hwipDweogaLhY5s88g+D7fAOFk3rYYpy50bIaepNGMugzXHJILTzF1f0u20JudPKDPviAMlFMVaPMAGVUTzWUurD3dylk28OFxIkzLuxKVdFPvRM/MOhuwW4WRie78PBIeSCv0qUD7w6uS0UOGYT9nnFk+VwR+5KXVvFekjdBXtx79RAyH/RLcgANCVsuiGuG9A4D6zvyiCOHI5JIjb6kBi8lUA5pG5urfXi3kJQOJUKX1B1xorWdOROsYVXtksofGOqbudBIGt5LndZIDVayvF8ZMDVMgv4aczhXSC9HdfxaoJgKaQ6DciMknv/P8+sBheBiGFij+ZRlT/Hc+rOUFgiLifIQ8TK6miVPWtF4g6W+fZ8Yo6MjUGy43Tbe5jDWxFpph0ldWsbLUfAcnU7rI9rqnnJ0tmVtz04P7wI711t7uo8tph9pzeXAl4c6XXsb8LhtxIC0E2ijq3CuzXFeF0/iUF0/Nua7egFSVhX6wjoy2ky9xl3lHsOvZAwEL/y4Q==
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(316002)(70586007)(8676002)(83380400001)(82310400004)(47076005)(40460700003)(4326008)(54906003)(6916009)(70206006)(36756003)(508600001)(356005)(81166007)(8936002)(2906002)(4744005)(7696005)(6666004)(107886003)(1076003)(186003)(16526019)(2616005)(5660300002)(426003)(26005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 03:37:27.2017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e632db94-e508-4de2-aeeb-08d9f67dd025
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_195330_918139_119C6770 
X-CRM114-Status: UNSURE (   9.60  )
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

The call to nvme_tcp_alloc_queue() fits perfectly in one line without
exceeding 80 char limit for the line.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/tcp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bb03ae5ef11f..babbc14a4b76 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1714,8 +1714,7 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 	int i, ret;
 
 	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = nvme_tcp_alloc_queue(ctrl, i,
-				ctrl->sqsize + 1);
+		ret = nvme_tcp_alloc_queue(ctrl, i, ctrl->sqsize + 1);
 		if (ret)
 			goto out_free_queues;
 	}
-- 
2.29.0


