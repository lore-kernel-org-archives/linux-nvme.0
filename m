Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C972C61DA4
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Feb 2023 13:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JEQLoDLINVl3F+/GA69pa8jyC+UqGUYA86Dria6Zank=; b=kP0Qo0+vjkYLDiEYtS4E207ASj
	hY3bbX2j5HsLsKKwG11k/Lu9dhGxBz7g5taLQTxPk70oYr9wpkP9TIIJd2BH39GJGfutomy08YSXg
	THl2lf3k80IQy7L8YKJlDG8/H68KcaFqhgGUGS5BekRRPbRpl8AIYS7HkfIVrj2JoFxpEGEM7ibDi
	HLN10uD7AWsrLZmmifFNAuhQJpFefP+O+PA3YWP4IXEwYoc0DRQh4wYZf+3lsr0WzsFQfw1boZMfA
	t2UiKO3pl2RPH1ZzYYhR3/521gsKIcj8tx7aorsEobPxvkwqHNo70cUIgnvXKcRGgnC3YmYLK1FQ6
	Oo7sDOVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSebA-00AP9c-Oy; Thu, 16 Feb 2023 13:46:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSeZU-00AO80-Fp
	for linux-nvme@lists.infradead.org; Thu, 16 Feb 2023 13:45:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676555109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=JEQLoDLINVl3F+/GA69pa8jyC+UqGUYA86Dria6Zank=;
	b=OHrqBIdSqohyYj/egJNPss0DqCE8tQuZ+L5qQ2gM/OXz6yIkR/0/o2WKsfbNgzI4/Wm2G1
	QW+rDF2xaPcJUTQ+ET5OqOvUFuTq1uQ7PC5cuqmpJEkAdolgX6OGSwvFwfx/DcV1Y0o9iP
	rgWSQEZaMjTE2IcVci+P+KYUkXJQLbU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-269-5CZ0-iN9Ntq_5yQpM69erA-1; Thu, 16 Feb 2023 08:43:33 -0500
X-MC-Unique: 5CZ0-iN9Ntq_5yQpM69erA-1
Received: by mail-pf1-f199.google.com with SMTP id cg11-20020a056a00290b00b005a8d3df5356so1253339pfb.6
        for <linux-nvme@lists.infradead.org>; Thu, 16 Feb 2023 05:43:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JEQLoDLINVl3F+/GA69pa8jyC+UqGUYA86Dria6Zank=;
        b=lfybrxixw75Fft2mUGSIHP9kALmUlFfv/W8L4cex3jvX4vWzJULyZPpp7JsBNVVPYm
         rTCd44SeJlT2PFmd3RQCN1crK0PJbt5rkW0jSwBbIWn3PWk+VRsJAViIoH/AEQbv4hRt
         GjLG1wtdb/KV1QeZ2OsiwjEIKPry0Cu1RQzMbW6sIAa15h1o1AntieqfrS5pkWAEqwiJ
         YWbxe2oFeyq6ci1SloSzyQQmIgoigC5QyXss2ChyHKTGcmcIaH8XwsAldGdf72g3SyoJ
         PeE3wrvNB5FWG02jTsQlbM8dxB1AomcGGV40qtOISri1ymype+WoiFb1dVLWpuiMvSci
         acGg==
X-Gm-Message-State: AO0yUKUL/rm3GJLLB2UKH5bVMKYKt+SMp2RQtg0M3HiRyC0yqzIv+hzW
	wSOoFaLkFvWHPvrWxElHPLq0Sf7xqmyc227A3hd0Yca3srPGJzFzNax6IHw0peeiUhx5QYAyXn9
	AKt9brluM4+BdJWfxRmE1lz7W576hsTLp8/qvWQHqw1SrNVhk4UxPDSdX
X-Received: by 2002:a17:90b:17d2:b0:231:1364:4103 with SMTP id me18-20020a17090b17d200b0023113644103mr546154pjb.145.1676555012214;
        Thu, 16 Feb 2023 05:43:32 -0800 (PST)
