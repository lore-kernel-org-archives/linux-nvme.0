Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4AFC433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 02:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9+T+L4v4CZCtJN4ApdKRgDpqdVQzIQcmiWMqy31diN4=; b=gV6qCWtSVDs7L8zyTMA/YT+M4M
	DaS3MM3OpceBcOzsYQXMAWW9zzH83gKVvXbP3YOd5Fr65ITgvAqMrVaUMrFql+tbbk9SFffIRo/fM
	mX8lBPz8KCX55KCuVtUu8O0pylaEECoNkkCAi5RrO9zGaj4XbWmVcW6waBe8DCfRNkBOEgEeE+jQR
	BiYgNr58TjLYv4znLUP7xjLlDjBiBr962dt7ewcXXdqc2ezVd7L/rw9a0gVNB9OonlTotc7LSoejM
	xVpbE93sQ+tGn2Bq5AYj4Zt04JR5SBAbP14b9IfB8qB421ooSS+2SZ5SUJEILOCv/IbXo2kSh+Jgn
	f/v42aBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncem9-00Ehlu-3y; Fri, 08 Apr 2022 02:55:05 +0000
Received: from mail-mw2nam12on2061e.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::61e]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncem2-00Ehje-1I
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 02:55:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhS0trNmSoCWpLaAt0oNoN5a7aywALL9uZM3exbT3IQKYVm+kqJi3O92bPVzfNOzrfZD7n8PiTTLPiw6kSUpo7+LEFfBuoImh1LuFu8iATdYg+8SmuwG3LRWuPQs2bLFroOKHdHtC4BWEkIqUff0KTJnN1XYJRKOQYiO7bsbLmMGneOi6cm+3Oem+hXrFNio0nDpYN6IlkEOqkcr/+etCKQZBUqNOYtoQcW8emP1tUMVm1E/fUXNfi8+zo+7QOeVluz/JGXgbd+rC1O81qmUuF/iKKs/7hqoLMfhOEfmVVbhSsmnSc4AeKGUVFpdmAln31vBObbSrZ4Z8NcmuHsvSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+T+L4v4CZCtJN4ApdKRgDpqdVQzIQcmiWMqy31diN4=;
 b=Iwr5UrJbBxV25E9bgf7B7ly1iwwWLhmVAC9998cgvkqaJRdkPekd1sAlFrWOd9VpskDj/GCYki8T33z9EssqGDwSt1LwaaP0IWcqGWeeUq6AMl1N3VsmWE+nRTlzybPE9GK5L0RAGiZfKmWS5021bg/3UiObLcxFcBrRUpmroqoOWn9+EXL4OPyEuq565giS+BNpPsvpGOhXlwwl+5LNaeBwLW5uX7UK73iY+/O4dCBgFVzrULGAzCnKXg90Ys6YRkxvCbcbsm+MoJxxj8YsaOvyddQLM+ZXNyzJ4cNxnnbBX9gEGcFVOihvr/S+Vw1f8kADjM5NprK/ypK8x7kDAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+T+L4v4CZCtJN4ApdKRgDpqdVQzIQcmiWMqy31diN4=;
 b=eXqyq17AuMEBq+H1heXEHJhDwZdJHs4snnFhstLR9zjPQrb/fTwsN/pNglp6g4HGvKPXoRpWIAX8aVnlN+pcC0EO7KKgdexAlmX7qlFo6Hqra718xiwf9TsiXwqhrPykf5BYDzbQFHPEMxaPpYMs5p/D8HddDy5f6eiDkZ/iwyPA105r9ZdyotS67nUVcdjKEr3vHHZ8s/JrceDeA2oe6lz0iQA3Lqzgj2b9rNTcF4j49jH4GrsjN1LOampv3OboOwkRxsbEeAD6OnOgE9fM4QNqp7r+m9PAXQW/i/uDZ7vl6wn4GkRCVx+ljW0mrLZAG6DmNbPW/4bfYZIzzLd+mw==
Received: from DM6PR05CA0045.namprd05.prod.outlook.com (2603:10b6:5:335::14)
 by DM5PR12MB2551.namprd12.prod.outlook.com (2603:10b6:4:b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 02:39:42 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::3b) by DM6PR05CA0045.outlook.office365.com
 (2603:10b6:5:335::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21 via Frontend
 Transport; Fri, 8 Apr 2022 02:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 02:39:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Fri, 8 Apr 2022 02:39:41 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 7 Apr 2022
 19:39:39 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/2] nvmet: handle missing cns and csi values
