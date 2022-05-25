Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7011C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 25 May 2022 15:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nVwR7tUxwTLV3IQtTXR4CJDdy4kGu27/9DYIdadmkZw=; b=Y2sX2k1q/zRsq2taeJi0Bjzdp1
	CojGIeMmoGtmZzHPOI5sN0Lq6gvc2zdIGV939+n6QRvT7I4l7C8wrvt+hmmfvSk7XRldqEOgTPBH1
	guxqWjoqmjT4dLeglLnaJXZkMPMmLswurBNbtmcfdnYhhLMQPonXh2mM/fZ91tMGNNgRCKlYKfqBE
	VMxaB2IbEd4MF7hFpT49ulb69H0s/AzqDpF+WrrLfJNOpyyjaB1ryp2jTbaB9HfX1zvdkWZkb4Pkx
	nQ7E/1LVUf72Or51Une6vo8pF37XbXAdIUMAOxquWPRLmT3uXteU9cHKpzlk3MZHz83cMNSxpYJY/
	bRx+g+sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntsUO-00BUD3-Dl; Wed, 25 May 2022 14:59:56 +0000
Received: from mail-dm6nam12on20600.outbound.protection.outlook.com ([2a01:111:f400:fe59::600] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntsUJ-00BUCX-7j
	for linux-nvme@lists.infradead.org; Wed, 25 May 2022 14:59:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1mMyzxzeU/WOhnoh5cKGs8wv2Sw3TXM6Yzmv1smup9L24BlefPddYRq0hMlFQQSmJvJvyFHBvFmXM7nZIPjqoWRf6focBpiPT7zXdESMvde2ZWDbwFQ56gIwWsjSmO/uwrLSq3F/nhidEdj7rKUX8tNsm4oQF8iXW4ezuiSaGUPw4coc3KUST9WOCZg47PVWgTSDF8WhSvsTkKzAGvVpxCopUYqaW3EoC2mHtKjcorEDTmFK7fZOJ2zOCGypu6ouiIJbkaoJdnSaSl6FK9lPYIrZBeRRn84SiRsf7unB6llkNt7Q4OF3ojFnachmieTH3zlu2tJn5rcGH0VDPzlOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVwR7tUxwTLV3IQtTXR4CJDdy4kGu27/9DYIdadmkZw=;
 b=Wi/pZnTDt8FWAbzSbrdINgaTdS1obiAu2ljL2kWqoA50jT4vl9dkV9xsXYfaoyJsejnYP+AkMfOz2IkCcXDwQk82YMsTYqOg2fVm/Y8HhKPyPJ14LONLkRRl/BsZoqZy9p1RJzBcmL+GXkizkaY6bwguebSTk5UHJgJVkhnjHbkOYcPkv4KDbB1sunkVOSNnbKAzCXd1I+N6pBMHPVRVZ1lG/9mjqNGRo0Xm7idGG9zmq5bZEP0CWuk/W12bs9QUbwWV5YJQ9V4P3hELHRrZj+89mpMi+zvqM1hAi6+eeuiLOxvdApFWuGWECQdImZhodjSMj4oqAmetY/bF9BXf4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVwR7tUxwTLV3IQtTXR4CJDdy4kGu27/9DYIdadmkZw=;
 b=fFD0mGHR8aLbew7c1OVFCJEluiIqJ7zOgLqb6Jg7cW5YYVwaFPqOWTB72iIQvaE3dEqHbT1XgqYu2/bBBU6UVfA4fN+kbQlMgmQziPG41EoSBUiGT0DC2b9TlyYbDWIsoHz+hAHRbPJQuJr3J7xJCiPdQmlkrEV3kmilxhnOBXsHm7jBxiCAUomYe5CtLhy9n/BTwwbXmZ+wRAe24P3SIGR1pbg4juvMYs1EB1euh1atmfNxvy2ACmzvZeD6dTSo7jRMSARzOaO+K/wImZQfVX88mJjwTrD+xwGwKukxQltrG4tOe8sLoqN5bpSd4+HKaTqe5ZZhIQbzXq896ry1Rg==
Received: from DS7PR05CA0087.namprd05.prod.outlook.com (2603:10b6:8:56::9) by
 BY5PR12MB3825.namprd12.prod.outlook.com (2603:10b6:a03:1a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Wed, 25 May
 2022 14:59:46 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::ea) by DS7PR05CA0087.outlook.office365.com
 (2603:10b6:8:56::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 14:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 14:59:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Wed, 25 May 2022 14:59:43 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 25 May 2022 07:59:43 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 25 May 2022 07:59:41 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <kbusch@kernel.org>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] nvme-rdma: fix typo in comment
Date: Wed, 25 May 2022 17:59:40 +0300
Message-ID: <20220525145940.575-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2742b23-b72e-4563-4109-08da3e5f33fe
X-MS-TrafficTypeDiagnostic: BY5PR12MB3825:EE_
X-Microsoft-Antispam-PRVS: 	<BY5PR12MB382528E9E1D79699F5A4AC7FDED69@BY5PR12MB3825.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	tAxppBa1Wwm2rNuovU60v2NC0uyTKDykxusM8qDlJKnna5toxLN2GfIPKrQrYbM6aSv9KWR4H+p1x0FretZb68+fWVUrd+1V7x4L8Ydk3RcFrQCIc6GdamrczOZGkHPM0sTzDg+en4mI24PlEGP5vMGNrvH3w0a/kk/CjpYfImp4l/h+RM13qt4LYv8KQJFFed2ARSagIFJSe6BmPfDC6JaiGc5aADR0YcKhAGTuECesBiwjlwe35UdQgSY8Bca55HvM89eENQ51MkH2zXvj5+VAdfxNak/7s9Fy5H8rJOaI5pbcVumU7+5IU8b5FORciVGXE2gB5p0VSeQqu495i2i9flG62cKOCBCCSdcRj9J+Qj19gkhMsWiGei/KzaM058s8bwJXZHqW+0ORo2xN58j/Dz/xBJ/wDBGqA7L/tle7ppPY/v/D2t5GlZ58ioUszv1dNHDQafNRMw3hSOEY0Ayvddmerx5V/+uh85QL/bQFGaJZQd3mLAsWTXzThLFOsAfsrFaVApyNTM6TXqkqf5k0a/5ixsfS3BoIFIFofKL0NrwnkHPG9TD7H4toZsYpM3Z1wxt8HqSanThlP7Z2Xip5TEAFQ25gBiThcIJrtbJuNktnIkaSj4l0DDDKhzswgFYS3NEs5nljOdncIkwut9m+iZVFi18DvASCloyrE8lbhMTeroDOfzQzaEnaFLM7OG6mXBJbIH0rhp6MIS7qZQ==
X-Forefront-Antispam-Report: 	CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(426003)(336012)(47076005)(356005)(81166007)(2906002)(86362001)(316002)(82310400005)(36756003)(8676002)(4326008)(70586007)(70206006)(40460700003)(83380400001)(5660300002)(26005)(4744005)(8936002)(508600001)(107886003)(54906003)(110136005)(2616005)(1076003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 14:59:44.0212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2742b23-b72e-4563-4109-08da3e5f33fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3825
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220525_075951_606260_E3423729 
X-CRM114-Status: GOOD (  10.86  )
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

There is no ib_stop_cq API and the need for the +1 is for ib_drain_qp.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d9f19d901313..12c7ea61ed0c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -509,7 +509,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	}
 	ibdev = queue->device->dev;
 
-	/* +1 for ib_stop_cq */
+	/* +1 for ib_drain_qp */
 	queue->cq_size = cq_factor * queue->queue_size + 1;
 
 	ret = nvme_rdma_create_cq(ibdev, queue);
-- 
2.18.1


