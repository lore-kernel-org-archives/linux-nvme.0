Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B373C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 10:39:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 530DE60FD9
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 10:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 530DE60FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XOvTb/fcFDKARosfppSWhwSBuH9sYKfRN4IqZz/R/uE=; b=2z77GRynP6w+A3w36nDS2UUS3T
	A8OG7AVF4uW9Mj5R+gtlnKarjMbK0W7oi0mmf+6dd22F1R9eEhYCNmDQ5yF560mQTIswjK/C8ZbqC
	kgthk0ZZRbiil8Iw4F+FWYDc4uf5NmhVqzRylCokmMyVf0sx394q2b8CndmPmNP9Z6pNlDbByxbWW
	r2ufMEKtY+8cft2z6VFm7F3ONQvELzvspLNUH/VUDgK/z/oghArx2FSuhEnVcrERrPdhOi1kcXMEq
	qlnxMZNugjJGF49EJ7FgFeQKt//LFX6dytjLfYPJbJxXwR85J3fnxh4Km2MbTZBVv+HxF2woupnvv
	zZnwdhXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1md8zv-0049LW-F1; Wed, 20 Oct 2021 10:39:03 +0000
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com
 ([40.107.236.59] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1md8zs-0049KN-2o
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 10:39:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPV600KcinYB85WeekLLOT551N0BOahELlIgE7ylV54sYBULN+B2vVAxR9uFIJPPOyxQglBhEFaxhbTWZFttXRM9ytWYIvwmKE569Q+ud1e4/RpmIcSjKZRs1c8RVp0rH1CU39rymrl7SX9LykU2pTJrS7CcIAGb4EcjEZRmVwj4ufFabo51T44mjftNOZRkeAfcg4crFcKkOzEMp5bPZrzsCei6Y+PIAGwLdFEdwf7itPjvKpKNqpxycCZSFYCSqxKZZN5lQxkmVGOtAVPxc65JuZLeQzQnABkdQ0SJBoJWVwQwd4HtanNsOXCGGWOYauXTcs83PT/D3Ky/G4EGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOvTb/fcFDKARosfppSWhwSBuH9sYKfRN4IqZz/R/uE=;
 b=Cj2gkiKtpsuBJa+sFA5H5wSS5xBOBN+jK5QavlKKqQZh2IBbMG6Hz1ynrKcPPMwtrAEDqMVCfgwg1hrNGzNLtvkl+VeuRLv1URx40DWy69EuniGrWvFK2IGmJR0yWF39mdVMu6Ride8Y7i9tYS4hFla/o7yYe+OPfMLdjrxlXScUS2kt9v6/FsDDfOgkX7cVlKNuJ1zRpB0QAV6LdH/l66lntiJkwuRy9x5lyUk+FnVLxCI4q17kmZVfedgrcytoPxCRxaMv9p4tVsgXQIroB6zezALbsNtI8wBF/R29bPbA0zz21IIZEesjCdsgMu9ysA8g7enFBePNOVfJnVSQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOvTb/fcFDKARosfppSWhwSBuH9sYKfRN4IqZz/R/uE=;
 b=X6IhMmkIaDA+VMD5EcHapi4YSI1nQ08ewde8yxIYQWeMiM6FJAh3NB/wpZT+Kvy0T7jW1c3ZLdcZ0C3lBep4VQRC4GDw/BPxwxU882FORkUCBAgTFNeapgej7IQYtZZ8HfamC8TX/1tsJtdMUqCSQtZoCOyJGbAbvEbK7jXo9xat1gHHUATitEVbhq3UlAqrSglmAgsEU8qp+keeU3pdgr5THvVMAS3zWDl57aK55ZLZRJJ0gQG1A3dwoeCn/+S9NwwXdBRIzexFUO+Dka8UOeCW7c8ZwfWGpOsYOYzn9geqypaRVdqIAu6oJe4pg0XT9wyYGNoNVZrHh1afxKCUvg==
Received: from BN9PR03CA0053.namprd03.prod.outlook.com (2603:10b6:408:fb::28)
 by CH2PR12MB4953.namprd12.prod.outlook.com (2603:10b6:610:36::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 10:38:51 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::eb) by BN9PR03CA0053.outlook.office365.com
 (2603:10b6:408:fb::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Wed, 20 Oct 2021 10:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 10:38:50 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 20 Oct
 2021 10:38:47 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 20 Oct 2021 10:38:45 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <hare@suse.de>, <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2 0/10] Centrelize common fabrics code to core drivers
Date: Wed, 20 Oct 2021 13:38:34 +0300
Message-ID: <20211020103844.7533-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c652f25-84c2-44c9-c716-08d993b5ce3e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4953:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4953F66D6FF2D22ED708DAF1DEBE9@CH2PR12MB4953.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3SXHG20bXjx+Ju3Xx6xmtEOFbaP0GgujM7pVkG+ly9BF9+dHIhO/DVQqqPevQ5mgdpyhmjcCQgS+V+75g3lMF08UsgYOBjT0qBYc+QdZwGyVnMaqOkS1YtUPMzn7PnsB9o9NicBqGjfaWOOR9mWCaknJoNdUeKqGkTKX3bT5wt/Hj4ZsYifMTbIg/Vayl6b+BaA5KdBjsNroHO0l+03VMLtnd6QlU00+SkewQCnQ/Ra6B0cOROWGJwjWkQSq7Mf0V8DDPzm3wKHg/+duTbVejpaTPsiE1O8/kptQ+rQlCxZT+mAJptDieKo8wMHKjoVWrxgKcFArUZCe1jEVMnYNpQBsyal41MJUinSzTXl7Orxdi6mbHpmZye87KE1dQjZiUpmHdNmOoduz5S4frcBYAv0N3+t2I4TZ8qnH3lHowcthbOFdYNHk5yiqjLjQ2iomUAZLrTEZUtNp4fHDei5gVy4p0k7bIJT4hqHY/Gy/ryVLHDpIQ0TsnFWJOfVT3p1o6otUJXV24mXdoaHC5A8ong3Ty/BsoIKjHz7iY/22MRgyCqyG8MpcFXTaSWxTqbMwVGdCQHWXFrXoNc8By21X+XI+buss62ojuHUPnEdlZMC7+gfPRLxzIoOeqOizDZ7DDrOm/ZBlUUmnSbvcYroANh1bzizgAyj1ZGQKt/oLDoeBO7l5aVlGDKDIrDCFQGCDPifWh0Nxlcbkj42L0HGZUA==
X-Forefront-Antispam-Report: CIP:216.228.112.35; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid02.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(47076005)(8936002)(2906002)(107886003)(26005)(110136005)(82310400003)(83380400001)(5660300002)(8676002)(6666004)(186003)(86362001)(7636003)(426003)(4326008)(2616005)(36756003)(70206006)(70586007)(508600001)(36860700001)(54906003)(356005)(336012)(1076003)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 10:38:50.2413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c652f25-84c2-44c9-c716-08d993b5ce3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.35];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4953
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_033900_171828_A2CFF7A0 
X-CRM114-Status: UNSURE (   9.42  )
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