Date: Thu, 7 Apr 2022 19:39:28 -0700
Message-ID: <20220408023930.85774-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47f3a3b2-e2ef-494f-8cbf-08da19090909
X-MS-TrafficTypeDiagnostic: DM5PR12MB2551:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2551CC483C84CC42353CFF98A3E99@DM5PR12MB2551.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RmJshj187c3VRq7pxAWtiqacJ91RsBPcBuN23X+VVeVPEARCNVLkNT/NgKAP+V4+nGfcBjzad1GX4NGGuXThZR+EoDHWbmXNmjzDfb+ZcFWrT2uCcQMRX8qNAEAU9tB3888jwcZ3T7Xs2kCp92zXR/ZXSl0umK4vDHVo+aGTLezrCD0yGZ7Gj88tdOnX7FldF/24/RiEFcZaDlSf0371kEI7qlvd3fex+urO0qrKPyRegf2X2U9ukZbrCe2zCW4T9Q0IbwR8bEYGVSO+W2DY8NRbx64zWydt3FDGhjl5KArrzU6tdpdmJwoV1d8k6DDIxfodclDLYPTi+UkNPMzxU23M3W8EGN1HTtv6j3agqvFD/g/Scv0ZJm/FVZEtDoeP/FJG5hztSpkHCUaYTPsgX14yGx1pO/w7zLO8K4vvUSYChc5OgrtErpuTjZlR31eOu9P+ZcVus+YjZ/pkZfz6wJOkt2w2Ckkc/JTmKme4olK1TkCA3qtVse2OXK+nYk0iPBn9/YsBLacuDSDV/oZgZgxnwL33kjQMpLT39lbzPPw7sYbAVehblymLiyCF+hW6Ae7fk5vvkqcDh5jC6xZmkEN4n9aiXNZB8oWa1NCo8M7JJwLiNHVhHGqG0QgoBhk8xzbp7+iij7PnLIysiEUxUDjNGtsmsFgi6PTb+Ven8twDUb70HcXFWlalY70DShhzrHbvdFgZ5Nn6okFNryDT1Q==
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(30864003)(426003)(83380400001)(36860700001)(47076005)(508600001)(26005)(2906002)(5660300002)(16526019)(36756003)(186003)(82310400005)(8936002)(70206006)(7696005)(8676002)(107886003)(4326008)(6916009)(54906003)(70586007)(2616005)(316002)(1076003)(81166007)(6666004)(356005)(40460700003)(36900700001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 02:39:42.1648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f3a3b2-e2ef-494f-8cbf-08da19090909
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2551
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_195458_189745_F240AE4C 
X-CRM114-Status: GOOD (  14.37  )
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

Hi,

This handles missing identify command cns and csi values for target
admin command and discovery admin command. This was reported by the
block test with addition of the new nvme_log_error() on the host side, 

This patch series fixes the error report in the block test.

See below for the detailed test log with and without this fix.

-ck


Chaitanya Kulkarni (2):
  nvmet: handle admin default command set identifier
  nvmet: handle disc default command set identifier

 drivers/nvme/target/admin-cmd.c | 7 +++++++
 drivers/nvme/target/discovery.c | 6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

* With this patch series :-

nvme (nvme-5.18) # git log -2 
commit 26c29e8bbc2b6e39a76f5d454522f055712ba51f (HEAD -> nvme-5.18)
Author: Chaitanya Kulkarni <kch@nvidia.com>
Date:   Thu Apr 7 12:21:41 2022 -0700

    nvmet: handle disc default command set identifier
    
    Similar to previous patch handle identify command cns value
    NVME_ID_CNS_CS_CTRL when executing nvme_admin_identify for discovery
    controller.
    
    This is needed to mask out the errors reported by the blktests.
    
    Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

commit 62ee22fcdcfc6f06bd2f5fc83210c1392f7d85f1
Author: Chaitanya Kulkarni <kch@nvidia.com>
Date:   Thu Apr 7 12:11:37 2022 -0700

    nvmet: handle admin default command set identifier
    
    The NVMeOF in kernel host when configuring non-mdts limits sets
    idnetify controller cns value to NVME_ID_CNS_CS_CTRL and csi value to
    NVME_CSI_NVM. In target code we don't handle that case.
    
    Handle missing case for CONFIG_BLK_DEV_ZONED and !CONFIG_BLK_DEV_ZONED.
    
    This is needed to mask out the errors reported by the blktests.
nvme (nvme-5.18) # 
nvme (nvme-5.18) # ./compile_nvme.sh 
+ umount /mnt/nvme0n1
+ clear_dmesg
./compile_nvme.sh: line 3: clear_dmesg: command not found
umount: /mnt/nvme0n1: no mount point specified.
+ ./delete.sh
+ NQN=testnqn
+ nvme disconnect -n testnqn
NQN:testnqn disconnected 0 controller(s)

real	0m0.010s
user	0m0.000s
sys	0m0.005s
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
cdb+ modprobe -r nvme-core
+ lsmod
+ grep nvme
+ sleep 1
lktest	
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
  LD [M]  drivers/nvme/target/nvme-loop.o
  LD [M]  drivers/nvme/target/nvme-fcloop.o
  LD [M]  drivers/nvme/target/nvmet.o
  LD [M]  drivers/nvme/target/nvmet-fc.o
  LD [M]  drivers/nvme/target/nvmet-tcp.o
  LD [M]  drivers/nvme/target/nvmet-rdma.o
  MODPOST drivers/nvme/Module.symvers
  CC [M]  drivers/nvme/target/nvme-fcloop.mod.o
  CC [M]  drivers/nvme/target/nvme-loop.mod.o
  CC [M]  drivers/nvme/target/nvmet-fc.mod.o
  CC [M]  drivers/nvme/target/nvmet-rdma.mod.o
  CC [M]  drivers/nvme/target/nvmet-tcp.mod.o
  CC [M]  drivers/nvme/target/nvmet.mod.o
  LD [M]  drivers/nvme/target/nvmet-fc.ko
  LD [M]  drivers/nvme/target/nvmet-rdma.ko
  LD [M]  drivers/nvme/target/nvme-loop.ko
  LD [M]  drivers/nvme/target/nvmet-tcp.ko
  LD [M]  drivers/nvme/target/nvme-fcloop.ko
  LD [M]  drivers/nvme/target/nvmet.ko
+ HOST=drivers/nvme/host
+ TARGET=drivers/nvme/target
++ uname -r
+ HOST_DEST=/lib/modules/5.17.0-rc2nvme+/kernel/drivers/nvme/host/
++ uname -r
+ TARGET_DEST=/lib/modules/5.17.0-rc2nvme+/kernel/drivers/nvme/target/
+ cp drivers/nvme/host/nvme-core.ko drivers/nvme/host/nvme-fabrics.ko drivers/nvme/host/nvme-fc.ko drivers/nvme/host/nvme.ko drivers/nvme/host/nvme-rdma.ko drivers/nvme/host/nvme-tcp.ko /lib/modules/5.17.0-rc2nvme+/kernel/drivers/nvme/host//
+ cp drivers/nvme/target/nvme-fcloop.ko drivers/nvme/target/nvme-loop.ko drivers/nvme/target/nvmet-fc.ko drivers/nvme/target/nvmet.ko drivers/nvme/target/nvmet-rdma.ko drivers/nvme/target/nvmet-tcp.ko /lib/modules/5.17.0-rc2nvme+/kernel/drivers/nvme/target//
+ ls -lrth /lib/modules/5.17.0-rc2nvme+/kernel/drivers/nvme/host/ /lib/modules/5.17.0-rc2nvme+/kernel/drivers/nvme/target//
/lib/modules/5.17.0-rc2nvme+/kernel/drivers/nvme/host/:
total 6.1M
-rw-r--r--. 1 root root 2.4M Apr  7 12:29 nvme-core.ko
-rw-r--r--. 1 root root 425K Apr  7 12:29 nvme-fabrics.ko
-rw-r--r--. 1 root root 923K Apr  7 12:29 nvme-fc.ko
-rw-r--r--. 1 root root 712K Apr  7 12:29 nvme.ko
-rw-r--r--. 1 root root 854K Apr  7 12:29 nvme-rdma.ko
-rw-r--r--. 1 root root 795K Apr  7 12:29 nvme-tcp.ko

/lib/modules/5.17.0-rc2nvme+/kernel/drivers/nvme/target//:
total 6.3M
-rw-r--r--. 1 root root 474K Apr  7 12:29 nvme-fcloop.ko
-rw-r--r--. 1 root root 417K Apr  7 12:29 nvme-loop.ko
-rw-r--r--. 1 root root 734K Apr  7 12:29 nvmet-fc.ko
-rw-r--r--. 1 root root 3.2M Apr  7 12:29 nvmet.ko
-rw-r--r--. 1 root root 822K Apr  7 12:29 nvmet-rdma.ko
-rw-r--r--. 1 root root 671K Apr  7 12:29 nvmet-tcp.ko
+ sync
+ sync
+ sync
+ modprobe nvme
nvme (nvme-5.18) # cdblktests 
blktests (master) # ./check nvme
nvme/002 (create many subsystems and test discovery)        
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  17.793s  ...  17.434s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.077s  ...  10.077s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.442s  ...  1.436s
nvme/005 (reset local loopback target)                       [passed]
    runtime  6.793s  ...  6.773s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.088s  ...  0.062s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.038s  ...  0.032s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.441s  ...  1.460s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.405s  ...  1.426s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  8.070s  ...  7.828s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  84.276s  ...  76.328s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  11.179s  ...  11.394s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  78.403s  ...  80.557s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  8.949s  ...  8.886s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  8.609s  ...  8.581s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  10.945s  ...  10.696s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  10.876s  ...  10.747s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.416s  ...  1.416s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.452s  ...  1.678s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.416s  ...  1.596s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.417s  ...  1.487s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  6.724s  ...  6.876s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.439s  ...  1.455s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.411s  ...  1.433s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.406s  ...  1.413s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.415s  ...  1.413s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.427s  ...  1.425s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.410s  ...  1.405s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.542s  ...  1.550s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.194s  ...  0.186s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  53.865s  ...  53.838s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.019s  ...  0.019s
blktests (master) # dmesg -c 
[   52.382953] run blktests nvme/002 at 2022-04-07 12:29:53
[   52.423691] loop: module loaded
[   52.427716] nvmet: adding nsid 1 to subsystem blktests-subsystem-0
[   52.432898] nvmet: adding nsid 1 to subsystem blktests-subsystem-1

<----------------------------------SNIP----------------------------------------->

[   56.160725] nvmet: adding nsid 1 to subsystem blktests-subsystem-998
[   56.164582] nvmet: adding nsid 1 to subsystem blktests-subsystem-999
[   56.173346] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
[   56.173417] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[   56.305088] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   69.923689] run blktests nvme/003 at 2022-04-07 12:30:10
[   69.950245] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   69.956495] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
[   69.956629] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[   79.975799] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   80.090939] run blktests nvme/004 at 2022-04-07 12:30:21
[   80.115832] loop0: detected capacity change from 0 to 2097152
[   80.127129] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   80.133045] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[   80.133169] nvme nvme1: creating 48 I/O queues.
[   80.136269] nvme nvme1: new ctrl: "blktests-subsystem-1"
[   81.160620] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[   81.625071] run blktests nvme/005 at 2022-04-07 12:30:22
[   81.647047] loop0: detected capacity change from 0 to 2097152
[   81.658587] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   81.673742] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[   81.673839] nvme nvme1: creating 48 I/O queues.
[   81.676956] nvme nvme1: new ctrl: "blktests-subsystem-1"
[   83.025471] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[   83.025531] nvme nvme1: creating 48 I/O queues.
[   88.033480] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[   88.490478] run blktests nvme/006 at 2022-04-07 12:30:29
[   88.513576] loop0: detected capacity change from 0 to 2097152
[   88.524221] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   88.653124] run blktests nvme/007 at 2022-04-07 12:30:29
[   88.675309] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   88.777684] run blktests nvme/008 at 2022-04-07 12:30:29
[   88.799158] loop0: detected capacity change from 0 to 2097152
[   88.814861] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   88.835969] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[   88.836096] nvme nvme1: creating 48 I/O queues.
[   88.839378] nvme nvme1: new ctrl: "blktests-subsystem-1"
[   89.877694] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[   90.327823] run blktests nvme/009 at 2022-04-07 12:30:31
[   90.348076] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   90.356188] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[   90.356289] nvme nvme1: creating 48 I/O queues.
[   90.359460] nvme nvme1: new ctrl: "blktests-subsystem-1"
[   91.398781] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[   91.934803] run blktests nvme/010 at 2022-04-07 12:30:32
[   91.958826] loop0: detected capacity change from 0 to 2097152
[   91.973891] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   91.995090] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[   91.995205] nvme nvme1: creating 48 I/O queues.
[   91.998393] nvme nvme1: new ctrl: "blktests-subsystem-1"
[   99.272748] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[   99.926076] run blktests nvme/011 at 2022-04-07 12:30:40
[   99.947783] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   99.956285] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[   99.956409] nvme nvme1: creating 48 I/O queues.
[   99.959837] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  175.909165] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  179.161840] run blktests nvme/012 at 2022-04-07 12:32:00
[  179.186991] loop0: detected capacity change from 0 to 2097152
[  179.199407] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  179.207708] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  179.207799] nvme nvme1: creating 48 I/O queues.
[  179.211028] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  180.260783] XFS (nvme1n1): Mounting V5 Filesystem
[  180.264189] XFS (nvme1n1): Ending clean mount
[  180.264563] xfs filesystem being mounted at /mnt/blktests supports timestamps until 2038 (0x7fffffff)
[  190.058507] XFS (nvme1n1): Unmounting Filesystem
[  190.076972] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  190.721064] run blktests nvme/013 at 2022-04-07 12:32:11
[  190.741655] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  190.750888] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  190.750985] nvme nvme1: creating 48 I/O queues.
[  190.754316] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  191.834886] XFS (nvme1n1): Mounting V5 Filesystem
[  191.845092] XFS (nvme1n1): Ending clean mount
[  191.847768] xfs filesystem being mounted at /mnt/blktests supports timestamps until 2038 (0x7fffffff)
[  270.907359] XFS (nvme1n1): Unmounting Filesystem
[  270.918134] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  274.335949] run blktests nvme/014 at 2022-04-07 12:33:35
[  274.358367] loop0: detected capacity change from 0 to 2097152
[  274.376215] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  274.384763] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  274.384895] nvme nvme1: creating 48 I/O queues.
[  274.388815] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  277.020134] nvme nvme1: using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!
[  282.808303] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  283.316653] run blktests nvme/015 at 2022-04-07 12:33:44
[  283.338275] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  283.347287] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  283.347382] nvme nvme1: creating 48 I/O queues.
[  283.350604] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  291.541413] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  291.996219] run blktests nvme/016 at 2022-04-07 12:33:52
[  292.017890] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  292.019570] nvmet: adding nsid 2 to subsystem blktests-subsystem-1
[  292.021034] nvmet: adding nsid 3 to subsystem blktests-subsystem-1

