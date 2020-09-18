Return-Path: <SRS0=7z9d=C3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA9EC43464
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 23:47:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795D22151B
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 23:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yYxQXCEM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=NETORG220063.onmicrosoft.com header.i=@NETORG220063.onmicrosoft.com header.b="JtVddpiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795D22151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hcdatainc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LoWT2rpdNAhzDNkvm4xlDANJFBl98qGW3uvvkwlBdoY=; b=yYxQXCEM24mX5JXUHtBwDaPqYi
	ER64ufJpwM52JQb/uOczl8KdqWPvXDPUCy76Jk+berl11/skwmr4+i/jBlGqf2VbK/W5sb0fdslgy
	rYXBiisnTr/yGXdz8kBBdPkFFM2hjSfNeFoygB+ZFYldy+Egdzj7w9HwbpNqJDfl3Eb9XwUYEgCCn
	g6AIvKM87HYZQMxEXmffDSllIwF9QGxK4cmjoC06+iNy1OMEe5UOxQi//iFSvrV2+cZbhOy5dewY9
	KxUsf2DhPpWYvxBF6D4peNN7a0L0JzyAwza3cF0tieT5ZuSPjDCOiVfOfHLHk2MGsVZL+KVOGusNy
	Fw/WmCfQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJQ6J-00077M-0U; Fri, 18 Sep 2020 23:47:35 +0000
