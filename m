Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEEBC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 03:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pKUtCSJJXY5q/p/V6iFeAWW2ANvaYcqG1REStGEXNVI=; b=XFZnwdgQNphM6EJANmh5qcodSu
	eSC+Tizl+nJVoaQFHTycDJehYN0+wFgobrFP8GQw92USnGmWdgJL4x45fWOdxy/wZf8D6r5rRUnT7
	OTDqYdmXlJeY+SkPGN3Hx8nUI958iudZ2ijaB4HACaNaaVWqVReqYqk5L8JRjMZ0hI0T8weX+BVxa
	7mTT1jDkfTFOnHS19SC8MZt1xCWtyN/UgN9wZRVOGYc2/FAH69snlJHbIww3cnmZfheDVITZXNbe9
	fW7wvSYwCNi3h2Nv8ryM9v/+UPpWrwhPUdzi5cjhkPDL0yp01mAbd/MzNVbYVxGjMFYiHAahxQQaW
	f4U3YaEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndkVA-006PVG-B0; Mon, 11 Apr 2022 03:14:04 +0000
Received: from mail-dm6nam12on2060a.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::60a]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndkUi-006PIM-Vn
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 03:13:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfPZpf0oA/P0HkSlAMj/K02fCqEytAZHT98bxvgJ49FkcFXqD6IKcC1JJKPbyCeBSuTIXvxScBQhybojx+E/Uq2Dw9lby/kmcmkWX1B9UlXWLE61xJP6OEMS+33/KwIDSarzHAUq7QdnlPuQPetYuE3cLPIHTnmP+z6u0XeH/EU6tCKe3y3XzG4KYlOJuPPDvhqftvXBVTMncCPBb/cF+978othBEpxiSq+qhsNYaFnYzZISuegNubaNl79u14naQEvkm4dzIrMEz38PITyqT7dpzGDuAugkmb7KJKqx++ynnJ1u7U+Brm81g7pZvKis4ztjNFEu0aahs49fuBDaVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKUtCSJJXY5q/p/V6iFeAWW2ANvaYcqG1REStGEXNVI=;
 b=TVlqLfWU8YXsjXTFlfm8M8TTdP5bTr5uI8jMKHjRxO0JEeFZQLd6pcCrNCBxPKrEtWe1BOFinY3veX3goGEmCbGv6fSmZJEtmqrPpilNNjUHFnJeVspeyp0KCClP0sdBR2wQ7lOODOzHsulTHdnhrMi8kbqjEpYy2R+2hnzlM9eAzRoLuh8OKMYWaIitv3BHUe8W0caDYl1cBNUE0xmm0Kh6Jxeb5A2/53S2PBPIs/fInl6WmkuRKIw3rrdF96kzAaRUi3gqtQ6F4ap5MgotTYWDLqRlkG5jB7IzBh2sRN2JRRhLe3XETrgTf2ioX95XK6l2iC4RTbrGHVKJgEBdTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKUtCSJJXY5q/p/V6iFeAWW2ANvaYcqG1REStGEXNVI=;
 b=rggrgpRzi+qipWhk/6n1LDtZnhsvCRw+8JwoP6KwMGm36EvT/T/FFDsYRDz7OgWyGhUpB6bAXBjQdEdsSK8h9ZcD3nSV5DRtpi5inzIPfezs1uu9RapDQEGZSbEI+p7Y57WXKALiqzzYmshHzf/mJBrY8Vv18y+/4JgJsq/JB2gH+OFvgNpB9SdRPK0nCLwvGmG8HBKty1cBWZe8KZLNKWdf5+cmPiUww5hGKjC3HwQ4XlCJLyFJh9VUbIuXtrUKoKcnRERts3WT9I6+kJYCF6MxTfhnlgKONoQunCRWGZIvu6nV25jxnWLYuPNzpHno4ynhFOPpyRg74i5J1lzXBw==
