Return-Path: <SRS0=nAjD=O2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CACC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Oct 2021 08:03:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E1861019
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Oct 2021 08:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 78E1861019
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=brsRGfgwAS+nb61kHtfSWeP78pU54O0Ced9UG0S0Ez4=; b=Wx9+Dea3C9i3OA
	JnexWl6Qfn8pNKlDABU+pa7Q2pe5E3pKUtC7ChCto1fgpUfvfCi8pIqxMU2fgGtYs493ahMuq9THd
	v43uC/4/33YIyqS7DSCmArSqfec7NILhYE0C6uWSIWqavzFlZrUNPA7ASs7PSXwfbkbjL46OqZJdi
	hcsaLKZqlEQkwX49DKcUetbmtRIy6gTHIZLE7xMg+lV61cFN29JGixWm8QTOiWmtpOXUSAVhHxlPd
	nxA0q+xlKYAbXpBtAF3mqXxXEH+up1RmfP7UOsd8AUwMbYarIH2EMbiAWnV4jyq/4VcjAQ8zCjXaQ
	VdFu54yaT6GURlUtAsMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mY1td-00DLHI-B7; Wed, 06 Oct 2021 08:03:25 +0000
Received: from mail-dm6nam12on2058.outbound.protection.outlook.com
 ([40.107.243.58] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mY1ta-00DLGJ-2O
 for linux-nvme@lists.infradead.org; Wed, 06 Oct 2021 08:03:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlF0Bh+el0UKvcLEHEag2x2qbEb9qykTT9WzGl4wJdYDo45UDxTD133abZvdf604QLbUGsopcbPDkLb48hAqS1lZ4AEAr2asigw2CbxfXhM0nEftDRHjGhHYY9AxFAXd4Lu0IQTdRDOz+UHbxUgeqNTm/6CwW0JgmIGdbYEDO2CM/Fzwk6FzpWvDyzBdA1Ts9VL0ttvReZ/dPWwf/0e01CRqAaKKcxkJijfZAcmDySfOwHx3AtUV1NfqyW1BULgwz5SqJUKuv+4tsUTYykufFYHv+pK9AhkkUFwp7ephiH1tY1a2UJusunxNmygV4vFR2Slo7KJd1Z5DxuHulSeMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xMlnodVZcvATSZHcPNkmBhpsPuNCT9zekuxzO/LJTI=;
 b=SO76cvWkoi0QQiXveNuxX4j4FztfHq38cllhqlEQTupAyk98AHTt7lD3lNYOYkv9gQ3O2y8Y8DH63llThlUsOCzVWmldOmxuYRK5SKCaVl1+l3+mUvu67p4HS3/WTMQKt2g9HNo4sa4c/GJWOmwl3x1VVYz71LRRu3Ab5pEIZpEfaoC99vrLuoQGCX5XxPr+D0I6gzpYcD66niPeeUos44EIRbC/1rotzy0hh6sV4CfIPszNKL38O4397ApUQMaSjClGYkavYCvyHR7zFa+pKdbi/jdToVQV1QTFTJIac+jjjMbN9waeL8Ko73QKUOwIfuMZ9W+zxsqhAYPa2Nsl0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xMlnodVZcvATSZHcPNkmBhpsPuNCT9zekuxzO/LJTI=;
 b=GJA7EE/TMo+9xHkQA8pBOwGAVo05EoSuwdAP5CKAijkuV3nH2QLNWkLfM7ZNWGAFsYMjjzausA+C2v93rvvn7VcY5epOKkM8Qpu4bxvsaR8Fr6od435ddEQQDouQOVbrwPGWHnS/dY+QXvH2YoN0dUJrB+rFUzD5wIWoSdSimt4DNS+Jc7JA5tjeVpVcuVjY6sMxrsYGsJ64JCx/hsTWALw/qNBW9TPx8gY2sG0NDqYpxglb5Pep3xUBN29zUM/qYr08eXTf8+3lq1n4Md2xcapDrJcAIcNjLQajLB32WWJKSLQCEJBV1Ndjf1api1QBlswJh7h7CD7D6RPWpeoUGw==
Received: from CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23) by
 BN8PR12MB3121.namprd12.prod.outlook.com (2603:10b6:408:40::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.19; Wed, 6 Oct 2021 08:03:15 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::ce) by CO2PR04CA0145.outlook.office365.com
 (2603:10b6:104::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Wed, 6 Oct 2021 08:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Wed, 6 Oct 2021 08:03:13 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 6 Oct
 2021 08:03:13 +0000
Received: from rsws47.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 6 Oct 2021 08:03:11 +0000
From: Israel Rukshin <israelr@nvidia.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg
 <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC: Israel Rukshin <israelr@nvidia.com>, Nitzan Carmi <nitzanc@nvidia.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 0/3] Fix-use-after-free-when-a-port-is-removed
