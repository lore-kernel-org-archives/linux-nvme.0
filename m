Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C65EC3DA4A
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jul 2024 20:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=GBMgfixy+x8J4chK+XEr8yM6u1+DycWp9/E02fNR+AA=; b=Z7/hzKBOhhucScR/YZbiTi5iVB
	X5buzus7UwcezjJdIGH4Tb4iYbV//1Q7EwM7D7vcAKW/xKJ8uXe1MS8/emomjxNi7BoKyF/B8wQb+
	Duip7MUJBgZAVya2bIhLcPd5xQqZ3HcfaBAkpsnU2Oc7hrnbtObdPuXBtAcfCXizUT963NTvEvXCD
	tK50A1MNgiZo1IxrPHLqJYj3WB4TOI3a1+tS7IaE6qAcvq+fTjfN7Ur6qxt/Gp/vi5yqXWZEu74dm
	qvdjgsmvnldK1tpmEcaaeC24oyw34WWIja/a4UZ42bT1ukYlbyP0kp1Bt68Jvgpth6WOqc/MQbfm+
	/idRd+mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXRrt-00000004y8B-2Cyx;
	Fri, 26 Jul 2024 20:48:49 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXRrr-00000004y7e-0TFU
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jul 2024 20:48:48 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a7d26c2297eso197471366b.2
        for <linux-nvme@lists.infradead.org>; Fri, 26 Jul 2024 13:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722026925; x=1722631725; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GBMgfixy+x8J4chK+XEr8yM6u1+DycWp9/E02fNR+AA=;
        b=bMUd7M1s4hGWJ2NnwGyf5il8Osfv612OC8JsWB/J4qCmzLFNa7RKPow2duXMqQ7C6Z
         tLg0yEqSlEYJs5g7sVTHLrprEx4zyr/0J/Y1J4ZEeRTKt4lVJbEiSHjMk9Z4RhJgGUQs
         BP62u0D6Diu/iM2StDrxiaGfZi3EEub4s2oavZZk+O07dXjqz6WJQK9wxUk5df8/r/bQ
         EznWgOd5uqA/dUE1TF4pUwtZ/Wcxo7CPpU44p3Ax4FV1g1eFIgW2QWyOHQ+kDVOoSWQu
         IaymKb1mRcaPs9mJw608sLNOJ+38hvYY9zUc+JdyUv208jTJvz0wKQXRb6WkltebR5aO
         30WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722026925; x=1722631725;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBMgfixy+x8J4chK+XEr8yM6u1+DycWp9/E02fNR+AA=;
        b=m4p0hdNNRjqHbIMEv7hBtGkvN3rXBCOfTobj6wLhBDLmwLbxDmHFS56jZvO05hxHIw
         2WA6qaO6ZY+D8lRQ/musY+b57pQsYj+Og47IvbV3YwwLHNGES739FrXcbIaKaPIzWllZ
         StyNj72w2C5OO+GV/METqscFu3bC4DHqQCmk3zexunxCazx96L9X8GpsSB5kAGx6eGvz
         Q+758tAomBg9tdVXhVYCKz87SG1TH3Qdlr1EbZbG0WwTP9sIbvWosL38xUZpuAtbb3Sb
         CwKew2eET7nCNR4rMS10/yqxq3NYlV5vSnMJxE0JBzOEomf11LB8oA/ucQF/oPoyhNZA
         7AZw==
X-Forwarded-Encrypted: i=1; AJvYcCWMxY+qx/oRWACS/Z/XNqzQEelbUpBfdifmtcqPXbqkVBIhvwfJCg9tsWQp9Z0fZ9oGdvTdoDSKg6ZK@lists.infradead.org
X-Gm-Message-State: AOJu0YxIE3Npj43FTRbKspeAbABiJpMafXBGWkocREIyveRStcXCoLX9
	xBvdTpNkgFBBgQPy/tyy+ELv2BGuKPuL9AV8bhlJSR/q6TITef7g
X-Google-Smtp-Source: AGHT+IH/Wk3yKHVOGm6Q2V0uGvjeJYCJriHVdyxX3OVHO2TxkE0uWiwh2D6R3c+mhA8SO2IVFuazNQ==
X-Received: by 2002:a17:907:72cc:b0:a7a:9d74:21c3 with SMTP id a640c23a62f3a-a7d400a1a61mr52676966b.35.1722026924592;
        Fri, 26 Jul 2024 13:48:44 -0700 (PDT)
