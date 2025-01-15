Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB8EC02183
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 17:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EtTgL1fmfOnGfXLs43NYICZaoLFW7iYr2mXlQCwdHAc=; b=TRZyt+6zyVU4/UHH+wtuB3aZ17
	C5BrMxR0AosUggU38Nu/6BkL/bE2xZKOE3pKV3VI0QRHqPCjXSqvAcJpD0jzMAxA9g4AfPOaw2VDV
	vxnNHBkmRNtRs68uJ19lox7kPj+fvSxucP8E5Cop4TOI2Qd45HkWjLE2Ua9+AV5ZAuw2sJVMz6YOX
	P/uL4C/XsJtgHymjvmNVDh1YaexFZkwSvwtgvhIK6nRgl5p1/Hs29d42Q2s99SVxJgZBu5v6T2z5m
	23S5EuG3VLsiaD8pQQZxl4vIsg4+4x1pUL76/N4Ni9fc5tXkUPPilLrddGozWZ6TxjDEMOvp1Gxh/
	jj/HMDOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tY7Lm-0000000Cd4k-2GKg;
	Wed, 15 Jan 2025 17:38:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tY7HK-0000000CcGf-1Kiv
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 17:34:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736962444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtTgL1fmfOnGfXLs43NYICZaoLFW7iYr2mXlQCwdHAc=;
	b=a6Unp9NfWcvtEoLezj1h8cNr48eEBhkpj/Xwwj5/M6foKBD7lymSbKlea3TzszGHMFduiD
	pBntDRGfj0WGobk9UvUGWipDX4BmJi0SpsRMmi3nd/8CStuUaHNISXtghKfRUD4vloRIrc
	RCclRFkYV3bkP3NLM2geWebs75zyFK0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-VtkvLAEWPEeU6zdv72WrGA-1; Wed, 15 Jan 2025 12:34:02 -0500
X-MC-Unique: VtkvLAEWPEeU6zdv72WrGA-1
X-Mimecast-MFC-AGG-ID: VtkvLAEWPEeU6zdv72WrGA
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e573c46fd5dso10335954276.1
        for <linux-nvme@lists.infradead.org>; Wed, 15 Jan 2025 09:34:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736962442; x=1737567242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtTgL1fmfOnGfXLs43NYICZaoLFW7iYr2mXlQCwdHAc=;
        b=NvyovQMuGmYSVkgqzSu4RX05Ym1YRYf0CRAndRNFR9U5jY75On5xXrtjPKV1Z2+SPN
         0vcM8lcFuoHmoG0qN+t5RlaO7tNybTYXw4aEQZqDW0FfbePAfyjn2VhDfqgsCh7piv8r
         vNbfySva5DcdOHBK+bjtpNDdjhn1ZCcjwJJc1m1C7dWuEcGoohaF5ghEijP05rfRav8S
         Qvty9Bn9K/TzeDaoSPNoLDeQFmA3s1OQClWeguYAKHq3Mus0q5xxi7FFheM/FsD+qaes
         CizxhOihKN9QEnSkFEJFxWDXekmhcu7jSAGF0P9eSzFR0gABNRerKEBLb50Hu+3oHH90
         oBAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV923o5bWM0ci5U/qC3G2VwNLDVeZjs+w82lk8elrQKCmq9PT51uzQdLiaH2jn6qJKWQh9VKddU1nAk@lists.infradead.org
X-Gm-Message-State: AOJu0Yzq6Uj+M5K8BjZ3K/mIlQ+nBZCd04zC1UAVGwgIJyE/CtCoyuSU
	kf5iO+PRm13biUoQQzFvr8N3RYPjCfChrVrzktdlQn+UY41WiObE5IlfJY+hvu4d2AD+s/kvo6W
	LMINcq2iBM/QRAyff7wU3PykF8IUt8EWWe5Rrl4qiPMuX2r/Hyn0ho97z/dvrfOBoCvAGE1NOUZ
	raBUiiEDIxFj26v3FM9MFJzzidarUfvx8/aAuD7no=
