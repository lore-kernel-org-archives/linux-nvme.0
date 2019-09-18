Return-Path: <SRS0=vpxS=XN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B65C4CEC4
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 14:22:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3952067B
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 14:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VHXlQprP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Xp4sTPJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3952067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VENDmABPJP8CtZ5fwEjO7giG67yfu0rjMui49nrVF0o=; b=VHXlQprPvjvRcCJyhrJhATujE
	OzO+59nKOmcrEaytzUo20dM4+IYg0BHzuGzoawsw4ZS3gk9Br8l2En1YynktQXvBtvXd5VFZAJga/
	uWvRexpYDav8Xil5yQnBMCDhr62W2pQQBnkXV3kSEiybwYD/myT/6fInatwlrX09uIYXCWIXNw5es
	wd3eoyVgpDtW85JSP1UonHTnRFwUDoYhG+RRbR8VpFPNcIYwWB2dK7FbW5VD5RtnXXjyegIMjJzhU
	cm5OnPX2EqcMNADCEnhCiz45zGlGgUNjAVjHs8kmr94w7lHCx4In1kuSJzeA31Tg3jzJvu0HlZfWY
	R+2G1dTCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAaqm-0007i8-2J; Wed, 18 Sep 2019 14:22:32 +0000
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAaqi-0007hm-KB
 for linux-nvme@lists.infradead.org; Wed, 18 Sep 2019 14:22:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mL3s2VP4YY6pTIo1HboUAAbaiDyz0yQ5hjcQomgBWV0QcvdQTDz8BVTsRStYKmdqoJKdncTLpcG97Qq6JkB7VS0jQZ0pRaxGdeLXs8/DoJ5J8R7p/7BQt3/aRwSDSldjixB9ROshYa+Jq7HLAZtYWQ6DBqOTDBjMr8xqsLFrl1oOGlTFyFfsEZK77fTHAV/4EnsOG9OwvlqXs1aLsBPrpnQnNehKJsyqF4RobWXZ+hauzWRW6sWShsMMLrfw723mX90X/fW/AXjqhrR8Rkb/i/59321mMn6L1Dqxi3lQ3J3t4/0GL7cnY4JVRKcN4xV/nlKEUqsEXZFkQ4NufHX36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQtp52QylBsYILbr04GbSiMV8/EkRFtHB3CbvXoB+t0=;
 b=W9Y6nsR2Q9pnvCUh2VbsNIkj9Go03wJa1RA8xu91NrozebBP8gT4cbnVp9DlOeKhFx21X139ddRYSN/2HhSkoiy8Ue6cRtSGlhBM0w+wddTGt2y7SFfLZtbQMM6mRRLeitzAjJadE/JRIAau3Hm9+u6mJFK3hywm5naEvZPMJL2sPywoI6f+/G/P33pyMMNP2WVhqNuD/jedVCwXWrx3Ais2zm+T9tbLPfplZCnEWTaiOpefcy4mMLCZCZhxZA0IAbhWiqt/uoivAYA/JcpDgxy8lVE8yLhRFB7G8NtCq/USOb/Y/xrxlkxwb5WxLM/EVwujenZCiSjKXvTt8eVXdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=grimberg.me smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQtp52QylBsYILbr04GbSiMV8/EkRFtHB3CbvXoB+t0=;
 b=Xp4sTPJdTNnY9pOlpy8xO/oZZEsqPz7UEX/eU3gdi5NZxqBt9uTwQEATheSNt8wb0l+x5J5qgyR4MHhC7/ra7OvRoQZ344LukrPNzns+h1DCI9yEZLbS5kiF7AnFA5I8d58WPTBLIB89dD2xLFXC2mEbB7Rz5DALwRgj+6kdFLY=
