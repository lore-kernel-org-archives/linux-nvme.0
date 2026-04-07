Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A91EDB7CA
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2026 08:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=H3YNCLpZhtdbRUe4D+cmakm06hCViIjBi6Xevylv3Hk=; b=jwK/6H1EY6Ca/LpekOWohtNofJ
	619b/zvYqhBIFbiAg+Uq2U+BCyMRO/du7MwRrCBc6T1zwOGaCcWziRr18TffwYkHC1jYOArUkc5Zl
	qmfQrBTH367GheaBBnCHUwScfe7vCfaIcSegD1qtlcKpA0kH8LZoymqDRh8gCK6ZskJ5SF1Wfs6Z6
	T818DRZ4qqukzxYHcxhPXdHVnpllnF3D2c1HXb22FdP4UMBJNMp8g4eG5q3kjqfrNuFStHh5RnoXn
	v49xotH9ARC6SIYeZjsYXWkvXw0nVkRq+kL6LmVlFv+nLSJriDmAJoqrlKaV8OExjzH0MriWuHrt7
	4zpz8RRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA1uD-00000006AVi-2VLd;
	Tue, 07 Apr 2026 08:35:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA1uA-00000006AUx-0JEG
	for linux-nvme@lists.infradead.org;
	Tue, 07 Apr 2026 08:35:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775550924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=H3YNCLpZhtdbRUe4D+cmakm06hCViIjBi6Xevylv3Hk=;
	b=AKLsFXGH9k5DKVb6okU3iA9k2Y55t2AWrNWKVzVgxuogxv8VeWTZ66GnnFv8Yhvg7gRNsN
	jnb4FWKe2bQ8AliBsgr6sKMXC1NpwTvtNp/KRTHKO2pVnI7SbM9kdZ2UYi/efPasmm36ZR
	P5fbUUtLdi7y2i44K8X69akZSHrLtl8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-7KQZLqhXNQaw0w7DbzXlpw-1; Tue, 07 Apr 2026 04:35:22 -0400
X-MC-Unique: 7KQZLqhXNQaw0w7DbzXlpw-1
X-Mimecast-MFC-AGG-ID: 7KQZLqhXNQaw0w7DbzXlpw_1775550921
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-38e007570ccso6464861fa.1
        for <linux-nvme@lists.infradead.org>; Tue, 07 Apr 2026 01:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775550919; x=1776155719;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H3YNCLpZhtdbRUe4D+cmakm06hCViIjBi6Xevylv3Hk=;
        b=GTQIAmeFi8cXZieRC33cYaY4iWaxSZSCSh3RC4LxRDc/LdAke29UX/x6ruSLzx5ZYy
         789e2bVK3dRV6JbW5xlUmBjONK81cM7lnfMbs7MyLp0UxpVh355lzltOhdQY1YOaowKg
         yXf5VkuLoDBtrfMdaeNAz/Ap3wEL8hKL07Jv529qDYJEuQSQU1pJXnV/2ozFq/cgX6aN
         WuLEOTvzNVhNzyhg+XSQqu0r4h3JG5id0Mo5rULvNbQMWHeUznQkd90/LMTkk7+gT/ye
         1rNtmZ8cZm9HRHGae8IStbMqVJuOEuOnlIB+3JZL5wYOc7OhXasRGHyEnP7knj5eTVId
         culA==
X-Gm-Message-State: AOJu0YxQnfzvHmby1spCFOejjiGtkvGKS/tIwT4U2tYNl99Xc7Uje/Ho
	k1cMsgfeygDTksuwCxfUYhQ16kN/nH0JB/8tZBUfndPRWUBi/QwQTZmhpkdHED8pU2ockV+5wNT
	0ovjOdgFGLRtyhN0GN92MDecOThjmreOUgej6YyuwDO1Ti9zNUQMbSmWyNJjUVKhfanrt84Qv62
	uIUntXUXhvpKi9I+0LrJXaLCA5g7/Vqes1zPXLOsiqWsoa8oxUHc0+kqpl