<----------------------------------SNIP----------------------------------------->

[  293.393454] nvmet: adding nsid 998 to subsystem blktests-subsystem-1
[  293.394835] nvmet: adding nsid 999 to subsystem blktests-subsystem-1
[  293.396160] nvmet: adding nsid 1000 to subsystem blktests-subsystem-1
[  293.404489] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
[  293.404557] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[  293.404950] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  302.789832] run blktests nvme/017 at 2022-04-07 12:34:03
[  302.811221] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  302.812528] nvmet: adding nsid 2 to subsystem blktests-subsystem-1

<----------------------------------SNIP----------------------------------------->

[  304.198262] nvmet: adding nsid 998 to subsystem blktests-subsystem-1
[  304.199618] nvmet: adding nsid 999 to subsystem blktests-subsystem-1
[  304.201085] nvmet: adding nsid 1000 to subsystem blktests-subsystem-1
[  304.209808] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
[  304.209910] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[  304.210323] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  313.651899] run blktests nvme/018 at 2022-04-07 12:34:14
[  313.673384] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  313.683449] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  313.683548] nvme nvme1: creating 48 I/O queues.
[  313.687066] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  314.714070] nvme1c1n1: Read(0x2) @ LBA 2305843009213693951, 1 blocks, Capacity Exceeded (sct 0x0 / sc 0x81) MORE DNR 
[  314.719261] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  315.170084] run blktests nvme/019 at 2022-04-07 12:34:16
[  315.189946] loop0: detected capacity change from 0 to 2097152
[  315.199829] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  315.207939] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  315.208032] nvme nvme1: creating 48 I/O queues.
[  315.211397] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  316.233522] nvme nvme1: using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!
[  316.236802] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  316.978713] run blktests nvme/020 at 2022-04-07 12:34:17
[  317.007054] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  317.016861] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  317.016964] nvme nvme1: creating 48 I/O queues.
[  317.020382] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  318.045265] nvme nvme1: using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!
[  318.048258] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  318.677335] run blktests nvme/021 at 2022-04-07 12:34:19
[  318.698344] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  318.706944] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  318.707037] nvme nvme1: creating 48 I/O queues.
[  318.710246] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  319.736855] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  320.270447] run blktests nvme/022 at 2022-04-07 12:34:21
[  320.292460] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  320.301206] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  320.301310] nvme nvme1: creating 48 I/O queues.
[  320.304753] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  321.328180] nvme nvme1: resetting controller
[  321.755851] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  321.755917] nvme nvme1: creating 48 I/O queues.
[  326.763074] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  327.259920] run blktests nvme/023 at 2022-04-07 12:34:28
[  327.280230] loop0: detected capacity change from 0 to 2097152
[  327.290502] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  327.298775] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  327.298867] nvme nvme1: creating 48 I/O queues.
[  327.302088] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  328.326763] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  328.818522] run blktests nvme/024 at 2022-04-07 12:34:29
[  328.840347] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  328.848981] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  328.849074] nvme nvme1: creating 48 I/O queues.
[  328.852670] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  329.877208] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  330.360269] run blktests nvme/025 at 2022-04-07 12:34:31
[  330.381769] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  330.390112] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  330.390225] nvme nvme1: creating 48 I/O queues.
[  330.393422] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  331.418391] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  331.874566] run blktests nvme/026 at 2022-04-07 12:34:32
[  331.901278] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  331.909423] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  331.909534] nvme nvme1: creating 48 I/O queues.
[  331.912836] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  332.937828] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  333.390110] run blktests nvme/027 at 2022-04-07 12:34:34
[  333.412455] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  333.420601] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  333.420697] nvme nvme1: creating 48 I/O queues.
[  333.424078] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  334.449171] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  334.923659] run blktests nvme/028 at 2022-04-07 12:34:35
[  334.947879] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  334.956177] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  334.956302] nvme nvme1: creating 48 I/O queues.
[  334.960082] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  335.987002] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  336.431339] run blktests nvme/029 at 2022-04-07 12:34:37
[  336.452889] loop0: detected capacity change from 0 to 2097152
[  336.466868] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  336.488138] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  336.488230] nvme nvme1: creating 48 I/O queues.
[  336.491527] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  337.605367] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  338.083300] run blktests nvme/030 at 2022-04-07 12:34:39
[  338.109578] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  338.116864] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
[  338.116943] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[  338.117375] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  338.143740] nvmet: adding nsid 1 to subsystem blktests-subsystem-2
[  338.150602] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
[  338.150678] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[  338.151034] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  338.173819] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
[  338.173891] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[  338.174271] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  338.197601] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
[  338.197668] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[  338.198033] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  338.243041] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
[  338.243122] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[  338.243525] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  338.377741] run blktests nvme/031 at 2022-04-07 12:34:39
[  338.399044] loop0: detected capacity change from 0 to 2097152
[  338.413685] nvmet: adding nsid 1 to subsystem blktests-subsystem-0
[  338.426024] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-0 for NQN testhostnqn.
[  338.426169] nvme nvme1: creating 48 I/O queues.
[  338.429501] nvme nvme1: new ctrl: "blktests-subsystem-0"
[  343.435059] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-0"
[  343.802195] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  343.807773] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  343.807863] nvme nvme1: creating 48 I/O queues.
[  343.811781] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  348.816567] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  349.182720] nvmet: adding nsid 1 to subsystem blktests-subsystem-2
[  349.188620] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-2 for NQN testhostnqn.
[  349.188713] nvme nvme1: creating 48 I/O queues.
[  349.192462] nvme nvme1: new ctrl: "blktests-subsystem-2"
[  354.197289] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-2"
[  354.556893] nvmet: adding nsid 1 to subsystem blktests-subsystem-3
[  354.562701] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-3 for NQN testhostnqn.
[  354.562795] nvme nvme1: creating 48 I/O queues.
[  354.566599] nvme nvme1: new ctrl: "blktests-subsystem-3"
[  359.571028] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-3"
[  359.954634] nvmet: adding nsid 1 to subsystem blktests-subsystem-4
[  359.960338] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-4 for NQN testhostnqn.
[  359.960426] nvme nvme1: creating 48 I/O queues.
[  359.963942] nvme nvme1: new ctrl: "blktests-subsystem-4"
[  364.968970] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-4"
[  365.326701] nvmet: adding nsid 1 to subsystem blktests-subsystem-5
[  365.332421] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-5 for NQN testhostnqn.
[  365.332505] nvme nvme1: creating 48 I/O queues.
[  365.336543] nvme nvme1: new ctrl: "blktests-subsystem-5"
[  370.341325] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-5"
[  370.699234] nvmet: adding nsid 1 to subsystem blktests-subsystem-6
[  370.706861] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-6 for NQN testhostnqn.
[  370.706952] nvme nvme1: creating 48 I/O queues.
[  370.711097] nvme nvme1: new ctrl: "blktests-subsystem-6"
[  375.715717] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-6"
[  376.078916] nvmet: adding nsid 1 to subsystem blktests-subsystem-7
[  376.084872] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-7 for NQN testhostnqn.
[  376.085035] nvme nvme1: creating 48 I/O queues.
[  376.089544] nvme nvme1: new ctrl: "blktests-subsystem-7"
[  381.094154] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-7"
[  381.458295] nvmet: adding nsid 1 to subsystem blktests-subsystem-8
[  381.464016] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-8 for NQN testhostnqn.
[  381.464104] nvme nvme1: creating 48 I/O queues.
[  381.467877] nvme nvme1: new ctrl: "blktests-subsystem-8"
[  386.472435] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-8"
[  386.836779] nvmet: adding nsid 1 to subsystem blktests-subsystem-9
[  386.842587] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-9 for NQN testhostnqn.
[  386.842696] nvme nvme1: creating 48 I/O queues.
[  386.846672] nvme nvme1: new ctrl: "blktests-subsystem-9"
[  391.851734] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-9"
[  392.358477] run blktests nvme/038 at 2022-04-07 12:35:33
blktests (master) # 
blktests (master) # 

