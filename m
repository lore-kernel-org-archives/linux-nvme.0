Return-Path: <SRS0=afDi=DA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0015C2D0A8
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 09:02:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 449D420773
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 09:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kp5/Q5yN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449D420773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Date:To:From:Message-ID:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CT5lZc+siBG6QOIl27qyK8GdQ/B1Hx3p8FWOMge0uaQ=; b=kp5/Q5yNhAM+0wZfKrJz56Pb0l
	ejkKw4sQDd++AhDa4FduzIumryMBg38lUzWRdeMdoXPsbwIl8Mwep5pDv4y9DVk+1rDc8fxyZ21Nj
	3V9TgJdMrLqg1mPcuX61gPB2kuFquNlKTYdQOLTnZIhhWFf4s4c6Sxif009Df19lhcYNlZ0b51vbK
	yEZNzX4Xn+C8kUgYpH6NyDtPNLtT5nwDxL2fMK9SFLDI1SCU7RU5yEwW1qfMoyocF/lsWgbUwH8Q/
	3ZWZ6SbNEVUSv1v8DfWO3D/iA7zStG/i9gLmvIjWg9gzJHnCfKu+hKf0vbVwYvwn3W86m5qOyR86D
	SuDMzW0w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kL0fK-0003yM-Dc; Wed, 23 Sep 2020 09:02:18 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kL0fH-0003xo-Cy
 for linux-nvme@lists.infradead.org; Wed, 23 Sep 2020 09:02:16 +0000
Received: from [2a0a:edc0:0:900:6245:cbff:fea0:1793]
 (helo=kresse.office.stw.pengutronix.de)
 by metis.ext.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <l.stach@pengutronix.de>)
 id 1kL0f8-000367-U0; Wed, 23 Sep 2020 11:02:07 +0200
Message-ID: <adcb71d188a0bf97c32d6be86233e5f5f3caff75.camel@pengutronix.de>
From: Lucas Stach <l.stach@pengutronix.de>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 23 Sep 2020 11:02:05 +0200
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:6245:cbff:fea0:1793
X-SA-Exim-Mail-From: l.stach@pengutronix.de
Subject: lockdep splat when disconnecting NVMe oF TCP inititator
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200923_050215_468183_4D9321AC 
X-CRM114-Status: UNSURE (   9.08  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi nvme folks,

I've toyed a bit with NVMe oF TCP over the last few days and came
across the following lockdep splat on the target when disconnecting the
initiator. I don't know if I'll have time to look into this anytime
soon, so I figured I could at least leave the report here.

Regards,
Lucas

[  142.078964] WARNING: possible circular locking dependency detected
[  142.085172] 5.9.0-rc5 #2 Not tainted
[  142.091982] ------------------------------------------------------
[  142.098186] kworker/0:3/74 is trying to acquire lock:
[  142.103259] ffff000015228830 ((work_completion)(&queue->io_work)){+.+.}-{0:0}, at: __flush_work+0x54/0x510
[  142.112981] 
[  142.112981] but task is already holding lock:
[  142.118835] ffff800011efbdc0 ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at: process_one_work+0x1ec/0x710
[  142.129413] 
[  142.129413] which lock already depends on the new lock.
[  142.129413] 
[  142.137618] 
[  142.137618] the existing dependency chain (in reverse order) is:
[  142.145124] 
[  142.145124] -> #2 ((work_completion)(&queue->release_work)){+.+.}-{0:0}:
[  142.153352]        process_one_work+0x248/0x710
[  142.157906]        worker_thread+0x74/0x470
[  142.162119]        kthread+0x15c/0x160
[  142.165894]        ret_from_fork+0x10/0x38
[  142.170005] 
[  142.170005] -> #1 ((wq_completion)events){+.+.}-{0:0}:
[  142.176665]        flush_workqueue+0x98/0x400
[  142.181054]        nvmet_tcp_install_queue+0x11c/0x130
[  142.186217]        nvmet_install_queue+0xbc/0x150
[  142.190946]        nvmet_execute_admin_connect+0x11c/0x200
[  142.196458]        nvmet_tcp_io_work+0x8c0/0x950
[  142.201099]        process_one_work+0x294/0x710
[  142.205654]        worker_thread+0x74/0x470
[  142.209860]        kthread+0x15c/0x160
[  142.213630]        ret_from_fork+0x10/0x38
[  142.217742] 
[  142.217742] -> #0 ((work_completion)(&queue->io_work)){+.+.}-{0:0}:
[  142.225542]        __lock_acquire+0x13fc/0x2160
[  142.230097]        lock_acquire+0xec/0x4d0
[  142.234215]        __flush_work+0x7c/0x510
[  142.238333]        flush_work+0x14/0x20
[  142.242192]        nvmet_tcp_release_queue_work+0xb0/0x280
[  142.247703]        process_one_work+0x294/0x710
[  142.252257]        worker_thread+0x74/0x470
[  142.256465]        kthread+0x15c/0x160
[  142.260234]        ret_from_fork+0x10/0x38
[  142.264346] 
[  142.264346] other info that might help us debug this:
[  142.264346] 
[  142.272375] Chain exists of:
[  142.272375]   (work_completion)(&queue->io_work) --> (wq_completion)events --> (work_completion)(&queue->release_work)
[  142.272375] 
[  142.287476]  Possible unsafe locking scenario:
[  142.287476] 
[  142.293415]        CPU0                    CPU1
[  142.297962]        ----                    ----
[  142.302508]   lock((work_completion)(&queue->release_work));
[  142.308194]                                lock((wq_completion)events);
[  142.314836]                                lock((work_completion)(&queue->release_work));
[  142.323046]   lock((work_completion)(&queue->io_work));
[  142.328296] 
[  142.328296]  *** DEADLOCK ***
[  142.328296] 
[  142.334239] 2 locks held by kworker/0:3/74:
[  142.338438]  #0: ffff000017405738 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1ec/0x710
[  142.347887]  #1: ffff800011efbdc0 ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at: process_one_work+0x1ec/0x710
[  142.358901] 
[  142.358901] stack backtrace:
[  142.363284] CPU: 0 PID: 74 Comm: kworker/0:3 Not tainted 5.9.0-rc5 #2
[  142.372970] Hardware name: XXX (DT)
[  142.378053] Workqueue: events nvmet_tcp_release_queue_work
[  142.383563] Call trace:
[  142.386032]  dump_backtrace+0x0/0x1b0
[  142.389717]  show_stack+0x18/0x30
[  142.393055]  dump_stack+0xe8/0x15c
[  142.396480]  print_circular_bug+0x278/0x280
[  142.400688]  check_noncircular+0x164/0x1e0
[  142.404808]  __lock_acquire+0x13fc/0x2160
[  142.408841]  lock_acquire+0xec/0x4d0
[  142.412437]  __flush_work+0x7c/0x510
[  142.416032]  flush_work+0x14/0x20
[  142.419369]  nvmet_tcp_release_queue_work+0xb0/0x280
[  142.424358]  process_one_work+0x294/0x710
[  142.428390]  worker_thread+0x74/0x470
[  142.432075]  kthread+0x15c/0x160
[  142.435322]  ret_from_fork+0x10/0x38


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
