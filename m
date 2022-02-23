Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EABAC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Feb 2022 03:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZtJ6b2+/PHEy/+/upAQJCGwq21DZ29jYy8M/NsV7gmk=; b=Caah2ooh4b2Bso/2jxNc9GcSP2
	EXMugHRuoH6657t6SyAo7HynxeVTlMvnLtE1b+sgALcDAMy1hhf/00Gpd30zD2ee8pFa2TSh98mgp
	RaenaEjNM9cN4oIKv6wIVGXcVqqnfJKI0thgeBi2YgqH58fM7HZgDiGvLlaatMiXPAaSM05dPAqEg
	zQxwr0CD4jE6T4YNYPZ8jGLJ+hkPLZlAgKWv9/9mIp+glP6MZczr9zEMaxqJTw932TV1QVmvD8jOG
	p8SDGqPbj6E5+xhZQNFd/G4yvUJfZZCBBzJ3tpPFF3+S6dNM24+B8HTJCz8FL1DljO+j/XNGtaPdC
	0aBwkLoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMiSn-00CYDG-3m; Wed, 23 Feb 2022 03:37:13 +0000
Received: from mail-dm6nam12on2061d.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::61d]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMiSj-00CYCw-Pe
 for linux-nvme@lists.infradead.org; Wed, 23 Feb 2022 03:37:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyiCYl6eT6xO9eqPD1849/lXjTpd/MXqat2lZ4bOPE761DEpqHKjj6Dh9kkGHQUY+JRa7eEIML0siIW0gioDs15RFW38mFl+jMF9xCm/tGf0X8RMzGAR+OOPQKG26A7NRTKMyFlqcefCAyZdo3Rais13zJ3UQhLwSyWzW8v+0IUfY9IWOBNEhBEsvbHMDqENbA2R2V1sER4Z1MfSKIN0hzxqBmsn+Gqm9EOsnv+GjoiifWALNj6//SzsUVycD2cG+2gLTSAVDudV+YbKkzvL64QdK1z/+LYcL6vRsBLkvYo+tQB+Y9uHM26KlnMc2/2GqfF7KsAV8OA4/4qiXZ8c9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtJ6b2+/PHEy/+/upAQJCGwq21DZ29jYy8M/NsV7gmk=;
 b=jphF0b0BrQTKtWcrDnfgro71/L5Sxkm+ZKXH68YnwCvcmdVJ/Ivpwi9gWPcM2wX3rgrW0i5yivwWhUr715Ai6TA+9RLLzC5vqdP30EwW8F1i38Iexpz2D9EPLEd3SAh5VCysnMipecgfIliTL6l1xGJ2Pg5gbh8YjnT9sAgcdlnhpNoOWI8gtPjwJOXkfQf6iTer0rj4aOskpv4tLAQ5VYwUGi7JBG0zNguscmA8v3ezhJjhF9qfKGMOHPm7dg/Bu9VXne1e1aUxSj8rrWyhVYPoQSt7s30GbTc4UHq/X3VOzWtCUwzA4lu9dFLPCSzbYjInS10KZ1SQhxLapXhvFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtJ6b2+/PHEy/+/upAQJCGwq21DZ29jYy8M/NsV7gmk=;
 b=iWnN0F9aUhhT4mRNPZOzKDIX1oOaJ5zVjhd1sEuugeh4Ih4F0IlStrTO2bk71Q0fWix8TCg9JNnDMuF4hNwXfvoN1V1p4o3RivyrZBtcvews5Mf6DZTqq4oCfB30gejYyl0FT/FvD6ZB94A2YkLehWz5hXzbv2MwAqmgptyAdNgaSGSufsF3HNtbEoE6RH7Zt3N/FLF0Js1IyX2jygoWW8UMic9wYkFCJpZDfBOL8LtVO+9CZX821OrSSUUhUZywgkxWPJJUzOchXWN6gareTxQx2VyhJzFhY70k+8WvE3SBPplAzQUvI74QbTvLKeIMLLK+u2EJoH5/t6ZeDLdi/w==
