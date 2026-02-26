Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B162AFD4609
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 02:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BTYCdFy5XF1WcVGlkXFfAd2liIM1AgmUuFoTDc0IJlk=; b=HmL39fE1svlcwhSXLv53lGZumF
	YS5bT1qLacGaUX7lIUNcg6BaogIB/ScliwSH5ZiKfkcsnjZWSxVXxqU5VufbX8E5phazgaCpNDEca
	uml55Fmj8Rljbu/aQJTQ7H5pMJQWJoA8/Lfs3/V8sFnp82hG8YkZsWb9HvVpAl+GX6RDRWtxPtKUe
	W71KkoKGozmsp5f7OvT/csqFhW+FyMJuGSQWNheHXoeF8YLbGZWTtJsOPdRacqDkBVtNn4v05oqAQ
	y8Czp+wrfqd5Id4Yq0VyqI8yxWRgfj8HHAlEiFVbwUghKmlwS6Hjm+v5uS/LkA5fcRUIQm+5cOZpN
	hBc/dw2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvRZh-00000005H8M-2Rci;
	Thu, 26 Feb 2026 02:58:01 +0000
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvRZe-00000005H7e-0nvl
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 02:57:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqNHQdbaUDWiINfpHakikw6uS65Z1HE4JgicKj0QZZOFHaollKX+qQEYlSqh7kVP3rDtu/D2+1F2CgR0TCQFE1J8dSfw1iwV+yfnxDVk2gRjkMIkD3XO8+/f/QIRsV8rupQrDIV07pcvV4SW80j2phTxe1tAZj5IoTmB1TuyIiF1CW43ChzUiVuKm8fRDDpKTQYgyL7v30UI+dzxQCdogd8wXnWLd/SsXsou+esZzG1lIbT799fg5nsFIjlfob3mjyqOPx2S3H+92PbwOKIIVh4FlcXukdEi7jz9o/hZvUrvlWgREX5G7B54D93mVM2Kqm7aj4SNS3cZ/FplvB4quw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTYCdFy5XF1WcVGlkXFfAd2liIM1AgmUuFoTDc0IJlk=;
 b=CTrGGOlxkSOt30lyR3qen4TuzpbsxThcME0og4cbuJ02T5zkSjgDs4JVbCxuAaKsMRdpmk/amnEAzys0kKYNJIB00BqWKa6m8aM5W4H7KjebBUcb4PiZFxVU9vsBobBzbpIt1GI6Xas6AF/VaQaHwTwRJKYBd6CfZhoR+iyM7qil2/evWcl3oj79nY7m0jbq0EZUQt8k7+IYEt3OycBE6enG7daw3hsHTeOIQQAOtw3+zPt/aQv0UzuFimcocTkVtTp9Jva3Y6qUOsqgEX8tJSaSD/UsMJ1JrmPaTxh0yETnOOdAp/lWhzOkGP0j+aQuVqCcFWOlwn0/dV3utpLeFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTYCdFy5XF1WcVGlkXFfAd2liIM1AgmUuFoTDc0IJlk=;
 b=hYkzKSRHjaDY5AfeopgWM8y/OhJCeztYQbo6el5CffUjKPoA8DKuU2UMVP2tJM2qu1KdyqXeEABTRBTNkMFFT1Ga2NBqAFVuLerUGPoTcURsQscHXTdpYbtxePOFkECDBtE3uaTzto966iN8cZIWZ8ktz5giHcwOqpEOSRTabuKniTAuxOUAH2OuCE3FNRdOAL4K5CC6VjviW1PuxEe9fvtEgUOWN+sqJaFM/sOmYn9T21w7MHRzzYftIU38T30VVDHdbiDSqxDSEwSr9RGF2xM2gjErTvdkTcD4d6GhWmTPGW9FM/78uDDJFxvdgDrkswqm1oVJiYURu/q/h5//tQ==