Received: from shift.daheim (p200300d5ff30930050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff30:9300:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2302dsm212952766b.39.2024.07.26.13.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 13:48:44 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=shift.localnet)
	by shift.daheim with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <chunkeey@gmail.com>)
	id 1sXSkR-00000000zGU-3SKI;
	Fri, 26 Jul 2024 22:48:43 +0200
From: Christian Lamparter <chunkeey@gmail.com>
To: hch@lst.de
Cc: axboe@kernel.dk, dlemoal@kernel.org, jasowang@redhat.com,
 kbusch@kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, martin.petersen@oracle.com, mst@redhat.com,
 pbonzini@redhat.com, sagi@grimberg.me, stefanha@redhat.com,
 virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 04/15] block: add an API to atomically update queue limits
Date: Fri, 26 Jul 2024 22:48:43 +0200
Message-ID: <2011786.tdWV9SEqCh@shift>
In-Reply-To: <20240213073425.1621680-5-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240726_134847_189757_A5580249 
X-CRM114-Status: GOOD (  12.29  )
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

got a WARNING splatch (=> boot harddrive is inaccessible - device fails to boot) 

------------[ cut here ]------------
WARNING: CPU: 0 PID: 29 at block/blk-settings.c:185 blk_validate_limits+0x154/0x294
Modules linked in:
CPU: 0 PID: 29 Comm: kworker/u4:2 Tainted: G        W          6.10.0+ #1
Hardware name: MyBook Live APM821XX 0x12c41c83 PowerPC 44x Platform
Workqueue: async async_run_entry_fn
NIP:  c02f1f00 LR: c02eef3c CTR: 00000000
REGS: c114bbc0 TRAP: 0700   Tainted: G        W           (6.10.0+)
MSR:  0002b000 <CE,EE,FP,ME>  CR: 84000008  XER: 00000000

GPR00: c02eef28 c114bcb0 c116cf40 c114bda8 00000082 ffffffff ffffffff 00000200
GPR08: 00000200 0000ffff 00001fff c114bc80 44000008 00000000 c00433f0 c119b440
GPR16: 00000000 00000000 00000000 00000000 c105d505 c1101880 c11b6250 00000001
GPR24: 00000000 c0ab0000 c114bda8 ffffffff c0a1eb68 00000000 00000014 c1b683d0
NIP [c02f1f00] blk_validate_limits+0x154/0x294
LR [c02eef3c] blk_alloc_queue+0x80/0x1f0
Call Trace:
[c114bcb0] [c02ffa54] blk_alloc_queue_stats+0x20/0x48 (unreliable)
[c114bcc0] [c02eef28] blk_alloc_queue+0x6c/0x1f0
[c114bcf0] [c02fde24] blk_mq_alloc_queue+0x50/0xa8
[c114bd90] [c04393b4] scsi_alloc_sdev+0x190/0x2b8
[c114be40] [c04395a8] scsi_probe_and_add_lun+0xcc/0x2a0
[c114bea0] [c043a008] __scsi_add_device+0xe4/0x134
[c114bee0] [c045296c] ata_scsi_scan_host+0x84/0x27c
[c114bf30] [c0048158] async_run_entry_fn+0x34/0xcc
[c114bf50] [c003c800] process_scheduled_works+0x170/0x244
[c114bf90] [c003cc48] worker_thread+0x184/0x1d4
[c114bfc0] [c00434bc] kthread+0xcc/0xd0
[c114bff0] [c000c210] start_kernel_thread+0x10/0x14
Code: 81430050 7c085040 40810008 91030050 81430004 2c0a0000 40820010 3940ffff 91430004 48000014 280a3ffe 41a1000c <0fe00000> 48000130 80c30008 81430020
---[ end trace 0000000000000000 ]---
scsi_alloc_sdev: Allocation failure during SCSI scanning, some SCSI devices might not be configured

---

This is due to this patch adds
| /*
|   * By default there is no limit on the segment boundary alignment,
|   * but if there is one it can't be smaller than the page size as
|   * that would break all the normal I/O patterns.
|   */
|   if (!lim->seg_boundary_mask)
|           lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
|   if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1)) <----- this warning gets triggered
|          return -EINVAL;

My guess is that this is caused by the kernel has a 16K page size.

CONFIG_HAVE_PAGE_SIZE_16KB=y
CONFIG_PAGE_SIZE_16KB=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_PAGE_SHIFT=14

This worked fine (sata driver is sata_dwc_460ex.c) in the past (and using 16K pages was
slightly faster than 4k pages)... and yes: using a 4K page size works (as in: device boots again).

Regards,
Christian



