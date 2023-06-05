Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E171C7EE2F
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 09:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jMarYFQOjGIWe5Iz65HQfuMLMP5zK+hrzH1Cuuxxbic=; b=tB7YU03929kwz9WqFU6FHzYIha
	zKEbu6Hz0DTj6Xu2+7GNgycnffkZr1uyniLRSeUe5J2ZZIJx5GCMvlv2UQcpkCLTPMFJTCc4EyFt2
	QwjDxhR5PqdgOHHHH6KIj4l5scEjAjsxDF31EDwKdOVQ4jGr8kIVn9ZmqeLafdjSLZBnKl1BMJR2a
	AuEex50PQKAy8x33nEqtS1DAjpuBtAi7CycuteHuWHUjtBOPg692IY2t7yYpJ5uK6+SmfdARfVK6T
	/CO476IH8wu2urCzYVP/otnMPPTLXNVNDOl83QKEEW8etsMGl68ypzwio/+4l5kuudLGE7HBB91ti
	+S04tz/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q66NY-00Ep2N-3D;
	Mon, 05 Jun 2023 09:19:57 +0000
Received: from mail-bn7nam10on2061c.outbound.protection.outlook.com ([2a01:111:f400:7e8a::61c] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q66NV-00Ep1Q-1j
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 09:19:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQ8pr4zHniX+sb7HX5quLOljBF6h5YCKZAwDXmaPQ5hxbELaAM0VittHiiLRtlyihDi1gWOThpGh0ZL/ckJdcd6owdO4L94Gr8Xj0ozyS0f1MoI8ZgdvzDajaiGVhnQxCsZn8QRXxDrzIUjcwXPdZadr16Ugi/snGVfMW6a7pv5Qrw9IIRBW9l6026JadwR1l1SD8agYKjfQqSyFD2Ceqoaqa6cnVDtAdw0PhrC7xS8rzE63I34TLdnHulwnpRqLhsTvt8TOOhZcdICmyM0uhpUJmJb5Yr3jce6Jngdtr7FYFdXl65gtO4sp2PEN7Iy/S9clQTbcWoStwg+Y6pcPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMarYFQOjGIWe5Iz65HQfuMLMP5zK+hrzH1Cuuxxbic=;
 b=iZL+lVfEKvp7+8sd4WRUdw2FQgS+LR0ktKoE+ugqzuuZr+vAhWAEXQWZ1hEPEiXR6sZv2fgN+FjISpPkhaskmwjfDVsQKhBTOXM64eNKVnmi1g9wmuUHXnMQwA6nrBzFttc0kvMwXrS9vaklwGWNccwOz0pFX7PP6okxK0bgXlYXhrw92e1/Nl8Lgl5iRIjixpeh446znGpiOkDYjGye/zyG5+eq40teYN3Mu+KD4Ki4bdnCaz3xWXk8EToBkhshXvbOtsvTak//RCYgurwbV8f7RgtIJKZLySqPkY87pUBVuMunkUh1IbYcAWzMadvtmfmEScIdtFpKq+4CaZLGXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMarYFQOjGIWe5Iz65HQfuMLMP5zK+hrzH1Cuuxxbic=;
 b=lw2yihXKNxoWoalN8BzzNuTvVBHvenceEQ5edFfSwdIv/8Dt4qWBaw8eljLl97AYSxzmjnvNQ6Ocu91B/ogi2pPxAnoi15/0D+ANyGGE4Z40yTGJ5zFLvZg2B2mqt7pcjzjEBUYWX0x816TDdG2RqXQpVsv6F/O7quxN5qU5HkTUYcPSkdc4kjyPBR2BAJq7xRKwzSdifV+5VpLudK5yUXo7sVN22wYpQmo/WY+2Xlc/9SUSGv7dODUlDBf2mCzT0yTpsIEo7lsmbfZG7+upEx64TwlDp7pw25KRWvi1ZOFt+XaZCaaD+I43/lXBMsVJbumoTR40zyy+jDr97dKGzA==
Received: from MW4PR04CA0375.namprd04.prod.outlook.com (2603:10b6:303:81::20)
 by SJ2PR12MB7867.namprd12.prod.outlook.com (2603:10b6:a03:4cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Mon, 5 Jun
 2023 09:19:44 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::6d) by MW4PR04CA0375.outlook.office365.com
 (2603:10b6:303:81::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32 via Frontend
 Transport; Mon, 5 Jun 2023 09:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23 via Frontend Transport; Mon, 5 Jun 2023 09:19:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 5 Jun 2023
 02:19:29 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 5 Jun 2023
 02:19:28 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V3 0/3] nvmet-auth: auth send / receive cleanup
Date: Mon, 5 Jun 2023 02:19:17 -0700
Message-ID: <20230605091920.34253-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|SJ2PR12MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: f6714bc7-a41f-4041-8f4e-08db65a6003c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sj1Aw0CRmPpONtK5zMhrI/E6xXyIUSHpqe4i0n1SeWg5lQ0WIkKSMIlvkhCdVW8ffYV2naagi8WpbgrNQN92Fcx6R5E3ivvx36coNwuRkRw/Vmy8loIRAQYE7TiSZlTiwWyfTSDmZbXrMFWSOOZE/vjRgb5TmcwVWAcHQgwBsrKciCU6i2UCKDJpNbrNu/8CM4KFG8cVh3PvP9yn9dIwjs6oWqVQ0Gjcad7DYEJvehGBx9WD6noFwmxWXbNCkLn/nMEgpaMlTwKLpNUtHUArhvX+Fo4oB92hcg3nEDrV/9tFE/kR4wPxR6ZJiXdZiKPuoOpnIvufgSAFGAG9DlBZzUjZX7bHFTqu4f+Ic4lokKgVI+gzF2/DznuBGDVr21I2FHZia+GMOkNIGc6Aj64oGD7LYLFbC2cwmdSOaViAxz09Ezbzx8Y952yJVKxY9cszXG9xJ009+zVpEVOQnKAsqzChO7UXVjBCDkOB60JWMN0FI8kEsHllnuF8Csfmo7Eh+3KJxDfv979DoBS4LY8U6BsDFjSbS8YL1N9mMV1R3W1tcS1YxaweZrlD/RO5V84KfE/blaFyWHvJmsHz3+WQZGO7jwN5tFIsMQy+1lBexPhtWSsrR66e788NJIFTBbbINmJrKjmwQ+BXfbIEtguFB0Ozaunin2JuJxqkMVUftRhg85uNIV8zqmiqgutYbL0+PxOwYmhEO13apONBcjJJOmEmBoovFDF3FG901pVYQSoc9IzRweas04FJKTposXDn
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(6666004)(16526019)(82740400003)(82310400005)(7636003)(356005)(478600001)(40480700001)(47076005)(107886003)(83380400001)(336012)(426003)(36860700001)(186003)(36756003)(26005)(1076003)(2616005)(40460700003)(7696005)(316002)(4326008)(70586007)(70206006)(41300700001)(6916009)(8676002)(8936002)(5660300002)(54906003)(2906002)(30864003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 09:19:44.4908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6714bc7-a41f-4041-8f4e-08db65a6003c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7867
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_021953_647608_3E63ECCB 
X-CRM114-Status: GOOD (  16.83  )
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

- Changes in V3:-

* remove wrapper on the top of wrapper (Hannes)
* fix commit message in following patch 
  "nvmet-auth: use correct type for status variable" (Hannes)

- Changes in V2:-

* add reviewe tags
* remove use of conditional operators in 3rd patch
* add a patch to fix the nvmet_sq->dhchap_step type fix from int -> u16

Chaitanya Kulkarni (3):
  nvmet-auth: use common helper to check secp/spsp
  nvmet_auth: use common helper for buffer alloc
  nvmet-auth: use correct type for status variable

 drivers/nvme/target/fabrics-cmd-auth.c | 89 ++++++++++++--------------
 drivers/nvme/target/nvmet.h            |  2 +-
 2 files changed, 41 insertions(+), 50 deletions(-)

nvme (nvme-6.5) # git log -3
commit a30ce4b8bcfa0fa0485cc2afb0252400e7623052 (HEAD -> nvme-6.5)
Author: Chaitanya Kulkarni <kch@nvidia.com>
Date:   Sat Jun 3 22:59:12 2023 -0700

    nvmet-auth: use correct type for status variable
    
    The dhchap_step member of structure nvmet_sq holds the following values:
    
            NVME_AUTH_DHCHAP_FAILURE_FAILED                 = 0x01,
            NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE             = 0x02,
            NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH        = 0x03,
            NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE          = 0x04,
            NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE       = 0x05,
            NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD      = 0x06,
            NVME_AUTH_DHCHAP_FAILURE_INCORRECT_MESSAGE      = 0x07,
    
    These values can never be negative, hence change int type of
    dhchap_step to u16 in the nvmet_sq struct.
    
    Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

commit a5e26a6060a64a3104875bcd7074b15049460f78
Author: Chaitanya Kulkarni <kch@nvidia.com>
Date:   Mon Jun 5 01:46:30 2023 -0700

    nvmet_auth: use common helper for buffer alloc
    
    Add a common helper to factor out buffer allocation in
    nvmet_execute_auth_send() and nvmet_execute_auth_receive() and call it
    from nvmet_auth_common_prep() once we done with the secp/spsp0/spsp1
    check.
    
    Only functional change in this patch is transfer buffer allocation is
    moved before nvmet_check_transfer_len() and it is freed if when
    nvmet_check_transfer_len() fails. But similar allocation and free is
    used in error unwind path in nvme code and it is not in fast path, so
    it shuold be fine.
    
    Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

commit 974ed1267f19f27ee9fc6c2d194b46cb39fb13a0
Author: Chaitanya Kulkarni <kch@nvidia.com>
Date:   Sat May 20 22:36:25 2023 -0700

    nvmet-auth: use common helper to check secp/spsp
    
    Add a common helper to factor out secp/spsp values check in
    nvmet_execute_auth_send() and nvmet_execute_auth_receive().
    
    No functional change in this patch.
    
    Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
nvme (nvme-6.5) # ./compile_nvme.sh 
+ umount /mnt/nvme0n1
+ clear_dmesg
./compile_nvme.sh: line 3: clear_dmesg: command not found
umount: /mnt/nvme0n1: no mount point specified.
+ ./delete.sh
+ NQN=testnqn
+ nvme disconnect -n testnqn
NQN:testnqn disconnected 0 controller(s)

real	0m0.003s
user	0m0.002s
sys	0m0.001s
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
└── pci_ep
    ├── controllers
    └── functions

3 directories, 0 files
+ sleep 1
+ modprobe -r nvme-core
+ lsmod
+ grep nvme
+ sleep 1
+ git diff
++ nproc
+ make -j 48 M=drivers/nvme/ modules
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
-rw-r--r--. 1 root root 3.8M Jun  5 01:51 nvme-core.ko
-rw-r--r--. 1 root root 493K Jun  5 01:51 nvme-fabrics.ko
-rw-r--r--. 1 root root 981K Jun  5 01:51 nvme-fc.ko
-rw-r--r--. 1 root root 785K Jun  5 01:51 nvme.ko
-rw-r--r--. 1 root root 929K Jun  5 01:51 nvme-rdma.ko
-rw-r--r--. 1 root root 906K Jun  5 01:51 nvme-tcp.ko

/lib/modules/6.4.0-rc2nvme+/kernel/drivers/nvme/target//:
total 7.4M
-rw-r--r--. 1 root root 537K Jun  5 01:51 nvme-fcloop.ko
-rw-r--r--. 1 root root 476K Jun  5 01:51 nvme-loop.ko
-rw-r--r--. 1 root root 805K Jun  5 01:51 nvmet-fc.ko
-rw-r--r--. 1 root root 4.0M Jun  5 01:51 nvmet.ko
-rw-r--r--. 1 root root 899K Jun  5 01:51 nvmet-rdma.ko
-rw-r--r--. 1 root root 761K Jun  5 01:51 nvmet-tcp.ko
+ sync
+ sync
+ sync
+ modprobe nvme
+ echo 'Press enter to continue ...'
Press enter to continue ...
nvme (nvme-6.5) # cdblktests 
(failed reverse-i-search)`./sh test': ^Csend-email.sh 
blktests (master) # sh test-nvme.sh 
blktests (master) # sh test-nvme.sh 
################nvme_trtype=loop############
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime    ...  19.549s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.096s  ...  10.088s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.150s  ...  1.439s
nvme/005 (reset local loopback target)                       [passed]
    runtime  1.193s  ...  1.787s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.060s  ...  0.063s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.035s  ...  0.036s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.153s  ...  1.454s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.133s  ...  1.458s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  94.475s  ...  97.494s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  65.550s  ...  79.488s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  88.897s  ...  83.403s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  62.977s  ...  72.704s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  4.069s  ...  4.257s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  3.540s  ...  3.751s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime    ...  12.843s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime    ...  12.687s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.134s  ...  1.435s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.158s  ...  1.443s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.116s  ...  1.430s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.136s  ...  1.426s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.171s  ...  1.782s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.142s  ...  1.462s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.138s  ...  1.425s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.123s  ...  1.432s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.117s  ...  1.421s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.147s  ...  1.443s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.121s  ...  1.444s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.259s  ...  1.569s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.121s  ...  0.202s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  0.815s  ...  3.975s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.017s  ...  0.014s
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  7.171s  ...  7.871s
nvme/041 (Create authenticated connections)                  [passed]
    runtime  0.452s  ...  0.756s
nvme/042 (Test dhchap key types for authenticated connections) [passed]
    runtime  2.822s  ...  4.909s
nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
    runtime  0.691s  ...  6.975s
nvme/044 (Test bi-directional authentication)                [passed]
    runtime  1.216s  ...  1.824s
nvme/045 (Test re-authentication)                            [passed]
    runtime  3.810s  ...  4.061s
nvme/047 (test different queue types for fabric transports)  [not run]
    runtime  1.832s  ...  
    nvme_trtype=loop is not supported in this test
nvme/048 (Test queue count changes on reconnect)             [not run]
    runtime  5.251s  ...  
    nvme_trtype=loop is not supported in this test
################nvme_trtype=tcp############
nvme/002 (create many subsystems and test discovery)         [not run]
    runtime  19.549s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.088s  ...  10.087s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.439s  ...  1.128s
nvme/005 (reset local loopback target)                       [passed]
    runtime  1.787s  ...  1.227s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.063s  ...  0.056s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.036s  ...  0.038s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.454s  ...  1.141s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.458s  ...  1.118s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  97.494s  ...  101.964s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  79.488s  ...  68.096s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  83.403s  ...  88.510s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  72.704s  ...  71.458s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  4.257s  ...  3.951s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  3.751s  ...  3.439s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [not run]
    runtime  12.843s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/017 (create/delete many file-ns and test discovery)     [not run]
    runtime  12.687s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.435s  ...  1.127s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.443s  ...  1.132s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.430s  ...  1.118s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.426s  ...  1.121s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.782s  ...  1.170s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.462s  ...  1.133s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.425s  ...  1.116s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.432s  ...  1.112s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.421s  ...  1.114s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.443s  ...  1.121s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.444s  ...  1.103s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.569s  ...  1.253s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.202s  ...  0.122s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  3.975s  ...  0.809s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.014s  ...  0.015s
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  7.871s  ...  7.169s
nvme/041 (Create authenticated connections)                  [passed]
    runtime  0.756s  ...  0.423s
nvme/042 (Test dhchap key types for authenticated connections) [passed]
    runtime  4.909s  ...  2.758s
nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
    runtime  6.975s  ...  0.701s
nvme/044 (Test bi-directional authentication)                [passed]
    runtime  1.824s  ...  1.235s
nvme/045 (Test re-authentication)                            [passed]
    runtime  4.061s  ...  3.822s
nvme/047 (test different queue types for fabric transports)  [passed]
    runtime    ...  1.803s
nvme/048 (Test queue count changes on reconnect)             [passed]
    runtime    ...  6.233s
-- 
2.40.0