X-Gm-Gg: ASbGncvxH4W8z0aOjpAau49pfRGGZW6Z1RR25D8p3/rX0liFuq01l1Zg1iy7j3t6Enm
	csFszbBUGckyha85Fruq91XyNAHuDPO1VNaH6Kw==
X-Received: by 2002:a05:690c:4d88:b0:6f6:7b8a:6e62 with SMTP id 00721157ae682-6f67b8a76ccmr143529587b3.35.1736962441934;
        Wed, 15 Jan 2025 09:34:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjrniYah4RGHJuz7HUVYRKgcDW7CY7GgaykYkddeqiN2jj8BXddHS/izwjW/02uMh/iuWqmLC5ygRvbJ34ISM=
X-Received: by 2002:a05:690c:4d88:b0:6f6:7b8a:6e62 with SMTP id
 00721157ae682-6f67b8a76ccmr143529257b3.35.1736962441582; Wed, 15 Jan 2025
 09:34:01 -0800 (PST)
MIME-Version: 1.0
References: <20250113124446.830697-1-ming.lei@redhat.com> <CAGtn9r=bqfqm6d0ipf6pc5Rure=NdkxdX+K=gTp4iAQ6qUYVtQ@mail.gmail.com>
 <CAGtn9r=pJjpZVoGt9deesQxv=G9tC4r8ZNAWVX2nTErQWAo3Rw@mail.gmail.com>
In-Reply-To: <CAGtn9r=pJjpZVoGt9deesQxv=G9tC4r8ZNAWVX2nTErQWAo3Rw@mail.gmail.com>
From: Ewan Milne <emilne@redhat.com>
Date: Wed, 15 Jan 2025 12:33:50 -0500
X-Gm-Features: AbW1kvaGGWExxXICA2qlAIMLrdh-NFT3R1k01CwrKFMec2CD5V-Vgj4rVZxhyIM
Message-ID: <CAGtn9rn=rUsaOACWyOLAx2=E++WvStwtQwyXZR=kxYmuCQQ0_A@mail.gmail.com>
Subject: Re: [RFC PATCH] nvme-fc: move tagset removal to nvme_fc_delete_ctrl()
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	Marco Patalano <mpatalan@redhat.com>, James Smart <james.smart@broadcom.com>, 
	Sagi Grimberg <sagi@grimberg.me>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LBfjTuoGMfv6YX6MF3g703rsSDEtXduSGXaTAJLDi0E_1736962442
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_093406_505004_497D1C56 
X-CRM114-Status: GOOD (  43.57  )
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

Moving the tagset removal to the end of nvme_fc_delete_ctrl() ran OK and we
no longer see the WARN_ON() seen earlier, however I think that there is a
potential problem with doing this because the keepalive is not stopped unti=
l
nvme_uninit_ctrl() is called.  On our systems w/FC kato is normally disable=
d
so we wouldn't see any problem but this isn't true in the general case.

-Ewan

