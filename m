Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FA1EE57D7
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Dec 2025 15:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sP7w9mwoC0sWUxD8iwBfG1sVmiPRIXdoiMDwxe28xg0=; b=shrwQx1T2rjU03F6DsCrYlhcey
	ELny2pE343hFFffLX7k9H3quLoUJ0Mu3fn45gOywANDnfSGGEbPf3csA8t8jQ8oMz/pa53Iv7xEih
	5s3Crrh3MRlM+jZkqVI69MEqu38O+ihffQZDCGwucu/XPZNXcncBAI//xwqa+Q3Gxg7LiiMKDaicf
	GpVrB2z8lKLxgl9DHOX/PXIqj94bBYEIlrGsbNVzUw449NNRG8Qcm6gBqTrQN9uQpSrRSs9bNsuHn
	B2V/A/+PeM/gTuW58BF7HNiCv0oFQ0M8mj16HLbN1WY61PBtoFXeof81Dlp+2atyPe3hx33HjGADe
	nlr/kT1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vay0E-000000064Vz-1Hsm;
	Wed, 31 Dec 2025 15:20:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vay0B-000000064Vc-1QVw
	for linux-nvme@lists.infradead.org;
	Wed, 31 Dec 2025 15:20:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767194439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=sP7w9mwoC0sWUxD8iwBfG1sVmiPRIXdoiMDwxe28xg0=;
	b=DfLHxSF44cdYoB6CHutwJY/HQVW0ipi5KeCDIJc2b8/U+9Mbg7WsTEc4FXyGa4tygGCxSg
	yOplaBT75aX+DfgBmabSdtHPABqzAwHuN0dEuZJWPYRJreyo39zJw8Nt7JJ8/kM5ou+uWj
	7YJKUB+plQRK9zLYpqobEXw9q8rkRm4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-iHLTf2GbOaqKuOHjXJBgaA-1; Wed, 31 Dec 2025 10:20:37 -0500
X-MC-Unique: iHLTf2GbOaqKuOHjXJBgaA-1
X-Mimecast-MFC-AGG-ID: iHLTf2GbOaqKuOHjXJBgaA_1767194436
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-37fe06427afso45772771fa.2
        for <linux-nvme@lists.infradead.org>; Wed, 31 Dec 2025 07:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767194434; x=1767799234;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sP7w9mwoC0sWUxD8iwBfG1sVmiPRIXdoiMDwxe28xg0=;
        b=SRS2f4ovW3dJiOTUcL5mOL+qsG59iFnURWP0i+0Viut3V5pACQvbnxlGCQ0d+vQ8Q6
         gsukoMhHRtPA0PWr87sGYygIfY8jHvjeXQJ+35oTeNgvUySPddyimt0F5mM6QZcKjICg
         KMldW2AsMuA8mIT/8mn6v1+jEl54QjafJlZSZg2dnx/WFtxggIOujivpQy/cEcqe1IQv
         fz+4SKs/ZtNYxst/vZh3fZWdflrvPgQLzhdl+4fBbIzlby3IKWRNSAwT259V3AgKvie5
         YLEb5avo9ORi7etGzvOqU+YWJiC+lmZftGUPj361xqfhNVDPHXPvGtoZw6On8vLeHGs0
         Ll7A==
X-Gm-Message-State: AOJu0YxKzCyfWeiE6jSmR9makHqX5Uby+NtMQShnFzLS+KZrdIHFQsgf
	uLSJncTSLzxi4BE+xgp2n1zhBKoODWmUXe7O/M2ePW8KSeGdr8N5seeq5TXrv9Q9AuEYnfiFx4d
	+ZJCP8WwNkrYzDxba2TXx3UWeX5nDVlphe+tP6j+/5Yv4wkGteaJSDMAUd4l1H28Ba+hudHlUuN
	CWOrIL4QciSHO37U8sSOH3MP/CTqzlBQ/pmMVI7mPkdrCvKt09nb03cA==