* Without this patch series :-

nvme (nvme-5.18) # git reset HEAD~2 --hard 
HEAD is now at f8d08d519f57 nvmf: dno't duplicate the time out req completion
nvme (nvme-5.18) # ./compile_nvme.sh 
+ umount /mnt/nvme0n1
+ clear_dmesg
./compile_nvme.sh: line 3: clear_dmesg: command not found
umount: /mnt/nvme0n1: no mount point specified.
+ ./delete.sh
+ NQN=testnqn
+ nvme disconnect -n testnqn
NQN:testnqn disconnected 0 controller(s)

real	0m0.003s
user	0m0.000s
sys	0m0.002s
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
  LD [M]  drivers/nvme/target/nvme-loop.o
  LD [M]  drivers/nvme/target/nvme-fcloop.o
  LD [M]  drivers/nvme/target/nvmet.o
  LD [M]  drivers/nvme/target/nvmet-fc.o
  LD [M]  drivers/nvme/target/nvmet-tcp.o
  LD [M]  drivers/nvme/target/nvmet-rdma.o
  MODPOST drivers/nvme/Module.symvers
  CC [M]  drivers/nvme/target/nvme-fcloop.mod.o
  CC [M]  drivers/nvme/target/nvme-loop.mod.o
  CC [M]  drivers/nvme/target/nvmet-fc.mod.o
  CC [M]  drivers/nvme/target/nvmet-rdma.mod.o
  CC [M]  drivers/nvme/target/nvmet-tcp.mod.o
  CC [M]  drivers/nvme/target/nvmet.mod.o
  LD [M]  drivers/nvme/target/nvme-loop.ko
  LD [M]  drivers/nvme/target/nvme-fcloop.ko
  LD [M]  drivers/nvme/target/nvmet.ko
  LD [M]  drivers/nvme/target/nvmet-tcp.ko
  LD [M]  drivers/nvme/target/nvmet-fc.ko
  LD [M]  drivers/nvme/target/nvmet-rdma.ko