Received: from MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::18)
 by MN2PR12MB3727.namprd12.prod.outlook.com (2603:10b6:208:15a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 03:13:32 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::79) by MW4P222CA0013.outlook.office365.com
 (2603:10b6:303:114::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.27 via Frontend
 Transport; Mon, 11 Apr 2022 03:13:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 03:13:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Mon, 11 Apr 2022 03:13:31 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 10 Apr
 2022 20:13:30 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH 3/3] nvme-core: mark internal passthru req REQ_QUIET
Date: Sun, 10 Apr 2022 20:12:49 -0700
Message-ID: <20220411031249.5158-4-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220411031249.5158-1-kch@nvidia.com>
References: <20220411031249.5158-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f1562f3-b496-4ab3-e48d-08da1b694241
X-MS-TrafficTypeDiagnostic: MN2PR12MB3727:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB37270F2063AC5D349D3E1210A3EA9@MN2PR12MB3727.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A0MgWLdchmGW+is2m8LM/kKQxhe8c1Qryl2hG2zYLSe3IFWEW4hmwpS9AW+h4n3cKDpP43KMIki9tq6/B4/bhi9hkoCG32uSsCtebzFCVsrMFcarR6dILp1cZ8V3dm3aQl1Ka5rQpv+P34MrFYCu8Kut2VGun3Jn7S7L2IMAVlGncXOI+ZSN8x9tvxbbCtPZxGssWXemdeK4oUb3sBjIekFHnO/l0ZGTD/jVaB73yBQv4G89wj/vgwsIUqwrdBnXbmdAXIi+4RDaMdD+6OiM1GwsFT9RblvVwG50UqEblAsrxJnDcWo9w3layQZAPC23ILBmpGGD040jakOjtjRLluB342FfEQIa5tGeV9tPzrZpQWgQUgHG+KV3/yL87au+zuqjuwRgWcuGG0nA8PcIJ8QUtkzahEh4tbpP+DYJKi9/gmJKXFsTU7Oqy9J1Uo6jzrMmRwvr1NsdCXW0MinkITmEhBTHSvX9FtHsOiKOlUrwpkwZSaYRfjjfRo4V73pSDKADI9B52KLVNd0Bk5j7zW3rhfx4i0Z2clWozZn7K4n5b7wBYpMJFkf56+JrCkUqdTBRpkDZIm1a2hlQhClof6dOLHW/M2v9E6D+cLiJJ8ETJ+LS1or34IzDMx1Mmp27dfVT3D/eJ7Gxvs6HufYgQXnwsRyhcbfUQMY+k3ib7TqFCw+2SdT2wrceEuekNwKd7e09ylgEuHr/Uda6dg9Muw==
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6666004)(81166007)(83380400001)(82310400005)(2906002)(36756003)(2616005)(8936002)(54906003)(6916009)(356005)(508600001)(36860700001)(336012)(47076005)(426003)(7696005)(16526019)(186003)(1076003)(26005)(107886003)(40460700003)(316002)(5660300002)(70206006)(4326008)(70586007)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 03:13:32.2383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1562f3-b496-4ab3-e48d-08da1b694241
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3727
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220410_201337_101212_CAFC825E 
X-CRM114-Status: UNSURE (   8.75  )
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

Mark internal passthru requests quiet in the submission path with
RQF_QUIET flag added in the __nvme_submit_sync_cmd(). In the completion
path, if nvme request is resulted in the error and request is marked
RQF_QUIET then don't log the error with nvme_error_log().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 449378a96a9f..12302be83a6c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -370,7 +370,7 @@ static inline void nvme_end_req(struct request *req)
 {
 	blk_status_t status = nvme_error_status(nvme_req(req)->status);
 
-	if (unlikely(nvme_req(req)->status != NVME_SC_SUCCESS))
+	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET)))
 		nvme_log_error(req);
 	nvme_end_req_zoned(req);
 	nvme_trace_bio_complete(req);
@@ -1100,6 +1100,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 			goto out;
 	}
 
+	req->rq_flags |= RQF_QUIET;
 	ret = nvme_execute_rq(req, at_head);
 	if (result && ret >= 0)
 		*result = nvme_req(req)->result;
-- 
2.29.0


