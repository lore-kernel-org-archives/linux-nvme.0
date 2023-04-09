Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEF4C77B61
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Apr 2023 21:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lTU4ZNQDDQGzgoSD2E/wDPH7wpNsU0L7iHFnNkJ/Als=; b=aSjRpMVYof4MyDgJXzlsOmX6aD
	r6F9w+cv4LimOEYa6AYfLXVk40wJSxfGEF2raSYhjV4qI6GO8vY8v4mQDgjPGnE4QVC/6xHg8fMIa
	ESsDTSgJF2vnqBBwifRBz8oRAkYYH8jozcOSUmL4jlvjxyJ/dLr20Y0xI81yCjTV/jaVgJOiiYuI2
	fOpEaNGqUrbpbWhVirPWH64yo7wNPm85z7nM5Xs98nlFJNAdHHgRR9YFnk6szoR98iyesaAEDVUHz
	/eirLDVqD/snbZr0Qrm3oMcFkeNq4jp5ejEgfDdlepHl+OHFW0I6cKO1FbR8AOmp8Hshy7XMTctbv
	CiO7Ss8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1plcYF-00EGj9-2c;
	Sun, 09 Apr 2023 21:26:19 +0000
Received: from mail-co1nam11on20607.outbound.protection.outlook.com ([2a01:111:f400:7eab::607] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1plcY8-00EGiA-0b
	for linux-nvme@lists.infradead.org;
	Sun, 09 Apr 2023 21:26:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgdfWph4+eIU+F74oBHalPVMqJ5XQsd007SmeFqXTPOaSuXxkyUfVK5g36zRxAtzuptOB3BO7yWq5KgzPEu4PsLjqHBjHz0zJr5yh5iDUBXHEUWas3FPnqwSnhXFN08Eu6HYQKrBzbY10gauf14GcS4KIAnplgEDDClwns4iAkoLX9dErGUXEUo8Pf24qJlsv3kpHMeFhfE7ihLIDYpzro+V6ldEeyKrc1d0T2iSaqki+IgtBdMHwp/rb6HQDovZXeXLgpdVdXlFK7LMUbX+TBsC9c3dwu1m/3jf99/dCYemM2Q2/PF7km5sFlU10D+EPXduulbn9oSxwH1B7sCAPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTU4ZNQDDQGzgoSD2E/wDPH7wpNsU0L7iHFnNkJ/Als=;
 b=HtJfcqnNe2TfOLiwdpNzLs52KOqUx/iDmnp1hPYFFJrxfOK2I8hKwQp543gsyBnrRuWtCT4R6EWDkkgcGYp/3z9AAaPJQOiMH95h6//ozRcVI0xMAtbSYVLVytQFECRlHXrFTZ97BbrRdUIW8JqXwjXbMdVON6Epp30x/a4sNI8HzLhBY4sBkHz1F+i+aV1sH77IpB4MiuJILVuiNUohrPz75+ZaszULRjYm5dSZ/TZFJtQ3pDJnnMRETvyfgYoQrtFdd2bYE4ctkVu1yzkFE5trGfuotcb9xxxhWf0iXBB0OO3e+mnuOpJqsA8yjqpSzm1rA7TEBL9Jjy+C1OZzGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTU4ZNQDDQGzgoSD2E/wDPH7wpNsU0L7iHFnNkJ/Als=;
 b=la3nfigpDh2gxuV+IlYbY6FB/oparLbLRMCr9CHjZsDroitNd7jkPfKiyNzZdlrBhUwZ6yjDr5YZctxmm5CaaxpmfaCJTnmNoacbYU2z+2+0BhUnqt3ZxVdnBBOrCgbPSn3Cx+5xVqEjW7MT869C9VpRKB2aukeaeW4e1TkZCZyF0Y+Fkuh9uNAfNVv9q1ck1yFjeEWfIRayunadyRmao64eMbBit3eyBRavC/QJJ5tx1fMltvL+6T97pWIo+nrhY17LsEnxCX0tKijmLXEGsOeiHPm42GJY+qC4U+9ZsYYuelSR/KQDD2Iq1w9ksQKeccAsppE+NR6OcuaXzVEc8A==
Received: from MW3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:303:2b::8)
 by DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.27; Sun, 9 Apr 2023 21:26:03 +0000
