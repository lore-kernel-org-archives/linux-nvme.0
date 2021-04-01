Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2F4C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 04:12:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0966101A
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 04:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0966101A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:From:To:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tm/D/g18kthoYS5LaCEtvZ9IqUfEvCZ1nwOcQizfcnY=; b=IDlaMtIK6m/3WX
	fK/Hf6+nnGoGVvxgQMGE5JR4Dk8mEf1ZepeU6+FVVAKqWdt7qUKTYFwFRj2c1dAmeqarfpCPwKwE6
	Y7Rzasssz6PFplGsbEkHXLbPlMjP6tpGiy6R4Be7E3Sa2ZGA3ymDVmI/LmkAnRgW0xjrfU/QlNVLf
	XWJiCBLZfx/ecZaQhEJZ1yQwLhGVY4lrSkSqpDf4lrhFrJEeH8F+D8j/mUKO8lkKyC8XIWbsa7Rxa
	KYS0hcZzJbkHC2tcKTUf8azDahH1BWjzB9ojBQhQGZ0Nd7XShMSCDtxzbzOJCjiVg3m9Ctd1/NEd8
	RW3hJzgA2fikGEgsYx7g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRogj-008OmU-PM; Thu, 01 Apr 2021 04:12:09 +0000
Received: from mail-pj1-f44.google.com ([209.85.216.44])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRoYW-008Njf-DB
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 04:03:44 +0000
Received: by mail-pj1-f44.google.com with SMTP id
 nh23-20020a17090b3657b02900c0d5e235a8so311846pjb.0
 for <linux-nvme@lists.infradead.org>; Wed, 31 Mar 2021 21:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=Bn3JTuQh+lXhfdV50vhV+Qni+UwtlwqpRR/eiJNmBO4=;
 b=WTXzjkPPjOBuNFQKUHgDQ2VWbEjpX2m1BLysmQe+HYlAmmCsZLCeW/kLXK9rdF9vLk
 kr2X8btfBln2fo+X05zElqZgqi4umrS++hl2Ks+0c/M68DlaGoixKzBdDFpK8hTFzyf2
 ELij3l4JtKjmOqq5ahrHRx45BcoOy5WAlhctUInTGZcQphd2mmpPlT53pe76C+OaIO5p
 3jcErtlJkDZYKXxUUa1x5AdjW0w/DOaGbrVfLI9UfEqr9IzKYAMj9ysy4+i5OQD97FZK
 EMAdZHtIMljm3ZEvi3j6B1P3/B+rnDKrG+JQP3s/ObkBr7vXWoelFo0hgSONyFUr5TgQ
 CqcQ==
X-Gm-Message-State: AOAM533qWfZL9ANLeEtarxgEU7hf0PWdWsOHguuJY5aFr7llDtF0yws4
 xWN5hqiFAlYId/M1a1DC3Z8nGyUGawE=