Received: from MN2PR03CA0011.namprd03.prod.outlook.com (2603:10b6:208:23a::16)
 by IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 02:57:45 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:23a:cafe::e2) by MN2PR03CA0011.outlook.office365.com
 (2603:10b6:208:23a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 02:57:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 02:57:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 18:57:33 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 18:57:32 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<nilay@linux.ibm.com>, <hare@suse.de>, <dwagner@suse.de>
CC: <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V3] nvme-tcp: teardown circular lockng fixes
Date: Wed, 25 Feb 2026 18:56:58 -0800
Message-ID: <20260226025658.86496-1-kch@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|IA1PR12MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: bc53a642-a32b-4e47-67a8-08de74e2d152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info: Vo7cyC+PCAfeeMzJH4JlPzaSFvHf6+peXVWz6f++/bXaDasnmwIG/UOfNr3zGbSxmr2Qph919wbP9VB6WbQRPAbzVQ65dYaYIJaJ4CkLiHsTJkCtvEe7CnuvTGCqLz9bykgP0tGy4FisOs6mc0Q9PtzO9EM0GBqadXzPo3SDI5dkFBx1rOS9hh5hl2rHKpytDB3CVruMZ74lerdJZjqgKKV7H3kFvHG0JrvtAUX5NiRTVUyzPwQWN2K8oO60NA/FG8+fQ+otklzRWl1b/wPFYSdLmClxyHZdQ4Rjhw2KxgBnAeztNJ1GOUD6xtHXgdBUKhYvNNLTgIT19b7T/GEJV/AdwdBDKi2QCxmlLhtRHETz48/9DtyFjnfJQL3M3YxZ1ZshsvkUBN4e94I/wqrbFXECEMnxp4tb2Sa2m6Khf+pvE4ibCXG0OduIdPqjwUGH7CK3pUrX5ErApSA5wJ3kUMr2y9t64WAcVNBBmJ/eXZXQ8QtHsLYfnn+REGGR6liXVOIK+XYoWxwtMwiPCM4e4QhQTNnU7H5Kh97ozz71g40WrkVWRie3O9JG5b0vBiJtAXU1lqw/K5XJjb8UAq64z+LGt/ki97/8/fyMlDC7h1fMdgvHGjSbegUfzaI4DdoRFwEQUsvOsk9A29YHUtXp42cGZ39f9bU66TJc5RfVvSULQzVVine0LEsZCitX4UvS6QKInGmDDIIw5lC3K+3kReqGvSE04A25PM9ZWfaVkfbxkMMPcWPnJeY/JImCp/yjJMehgJyA+HPiSYhaQpEr1K8A+eDPVDug6nP0+CikQv4DUFYMSNvGv9zfwZRkpX/Lnfz9KAA77SNb0QhWJ3se3g==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TxGsDeLrBj1RwLs8NpzKI4dy4eNyxwTbqv+OnxezEtpHYpOK79mKA0I2Nxl5dtKaPD9Eo5gXnKV4wvWTE5FIaJE2Y/0Oa78RjR1T3GFWgTtyY1QBrP9XwAl3O63dW5i9eVcqskE4oU4wEq34/WAk/+ZMp1QLcMddToYzJCKIhwWcDMGpElXQgbfomN3O2og3QMsLgb76paorUikDJ8iRurlb/u3Pdoh49rgf9Uo4M0TmoEI7oqrfcDNOrOuP1Ppywrbj3mUGSO7XIl9ZnXkSsH9gRMfY0WDqOL8hUgfzQ0/Ph3uILjMD0Hm66twVygqxUdqxav93bo0L/U+kn4v0Giv7T+fNeA5/j09rXBcc7HY/Eejvk2StmZ4c/OpzbzMd097aZ3nF/IcKrZNaTPTZq6cU97Wmf0B6tG/c2TrfH7WJpso6Qx+A3gPINs28nO4Q
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 02:57:45.4652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc53a642-a32b-4e47-67a8-08de74e2d152
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6580
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_185758_337069_8D4C40CF 
X-CRM114-Status: UNSURE (   9.29  )
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