On Tue, Jan 14, 2025 at 1:31=E2=80=AFPM Ewan Milne <emilne@redhat.com> wrot=
e:
>
> Patch results in a crash w/slub_debug=3DFZPU enabled.  I'll try moving
> the tagset removal further down.
>
> -Ewan
>
> [   36.608477] BUG: unable to handle page fault for address: ffffffffbd92=
a8d8
> [   36.608479] #PF: supervisor read access in kernel mode
> [   36.608481] #PF: error_code(0x0000) - not-present page
> [   36.608483] PGD 687827067 P4D 687827067 PUD 687828063 PMD 10938d063
> PTE 800ffff9788d5022
> [   36.608488] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> [   36.608492] CPU: 3 UID: 0 PID: 952 Comm: nvme Not tainted 6.13.0-rc6+ =
#2
> [   36.608495] Hardware name: Dell Inc. PowerEdge R440/0WKGTH, BIOS
> 1.4.8 05/22/2018
> [   36.608496] RIP: 0010:lock_timer_base+0x4a/0xa0
> [   36.608504] Code: 1c 73 bf 00 f3 90 44 8b 6b 20 41 f7 c5 00 00 04
> 00 75 f1 44 89 e8 44 89 ea 25 00 00 10 00 83 f8 01 48 19 c0 81 e2 ff
> ff 03 00 <48> 8b 14 d5 80 4d 77 bd 25 80 12 00 00 48 05 00 1b 02 00 4c
> 8d 34
> [   36.608506] RSP: 0018:ffffabdd80b77b70 EFLAGS: 00010202
> [   36.608509] RAX: ffffffffffffffff RBX: ffff898856cdd970 RCX: 000000000=
0000002
> [   36.608511] RDX: 0000000000036b6b RSI: ffffabdd80b77ba0 RDI: ffff89885=
6cdd970
> [   36.608512] RBP: 0000000000024000 R08: ffff899350bb6730 R09: 000000087=
21e3400
> [   36.608513] R10: 0000000000000000 R11: ffff899350bb430c R12: ffffabdd8=
0b77ba0
> [   36.608515] R13: 000000006b6b6b6b R14: ffffabdd80b77d28 R15: ffff89886=
0917060
> [   36.608516] FS:  00007f4d32b0fc40(0000) GS:ffff899350b80000(0000)
> knlGS:0000000000000000
> [   36.608519] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   36.608520] CR2: ffffffffbd92a8d8 CR3: 00000001154ba006 CR4: 000000000=
07726f0
> [   36.608522] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   36.608523] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   36.608524] PKRU: 55555554
> [   36.608525] Call Trace:
> [   36.608526]  <TASK>
> [   36.608528]  ? show_trace_log_lvl+0x1b0/0x2f0
> [   36.608532]  ? show_trace_log_lvl+0x1b0/0x2f0
> [   36.608536]  ? __try_to_del_timer_sync+0x2b/0x90
> [   36.608540]  ? __die_body.cold+0x8/0x12
> [   36.608543]  ? page_fault_oops+0x146/0x160
> [   36.608549]  ? exc_page_fault+0x152/0x160
> [   36.608553]  ? asm_exc_page_fault+0x26/0x30
> [   36.608559]  ? lock_timer_base+0x4a/0xa0
> [   36.608563]  __try_to_del_timer_sync+0x2b/0x90
> [   36.608567]  __timer_delete_sync+0x28/0x40
> [   36.608571]  blk_sync_queue+0x19/0x30
> [   36.608575]  __nvme_fc_abort_outstanding_ios+0x76/0x160 [nvme_fc]
> [   36.608582]  nvme_fc_delete_association+0x84/0x250 [nvme_fc]
> [   36.608587]  ? blk_mq_free_tag_set+0x120/0x160
> [   36.608593]  nvme_do_delete_ctrl+0x7d/0x90 [nvme_core]
> [   36.608612]  nvme_delete_ctrl_sync.cold+0x8/0xd [nvme_core]
> [   36.608624]  nvme_sysfs_delete+0x38/0x50 [nvme_core]
> [   36.608638]  kernfs_fop_write_iter+0x13b/0x1f0
> [   36.608643]  vfs_write+0x28d/0x450
> [   36.608647]  ksys_write+0x6c/0xe0
> [   36.608650]  do_syscall_64+0x7d/0x160
> [   36.608654]  ? syscall_exit_to_user_mode+0x32/0x190
> [   36.608658]  ? do_syscall_64+0x89/0x160
> [   36.608661]  ? rseq_get_rseq_cs+0x1d/0x220
> [   36.608665]  ? rseq_ip_fixup+0x8d/0x1d0
> [   36.608668]  ? nvme_dev_ioctl+0x1b3/0x1d0 [nvme_core]
> [   36.608680]  ? switch_fpu_return+0x4e/0xd0
> [   36.608684]  ? arch_exit_to_user_mode_prepare.isra.0+0x83/0xb0
> [   36.608687]  ? syscall_exit_to_user_mode+0x32/0x190
> [   36.608690]  ? do_syscall_64+0x89/0x160
> [   36.608694]  ? exc_page_fault+0x73/0x160
> [   36.608697]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   36.608701] RIP: 0033:0x7f4d32d8c6a4
> [   36.608704] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
> 84 00 00 00 00 00 f3 0f 1e fa 80 3d a5 c9 0d 00 00 74 13 b8 01 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24
> 18 48
> [   36.608705] RSP: 002b:00007ffef88f49a8 EFLAGS: 00000202 ORIG_RAX:
> 0000000000000001
> [   36.608708] RAX: ffffffffffffffda RBX: 0000565309cf54f0 RCX: 00007f4d3=
2d8c6a4
> [   36.608709] RDX: 0000000000000001 RSI: 00007f4d32edcdb5 RDI: 000000000=
0000004
> [   36.608710] RBP: 0000565309cf53c0 R08: 0000000000000073 R09: 00000000f=
fffffff
> [   36.608712] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000=
0000004
> [   36.608713] R13: 0000565309cf53c0 R14: 0000565309cf5410 R15: 00007ffef=
88f4bf0
> [   36.608717]  </TASK>
> [   36.608718] Modules linked in: qrtr rfkill intel_rapl_msr
> intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common
> skx_edac skx_edac_common nfit libnvdimm x86_pkg_temp_thermal
> intel_powerclamp coretemp kvm_intel kvm ipmi_ssif dell_wmi_descriptor
> iTCO_wdt platform_profile iTCO_vendor_support wmi ipmi_si rapl mei_me
> acpi_power_meter dcdbas tg3 mei intel_cstate i2c_i801 intel_uncore
> acpi_ipmi intel_pch_thermal pcspkr lpc_ich i2c_smbus sg ipmi_devintf
> ipmi_msghandler dm_multipath loop nfnetlink xfs lpfc sd_mod nvmet_fc
> nvmet nvme_fc nvme_fabrics nvme_keyring crct10dif_pclmul nvme_core
> crc32_pclmul ahci crc32c_intel libahci nvme_auth mgag200
> ghash_clmulni_intel megaraid_sas scsi_transport_fc libata i2c_algo_bit
> dm_mirror dm_region_hash dm_log dm_mod fuse
> [   36.608765] CR2: ffffffffbd92a8d8
> [   36.608766] ---[ end trace 0000000000000000 ]---
>
> On Tue, Jan 14, 2025 at 12:06=E2=80=AFPM Ewan Milne <emilne@redhat.com> w=
rote:
> >
> > Hi Ming-
> >
> > So there is definitely something wrong, because we are recently
> > starting to see a 100% reproducible
> > warning on a couple of our test systems (but not another one) where
> > the nvme_fc_ctrl kref decrements to
> > zero on command completion.  However, I'm not sure that this patch
> > addresses the underlying issue.
> > If there was an outstanding command on the admin queue, there should
> > have been a corresponding
> > kref taken in nvme_fc_start_fcp_op() so we should not be in
> > nvme_fc_ctrl_free() until after it completes.
> > and the kref should not be zero at the end of command completion.
> >
> > Normally, we would have already done through the code path in the
> > bottom of __nvme_fc_abort_outstanding_ios()
> > which should have resulted in no commands outstanding either on the
> > admin_q or the io queues prior to the
> > ->free_ctrl() callback to nvme_fc_free_ctrl() which I think should be
> > the last put on the nvme_fc_ctrl object.
> >
> > I think there there is also a problem with your change regarding when
> > the tagsets are removed,
> > which addresses WARN_ON() in blk_mq_run_hw_queue():
> >
> >         WARN_ON_ONCE(!async && in_interrupt());
> >
> > ...because moving the removal of the tagsets to earlier in
> > nvme_fc_delete_ctrl() is removing the tagsets
> > to be prior to the the nvme_fc_delete_association() call which then
> > calls __nvme_fc_abort_outstanding_ios()
> > which invokes blk_mq_tagset_busy_iter() on the tagsets.  Perhaps
> > moving the tagset removal to after the
> > nvme_fc_delete_assocation() call would address your specific concern
> > regarding the correct execution context?
> >
> > I think the real problem is that nvme_fc_ctrl_free() is called due to
> > the kref put when the command completes.
> > This shouldn't happen.  The last put should happen when the core code
> > calls ->free_ctrl().
> >
> > Below is the stack trace we see for those interested.  The test is
> > doing a echo 1 > /sys/..../delete_controller.
> >
> > I can't reproduce this on my otherwise identical system (connected to
> > different storage fabric arrays though).
> > So we have to run any experiments through the test automation instead
> > of interactively.
> >
> > -Ewan
> >
> > [ 4095.189976] ------------[ cut here ]------------
> > [ 4095.194596] WARNING: CPU: 9 PID: 38355 at block/blk-mq.c:2325
> > blk_mq_run_hw_queue+0x26/0x280
> > [ 4095.203036] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4
> > dns_resolver nfs lockd grace netfs sunrpc dm_service_time dm_multipath
> > amd_atl intel_rapl_msr intel_rapl_common amd64_edac dell_pc
> > platform_profile edac_mce_amd kvm_amd dell_wmi sparse_keymap rfkill
> > dell_smbios video dcdbas ipmi_ssif mgag200 kvm i2c_algo_bit
> > drm_client_lib drm_shmem_helper drm_kms_helper dell_wmi_descriptor
> > wmi_bmof rapl pcspkr i2c_piix4 ptdma i2c_smbus k10temp ipmi_si
> > acpi_power_meter acpi_ipmi ipmi_devintf ipmi_msghandler drm fuse xfs
> > libcrc32c sd_mod sg qla2xxx nvme_fc nvme_fabrics nvme_keyring ahci
> > crct10dif_pclmul nvme_core libahci crc32_pclmul nvme_auth crc32c_intel
> > libata ghash_clmulni_intel ccp scsi_transport_fc tg3 megaraid_sas
> > sp5100_tco wmi dm_mirror dm_region_hash dm_log dm_mod
> > [ 4095.271190] CPU: 9 UID: 0 PID: 38355 Comm: kworker/u65:3 Not
> > tainted 6.13.0-rc4+ #1
> > [ 4095.278851] Hardware name: Dell Inc. PowerEdge R6515/04F3CJ, BIOS
> > 2.13.3 09/12/2023
> > [ 4095.286515] Workqueue:  0x0 (writeback)
> > [ 4095.290361] RIP: 0010:blk_mq_run_hw_queue+0x26/0x280
> > [ 4095.295334] Code: 90 90 90 90 0f 1f 44 00 00 41 57 41 56 41 55 41
> > 54 55 48 89 fd 53 89 f3 40 84 f6 75 1c 65 f7 05 34 e9 40 4e 00 ff ff
> > 00 74 02 <0f> 0b f6 85 a8 00 00 00 10 0f 85 16 02 00 00 48 8b 85 b8 00
> > 00 00
> > [ 4095.314088] RSP: 0018:ffffb8ca0056cea8 EFLAGS: 00010206
> > [ 4095.319321] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000=
000000000
> > [ 4095.326455] RDX: ffff9c82cb227728 RSI: 0000000000000000 RDI: ffff9c8=
2d1e73e00
> > [ 4095.333585] RBP: ffff9c82d1e73e00 R08: 0000000000000000 R09: ffffb8c=
a0056ccf8
> > [ 4095.340720] R10: ffffb8ca0056ccf0 R11: ffffffffb33e1348 R12: 0000000=
000000000
> > [ 4095.347851] R13: ffff9c82ddfd1380 R14: 0000000000000010 R15: fffffff=
fb30070e0
> > [ 4095.354986] FS:  0000000000000000(0000) GS:ffff9c862f380000(0000)
> > knlGS:0000000000000000
> > [ 4095.363078] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 4095.368825] CR2: 0000563f2b03c0b0 CR3: 000000011dfe6000 CR4: 0000000=
000350ef0
> > [ 4095.375966] Call Trace:
> > [ 4095.378418]  <IRQ>
> > [ 4095.380439]  ? __warn+0x84/0x130
> > [ 4095.383679]  ? blk_mq_run_hw_queue+0x26/0x280
> > [ 4095.388046]  ? report_bug+0x18a/0x1a0
> > [ 4095.391721]  ? handle_bug+0x53/0x90
> > [ 4095.395222]  ? exc_invalid_op+0x14/0x70
> > [ 4095.399063]  ? asm_exc_invalid_op+0x16/0x20
> > [ 4095.403261]  ? blk_mq_run_hw_queue+0x26/0x280
> > [ 4095.407626]  blk_mq_run_hw_queues+0x63/0x120
> > [ 4095.411908]  __blk_freeze_queue_start+0x64/0x70
> > [ 4095.416447]  blk_queue_start_drain+0x18/0x50
> > [ 4095.420728]  blk_mq_destroy_queue+0x30/0x60
> > [ 4095.424915]  nvme_remove_io_tag_set+0x26/0x40 [nvme_core]
> > [ 4095.430330]  nvme_fc_ctrl_free+0x2e/0x130 [nvme_fc]
> > [ 4095.435219]  blk_complete_reqs+0x40/0x50
> > [ 4095.439154]  handle_softirqs+0xd3/0x2b0
> > [ 4095.443004]  __irq_exit_rcu+0xcd/0xf0
> > [ 4095.446673]  sysvec_call_function_single+0x71/0x90
> > [ 4095.451468]  </IRQ>
> >
> >
> >
> > On Mon, Jan 13, 2025 at 7:45=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Now target is removed from nvme_fc_ctrl_free() which is the ctrl->ref
> > > release handler. And even admin queue is unquiesced there, this way
> > > is definitely wrong because the ctr->ref is grabbed when submitting
> > > command.
> > >
> > > And Marco observed that nvme_fc_ctrl_free() can be called from reques=
t
> > > completion code path, and trigger kernel warning since request comple=
tes
> > > from softirq context.
> > >
> > > Fix the issue by moveing target removal into nvme_fc_delete_ctrl(),
> > > which is also aligned with nvme-tcp and nvme-rdma.
> > >
> > > Cc: Marco Patalano <mpatalan@redhat.com>
> > > Cc: Ewan Milne <emilne@redhat.com>
> > > Cc: James Smart <james.smart@broadcom.com>
> > > Cc: Sagi Grimberg <sagi@grimberg.me>
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/nvme/host/fc.c | 13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> > > index b81af7919e94..b94b4e50a3df 100644
> > > --- a/drivers/nvme/host/fc.c
> > > +++ b/drivers/nvme/host/fc.c
> > > @@ -2389,17 +2389,11 @@ nvme_fc_ctrl_free(struct kref *ref)
> > >                 container_of(ref, struct nvme_fc_ctrl, ref);
> > >         unsigned long flags;
> > >
> > > -       if (ctrl->ctrl.tagset)
> > > -               nvme_remove_io_tag_set(&ctrl->ctrl);
> > > -
> > >         /* remove from rport list */
> > >         spin_lock_irqsave(&ctrl->rport->lock, flags);
> > >         list_del(&ctrl->ctrl_list);
> > >         spin_unlock_irqrestore(&ctrl->rport->lock, flags);
> > >
> > > -       nvme_unquiesce_admin_queue(&ctrl->ctrl);
> > > -       nvme_remove_admin_tag_set(&ctrl->ctrl);
> > > -
> > >         kfree(ctrl->queues);
> > >
> > >         put_device(ctrl->dev);
> > > @@ -3288,6 +3282,13 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
> > >
> > >         cancel_work_sync(&ctrl->ioerr_work);
> > >         cancel_delayed_work_sync(&ctrl->connect_work);
> > > +
> > > +       if (ctrl->ctrl.tagset)
> > > +               nvme_remove_io_tag_set(&ctrl->ctrl);
> > > +
> > > +       nvme_unquiesce_admin_queue(&ctrl->ctrl);
> > > +       nvme_remove_admin_tag_set(&ctrl->ctrl);
> > > +
> > >         /*
> > >          * kill the association on the link side.  this will block
> > >          * waiting for io to terminate
> > > --
> > > 2.47.0
> > >