Received: from HE1PR05CA0201.eurprd05.prod.outlook.com (2603:10a6:3:f9::25) by
 AM6PR05MB5831.eurprd05.prod.outlook.com (2603:10a6:20b:94::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 14:22:25 +0000
Received: from DB5EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by HE1PR05CA0201.outlook.office365.com
 (2603:10a6:3:f9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.15 via Frontend
 Transport; Wed, 18 Sep 2019 14:22:24 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT051.mail.protection.outlook.com (10.152.21.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2284.20 via Frontend Transport; Wed, 18 Sep 2019 14:22:24 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 18 Sep 2019 17:22:23
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 18 Sep 2019 17:22:23 +0300
Received: from [10.223.0.54] (10.223.0.54) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 18 Sep 2019 17:21:38
 +0300
Subject: Re: NVMeoF RDMA IB: I/O timeout and NULL pointer observed during
 rescan_controller/reset_controller with fio background
To: Yi Zhang <yi.zhang@redhat.com>, <linux-nvme@lists.infradead.org>
References: <1437535598.446597.1568798016422.JavaMail.zimbra@redhat.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <2ea07772-3905-fb82-4d73-7458a963677c@mellanox.com>
Date: Wed, 18 Sep 2019 17:21:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1437535598.446597.1568798016422.JavaMail.zimbra@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.223.0.54]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(51234002)(189003)(199004)(4326008)(8676002)(305945005)(81166006)(45080400002)(81156014)(478600001)(8936002)(8746002)(356004)(3846002)(6116002)(50466002)(31686004)(70586007)(70206006)(7736002)(36756003)(6246003)(6306002)(2906002)(229853002)(65806001)(65956001)(47776003)(486006)(23676004)(186003)(16526019)(5660300002)(16576012)(316002)(11346002)(14444005)(110136005)(31696002)(86362001)(2616005)(446003)(476003)(58126008)(126002)(2486003)(53546011)(76176011)(26005)(336012)(106002)(966005)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR05MB5831; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53bd9df0-ee77-41e0-f3c8-08d73c43a05b
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:AM6PR05MB5831; 
X-MS-TrafficTypeDiagnostic: AM6PR05MB5831:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <AM6PR05MB583122D31C1E630FD4D91B2AB68E0@AM6PR05MB5831.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:146;
X-Forefront-PRVS: 01644DCF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: TAKRCp8Aitn88KxusqwWeyiloZvNL43pouXDCKuJDGmyTZGBmt76c9srqyKEzbeIHLDw+pT728tRaK823Zjn8pHTOJLhK0o7kOD9A3ttxZqMHlpGiSRfu+VviwkghRCFxkt7MnMWtMVERZ/GcidrJCDkSy7BVdZoHhAp19V77lUyiwzjqewW9MRHWntwNXvg8PD4jdTFcbPzjU0koP+G20f6GwyA8h08kPh22wPlVff2DHctJOPqO6XNx8GO/dML+A+Ia53KNZB6oe6tKqPW6lFrUGVmdljRsAMdLmop7xcQujLM+9afkBbADtHFHPUI5BhZA/SrfcoThUEVrzIEYn4oqI3xH7/8jbA928xV/RTIRv7rMNisWhbDICIUZYQXyk9/5SLceOUg5aaElPJQ64aASKdvPq29DaeWyq2AveI=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2019 14:22:24.3427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bd9df0-ee77-41e0-f3c8-08d73c43a05b
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5831
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190918_072228_727993_42EE5E12 
X-CRM114-Status: GOOD (  11.08  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 9/18/2019 12:13 PM, Yi Zhang wrote:
> Hello
> I observed bellow I/O timeout and NULL pointer on 5.3.0, pls help check it, let me know if you need more info or test patch, thanks

Hi,

Can you try to repro it with older kernel (5.2.0) ?

I want to understand if its a regression from the last few months...


>
> reproducer:
> 1. do fio background testing
> 2. stress rescan/reset_controller operation
> echo 1 > /sys/block/nvme2n1/device/nvme2/rescan_controller
> echo 1 > /sys/block/nvme2n1/device/nvme2/reset_controller
>
> kernel log:
> [  384.865550] nvme nvme2: creating 48 I/O queues.
> [  386.784069] nvme nvme2: creating 48 I/O queues.
> [  387.771002] nvme_ns_head_make_request: 159989 callbacks suppressed
> [  387.771004] block nvme2n1: no usable path - requeuing I/O
> [  387.771012] block nvme2n1: no usable path - requeuing I/O
> [  387.771051] block nvme2n1: no usable path - requeuing I/O
> [  387.771061] block nvme2n1: no usable path - requeuing I/O
> [  387.771065] block nvme2n1: no usable path - requeuing I/O
> [  387.771070] block nvme2n1: no usable path - requeuing I/O
> [  387.771077] block nvme2n1: no usable path - requeuing I/O
> [  387.771124] block nvme2n1: no usable path - requeuing I/O
> [  387.771146] block nvme2n1: no usable path - requeuing I/O
> [  387.771155] block nvme2n1: no usable path - requeuing I/O
> [  449.670780] nvme nvme2: I/O 0 QID 0 timeout
> [  449.691674] nvme nvme2: Connect command failed, error wo/DNR bit: 7
> [  449.697974] BUG: kernel NULL pointer dereference, address: 00000000000000c8
> [  449.704945] #PF: supervisor read access in kernel mode
> [  449.710082] #PF: error_code(0x0000) - not-present page
> [  449.715221] PGD 0 P4D 0
> [  449.717761] Oops: 0000 [#1] SMP PTI
> [  449.721254] CPU: 45 PID: 1145 Comm: kworker/u98:2 Not tainted 5.3.0 #12
> [  449.727866] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS 2.2.11 06/13/2019
> [  449.735448] Workqueue: nvme-reset-wq nvme_rdma_reset_ctrl_work [nvme_rdma]
> [  449.742325] RIP: 0010:rdma_disconnect+0x2e/0x90 [rdma_cm]
> [  449.747722] Code: 00 55 53 48 89 fb 48 8b bf a8 02 00 00 48 85 ff 74 65 48 8b 0b 0f b6 83 c0 01 00 00 48 69 c0 b8 00 00 00 48 03 81 80 04 00 00 <8b> 40 10 a8 04 75 0d a8 08 74 42 5b 31 f6 5d e9 fe 72 b2 ff 48 89
> [  449.766466] RSP: 0018:ffffb01f87323de0 EFLAGS: 00010206
> [  449.771693] RAX: 00000000000000b8 RBX: ffff9e4d5a474c00 RCX: ffff9e4d5a475c00
> [  449.778825] RDX: 0000000000000819 RSI: ffff9e4dffb96b88 RDI: ffff9e41af404e00
> [  449.785956] RBP: 0000000000000000 R08: 00000000000008e7 R09: 000000000000002d
> [  449.793098] R10: ffffb01f87323df8 R11: ffffb01f87323ac0 R12: 0000000000000007
> [  449.800229] R13: ffff9e4db1332000 R14: ffff9e42045e2540 R15: ffff9e4db1332000
> [  449.807361] FS:  0000000000000000(0000) GS:ffff9e4dffb80000(0000) knlGS:0000000000000000
> [  449.815456] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  449.821195] CR2: 00000000000000c8 CR3: 000000183e60a003 CR4: 00000000007606e0
> [  449.828327] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  449.835457] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  449.842581] PKRU: 55555554
> [  449.845287] Call Trace:
> [  449.847758]  nvme_rdma_start_queue+0x8f/0xc0 [nvme_rdma]
> [  449.853070]  nvme_rdma_setup_ctrl+0x4ef/0x6a0 [nvme_rdma]
> [  449.858469]  nvme_rdma_reset_ctrl_work+0x4e/0x70 [nvme_rdma]
> [  449.864132]  process_one_work+0x1a1/0x360
> [  449.868140]  worker_thread+0x1c9/0x380
> [  449.871894]  ? process_one_work+0x360/0x360
> [  449.876081]  kthread+0x10c/0x130
> [  449.879310]  ? kthread_create_on_node+0x60/0x60
> [  449.883846]  ret_from_fork+0x35/0x40
> [  449.887422] Modules linked in: nvme_rdma nvme_fabrics nvmet_rdma nvmet 8021q garp mrp stp llc ib_isert iscsi_target_mod ib_srpt target_core_mod ib_srp scsi_transport_srp iw_cxgb4 libcxgb mlx5_ib vfat fat opa_vnic ib_umad ib_ipoib intel_rapl_msr intel_rapl_common isst_if_common rpcrdma sunrpc skx_edac nfit rdma_ucm libnvdimm ib_iser rdma_cm x86_pkg_temp_thermal intel_powerclamp iw_cm ib_cm coretemp libiscsi kvm_intel scsi_transport_iscsi hfi1 kvm iTCO_wdt iTCO_vendor_support dcdbas ipmi_ssif irqbypass rdmavt bnxt_re crct10dif_pclmul crc32_pclmul ib_uverbs ghash_clmulni_intel intel_cstate intel_uncore ib_core dell_smbios mei_me ipmi_si intel_rapl_perf wmi_bmof dell_wmi_descriptor pcspkr sg mei i2c_i801 lpc_ich ipmi_devintf ipmi_msghandler acpi_power_meter xfs libcrc32c sd_mod mgag200 i2c_algo_bit drm_vram_helper mlx5_core ttm drm_kms_helper syscopyarea sysfillrect sysimgblt ahci fb_sys_fops nvme libahci csiostor drm cxgb4 bnxt_en crc32c_intel nvme_core libata megaraid_sas scsi_tra
 nsport_fc
> [  449.887456]  mlxfw tg3 wmi dm_mirror dm_region_hash dm_log dm_mod
> [  449.980847] CR2: 00000000000000c8
> [  449.984182] ---[ end trace aeab63ac2e6510db ]---
> [  450.046884] RIP: 0010:rdma_disconnect+0x2e/0x90 [rdma_cm]
> [  450.052282] Code: 00 55 53 48 89 fb 48 8b bf a8 02 00 00 48 85 ff 74 65 48 8b 0b 0f b6 83 c0 01 00 00 48 69 c0 b8 00 00 00 48 03 81 80 04 00 00 <8b> 40 10 a8 04 75 0d a8 08 74 42 5b 31 f6 5d e9 fe 72 b2 ff 48 89
> [  450.071027] RSP: 0018:ffffb01f87323de0 EFLAGS: 00010206
> [  450.076255] RAX: 00000000000000b8 RBX: ffff9e4d5a474c00 RCX: ffff9e4d5a475c00
> [  450.083387] RDX: 0000000000000819 RSI: ffff9e4dffb96b88 RDI: ffff9e41af404e00
> [  450.090517] RBP: 0000000000000000 R08: 00000000000008e7 R09: 000000000000002d
> [  450.097642] R10: ffffb01f87323df8 R11: ffffb01f87323ac0 R12: 0000000000000007
> [  450.104774] R13: ffff9e4db1332000 R14: ffff9e42045e2540 R15: ffff9e4db1332000
> [  450.111899] FS:  0000000000000000(0000) GS:ffff9e4dffb80000(0000) knlGS:0000000000000000
> [  450.119985] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  450.125729] CR2: 00000000000000c8 CR3: 000000183e60a003 CR4: 00000000007606e0
> [  450.132853] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  450.139987] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  450.147118] PKRU: 55555554
> [  450.149831] Kernel panic - not syncing: Fatal exception
> [  450.155135] Kernel Offset: 0x17200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [  450.224883] ---[ end Kernel panic - not syncing: Fatal exception ]---
>
> # gdb /lib/modules/5.3.0/kernel/drivers/nvme/host/nvme-rdma.ko
> Reading symbols from /lib/modules/5.3.0/kernel/drivers/nvme/host/nvme-rdma.ko...done.
>
> (gdb) l *(nvme_rdma_start_queue+0x8f)
> 0x65f is in nvme_rdma_start_queue (drivers/nvme/host/rdma.c:568).
> 563	}
> 564	
> 565	static void __nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
> 566	{
> 567		rdma_disconnect(queue->cm_id);
> 568		ib_drain_qp(queue->qp);
> 569	}
> 570	
> 571	static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
> 572	{
> (gdb)
>
> # lspci | grep -i mel
> 3b:00.0 Infiniband controller: Mellanox Technologies MT27800 Family [ConnectX-5]
>
>
>
> Best Regards,
>    Yi Zhang
>
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> https://eur03.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&amp;data=02%7C01%7Cmaxg%40mellanox.com%7C81816cef9009489a9a9608d73c1887fd%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C1%7C637043948365925030&amp;sdata=xDFYdW4FFjVGrqJ74xlr4tTN4hs4Qwwvt7eaGoui%2F%2Fg%3D&amp;reserved=0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
