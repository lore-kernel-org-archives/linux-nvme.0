Return-Path: <SRS0=FZGd=J4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB614C433ED
	for <linux-nvme@archiver.kernel.org>; Sat,  1 May 2021 00:55:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5586140C
	for <linux-nvme@archiver.kernel.org>; Sat,  1 May 2021 00:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5586140C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3siuEhLpRiJHlm8AO/nQ8UGEv5TXXYKFNjntl1QC0WA=; b=cakrZ43zcjBOhkp1xEOY7eSOy
	TZ8b/rmRT/FeKHtusbUi6IT3zzYzEuSVgiHHR8mPS5J+R9GmJoLe/dY4pgE1Y7MYxkBO2rcHy+WlH
	tHjQ6jO2k4Uh3AS0V9K+zmdueb2QxioklnPC/UCFekXY4BaZr3aWNAxXvF9NvrYW3GLoSv5DNeDXR
	Y0JkJmMboUOfOcybqUL07HZgLr/bXjprk6oY61rQMF/zUiJiaJeOcLPRG9CoacecbAVgeN2YmdB0O
	9eUORRWQnKkDg6+lAdFNAsezQUXIS5mydAUgnTMiivDVhxMGrEtYyP8avjeqDGBbenl8/PGdImhUr
	ZHQMhC0qA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcdui-0092xD-W4; Sat, 01 May 2021 00:55:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcdue-0092wp-B2
 for linux-nvme@desiato.infradead.org; Sat, 01 May 2021 00:55:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=0YwBiqs+ljNG0ui/8TtcNHSgAA/FDR4xYROGZl3i7Yk=; b=ZpDRoxggi9QrFnaYEHTp/OO6a4
 AIhvT1gyWMtwxdTZLhVhhab5ipoCxNxAzas9aZpUAWCUJ7gN1mGtgaUxkmguvXjBB/vkWLNlXeq5X
 1htNLBrUYE3vqHmXCaAT+kYG0dl3TqJsajXSnQmXEV2AutwSX52LekU3UsAn9QYhC0cSFrm6TWOkA
 oGOPwWxVNi2ZV+fEsZApwwSBeAZ5QbQuIdxI2d0aMHWm73t50w/I+perTBUz3GaQ7nle4jfJhd1ZS
 yIDEPNGHHZxmAxiwWr5pN1rTyEgQn2Vkktjrs4T90lBMYP9/Gyh3MgzW6I+c/xX59ansqsP7DZB17
 tlzOhe8g==;
Received: from mail-pf1-f174.google.com ([209.85.210.174])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcdub-001lrm-0n
 for linux-nvme@lists.infradead.org; Sat, 01 May 2021 00:55:14 +0000
Received: by mail-pf1-f174.google.com with SMTP id i13so297314pfu.2
 for <linux-nvme@lists.infradead.org>; Fri, 30 Apr 2021 17:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0YwBiqs+ljNG0ui/8TtcNHSgAA/FDR4xYROGZl3i7Yk=;
 b=O5+777RVfjs1eNAVSOKp5L3eO3OLpZ17eaCxrV62Y92mLJ2E/0P2/6WEo0JV3bh5xg
 Uuot3N8iAcfQvNFMem7aNifAdjL1nfT4L0Tmm/lMQgciZie/g7MTabGtQV5DDyCCC4Ch
 JABpNbH2tp+DtUIB4pqINbNMykE/JNDzZ8P49sI19Zc+UZ4Hfc3dZXprZ5Lw4p4WKHsg
 3o+SJjwK/7NtjYg0iBbdPu5mFZdDZpHyghxApCisBYUY1dQCTEx9UV0Q5VHJV0/5hgiQ
 aPG1EjQUoJFWHvi7rWOj9EK68YaWaoYBCmF7A7OVbO8VCx4J4lXh+g7k9ynh5x5VerKV
 NIvw==
X-Gm-Message-State: AOAM531My/5HvEhA+EUGLIYML3vI4yWDXrwrdnBJ/ZOoZIFMNEMSDcbm
 /BLzFEgyYF75hP9Kc73RNCq7U4vTuZ8=
X-Google-Smtp-Source: ABdhPJyiG5GjDFm8KGHvfK0c71u3uuxxgVUoQjrp140QU8v8n8VSDNu2LHEFSLwYI9dddlk1mq9x+A==
X-Received: by 2002:a62:2904:0:b029:25c:13f2:47d4 with SMTP id
 p4-20020a6229040000b029025c13f247d4mr7505300pfp.4.1619830511873; 
 Fri, 30 Apr 2021 17:55:11 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4771:746e:801f:eccb?
 ([2601:647:4802:9070:4771:746e:801f:eccb])
 by smtp.gmail.com with ESMTPSA id z12sm11527445pjt.29.2021.04.30.17.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Apr 2021 17:55:11 -0700 (PDT)
Subject: Re: [bug report] blktests nvme/022 lead kernel WARNING and NULL
 pointer