Hi Christoph, Sagi, Keith and Co,
This series is intended to move common reconnection, device removal,
error recovery and reset logic to common fabrics and core drivers.
In this stage, it mainly deals with the RDMA and TCP drivers which had
the same logic for the above tasks. FC driver can start using this
framework in the future after some preparation work that should be done.

This will ease on code maintenance and reduce the code duplication
between the RDMA and TCP drivers.

Since there are some attributes that were moved to generic nvme_ctrl
structure, I've measured perf impact.

NVMe PCI Perf numbers using NVIDIA's NVMe SNAP Bluefield-2 device
(Fio 16 jobs, 128 iodepth, libaio):

IO size   rand READ (before/after)  rand WRITE (before/after)
-------- -------------------------  --------------------------
 512B          2189k/2197k                2031k/2092k
 1KB           2188k/2201k                2027k/2088k
 2KB           2166k/2181k                2023k/2078k
 4KB           2153k/2169k                2025k/2076k
 8KB           1381k/1381k                1378k/1375k
 16KB          669k/676k                  660k/664k
 32KB          320k/322k                  305k/305k
 64KB          157k/157k                  151k/151k

As we can see, there is no impact on the performance.

Changes from v1:
 - collect some "Reviewed-by" signatures (Sagi, Hannes, Chaitanya)
 - added reset flow to this series (thus added setup_ctrl callback)
 - added more common code to nvmf_init_ctrl
 - rename nvmf_teardown_ctrl to nvmf_uninit_ctrl (Sagi)
 - add bool arguments to use RDMA/TCP callbacks directly (Hannes)

Max Gurtovoy (10):
  nvme: add connect_work attribute to nvme ctrl
  nvme-fabrics: introduce nvmf_reconnect_or_remove API
  nvme: add err_work attribute to nvme ctrl
  nvme-fabrics: introduce nvmf_error_recovery API
  nvme/nvme-fabrics: introduce nvmf_error_recovery_work API
  nvme/nvme-fabrics: introduce nvmf_reconnect_ctrl_work API
  nvme-fabrics: add nvmf_init_ctrl/nvmf_uninit_ctrl API
  nvme-rdma: update WARN_ON condition during reset
  nvme/nvme-fabrics: move reset ctrl flow to common code
  nvme-fabrics: set common attributes during nvmf_init_ctrl

 drivers/nvme/host/fabrics.c | 121 +++++++++++++++++
 drivers/nvme/host/fabrics.h |   3 +
 drivers/nvme/host/fc.c      |  23 ++--
 drivers/nvme/host/nvme.h    |   8 ++
 drivers/nvme/host/rdma.c    | 252 +++++++++++-------------------------
 drivers/nvme/host/tcp.c     | 152 +++-------------------
 6 files changed, 241 insertions(+), 318 deletions(-)

-- 
2.18.1


