Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D42DC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 21:56:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE1360F24
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 21:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1AE1360F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rxmbRKdb4ht9Dg5Jmdq/DB4dqxrhc3gaEhQzMV13Ibs=; b=JDCCJTAVzg1YLz
	t63tDPheMqZRXSA8hwzM/MvWFj3WWx13yg0ruYeB20ETwmi/Wr9BXZ9Wb5AzPMtYPXhVjlj/hvfmH
	nPduVHLVPYVoezfvbyMhDL0REi913Zk1QqzpGs9rMmuSwoaFmx6vKDyO+zLiAGAlKHV7dHlO5YOWu
	p1wQnob+FpDuv19+lu48bJmfG3EqNrM0Cf6woDoszGd5w3Z7HhUpC0MLsh6KIZRp4yI2Cg9VrGXi9
	gc2VAlW03OmOv4uyTPVspgp8AwuvUfq5MV855QOKOUsZKD+n8HmNCAn56ltHCw4JzTrxQYbd45zJY
	pET41q1Dk7ftbF5xrQUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mTADk-009mi8-OB; Wed, 22 Sep 2021 21:56:04 +0000
Received: from mail-bn8nam12on2085.outbound.protection.outlook.com
 ([40.107.237.85] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTADX-009mgG-IF
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 21:55:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1SMgLXKaQjEhdZi8pnwxWd5frBbuE+h11ihqzJMjSFx9ABIsS2HQGVctkByHNSTrRRk34X73PcZKvPLfDuPHSNDXGpdCcEhSZoRnWWknks2FUb+ODFmDDYrO5gK7oAYuDl6bfk1tH28UEVmKXzvya+iPbk0NWROMxUl3srKVVhVEZEtGBVEwvx1YtpY4hn43jPLDmDTmq/mxxSR5SU98pYll56KCxbeeHibJdmk+ghXFncdwZuwl/4wObOHSyFf1kIoc8FXeuJHXvLzgZR5vRkRHW6TJRWecOwZYPAgIuQTBv2jgpWjjvEIZbW5AjOuTHBXcRXt+pjRaiJEh9mjGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=gs83CvKHKPP9JPISxf23J63FOtKZFzvOlQ7GqJW5Rqo=;
 b=mukR2zCzPN1P7EgMuoUaL+tk8WpEx0uYLG2Nt3JhMZrplsCIn95ohJJtv7JOTelapJ3MTN2uFPcE1B9iYr0/5RHvCmZoSLD1z/W412zR6BxoyDdDFqVhkzaAUYA4OcFqymbRXp/sZmB8pdqcSGolcAuPAk7pPxKS1JaX2XqlJ10pDeKcZGlRzJEc+zkfS4pZiIh6qJI84gSV0Cs08vmbCdly2dDDzKLYcK6ne03SThAgEfQsqlOTyq8+tfSKS0Cbn729/j181UvOHJC6H77QbGCLYqMqYvhCL1GM8JYmyGgPTJt4oMMb8whct4JslaDSPYsrtIj9cQDBdxxoyDsaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gs83CvKHKPP9JPISxf23J63FOtKZFzvOlQ7GqJW5Rqo=;
 b=a8M19ERekb4TP4yWUdEJu0S47rG6FKmB4wGx0j2sc3shZnblPjlxm14cyRm/I2k3fxh0fgum+TbO37eqTzCvhL6vbJFJIDZvtYC6lHHaLhjdxKhBHNBVUCjZpPB5DjaHxEwisyXjolHCvotWt/BXvmP7TJupFd+g125e3O8GwMszoULN5Y7BAJrVzc3bogyP4r12njKcIF0+FClBI5fsiMhGTqnFHauR1z/5BiHZ+rNog6oya6GHJWmOb4V1350tZMyF5d9iliUNHFDFYxHqJ10BqSi4pQk/mjkS5oXa5pe+UHDRlcH3slMpdk0inJVqH0O3RMP2NNcHlQGtxirdCA==
Received: from BN0PR04CA0178.namprd04.prod.outlook.com (2603:10b6:408:eb::33)
 by DM6PR12MB3980.namprd12.prod.outlook.com (2603:10b6:5:1cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 21:55:41 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::ab) by BN0PR04CA0178.outlook.office365.com
 (2603:10b6:408:eb::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Wed, 22 Sep 2021 21:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 21:55:41 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 21:55:40 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 22 Sep 2021 21:55:38 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>, <chaitanyak@nvidia.com>
CC: <israelr@nvidia.com>, <mruijter@primelogic.nl>, <oren@nvidia.com>,
 <nitzanc@nvidia.com>, <jgg@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2 0/3] update RDMA controllers queue depth
Date: Thu, 23 Sep 2021 00:55:34 +0300
Message-ID: <20210922215537.6499-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a69ac64-e92c-4295-b830-08d97e13b895
X-MS-TrafficTypeDiagnostic: DM6PR12MB3980:
X-Microsoft-Antispam-PRVS: <DM6PR12MB398021EFAF62521F175FAF2ADEA29@DM6PR12MB3980.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PblaE85p+qVJVq0QeBnZmpI25STSf4CKd25Dan1aMRZHsil5L73ENeqKXHKOua1Dx3N0R93LhJKJ23BkPgqrMznY3kQX2T9MIwQhejVNZ4TR9MrJeZifVN91c9GnMgrTMxx5An+Dx+p85Y2TX4JdRTAfPc7gnD2O7dcBY5Uymht2+asF8BDh7q5Tu2Yq7V0nqM9HymBNig49wOv9ZPAEmFtnP4yjEuL+zxvSAPZrHEmBEDymcaj11neS2CE4p9Ybs/Q7QQKuXHTiftcKaGXdijYP1iamlZfcDgbQO5vebVfLEjrkzq5Mz2rKOei/g7+Ye7cQK7UtJvPTJmRrfrZ7+PskBXf/ZLiJQTxIKTgkmEyb00ZISg+CRTWJOKRCO2XFGTF/vIL8jXh//tvmR4UO9XXR5CyfaAxYGp9fK52nw8ZXm1Vf6Av9u/fgaF1R8d64H7x+H2IX8F+ux3953mAbo7pyVDF5IwW6SdyAWAqAMb1RfRHUDk8uoy/Iqmg/yLS7PMS57Qt6es9zVdHLTBRjIRzc3GNGZi6B1GqK20JhKCnjuZWV2WUuvEbdUgK3kzqETEX7JyzKb9gjSt4uIIVG1etJvCL/ZEaha68LZN4FiTiTHdWuLrI1p/0kaGw12hNTVD9UGk+lrqNCxcXpI2BOQok1Et7mLvu5P8XxXMH0bHqeOMUobpIAL6HCfUFFrw/ZBrB+ulX9oRmd3yH8NZOE2A==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6636002)(86362001)(47076005)(7636003)(54906003)(110136005)(82310400003)(8676002)(83380400001)(8936002)(2906002)(36860700001)(356005)(426003)(70206006)(70586007)(316002)(36756003)(2616005)(5660300002)(36906005)(26005)(336012)(508600001)(107886003)(4326008)(1076003)(6666004)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 21:55:41.4195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a69ac64-e92c-4295-b830-08d97e13b895
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3980
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_145551_862215_ED42EF1B 
X-CRM114-Status: GOOD (  13.97  )
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
Other transport will continue with their old behaviour.

Also fix the other side of the coin. In case there is a target that is
capable to expose a queue depth of 1024 (or any value > 128), limit the
initiator side to open only queues upto 128 entries to avoid a situation
of failing to allocate larger QP.

In the future, in order to increase this size, we'll need to create a
special RDMA API to calculate a possible queue depth for ULPs. As we
know, the RDMA IO operations sometimes are built from multiple WRs (such
as memory registrations and invalidations) that the ULP driver should
take this into consideration during device discovery and queue depth
calculations.

Changes from V1:
 - added Reviewed-by signatures (Chaitanya)
 - rename get_queue_size to get_max_queue_size (Sagi)
 - add a fix to initiator side as well (Jason)
 - move NVME_RDMA_MAX_QUEUE_SIZE to common header file for nvme-rdma

Max Gurtovoy (3):
  nvme-rdma: limit the maximal queue size for RDMA controllers
  nvmet: add get_max_queue_size op for controllers
  nvmet-rdma: implement get_max_queue_size controller op

 drivers/nvme/host/rdma.c    | 7 +++++++
 drivers/nvme/target/core.c  | 8 +++++---
 drivers/nvme/target/nvmet.h | 1 +
 drivers/nvme/target/rdma.c  | 6 ++++++
 include/linux/nvme-rdma.h   | 2 ++
 5 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