X-Google-Smtp-Source: ABdhPJzzCo0v0ntVx+Beh7HdQKIQY4j4R6UA0zKwwZwI8bkggFpX7vyaKY1zJTEqlRuZdZhzFJiTqw==
X-Received: by 2002:a17:90a:5d09:: with SMTP id
 s9mr6678858pji.172.1617249817744; 
 Wed, 31 Mar 2021 21:03:37 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:be87:d7bf:6a65:f00d?
 ([2601:647:4000:d7:be87:d7bf:6a65:f00d])
 by smtp.gmail.com with ESMTPSA id n5sm3759016pfq.44.2021.03.31.21.03.36
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Mar 2021 21:03:37 -0700 (PDT)
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Bart Van Assche <bvanassche@acm.org>
Subject: Recursive locking complaint with nvme-5.13 branch
Message-ID: <f8288fe3-d8d2-5cfe-6aef-410bcd6e6231@acm.org>
Date: Wed, 31 Mar 2021 21:03:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_050340_743514_C98CA023 
X-CRM114-Status: UNSURE (   9.23  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

If I boot a VM with the nvme-5.13 branch (commit 24e238c92186
("nvme: warn of unhandled effects only once")) then the complaint
shown below is reported. Is this a known issue?

Thanks,

Bart.


============================================
WARNING: possible recursive locking detected
5.12.0-rc3-dbg+ #6 Not tainted
--------------------------------------------
systemd-udevd/299 is trying to acquire lock:
ffff88811b1e80a0 (&bdev->bd_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x85/0x350

but task is already holding lock:
ffff8881134100a0 (&bdev->bd_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x1a9/0x350

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&bdev->bd_mutex);
  lock(&bdev->bd_mutex);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by systemd-udevd/299:
 #0: ffff8881134100a0 (&bdev->bd_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x1a9/0x350
 #1: ffffffffa10269c8 (pktcdvd_mutex){+.+.}-{3:3}, at: pkt_open+0x22/0x15a [pktcdvd]
 #2: ffffffffa1025788 (&ctl_mutex#2){+.+.}-{3:3}, at: pkt_open+0x30/0x15a [pktcdvd]

stack backtrace:
CPU: 6 PID: 299 Comm: systemd-udevd Not tainted 5.12.0-rc3-dbg+ #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
Call Trace:
 show_stack+0x52/0x58
 dump_stack+0x9d/0xcf
 print_deadlock_bug.cold+0x131/0x136
 validate_chain+0x6d3/0xc70
 ? check_prev_add+0x11d0/0x11d0
 __lock_acquire+0x500/0x920
 ? start_flush_work+0x375/0x510
 ? __this_cpu_preempt_check+0x13/0x20
 lock_acquire.part.0+0x117/0x210
 ? blkdev_get_by_dev+0x85/0x350
 ? rcu_read_unlock+0x50/0x50
 ? __this_cpu_preempt_check+0x13/0x20
 ? lock_is_held_type+0xdb/0x130
 lock_acquire+0x9b/0x1a0
 ? blkdev_get_by_dev+0x85/0x350
 __mutex_lock+0x117/0xb60
 ? blkdev_get_by_dev+0x85/0x350
 ? blkdev_get_by_dev+0x85/0x350
 ? mutex_lock_io_nested+0xa70/0xa70
 ? __kasan_check_write+0x14/0x20
 ? __mutex_unlock_slowpath+0xa7/0x290
 ? __ww_mutex_check_kill+0x160/0x160
 ? trace_hardirqs_on+0x2b/0x130
 ? mutex_unlock+0x12/0x20
 ? disk_block_events+0x92/0xc0
 mutex_lock_nested+0x1b/0x20
 blkdev_get_by_dev+0x85/0x350
 ? __mutex_lock+0x49c/0xb60
 pkt_open_dev+0x7f/0x370 [pktcdvd]
 ? pkt_open_write+0x120/0x120 [pktcdvd]
 ? __ww_mutex_check_kill+0x160/0x160
 pkt_open+0xfd/0x15a [pktcdvd]
 __blkdev_get+0xa3/0x450
 blkdev_get_by_dev+0x1b4/0x350
 ? __kasan_check_read+0x11/0x20
 blkdev_open+0xa4/0x120
 do_dentry_open+0x27d/0x690
 ? blkdev_get_by_dev+0x350/0x350
 vfs_open+0x58/0x60
 do_open+0x316/0x4a0
 path_openat+0x1b8/0x260
 ? do_tmpfile+0x160/0x160
 ? __this_cpu_preempt_check+0x13/0x20
 do_filp_open+0x12d/0x240
 ? may_open_dev+0x60/0x60
 ? __kasan_check_read+0x11/0x20
 ? do_raw_spin_unlock+0x98/0xf0
 ? preempt_count_sub+0x18/0xc0
 ? _raw_spin_unlock+0x2d/0x50
 do_sys_openat2+0xe9/0x260
 ? build_open_flags+0x2a0/0x2a0
 __x64_sys_openat+0xd3/0x130
 ? __ia32_sys_open+0x110/0x110
 ? __secure_computing+0x74/0x140
 ? syscall_trace_enter.constprop.0+0x71/0x230
 do_syscall_64+0x32/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