To: Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org
Cc: skt-results-master@redhat.com, Bruno Goncalves <bgoncalv@redhat.com>
References: <CAHj4cs-hAaHhWU4Kb4NrQ9Fvi7DiH95P=Q=7zK-inxpeZtztkw@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3243ab72-ffe3-e655-ef0a-d695885ce2c5@grimberg.me>
Date: Fri, 30 Apr 2021 17:55:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAHj4cs-hAaHhWU4Kb4NrQ9Fvi7DiH95P=Q=7zK-inxpeZtztkw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210430_175513_107552_E4C38970 
X-CRM114-Status: GOOD (  16.38  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hello
> Recently CKI reproduced this WARNING and NULL pointer with
> linux-block/for-next on aarch64, seems it's one regression, I will try
> if I can bisect the culprit.
> 
> blktests: nvme/022 (test NVMe reset command on NVMeOF file-backed ns)
> 
> [ 1879.759978] run blktests nvme/022 at 2021-04-30 12:30:36
> [ 1879.804283] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [ 1879.819087] nvmet: creating controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0da758a0-4d84-4133-82dd-9801235b55cd.
> [ 1879.833081] nvmet: unhandled identify cns 6 on qid 0
> [ 1879.838079] nvme nvme0: creating 128 I/O queues.
> [ 1879.852353] nvme nvme0: new ctrl: "blktests-subsystem-1"
> [ 1880.879731] nvme nvme0: resetting controller
> [ 1889.940458] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> [ 1889.946377] nvmet: ctrl 1 fatal error occurred!
> [ 1889.950928] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"

It appears that we are somehow now expire the kato after/during a reset
sequence and then seem to race reset and remove...

bisection will help definitely.

> [ 1892.810813] -
> [ 1892.815427] WARNING: CPU: 30 PID: 5492 at
> drivers/nvme/target/loop.c:466 nvme_loop_reset_ctrl_work+0x48/0xf0
> [nvme_loop]
> [ 1892.826293] Modules linked in: nvme_loop nvme_fabrics nvme_core
> nvmet loop rfkill rpcrdma sunrpc rdma_ucm ib_srpt ib_isert
> iscsi_target_mod target_core_mod ib_iser vfat libiscsi fat
> scsi_transport_iscsi ib_umad rdma_cm ib_ipoib iw_cm ib_cm mlx5_ib
> ib_uverbs i2c_smbus ib_core crct10dif_ce ghash_ce sha1_ce acpi_ipmi
> ipmi_ssif ipmi_devintf ipmi_msghandler thunderx2_pmu ip_tables xfs
> libcrc32c sr_mod cdrom mlx5_core ast i2c_algo_bit drm_vram_helper
> drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
> drm_ttm_helper ttm drm uas mlxfw sha2_ce tls sha256_arm64 usb_storage
> sg psample gpio_xlp i2c_xlp9xx dm_mirror dm_region_hash dm_log dm_mod
> [last unloaded: nvmet]
> [ 1892.885150] CPU: 30 PID: 5492 Comm: kworker/u513:5 Not tainted 5.12.0+ #1
> [ 1892.891926] Hardware name: HPE Apollo 70             /C01_APACHE_MB
>          , BIOS L50_5.13_1.16 07/29/2020
> [ 1892.901654] Workqueue: nvme-reset-wq nvme_loop_reset_ctrl_work [nvme_loop]
> [ 1892.908519] pstate: 40400009 (nZcv daif +PAN -UAO -TCO BTYPE=--)
> [ 1892.914513] pc : nvme_loop_reset_ctrl_work+0x48/0xf0 [nvme_loop]
> [ 1892.920508] lr : nvme_loop_reset_ctrl_work+0x40/0xf0 [nvme_loop]
> [ 1892.926502] sp : fffffe0031b6fd70
> [ 1892.929803] x29: fffffe0031b6fd70 x28: 0000000000000000
> [ 1892.935105] x27: fffffc081065c0c0 x26: fffffc0807c2c26c
> [ 1892.940405] x25: 0000000000000000 x24: fffffc084ae24898
> [ 1892.945705] x23: 0000000000000000 x22: fffffc09410c1d00
> [ 1892.951004] x21: fffffc084ae24890 x20: fffffc084ae244a0
> [ 1892.956305] x19: fffffc084ae24000 x18: 0000000000000012
> [ 1892.961604] x17: 0000000000000001 x16: 0000000000000019
> [ 1892.966904] x15: fffffe0011d7e7e0 x14: fffffc8ba09cedf8
> [ 1892.972204] x13: 0000000000000000 x12: 0000000000000003
> [ 1892.977504] x11: fffffc8ba09ced40 x10: fffffe0011d7e7e8
> [ 1892.982804] x9 : fffffe000ad60c58 x8 : fffffe8b650f0000
> [ 1892.988104] x7 : 0000000000000008 x6 : fffffc0000000000
> [ 1892.993403] x5 : 0000000000000000 x4 : ffffffff22f337e0
> [ 1892.998703] x3 : fffffc084ae244ac x2 : 0000000000000001
> [ 1893.004003] x1 : fffffc084ae244ac x0 : 0000000000000000
> [ 1893.009303] Call trace:
> [ 1893.011737]  nvme_loop_reset_ctrl_work+0x48/0xf0 [nvme_loop]
> [ 1893.017384]  process_one_work+0x1d0/0x438
> [ 1893.021385]  worker_thread+0x1f8/0x4d8
> [ 1893.025123]  kthread+0x114/0x118
> [ 1893.028341]  ret_from_fork+0x10/0x18
> [ 1893.031907] ---[ end trace 883109425327ab60 ]---
> [ 1893.301843] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000008
> [ 1893.310620] Mem abort info:
> [ 1893.313401]   ESR = 0x96000006
> [ 1893.316442]   EC = 0x25: DABT (current EL), IL = 32 bits
> [ 1893.321741]   SET = 0, FnV = 0
> [ 1893.324783]   EA = 0, S1PTW = 0
> [ 1893.327911] Data abort info:
> [ 1893.330778]   ISV = 0, ISS = 0x00000006
> [ 1893.334600]   CM = 0, WnR = 0
> [ 1893.337555] user pgtable: 64k pages, 42-bit VAs, pgdp=0000000a0b750000
> [ 1893.344069] [0000000000000008] pgd=0000000000000000,
> p4d=0000000000000000, pud=0000000000000000, pmd=0000000000000000
> [ 1893.354669] Internal error: Oops: 96000006 [#1] SMP
> [ 1893.359535] Modules linked in: nvme_loop nvme_fabrics nvme_core
> nvmet loop rfkill rpcrdma sunrpc rdma_ucm ib_srpt ib_ ib_ipoib iw_cm
> intf ipmi_msghandrm_kms_helper s64 usb_storage s.418386] CPU: 0 PID:
> 12871 Comm: kworker/u513:0 Tainted: G        W         5.12.0+ #1
> [ 1893.426551] Hardware name: HPE Apollo 70             /C01_APACHE_MB
>          , BIOS L50_5.13_1.16 07/29/2020
> [ 1893.436277] Workqueue: nvme-delete-wq nvme_delete_ctrl_work [nvme_core]
> [ 1893.442892] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO BTYPE=--)
> [ 1893.448886] pc : percpu_ref_kill_and_confirm+0x15c/0x178
> [ 1893.454189] lr : nvmet_sq_destroy+0xec/0x1f0 [nvmet]
> [ 1893.459149] sp : fffffe006466fc70
> [ 1893.462449] x29: fffffe006466fc70 x28: 0000000000000000
> [ 1893.467750] x27: fffffc8bcee4e5c0 x26: fffffc0807f57a6c
> [ 1893.473051] x25: 0000000000000000 x24: fffffc084ae248b8
> [ 1893.478351] x23: fffffc0854e600d0 x22: fffffe000ac40600
> [ 1893.483650] x21: 0000000000000000 x20: fffffc0854e60090
> [ 1893.488950] x19: fffffe0011d7e000 x18: 0000000000000016
> [ 1893.494250] x17: 0000000000000001 x16: fffffc084e210598
> [ 1893.499550] x15: fffffe0011d7e7e0 x14: fffffc8ba09cee18
> [ 1893.504850] x13: 0000000000000000 x12: fffffe006466fc68
> [ 1893.510149] x11: 0000000000000040 x10: fffffe001158b2f8
> [ 1893.515449] x9 : fffffe000ad608ec x8 : fffffc082000cfc0
> [ 1893.520749] x7 : 0000000000000001 x6 : fffffc0000000000
> [ 1893.526049] x5 : 0000000000000080 x4 : 0000000000000000
> [ 1893.531349] x3 : 0000000000000000 x2 : fffffe0011a4e000
> [ 1893.536649] x1 : fffffe0010bdec08 x0 : fffffe0010e95000
> [ 1893.541949] Call trace:
> [ 1893.544383]  percpu_ref_kill_and_confirm+0x15c/0x178
> [ 1893.549335]  nvmet_sq_destroy+0xec/0x1f0 [nvmet]
> [ 1893.553945]  nvme_loop_destroy_io_queues+0x64/0x90 [nvme_loop]
> [ 1893.559767]  nvme_loop_shutdown_ctrl+0x60/0xb8 [nvme_loop]
> [ 1893.565240]  nvme_loop_delete_ctrl_host+0x18/0x20 [nvme_loop]
> [ 1893.570973]  nvme_do_delete_ctrl+0x58/0x6c [nvme_core]
> [ 1893.576106]  nvme_delete_ctrl_work+0x18/0x38 [nvme_core]
> [ 1893.581411]  process_one_work+0x1d0/0x438
> [ 1893.585410]  worker_thread+0x150/0x4d8
> [ 1893.589148]  kthread+0x114/0x118
> [ 1893.592364]  ret_from_fork+0x10/0x18
> [ 1893.595929] Code: 39244840 f0003781 d0004d40 91302021 (f9400462)
> [ 1893.602139] ---[ end trace 883109425327ab61 ]---
> [ 1893.606744] Kernel panic - not syncing: Oops: Fatal exception
> [ 1893.612512] SMP: stopping secondary CPUs
> [ 1893.616474] Kernel Offset: disabled
> [ 1893.619949] CPU features: 0x00046002,63000838
> [ 1893.624293] Memory Limit: none
> [ 1893.627362] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