When a controller reset is triggered via sysfs (by writing to
/sys/class/nvme/<nvmedev>/reset_controller), the reset work tears down
and re-establishes all queues. The socket release using fput() defers
the actual cleanup to task_work delayed_fput workqueue. This deferred
cleanup can race with the subsequent queue re-allocation during reset,
potentially leading to use-after-free or resource conflicts.

Replace fput() with __fput_sync() to ensure synchronous socket release,
guaranteeing that all socket resources are fully cleaned up before the
function returns. This prevents races during controller reset where
new queue setup may begin before the old socket is fully released.

* Call chain during reset:
  nvme_reset_ctrl_work()
    -> nvme_tcp_teardown_ctrl()
      -> nvme_tcp_teardown_io_queues()
        -> nvme_tcp_free_io_queues()
          -> nvme_tcp_free_queue()       <-- fput() -> __fput_sync()
      -> nvme_tcp_teardown_admin_queue()
        -> nvme_tcp_free_admin_queue()
          -> nvme_tcp_free_queue()       <-- fput() -> __fput_sync()
    -> nvme_tcp_setup_ctrl()             <-- race with deferred fput

memalloc_noreclaim_save() sets PF_MEMALLOC which is intended for tasks
performing memory reclaim work that need reserve access. While PF_MEMALLOC
prevents the task from entering direct reclaim (causing __need_reclaim() to
return false), it does not strip __GFP_IO from gfp flags. The allocator can
therefore still trigger writeback I/O when __GFP_IO remains set, which is
unsafe when the caller holds block layer locks.

Switch to memalloc_noio_save() which sets PF_MEMALLOC_NOIO. This causes
current_gfp_context() to strip __GFP_IO|__GFP_FS from every allocation in
the scope, making it safe to allocate memory while holding elevator_lock and
set->srcu.

* The issue can be reproduced using blktests:

  nvme_trtype=tcp ./check nvme/005
blktests (master) # nvme_trtype=tcp ./check nvme/005
nvme/005 (tr=tcp) (reset local loopback target)              [failed]
    runtime  0.725s  ...  0.798s
    something found in dmesg:
    [  108.473940] run blktests nvme/005 at 2025-11-22 16:12:20

    [...]
    ...
    (See '/root/blktests/results/nodev_tr_tcp/nvme/005.dmesg' for the entire message)
blktests (master) # cat /root/blktests/results/nodev_tr_tcp/nvme/005.dmesg
[  108.473940] run blktests nvme/005 at 2025-11-22 16:12:20
[  108.526983] loop0: detected capacity change from 0 to 2097152
[  108.555606] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  108.572531] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  108.613061] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  108.616832] nvme nvme0: creating 48 I/O queues.
[  108.630791] nvme nvme0: mapped 48/0/0 default/read/poll queues.
[  108.661892] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  108.746639] nvmet: Created nvm controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  108.748466] nvme nvme0: creating 48 I/O queues.
[  108.802984] nvme nvme0: mapped 48/0/0 default/read/poll queues.
[  108.829983] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[  108.854288] block nvme0n1: no available path - failing I/O
[  108.854344] block nvme0n1: no available path - failing I/O
[  108.854373] Buffer I/O error on dev nvme0n1, logical block 1, async page read

[  108.891693] ======================================================
[  108.895912] WARNING: possible circular locking dependency detected
[  108.900184] 6.17.0nvme+ #3 Tainted: G                 N
[  108.903913] ------------------------------------------------------
[  108.908171] nvme/2734 is trying to acquire lock:
[  108.911957] ffff88810210e610 (set->srcu){.+.+}-{0:0}, at: __synchronize_srcu+0x17/0x170
[  108.917587]
               but task is already holding lock:
[  108.921570] ffff88813abea198 (&q->elevator_lock){+.+.}-{4:4}, at: elevator_change+0xa8/0x1c0
[  108.927361]
               which lock already depends on the new lock.

[  108.933018]
               the existing dependency chain (in reverse order) is:
[  108.938223]
               -> #4 (&q->elevator_lock){+.+.}-{4:4}:
[  108.942988]        __mutex_lock+0xa2/0x1150
[  108.945873]        elevator_change+0xa8/0x1c0
[  108.948925]        elv_iosched_store+0xdf/0x140
[  108.952043]        kernfs_fop_write_iter+0x16a/0x220
[  108.955367]        vfs_write+0x378/0x520
[  108.957598]        ksys_write+0x67/0xe0
[  108.959721]        do_syscall_64+0x76/0xbb0
[  108.962052]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  108.965145]
               -> #3 (&q->q_usage_counter(io)){++++}-{0:0}:
[  108.968923]        blk_alloc_queue+0x30e/0x350
[  108.972117]        blk_mq_alloc_queue+0x61/0xd0
[  108.974677]        scsi_alloc_sdev+0x2a0/0x3e0
[  108.977092]        scsi_probe_and_add_lun+0x1bd/0x430
[  108.979921]        __scsi_add_device+0x109/0x120
[  108.982504]        ata_scsi_scan_host+0x97/0x1c0
[  108.984365]        async_run_entry_fn+0x2d/0x130
[  108.986109]        process_one_work+0x20e/0x630
[  108.987830]        worker_thread+0x184/0x330
[  108.989473]        kthread+0x10a/0x250
[  108.990852]        ret_from_fork+0x297/0x300
[  108.992491]        ret_from_fork_asm+0x1a/0x30
[  108.994159]
               -> #2 (fs_reclaim){+.+.}-{0:0}:
[  108.996320]        fs_reclaim_acquire+0x99/0xd0
[  108.998058]        kmem_cache_alloc_node_noprof+0x4e/0x3c0
[  109.000123]        __alloc_skb+0x15f/0x190
[  109.002195]        tcp_send_active_reset+0x3f/0x1e0
[  109.004038]        tcp_disconnect+0x50b/0x720
[  109.005695]        __tcp_close+0x2b8/0x4b0
[  109.007227]        tcp_close+0x20/0x80
[  109.008663]        inet_release+0x31/0x60
[  109.010175]        __sock_release+0x3a/0xc0
[  109.011778]        sock_close+0x14/0x20
[  109.013263]        __fput+0xee/0x2c0
[  109.014673]        delayed_fput+0x31/0x50
[  109.016183]        process_one_work+0x20e/0x630
[  109.017897]        worker_thread+0x184/0x330
[  109.019543]        kthread+0x10a/0x250
[  109.020929]        ret_from_fork+0x297/0x300
[  109.022565]        ret_from_fork_asm+0x1a/0x30
[  109.024194]
               -> #1 (sk_lock-AF_INET-NVME){+.+.}-{0:0}:
[  109.026634]        lock_sock_nested+0x2e/0x70
[  109.028251]        tcp_sendmsg+0x1a/0x40
[  109.029783]        sock_sendmsg+0xed/0x110
[  109.031321]        nvme_tcp_try_send_cmd_pdu+0x13e/0x260 [nvme_tcp]
[  109.034263]        nvme_tcp_try_send+0xb3/0x330 [nvme_tcp]
[  109.036375]        nvme_tcp_queue_rq+0x342/0x3d0 [nvme_tcp]
[  109.038528]        blk_mq_dispatch_rq_list+0x297/0x800
[  109.040448]        __blk_mq_sched_dispatch_requests+0x3db/0x5f0
[  109.042677]        blk_mq_sched_dispatch_requests+0x29/0x70
[  109.044787]        blk_mq_run_work_fn+0x76/0x1b0
[  109.046535]        process_one_work+0x20e/0x630
[  109.048245]        worker_thread+0x184/0x330
[  109.049890]        kthread+0x10a/0x250
[  109.051331]        ret_from_fork+0x297/0x300
[  109.053024]        ret_from_fork_asm+0x1a/0x30
[  109.054740]
               -> #0 (set->srcu){.+.+}-{0:0}:
[  109.056850]        __lock_acquire+0x1468/0x2210
[  109.058614]        lock_sync+0xa5/0x110
[  109.060048]        __synchronize_srcu+0x49/0x170
[  109.061802]        elevator_switch+0xc9/0x330
[  109.063950]        elevator_change+0x128/0x1c0
[  109.065675]        elevator_set_none+0x4c/0x90
[  109.067316]        blk_unregister_queue+0xa8/0x110
[  109.069165]        __del_gendisk+0x14e/0x3c0
[  109.070824]        del_gendisk+0x75/0xa0
[  109.072328]        nvme_ns_remove+0xf2/0x230 [nvme_core]
[  109.074365]        nvme_remove_namespaces+0xf2/0x150 [nvme_core]
[  109.076652]        nvme_do_delete_ctrl+0x71/0x90 [nvme_core]
[  109.078775]        nvme_delete_ctrl_sync+0x3b/0x50 [nvme_core]
[  109.081009]        nvme_sysfs_delete+0x34/0x40 [nvme_core]
[  109.083082]        kernfs_fop_write_iter+0x16a/0x220
[  109.085009]        vfs_write+0x378/0x520
[  109.086539]        ksys_write+0x67/0xe0
[  109.087982]        do_syscall_64+0x76/0xbb0
[  109.089577]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  109.091665]
               other info that might help us debug this:

[  109.095478] Chain exists of:
                 set->srcu --> &q->q_usage_counter(io) --> &q->elevator_lock

[  109.099544]  Possible unsafe locking scenario:

[  109.101708]        CPU0                    CPU1
[  109.103402]        ----                    ----
[  109.105103]   lock(&q->elevator_lock);
[  109.106530]                                lock(&q->q_usage_counter(io));
[  109.109022]                                lock(&q->elevator_lock);
[  109.111391]   sync(set->srcu);
[  109.112586]
                *** DEADLOCK ***

[  109.114772] 5 locks held by nvme/2734:
[  109.116189]  #0: ffff888101925410 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x67/0xe0
[  109.119143]  #1: ffff88817a914e88 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x10f/0x220
[  109.123141]  #2: ffff8881046313f8 (kn->active#185){++++}-{0:0}, at: sysfs_remove_file_self+0x26/0x50
[  109.126543]  #3: ffff88810470e1d0 (&set->update_nr_hwq_lock){++++}-{4:4}, at: del_gendisk+0x6d/0xa0
[  109.129891]  #4: ffff88813abea198 (&q->elevator_lock){+.+.}-{4:4}, at: elevator_change+0xa8/0x1c0
[  109.133149]
               stack backtrace:
