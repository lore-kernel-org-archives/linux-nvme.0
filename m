Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D38C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Dec 2021 11:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7TshaU6WwHPa0P+w7TyXO2wvJT8x7KEPPvg7rLCvH2I=; b=WjExojbCXlwsqzZzh/ruYWM4Px
	IjIVzEqfSbhY9p184DoWmlxBhpoaZlOhpMzNoGiCxwlI63y19wrOvNPjJ3AGTda5A1qIbBJlYK+AH
	5zyO0Euhgictt8L5hw9hg18B5/dm7UwDH5FnMID8tacjsMC716W6Jr9j9gSsbTQMn4Na01AblK6Tr
	HGdwPYxtcsH8zjVrzr/8ghDK8XKqH/8aq+zeDKMPADTnKYHZqBIw4mmWX5z2hp4xoSSPlM+aVvHSZ
	G236M3b4gFjLnyLxeKQQtUW2ylgjvl2/bowlKzkaLjcdy2vJzzvlhCLMuGBprXE2mzOfXNi56yVrD
	y/iLu27Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mvdyA-001dhC-Hr; Fri, 10 Dec 2021 11:21:42 +0000
Received: from mail-co1nam11on2053.outbound.protection.outlook.com
 ([40.107.220.53] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvdy6-001dfC-GM
 for linux-nvme@lists.infradead.org; Fri, 10 Dec 2021 11:21:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGlC/c21sT+6bxS/yw8JxpeW/JaSQjPZNNmZbvVv0oSN4KygeicvrBWgQlyKNStWBxhHbSUrrL8jWpi5BOV9DCTXcsSuggxaCIVJKCsdw94ARKxNiud+ROXmkavQt7J4/lPI98iXi9YIsokpY9Vt3cvhncA/cloMxgZb9kSnrrYrWDXzQL8IsA6u3oFzAEYMK6JorZFK+IzpyNB8bXrX3OxtjsPu+wsJ2LcvaerBRi8wNuoAdriiZzJEeRqJ6SRcmBzu3guTBRvmnr0oFh7U4Qj8+0kMNQXga1DrW8imuxkDhFMQr/dVVXyP6AHM0ETGG+X7fvm0AlKjYMSqRKBdhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TshaU6WwHPa0P+w7TyXO2wvJT8x7KEPPvg7rLCvH2I=;
 b=eBfn+kg6RN3Xa1B/7kOuOtc0yzkv0e804Dga9HpOqWrut5Tyo+qED8hXdUMMQrPc9BT7GmfMfLACq+LM/PdLi61B4wCQvJqTogOOHpc8kdnz8Uw6H3OyYEucTUgdiSVHmu02jGSnfAAP6M7cy3xzqDv91C83SjI34t288435l8+NdJQighdcegkjYBX+C0e4P3j9unT2w3zNZtxUh/eX75sHjbaCiNnTi2TraEC7uZbP31oA5zaXCQgYe5BD8XcU1DHE5yW3YAgPPM8RpqR2XZBrmydMOgs8Hhi2dKXlSFwLgCXGkuhSzrLWcWcJha4PXk+NQDYkFkHWTOgp5Tv/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TshaU6WwHPa0P+w7TyXO2wvJT8x7KEPPvg7rLCvH2I=;
 b=rHcMq6L59MqY3tmTacP/4c/iOl7fvPPc4V0ncQQd9nYYY3W5tQtzyFZBAlBHSjuV835+UHv2I2/5xNs+RAnFh8pfq/LqNDI0QfiwP7Oy/CM3QjmIAl6EnISCcgUySjgEMqT8vTmlI+IykHBSH0q+hzuSz5NhEvJDjaFnASnH/gpI/eRS3dSOnjbpuwMWCTbxlZ1nM7c8+ygQAKTGO49QJ/81ez1k4duGckUV9u3F9MO5RWDVN1Z3LmjlfoXTSqrCnuEHm4xub2pUKRSZrxfYjK8c/In/NXG5D1AIH/YH3pVtakld1U0/qRZH/GQZkzglB/nP4kI0MWMLVJHTlhvhZA==
Received: from BN0PR04CA0159.namprd04.prod.outlook.com (2603:10b6:408:eb::14)
 by SA0PR12MB4591.namprd12.prod.outlook.com (2603:10b6:806:9d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 11:21:28 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::99) by BN0PR04CA0159.outlook.office365.com
 (2603:10b6:408:eb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Fri, 10 Dec 2021 11:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.13) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 11:21:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 10 Dec
 2021 11:21:26 +0000
Received: from dev.nvidia.com (172.20.187.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Fri, 10 Dec 2021
 03:21:24 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/3] nvme-core: make gencounter feature tunable
Date: Fri, 10 Dec 2021 03:21:13 -0800
Message-ID: <20211210112116.9299-1-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e622828-d5e1-4398-a50b-08d9bbcf35a8
X-MS-TrafficTypeDiagnostic: SA0PR12MB4591:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB45916A6A13A91FB0B40A017BA3719@SA0PR12MB4591.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:466;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRqoVR19mNOVS7+fboS7PRbt4yiCfHBZ/sQxU9ZUM6o2iCA3s50vkfgwzjafhpZ3100mU7J4Zg1LwT7q0aMl5UyZG4tDCy+y07P46KtLdRo7wGnhmelmf1aUCDSJT5Xroa1G2cjKEMozkonLO5gylSJzc3nsAQuqK4I0CSc3LngoMaiZVhEg76COzXNYALeDQbtd5gK4KDzIEkN6l07LQDZKWpLu85PckKa0DabELAhC3x+bnlPLmHH9t/BzXRN3jndwk6h94QDjmeBEPyNEgjQ4+mwKVOOcDemwlJtXWt5L5fssffuImVMwuRb4au7f7yj2931UqWp3juEQjg4Hf7RgVwyHjuSd+uK++n2laJ7lJM2wDy3t3dP8CTyt5RoUHw7CHCMuTwnAqvo9k0dOxomZZDq7gopdhLX8zFzvPGk5la1Mtv+CIUf8aNhDs3eQcMK/L6Kmd5A6h2SjYCYBqQLTUk7k3kibENknkGhXaoStZQFMKUvwRkP7aF751gVqQM4yLA6v+WYFhs63MITcmDO4LlrJ/IQ4o0cQ6ja0wtG0gRd6myIG64PnuB31+v4v0tkwZASBFs1Tq5Hd/GhlatsgOSou67cGqzzxoZlxXCzu9I5lehlxKDck3QkM6S4s/rfTz8HVRFrl8WJyYDWdfdNIskiFMC129LRswTkmgAeHygdC+DCZmkNNZfjpw1VrCey0ACxv8cgdHzOdZqSB8SLwXneVv3mUZ/JwRKUxnh65tzXDNpwcet68BumAgcvkGG4L0bDoARVQ3TehKLkT336rtR5TjL7Rmw3PhGBlsUkwShucVHLXljcqsRd7BHah1929CvU5Shm4+JnkrW8X9pJNg9yJShBumPFm8wds6pI=
X-Forefront-Antispam-Report: CIP:203.18.50.13; CTRY:HK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:hkhybrid02.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(26005)(4326008)(70586007)(86362001)(7636003)(16526019)(356005)(186003)(40460700001)(8936002)(2616005)(5660300002)(426003)(70206006)(82310400004)(6666004)(8676002)(336012)(7696005)(107886003)(36756003)(34020700004)(316002)(1076003)(2906002)(47076005)(110136005)(54906003)(30864003)(508600001)(36860700001)(83380400001)(473944003)(47845001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 11:21:27.7661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e622828-d5e1-4398-a50b-08d9bbcf35a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[203.18.50.13];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4591
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211210_032138_656719_650D2BB3 
X-CRM114-Status: GOOD (  11.86  )
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

From: Chaitanya Kulkarni <kch@nvidia.com>

Hi,

The recent commit uses a combination of command id and a gencounter
to calculate the command id so that we can call out buggy controllers
for spurious completions and that also avoids use after free.
This commit adds various if statements and bitwise operations
such as &, <<, >>, & along with comparison operations to validate the  
gencounter and print out the errors.
 
This feature is required to catch the buggy controller, but in the  
production environment where controller is validated and known to be
stable this achieves nothing but adds additional code and runtime CPU  
instructions for the PCIe controller.
Worst case scenario when NVMeOF setup is using passthru backend then
these instructions gets duplicated on the host and on the target side
for each controller.
 
This patch-series makes the gencounter feature configurable by   
defining a new KConfig macro CONFIG_NVME_DEBUG_USE_CID_GENCTR and adding
a new KConfig section Debug with subsection for enabling the  
gencounter debug feature. We move the current tag + gencounter code when
CONFIG_NVME_DEBUG_USE_CID_GENCTR is defined and keep the original code
where we use tag based command id where
CONFIG_NVME_DEBUG_USE_CID_GENCTR is not defined.
The newly added Debug section is kept under NVMe Driver section under
host side.
 
In this way we achieve:-
1. Removing the entire gencounter code at the compile-time and keeping the  
   fastpath as lean as possible when the controller is known to be stable.
2. Retaining the gencounter behavior by enabling the debug feature.
3. Letting user decide which debug features to enable instead of forcing
   any.
4. Avoid measurable differences in fio performance numbers. see below.

* fio BW/iops/slat cid gencounter on avg IOPS = 75k, BW = 295MiB :-
read: IOPS=75.3k, BW=294MiB/s
read: IOPS=75.8k, BW=296MiB/s 
read: IOPS=75.2k, BW=294MiB/s 
read: IOPS=76.0k, BW=297MiB/s 
read: IOPS=75.4k, BW=294MiB/s 
read: IOPS=76.0k, BW=297MiB/s 
read: IOPS=75.5k, BW=295MiB/s 
read: IOPS=75.4k, BW=294MiB/s 

Submission latency avg = 6698 nsec :-
slat (nsec): avg=5057.99
slat (nsec): avg=7434.15
slat (nsec): avg=6310.50
slat (nsec): avg=8083.82
slat (nsec): avg=7297.77
slat (nsec): avg=6003.77
slat (nsec): avg=6657.75
slat (nsec): avg=6745.34

* fio BW/iops/slat cid gencounter off IOPS avg = 76k, BW = 297MiB :-
read: IOPS=77.7k, BW=304MiB/s
read: IOPS=76.5k, BW=299MiB/s 
read: IOPS=74.1k, BW=290MiB/s 
read: IOPS=75.8k, BW=296MiB/s 
read: IOPS=75.9k, BW=297MiB/s 
read: IOPS=75.2k, BW=294MiB/s 
read: IOPS=77.6k, BW=303MiB/s 
read: IOPS=76.8k, BW=300MiB/s 

Submission latency avg = 5030 nsec :-

slat (nsec): avg=3859.20
slat (nsec): avg=4669.78
slat (nsec): avg=3778.51
slat (nsec): avg=8436.18
slat (nsec): avg=5653.83
slat (nsec): avg=5286.60
slat (nsec): avg=4176.05
slat (nsec): avg=4385.19

-ck

Chaitanya Kulkarni (3):
  nvme-core: make cid gencounter configurable
  nvme-core: move gencounter check into nvme_cid()
  nvme: add KConfig options for debug features

 drivers/nvme/host/Kconfig | 10 ++++++++++
 drivers/nvme/host/core.c  |  3 ---
 drivers/nvme/host/nvme.h  | 31 +++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.29.0

Test Log :-

root@dev nvme (nvme-5.16) # ./compile_nvme.sh 
+ umount /mnt/nvme0n1
+ clear_dmesg
./compile_nvme.sh: line 3: clear_dmesg: command not found
umount: /mnt/nvme0n1: no mount point specified.
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
+ make -j 48 M=drivers/nvme/ modules
  MODPOST drivers/nvme/Module.symvers
  CC [M]  drivers/nvme/host/nvme-core.mod.o
  CC [M]  drivers/nvme/host/nvme-fabrics.mod.o
  CC [M]  drivers/nvme/host/nvme-fc.mod.o
  CC [M]  drivers/nvme/host/nvme-rdma.mod.o
  CC [M]  drivers/nvme/host/nvme-tcp.mod.o
  CC [M]  drivers/nvme/host/nvme.mod.o
  CC [M]  drivers/nvme/target/nvme-fcloop.mod.o
  CC [M]  drivers/nvme/target/nvme-loop.mod.o
  CC [M]  drivers/nvme/target/nvmet-fc.mod.o
  CC [M]  drivers/nvme/target/nvmet-rdma.mod.o
  CC [M]  drivers/nvme/target/nvmet-tcp.mod.o
  CC [M]  drivers/nvme/target/nvmet.mod.o
  LD [M]  drivers/nvme/host/nvme-rdma.ko
  LD [M]  drivers/nvme/host/nvme-core.ko
  LD [M]  drivers/nvme/host/nvme-fc.ko
  LD [M]  drivers/nvme/target/nvme-loop.ko
  LD [M]  drivers/nvme/target/nvmet.ko
  LD [M]  drivers/nvme/target/nvmet-rdma.ko
  LD [M]  drivers/nvme/host/nvme-tcp.ko
  LD [M]  drivers/nvme/target/nvme-fcloop.ko
  LD [M]  drivers/nvme/target/nvmet-fc.ko
  LD [M]  drivers/nvme/target/nvmet-tcp.ko
  LD [M]  drivers/nvme/host/nvme-fabrics.ko
  LD [M]  drivers/nvme/host/nvme.ko
  BTF [M] drivers/nvme/target/nvme-loop.ko
  BTF [M] drivers/nvme/host/nvme-rdma.ko
  BTF [M] drivers/nvme/target/nvme-fcloop.ko
  BTF [M] drivers/nvme/host/nvme-fabrics.ko
  BTF [M] drivers/nvme/target/nvmet-rdma.ko
  BTF [M] drivers/nvme/target/nvmet-tcp.ko
  BTF [M] drivers/nvme/host/nvme.ko
  BTF [M] drivers/nvme/host/nvme-tcp.ko
  BTF [M] drivers/nvme/target/nvmet-fc.ko
  BTF [M] drivers/nvme/host/nvme-fc.ko
  BTF [M] drivers/nvme/host/nvme-core.ko
  BTF [M] drivers/nvme/target/nvmet.ko
+ HOST=drivers/nvme/host
+ TARGET=drivers/nvme/target
++ uname -r
+ HOST_DEST=/lib/modules/5.16.0-rc1nvme+/kernel/drivers/nvme/host/
++ uname -r
+ TARGET_DEST=/lib/modules/5.16.0-rc1nvme+/kernel/drivers/nvme/target/
+ cp drivers/nvme/host/nvme-core.ko drivers/nvme/host/nvme-fabrics.ko drivers/nvme/host/nvme-fc.ko drivers/nvme/host/nvme.ko drivers/nvme/host/nvme-rdma.ko drivers/nvme/host/nvme-tcp.ko /lib/modules/5.16.0-rc1nvme+/kernel/drivers/nvme/host//
+ cp drivers/nvme/target/nvme-fcloop.ko drivers/nvme/target/nvme-loop.ko drivers/nvme/target/nvmet-fc.ko drivers/nvme/target/nvmet.ko drivers/nvme/target/nvmet-rdma.ko drivers/nvme/target/nvmet-tcp.ko /lib/modules/5.16.0-rc1nvme+/kernel/drivers/nvme/target//
+ ls -lrth /lib/modules/5.16.0-rc1nvme+/kernel/drivers/nvme/host/ /lib/modules/5.16.0-rc1nvme+/kernel/drivers/nvme/target//
/lib/modules/5.16.0-rc1nvme+/kernel/drivers/nvme/host/:
total 6.6M
-rw-r--r--. 1 root root  2.7M Dec 10 01:49 nvme-core.ko
-rw-r--r--. 1 root root  446K Dec 10 01:49 nvme-fabrics.ko
-rw-r--r--. 1 root root  964K Dec 10 01:49 nvme-fc.ko
-rw-r--r--. 1 root root  732K Dec 10 01:49 nvme.ko
-rw-r--r--. 1 root root 1019K Dec 10 01:49 nvme-rdma.ko
-rw-r--r--. 1 root root  893K Dec 10 01:49 nvme-tcp.ko

/lib/modules/5.16.0-rc1nvme+/kernel/drivers/nvme/target//:
total 6.7M
-rw-r--r--. 1 root root 498K Dec 10 01:49 nvme-fcloop.ko
-rw-r--r--. 1 root root 435K Dec 10 01:49 nvme-loop.ko
-rw-r--r--. 1 root root 767K Dec 10 01:49 nvmet-fc.ko
-rw-r--r--. 1 root root 3.3M Dec 10 01:49 nvmet.ko
-rw-r--r--. 1 root root 992K Dec 10 01:49 nvmet-rdma.ko
-rw-r--r--. 1 root root 768K Dec 10 01:49 nvmet-tcp.ko
+ modprobe nvme
root@dev nvme (nvme-5.16) # grep NVME_DEBUG .config
# CONFIG_NVME_DEBUG_USE_CID_GENCTR is not set
(reverse-i-search)`for': mv 0001-nvme-code-command_id-with-a-genctr-^Cr-use-after-fre.patch  sagi-genctr.patch
root@dev nvme (nvme-5.16) # ./passthru_config.sh /dev/nvme0
umount: /mnt/nvme0n1: no mount point specified.
+ mkdir /sys/kernel/config/nvmet/subsystems/pt-nqn
+ sleep 1
+ echo 'Initializing passthru ctrl path ...'
Initializing passthru ctrl path ...
+ echo -n /dev/nvme0
+ sleep 1
+ echo 1
+ echo 1
+ mkdir /sys/kernel/config/nvmet/ports/1/
+ sleep 1
+ echo -n loop
+ sleep 1
+ echo 'Connecting passthru ctrl to the port '
Connecting passthru ctrl to the port 
+ ln -s /sys/kernel/config/nvmet/subsystems/pt-nqn /sys/kernel/config/nvmet/ports/1/subsystems/
+ sleep 1
+ nvme connect -t loop -n pt-nqn
+ sleep 1
+ tr -s ' ' ' '
+ set +x
root@dev nvme (nvme-5.16) # for i in `seq 1 10`; do fio fio/randread.fio --filename=/dev/nvme1n1                                                                           --output=no-cid-genctr-${i}.fio; done
root@dev nvme (nvme-5.16) # makemnconfig 
configuration written to .config

*** End of the configuration.
*** Execute 'make' to start the build or try 'make help'.

root@dev nvme (nvme-5.16) # 
root@dev nvme (nvme-5.16) # 
root@dev nvme (nvme-5.16) # 
root@dev nvme (nvme-5.16) # 
root@dev nvme (nvme-5.16) # 
root@dev nvme (nvme-5.16) # ./kernel_compile.sh 
  DEPMOD  /lib/modules/5.16.0-rc1nvme+
sh ./arch/x86/boot/install.sh 5.16.0-rc1nvme+ \
	arch/x86/boot/bzImage System.map "/boot"
Generating grub configuration file ...
done
real	1m33.758s
user	4m54.633s
sys	1m50.129s
root@dev nvme (nvme-5.16) # reboot 
Connection to 192.168.0.46 closed by remote host.
Connection to 192.168.0.46 closed.
[neo@fedora ~]$ dev
root@192.168.0.46's password: 
Last login: Fri Dec 10 01:49:40 2021 from 192.168.0.63
root@dev ~ # cd nvme/
root@dev nvme (nvme-5.16) # ./compile_nvme.sh 
+ umount /mnt/nvme0n1
+ clear_dmesg
./compile_nvme.sh: line 3: clear_dmesg: command not found
umount: /mnt/nvme0n1: no mount point specified.
+ modprobe -r nvme-fabrics
+ modprobe -r nvme_loop
+ modprobe -r nvmet
+ modprobe -r nvme
+ sleep 1
+ modprobe -r nvme-core
+ lsmod
+ grep nvme
+ sleep 1
./+ git diff
+ sleep 1
++ nproc
+ make -j 48 M=drivers/nvme/ modules
  MODPOST drivers/nvme/Module.symvers
  CC [M]  drivers/nvme/host/nvme-core.mod.o
  CC [M]  drivers/nvme/host/nvme-fabrics.mod.o
  CC [M]  drivers/nvme/host/nvme-fc.mod.o
  CC [M]  drivers/nvme/host/nvme-rdma.mod.o
  CC [M]  drivers/nvme/host/nvme-tcp.mod.o
  CC [M]  drivers/nvme/host/nvme.mod.o
  CC [M]  drivers/nvme/target/nvme-fcloop.mod.o
  CC [M]  drivers/nvme/target/nvme-loop.mod.o
  CC [M]  drivers/nvme/target/nvmet-fc.mod.o
  CC [M]  drivers/nvme/target/nvmet-rdma.mod.o
  CC [M]  drivers/nvme/target/nvmet-tcp.mod.o
  CC [M]  drivers/nvme/target/nvmet.mod.o
  LD [M]  drivers/nvme/target/nvme-loop.ko
  LD [M]  drivers/nvme/target/nvmet.ko
  LD [M]  drivers/nvme/host/nvme.ko
  LD [M]  drivers/nvme/target/nvmet-rdma.ko
  LD [M]  drivers/nvme/host/nvme-rdma.ko
  LD [M]  drivers/nvme/host/nvme-tcp.ko
  LD [M]  drivers/nvme/host/nvme-core.ko
  LD [M]  drivers/nvme/target/nvmet-fc.ko
  LD [M]  drivers/nvme/target/nvmet-tcp.ko
  LD [M]  drivers/nvme/host/nvme-fabrics.ko
  LD [M]  drivers/nvme/host/nvme-fc.ko
  BTF [M] drivers/nvme/target/nvme-loop.ko
  LD [M]  drivers/nvme/target/nvme-fcloop.ko
  BTF [M] drivers/nvme/target/nvmet-rdma.ko
  BTF [M] drivers/nvme/host/nvme-fabrics.ko
  BTF [M] drivers/nvme/target/nvme-fcloop.ko
  BTF [M] drivers/nvme/host/nvme-rdma.ko
  BTF [M] drivers/nvme/host/nvme-tcp.ko
  BTF [M] drivers/nvme/target/nvmet-fc.ko
  BTF [M] drivers/nvme/target/nvmet-tcp.ko
  BTF [M] drivers/nvme/host/nvme.ko
  BTF [M] drivers/nvme/host/nvme-fc.ko
  BTF [M] drivers/nvme/target/nvmet.ko
  BTF [M] drivers/nvme/host/nvme-core.ko
+ HOST=drivers/nvme/host
+ TARGET=drivers/nvme/target
++ uname -r
+ HOST_DEST=/lib/modules/5.16.0-rc1nvme+/kernel/drivers/nvme/host/
++ uname -r
+ TARGET_DEST=/lib/modules/5.16.0-rc1nvme+/kernel/drivers/nvme/target/
+ cp drivers/nvme/host/nvme-core.ko drivers/nvme/host/nvme-fabrics.ko drivers/nvme/host/nvme-fc.ko drivers/nvme/host/nvme.ko drivers/nvme/host/nvme-rdma.ko drivers/nvme/host/nvme-tcp.ko /lib/modules/5.16.0-rc1nvme+/kernel/drivers/nvme/host//
+ cp drivers/nvme/target/nvme-fcloop.ko drivers/nvme/target/nvme-loop.ko drivers/nvme/target/nvmet-fc.ko drivers/nvme/target/nvmet.ko drivers/nvme/target/nvmet-rdma.ko drivers/nvme/target/nvmet-tcp.ko /lib/modules/5.16.0-rc1nvme+/kernel/drivers/nvme/target//
+ ls -lrth /lib/modules/5.16.0-rc1nvme+/kernel/drivers/nvme/host/ /lib/modules/5.16.0-rc1nvme+/kernel/drivers/nvme/target//
/lib/modules/5.16.0-rc1nvme+/kernel/drivers/nvme/host/:
total 6.6M
-rw-r--r--. 1 root root  2.7M Dec 10 02:17 nvme-core.ko
-rw-r--r--. 1 root root  446K Dec 10 02:17 nvme-fabrics.ko
-rw-r--r--. 1 root root  964K Dec 10 02:17 nvme-fc.ko
-rw-r--r--. 1 root root  732K Dec 10 02:17 nvme.ko
-rw-r--r--. 1 root root 1019K Dec 10 02:17 nvme-rdma.ko
-rw-r--r--. 1 root root  897K Dec 10 02:17 nvme-tcp.ko

/lib/modules/5.16.0-rc1nvme+/kernel/drivers/nvme/target//:
total 6.7M
-rw-r--r--. 1 root root 498K Dec 10 02:17 nvme-fcloop.ko
-rw-r--r--. 1 root root 436K Dec 10 02:17 nvme-loop.ko
-rw-r--r--. 1 root root 767K Dec 10 02:17 nvmet-fc.ko
-rw-r--r--. 1 root root 3.3M Dec 10 02:17 nvmet.ko
-rw-r--r--. 1 root root 992K Dec 10 02:17 nvmet-rdma.ko
-rw-r--r--. 1 root root 768K Dec 10 02:17 nvmet-tcp.ko
+ modprobe nvme
root@dev nvme (nvme-5.16) # ./passthru_config.sh /dev/nvme0
umount: /mnt/nvme0n1: no mount point specified.
+ mkdir /sys/kernel/config/nvmet/subsystems/pt-nqn
+ sleep 1
+ echo 'Initializing passthru ctrl path ...'
Initializing passthru ctrl path ...
+ echo -n /dev/nvme0
+ sleep 1
+ echo 1
+ echo 1
+ mkdir /sys/kernel/config/nvmet/ports/1/
+ sleep 1
+ echo -n loop
+ sleep 1
+ echo 'Connecting passthru ctrl to the port '
Connecting passthru ctrl to the port 
+ ln -s /sys/kernel/config/nvmet/subsystems/pt-nqn /sys/kernel/config/nvmet/ports/1/subsystems/
+ sleep 1
+ nvme connect -t loop -n pt-nqn
+ sleep 1
root@dev nvme (nvme-5.16) # grep NVME_DEBUG .config
CONFIG_NVME_DEBUG_USE_CID_GENCTR=y
root@dev nvme (nvme-5.16) # for i in `seq 1 10`; do fio fio/randread.fio --filename=/dev/nvme1n1                                                                           --output=yes-cid-genctr-${i}.fio; done
root@dev nvme (nvme-5.16) # .0%][r=297MiB/s][r=76.0k IOPS][eta 00m:00s]
root@dev nvme (nvme-5.16) # 
root@dev nvme (nvme-5.16) # 
root@dev nvme (nvme-5.16) # 
root@dev nvme (nvme-5.16) # grep slat yes*genctr* | awk '{print $6}' | cut -f 2 -d '=' | cut -f1 -d ','
5057.99
7434.15
6310.50
8083.82
7297.77
6003.77
6657.75
6745.34
root@dev nvme (nvme-5.16) # grep slat no*genctr* | awk '{print $6}' | cut -f 2 -d '=' | cut -f1 -d ','
3859.20
4669.78
3778.51
8436.18
5653.83
5286.60
4176.05
4385.19
root@dev nvme (nvme-5.16) # sum=0;for i in `grep slat yes-cid-genctr-* | awk '{print $6}' | cut -f 2 -d '=' | cut -f1 -d ','| cut -f 1 -d '.'`; do let sum=sum+$i; done ; echo $sum/8|bc
6698
root@dev nvme (nvme-5.16) # sum=0;for i in `grep slat no-cid-genctr-* | awk '{print $6}' | cut -f 2 -d '=' | cut -f1 -d ','| cut -f 1 -d '.'`; do let sum=sum+$i; done ; echo $sum/8|bc
5030
root@dev nvme (nvme-5.16) # 