+ HOST=drivers/nvme/host
+ TARGET=drivers/nvme/target
++ uname -r
+ HOST_DEST=/lib/modules/5.17.0-rc2nvme+/kernel/drivers/nvme/host/
++ uname -r
+ TARGET_DEST=/lib/modules/5.17.0-rc2nvme+/kernel/drivers/nvme/target/
+ cp drivers/nvme/host/nvme-core.ko drivers/nvme/host/nvme-fabrics.ko drivers/nvme/host/nvme-fc.ko drivers/nvme/host/nvme.ko drivers/nvme/host/nvme-rdma.ko drivers/nvme/host/nvme-tcp.ko /lib/modules/5.17.0-rc2nvme+/kernel/drivers/nvme/host//
+ cp drivers/nvme/target/nvme-fcloop.ko drivers/nvme/target/nvme-loop.ko drivers/nvme/target/nvmet-fc.ko drivers/nvme/target/nvmet.ko drivers/nvme/target/nvmet-rdma.ko drivers/nvme/target/nvmet-tcp.ko /lib/modules/5.17.0-rc2nvme+/kernel/drivers/nvme/target//
+ ls -lrth /lib/modules/5.17.0-rc2nvme+/kernel/drivers/nvme/host/ /lib/modules/5.17.0-rc2nvme+/kernel/drivers/nvme/target//
/lib/modules/5.17.0-rc2nvme+/kernel/drivers/nvme/host/:
total 6.1M
-rw-r--r--. 1 root root 2.4M Apr  7 12:44 nvme-core.ko
-rw-r--r--. 1 root root 425K Apr  7 12:44 nvme-fabrics.ko
-rw-r--r--. 1 root root 923K Apr  7 12:44 nvme-fc.ko
-rw-r--r--. 1 root root 712K Apr  7 12:44 nvme.ko
-rw-r--r--. 1 root root 854K Apr  7 12:44 nvme-rdma.ko
-rw-r--r--. 1 root root 795K Apr  7 12:44 nvme-tcp.ko

