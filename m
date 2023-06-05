Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C9EC7EE24
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 06:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FrVFzLf3p+AsNjRTh70R2U+rUWhfDGT5BCoOW2oHAX0=; b=GXqkSIHAKAi9n7otLaF3D1cx58
	oe+s5AXZltfspMpSam+Ye4JfWrHofrRWpJ5pS/sd7a67+Hw55El+Sf0NZ/ox2YWXWWsD7DhSFo7tp
	BT2SJWU9OzYgTyBho3StPTs/AfLIDj8ICHwIu5exu/MPOOADkDz0257v36VoUn9J1zqCQv708ptWw
	j4yqLeoAVbyaMVENCj24M0TY8VBpuOUQjRaqz40uEM59F+3xFgLx3u8CeY2pAx/cAeAECqYLjPy2R
	5M0GLTQ4epFYTAR2h0XH0LNAno4meJI38F0GN87KrkN78gKTW06uND9ViPDbRwlISg4dMTyvt/dja
	p2lwblUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q63xr-00EQ3q-1T;
	Mon, 05 Jun 2023 06:45:15 +0000
Received: from mail-bn7nam10on20605.outbound.protection.outlook.com ([2a01:111:f400:7e8a::605] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q63xk-00EQ1A-23
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 06:45:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ux91HmvM+21EQw3Fxm4UKsfymD8FPsZn4Sri0BPA7ruPIeaJAUTMxFbRDhNrMZFj+NlAkBZ326R+kwFH7Dflpf1at3ENG5ztyk3c6WDfvArIK1mtnXf1Lrj75+vw0jxolwRoPzj1979kcn+c4dTuLu3gj+fps1lqRduRKMfJlKv7HkHNbPsxZktr9e2oaNQMVQuCfGVMm6nxkPYcxKQpXE+200iqTAykvNC82xQxx/t9pzftkVelYt4m7LgRlqvdNlw+z87DKGzaJsXi1a+MoYtu235mcq7f1InVHc4rEoUVOu0arhE+cvAvXPQx30d3ild70Q+zwI0Muoq193diKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrVFzLf3p+AsNjRTh70R2U+rUWhfDGT5BCoOW2oHAX0=;
 b=UVP8ExrE9pKug5sLMyvePXnS8sn+7V7g8tj6DmrzmwuEB6rD1QyuItpjf2YpQEry3rT2oVAT0iuHQpJgemBW4GJkFMYRHbkkRtqR1m+s8G/1xiVOVUDRfppb5StdbiP+ghZFnoCuaY9aKl8qcVAbNAwms15jW7OS8IOWvq58xLwfyJRg9w/Exbd4hlzwGZh8rk4IsyplDQifA7kxSWFfN9FRUGuM9veAqqfaiaVeFCrd5/aroGg4wPkkIu6B6eOz4oW1crxuu9OoOVQxIoLtmlTsPFevmccCb9iodN+6MwJaMWHlZN/EuoNtyQeb1fXrU6SujR1nqhUVv1CWH/+KCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrVFzLf3p+AsNjRTh70R2U+rUWhfDGT5BCoOW2oHAX0=;
 b=PzxtxKL+rglvUcRFkASaUjtZSLB2GkDIvQrTUthnVIPjDOvK82DzxVQ+ViEvurp/FU6sEvyciL/yeoAPqmBcWCgOJzeeRSK00xNjfYFSclU/qCPsyq4zzfhoOOqCiCx40A+1lIZ0co7ChNlA2LLvx73UxrWuBOzWdjFJjXv5iE402PZyteo+SQxF4QQUHG1OxyAKchcJl3+goiv+lZuiDyROsjnXvs/YlWLN6G7nR5CBFVqY9hZQjPhIruK+BrSwQtMtljavzhlq2lv9SMBYZpBsHkRQOs1AiHjIaMLaHfaayefUFhA6bliVUWn9CMrFvLmJDaBCaLs17rco8I+48g==
Received: from MW4P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::27)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 06:44:59 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::15) by MW4P221CA0022.outlook.office365.com
 (2603:10b6:303:8b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32 via Frontend
 Transport; Mon, 5 Jun 2023 06:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32 via Frontend Transport; Mon, 5 Jun 2023 06:44:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 4 Jun 2023
 23:44:44 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 4 Jun 2023
 23:44:44 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 0/4] nvmet-auth: auth send / receive cleanup