X-Google-Smtp-Source: AK7set+OqSFr8nuNZnRRTr16DGcCUJwDhktdtedpb+64N25zk/wIj+8O/kPG9LVZPyjH8O98ZdjN3K/sC8S2OlCEhZg=
X-Received: by 2002:a17:90b:17d2:b0:231:1364:4103 with SMTP id
 me18-20020a17090b17d200b0023113644103mr546148pjb.145.1676555011674; Thu, 16
 Feb 2023 05:43:31 -0800 (PST)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 16 Feb 2023 21:43:20 +0800
Message-ID: <CAHj4cs83N=Hct2b6raGbiV83bKKmgSg4Czz_btMAZRExp=whhg@mail.gmail.com>
Subject: [bug report] kernel panic observed during blktests nvme/004 on latest linux-block/for-next
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230216_054512_658119_33B69988 
X-CRM114-Status: UNSURE (   7.98  )
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

Hello

I reproduced one kernel panic during blktests nvme/ on the latest
linux-block/for-next, here is the gdb info and full trace, pls help
check it.

(gdb) l *(nvme_do_delete_ctrl+0x63)
0x6f3 is in nvme_do_delete_ctrl (drivers/nvme/host/core.c:217).
212 "Removing ctrl: NQN \"%s\"\n", nvmf_ctrl_subsysnqn(ctrl));
213
214 flush_work(&ctrl->reset_work);
215 nvme_stop_ctrl(ctrl);
216 nvme_remove_namespaces(ctrl);
217 ctrl->ops->delete_ctrl(ctrl);
218 nvme_uninit_ctrl(ctrl);
219 }
220
221 static void nvme_delete_ctrl_work(struct work_struct *work)