X-Gm-Gg: AeBDievF+rW2YfFxlgNnaTo5w2WrzbQV9jNxGFCDyiG8NZUUy/PSB48QIOJAP0o6m4w
	Y2rf74eHgd/MqwVR+ueY7PHJBQLkqOXQBtwRILX/TwKASRk8XPpvxuW52rmKgliHWuSocf1RNKb
	gVio8j2Z4xAXdfORB+Jo2jcbRlkT1aB/ZyPsdAQk5048xYAaUxewNW2HZDfR5YwP14lc/uQhjDV
	H4XgrCLzKNp15vkSKG2NJGReqjrBbs+kl/fpwrlPUn1Zzkka+g=
X-Received: by 2002:a05:651c:b10:b0:38b:50c7:8239 with SMTP id 38308e7fff4ca-38d91d8640dmr56996071fa.21.1775550919310;
        Tue, 07 Apr 2026 01:35:19 -0700 (PDT)
X-Received: by 2002:a05:651c:b10:b0:38b:50c7:8239 with SMTP id
 38308e7fff4ca-38d91d8640dmr56995961fa.21.1775550918715; Tue, 07 Apr 2026
 01:35:18 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 7 Apr 2026 16:35:06 +0800
X-Gm-Features: AQROBzCFuI_fl4d7uWWaJVmq8cYrYKTxVKcZzAz2dkZFHI_hGl8SkMCiDwV4pbs
Message-ID: <CAHj4cs-H=+1UkBuPa8M-_+Yy8cTqnNUT9grEqef=DdZfvgG+Gw@mail.gmail.com>
Subject: [bug report] Oops: general protection fault observed during blktests
 nvme/fc nvme/057 nvme/058
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Cc: Daniel Wagner <wagi@kernel.org>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JbG_Zz5Ib1FwNoW8L3Y65vIAfDsoKzQXqBqZzoL_8Ew_1775550921
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_013526_278518_153F427E 
X-CRM114-Status: UNSURE (   8.00  )
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
I reproduced this Oops issue on the latest linux-block/for-next and
v7.0-rc6, please help check it and let me know if you need any
info/test for it, thanks.

reproducer:
blktests nvme/fc nvme/057 nvme/058

