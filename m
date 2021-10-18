Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EAEC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 13:40:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE5B6138B
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 13:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6EE5B6138B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FPO9IWWxBn3O5XtJMaJ6GNtnNNnNI7BoyvTYsPq/nm8=; b=M+xSQy7QbFC9TPaB/JurDddWqS
	wxabTK+PlOY7gVMWEEXUhyWCcNktHQGxTrmOPoNQ38HKHtK98tLj71nlcn3IYKW5lxsoJ00gUCZAE
	vN757vqKs9zdXSYsFoI7rUXz44V65Nyd9hVd/Gyo0C27PjziOXjd3TnctycfeG+7gpJzOBOvuGVSy
	8kdgOBcYwX13mwUbEUsSFvHEdJYO1Fhijfmp66pkHJAq931Wuf+vlGhEXYdGoT54wpOzzJ+baAVxv
	0yF6qs1EuQcPNwkSCu9QUjeYrsC2I1R9OMPH/xEiAuSDxBD94t/ZcjKOEiOHtB0w8cT8aL5nViNmw
	cnUtgqZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcSsk-00Fr7y-TU; Mon, 18 Oct 2021 13:40:50 +0000
Received: from mail-bn8nam11on2045.outbound.protection.outlook.com
 ([40.107.236.45] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcSsS-00Fqy1-8u
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 13:40:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZepdPww8kDn2XjvPLBBdX1xkyXKuZduG7XfMEB932qu+xRS195CqVSERHp11gLOAzxVmx2qEQzhPTbV2I4guqji/kJO5RSlSqJLPZpxWxNZLqBnhddg3PjnoRlMBmYl246TDRfTvKHUcv8kP+nt36mdy1z9KbW8b4oAwlSZF/Ld1z0EfqY9n/nkbqw5IZ+IP8AQ1AWRWD+eSs9Cb4rt3z0X6uWcrPe8sGARwLJZpZQf//OFVPw4YrVWNBngtRqL4RPHzjB8CEBSK0XZXcoS2RbBOEZElP7CaK/h97SxtznnQNQmfhx62LwgCeTnG2MzcR3g4GV4cz8xesrZNvV2tjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPO9IWWxBn3O5XtJMaJ6GNtnNNnNI7BoyvTYsPq/nm8=;
 b=i1W7+o7Eg6kStrcGlaQewotH+qdXKdgeqiPZIzUbgfz+s3WxNrNtYuAftO3p60Zio9cxoTm5fAYxnVKYmGnlZ6xFirmJajcZCfYpmcBz9/mf96Q4U2HodThQoyzK8LATZd1Gax3gtIAClgWp4J3Ob79VmXApYF6vo1t54NSvFGhoLyXMOGF7LDxyjd0dEKEpa9+Cb/SmXybYNYEF3wKxbtjFI2+DNkS0Y2gI3HpGjqchALbO5AfE2aOctCQR/7+vAXlE+xK69nM6lVFQgV+hL/q+s+U6E7+HD/0s0XtIVimsQt3F5lojYO190aE5gAEGqiSum7Ng4UFmp3lMW2jfxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPO9IWWxBn3O5XtJMaJ6GNtnNNnNI7BoyvTYsPq/nm8=;
 b=FSjDCoi/wDfaAOCWCKsrNwBABdIJPNR56tJbHFR1iDmdgVDpHGagiLplWhLilzIPmHIJcdw2IOrvplT0kA36sixns1NJxdSABSmX+OK1CqxgD8sRNaclKKKjjNhKWR/IpRQMjNsnLLxLw/zHi+oyitHashi1HJM0wnrm9QNMZ9tPAOpvH8ZXrJT7JdsBmy3WFyb/XbjlIO+eKrGuZMn4X0TGO9ipi/xzVYdPj8g0/WX9FloAJlZKu4kjs1Tphg0TTVgjRaMtIZlVFpjI2Q2FRgifJXBruDwnsz1+OfsUIoK+QzWtb5w3sdllEP8s8bXtGg6FQ8hLeNGMMJZuQQJz+A==
Received: from MW4PR03CA0089.namprd03.prod.outlook.com (2603:10b6:303:b6::34)
 by DM6PR12MB3643.namprd12.prod.outlook.com (2603:10b6:5:3d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Mon, 18 Oct
 2021 13:40:25 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::7) by MW4PR03CA0089.outlook.office365.com
 (2603:10b6:303:b6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Mon, 18 Oct 2021 13:40:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 13:40:25 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 18 Oct
 2021 13:40:23 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 18 Oct 2021 13:40:21 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v1 0/7] Centrelize common fabrics code to core drivers
Date: Mon, 18 Oct 2021 16:40:13 +0300
Message-ID: <20211018134020.33838-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd2786ff-e8b3-476d-5321-08d9923cd6f8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3643:
X-Microsoft-Antispam-PRVS: <DM6PR12MB36439585C2806E342FA7C770DEBC9@DM6PR12MB3643.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sEKSa29uYRDEDfpNHXF6HfPTd/e7Mpjrm5oQCcv51BjsBzMGz+4xxr6SEtSr9mqHm6gWKFJ2BJd/tu0t4JIq0j5XNgu8zvuhyVh4yhpL3Mk9ffL5Qq/G9zEaxcrxkHiWJWUTkiN5yK8iDKTtWXZutfUBHqfcH9M6RHpWYLbSAd49k97ui9wTWmbNLONn2HCRgp9BhgB6uWUYNYEEgSu6lU0BH6kCdXdgbxclMaCVQvMdzRpPEjQP9l5KogaQyhD9/eUSWSER8iu1ZuJXPxxeWIG3vC0lNhbfmFYIpXPulE9h9xXYr+0Mgn4b4FvRCscYk9Hoe9jTY0GJg9y7nESfBS5My5lSjwvKmCkjVXIcwHsAkoCuoqsPm9qSWhS7RkmWi4tgugq5jnD/2I+jf2R0ekDM4mgYHZyd5QpHzUsX+wCg7Xefk2LrNJzE7a6rr9m0IY+xrExueTwYhGOLe3kfnquiYYs6aEG52m11agvq2LrkuMKjhu3coW1h4hFWr7yEjQr9yRXLAdk2mLMEhl7RzW1X061s/bk+MPbBAxQXbiczUBEQjHE1FEisjtkDoR2j3inItfHcAy5T7gpEKn8bU0uBeGWJOPM947xkGclv6RmAWCQYofRycCuf0TfYPFzunlAGYQCVP9J65poHWZyJ8BZnScbCsqJx8A+niIfFnN5J+WyyfZU0EjBwcZK+TlLtAupUIrZMEBEdDPcm7uqSvg==
X-Forefront-Antispam-Report: CIP:216.228.112.35; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid02.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(26005)(36860700001)(86362001)(508600001)(8936002)(336012)(7636003)(5660300002)(82310400003)(8676002)(356005)(186003)(2906002)(4326008)(1076003)(83380400001)(36906005)(2616005)(107886003)(426003)(36756003)(6666004)(110136005)(70206006)(54906003)(70586007)(316002)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 13:40:25.0907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2786ff-e8b3-476d-5321-08d9923cd6f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.35];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3643
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_064032_337278_3F46F256 
X-CRM114-Status: UNSURE (   7.23  )
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
This series is intended to move common reconnection, device removal and
error recovery logic to common fabrics and core drivers. In this stage,
it mainly deals with the RDMA and TCP drivers which had the same logic
for the above tasks. FC driver can start using this framework in the
future after some preparation work that should be done.

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

Max Gurtovoy (7):
  nvme: add connect_work attribute to nvme ctrl
  nvme-fabrics: introduce nvmf_reconnect_or_remove API
  nvme: add err_work attribute to nvme ctrl
  nvme-fabrics: introduce nvmf_error_recovery API
  nvme/nvme-fabrics: introduce nvmf_error_recovery_work API
  nvme/nvme-fabrics: introduce nvmf_reconnect_ctrl_work API
  nvme-fabrics: add nvmf_init_ctrl/nvmf_teardown_ctrl API

 drivers/nvme/host/fabrics.c |  90 ++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h |   4 ++
 drivers/nvme/host/fc.c      |  23 ++++---
 drivers/nvme/host/nvme.h    |   7 ++
 drivers/nvme/host/rdma.c    | 134 ++++++++++--------------------------
 drivers/nvme/host/tcp.c     | 124 ++++++++-------------------------
 6 files changed, 180 insertions(+), 202 deletions(-)

-- 
2.18.1


