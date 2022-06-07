Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E11C43334
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 01:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1tALjI5U4yd0CFGecBT+AZi+x8iVGbYUF9ITHqKDj/0=; b=kxgCWaWbJcQR8xf1VLLjDsGJ0b
	yJHLhfbeBF8EgXIe9x6jdpQz1zvJj0QVoUtiVBLyiUyQrhZJsTr06IpT9Q95crEgYgxnPQFNE8PCf
	rVEGHImv9CGa0pA43xw00EsF5xorSLhYdMYmrVo14nBwdJS2mIl7A7ZcQgcKCqMeHArEA+M0RLvOX
	9wLGZdt/r1gU6EY+mA8Pb+9VWnyLJCbyzMAI6sXUEc3fKUHPsFt4xM4UQHRWDf64w9KgnesMlH4B8
	XI0y4rxD6K/p9eBARvs70t9RsMYQui6rraOT8av6Fz0JKCaaq51ZXxXNLMDEzVnjNn9WhcsrJJc/b
	xO+5EARw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyO5S-0041Ng-U5; Tue, 07 Jun 2022 01:32:50 +0000
Received: from mail-bn8nam11on2062e.outbound.protection.outlook.com ([2a01:111:f400:7eae::62e] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyO5Q-0041NC-1N
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 01:32:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuTHBb4cyO2dqZVPffwufcc41MWKC1fXCEo4yf+fue3/MqR3w/jp8J4oU5RDw4vucJZU5uiuo21YCHi2tOTI7VeJXtl3g0nOlz2vVIIUA1Gx6OwGI95BXI1hcHjxpxMSfo3BZXMcpe1qaMX78UjG9NaXGVi0rsebkofLZ81ofcoK+UyG/3lzAqdASoVMyS+VS0fq2YJp+WwaHUxtrq0nE1DeB0vAyam+7ypUv8CQ3KNBre0nTa1I4OFBo5bSO4ORUeS3N5ouH1Hk6mxIUPff5FB8rhzhQZf+G3AkLDvV4GOlVkf15371aCm5atO+3ot1livfWzB94D41H59P7YyXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tALjI5U4yd0CFGecBT+AZi+x8iVGbYUF9ITHqKDj/0=;
 b=GdK8x/+arynwmiN3JGVwf4cBWmIHMDSXIN58lfFX0nz9M4ATx4sUxEDhC/vUVftbE7jdqunJNxuH+3eBbS2VuPnxYgtTMxSL0PGllYYiJo1QqukfdixowQ898jQ2bN7y4ynekAQboDeI1zU5J8eH1KexJzCVuMfv33zEasL0Ok1Y6RiuvUXSGixk5g8IjYIRfUs44+QA1EzSwGa7FGT3euxzQ2cJqmov7FOup1PkypU/7yqnf/WhFC3cVZ0bPy3bP/zM6tWzkth3KYT/l4ZY38d7TDFZauLpJVfzUCnHZwax5pON6nQViTXCqrAuUSbbwRXPJlJY4z3d7wuKv7+m/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tALjI5U4yd0CFGecBT+AZi+x8iVGbYUF9ITHqKDj/0=;
 b=Y8jHZZUV8BaJ+MbIkNh2Vc0STevFE5UYAfgICz8DT0nmAimlLI8wIPdcsCmFdYNsa+UWxzi/DDF6Fpxz07hedwy0gRqbcz6InAfLezNKCqgTjlFiL5/w9F/vQ2xM9hfZs/19Y+K3VRnGdVO2qDQBmJ5eurR+xcIDU4vIYCgd6CqCM1debzmF/Zm1sVJrYBMHeKylOKr3fHulvU5e5xEtQRxiMP3LO9qcJOH+Ld/9DZC3CK9dY3jVu+eBia0ttXAiSr0IlAyojoKGI4ZJisvZQDMbshjxAc5kA4iLJdxbSs8v9NHX1TR4RqRKbbxPjFSuTcxCmJeDz1ErGzPs6CTYcw==
Received: from BN6PR19CA0089.namprd19.prod.outlook.com (2603:10b6:404:133::27)
 by BN6PR12MB1617.namprd12.prod.outlook.com (2603:10b6:405:d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 01:16:55 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::21) by BN6PR19CA0089.outlook.office365.com
 (2603:10b6:404:133::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19 via Frontend
 Transport; Tue, 7 Jun 2022 01:16:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 01:16:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 7 Jun
 2022 01:16:54 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 18:16:53 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/6] nvme: __nvme_submit_sync_command() cleanup
Date: Mon, 6 Jun 2022 18:16:41 -0700
Message-ID: <20220607011647.24105-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 272ca9b5-2c25-42db-3c28-08da4823697d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1617:EE_
X-Microsoft-Antispam-PRVS: 	<BN6PR12MB1617617905DC7BAB27AC7F78A3A59@BN6PR12MB1617.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	OMEZtjwlkJSv5EFwDQ4TXCYdeZYs1b4Gur+icJKhafxItAYvZb8QTyXt6St+u3eqfxtbqGX5gjeEJG68TOu6TW1JTTG51oVwywqQ3yzR6ft/eoxjSubbWNSIy0u10sYWFWWAn2/nCpZYBkH8nxecR5hHW0rWeE4vRntoKPYw3vhdr1GHmRjUxRgylTvevLAZbC20PXKzLwnYomS4x0nAJFdfEWq3fPDkMxdFT1luEFqD2txw83xqhptK5sqf338EFj7uy9RhphLNa+wMtiTgxK0Wy6OthnmNE0LFg6AekKkDS/QT22sJ51JG2fnzd/5o9zs3OLrH3TsCmryqhnuLorr+713A4+6nc5BKFr8B/it1vJma+fWi0PHAf5rh5Hp+belpujst73PXU/Yh203fqjhEJ+hCTQmH6GE9rm+47Tytq+hyX/MZxw0OseWGr48grqKzs+/UZvGVzheQioxzAX+4BlnxNEEKQt/zCIewIJ/to/hFDp8g6PAn15i63MxreTjGY2UUL4ruloP3WOHNYCAD2xK/mEDZu4q/ovqiW341+hnFRT5Im5nqtjIU5nqWpVmxVAVxWgk/6mflJFFRhY0cWeopNqAGKa1c6oOGB2h2+T1h+NSs3pVN2Q6xwQ8cdZPe+/KY/mvsYDQc1VIvFho4A5GQ9jx+5dujor8GnJ8T0+6I/EFsgrwL3ABX2z195WNkTGmaI/+ggEq49vlKgA==
X-Forefront-Antispam-Report: 	CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(336012)(83380400001)(508600001)(356005)(2616005)(81166007)(8676002)(70586007)(6666004)(2906002)(4326008)(5660300002)(30864003)(70206006)(426003)(16526019)(186003)(47076005)(107886003)(40460700003)(82310400005)(7696005)(6916009)(54906003)(316002)(36860700001)(1076003)(26005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 01:16:55.5498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 272ca9b5-2c25-42db-3c28-08da4823697d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1617
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_183248_187036_4FAE6FE0 
X-CRM114-Status: GOOD (  12.17  )
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

The function __nvme_submit_sync_command() has unusually large number of
arguments = 9 which is not a good practice for kernel code unless there
is no other way to pass the parameters. Some of the arguments can be
derived from other arguments with addition of the readable helpers.

This patch series removes the unnecessary arguments from the function
that also makes code easy to read, debug and maintain.

I've ran the blktests on it seems to pass all the testcases.

Please let me know if I miss someting in terms of testing.

-ck

Chaitanya Kulkarni (6):
  nvme-core: remove unused timeout parameter
  nvme-core: fix qid param blk_mq_alloc_request_hctx
  nvme-core: remove qid parameter
  nvme-core: remove flags parameter
  nvme-core: remove at_head parameter
  nvme-core: remove __nvme_submit_sync_cmd() wrapper

 drivers/nvme/host/core.c    | 79 ++++++++++++++++++++++---------------
 drivers/nvme/host/fabrics.c | 19 ++++-----
 drivers/nvme/host/nvme.h    |  6 +--
 drivers/nvme/host/pci.c     | 10 ++---
 drivers/nvme/host/zns.c     |  7 ++--
 5 files changed, 65 insertions(+), 56 deletions(-)

vme (nvme-5.19) # git am --skip 
Applying: nvme-core: remove unused timeout parameter
Applying: nvme-core: fix qid param blk_mq_alloc_request_hctx
Applying: nvme-core: remove qid parameter
Applying: nvme-core: remove flags parameter
Applying: nvme-core: remove at_head parameter
Applying: nvme-core: remove __nvme_submit_sync_cmd() wrapper
nvme (nvme-5.19) # ./compile_nvme.sh
+ umount /mnt/nvme0n1
+ clear_dmesg
./compile_nvme.sh: line 3: clear_dmesg: command not found
umount: /mnt/nvme0n1: no mount point specified.
+ ./delete.sh
+ NQN=testnqn
+ nvme disconnect -n testnqn
NQN:testnqn disconnected 0 controller(s)

real	0m0.010s
user	0m0.002s
sys	0m0.003s
+ rm -fr '/sys/kernel/config/nvmet/ports/1/subsystems/*'
+ rmdir /sys/kernel/config/nvmet/ports/1
rmdir: failed to remove '/sys/kernel/config/nvmet/ports/1': No such file or directory
+ for subsys in /sys/kernel/config/nvmet/subsystems/*
+ for ns in ${subsys}/namespaces/*
+ echo 0
./delete.sh: line 14: /sys/kernel/config/nvmet/subsystems/*/namespaces/*/enable: No such file or directory
+ rmdir '/sys/kernel/config/nvmet/subsystems/*/namespaces/*'
rmdir: failed to remove '/sys/kernel/config/nvmet/subsystems/*/namespaces/*': No such file or directory
+ rmdir '/sys/kernel/config/nvmet/subsystems/*'
rmdir: failed to remove '/sys/kernel/config/nvmet/subsystems/*': No such file or directory
+ rmdir 'config/nullb/nullb*'
rmdir: failed to remove 'config/nullb/nullb*': No such file or directory
+ umount /mnt/nvme0n1
umount: /mnt/nvme0n1: no mount point specified.
+ umount /mnt/backend
umount: /mnt/backend: not mounted.
+ modprobe -r nvme_loop
+ modprobe -r nvme_fabrics
+ modprobe -r nvmet
+ modprobe -r nvme
+ modprobe -r null_blk
+ tree /sys/kernel/config
/sys/kernel/config

0 directories, 0 files
+ modprobe -r nvme-fabrics
+ modprobe -r nvme_loop
+ modprobe -r nvmet
+ modprobe -r nvme
+ sleep 1
+ modprobe -r nvme-core
+ lsmod
+ grep nvme
+ sleep 1
+ git diff
+ sleep 1
++ nproc
+ make -j 48 M=drivers/nvme/target/ clean
++ nproc
+ make -j 48 M=drivers/nvme/ modules
  CC [M]  drivers/nvme/target/core.o
  CC [M]  drivers/nvme/target/configfs.o
  CC [M]  drivers/nvme/target/admin-cmd.o
  CC [M]  drivers/nvme/target/fabrics-cmd.o
  CC [M]  drivers/nvme/target/discovery.o
  CC [M]  drivers/nvme/target/io-cmd-file.o
  CC [M]  drivers/nvme/target/io-cmd-bdev.o
  CC [M]  drivers/nvme/target/passthru.o
  CC [M]  drivers/nvme/target/zns.o
  CC [M]  drivers/nvme/target/trace.o
  CC [M]  drivers/nvme/target/loop.o
  CC [M]  drivers/nvme/target/rdma.o
  CC [M]  drivers/nvme/target/fc.o
  CC [M]  drivers/nvme/target/fcloop.o
  CC [M]  drivers/nvme/target/tcp.o
  CC [M]  drivers/nvme/host/core.o
  CC [M]  drivers/nvme/host/ioctl.o
  CC [M]  drivers/nvme/host/constants.o
  CC [M]  drivers/nvme/host/trace.o
  CC [M]  drivers/nvme/host/multipath.o
  CC [M]  drivers/nvme/host/zns.o
  CC [M]  drivers/nvme/host/fault_inject.o
  CC [M]  drivers/nvme/host/pci.o
  CC [M]  drivers/nvme/host/fabrics.o
  CC [M]  drivers/nvme/host/rdma.o
  CC [M]  drivers/nvme/host/fc.o
  CC [M]  drivers/nvme/host/tcp.o
  LD [M]  drivers/nvme/target/nvme-loop.o
  LD [M]  drivers/nvme/target/nvme-fcloop.o
  LD [M]  drivers/nvme/host/nvme-fabrics.o
  LD [M]  drivers/nvme/target/nvmet.o
  LD [M]  drivers/nvme/target/nvmet-fc.o
  LD [M]  drivers/nvme/target/nvmet-tcp.o
  LD [M]  drivers/nvme/target/nvmet-rdma.o
  LD [M]  drivers/nvme/host/nvme-rdma.o
  LD [M]  drivers/nvme/host/nvme-tcp.o
  LD [M]  drivers/nvme/host/nvme-fc.o
  LD [M]  drivers/nvme/host/nvme.o
  LD [M]  drivers/nvme/host/nvme-core.o
  MODPOST drivers/nvme/Module.symvers
  LD [M]  drivers/nvme/host/nvme-core.ko
  LD [M]  drivers/nvme/host/nvme-fabrics.ko
  LD [M]  drivers/nvme/host/nvme-fc.ko
  LD [M]  drivers/nvme/host/nvme-rdma.ko
  LD [M]  drivers/nvme/host/nvme-tcp.ko
  LD [M]  drivers/nvme/host/nvme.ko
  CC [M]  drivers/nvme/target/nvme-fcloop.mod.o
  CC [M]  drivers/nvme/target/nvme-loop.mod.o
  CC [M]  drivers/nvme/target/nvmet-fc.mod.o
  CC [M]  drivers/nvme/target/nvmet-rdma.mod.o
  CC [M]  drivers/nvme/target/nvmet-tcp.mod.o
  CC [M]  drivers/nvme/target/nvmet.mod.o
  LD [M]  drivers/nvme/target/nvmet-fc.ko
  LD [M]  drivers/nvme/target/nvme-fcloop.ko
  LD [M]  drivers/nvme/target/nvmet-rdma.ko
  LD [M]  drivers/nvme/target/nvme-loop.ko
  LD [M]  drivers/nvme/target/nvmet-tcp.ko
  LD [M]  drivers/nvme/target/nvmet.ko
+ HOST=drivers/nvme/host
+ TARGET=drivers/nvme/target
++ uname -r
+ HOST_DEST=/lib/modules/5.18.0-rc3nvme+/kernel/drivers/nvme/host/
++ uname -r
+ TARGET_DEST=/lib/modules/5.18.0-rc3nvme+/kernel/drivers/nvme/target/
+ cp drivers/nvme/host/nvme-core.ko drivers/nvme/host/nvme-fabrics.ko drivers/nvme/host/nvme-fc.ko drivers/nvme/host/nvme.ko drivers/nvme/host/nvme-rdma.ko drivers/nvme/host/nvme-tcp.ko /lib/modules/5.18.0-rc3nvme+/kernel/drivers/nvme/host//
+ cp drivers/nvme/target/nvme-fcloop.ko drivers/nvme/target/nvme-loop.ko drivers/nvme/target/nvmet-fc.ko drivers/nvme/target/nvmet.ko drivers/nvme/target/nvmet-rdma.ko drivers/nvme/target/nvmet-tcp.ko /lib/modules/5.18.0-rc3nvme+/kernel/drivers/nvme/target//
+ ls -lrth /lib/modules/5.18.0-rc3nvme+/kernel/drivers/nvme/host/ /lib/modules/5.18.0-rc3nvme+/kernel/drivers/nvme/target//
/lib/modules/5.18.0-rc3nvme+/kernel/drivers/nvme/host/:
total 6.3M
-rw-r--r--. 1 root root 2.7M Jun  6 17:45 nvme-core.ko
-rw-r--r--. 1 root root 422K Jun  6 17:45 nvme-fabrics.ko
-rw-r--r--. 1 root root 924K Jun  6 17:45 nvme-fc.ko
-rw-r--r--. 1 root root 716K Jun  6 17:45 nvme.ko
-rw-r--r--. 1 root root 863K Jun  6 17:45 nvme-rdma.ko
-rw-r--r--. 1 root root 809K Jun  6 17:45 nvme-tcp.ko

/lib/modules/5.18.0-rc3nvme+/kernel/drivers/nvme/target//:
total 6.3M
-rw-r--r--. 1 root root 472K Jun  6 17:45 nvme-fcloop.ko
-rw-r--r--. 1 root root 415K Jun  6 17:45 nvme-loop.ko
-rw-r--r--. 1 root root 732K Jun  6 17:45 nvmet-fc.ko
-rw-r--r--. 1 root root 3.2M Jun  6 17:45 nvmet.ko
-rw-r--r--. 1 root root 822K Jun  6 17:45 nvmet-rdma.ko
-rw-r--r--. 1 root root 675K Jun  6 17:45 nvmet-tcp.ko
+ sync
+ sync
+ sync
+ modprobe nvme
+ echo 'Press enter to continue ...'
Press enter to continue ...
+ read next


nvme (nvme-5.19) # cdblktests 
blktests (master) # nvme_trtype=tcp ./check nvme 
nvme/002 (create many subsystems and test discovery)         [not run]
    runtime  17.206s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.083s  ...  10.085s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.436s  ...  1.141s
nvme/005 (reset local loopback target)                       [passed]
    runtime  6.772s  ...  6.205s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.057s  ...  0.073s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.039s  ...  0.042s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.435s  ...  1.148s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.405s  ...  1.117s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  8.197s  ...  17.531s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  86.446s  ...  80.812s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  11.663s  ...  21.509s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  90.610s  ...  97.420s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  8.889s  ...  8.551s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  8.796s  ...  8.741s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [not run]
    runtime  13.641s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/017 (create/delete many file-ns and test discovery)     [not run]
    runtime  13.113s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.405s  ...  1.125s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.440s  ...  1.140s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.411s  ...  1.113s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.423s  ...  1.116s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  6.725s  ...  6.230s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.435s  ...  1.134s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.398s  ...  1.105s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.398s  ...  1.112s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.405s  ...  1.107s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.407s  ...  1.127s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.429s  ...  1.116s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.521s  ...  1.233s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.177s  ...  0.115s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  53.745s  ...  50.742s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.019s  ...  0.025s
blktests (master) # nvme_trtype=loop ./check nvme 
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime    ...  17.636s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.085s  ...  10.091s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.141s  ...  1.435s
nvme/005 (reset local loopback target)                       [passed]
    runtime  6.205s  ...  6.788s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.073s  ...  0.063s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.042s  ...  0.040s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.148s  ...  1.452s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.117s  ...  1.427s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  17.531s  ...  8.175s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  80.812s  ...  85.502s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  21.509s  ...  11.513s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  97.420s  ...  92.585s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  8.551s  ...  8.828s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  8.741s  ...  8.735s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime    ...  13.152s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime    ...  13.662s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.125s  ...  1.409s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.140s  ...  1.438s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.113s  ...  1.415s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.116s  ...  1.422s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  6.230s  ...  6.721s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.134s  ...  1.432s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.105s  ...  1.415s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.112s  ...  1.430s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.107s  ...  1.423s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.127s  ...  1.423s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.116s  ...  1.405s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.233s  ...  1.535s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.115s  ...  0.189s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  50.742s  ...  53.742s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.025s  ...  0.020s
blktests (master) # 


-- 
2.29.0


