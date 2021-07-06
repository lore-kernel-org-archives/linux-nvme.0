Return-Path: <SRS0=sCQG=L6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0E2C07E96
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jul 2021 08:10:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 903C161357
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jul 2021 08:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903C161357
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0KSzxrlMcRBOByEriDN9TpTklfFAWdU7DEFlZC5HzKg=; b=yR+Jg/WuZhSG398bPc0RCFqTqR
	Xosvv1BkgaqtpYwJ6ThaHLsofw6hsYczciesDs042l6sV5vVwK7RFZ4hzDWDniB8/ZMU5Wx5dr8JH
	CwaK4xpT3GcOcUViVu3oEfC6SsIcg7iC0SLp7LYKRdoZxUQLqN/gy8flD1ZK28FH3fmuC9yYtaxv/
	nNWN3yfDzBng/FXMxUGkx9jt/MrtEh+Em0xwiPrhs8NL6CrIf5zDvdYxWxVc0K+nvd/XfsSFzrI+n
	u3C298npi2MspfD3zk53dziS4/obRmTnmKv1J9NRKPriyjj8DcEZ+ylY3fISrBKI7TfuNG3hRzq6J
	p7yBmNIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0g9o-00AlwQ-D7; Tue, 06 Jul 2021 08:10:16 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0g9j-00Alvm-P7
 for linux-nvme@lists.infradead.org; Tue, 06 Jul 2021 08:10:14 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6B4BA226A7;
 Tue,  6 Jul 2021 08:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625559010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SowY9kRlKQd/sAYBU0dK4HTbkVdfxpdCzxqbS1MkAwY=;
 b=X2gLgHOJCchrPDxVRGTESCxxOmVnYVmjSFjRg2F6uA2sb4JRqHA6kFfyt/6jT1Y3eqwLXR
 CRGzaOPNmVmah0xW6mCjarOCKnqowotb0SOy475BCzij6gO75N8k8HGUAWiEbijngKe0xn
 A78K4L+0gmTc+9IRp8tQobbfcJCjnJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625559010;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SowY9kRlKQd/sAYBU0dK4HTbkVdfxpdCzxqbS1MkAwY=;
 b=ob6wKFxtyQIjueT6O9BghwHxtSCfv+6GKzuz6JzoHQCZM3tdo7AALgSFT5xU+Y61FmZiui
 2wjhgoQYOUr5FhAw==
Received: from localhost (unknown [10.163.25.122])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 49E45A3B97;
 Tue,  6 Jul 2021 08:10:10 +0000 (UTC)
Date: Tue, 6 Jul 2021 10:10:10 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
Message-ID: <20210706081010.dqmg7bxik5gnym5k@beryllium.lan>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-3-dwagner@suse.de> <YNp50pmlzN6M0kNX@T590>
 <20210705162519.qqlklisxcsiopflw@beryllium.lan>
 <YOQGRwLfLaFGqlVA@T590>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ioub6u6kkzlqh46f"
Content-Disposition: inline
In-Reply-To: <YOQGRwLfLaFGqlVA@T590>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210706_011012_189245_F3FA9208 
X-CRM114-Status: GOOD (  14.38  )
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


--ioub6u6kkzlqh46f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 06, 2021 at 03:29:11PM +0800, Ming Lei wrote:
> > and this seems to confirm, no I/O in flight.
> 
> What is the output of the following command after the hang is triggered?
> 
> (cd /sys/kernel/debug/block/nvme0n1 && find . -type f -exec grep -aH . {} \;)
> 
> Suppose the hang disk is nvme0n1.

see attachement

> No, percpu_ref_is_zero() is fine to be called in atomic mode.

Okay, that is what I hoped for :)

--ioub6u6kkzlqh46f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="blk-debug.txt"