Date: Sun, 4 Jun 2023 23:44:30 -0700
Message-ID: <20230605064434.45233-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e77e1f-7109-4fd2-531d-08db659061ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwPp/nw0G38iVxwYKq2q/KH/sn3ZP+f9AslqAKwBRs8/t4ST3kPW1B38WXxTFD4GczfJa+xWvfRoXucjQwxWtLFmyEeRNyXUuWJA88dGGNiTqnz1VvBe8Lx6M0OM9hk2MZPDhLwDUaGsPBc1DcB2nCQ3orV/15rH3ZKwkpQEPkB+ybWcF4fiIdWPlPbzKOBq6b0wpWklwTPmGXDdizPhWkEufsbtRrLjquqDQF+0C+oKMaGC2ajyyejLje0OgIB72KTO89cQeeyx6wqmyXNOUxFNWu+kBMEu3oiuYXnQ22MgJ/HFtRX+bTNbPnvEWF8Tn/blbyzoJ7x9Ul7/9U1NneKJi+dNABNVkquqiCeighsCm23DIa1bGSPZkFWOOjqmA6TyBqKd/OHWrrpQPGJ5iyEWaTuEYXbRmj4ukLvo8s07q43ynAbMjvqmLQy6lSEiq59oVLPSTnLcq8QnD6EXfeoGy0X6D9MA6Gz71CQNaZ/NGamwzDFykpF7otHgd/F9VL5Hp1/SFG4ZU2zUzxrwUojXkJCTQOyeUqB0xjSQu/NrEQgfxUs7G4qpHDL6vPHm8WbreTZ56YQk096H1kj/vdmVXHZclMMDKwKD0Zy2p31V7LfqCg6Ox8nBW42tm8QIv3n3O0txB46VsvSvjKr/oPkGbc7jaGoxR7XGiGXMOk/2yoIzXOel1Yj2Tp6WTuDSy/WcNqeaw5xuFOaj0H0FenLxEg+eOh5VRL183pfoNaFUs7hGYmghf4xx9P2ie0Xb
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(478600001)(356005)(7636003)(82740400003)(6916009)(4326008)(70586007)(70206006)(36756003)(54906003)(8936002)(8676002)(40480700001)(5660300002)(2906002)(41300700001)(30864003)(316002)(40460700003)(83380400001)(2616005)(426003)(336012)(47076005)(26005)(1076003)(107886003)(16526019)(186003)(6666004)(7696005)(36860700001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 06:44:59.1840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e77e1f-7109-4fd2-531d-08db659061ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230604_234508_802216_E3E0ED5E 
X-CRM114-Status: GOOD (  12.52  )
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

nvmet_execute_auth_send() and nvmet_exeucte_auth_receive() share a lot
of common functionality such as :-

1. Checking secp/spsp values and its error handling.
2. Initializing transfer buffer len and its error handling.
2. Allocating transfer buffer and its error handling.

This code is repeated in both the functions.

Add common helpers with very small restructring of code to remove
duplication of above functionality in the nvmet_exeucte_auth_receive()
and nvmet_execute_auth_send(), it also makes code easy to read as both
the functions are doing substantial work.

Please note that this series is generated on the top of this :-

commit 01cff945c026f1e245ba6401f7df2336ddbae11d (origin/nvme-6.5)
Author: Chaitanya Kulkarni <kch@nvidia.com>
Date:   Fri May 19 02:40:52 2023 -0700

    nvme-fcloop: no need to return from void function
    
    Remove return at the end of void function.

-ck

- Changes in V2:-

* add reviewe tags
* remove use of conditional operators in 3rd patch
* add a patch to fix the nvmet_sq->dhchap_step type fix from int -> u16

Chaitanya Kulkarni (4):
  nvmet-auth: use common helper to check secp/spsp
  nvmet_auth: use common helper for buffer alloc
  nvmet-auth: use helper for auth send/recv cmd prep
  nvmet-auth: use correct type for status variable

 drivers/nvme/target/fabrics-cmd-auth.c | 108 +++++++++++--------------
 drivers/nvme/target/nvmet.h            |   2 +-
 2 files changed, 48 insertions(+), 62 deletions(-)

nvme (nvme-6.5) # gitlog -4
6692f4da1048 (HEAD -> nvme-6.5) nvmet-auth: use correct type for status variable
16cb863ed3b1 nvmet-auth: use helper for auth send/recv cmd prep
d980c9183a99 nvmet_auth: use common helper for buffer alloc
104b23f8d911 nvmet-auth: use common helper to check secp/spsp
nvme (nvme-6.5) # git reset HEAD~4 --hard
HEAD is now at 01cff945c026 nvme-fcloop: no need to return from void function
nvme (nvme-6.5) # git am p/nvmet-auth-code-cleanup/*patch; git am --skip
Patch is empty.
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To record the empty patch as an empty commit, run "git am --allow-empty".
To restore the original branch and stop patching, run "git am --abort".
Applying: nvmet-auth: use common helper to check secp/spsp
Applying: nvmet_auth: use common helper for buffer alloc
Applying: nvmet-auth: use helper for auth send/recv cmd prep
Applying: nvmet-auth: use correct type for status variable
nvme (nvme-6.5) # ./compile_nvme.sh 
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
  CC [M]  drivers/nvme/target/fabrics-cmd-auth.o
  CC [M]  drivers/nvme/target/auth.o
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
  LD [M]  drivers/nvme/target/nvmet.ko
  LD [M]  drivers/nvme/target/nvme-loop.ko
  LD [M]  drivers/nvme/target/nvmet-rdma.ko
  LD [M]  drivers/nvme/target/nvmet-fc.ko
  LD [M]  drivers/nvme/target/nvme-fcloop.ko
  LD [M]  drivers/nvme/target/nvmet-tcp.ko
+ HOST=drivers/nvme/host
+ TARGET=drivers/nvme/target
++ uname -r
+ HOST_DEST=/lib/modules/6.4.0-rc2nvme+/kernel/drivers/nvme/host/
++ uname -r
+ TARGET_DEST=/lib/modules/6.4.0-rc2nvme+/kernel/drivers/nvme/target/
+ cp drivers/nvme/host/nvme-core.ko drivers/nvme/host/nvme-fabrics.ko drivers/nvme/host/nvme-fc.ko drivers/nvme/host/nvme.ko drivers/nvme/host/nvme-rdma.ko drivers/nvme/host/nvme-tcp.ko /lib/modules/6.4.0-rc2nvme+/kernel/drivers/nvme/host//
+ cp drivers/nvme/target/nvme-fcloop.ko drivers/nvme/target/nvme-loop.ko drivers/nvme/target/nvmet-fc.ko drivers/nvme/target/nvmet.ko drivers/nvme/target/nvmet-rdma.ko drivers/nvme/target/nvmet-tcp.ko /lib/modules/6.4.0-rc2nvme+/kernel/drivers/nvme/target//
+ ls -lrth /lib/modules/6.4.0-rc2nvme+/kernel/drivers/nvme/host/ /lib/modules/6.4.0-rc2nvme+/kernel/drivers/nvme/target//
/lib/modules/6.4.0-rc2nvme+/kernel/drivers/nvme/host/:
total 7.8M
-rw-r--r--. 1 root root 3.8M Jun  4 23:21 nvme-core.ko
-rw-r--r--. 1 root root 493K Jun  4 23:21 nvme-fabrics.ko
-rw-r--r--. 1 root root 981K Jun  4 23:21 nvme-fc.ko
-rw-r--r--. 1 root root 785K Jun  4 23:21 nvme.ko
-rw-r--r--. 1 root root 929K Jun  4 23:21 nvme-rdma.ko
-rw-r--r--. 1 root root 906K Jun  4 23:21 nvme-tcp.ko

/lib/modules/6.4.0-rc2nvme+/kernel/drivers/nvme/target//:
total 7.4M
-rw-r--r--. 1 root root 537K Jun  4 23:21 nvme-fcloop.ko
-rw-r--r--. 1 root root 476K Jun  4 23:21 nvme-loop.ko
-rw-r--r--. 1 root root 805K Jun  4 23:21 nvmet-fc.ko
-rw-r--r--. 1 root root 4.0M Jun  4 23:21 nvmet.ko
-rw-r--r--. 1 root root 899K Jun  4 23:21 nvmet-rdma.ko
-rw-r--r--. 1 root root 761K Jun  4 23:21 nvmet-tcp.ko
+ sync
+ sync
+ sync
+ modprobe nvme
+ echo 'Press enter to continue ...'
Press enter to continue ...
################nvme_trtype=loop############
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  20.311s  ...  20.535s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.080s  ...  10.080s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.465s  ...  1.470s
nvme/005 (reset local loopback target)                       [passed]
    runtime  1.797s  ...  1.784s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.060s  ...  0.061s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.034s  ...  0.035s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.468s  ...  1.468s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.441s  ...  1.436s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  94.861s  ...  86.838s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  81.316s  ...  71.517s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime    ...  77.886s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  70.922s  ...  77.348s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  4.239s  ...  4.570s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  3.763s  ...  3.792s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  12.382s  ...  12.757s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  12.338s  ...  12.283s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.440s  ...  1.434s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.451s  ...  1.445s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.430s  ...  1.421s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.434s  ...  1.434s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.756s  ...  1.756s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.449s  ...  1.453s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.414s  ...  1.435s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.431s  ...  1.426s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.435s  ...  1.417s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.438s  ...  1.438s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.433s  ...  1.429s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.579s  ...  1.561s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.211s  ...  0.209s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  3.968s  ...  3.925s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.013s  ...  0.013s
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  7.909s  ...  7.858s
nvme/041 (Create authenticated connections)                  [passed]
    runtime  0.741s  ...  0.766s
nvme/042 (Test dhchap key types for authenticated connections) [passed]
    runtime  4.897s  ...  4.920s
nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
    runtime  3.126s  ...  6.955s
nvme/044 (Test bi-directional authentication)                [passed]
    runtime  1.854s  ...  1.797s
nvme/045 (Test re-authentication)                            [passed]
    runtime  4.087s  ...  4.039s
nvme/047 (test different queue types for fabric transports)  [not run]
    nvme_trtype=loop is not supported in this test
nvme/048 (Test queue count changes on reconnect)             [not run]
    nvme_trtype=loop is not supported in this test
################nvme_trtype=tcp############
nvme/002 (create many subsystems and test discovery)         [not run]
    runtime  20.535s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.080s  ...  10.096s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.470s  ...  1.150s
nvme/005 (reset local loopback target)                       [passed]
    runtime  1.784s  ...  1.193s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.061s  ...  0.060s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.035s  ...  0.035s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.468s  ...  1.153s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.436s  ...  1.133s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  86.838s  ...  94.475s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  71.517s  ...  65.550s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  77.886s  ...  88.897s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  77.348s  ...  62.977s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  4.570s  ...  4.069s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  3.792s  ...  3.540s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [not run]
    runtime  12.757s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/017 (create/delete many file-ns and test discovery)     [not run]
    runtime  12.283s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.434s  ...  1.134s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.445s  ...  1.158s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.421s  ...  1.116s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.434s  ...  1.136s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.756s  ...  1.171s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.453s  ...  1.142s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.435s  ...  1.138s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.426s  ...  1.123s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.417s  ...  1.117s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.438s  ...  1.147s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.429s  ...  1.121s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.561s  ...  1.259s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.209s  ...  0.121s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  3.925s  ...  0.815s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.013s  ...  0.017s
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  7.858s  ...  7.171s
nvme/041 (Create authenticated connections)                  [passed]
    runtime  0.766s  ...  0.452s
nvme/042 (Test dhchap key types for authenticated connections) [passed]
    runtime  4.920s  ...  2.822s
nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
    runtime  6.955s  ...  0.691s
nvme/044 (Test bi-directional authentication)                [passed]
    runtime  1.797s  ...  1.216s
nvme/045 (Test re-authentication)                            [passed]
    runtime  4.039s  ...  3.810s
nvme/047 (test different queue types for fabric transports)  [passed]
    runtime    ...  1.832s
nvme/048 (Test queue count changes on reconnect)             [passed]
    runtime    ...  5.251s
blktests (master) # 


-- 
2.40.0