/lib/modules/5.17.0-rc2nvme+/kernel/drivers/nvme/target//:
total 6.3M
-rw-r--r--. 1 root root 474K Apr  7 12:44 nvme-fcloop.ko
-rw-r--r--. 1 root root 417K Apr  7 12:44 nvme-loop.ko
-rw-r--r--. 1 root root 734K Apr  7 12:44 nvmet-fc.ko
-rw-r--r--. 1 root root 3.2M Apr  7 12:44 nvmet.ko
-rw-r--r--. 1 root root 822K Apr  7 12:44 nvmet-rdma.ko
-rw-r--r--. 1 root root 671K Apr  7 12:44 nvmet-tcp.ko
+ sync
+ sync
+ sync
+ modprobe nvme
nvme (nvme-5.18) # git log -2 
commit f8d08d519f57fa2b264fad37d46c4990865c6d3a (HEAD -> nvme-5.18)
Author: Chaitanya Kulkarni <kch@nvidia.com>
Date:   Tue Mar 29 15:56:22 2022 -0700

    nvmf: dno't duplicate the time out req completion
    
    The RDAMA and TCP transport both complete the timed out request in the
    same manner and hence code is duplicated. Add and use the helper
    nvmf_complete_timed_out_request() to remove the duplicate code.
    
    Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

commit 03f2f45b44eeb90b61b258f3db3fe977bbdb480f
Merge: 226d991feef9 a4a6f3c8f61c
Author: Chaitanya Kulkarni <kch@nvidia.com>
Date:   Tue Mar 29 15:43:23 2022 -0700

    Merge branch 'nvme-5.18' of git://git.infradead.org/nvme into nvme-5.18
nvme (nvme-5.18) # cdblk
linux-block (for-next) # cd -
/mnt/data/nvme
nvme (nvme-5.18) # cdblktests 
blktests (master) # ./check nvme 
nvme/002 (create many subsystems and test discovery)        
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  17.434s  ...  17.426s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.077s  ...  10.078s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.436s  ...  1.435s
nvme/005 (reset local loopback target)                       [passed]
    runtime  6.773s  ...  6.778s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.062s  ...  0.082s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.032s  ...  0.033s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.460s  ...  1.457s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.426s  ...  1.413s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  7.828s  ...  7.878s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  76.328s  ...  73.253s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  11.394s  ...  11.163s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  80.557s  ...  77.126s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  8.886s  ...  8.941s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  8.581s  ...  8.759s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  10.696s  ...  11.128s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  10.747s  ...  10.773s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.416s  ...  1.409s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.678s  ...  1.468s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.596s  ...  1.420s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.487s  ...  1.420s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  6.876s  ...  6.731s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.455s  ...  1.441s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.433s  ...  1.424s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.413s  ...  1.422s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.413s  ...  1.406s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.425s  ...  1.422s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.405s  ...  1.409s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.550s  ...  1.543s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.186s  ...  0.186s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  53.838s  ...  53.876s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.019s  ...  0.019s

[  932.787219] nvme nvme0: pci function 0000:00:04.0
[  932.824503] nvme nvme0: 48/0/0 default/read/poll queues
[  957.330536] run blktests nvme/002 at 2022-04-07 12:44:58
[  957.356065] nvmet: adding nsid 1 to subsystem blktests-subsystem-0

<----------------------------------SNIP----------------------------------------->

[  961.140652] nvmet: adding nsid 1 to subsystem blktests-subsystem-998
[  961.144563] nvmet: adding nsid 1 to subsystem blktests-subsystem-999
[  961.152609] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
[  961.152672] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[  961.154057] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[  961.295324] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  974.855542] run blktests nvme/003 at 2022-04-07 12:45:15
[  974.880493] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  974.886142] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
[  974.886213] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[  974.888553] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[  984.908071] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  985.029853] run blktests nvme/004 at 2022-04-07 12:45:26
[  985.051930] loop0: detected capacity change from 0 to 2097152
[  985.062047] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  985.067825] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  985.067916] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[  985.069576] nvme nvme1: creating 48 I/O queues.
[  985.072757] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  986.100616] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  986.557237] run blktests nvme/005 at 2022-04-07 12:45:27
[  986.579282] loop0: detected capacity change from 0 to 2097152
[  986.591425] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  986.609897] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  986.609983] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[  986.611631] nvme nvme1: creating 48 I/O queues.
[  986.614990] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  987.964464] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  987.964521] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[  987.965933] nvme nvme1: creating 48 I/O queues.
[  992.973759] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  993.424560] run blktests nvme/006 at 2022-04-07 12:45:34
[  993.443933] loop0: detected capacity change from 0 to 2097152
[  993.455357] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  993.592791] run blktests nvme/007 at 2022-04-07 12:45:34
[  993.613154] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  993.716336] run blktests nvme/008 at 2022-04-07 12:45:34
[  993.736418] loop0: detected capacity change from 0 to 2097152
[  993.749319] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  993.771113] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  993.771216] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[  993.772751] nvme nvme1: creating 48 I/O queues.
[  993.775953] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  994.815611] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  995.259523] run blktests nvme/009 at 2022-04-07 12:45:36
[  995.281576] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  995.289813] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  995.289897] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[  995.291325] nvme nvme1: creating 48 I/O queues.
[  995.294766] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  996.328451] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  996.834839] run blktests nvme/010 at 2022-04-07 12:45:37
[  996.854723] loop0: detected capacity change from 0 to 2097152
[  996.868084] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  996.886426] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[  996.886510] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[  996.888303] nvme nvme1: creating 48 I/O queues.
[  996.891657] nvme nvme1: new ctrl: "blktests-subsystem-1"
[ 1004.244125] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 1004.878469] run blktests nvme/011 at 2022-04-07 12:45:45
[ 1004.900125] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1004.908140] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[ 1004.908224] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1004.910466] nvme nvme1: creating 48 I/O queues.
[ 1004.913833] nvme nvme1: new ctrl: "blktests-subsystem-1"
[ 1077.790613] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 1081.092329] run blktests nvme/012 at 2022-04-07 12:47:02
[ 1081.113543] loop0: detected capacity change from 0 to 2097152
[ 1081.125067] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1081.132694] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[ 1081.132778] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1081.134844] nvme nvme1: creating 48 I/O queues.
[ 1081.138244] nvme nvme1: new ctrl: "blktests-subsystem-1"
[ 1082.187042] XFS (nvme1n1): Mounting V5 Filesystem
[ 1082.191233] XFS (nvme1n1): Ending clean mount
[ 1082.191583] xfs filesystem being mounted at /mnt/blktests supports timestamps until 2038 (0x7fffffff)
[ 1091.773894] XFS (nvme1n1): Unmounting Filesystem
[ 1091.792912] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 1092.417091] run blktests nvme/013 at 2022-04-07 12:47:13
[ 1092.439604] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1092.447535] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[ 1092.447618] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1092.451846] nvme nvme1: creating 48 I/O queues.
[ 1092.455408] nvme nvme1: new ctrl: "blktests-subsystem-1"
[ 1093.600543] XFS (nvme1n1): Mounting V5 Filesystem
[ 1093.610574] XFS (nvme1n1): Ending clean mount
[ 1093.613235] xfs filesystem being mounted at /mnt/blktests supports timestamps until 2038 (0x7fffffff)
[ 1169.170834] XFS (nvme1n1): Unmounting Filesystem
[ 1169.181407] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 1171.925066] run blktests nvme/014 at 2022-04-07 12:48:32
[ 1171.945578] loop0: detected capacity change from 0 to 2097152
[ 1171.958656] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1171.967684] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[ 1171.967768] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1171.969453] nvme nvme1: creating 48 I/O queues.
[ 1171.972976] nvme nvme1: new ctrl: "blktests-subsystem-1"
[ 1174.592998] nvme nvme1: using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!
[ 1180.446260] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 1180.955873] run blktests nvme/015 at 2022-04-07 12:48:41
[ 1180.977187] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1180.985737] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[ 1180.985861] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1180.987053] nvme nvme1: creating 48 I/O queues.
[ 1180.990547] nvme nvme1: new ctrl: "blktests-subsystem-1"
[ 1189.372053] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 1189.808482] run blktests nvme/016 at 2022-04-07 12:48:50
[ 1189.829232] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1191.207671] nvmet: adding nsid 999 to subsystem blktests-subsystem-1