Received: from CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::cd) by MW3PR05CA0003.outlook.office365.com
 (2603:10b6:303:2b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.26 via Frontend
 Transport; Sun, 9 Apr 2023 21:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT101.mail.protection.outlook.com (10.13.175.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.20 via Frontend Transport; Sun, 9 Apr 2023 21:26:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 9 Apr 2023
 14:25:46 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 9 Apr 2023
 14:25:45 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <alan.adamson@oracle.com>
CC: <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V5 0/1] nvme: allow passthru cmd error logging
Date: Sun, 9 Apr 2023 14:25:37 -0700
Message-ID: <20230409212538.18647-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset="a"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT101:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 85fbafa8-e8f8-4456-cae7-08db39410560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(36840700001)(46966006)(40470700004)(36756003)(41300700001)(8676002)(6916009)(4326008)(316002)(70586007)(478600001)(70206006)(54906003)(7696005)(82310400005)(7636003)(40480700001)(30864003)(5660300002)(8936002)(2906002)(26005)(356005)(82740400003)(186003)(2616005)(16526019)(36860700001)(83380400001)(47076005)(1076003)(336012)(107886003)(6666004)(426003)(40460700003)(93036002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2023 21:26:02.7381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fbafa8-e8f8-4456-cae7-08db39410560
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230409_142612_683828_CDF7E4B1 
X-CRM114-Status: GOOD (  17.03  )
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

Hi Alan,

I spnet some time on the V4 to fix several nits and testing with keeping
your authorship, please have a look, feel free to send a next version
if you find something not right.

In nvme_end_req()_ we only log errors which are for non-passthru
commands. Add a helper function nvme_log_err_passthru() which allows us
to log error for passthru commands by decoding cdw10-cdw15 values of
nvme command.

Full disclouser there is a checkpatch warning on this patch :-

WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred. Consider using octal permissions '0644'.
#146: FILE: drivers/nvme/host/core.c:3487:
+static DEVICE_ATTR(passthru_err_log, S_IRUGO | S_IWUSR,

This patch is using DEVICE_ATTR declaration style in nvme/host/core.c
instead of inventing new one to remove above warning.

This has several fixes on V4, see list below.

Below is short testlog :-

nvme (nvme-6.4) # echo "############ TEST Admin Command error ###################"
############ TEST Admin Command error ###################
nvme (nvme-6.4) # nvme telemetry-log -o /tmp/test /dev/nvme0  
NVMe status: Invalid Field in Command: A reserved coded value or an unsupported value in a defined field(0x4002)
Failed to acquire telemetry log 16386!
nvme (nvme-6.4) # dmesg  -c 
[50359.040637] nvme0: Get Log Page(0x2), Invalid Field in Command (sct 0x0 / sc 0x2) DNR cdw10=0x7f0107 cdw11=0x0 cdw12=0x0 cdw13=0x0 cdw14=0x0 cdw15=0x0
nvme (nvme-6.4) # echo "############ TEST I/O Command error ###################"
############ TEST I/O Command error ###################
nvme (nvme-6.4) # nvme write-zeroes -n 1 -s 0x200000 -c 10 /dev/nvme0
NVMe status: LBA Out of Range: The command references an LBA that exceeds the size of the namespace(0x4080)
nvme (nvme-6.4) # dmesg  -c
[134411.419290] nvme nvme0: using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!
[134411.419484] nvme0n1: Write Zeros(0x8), LBA Out of Range (sct 0x0 / sc 0x80) DNR cdw10=0x200000 cdw11=0x0 cdw12=0xa cdw13=0x0 cdw14=0x0 cdw15=0x0
nvme (nvme-6.4) #

nvme (nvme-6.4) # 

-ck

Chaitanya Kulkarni (1):
  nvme: allow passthru cme error logging

 drivers/nvme/host/core.c | 83 +++++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 79 insertions(+), 5 deletions(-)

v5:

- Trim down code in the nvme_log_error_passthrough().
  Use following to get the disk name as an arg to
   pr_err_ratelimited() :-
	ns ? ns->disk->disk_name : dev_name(nr->ctrl->device),
  Use following to get the admin vs I/O opcode string as an arg to
  pr_err_ratelimited() :-
       	ns ? nvme_get_opcode_str(nr->cmd->common.opcode) :
       	     nvme_get_admin_opcode_str(nr->cmd->common.opcode),
- Rename nvme_log_error_passthrough() -> nvme_log_err_passthru().
- Remove else and return directly in nvme_passthru_err_log_show().
- Generate error on invalid values of the passthru_enable variable
  in nvme_passthru_log_store().
- Rename passthrough -> passthru.
- Rename sysfs attr from passthru_admin_err_logging -> passthru_log_err.

v4:
- Change sysfs attribute to passthru_admin_err_logging
- Only log passthrough admin commands.  IO passthrough commands will always be logged.

v3:
- Log a passthrough specific message that dumps CDW* contents.
- Enable/disable vis sysfs rather than debugfs.

v2:
- Included Pankaj Raghav's patch 'nvme: ignore starting sector while error logging for passthrough requests'
  with a couple changes.
- Moved error_logging flag to nvme_ctrl structure
- The entire nvme-debugfs.c does not need to be guarded by #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS.
- Use IS_ENABLED((CONFIG_NVME_ERROR_LOGGING_DEBUG_FS)) to determine if error logging should be
  initialized.
- Various other nits.

nvme (nvme-6.4) # git am p/nvme-passthru-err-log/0001-nvme-allow-passthru-cme-error-logging.patch
Applying: nvme: allow passthru cmd error logging
nvme (nvme-6.4) # gitlog -2
aeae7179040c (HEAD -> nvme-6.4) nvme: allow passthru cmd error logging
803fc6f9ccee Merge branch 'nvme-6.4' of git://git.infradead.org/nvme into nvme-6.4
nvme (nvme-6.4) # ./compile_nvme.sh 
+ umount /mnt/nvme0n1
+ clear_dmesg
./compile_nvme.sh: line 3: clear_dmesg: command not found
umount: /mnt/nvme0n1: no mount point specified.
+ ./delete.sh
+ NQN=testnqn
+ nvme disconnect -n testnqn
NQN:testnqn disconnected 0 controller(s)

real	0m0.004s
user	0m0.001s
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
└── pci_ep
    ├── controllers
    └── functions

3 directories, 0 files
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
  CC [M]  drivers/nvme/common/auth.o
  CC [M]  drivers/nvme/host/core.o
  CC [M]  drivers/nvme/host/ioctl.o
  CC [M]  drivers/nvme/target/core.o
  CC [M]  drivers/nvme/target/configfs.o
  CC [M]  drivers/nvme/host/constants.o
  CC [M]  drivers/nvme/host/trace.o
  CC [M]  drivers/nvme/target/admin-cmd.o
  CC [M]  drivers/nvme/host/multipath.o
  CC [M]  drivers/nvme/target/fabrics-cmd.o
  CC [M]  drivers/nvme/host/zns.o
  CC [M]  drivers/nvme/target/discovery.o
  CC [M]  drivers/nvme/host/fault_inject.o
  CC [M]  drivers/nvme/target/io-cmd-file.o
  CC [M]  drivers/nvme/host/hwmon.o
  CC [M]  drivers/nvme/target/io-cmd-bdev.o
  CC [M]  drivers/nvme/host/auth.o
  CC [M]  drivers/nvme/target/passthru.o
  CC [M]  drivers/nvme/target/zns.o
  CC [M]  drivers/nvme/host/pci.o
  CC [M]  drivers/nvme/host/fabrics.o
  CC [M]  drivers/nvme/target/fabrics-cmd-auth.o
  CC [M]  drivers/nvme/target/auth.o
  CC [M]  drivers/nvme/target/trace.o
  CC [M]  drivers/nvme/host/rdma.o
  CC [M]  drivers/nvme/target/loop.o
  CC [M]  drivers/nvme/host/fc.o
  CC [M]  drivers/nvme/target/rdma.o
  CC [M]  drivers/nvme/host/tcp.o
  CC [M]  drivers/nvme/target/fc.o
  CC [M]  drivers/nvme/target/fcloop.o
  CC [M]  drivers/nvme/target/tcp.o
  LD [M]  drivers/nvme/common/nvme-common.o
  LD [M]  drivers/nvme/host/nvme-fabrics.o
  LD [M]  drivers/nvme/target/nvme-fcloop.o
  LD [M]  drivers/nvme/target/nvme-loop.o
  LD [M]  drivers/nvme/target/nvmet.o
  LD [M]  drivers/nvme/target/nvmet-fc.o
  LD [M]  drivers/nvme/host/nvme-rdma.o
  LD [M]  drivers/nvme/target/nvmet-tcp.o
  LD [M]  drivers/nvme/host/nvme-fc.o
  LD [M]  drivers/nvme/host/nvme.o
  LD [M]  drivers/nvme/host/nvme-tcp.o
  LD [M]  drivers/nvme/target/nvmet-rdma.o
  LD [M]  drivers/nvme/host/nvme-core.o
  MODPOST drivers/nvme/Module.symvers
  CC [M]  drivers/nvme/host/nvme-core.mod.o
  CC [M]  drivers/nvme/host/nvme.mod.o
  CC [M]  drivers/nvme/host/nvme-fabrics.mod.o
  CC [M]  drivers/nvme/host/nvme-rdma.mod.o
  CC [M]  drivers/nvme/host/nvme-fc.mod.o
  CC [M]  drivers/nvme/host/nvme-tcp.mod.o
  CC [M]  drivers/nvme/target/nvmet.mod.o
  CC [M]  drivers/nvme/target/nvme-loop.mod.o
  CC [M]  drivers/nvme/target/nvmet-rdma.mod.o
  CC [M]  drivers/nvme/target/nvmet-fc.mod.o
  CC [M]  drivers/nvme/target/nvme-fcloop.mod.o
  CC [M]  drivers/nvme/target/nvmet-tcp.mod.o
  CC [M]  drivers/nvme/common/nvme-common.mod.o
  LD [M]  drivers/nvme/host/nvme-core.ko
  LD [M]  drivers/nvme/host/nvme-fabrics.ko
  LD [M]  drivers/nvme/host/nvme.ko
  LD [M]  drivers/nvme/host/nvme-fc.ko
  LD [M]  drivers/nvme/host/nvme-rdma.ko
  LD [M]  drivers/nvme/target/nvmet-rdma.ko
  LD [M]  drivers/nvme/target/nvmet.ko
  LD [M]  drivers/nvme/host/nvme-tcp.ko
  LD [M]  drivers/nvme/target/nvme-loop.ko
  LD [M]  drivers/nvme/target/nvme-fcloop.ko
  LD [M]  drivers/nvme/target/nvmet-tcp.ko
  LD [M]  drivers/nvme/target/nvmet-fc.ko
  LD [M]  drivers/nvme/common/nvme-common.ko
+ HOST=drivers/nvme/host
+ TARGET=drivers/nvme/target
++ uname -r
+ HOST_DEST=/lib/modules/6.3.0-rc2nvme+/kernel/drivers/nvme/host/
++ uname -r
+ TARGET_DEST=/lib/modules/6.3.0-rc2nvme+/kernel/drivers/nvme/target/
+ cp drivers/nvme/host/nvme-core.ko drivers/nvme/host/nvme-fabrics.ko drivers/nvme/host/nvme-fc.ko drivers/nvme/host/nvme.ko drivers/nvme/host/nvme-rdma.ko drivers/nvme/host/nvme-tcp.ko /lib/modules/6.3.0-rc2nvme+/kernel/drivers/nvme/host//
+ cp drivers/nvme/target/nvme-fcloop.ko drivers/nvme/target/nvme-loop.ko drivers/nvme/target/nvmet-fc.ko drivers/nvme/target/nvmet.ko drivers/nvme/target/nvmet-rdma.ko drivers/nvme/target/nvmet-tcp.ko /lib/modules/6.3.0-rc2nvme+/kernel/drivers/nvme/target//
+ ls -lrth /lib/modules/6.3.0-rc2nvme+/kernel/drivers/nvme/host/ /lib/modules/6.3.0-rc2nvme+/kernel/drivers/nvme/target//
/lib/modules/6.3.0-rc2nvme+/kernel/drivers/nvme/host/:
total 7.5M
-rw-r--r--. 1 root root 3.5M Apr  8 14:59 nvme-core.ko
-rw-r--r--. 1 root root 477K Apr  8 14:59 nvme-fabrics.ko
-rw-r--r--. 1 root root 974K Apr  8 14:59 nvme-fc.ko
-rw-r--r--. 1 root root 783K Apr  8 14:59 nvme.ko
-rw-r--r--. 1 root root 925K Apr  8 14:59 nvme-rdma.ko
-rw-r--r--. 1 root root 900K Apr  8 14:59 nvme-tcp.ko

/lib/modules/6.3.0-rc2nvme+/kernel/drivers/nvme/target//:
total 7.3M
-rw-r--r--. 1 root root 529K Apr  8 14:59 nvme-fcloop.ko
-rw-r--r--. 1 root root 469K Apr  8 14:59 nvme-loop.ko
-rw-r--r--. 1 root root 799K Apr  8 14:59 nvmet-fc.ko
-rw-r--r--. 1 root root 4.0M Apr  8 14:59 nvmet.ko
-rw-r--r--. 1 root root 891K Apr  8 14:59 nvmet-rdma.ko
-rw-r--r--. 1 root root 751K Apr  8 14:59 nvmet-tcp.ko
+ sync
+ sync
+ sync
+ modprobe nvme
+ echo 'Press enter to continue ...'
Press enter to continue ...
nvme (nvme-6.4) # dmesg  -c > /dev/null
nvme (nvme-6.4) # 
nvme (nvme-6.4) # 
bash: cho: command not found...
nvme (nvme-6.4) # echo 1 > /sys/class/nvme/nvme0/passthru_err_log 
nvme (nvme-6.4) # echo "############ TEST Admin Command error ###################"
############ TEST Admin Command error ###################
nvme (nvme-6.4) # nvme telemetry-log -o /tmp/test /dev/nvme0  
NVMe status: Invalid Field in Command: A reserved coded value or an unsupported value in a defined field(0x4002)
Failed to acquire telemetry log 16386!
nvme (nvme-6.4) # dmesg  -c 
[50359.040637] nvme0: Get Log Page(0x2), Invalid Field in Command (sct 0x0 / sc 0x2) DNR cdw10=0x7f0107 cdw11=0x0 cdw12=0x0 cdw13=0x0 cdw14=0x0 cdw15=0x0
nvme (nvme-6.4) # echo "############ TEST I/O Command error ###################"
############ TEST I/O Command error ###################
nvme (nvme-6.4) # nvme write-zeroes -n 1 -s 0x200000 -c 10 /dev/nvme0
NVMe status: LBA Out of Range: The command references an LBA that exceeds the size of the namespace(0x4080)
nvme (nvme-6.4) # 
o

-- 
2.29.0