/sys/kernel/debug/block/nvme0c0n1# find . -type f -exec grep -aH . {} \;
./rqos/wbt/wb_background:4
./rqos/wbt/wb_normal:8
./rqos/wbt/unknown_cnt:0
./rqos/wbt/min_lat_nsec:2000000
./rqos/wbt/inflight:0: inflight 0
./rqos/wbt/inflight:1: inflight 0
./rqos/wbt/inflight:2: inflight 0
./rqos/wbt/id:0
./rqos/wbt/enabled:1
./rqos/wbt/curr_win_nsec:0
./hctx0/cpu39/completed:0 0
./hctx0/cpu39/merged:0
./hctx0/cpu39/dispatched:0 0
./hctx0/cpu38/completed:0 0
./hctx0/cpu38/merged:0
./hctx0/cpu38/dispatched:0 0
./hctx0/cpu37/completed:0 0
./hctx0/cpu37/merged:0
./hctx0/cpu37/dispatched:0 0
./hctx0/cpu36/completed:0 0
./hctx0/cpu36/merged:0
./hctx0/cpu36/dispatched:0 0
./hctx0/cpu35/completed:0 0
./hctx0/cpu35/merged:0
./hctx0/cpu35/dispatched:0 0
./hctx0/cpu34/completed:0 0
./hctx0/cpu34/merged:0
./hctx0/cpu34/dispatched:0 0
./hctx0/cpu33/completed:0 0
./hctx0/cpu33/merged:0
./hctx0/cpu33/dispatched:0 0
./hctx0/cpu32/completed:0 0
./hctx0/cpu32/merged:0
./hctx0/cpu32/dispatched:0 0
./hctx0/cpu31/completed:0 0
./hctx0/cpu31/merged:0
./hctx0/cpu31/dispatched:0 0
./hctx0/cpu30/completed:0 0
./hctx0/cpu30/merged:0
./hctx0/cpu30/dispatched:0 0
./hctx0/cpu29/completed:0 0
./hctx0/cpu29/merged:0
./hctx0/cpu29/dispatched:0 0
./hctx0/cpu28/completed:0 0
./hctx0/cpu28/merged:0
./hctx0/cpu28/dispatched:0 0
./hctx0/cpu27/completed:0 0
./hctx0/cpu27/merged:0
./hctx0/cpu27/dispatched:0 0
./hctx0/cpu26/completed:0 0
./hctx0/cpu26/merged:0
./hctx0/cpu26/dispatched:0 0
./hctx0/cpu25/completed:0 0
./hctx0/cpu25/merged:0
./hctx0/cpu25/dispatched:0 0
./hctx0/cpu24/completed:0 0
./hctx0/cpu24/merged:0
./hctx0/cpu24/dispatched:0 0
./hctx0/cpu23/completed:0 0
./hctx0/cpu23/merged:0
./hctx0/cpu23/dispatched:0 0
./hctx0/cpu22/completed:0 0
./hctx0/cpu22/merged:0
./hctx0/cpu22/dispatched:0 0
./hctx0/cpu21/completed:0 0
./hctx0/cpu21/merged:0
./hctx0/cpu21/dispatched:0 0
./hctx0/cpu20/completed:0 0
./hctx0/cpu20/merged:0
./hctx0/cpu20/dispatched:0 0
./hctx0/cpu19/completed:0 0
./hctx0/cpu19/merged:0
./hctx0/cpu19/dispatched:0 0
./hctx0/cpu18/completed:0 0
./hctx0/cpu18/merged:0
./hctx0/cpu18/dispatched:0 0
./hctx0/cpu17/completed:0 0
./hctx0/cpu17/merged:0
./hctx0/cpu17/dispatched:0 0
./hctx0/cpu16/completed:0 0
./hctx0/cpu16/merged:0
./hctx0/cpu16/dispatched:0 0
./hctx0/cpu15/completed:0 0
./hctx0/cpu15/merged:0
./hctx0/cpu15/dispatched:0 0
./hctx0/cpu14/completed:0 0
./hctx0/cpu14/merged:0
./hctx0/cpu14/dispatched:0 0
./hctx0/cpu13/completed:0 0
./hctx0/cpu13/merged:0
./hctx0/cpu13/dispatched:0 0
./hctx0/cpu12/completed:0 0
./hctx0/cpu12/merged:0
./hctx0/cpu12/dispatched:0 0
./hctx0/cpu11/completed:0 0
./hctx0/cpu11/merged:0
./hctx0/cpu11/dispatched:0 0
./hctx0/cpu10/completed:0 0
./hctx0/cpu10/merged:0
./hctx0/cpu10/dispatched:0 0
./hctx0/cpu9/completed:0 0
./hctx0/cpu9/merged:0
./hctx0/cpu9/dispatched:0 0
./hctx0/cpu8/completed:0 0
./hctx0/cpu8/merged:0
./hctx0/cpu8/dispatched:0 0
./hctx0/cpu7/completed:0 0
./hctx0/cpu7/merged:0
./hctx0/cpu7/dispatched:0 0
./hctx0/cpu6/completed:0 0
./hctx0/cpu6/merged:0
./hctx0/cpu6/dispatched:0 0
./hctx0/cpu5/completed:0 0
./hctx0/cpu5/merged:0
./hctx0/cpu5/dispatched:0 0
./hctx0/cpu4/completed:0 0
./hctx0/cpu4/merged:0
./hctx0/cpu4/dispatched:0 0
./hctx0/cpu3/completed:0 0
./hctx0/cpu3/merged:0
./hctx0/cpu3/dispatched:0 0
./hctx0/cpu2/completed:0 0
./hctx0/cpu2/merged:0
./hctx0/cpu2/dispatched:0 0
./hctx0/cpu1/completed:0 0
./hctx0/cpu1/merged:0
./hctx0/cpu1/dispatched:0 0
./hctx0/cpu0/completed:0 0
./hctx0/cpu0/merged:0
./hctx0/cpu0/dispatched:0 0
./hctx0/type:default
./hctx0/dispatch_busy:0
./hctx0/active:0
./hctx0/run:0
./hctx0/queued:0
./hctx0/dispatched:       0     0
./hctx0/dispatched:       1     0
./hctx0/dispatched:       2     0
./hctx0/dispatched:       4     0
./hctx0/dispatched:       8     0
./hctx0/dispatched:      16     0
./hctx0/dispatched:      32+    0
./hctx0/io_poll:considered=0
./hctx0/io_poll:invoked=0
./hctx0/io_poll:success=0
./hctx0/sched_tags_bitmap:00000000: 0000 0000 0000 0000
./hctx0/sched_tags:nr_tags=64
./hctx0/sched_tags:nr_reserved_tags=1
./hctx0/sched_tags:active_queues=0
./hctx0/sched_tags:bitmap_tags:
./hctx0/sched_tags:depth=63
./hctx0/sched_tags:busy=0
./hctx0/sched_tags:cleared=0
./hctx0/sched_tags:bits_per_word=8
./hctx0/sched_tags:map_nr=8
./hctx0/sched_tags:alloc_hint={28, 37, 21, 45, 61, 51, 42, 10, 43, 53, 40, 31, 17, 8, 28, 43, 47, 61, 51, 48, 53, 62, 15, 21, 52, 1, 2, 41, 50, 14, 24, 4, 58}
./hctx0/sched_tags:wake_batch=7
./hctx0/sched_tags:wake_index=0
./hctx0/sched_tags:ws_active=0
./hctx0/sched_tags:ws={
./hctx0/sched_tags:     {.wait_cnt=7, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=7, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=7, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=7, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=7, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=7, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=7, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=7, .wait=inactive},
./hctx0/sched_tags:}
./hctx0/sched_tags:round_robin=0
./hctx0/sched_tags:min_shallow_depth=4294967295
./hctx0/sched_tags:breserved_tags:
./hctx0/sched_tags:depth=1
./hctx0/sched_tags:busy=0
./hctx0/sched_tags:cleared=0
./hctx0/sched_tags:bits_per_word=64
./hctx0/sched_tags:map_nr=1
./hctx0/sched_tags:alloc_hint={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
./hctx0/sched_tags:wake_batch=1
./hctx0/sched_tags:wake_index=0
./hctx0/sched_tags:ws_active=0
./hctx0/sched_tags:ws={
./hctx0/sched_tags:     {.wait_cnt=1, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=1, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=1, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=1, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=1, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=1, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=1, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=1, .wait=inactive},
./hctx0/sched_tags:}
./hctx0/sched_tags:round_robin=0
./hctx0/sched_tags:min_shallow_depth=4294967295
./hctx0/tags_bitmap:00000000: 0000 0000
./hctx0/tags:nr_tags=32
./hctx0/tags:nr_reserved_tags=1
./hctx0/tags:active_queues=0
./hctx0/tags:bitmap_tags:
./hctx0/tags:depth=31
./hctx0/tags:busy=0
./hctx0/tags:cleared=0
./hctx0/tags:bits_per_word=4
./hctx0/tags:map_nr=8
./hctx0/tags:alloc_hint={12, 9, 9, 18, 27, 3, 7, 0, 28, 6, 28, 12, 21, 19, 1, 23, 27, 24, 6, 17, 15, 1, 10, 19, 27, 2, 24, 26, 30, 2, 26, 20, 18, 22, 19, 3, }
./hctx0/tags:wake_batch=3
./hctx0/tags:wake_index=0
./hctx0/tags:ws_active=0
./hctx0/tags:ws={
./hctx0/tags:   {.wait_cnt=3, .wait=inactive},
./hctx0/tags:   {.wait_cnt=3, .wait=inactive},
./hctx0/tags:   {.wait_cnt=3, .wait=inactive},
./hctx0/tags:   {.wait_cnt=3, .wait=inactive},
./hctx0/tags:   {.wait_cnt=3, .wait=inactive},
./hctx0/tags:   {.wait_cnt=3, .wait=inactive},
./hctx0/tags:   {.wait_cnt=3, .wait=inactive},
./hctx0/tags:   {.wait_cnt=3, .wait=inactive},
./hctx0/tags:}
./hctx0/tags:round_robin=0
./hctx0/tags:min_shallow_depth=4294967295
./hctx0/tags:breserved_tags:
./hctx0/tags:depth=1
./hctx0/tags:busy=0
./hctx0/tags:cleared=1
./hctx0/tags:bits_per_word=64
./hctx0/tags:map_nr=1
./hctx0/tags:alloc_hint={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
./hctx0/tags:wake_batch=1
./hctx0/tags:wake_index=0
./hctx0/tags:ws_active=0
./hctx0/tags:ws={
./hctx0/tags:   {.wait_cnt=1, .wait=inactive},
./hctx0/tags:   {.wait_cnt=1, .wait=inactive},
./hctx0/tags:   {.wait_cnt=1, .wait=inactive},
./hctx0/tags:   {.wait_cnt=1, .wait=inactive},
./hctx0/tags:   {.wait_cnt=1, .wait=inactive},
./hctx0/tags:   {.wait_cnt=1, .wait=inactive},
./hctx0/tags:   {.wait_cnt=1, .wait=inactive},
./hctx0/tags:   {.wait_cnt=1, .wait=inactive},
./hctx0/tags:}
./hctx0/tags:round_robin=0
./hctx0/tags:min_shallow_depth=4294967295
./hctx0/ctx_map:00000000: 0000 0000 00
./hctx0/flags:alloc_policy=FIFO SHOULD_MERGE|TAG_QUEUE_SHARED|4
./sched/starved:0
./sched/batching:0
./write_hints:hint0: 0
./write_hints:hint1: 0
./write_hints:hint2: 0
./write_hints:hint3: 0
./write_hints:hint4: 0
./state:SAME_COMP|NONROT|IO_STAT|INIT_DONE|STATS|REGISTERED|NOWAIT
./pm_only:0
./poll_stat:read  (512 Bytes): samples=0
./poll_stat:write (512 Bytes): samples=0
./poll_stat:read  (1024 Bytes): samples=0
./poll_stat:write (1024 Bytes): samples=0
./poll_stat:read  (2048 Bytes): samples=0
./poll_stat:write (2048 Bytes): samples=0
./poll_stat:read  (4096 Bytes): samples=0
./poll_stat:write (4096 Bytes): samples=0
./poll_stat:read  (8192 Bytes): samples=0
./poll_stat:write (8192 Bytes): samples=0
./poll_stat:read  (16384 Bytes): samples=0
./poll_stat:write (16384 Bytes): samples=0
./poll_stat:read  (32768 Bytes): samples=0
./poll_stat:write (32768 Bytes): samples=0
./poll_stat:read  (65536 Bytes): samples=0
./poll_stat:write (65536 Bytes): samples=0


/sys/kernel/debug/block/nvme0c0n2# find . -type f -exec grep -aH . {} \;
./rqos/wbt/wb_background:4
./rqos/wbt/wb_normal:8
./rqos/wbt/unknown_cnt:0
./rqos/wbt/min_lat_nsec:2000000
./rqos/wbt/inflight:0: inflight 0
./rqos/wbt/inflight:1: inflight 0
./rqos/wbt/inflight:2: inflight 0
./rqos/wbt/id:0
./rqos/wbt/enabled:1
./rqos/wbt/curr_win_nsec:0
./hctx0/cpu39/completed:0 0
./hctx0/cpu39/merged:0
./hctx0/cpu39/dispatched:0 0
./hctx0/cpu38/completed:0 0
./hctx0/cpu38/merged:0
./hctx0/cpu38/dispatched:0 0
./hctx0/cpu37/completed:0 0
./hctx0/cpu37/merged:0
./hctx0/cpu37/dispatched:0 0
./hctx0/cpu36/completed:0 0
./hctx0/cpu36/merged:0
./hctx0/cpu36/dispatched:0 0
./hctx0/cpu35/completed:0 0
./hctx0/cpu35/merged:0
./hctx0/cpu35/dispatched:0 0
./hctx0/cpu34/completed:0 0
./hctx0/cpu34/merged:0
./hctx0/cpu34/dispatched:0 0
./hctx0/cpu33/completed:0 0
./hctx0/cpu33/merged:0
./hctx0/cpu33/dispatched:0 0
./hctx0/cpu32/completed:0 0
./hctx0/cpu32/merged:0
./hctx0/cpu32/dispatched:0 0
./hctx0/cpu31/completed:0 0
./hctx0/cpu31/merged:0
./hctx0/cpu31/dispatched:0 0
./hctx0/cpu30/completed:0 0
./hctx0/cpu30/merged:0
./hctx0/cpu30/dispatched:0 0
./hctx0/cpu29/completed:0 0
./hctx0/cpu29/merged:0
./hctx0/cpu29/dispatched:0 0
./hctx0/cpu28/completed:0 0
./hctx0/cpu28/merged:0
./hctx0/cpu28/dispatched:0 0
./hctx0/cpu27/completed:0 0
./hctx0/cpu27/merged:0
./hctx0/cpu27/dispatched:0 0
./hctx0/cpu26/completed:0 0
./hctx0/cpu26/merged:0
./hctx0/cpu26/dispatched:0 0
./hctx0/cpu25/completed:0 0
./hctx0/cpu25/merged:0
./hctx0/cpu25/dispatched:0 0
./hctx0/cpu24/completed:0 0
./hctx0/cpu24/merged:0
./hctx0/cpu24/dispatched:0 0
./hctx0/cpu23/completed:0 0
./hctx0/cpu23/merged:0
./hctx0/cpu23/dispatched:0 0
./hctx0/cpu22/completed:0 0
./hctx0/cpu22/merged:0
./hctx0/cpu22/dispatched:0 0
./hctx0/cpu21/completed:0 0
./hctx0/cpu21/merged:0
./hctx0/cpu21/dispatched:0 0
./hctx0/cpu20/completed:0 0
./hctx0/cpu20/merged:0
./hctx0/cpu20/dispatched:0 0
./hctx0/cpu19/completed:0 0
./hctx0/cpu19/merged:0
./hctx0/cpu19/dispatched:0 0
./hctx0/cpu18/completed:0 0
./hctx0/cpu18/merged:0
./hctx0/cpu18/dispatched:0 0
./hctx0/cpu17/completed:0 0
./hctx0/cpu17/merged:0
./hctx0/cpu17/dispatched:0 0
./hctx0/cpu16/completed:0 0
./hctx0/cpu16/merged:0
./hctx0/cpu16/dispatched:0 0
./hctx0/cpu15/completed:0 0
./hctx0/cpu15/merged:0
./hctx0/cpu15/dispatched:0 0
./hctx0/cpu14/completed:0 0
./hctx0/cpu14/merged:0
./hctx0/cpu14/dispatched:0 0
./hctx0/cpu13/completed:0 0
./hctx0/cpu13/merged:0
./hctx0/cpu13/dispatched:0 0
./hctx0/cpu12/completed:0 0
./hctx0/cpu12/merged:0
./hctx0/cpu12/dispatched:0 0
./hctx0/cpu11/completed:0 0
./hctx0/cpu11/merged:0
./hctx0/cpu11/dispatched:0 0
./hctx0/cpu10/completed:0 0
./hctx0/cpu10/merged:0
./hctx0/cpu10/dispatched:0 0
./hctx0/cpu9/completed:0 0
./hctx0/cpu9/merged:0
./hctx0/cpu9/dispatched:0 0
./hctx0/cpu8/completed:0 0
./hctx0/cpu8/merged:0
./hctx0/cpu8/dispatched:0 0
./hctx0/cpu7/completed:0 0
./hctx0/cpu7/merged:0
./hctx0/cpu7/dispatched:0 0
./hctx0/cpu6/completed:0 0
./hctx0/cpu6/merged:0
./hctx0/cpu6/dispatched:0 0
./hctx0/cpu5/completed:0 0
./hctx0/cpu5/merged:0
./hctx0/cpu5/dispatched:0 0
./hctx0/cpu4/completed:0 0
./hctx0/cpu4/merged:0
./hctx0/cpu4/dispatched:0 0
./hctx0/cpu3/completed:0 0
./hctx0/cpu3/merged:0
./hctx0/cpu3/dispatched:0 0
./hctx0/cpu2/completed:0 0
./hctx0/cpu2/merged:0
./hctx0/cpu2/dispatched:0 0
./hctx0/cpu1/completed:0 0
./hctx0/cpu1/merged:0
./hctx0/cpu1/dispatched:0 0
./hctx0/cpu0/completed:0 0
./hctx0/cpu0/merged:0
./hctx0/cpu0/dispatched:0 0
./hctx0/type:default
./hctx0/dispatch_busy:0
./hctx0/active:0
./hctx0/run:0
./hctx0/queued:0
./hctx0/dispatched:       0     0
./hctx0/dispatched:       1     0
./hctx0/dispatched:       2     0
./hctx0/dispatched:       4     0
./hctx0/dispatched:       8     0
./hctx0/dispatched:      16     0
./hctx0/dispatched:      32+    0
./hctx0/io_poll:considered=0
./hctx0/io_poll:invoked=0
./hctx0/io_poll:success=0
./hctx0/sched_tags_bitmap:00000000: 0000 0000 0000 0000
./hctx0/sched_tags:nr_tags=64
./hctx0/sched_tags:nr_reserved_tags=1
./hctx0/sched_tags:active_queues=0
./hctx0/sched_tags:bitmap_tags:
./hctx0/sched_tags:depth=63
./hctx0/sched_tags:busy=0
./hctx0/sched_tags:cleared=0
./hctx0/sched_tags:bits_per_word=8
./hctx0/sched_tags:map_nr=8
./hctx0/sched_tags:alloc_hint={7, 2, 30, 8, 28, 25, 10, 60, 21, 58, 59, 43, 12, 22, 1, 0, 37, 7, 8, 28, 10, 53, 6, 28, 16, 47, 11, 29, 28, 12, 21, 59, 37, 25}
./hctx0/sched_tags:wake_batch=7
./hctx0/sched_tags:wake_index=0
./hctx0/sched_tags:ws_active=0
./hctx0/sched_tags:ws={
./hctx0/sched_tags:     {.wait_cnt=7, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=7, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=7, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=7, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=7, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=7, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=7, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=7, .wait=inactive},
./hctx0/sched_tags:}
./hctx0/sched_tags:round_robin=0
./hctx0/sched_tags:min_shallow_depth=4294967295
./hctx0/sched_tags:breserved_tags:
./hctx0/sched_tags:depth=1
./hctx0/sched_tags:busy=0
./hctx0/sched_tags:cleared=0
./hctx0/sched_tags:bits_per_word=64
./hctx0/sched_tags:map_nr=1
./hctx0/sched_tags:alloc_hint={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
./hctx0/sched_tags:wake_batch=1
./hctx0/sched_tags:wake_index=0
./hctx0/sched_tags:ws_active=0
./hctx0/sched_tags:ws={
./hctx0/sched_tags:     {.wait_cnt=1, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=1, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=1, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=1, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=1, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=1, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=1, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=1, .wait=inactive},
./hctx0/sched_tags:}
./hctx0/sched_tags:round_robin=0
./hctx0/sched_tags:min_shallow_depth=4294967295
./hctx0/tags_bitmap:00000000: 0000 0000
./hctx0/tags:nr_tags=32
./hctx0/tags:nr_reserved_tags=1
./hctx0/tags:active_queues=0
./hctx0/tags:bitmap_tags:
./hctx0/tags:depth=31
./hctx0/tags:busy=0
./hctx0/tags:cleared=0
./hctx0/tags:bits_per_word=4
./hctx0/tags:map_nr=8
./hctx0/tags:alloc_hint={12, 9, 9, 18, 27, 3, 7, 0, 28, 6, 28, 12, 21, 19, 1, 23, 27, 24, 6, 17, 15, 1, 10, 19, 27, 2, 24, 26, 30, 2, 26, 20, 18, 22, 19, 3, }
./hctx0/tags:wake_batch=3
./hctx0/tags:wake_index=0
./hctx0/tags:ws_active=0
./hctx0/tags:ws={
./hctx0/tags:   {.wait_cnt=3, .wait=inactive},
./hctx0/tags:   {.wait_cnt=3, .wait=inactive},
./hctx0/tags:   {.wait_cnt=3, .wait=inactive},
./hctx0/tags:   {.wait_cnt=3, .wait=inactive},
./hctx0/tags:   {.wait_cnt=3, .wait=inactive},
./hctx0/tags:   {.wait_cnt=3, .wait=inactive},
./hctx0/tags:   {.wait_cnt=3, .wait=inactive},
./hctx0/tags:   {.wait_cnt=3, .wait=inactive},
./hctx0/tags:}
./hctx0/tags:round_robin=0
./hctx0/tags:min_shallow_depth=4294967295
./hctx0/tags:breserved_tags:
./hctx0/tags:depth=1
./hctx0/tags:busy=0
./hctx0/tags:cleared=1
./hctx0/tags:bits_per_word=64
./hctx0/tags:map_nr=1
./hctx0/tags:alloc_hint={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
./hctx0/tags:wake_batch=1
./hctx0/tags:wake_index=0
./hctx0/tags:ws_active=0
./hctx0/tags:ws={
./hctx0/tags:   {.wait_cnt=1, .wait=inactive},
./hctx0/tags:   {.wait_cnt=1, .wait=inactive},
./hctx0/tags:   {.wait_cnt=1, .wait=inactive},
./hctx0/tags:   {.wait_cnt=1, .wait=inactive},
./hctx0/tags:   {.wait_cnt=1, .wait=inactive},
./hctx0/tags:   {.wait_cnt=1, .wait=inactive},
./hctx0/tags:   {.wait_cnt=1, .wait=inactive},
./hctx0/tags:   {.wait_cnt=1, .wait=inactive},
./hctx0/tags:}
./hctx0/tags:round_robin=0
./hctx0/tags:min_shallow_depth=4294967295
./hctx0/ctx_map:00000000: 0000 0000 00
./hctx0/flags:alloc_policy=FIFO SHOULD_MERGE|TAG_QUEUE_SHARED|4
./sched/starved:0
./sched/batching:0
./write_hints:hint0: 0
./write_hints:hint1: 0
./write_hints:hint2: 0
./write_hints:hint3: 0
./write_hints:hint4: 0
./state:SAME_COMP|NONROT|IO_STAT|INIT_DONE|STATS|REGISTERED|NOWAIT
./pm_only:0
./poll_stat:read  (512 Bytes): samples=0
./poll_stat:write (512 Bytes): samples=0
./poll_stat:read  (1024 Bytes): samples=0
./poll_stat:write (1024 Bytes): samples=0
./poll_stat:read  (2048 Bytes): samples=0
./poll_stat:write (2048 Bytes): samples=0
./poll_stat:read  (4096 Bytes): samples=0
./poll_stat:write (4096 Bytes): samples=0
./poll_stat:read  (8192 Bytes): samples=0
./poll_stat:write (8192 Bytes): samples=0
./poll_stat:read  (16384 Bytes): samples=0
./poll_stat:write (16384 Bytes): samples=0
./poll_stat:read  (32768 Bytes): samples=0
./poll_stat:write (32768 Bytes): samples=0
./poll_stat:read  (65536 Bytes): samples=0
./poll_stat:write (65536 Bytes): samples=0


--ioub6u6kkzlqh46f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--ioub6u6kkzlqh46f--