Received: from mail-bn8nam11on2100.outbound.protection.outlook.com
 ([40.107.236.100] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJQ6E-000771-Sg
 for linux-nvme@lists.infradead.org; Fri, 18 Sep 2020 23:47:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hL4ZDDPBHueaJMyl1UCzQ8/tZCOWjcOhcZAmXQ4hRYooo6JUZVk7/wVvpG7muQ6dM6leuHBhIPYN4Xv9x5Xbrc0mFBXKQ9LjIvTmyRZt1C+YDxE4ORWx0nxM2dhl6mthodgrOjfQsBLMk0ubI7kZXTQLkSXkL8gpWA0OcIDeliFZ9qu2nJFAImhLp3tem0h64MNkoa+FyQxOc7KJyHPmkcV2QKFYvV6pKumJtnwRT6Eyz15cQuT/D63i3h5I2kU5zc/AISqKqe2qlNReqy6aTgukTvi4nvC5d5CNSI8xaKsPo17hdIfuFYvUMzBUK351ZzkNo9XqeomkzAPrEkPB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttCDw9sHzEAINrvd3LGY0Ud24Zg+YJAFGQxb0Kh2+Xc=;
 b=U2DKtd5WgmvuGn/GuY2IdE984q+zWeJFYQhKJrWLekuLsopIH+bbK4HFsMfj3wfyzikGVsS0xIDdpPEm/NEKic0fVeq8qMqkdEFXRPWlFGPqvuK5AgaqSZVUzb9HTHXyPo4gfeskwiOhAXDJhijotxBvaC0g1RZMAnbfrSZkzPkrpw1djeLwYz9NpzUviOCp/0yoBaXfhOVsxuWIPP8eX5JfJLzQEbppy39AcYkiLyOWuQoZTk988HVWJsVacG5kdVFVAhe7MD7TXmQR4psWLxE2icPIJvhHX5lhW8jLn7y+PIjqUoNU1rJ3a5P5+OrcqLxbbnYx4jYr6k96sYOIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hcdatainc.com; dmarc=pass action=none
 header.from=hcdatainc.com; dkim=pass header.d=hcdatainc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG220063.onmicrosoft.com; s=selector2-NETORG220063-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttCDw9sHzEAINrvd3LGY0Ud24Zg+YJAFGQxb0Kh2+Xc=;
 b=JtVddpiMXSxBn9hlFReMLI4y+beEf+6ywQ/RebGBFOUkFLVhm64fkwxpK79EKIpsFDlTj34DPbPSjunb6qZH2VmrK7uM/jlmbfflbCX136eJ1LQOHiS+vO76O0MZMbDR9QP9wC77HovXGoN1CsCQr6dz2+ZQz3ELisKiWDjf8jQ=
Received: from BYAPR10MB2456.namprd10.prod.outlook.com (2603:10b6:a02:b3::16)
 by BYAPR10MB3207.namprd10.prod.outlook.com (2603:10b6:a03:152::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 18 Sep
 2020 23:47:27 +0000
Received: from BYAPR10MB2456.namprd10.prod.outlook.com
 ([fe80::c430:480c:3ceb:566c]) by BYAPR10MB2456.namprd10.prod.outlook.com
 ([fe80::c430:480c:3ceb:566c%6]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 23:47:27 +0000
From: Meng Wang <meng@hcdatainc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: kernel panics when hot removing U.2 nvme disk
Thread-Topic: kernel panics when hot removing U.2 nvme disk
Thread-Index: AQHWjhX83+5IHgri4062+f1Cfnen/g==
Date: Fri, 18 Sep 2020 23:47:27 +0000
Message-ID: <BYAPR10MB24561C62C45813B7092E346BCB3F0@BYAPR10MB2456.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=hcdatainc.com;
x-originating-ip: [45.28.143.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38b73540-4d5b-4681-3070-08d85c2d3350
x-ms-traffictypediagnostic: BYAPR10MB3207:
x-microsoft-antispam-prvs: <BYAPR10MB320775A5F1909807276F5905CB3F0@BYAPR10MB3207.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:181;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7/YUZMPJkngYbICcO8SANsd6WtVO63gOFBhRDi5UbOjshaSEToY0L8AXuLaiL5fKB4kIMv+KA64HtbZhls4CciXF3lubA/C+otLXrT1rq6T4chzIS8Ypj597+QKaowsFiB03xNqfCtSyC/XZc51RFPWxUREQleV1CUgABX4asojKIt90Jga4Hg4HbPZiwtPkhvnHBW+Np86kMT6TZDywyN2gWFkzNZZSO0bEN1LVl9JKo/oDt4qC9fU3K0CSc76hK2m5/vNU5TeDjVbhOd/0Xbt9i9C+HY7mReDjK9cdNFLnMt8MWSqK0f0YWECRgLUpWWx75vDxgmuSMGnmK+bKLcYlanrjDEg2nrvuVt9YXAgK7gBhon7iXWt2zGDCi8Qj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2456.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(136003)(39830400003)(376002)(346002)(366004)(186003)(478600001)(5660300002)(9686003)(7696005)(52536014)(6916009)(316002)(66446008)(86362001)(33656002)(83380400001)(66476007)(66556008)(71200400001)(76116006)(55016002)(64756008)(6506007)(66946007)(26005)(8676002)(30864003)(45080400002)(8936002)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: VKD4+8ftyRTgio/2kLqwmxhnbOGwqXr6mCLux96exm4ns1tMqrlft7qyhMM714fM0kG2rORApsdrnvU8e0J0N0HfgjkBjsdUdFa3e1QQQR4eNzh8+cz/tYb5HQ991nLBsHvWH3cbuVRpLq2KPNV6+R2zeMv+qdBsLZlxzWEax8dbhxVJ7UGlh/RybRqh5sVn5VByY3qAVilHSl+0/34hesAoVPDTeZCdrPDSr9JZZxKxnhOfBC3KX/SV8I8y1qofyYMMkTwLMpnDCXia5a6qNyNsxnBWjdeyNQz9szy1M/jftunrD+hpL4CDFnBROhro+2asVILVI5og1tXE36U1TlmQpRnocAdHLTQP/cVvSDUsuOcwC4mpKlaiIrkohIldfj12wmMAur3e+snFLnDeZHUkCvLy4hQJUjNDqOD2Kc18ULYdP/ad6sOXLUQG0ljuQwPkmHZ5/ZRr6mYMrgcvTzKAu+jOGDdkLOwsmkVIrr0ltjPax6gZgj832n5MNT3ckAg3erL/dNZCqJXgWxetkKXjXyE0bxnTAf+aHPQhaZnSnFh4TS8w3XR2AYmx4wi6zb8AzQE0WaGx+yRy9F2nhQ+0Qo9CR6lNEbSt6K85/0rOwtckagOA31j9B+IDVKi0Ywg6sYvObNDkV5N0e3yP0Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hcdatainc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2456.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b73540-4d5b-4681-3070-08d85c2d3350
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 23:47:27.5083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8368637-8933-4f2c-a6d2-c0d726d49c7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2oNF0llxenLjrP25HI7v4wqejn+76T3HDvh/q623StxeeOoXIj7cEiqXU1IUDU2tHktvilRsCmhl5l2hb2+/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3207
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200918_194730_996142_4B509F0C 
X-CRM114-Status: UNSURE (   9.15  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,
We found kernel panics today when doing test on hot remove U.2 nvme disk. After hot remove the nvme disk (formatted as ext4), the system freezes and all services stuck. Lot of kernel message flushed the syslog, including the CPU soft lockup, ext4 NULL point er dereferece and ib nic transmission timeout. The kernel panics and configuration are shown below. The used kernel is 5.4.0-050400-generic and OS is Ubuntu 16.04. Not sure whether it's a known bug or configuration error. Any advise are welcome.

Thanks,
Meng

----------------------------------------------
kernel config regarding hot swap
----------------------------------------------
~$ cat /boot/config-5.4.0-050400-generic | grep -i HOT
CONFIG_TICK_ONESHOT=y
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_HOTPLUG_SMT=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
CONFIG_HOTPLUG_PCI_CPCI=y
CONFIG_HOTPLUG_PCI_CPCI_ZT5550=m
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=m
CONFIG_HOTPLUG_PCI_SHPC=y
CONFIG_DM_SNAPSHOT=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=y
CONFIG_XEN_BALLOON_MEMORY_HOTPLUG_LIMIT=512
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set

------------------------------------------------------
kernel panic snippet on cpu soft lockup
------------------------------------------------------
Sep 18 21:27:27 hcd56 kernel: [88463.800033] watchdog: BUG: soft lockup - CPU#38 stuck for 23s! [irq/27-pciehp:416]
Sep 18 21:27:27 hcd56 kernel: [88463.804076] ib0: transmit timeout: latency 20428 msecs
Sep 18 21:27:27 hcd56 kernel: [88463.807609] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace fscache ipmi_ssif intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass dax_pmem_compat device_dax nd_pmem dax_pmem_core nd_btt crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper intel_cstate input_leds intel_rapl_perf joydev mei_me mei lpc_ich ioatdma ipmi_si ipmi_devintf ipmi_msghandler nfit acpi_power_meter acpi_pad mac_hid iscsi_tcp libiscsi_tcp rdma_ucm mlx4_ib sunrpc ib_uverbs ib_umad ib_iser rdma_cm iw_cm libiscsi scsi_transport_iscsi ib_ipoib ib_cm ib_core parport_pc ppdev lp parport autofs4 btrfs xor zstd_compress raid6_pq libcrc32c mlx4_en hid_generic usbhid hid ast drm_vram_helper i2c_algo_bit ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops sfc mlx4_core mtd ixgbe drm ahci nvme xfrm_algo libahci nvme_core dca mdio wmi
Sep 18 21:27:27 hcd56 kernel: [88463.812748] ib0: queue stopped 1, tx_head 7638106, tx_tail 7637978
Sep 18 21:27:27 hcd56 kernel: [88463.894312] CPU: 38 PID: 416 Comm: irq/27-pciehp Tainted: G      D W         5.4.0-050400-generic #201911242031
Sep 18 21:27:27 hcd56 kernel: [88463.894313] Hardware name: Supermicro SYS-1028U-TN10RT+/X10DRU-i+, BIOS 3.1 06/08/2018
Sep 18 21:27:27 hcd56 kernel: [88463.894329] RIP: 0010:native_queued_spin_lock_slowpath+0x62/0x1d0
Sep 18 21:27:27 hcd56 kernel: [88463.894331] Code: 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 48 85 c0 74 0e 8b 07 84 c0 74 08 f3 90 8b 07 <84> c0 75 f8 b8 01 00 00 00 5d 66 89 07 c3 8b 37 81 fe 00 01 00 00
Sep 18 21:27:27 hcd56 kernel: [88463.894332] RSP: 0000:ffffb1da46eefa40 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
Sep 18 21:27:27 hcd56 kernel: [88463.894334] RAX: 0000000000000101 RBX: ffff9717c9abe380 RCX: ffffb1da46eefa9c
Sep 18 21:27:27 hcd56 kernel: [88463.894334] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9701e12d7b88
Sep 18 21:27:27 hcd56 kernel: [88463.894335] RBP: ffffb1da46eefa40 R08: ffffb1da46eef918 R09: 0000000000000000
Sep 18 21:27:27 hcd56 kernel: [88463.894336] R10: 0000000000000001 R11: ffff97183ffd4000 R12: ffff9717f9da0528
Sep 18 21:27:27 hcd56 kernel: [88463.894336] R13: ffff9701e12d7b88 R14: ffff9703fa860000 R15: ffff9717f9da0630
Sep 18 21:27:27 hcd56 kernel: [88463.894337] FS:  0000000000000000(0000) GS:ffff9717ffa80000(0000) knlGS:0000000000000000
Sep 18 21:27:27 hcd56 kernel: [88463.894338] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Sep 18 21:27:27 hcd56 kernel: [88463.894339] CR2: 00007fdd7bb3c000 CR3: 000000103564c002 CR4: 00000000003606e0
Sep 18 21:27:27 hcd56 kernel: [88463.894340] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Sep 18 21:27:27 hcd56 kernel: [88463.894340] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Sep 18 21:27:27 hcd56 kernel: [88463.894341] Call Trace:
Sep 18 21:27:27 hcd56 kernel: [88463.894359]  _raw_spin_lock+0x1e/0x30
Sep 18 21:27:27 hcd56 kernel: [88463.894376]  jbd2_journal_release_jbd_inode+0xb7/0x120
Sep 18 21:27:27 hcd56 kernel: [88464.032946]  ? ext4_es_remove_extent+0x82/0x100
Sep 18 21:27:27 hcd56 kernel: [88464.037480]  ext4_clear_inode+0x5f/0xa0
Sep 18 21:27:27 hcd56 kernel: [88464.041318]  ext4_evict_inode+0x60/0x5b0
Sep 18 21:27:27 hcd56 kernel: [88464.045234]  evict+0xd2/0x1b0
Sep 18 21:27:27 hcd56 kernel: [88464.048196]  dispose_list+0x39/0x50
Sep 18 21:27:27 hcd56 kernel: [88464.051680]  invalidate_inodes+0x160/0x190
Sep 18 21:27:27 hcd56 kernel: [88464.055773]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
Sep 18 21:27:27 hcd56 kernel: [88464.060730]  __invalidate_device+0x38/0x60
Sep 18 21:27:27 hcd56 kernel: [88464.064822]  invalidate_partition+0x32/0x50
Sep 18 21:27:27 hcd56 kernel: [88464.069006]  del_gendisk+0x117/0x2f0
Sep 18 21:27:27 hcd56 kernel: [88464.072582]  nvme_ns_remove+0xf6/0x140 [nvme_core]
Sep 18 21:27:27 hcd56 kernel: [88464.077371]  nvme_remove_namespaces+0x9f/0xe0 [nvme_core]
Sep 18 21:27:27 hcd56 kernel: [88464.082760]  nvme_remove+0x66/0x170 [nvme]
Sep 18 21:27:27 hcd56 kernel: [88464.086853]  pci_device_remove+0x3e/0xb0
Sep 18 21:27:27 hcd56 kernel: [88464.090770]  device_release_driver_internal+0xf0/0x1c0
Sep 18 21:27:27 hcd56 kernel: [88464.095898]  device_release_driver+0x12/0x20
Sep 18 21:27:27 hcd56 kernel: [88464.100165]  pci_stop_bus_device+0x70/0xa0
Sep 18 21:27:27 hcd56 kernel: [88464.104253]  pci_stop_and_remove_bus_device+0x13/0x20
Sep 18 21:27:27 hcd56 kernel: [88464.109301]  pciehp_unconfigure_device+0x80/0x12f
Sep 18 21:27:27 hcd56 kernel: [88464.114004]  pciehp_disable_slot+0x6e/0x100
Sep 18 21:27:27 hcd56 kernel: [88464.118182]  pciehp_handle_presence_or_link_change+0xe1/0x150
Sep 18 21:27:27 hcd56 kernel: [88464.123919]  pciehp_ist+0x122/0x130
Sep 18 21:27:27 hcd56 kernel: [88464.127401]  irq_thread_fn+0x28/0x60
Sep 18 21:27:27 hcd56 kernel: [88464.130973]  irq_thread+0xda/0x170
Sep 18 21:27:27 hcd56 kernel: [88464.134369]  ? irq_forced_thread_fn+0x80/0x80
Sep 18 21:27:27 hcd56 kernel: [88464.138724]  kthread+0x104/0x140
Sep 18 21:27:27 hcd56 kernel: [88464.141953]  ? irq_thread_check_affinity+0xf0/0xf0
Sep 18 21:27:27 hcd56 kernel: [88464.146736]  ? kthread_park+0x90/0x90
Sep 18 21:27:27 hcd56 kernel: [88464.150397]  ret_from_fork+0x35/0x40

---------------------------------------------------------------
kernel panic on ext4 NULL pointer dereference
---------------------------------------------------------------
Sep 18 21:27:00 hcd56 kernel: [88437.232231] VFS: busy inodes on changed media or resized disk nvme0n2
Sep 18 21:27:01 hcd56 kernel: [88437.577487] Aborting journal on device nvme0n2-8.
Sep 18 21:27:01 hcd56 kernel: [88437.582192] JBD2: Error -5 detected when updating journal superblock for nvme0n2-8.
Sep 18 21:27:01 hcd56 kernel: [88437.589853] BUG: kernel NULL pointer dereference, address: 0000000000000008
Sep 18 21:27:01 hcd56 kernel: [88437.596808] #PF: supervisor write access in kernel mode
Sep 18 21:27:01 hcd56 kernel: [88437.602026] #PF: error_code(0x0002) - not-present page
Sep 18 21:27:01 hcd56 kernel: [88437.607157] PGD 8000000b59cba067 P4D 8000000b59cba067 PUD fa8d3d067 PMD 0
Sep 18 21:27:01 hcd56 kernel: [88437.614021] Oops: 0002 [#1] SMP PTI
Sep 18 21:27:01 hcd56 kernel: [88437.617505] CPU: 31 PID: 3660 Comm: jbd2/nvme0n2-8 Tainted: G        W         5.4.0-050400-generic #201911242031
Sep 18 21:27:01 hcd56 kernel: [88437.627781] Hardware name: Supermicro SYS-1028U-TN10RT+/X10DRU-i+, BIOS 3.1 06/08/2018
Sep 18 21:27:01 hcd56 kernel: [88437.635694] RIP: 0010:jbd2_journal_grab_journal_head+0x22/0x40
Sep 18 21:27:01 hcd56 kernel: [88437.641522] Code: eb e7 66 0f 1f 44 00 00 0f 1f 44 00 00 55 48 89 e5 f0 48 0f ba 2f 18 72 1c 48 8b 17 31 c0 f7 c2 00 00 02 00 74 08 48 8b 47 40 <83> 40 08 01 f0 80 67 03 fe 5d c3 f3 90 48 8b
07 a9 00 00 00 01 75
Sep 18 21:27:01 hcd56 kernel: [88437.660259] RSP: 0018:ffffb1da4a17fce0 EFLAGS: 00010206
Sep 18 21:27:01 hcd56 kernel: [88437.665475] RAX: 0000000000000000 RBX: ffff9717a5c274b0 RCX: 000000008020001c
Sep 18 21:27:01 hcd56 kernel: [88437.672599] RDX: 0000000001e2c021 RSI: ffff9710e77ea900 RDI: ffff97120026fa90
Sep 18 21:27:01 hcd56 kernel: [88437.679722] RBP: ffffb1da4a17fce0 R08: 0000000000000000 R09: ffffffffa67e2700
Sep 18 21:27:01 hcd56 kernel: [88437.686848] R10: ffff971017b71400 R11: 0000000000000001 R12: ffff9710e77ea900
Sep 18 21:27:01 hcd56 kernel: [88437.693973] R13: ffff9701e12d7b88 R14: ffff97120026fa92 R15: ffff9710e77ea900
Sep 18 21:27:01 hcd56 kernel: [88437.701095] FS:  0000000000000000(0000) GS:ffff9717ff8c0000(0000) knlGS:0000000000000000
Sep 18 21:27:01 hcd56 kernel: [88437.709174] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Sep 18 21:27:01 hcd56 kernel: [88437.714909] CR2: 0000000000000008 CR3: 000000103564c005 CR4: 00000000003606e0
Sep 18 21:27:01 hcd56 kernel: [88437.722035] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Sep 18 21:27:01 hcd56 kernel: [88437.729160] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Sep 18 21:27:01 hcd56 kernel: [88437.736284] Call Trace:
Sep 18 21:27:01 hcd56 kernel: [88437.738733]  __jbd2_journal_insert_checkpoint+0x28/0x80
Sep 18 21:27:01 hcd56 kernel: [88437.743954]  jbd2_journal_commit_transaction+0x124f/0x178d
Sep 18 21:27:01 hcd56 kernel: [88437.749434]  ? try_to_del_timer_sync+0x54/0x80
Sep 18 21:27:01 hcd56 kernel: [88437.753881]  kjournald2+0xb6/0x280
Sep 18 21:27:01 hcd56 kernel: [88437.757286]  ? wait_woken+0x80/0x80
Sep 18 21:27:01 hcd56 kernel: [88437.760778]  kthread+0x104/0x140
Sep 18 21:27:01 hcd56 kernel: [88437.763231] EXT4-fs error (device nvme0n2): ext4_journal_check_start:61: Detected aborted journal
Sep 18 21:27:01 hcd56 kernel: [88437.763293] EXT4-fs error (device nvme0n2): ext4_journal_check_start:61: Detected aborted journal
Sep 18 21:27:01 hcd56 kernel: [88437.764002]  ? commit_timeout+0x20/0x20
Sep 18 21:27:01 hcd56 kernel: [88437.764004]  ? kthread_park+0x90/0x90
Sep 18 21:27:01 hcd56 kernel: [88437.764009]  ret_from_fork+0x35/0x40
Sep 18 21:27:01 hcd56 kernel: [88437.764011] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace fscache ipmi_ssif intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass dax_pmem_compat device_dax nd_pmem dax_pmem_core nd_btt crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper intel_cstate input_leds intel_rapl_perf joydev mei_me mei lpc_ich ioatdma ipmi_si ipmi_devintf ipmi_msghandler nfit acpi_power_meter acpi_pad mac_hid iscsi_tcp libiscsi_tcp rdma_ucm mlx4_ib sunrpc ib_uverbs ib_umad ib_iser rdma_cm iw_cm libiscsi scsi_transport_iscsi ib_ipoib ib_cm ib_core parport_pc ppdev lp parport autofs4 btrfs xor zstd_compress raid6_pq libcrc32c mlx4_en hid_generic usbhid hid ast drm_vram_helper i2c_algo_bit ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops sfc mlx4_core mtd ixgbe drm ahci nvme xfrm_algo libahci nvme_core dca mdio wmi
Sep 18 21:27:01 hcd56 kernel: [88437.874368] CR2: 0000000000000008
Sep 18 21:27:01 hcd56 kernel: [88437.877683] ---[ end trace 5a47dfdfd127baf6 ]---
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