console log:
[24778.056260] run blktests nvme/057 at 2026-04-07 03:53:44
[24784.172575] nvme nvme7: Found shared namespace 1, but multipathing
not supported.
[24785.576049] nvme nvme8: Found shared namespace 1, but multipathing
not supported.
[24785.649339] nvme_log_error: 72 callbacks suppressed
[24785.649351] nvme8n1: I/O Cmd(0x2) @ LBA 0, 8 blocks, I/O Error (sct
0x3 / sc 0x2) MORE
[24785.662411] blk_print_req_error: 72 callbacks suppressed
[24785.662417] I/O error, dev nvme8n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1 prio class 2
[24785.676236] buffer_io_error: 67 callbacks suppressed
[24785.676241] Buffer I/O error on dev nvme8n1, logical block 0, async page read
[24785.689844] nvme8n1: I/O Cmd(0x2) @ LBA 0, 8 blocks, I/O Error (sct
0x3 / sc 0x2) MORE
[24785.698047] I/O error, dev nvme8n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1 prio class 2
[24785.706525] Buffer I/O error on dev nvme8n1, logical block 0, async page read
[24785.716133] nvme8n1: I/O Cmd(0x2) @ LBA 0, 8 blocks, I/O Error (sct
0x3 / sc 0x2) MORE
[24785.724182] I/O error, dev nvme8n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1 prio class 2
[24785.732652] Buffer I/O error on dev nvme8n1, logical block 0, async page read
[24785.741196] nvme8n1: I/O Cmd(0x2) @ LBA 0, 8 blocks, I/O Error (sct
0x3 / sc 0x2) MORE
[24785.749242] I/O error, dev nvme8n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1 prio class 2
[24785.757706] Buffer I/O error on dev nvme8n1, logical block 0, async page read
[24785.766193] nvme8n1: I/O Cmd(0x2) @ LBA 0, 8 blocks, I/O Error (sct
0x3 / sc 0x2) MORE
[24785.774462] I/O error, dev nvme8n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1 prio class 2
[24785.782947] Buffer I/O error on dev nvme8n1, logical block 0, async page read
[24785.791432] nvme8n1: I/O Cmd(0x2) @ LBA 0, 8 blocks, I/O Error (sct
0x3 / sc 0x2) MORE
[24785.799769] I/O error, dev nvme8n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1 prio class 2
[24785.808239] Buffer I/O error on dev nvme8n1, logical block 0, async page read
[24785.907390] nvme8n1: I/O Cmd(0x2) @ LBA 2097024, 8 blocks, I/O
Error (sct 0x3 / sc 0x2) MORE
[24785.915982] I/O error, dev nvme8n1, sector 2097024 op 0x0:(READ)
flags 0x80700 phys_seg 1 prio class 2
[24785.926864] nvme8n1: I/O Cmd(0x2) @ LBA 2097024, 8 blocks, I/O
Error (sct 0x3 / sc 0x2) MORE
[24785.935445] I/O error, dev nvme8n1, sector 2097024 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 2
[24785.944442] Buffer I/O error on dev nvme8n1, logical block 262128,
async page read
[24787.014714] nvme nvme9: Found shared namespace 1, but multipathing
not supported.
[24787.109346] nvme9n1: I/O Cmd(0x2) @ LBA 0, 8 blocks, I/O Error (sct
0x3 / sc 0x2) MORE
[24787.117401] I/O error, dev nvme9n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1 prio class 2
[24787.125928] Buffer I/O error on dev nvme9n1, logical block 0, async page read
[24787.134760] nvme9n1: I/O Cmd(0x2) @ LBA 0, 8 blocks, I/O Error (sct
0x3 / sc 0x2) MORE
[24787.142808] I/O error, dev nvme9n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1 prio class 2
[24787.151340] Buffer I/O error on dev nvme9n1, logical block 0, async page read
[24787.159882] Buffer I/O error on dev nvme9n1, logical block 0, async page read
[24793.253267] nvme nvme6: NVME-FC{0}: transport association event:
transport detected io error
[24793.257123] nvme_log_error: 6 callbacks suppressed
[24793.257128] nvme6n1: I/O Cmd(0x1) @ LBA 543904, 8 blocks, I/O Error
(sct 0x3 / sc 0x70)
[24793.257139] blk_print_req_error: 6 callbacks suppressed
[24793.257143] recoverable transport error, dev nvme6n1, sector 543904
op 0x1:(WRITE) flags 0x8800 phys_seg 1 prio class 2
[24793.257673] nvme6n1: I/O Cmd(0x1) @ LBA 411480, 8 blocks, I/O Error
(sct 0x3 / sc 0x70)
[24793.257682] recoverable transport error, dev nvme6n1, sector 411480
op 0x1:(WRITE) flags 0x8800 phys_seg 1 prio class 2
[24793.258044] nvme6n1: I/O Cmd(0x1) @ LBA 710688, 8 blocks, I/O Error
(sct 0x3 / sc 0x70)
[24793.258053] recoverable transport error, dev nvme6n1, sector 710688
op 0x1:(WRITE) flags 0x8800 phys_seg 1 prio class 2
[24793.261036] nvme6n1: I/O Cmd(0x1) @ LBA 397960, 8 blocks, I/O Error
(sct 0x3 / sc 0x70)
[24793.261047] recoverable transport error, dev nvme6n1, sector 397960
op 0x1:(WRITE) flags 0x8800 phys_seg 1 prio class 2
[24793.261329] nvme6n1: I/O Cmd(0x1) @ LBA 1591072, 8 blocks, I/O
Error (sct 0x3 / sc 0x70)
[24793.261338] recoverable transport error, dev nvme6n1, sector
1591072 op 0x1:(WRITE) flags 0x8800 phys_seg 1 prio class 2
[24793.261931] nvme nvme6: NVME-FC{0}: resetting controller
[24793.262852] nvme6n1: I/O Cmd(0x1) @ LBA 222192, 8 blocks, I/O Error
(sct 0x3 / sc 0x70)
[24793.262864] recoverable transport error, dev nvme6n1, sector 222192
op 0x1:(WRITE) flags 0x8800 phys_seg 1 prio class 2
[24793.274891] nvme6n1: I/O Cmd(0x1) @ LBA 1214144, 8 blocks, I/O
Error (sct 0x3 / sc 0x70)
[24793.399106] recoverable transport error, dev nvme6n1, sector
1214144 op 0x1:(WRITE) flags 0x8800 phys_seg 1 prio class 2
[24793.455979] nvme6n1: I/O Cmd(0x1) @ LBA 560192, 8 blocks, I/O Error
(sct 0x3 / sc 0x2) MORE
[24793.456341] nvme6n1: I/O Cmd(0x1) @ LBA 1352744, 8 blocks, I/O
Error (sct 0x3 / sc 0x2) MORE
[24793.456364] nvme6n1: I/O Cmd(0x1) @ LBA 1353024, 8 blocks, I/O
Error (sct 0x3 / sc 0x2) MORE
[24793.456379] I/O error, dev nvme6n1, sector 1353024 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 2
[24793.456988] I/O error, dev nvme6n1, sector 1913184 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 2
[24793.457182] I/O error, dev nvme6n1, sector 864944 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 2
[24793.544368] buffer_io_error: 4 callbacks suppressed
[24793.544379] Buffer I/O error on dev nvme6n1, logical block 0, async page read
[24793.560206] Buffer I/O error on dev nvme6n1, logical block 0, async page read
[24793.569388] Buffer I/O error on dev nvme6n1, logical block 0, async page read
[24793.578024] Buffer I/O error on dev nvme6n1, logical block 0, async page read
[24793.586584] Buffer I/O error on dev nvme6n1, logical block 0, async page read
[24793.595761] Buffer I/O error on dev nvme6n1, logical block 0, async page read
[24793.659221] Buffer I/O error on dev nvme6n1, logical block 262128,
async page read
[24814.210989] Oops: general protection fault, probably for
non-canonical address 0xdffffc0000000005: 0000 [#1] SMP KASAN NOPTI
[24814.222213] KASAN: null-ptr-deref in range
[0x0000000000000028-0x000000000000002f]
[24814.229789] CPU: 10 UID: 0 PID: 1547 Comm: kworker/u66:2 Not
tainted 7.0.0-rc6+ #1 PREEMPT(full)
[24814.238670] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.21.1 09/24/2025
[24814.246331] Workqueue: nvmet-wq fcloop_tgt_fcprqst_done_work [nvme_fcloop]
[24814.253219] RIP: 0010:kasan_byte_accessible+0x15/0x30
[24814.258280] Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90
90 90 90 90 90 0f 1f 40 d6 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03
48 01 c7 <0f> b6 07 3c 07 0f 96 c0 e9 0e d5 04 02 66 66 2e 0f 1f 84 00
00 00
[24814.277034] RSP: 0018:ffffc9000bc9fb68 EFLAGS: 00010286
[24814.282268] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
[24814.289400] RDX: 0000000000000000 RSI: ffffffff89610547 RDI: dffffc0000000005
[24814.296532] RBP: 0000000000000028 R08: 0000000000000001 R09: 0000000000000000
[24814.303666] R10: ffffffff8b7bd367 R11: 0000000000000001 R12: ffffffff89610547
[24814.310799] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
[24814.317939] FS:  0000000000000000(0000) GS:ffff8887d23ca000(0000)
knlGS:0000000000000000
[24814.326033] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[24814.331779] CR2: 0000555867b457e8 CR3: 000000020526f000 CR4: 0000000000350ef0
[24814.338911] Call Trace:
[24814.341365]  <TASK>
[24814.343469]  __kasan_check_byte+0x13/0x50
[24814.347493]  lock_acquire.part.0+0x36/0x260
[24814.351687]  ? fcloop_tgt_fcprqst_done_work+0x104/0x200 [nvme_fcloop]
[24814.358135]  ? srso_return_thunk+0x5/0x5f
[24814.362153]  ? rcu_is_watching+0x15/0xb0
[24814.366082]  ? srso_return_thunk+0x5/0x5f
[24814.370102]  ? lock_acquire+0x159/0x180
[24814.373955]  _raw_spin_lock+0x37/0x80
[24814.377626]  ? fcloop_tgt_fcprqst_done_work+0x104/0x200 [nvme_fcloop]
[24814.384073]  fcloop_tgt_fcprqst_done_work+0x104/0x200 [nvme_fcloop]
[24814.390351]  process_one_work+0xd98/0x1390
[24814.394465]  ? __pfx_process_one_work+0x10/0x10
[24814.399017]  ? srso_return_thunk+0x5/0x5f
[24814.403039]  worker_thread+0x60b/0x1000
[24814.406895]  ? __pfx_worker_thread+0x10/0x10
[24814.411171]  kthread+0x36c/0x470
[24814.414414]  ? _raw_spin_unlock_irq+0x28/0x50
[24814.418780]  ? __pfx_kthread+0x10/0x10
[24814.422546]  ret_from_fork+0x5dc/0x8e0
[24814.426306]  ? __pfx_ret_from_fork+0x10/0x10
[24814.430588]  ? srso_return_thunk+0x5/0x5f
[24814.434605]  ? __switch_to+0x524/0xf50
[24814.438367]  ? __switch_to_asm+0x39/0x70
[24814.442302]  ? __pfx_kthread+0x10/0x10
[24814.446065]  ret_from_fork_asm+0x1a/0x30
[24814.450012]  </TASK>
[24814.452206] Modules linked in: nvme_fcloop nvmet_fc nvme_fc nvmet
nvme_fabrics platform_profile dell_wmi dell_smbios amd_atl
intel_rapl_msr intel_rapl_common amd64_edac sparse_keymap edac_mce_amd
rfkill video vfat dcdbas fat kvm_amd cdc_ether usbnet mii kvm
irqbypass dell_wmi_descriptor wmi_bmof rapl acpi_cpufreq pcspkr
ipmi_ssif i2c_piix4 ptdma k10temp i2c_smbus acpi_power_meter ipmi_si
acpi_ipmi ipmi_devintf ipmi_msghandler sg loop fuse xfs sd_mod nvme
ahci mgag200 libahci i2c_algo_bit mpt3sas ghash_clmulni_intel
nvme_core tg3 raid_class libata nvme_keyring ccp nvme_auth
scsi_transport_sas sp5100_tco wmi sunrpc dm_mirror dm_region_hash
dm_log dm_mod i2c_dev nfnetlink [last unloaded: nvmet_fc]
[24814.514133] ---[ end trace 0000000000000000 ]---
[24814.691561] RIP: 0010:kasan_byte_accessible+0x15/0x30
[24814.696869] Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90
90 90 90 90 90 0f 1f 40 d6 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03
48 01 c7 <0f> b6 07 3c 07 0f 96 c0 e9 0e d5 04 02 66 66 2e 0f 1f 84 00
00 00
[24814.715839] RSP: 0018:ffffc9000bc9fb68 EFLAGS: 00010286
[24814.721279] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
[24814.728651] RDX: 0000000000000000 RSI: ffffffff89610547 RDI: dffffc0000000005
[24814.736122] RBP: 0000000000000028 R08: 0000000000000001 R09: 0000000000000000
[24814.743575] R10: ffffffff8b7bd367 R11: 0000000000000001 R12: ffffffff89610547
[24814.750962] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
[24814.758254] FS:  0000000000000000(0000) GS:ffff8887d23ca000(0000)
knlGS:0000000000000000
[24814.766373] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[24814.772139] CR2: 0000555867b457e8 CR3: 000000020526f000 CR4: 0000000000350ef0
[24814.779291] Kernel panic - not syncing: Fatal exception
[24814.785098] Kernel Offset: 0x5600000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[24814.976844] ---[ end Kernel panic - not syncing: Fatal exception ]---



-- 
Best Regards,
  Yi Zhang