[  109.134817] CPU: 6 UID: 0 PID: 2734 Comm: nvme Tainted: G                 N  6.17.0nvme+ #3 PREEMPT(voluntary)
[  109.134819] Tainted: [N]=TEST
[  109.134820] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[  109.134821] Call Trace:
[  109.134823]  <TASK>
[  109.134824]  dump_stack_lvl+0x75/0xb0
[  109.134828]  print_circular_bug+0x26a/0x330
[  109.134831]  check_noncircular+0x12f/0x150
[  109.134834]  __lock_acquire+0x1468/0x2210
[  109.134837]  ? __synchronize_srcu+0x17/0x170
[  109.134838]  lock_sync+0xa5/0x110
[  109.134840]  ? __synchronize_srcu+0x17/0x170
[  109.134842]  __synchronize_srcu+0x49/0x170
[  109.134843]  ? mark_held_locks+0x49/0x80
[  109.134845]  ? _raw_spin_unlock_irqrestore+0x2d/0x60
[  109.134847]  ? kvm_clock_get_cycles+0x14/0x30
[  109.134853]  ? ktime_get_mono_fast_ns+0x36/0xb0
[  109.134858]  elevator_switch+0xc9/0x330
[  109.134860]  elevator_change+0x128/0x1c0
[  109.134862]  ? kernfs_put.part.0+0x86/0x290
[  109.134864]  elevator_set_none+0x4c/0x90
[  109.134866]  blk_unregister_queue+0xa8/0x110
[  109.134868]  __del_gendisk+0x14e/0x3c0
[  109.134870]  del_gendisk+0x75/0xa0
[  109.134872]  nvme_ns_remove+0xf2/0x230 [nvme_core]
[  109.134879]  nvme_remove_namespaces+0xf2/0x150 [nvme_core]
[  109.134887]  nvme_do_delete_ctrl+0x71/0x90 [nvme_core]
[  109.134893]  nvme_delete_ctrl_sync+0x3b/0x50 [nvme_core]
[  109.134899]  nvme_sysfs_delete+0x34/0x40 [nvme_core]
[  109.134905]  kernfs_fop_write_iter+0x16a/0x220
[  109.134908]  vfs_write+0x378/0x520
[  109.134911]  ksys_write+0x67/0xe0
[  109.134913]  do_syscall_64+0x76/0xbb0
[  109.134915]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  109.134916] RIP: 0033:0x7fd68a737317
[  109.134917] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  109.134919] RSP: 002b:00007ffded1546d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  109.134920] RAX: ffffffffffffffda RBX: 000000000054f7e0 RCX: 00007fd68a737317
[  109.134921] RDX: 0000000000000001 RSI: 00007fd68a855719 RDI: 0000000000000003
[  109.134921] RBP: 0000000000000003 R08: 0000000030407850 R09: 00007fd68a7cd4e0
[  109.134922] R10: 00007fd68a65b130 R11: 0000000000000246 R12: 00007fd68a855719
[  109.134923] R13: 00000000304074c0 R14: 00000000304074c0 R15: 0000000030408660
[  109.134926]  </TASK>
[  109.962756] Key type psk unregistered

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---

v2->v3

1. Replace noreclaim with noio in the nvme_tcp_free_queue() (Nilay, Christoph)
2. Merge replacing noreclaim to noio into this patch (Hannes, Nilay)
   https://lore.kernel.org/linux-nvme/718aae86-a8dd-4b1d-9666-8d3a2bc5bc49@suse.de/

---
 drivers/nvme/host/tcp.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 74cbbf48a981..296b1c69ea63 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1438,18 +1438,32 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
-	unsigned int noreclaim_flag;
+	unsigned int noio_flag;
 
 	if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
 
 	page_frag_cache_drain(&queue->pf_cache);
 
-	noreclaim_flag = memalloc_noreclaim_save();
-	/* ->sock will be released by fput() */
-	fput(queue->sock->file);
+	/**
+	 * Prevent memory reclaim from triggering block I/O during socket
+	 * teardown. The socket release path fput -> tcp_close ->
+	 * tcp_disconnect -> tcp_send_active_reset may allocate memory, and
+	 * allowing reclaim to issue I/O could deadlock if we're being called
+	 * from block device teardown (e.g., del_gendisk -> elevator cleanup)
+	 * which holds locks that the I/O completion path needs.
+	 */
+	noio_flag = memalloc_noio_save();
+
+	/**
+	 * Release the socket synchronously. During reset in
+	 * nvme_reset_ctrl_work(), queue teardown is immediately followed by
+	 * re-allocation. fput() defers socket cleanup to delayed_fput_work
+	 * in workqueue context, which can race with new queue setup.
+	 */
+	__fput_sync(queue->sock->file);
 	queue->sock = NULL;
-	memalloc_noreclaim_restore(noreclaim_flag);
+	memalloc_noio_restore(noio_flag);
 
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
@@ -1901,8 +1915,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 err_rcv_pdu:
 	kfree(queue->pdu);
 err_sock:
-	/* ->sock will be released by fput() */
-	fput(queue->sock->file);
+	/* Use sync variant - see nvme_tcp_free_queue() for explanation */
+	__fput_sync(queue->sock->file);
 	queue->sock = NULL;
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
-- 
2.39.5