X-Gm-Gg: AY/fxX6pfZM7I9pLasyu3thaTBIsCWUEt6QHlxppn7LDUc38CQKclBTtiVP/rCaApD4
	J+oXXIIk5aZ3FaF8o4YxkaYVCB1OI1Renar6ztHZJGgtko3IZIJ2Gv75sKg4Hk8HwboOCndeice
	f/DZRmuFtw/CixP4GApTDo9f2NWSIAg61w1N7L6lIQFAC4IuWhQMGGeSxndd5HHuzvnJM=
X-Received: by 2002:a05:651c:1b08:b0:37a:2d23:9e81 with SMTP id 38308e7fff4ca-381215aa991mr94142241fa.16.1767194434078;
        Wed, 31 Dec 2025 07:20:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6438JA5gfSC+lA5GVdL+6o9AnZDftfsGigmtqiY3TFGNk8n1D0gdsZ8QnivA0OYsCoqTEgkq/RxbH3vPFhCk=
X-Received: by 2002:a05:651c:1b08:b0:37a:2d23:9e81 with SMTP id
 38308e7fff4ca-381215aa991mr94142171fa.16.1767194433634; Wed, 31 Dec 2025
 07:20:33 -0800 (PST)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 31 Dec 2025 23:20:21 +0800
X-Gm-Features: AQt7F2oQL8sPzX7jS-e_Ah3yyuDh1tT4fYGol2pfQ9xB4RafWrv8yavqSTasMNs
Message-ID: <CAHj4cs_i5rq40TgMEfNB6M+PVeU2YZ1z_WZ6Qc9DWa+hGZ8Q0g@mail.gmail.com>
Subject: [bug report] Oops: general protection fault observed with blktests
 nvme/fc nvme/031
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: linux-block <linux-block@vger.kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Daniel Wagner <dwagner@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QVJT-DaLrA2pgRFE2d5CmBSYJcsNXNUpo_wj5iFTIFg_1767194436
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251231_072043_455899_5BB37989 
X-CRM114-Status: UNSURE (   6.06  )
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

Hi

I reproduced this Oops issue with blktests nvme/fc nvme/031 on the
latest blktests nvme/fc nvme/031.
Please help check it and let me know if you need any info/test, thanks.