Received: from MW4PR04CA0160.namprd04.prod.outlook.com (2603:10b6:303:85::15)
 by MW2PR12MB2489.namprd12.prod.outlook.com (2603:10b6:907:d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 23 Feb
 2022 03:37:05 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::8b) by MW4PR04CA0160.outlook.office365.com
 (2603:10b6:303:85::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Wed, 23 Feb 2022 03:37:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 03:37:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 23 Feb 2022 03:37:04 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 22 Feb 2022
 19:37:03 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH 0/2] nvme-tcp: small cleanup
Date: Tue, 22 Feb 2022 19:36:55 -0800
Message-ID: <20220223033657.208747-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c1a6a35-e9a9-4e75-b025-08d9f67dc313
X-MS-TrafficTypeDiagnostic: MW2PR12MB2489:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB248940F2B5BD9729E44731B4A33C9@MW2PR12MB2489.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05FxIgpiAnw5qbzsceOFST/jx0+17xtomG3I2wcHabrCodzP5vj4V06Cyihh3UCkrm+466YGmNfiNN+x4LMBTs9mPLpQ5bqIj0frcMEm/fyu9oogVadS5iBbZBYsT8953nug3b4U+5TlU4seM9OLZzgCwhUZ+vqfROfZ4kkd+ybMr+AYRyG8P+U+haamtW/qr1N4JQvJd+v1+wdlKiibNmddnd4HCnna6MYW5yzbTwUhzud2Wj+pLTeWf4VrMx9CPaMirCLR5sO2AVBuw2gK2iIBysB85syDim3w+o0hMzR/UjUc2VjviHdQGCq0tBX5CckEnkNg5NiiGnuomOTOAqwgGlQ4I11BOOKv5jD2bt/5mRWZiybrCagN2g009aRCEld2VuClr8zcY+2iOnz1tf75/p0nRli5bJ4lnjQiu5F7A1IzW8JnAswlL6T3mt56UgdaDuTiwx67soxZA0PgX4zGa4IYX6Z5gAHkR3DF8G99INHC+fDF6frUUntxkPVe0033PFEIJcLObx8RdsCn8INL+nTVrYxnwYuc0KpEFrx3+cGkD9d488YPBlkVYG6Hk5kr5cBYFVjLEfx+mg8z3/24qYKDx2DcV82cGUSOB8mue/DZ+1PWZqf1+tSTnIIX9m0q82SL5XtRlAX1YoCXu+nxWI3UPVu1arb45ITN+7gEvHrv7Z6Fu8tffG3aglo2kT2I0C2QtcXYbfqYRoVcmw==
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(26005)(426003)(4326008)(8676002)(316002)(81166007)(6916009)(54906003)(336012)(47076005)(1076003)(356005)(16526019)(82310400004)(2616005)(40460700003)(70206006)(70586007)(83380400001)(508600001)(5660300002)(36860700001)(7696005)(6666004)(2906002)(36756003)(107886003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 03:37:05.2578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1a6a35-e9a9-4e75-b025-08d9f67dc313
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2489
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_193709_916071_539E42E0 
X-CRM114-Status: UNSURE (   9.38  )
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

Hi,

A small cleanup for host tcp, no functional change, below is the
testlog.

-ck

Chaitanya Kulkarni (2):
  nvme-tcp: don't initialize ret variable
  nvme-tcp: don't fold the line

 drivers/nvme/host/tcp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

root@dev nvme (nvme-5.18) # git am p/tcp-cleanup/*patch 
Applying: nvme-tcp: don't initialize ret variable
Applying: nvme-tcp: don't fold the line
root@dev nvme (nvme-5.18) # ./compile_nvme.sh 
+ umount /mnt/nvme0n1
+ clear_dmesg
./compile_nvme.sh: line 3: clear_dmesg: command not found
umount: /mnt/nvme0n1: no mount point specified.
+ ./delete.sh 1
+ NQN=testnqn
+ nvme disconnect -n testnqn
NQN:testnqn disconnected 0 controller(s)

real	0m0.007s
user	0m0.002s
sys	0m0.000s
+ for i in /sys/kernel/config/nvmet/subsystems/${NQN}/namespaces/*
+ echo 0
./delete.sh: line 9: /sys/kernel/config/nvmet/subsystems/testnqn/namespaces/*/enable: No such file or directory
+ rmdir '/sys/kernel/config/nvmet/subsystems/testnqn/namespaces/*'
rmdir: failed to remove '/sys/kernel/config/nvmet/subsystems/testnqn/namespaces/*': No such file or directory
+ rm -fr /sys/kernel/config/nvmet/ports/1/subsystems/testnqn
+ rmdir /sys/kernel/config/nvmet/ports/1
rmdir: failed to remove '/sys/kernel/config/nvmet/ports/1': No such file or directory
+ rmdir /sys/kernel/config/nvmet/subsystems/testnqn
rmdir: failed to remove '/sys/kernel/config/nvmet/subsystems/testnqn': No such file or directory
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
+ make -j 48 M=drivers/nvme/ modules
  CC [M]  drivers/nvme/host/tcp.o
  LD [M]  drivers/nvme/host/nvme-tcp.o
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
  LD [M]  drivers/nvme/host/nvme-fc.ko
  LD [M]  drivers/nvme/host/nvme.ko
  LD [M]  drivers/nvme/host/nvme-tcp.ko
  LD [M]  drivers/nvme/host/nvme-rdma.ko
  LD [M]  drivers/nvme/host/nvme-core.ko
  LD [M]  drivers/nvme/target/nvmet-rdma.ko
  LD [M]  drivers/nvme/target/nvme-loop.ko
  LD [M]  drivers/nvme/target/nvmet-fc.ko
  LD [M]  drivers/nvme/target/nvmet.ko
  LD [M]  drivers/nvme/target/nvmet-tcp.ko
  LD [M]  drivers/nvme/host/nvme-fabrics.ko
  LD [M]  drivers/nvme/target/nvme-fcloop.ko
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
total 5.8M
-rw-r--r--. 1 root root 2.2M Feb 22 19:07 nvme-core.ko
-rw-r--r--. 1 root root 425K Feb 22 19:07 nvme-fabrics.ko
-rw-r--r--. 1 root root 922K Feb 22 19:07 nvme-fc.ko
-rw-r--r--. 1 root root 709K Feb 22 19:07 nvme.ko
-rw-r--r--. 1 root root 853K Feb 22 19:07 nvme-rdma.ko
-rw-r--r--. 1 root root 794K Feb 22 19:07 nvme-tcp.ko

/lib/modules/5.17.0-rc2nvme+/kernel/drivers/nvme/target//:
total 6.0M
-rw-r--r--. 1 root root 475K Feb 22 19:07 nvme-fcloop.ko
-rw-r--r--. 1 root root 417K Feb 22 19:07 nvme-loop.ko
-rw-r--r--. 1 root root 734K Feb 22 19:07 nvmet-fc.ko
-rw-r--r--. 1 root root 3.0M Feb 22 19:07 nvmet.ko
-rw-r--r--. 1 root root 823K Feb 22 19:07 nvmet-rdma.ko
-rw-r--r--. 1 root root 671K Feb 22 19:07 nvmet-tcp.ko
+ modprobe nvme
root@dev blktests (master) # nvme_trtype=tcp ./check nvme
nvme/002 (create many subsystems and test discovery)         [not run]
    nvme_trtype=tcp is not supported in this test
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.116s  ...  10.081s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.145s  ...  1.142s
nvme/005 (reset local loopback target)                       [passed]
    runtime  1.224s  ...  1.237s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.088s  ...  0.084s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.042s  ...  0.047s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.162s  ...  1.164s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.136s  ...  1.123s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  16.450s  ...  16.367s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  14.517s  ...  67.432s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime    ...  21.367s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  75.162s  ...  100.432s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  3.540s  ...  3.966s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  3.509s  ...  3.838s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [not run]
    nvme_trtype=tcp is not supported in this test
nvme/017 (create/delete many file-ns and test discovery)     [not run]
    nvme_trtype=tcp is not supported in this test
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.128s  ...  1.154s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.153s  ...  1.174s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.127s  ...  1.145s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.115s  ...  1.141s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.156s  ...  1.170s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.146s  ...  1.155s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.106s  ...  1.121s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.108s  ...  1.140s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.129s  ...  1.127s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.136s  ...  1.156s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.120s  ...  1.128s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.238s  ...  1.237s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.128s  ...  0.142s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  0.928s  ...  0.909s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.034s  ...  0.036s


-- 
2.29.0


