Return-Path: <SRS0=kLfw=OL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76FDC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 19:05:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A7461184
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 19:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92A7461184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=OcTdCEZA8qB5/QHRCXdaK8u7+q6nt88wf+/HHFGa9Sw=; b=kVjXRnZEBo6bsD
	64SAssJT4xuU0J1hbZtYDCJwsGJyGuBo7EaiUsPPsf8VtUUwrblAhQXkK81ocXuV72vdAEPCX61/2
	KKQOB5iiW4Xgpv0J58aogpN+s0rTYnb6LKUrO5CYMFtgrJUL3X6cNj7EjB1ASizNJBDSv/X+inSCN
	f95/7ry3XyZLW4MBEzB1IhIWPMk9mLg6/esEbphUztbX1gq6Wpnbjkju5Q2FZ5aB2UckV+5E5GdhD
	Yy7eZQlx2tD+4KOaF7OEi91piHdSzepK8mqYchqLS1JWHXoVcAZGha3XvE3RmHrx79qB3fJmnL9nl
	0uYCJrwEfttzeVk8dVLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSl4a-005ZJV-KO; Tue, 21 Sep 2021 19:04:56 +0000
Received: from mail-bn8nam11on2084.outbound.protection.outlook.com
 ([40.107.236.84] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSl4X-005ZID-Ca
 for linux-nvme@lists.infradead.org; Tue, 21 Sep 2021 19:04:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZYXlF2rFzLXw3zrN35+vEb2cTYnGo/UDom8YMZoPBqyGGgCBu52cSUIjvNDXb3E+Z6gwelnPvyAsbubNrKny9zWjl4XMRQDxuPSqmNG0ZdF3HvNOAMw3JX3hwQHYU28PChJ84bahQmJ+vH+D1GVnF05ACt5MlmNfwa8OoWROMQKdOvAaFhC30q5Cv865u4XmCNtqt1rgMftLC7onV74V08GSIkw1qhPae+LpiwDo/rmi4D0vNOmS/AwxiEHzCr8H0zqHNFfE+B6dOPFvP6AT4wI4EgmlspHa6KLtDyt87Tfsgu1xcTMfzXraR/xgSFHIPhkeszHn7/WM/8GjuyxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=GBlrr0zZhGheZp7z0Qww+75udC8Sp7kOC6kss/xjBAQ=;
 b=OST2KHqu6sYWzE9X90tXSKv89td+ztks5fRtgpPjDokdEEJ4kUWUKoaCaZ9otLskOSGl7lm/ROwU+L/xO6j3tcX2I85rXTpBY/9dS9rh4PZX+CQF329i4wCMi8ePoZmjvl2DpbjaaJ+6ItCdTqE+NdUFUe9WmYl7tmQgri2chL8hgL1wosDhcOAAgpPRymwL+JquWRf9HmeRyso/Hm8/3xxdERa2AKI3Lc6Qr4eM03+EBHKYteHWwb6HxfOlb0suwM4uglku4IRVaeuvEAa3I33we6CcV09K5+TdS6Ivek0jNQEcs5FCjY8AwlXqMcxfwTsJlx6cMM/uiQHa96+9Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBlrr0zZhGheZp7z0Qww+75udC8Sp7kOC6kss/xjBAQ=;
 b=UN8c+sQtKRZeRamYNyDOAbU2Ev09WBGe2JY/sYKtOGYOGuqC7iEXzDXjXFGwtzg9XZOZm7YhVbhasA41uB3aFi/L3gL0SamzZsgY2SIcqmPXbWWRu+bJQIjaygV555CUiX1DfgcIRuxUB23NrchKS/0CTVBCtXyZ2o3aw9AkxpjxEAfuUTgGcVnOXR+hlnABpWdJAIrw7yOdUCoXsLVk/To9e1/TQ+RhFS/aegJ3kkDzklQncrImjPN0ZvL0gyzU+p1L6L7u7af2+z0s7hMtpLyQ6VYHw/8VSQmiPV4fHA0VRABcgXEdSARmxGFUayLj+HHlu8hsaQWwCV6rLlhy6A==
Received: from BN6PR11CA0024.namprd11.prod.outlook.com (2603:10b6:405:2::34)
 by MN2PR12MB3822.namprd12.prod.outlook.com (2603:10b6:208:166::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Tue, 21 Sep
 2021 19:04:49 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::1f) by BN6PR11CA0024.outlook.office365.com
 (2603:10b6:405:2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 19:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 19:04:49 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 19:04:48 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 21 Sep 2021 12:04:46 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>, <chaitanyak@nvidia.com>
CC: <israelr@nvidia.com>, <mruijter@primelogic.nl>, <oren@nvidia.com>,
 <nitzanc@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v1 0/2] update RDMA controllers queue depth
Date: Tue, 21 Sep 2021 22:04:43 +0300
Message-ID: <20210921190445.6974-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c3635d3-88a6-4bad-daf2-08d97d32afa5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3822:
X-Microsoft-Antispam-PRVS: <MN2PR12MB38228FC903467093AF1F3B94DEA19@MN2PR12MB3822.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXuTj9aZCF1dFZWUMVW1yeqqjBYnDvOlrHECfrW64z4b2Z1huLh04yMw0tkoz2tfAZ9vMak9TXiJtz81dF7QsVrDaTvnBKPSaGHCGLzzieNEdI+iMTz8i526KUCzHqwBKx/IwQOvMBkrR3DwaFEMZjfLjE/S7T3/NJvtqE5wBfAm3lcTt0Xw2VXjko+AY3qWRR1emtZglzxnoUYEAWD47Bx6nyOSBkhVlyZWkJCnChVwSmfXbXjSCeS6Wan/lfnQKuFUG2mlmjxIJEQoJZlNkkin3b9DY0Uy65CKyaKZL3CchkRpQFQHl8QYD2V20rGl1aYUqIPAWLTP7O4B3LyR+1fJoKy3RcReevzCbeMaH0k7A5iUh9q1g3IpFSPjEZ/I4fjMv2clKH0k8Tu351IU82QrfcE8qudktE/H84PiSKpaEsntCjU2LFNWp2/8ckbfgSPpkqIciVLXGYCfzbDBys6DFNPTGp7Dvd+mvvtaj0Q4iwj1ZB6JUNc7+Ft/xZJwOO9QFVI1QpmhXOLX1dbuqBqL3xfRWIUORzZJiCn/6GTpQaH0W8nd/Sok0MkXCTpkIb49KdrrlntFgYDAie65EOumyCHZuK4xyI482hAt91k+2EdkZhrRiKlCnALSetK4t71xXYzpIXOjj/RE2ad6KZP5lLBv3zVifZmnKjGi4adIfrPXlmiuO/J9Xr1KNo6KBjeL+PfrGpF2dx8j/iKjAg==
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(426003)(8676002)(5660300002)(54906003)(6636002)(336012)(6666004)(508600001)(83380400001)(110136005)(7636003)(2906002)(1076003)(8936002)(4326008)(107886003)(2616005)(70206006)(70586007)(26005)(86362001)(36906005)(356005)(186003)(82310400003)(47076005)(36860700001)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 19:04:49.6565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3635d3-88a6-4bad-daf2-08d97d32afa5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3822
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_120453_473088_6603C8A7 
X-CRM114-Status: GOOD (  11.98  )
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
This series is solving the issue that was introduced by Mark Ruijter
while testing SPDK initiators on Vmware-7.x while connecting to Linux
RDMA target running on NVIDIA's ConnectX-6 Mellanox Technologies
adapter. During connection establishment, the NVMf target controller
expose a 1024 queue depth capability but wasn't able to satisfy this
depth in reality. The reason for that is that the NVMf driver didn't
take the underlying HW capabilities into consideration. For now, limit
the RDMA queue depth to a value of 128 (that is the default and works
for all the RDMA controllers probably). For that, introduce a new
controller operation to return the possible queue size for a given HW.
Other transport will continue with thier old behaviour.

In the future, in order to increase this size, we'll need to create a
special RDMA API to calculate a possible queue depth for ULPs. As we
know, the RDMA IO operations sometimes are built from multiple WRs (such
as memory registrations and invalidations) that the ULP driver should
take this into consideration during device discovery and queue depth
calculations.

Max Gurtovoy (2):
  nvmet: add get_queue_size op for controllers
  nvmet-rdma: implement get_queue_size controller op

 drivers/nvme/target/core.c  | 8 +++++---
 drivers/nvme/target/nvmet.h | 1 +
 drivers/nvme/target/rdma.c  | 8 ++++++++
 3 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