reproducer:
[ 5483.833251] Oops: general protection fault, probably for
non-canonical address 0x134a05bd4da73752: 0000 [#1] SMP KASAN NOPTI
[ 5483.844475] CPU: 3 UID: 0 PID: 104919 Comm: kworker/3:7 Kdump:
loaded Tainted: G W 6.19.0-rc2+ #2 PREEMPT(voluntary)
[ 5483.844485] Tainted: [W]=WARN
[ 5483.844488] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.21.1 09/24/2025
[ 5483.844492] Workqueue: events nvme_fc_handle_ls_rqst_work [nvme_fc]
[ 5483.873465] RIP: 0010:srso_safe_ret+0x5/0x20
[ 5483.877745] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 48 b8 48 8d
64 24 08 <c3> cc cc 0f ae e8 e8 f0 ff ff ff 0f 0b 66 66 2e 0f 1f 84 00
00 00
[ 5483.896492] RSP: 0018:ffffc9000d5bfb10 EFLAGS: 00010246
[ 5483.901726] RAX: 134a05bd4da73752 RBX: ffff888259a64758 RCX: 0000000000000000
[ 5483.908859] RDX: 1ffff1104b34c8ee RSI: ffff88824f116800 RDI: ffff888259a64758
[ 5483.915991] RBP: ffff88824f116940 R08: 0000000000000003 R09: 0000000000000000
[ 5483.923122] R10: ffffffffaf4ec167 R11: 6d766e20656d766e R12: 0000000000000000
[ 5483.930255] R13: ffff88825eb56800 R14: ffff88824f116800 R15: ffffffffc19f8820
[ 5483.937389] FS: 0000000000000000(0000) GS:ffff88886dcc4000(0000)
knlGS:0000000000000000
[ 5483.945483] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5483.951228] CR2: 00007f8b14040e3c CR3: 0000000786678000 CR4: 0000000000350ef0
[ 5483.958361] Call Trace:
[ 5483.960814] <TASK>
[ 5483.962921] ? fcloop_t2h_xmt_ls_rsp+0x2d2/0x3d0 [nvme_fcloop]
[ 5483.968766] ? __pfx_fcloop_t2h_xmt_ls_rsp+0x10/0x10 [nvme_fcloop]
[ 5483.974948] ? nvme_fc_xmt_ls_rsp+0x156/0x1c0 [nvme_fc]
[ 5483.980191] ? nvme_fc_handle_ls_rqst_work+0x355/0x1180 [nvme_fc]
[ 5483.986294] ? rcu_is_watching+0x15/0xb0
[ 5483.990227] ? srso_return_thunk+0x5/0x5f
[ 5483.994246] ? process_one_work+0xd8b/0x1320
[ 5483.998534] ? __pfx_process_one_work+0x10/0x10
[ 5484.003073] ? srso_return_thunk+0x5/0x5f
[ 5484.007102] ? srso_return_thunk+0x5/0x5f
[ 5484.011123] ? assign_work+0x16c/0x240
[ 5484.014884] ? srso_return_thunk+0x5/0x5f
[ 5484.018910] ? worker_thread+0x5f3/0xfe0
[ 5484.022854] ? __pfx_worker_thread+0x10/0x10
[ 5484.027130] ? kthread+0x3b4/0x770
[ 5484.030544] ? __pfx_do_raw_spin_trylock+0x10/0x10
[ 5484.035344] ? srso_return_thunk+0x5/0x5f
[ 5484.039359] ? __pfx_kthread+0x10/0x10
[ 5484.043118] ? lock_acquire+0x10b/0x140
[ 5484.046959] ? calculate_sigpending+0x3d/0x90
[ 5484.051327] ? srso_return_thunk+0x5/0x5f
[ 5484.055347] ? rcu_is_watching+0x15/0xb0
[ 5484.059272] ? srso_return_thunk+0x5/0x5f
[ 5484.063285] ? __pfx_kthread+0x10/0x10
[ 5484.067042] ? ret_from_fork+0x4ce/0x710
[ 5484.070974] ? __pfx_ret_from_fork+0x10/0x10
[ 5484.075258] ? srso_return_thunk+0x5/0x5f
[ 5484.079276] ? __switch_to+0x528/0xf50
[ 5484.083037] ? __switch_to_asm+0x39/0x70
[ 5484.086972] ? __pfx_kthread+0x10/0x10
[ 5484.090734] ? ret_from_fork_asm+0x1a/0x30
[ 5484.094855] </TASK>
[ 5484.097049] Modules linked in: nvme_fcloop nvmet_fc nvmet nvme_fc
nvme_fabrics rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd
grace nfs_localio netfs platform_profile dell_wmi dell_smbios
sparse_keymap amd_atl intel_rapl_msr rfkill intel_rapl_common video
amd64_edac dcdbas edac_mce_amd kvm_amd vfat fat cdc_ether usbnet kvm
mii irqbypass mgag200 rapl wmi_bmof dell_wmi_descriptor i2c_algo_bit
pcspkr acpi_cpufreq i2c_piix4 ptdma i2c_smbus ipmi_ssif k10temp
acpi_power_meter ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler sg
loop fuse xfs sd_mod nvme ahci nvme_core libahci tg3
ghash_clmulni_intel nvme_keyring libata ccp nvme_auth mpt3sas hkdf
raid_class scsi_transport_sas sp5100_tco wmi sunrpc dm_mirror
dm_region_hash dm_log dm_mod nfnetlink [last unloaded: nvmet]



-- 
Best Regards,
  Yi Zhang