<----------------------------------SNIP----------------------------------------->

[ 1191.209023] nvmet: adding nsid 1000 to subsystem blktests-subsystem-1
[ 1191.217660] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
[ 1191.217732] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1191.219435] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[ 1191.219928] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[ 1201.039390] run blktests nvme/017 at 2022-04-07 12:49:02
[ 1201.060583] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1201.062246] nvmet: adding nsid 2 to subsystem blktests-subsystem-1

<----------------------------------SNIP----------------------------------------->

[ 1202.449255] nvmet: adding nsid 997 to subsystem blktests-subsystem-1
[ 1202.450662] nvmet: adding nsid 998 to subsystem blktests-subsystem-1
[ 1202.452088] nvmet: adding nsid 999 to subsystem blktests-subsystem-1
[ 1202.453516] nvmet: adding nsid 1000 to subsystem blktests-subsystem-1
[ 1202.462232] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
[ 1202.462296] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1202.463848] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[ 1202.464377] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[ 1211.911514] run blktests nvme/018 at 2022-04-07 12:49:12
[ 1211.934744] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1211.943079] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[ 1211.943163] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1211.944782] nvme nvme1: creating 48 I/O queues.
[ 1211.948078] nvme nvme1: new ctrl: "blktests-subsystem-1"
[ 1212.976667] nvme1c1n1: Read(0x2) @ LBA 2305843009213693951, 1 blocks, Capacity Exceeded (sct 0x0 / sc 0x81) MORE DNR 
[ 1212.981527] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 1213.429338] run blktests nvme/019 at 2022-04-07 12:49:14
[ 1213.449876] loop0: detected capacity change from 0 to 2097152
[ 1213.468186] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1213.492413] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[ 1213.492499] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1213.494356] nvme nvme1: creating 48 I/O queues.
[ 1213.497819] nvme nvme1: new ctrl: "blktests-subsystem-1"
[ 1214.520864] nvme nvme1: using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!
[ 1214.524242] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 1214.997212] run blktests nvme/020 at 2022-04-07 12:49:16
[ 1215.017284] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1215.025331] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[ 1215.025430] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1215.026890] nvme nvme1: creating 48 I/O queues.
[ 1215.030244] nvme nvme1: new ctrl: "blktests-subsystem-1"
[ 1216.055681] nvme nvme1: using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!
[ 1216.059158] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 1216.524112] run blktests nvme/021 at 2022-04-07 12:49:17
[ 1216.544677] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1216.552753] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[ 1216.552839] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1216.554658] nvme nvme1: creating 48 I/O queues.
[ 1216.559182] nvme nvme1: new ctrl: "blktests-subsystem-1"
[ 1217.589011] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 1218.040577] run blktests nvme/022 at 2022-04-07 12:49:19
[ 1218.062091] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1218.069988] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[ 1218.070074] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1218.071869] nvme nvme1: creating 48 I/O queues.
[ 1218.075336] nvme nvme1: new ctrl: "blktests-subsystem-1"
[ 1219.101830] nvme nvme1: resetting controller
[ 1219.422414] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[ 1219.422465] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1219.424474] nvme nvme1: creating 48 I/O queues.
[ 1224.433048] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 1224.876972] run blktests nvme/023 at 2022-04-07 12:49:25
[ 1224.896389] loop0: detected capacity change from 0 to 2097152
[ 1224.910861] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1224.918979] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[ 1224.919064] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1224.920634] nvme nvme1: creating 48 I/O queues.
[ 1224.923966] nvme nvme1: new ctrl: "blktests-subsystem-1"
[ 1225.952853] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 1226.424781] run blktests nvme/024 at 2022-04-07 12:49:27
[ 1226.445904] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1226.453684] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[ 1226.453773] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1226.455205] nvme nvme1: creating 48 I/O queues.
[ 1226.458521] nvme nvme1: new ctrl: "blktests-subsystem-1"
[ 1227.488957] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 1227.953479] run blktests nvme/025 at 2022-04-07 12:49:28
[ 1227.974096] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1227.981820] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[ 1227.981908] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1227.983449] nvme nvme1: creating 48 I/O queues.
[ 1227.986727] nvme nvme1: new ctrl: "blktests-subsystem-1"
[ 1229.017262] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 1229.480005] run blktests nvme/026 at 2022-04-07 12:49:30
[ 1229.502304] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1229.510165] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[ 1229.510258] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1229.511977] nvme nvme1: creating 48 I/O queues.
[ 1229.515438] nvme nvme1: new ctrl: "blktests-subsystem-1"
[ 1230.542207] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 1230.985851] run blktests nvme/027 at 2022-04-07 12:49:31
[ 1231.007076] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1231.014820] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[ 1231.014903] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1231.016972] nvme nvme1: creating 48 I/O queues.
[ 1231.020536] nvme nvme1: new ctrl: "blktests-subsystem-1"
[ 1232.046969] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 1232.508302] run blktests nvme/028 at 2022-04-07 12:49:33
[ 1232.528636] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1232.536672] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[ 1232.536760] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1232.538187] nvme nvme1: creating 48 I/O queues.
[ 1232.541520] nvme nvme1: new ctrl: "blktests-subsystem-1"
[ 1233.570358] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 1234.017844] run blktests nvme/029 at 2022-04-07 12:49:35
[ 1234.037893] loop0: detected capacity change from 0 to 2097152
[ 1234.051313] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1234.059408] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[ 1234.059495] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1234.061119] nvme nvme1: creating 48 I/O queues.
[ 1234.064350] nvme nvme1: new ctrl: "blktests-subsystem-1"
[ 1235.184365] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 1235.659035] run blktests nvme/030 at 2022-04-07 12:49:36
[ 1235.681911] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1235.688917] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
[ 1235.689003] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1235.690502] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[ 1235.690910] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[ 1235.712532] nvmet: adding nsid 1 to subsystem blktests-subsystem-2
[ 1235.719280] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
[ 1235.719359] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1235.720732] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[ 1235.721191] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[ 1235.747083] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
[ 1235.747165] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1235.748727] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[ 1235.749179] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[ 1235.779510] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
[ 1235.779576] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1235.781562] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[ 1235.781961] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[ 1235.818455] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
[ 1235.818527] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1235.820140] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[ 1235.820547] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[ 1235.943032] run blktests nvme/031 at 2022-04-07 12:49:36
[ 1235.963586] loop0: detected capacity change from 0 to 2097152
[ 1235.980873] nvmet: adding nsid 1 to subsystem blktests-subsystem-0
[ 1236.000329] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-0 for NQN testhostnqn.
[ 1236.000418] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1236.002466] nvme nvme1: creating 48 I/O queues.
[ 1236.005940] nvme nvme1: new ctrl: "blktests-subsystem-0"
[ 1241.010783] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-0"
[ 1241.369775] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1241.376035] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN testhostnqn.
[ 1241.376128] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1241.377550] nvme nvme1: creating 48 I/O queues.
[ 1241.381705] nvme nvme1: new ctrl: "blktests-subsystem-1"
[ 1246.386400] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 1246.748703] nvmet: adding nsid 1 to subsystem blktests-subsystem-2
[ 1246.754780] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-2 for NQN testhostnqn.
[ 1246.754882] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1246.757093] nvme nvme1: creating 48 I/O queues.
[ 1246.760996] nvme nvme1: new ctrl: "blktests-subsystem-2"
[ 1251.765960] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-2"
[ 1252.129734] nvmet: adding nsid 1 to subsystem blktests-subsystem-3
[ 1252.135826] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-3 for NQN testhostnqn.
[ 1252.135909] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1252.137632] nvme nvme1: creating 48 I/O queues.
[ 1252.141480] nvme nvme1: new ctrl: "blktests-subsystem-3"
[ 1257.146273] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-3"
[ 1257.502190] nvmet: adding nsid 1 to subsystem blktests-subsystem-4
[ 1257.508334] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-4 for NQN testhostnqn.
[ 1257.508418] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1257.509782] nvme nvme1: creating 48 I/O queues.
[ 1257.513743] nvme nvme1: new ctrl: "blktests-subsystem-4"
[ 1262.518598] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-4"
[ 1262.896214] nvmet: adding nsid 1 to subsystem blktests-subsystem-5
[ 1262.902363] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-5 for NQN testhostnqn.
[ 1262.902450] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1262.903832] nvme nvme1: creating 48 I/O queues.
[ 1262.907578] nvme nvme1: new ctrl: "blktests-subsystem-5"
[ 1267.912774] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-5"
[ 1268.280905] nvmet: adding nsid 1 to subsystem blktests-subsystem-6
[ 1268.286951] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-6 for NQN testhostnqn.
[ 1268.287038] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1268.288790] nvme nvme1: creating 48 I/O queues.
[ 1268.292592] nvme nvme1: new ctrl: "blktests-subsystem-6"
[ 1273.299077] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-6"
[ 1273.664855] nvmet: adding nsid 1 to subsystem blktests-subsystem-7
[ 1273.670835] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-7 for NQN testhostnqn.
[ 1273.670919] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1273.672515] nvme nvme1: creating 48 I/O queues.
[ 1273.676566] nvme nvme1: new ctrl: "blktests-subsystem-7"
[ 1278.681518] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-7"
[ 1279.044358] nvmet: adding nsid 1 to subsystem blktests-subsystem-8
[ 1279.050257] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-8 for NQN testhostnqn.
[ 1279.050341] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1279.051794] nvme nvme1: creating 48 I/O queues.
[ 1279.055851] nvme nvme1: new ctrl: "blktests-subsystem-8"
[ 1284.060634] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-8"
[ 1284.426393] nvmet: adding nsid 1 to subsystem blktests-subsystem-9
[ 1284.432873] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-9 for NQN testhostnqn.
[ 1284.432959] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR 
[ 1284.434647] nvme nvme1: creating 48 I/O queues.
[ 1284.438677] nvme nvme1: new ctrl: "blktests-subsystem-9"
[ 1289.443577] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-9"
[ 1289.965096] run blktests nvme/038 at 2022-04-07 12:50:30
-- 
2.29.0