[   75.655995] run blktests nvme/004 at 2023-02-16 08:26:05
[   75.687398] loop0: detected capacity change from 0 to 2097152
[   76.759005] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[   76.765948] block nvme0n1: no available path - failing I/O
[   76.771517] block nvme0n1: no available path - failing I/O
[   76.777028] block nvme0n1: no available path - failing I/O
[   76.782538] block nvme0n1: no available path - failing I/O
[   76.788051] block nvme0n1: no available path - failing I/O
[   76.793561] block nvme0n1: no available path - failing I/O
[   76.799073] block nvme0n1: no available path - failing I/O
[   76.804595] block nvme0n1: no available path - failing I/O
[   76.810112] block nvme0n1: no available path - failing I/O
[   76.815619] block nvme0n1: no available path - failing I/O
[   76.827203] buffer_io_error: 39 callbacks suppressed
[   76.827209] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[   76.839369] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[   76.846518] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[   76.853669] ldm_validate_partition_table(): Disk read failed.
[   76.859431] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[   76.866581] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[   76.873733] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[   76.880884] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[   76.888030]  nvme0n1: unable to read partition table
[   76.895100] Buffer I/O error on dev nvme0n1, logical block 262128,
async page read
[   77.038530] BUG: unable to handle page fault for address: ffffffffc08fc138
[   77.045425] #PF: supervisor instruction fetch in kernel mode
[   77.051098] #PF: error_code(0x0010) - not-present page
[   77.056238] PGD 236c14067 P4D 236c15067 PUD 236c17067 PMD 1035ba067 PTE 0
[   77.063044] Oops: 0010 [#1] PREEMPT SMP NOPTI
[   77.067418] CPU: 36 PID: 9497 Comm: nvme Not tainted 6.2.0-rc7+ #1
[   77.073618] Hardware name: Dell Inc. PowerEdge R660/0M1CC5, BIOS
0.2.28 09/23/2022
[   77.081181] RIP: 0010:0xffffffffc08fc138
[   77.085111] Code: Unable to access opcode bytes at 0xffffffffc08fc10e.
[   77.091651] RSP: 0018:ff2fdb64c8befd68 EFLAGS: 00010202
[   77.096887] RAX: 0000000000000058 RBX: 000000000000000b RCX: 0000000000000000
[   77.104017] RDX: 000000000000000a RSI: ffffffffc08d5fec RDI: ff19a0bd6aea00e0
[   77.111153] RBP: ff19a0bd44c77000 R08: 0000000000000000 R09: 0000000080400036
[   77.118284] R10: 0000000000000024 R11: 0000000000000000 R12: ff2fdb64c8befe20
[   77.125418] R13: 0000000000000001 R14: ff19a0bd451c3d40 R15: ff19a0bd451c3d60
[   77.132549] FS:  00007f002189e580(0000) GS:ff19a0c0af100000(0000)
knlGS:0000000000000000
[   77.140637] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   77.146380] CR2: ffffffffc08fc10e CR3: 0000000188f12005 CR4: 0000000000771ee0
[   77.153515] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   77.160646] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   77.167779] PKRU: 55555554
[   77.170492] Call Trace:
[   77.172945]  <TASK>
[   77.175055]  ? nvme_do_delete_ctrl+0x63/0x6f [nvme_core]
[   77.180416]  ? nvme_sysfs_delete.cold+0x8/0xd [nvme_core]
[   77.185850]  ? kernfs_fop_write_iter+0x12f/0x1c0
[   77.190487]  ? vfs_write+0x21f/0x3e0
[   77.194085]  ? ksys_write+0x5b/0xd0
[   77.197595]  ? do_syscall_64+0x58/0x80
[   77.201364]  ? syscall_exit_to_user_mode+0x17/0x40
[   77.206175]  ? do_syscall_64+0x67/0x80
[   77.209944]  ? exc_page_fault+0x70/0x170
[   77.213888]  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   77.219141]  </TASK>
[   77.221332] Modules linked in: nvmet nvme_core nvme_common rfkill
intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common intel_ifs sunrpc i10nm_edac nfit
libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel
ipmi_ssif kvm iTCO_wdt irqbypass intel_pmc_bxt dell_smbios
iTCO_vendor_support vfat pmt_telemetry pmt_crashlog rapl fat
intel_sdsi pmt_class intel_th_gth intel_cstate acpi_ipmi mei_me
ipmi_si intel_th_pci isst_if_mbox_pci isst_if_mmio dcdbas i2c_i801
idxd intel_uncore tg3 pcspkr wmi_bmof dell_wmi_descriptor mei
intel_vsec isst_if_common idxd_bus intel_th i2c_smbus ipmi_devintf
i2c_ismt ipmi_msghandler acpi_power_meter fuse loop zram xfs qat_4xxx
crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni intel_qat
polyval_generic mpi3mr ghash_clmulni_intel sha512_ssse3 mgag200
scsi_transport_sas crc8 wmi pinctrl_emmitsburg [last unloaded:
nvme_fabrics]
[   77.300833] CR2: ffffffffc08fc138
[   77.304154] ---[ end trace 0000000000000000 ]---
[   77.352723] pstore: backend (erst) writing error (-28)
[   77.357877] RIP: 0010:0xffffffffc08fc138
[   77.361822] Code: Unable to access opcode bytes at 0xffffffffc08fc10e.
[   77.368345] RSP: 0018:ff2fdb64c8befd68 EFLAGS: 00010202
[   77.373570] RAX: 0000000000000058 RBX: 000000000000000b RCX: 0000000000000000
[   77.380704] RDX: 000000000000000a RSI: ffffffffc08d5fec RDI: ff19a0bd6aea00e0
[   77.387836] RBP: ff19a0bd44c77000 R08: 0000000000000000 R09: 0000000080400036
[   77.394971] R10: 0000000000000024 R11: 0000000000000000 R12: ff2fdb64c8befe20
[   77.402103] R13: 0000000000000001 R14: ff19a0bd451c3d40 R15: ff19a0bd451c3d60
[   77.409236] FS:  00007f002189e580(0000) GS:ff19a0c0af100000(0000)
knlGS:0000000000000000
[   77.417321] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   77.423067] CR2: ffffffffc08fc10e CR3: 0000000188f12005 CR4: 0000000000771ee0
[   77.430201] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   77.437333] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   77.444467] PKRU: 55555554
[   77.447177] Kernel panic - not syncing: Fatal exception
[   77.452567] Kernel Offset: 0x2a000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   77.509325] ---[ end Kernel panic - not syncing: Fatal exception ]-----


Best Regards,
  Yi Zhang