Date: Wed, 6 Oct 2021 08:09:42 +0000
Message-ID: <1633507785-10319-1-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a646d6e1-a02a-4917-bf34-08d9889fbf55
X-MS-TrafficTypeDiagnostic: BN8PR12MB3121:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3121698AB3E6D997F9AFDC80DAB09@BN8PR12MB3121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4tKtxV1zhhnLTur3kao2bmhPgaL3LDBqeURgyWF5PQb5rOCR/xta4dxEPqxNSCYHr0Yeg5zdqpZDYTOUynm4djoSr3N1caI6086UwBAVk7G5MU85GQA1fig3pZyQPhdHIHws0k337wRQjBsP3H6/UT61hqm/NJAPeD4lzvYWDFFUsmDE1WX3WBLnbfqw4AqzJdT5km0NjzJMsRofj/Hc8npt/Cc+0ZZ5Jzxt91DTDEH3eKIvLC/SQ2/ZvJRUehPO8oSRbQy3YPM8+8ni/EoxkSY+q0uVTPTBOQGY9Q6FobwG+MYzJI0LqkDiWsms8wjAUR+khjTSoapOKsuprxhbfJ5QDYBNBlRBXAayJPuo8H9qhy07tkozbY8x6xDFF2sZOXPA5dfdNACNW0Qrh3Xe6IqrYyijw55WBBr7BvV+Ppw6ugLEUYxFRLpdRzlZZ3RJJxus2IQBD8ewBnGoSHpZ3kpHnl8EMU86H9mZz+xBF68BmsyLTG49nYoiDhSfoAb+rYLKjwhC1LWaw/BerVIMgI83TrkLZuLrQCbUaKK5XNaDC0LvcAnFz1JW0KeooO4x3aUjyXfvXQZwuLxFzKwByGxXByhUX/1cW7cop/GzVgYYp7o8TLVAQ7amiynlfP1UbjMd+yLlaHTzeAdjf2XE3yUZTN8sKchCpx9f/cOfSgqXZMEAqwPyIHx6H7mtl2DW
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(186003)(336012)(4744005)(110136005)(70586007)(70206006)(54906003)(5660300002)(426003)(107886003)(26005)(316002)(2616005)(82310400003)(36756003)(47076005)(6666004)(508600001)(36860700001)(4326008)(8936002)(8676002)(356005)(2906002)(86362001)(7636003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 08:03:13.9022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a646d6e1-a02a-4917-bf34-08d9889fbf55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3121
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211006_010322_154453_65AE6CBF 
X-CRM114-Status: UNSURE (   8.39  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,
This series fixes an issue when a port is removed through configfs.
This issue is a use-after-free bug for any command that dereferences
req->port (like in nvmet_parse_io_cmd) after releasing the port.

The first patch fix the issue after the controller finished the
connection flow and the second and the third patches fix it during
connection creation time at nvmet-rdma and nvmet-tcp drivers.

Israel Rukshin (3):
  nvmet: Fix use-after-free when a port is removed
  nvmet_rdma: Fix use-after-free when a port is removed
  nvmet_tcp: Fix use-after-free when a port is removed

 drivers/nvme/target/configfs.c |  2 ++
 drivers/nvme/target/rdma.c     | 24 ++++++++++++++++++++++++
 drivers/nvme/target/tcp.c      | 16 ++++++++++++++++
 3 files changed, 42 insertions(+)

-- 
2.16.3


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
