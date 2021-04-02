Return-Path: <SRS0=ZbIm=I7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31889C433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 17:12:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C483C61152
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 17:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C483C61152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=B/t2Ic/2Ld2ewVMClr+4KHufpMfG74H3Ay+r0uywQOw=; b=j2EzdWDi84puNXXJLVBwcyCSS
	FHtKhonY97y+cj4un0mFIAlc+LHKq75WWSdIWvh59gMjm6P4Bh+nepfOnHrv3HqkhfikvZKPL410w
	TUxScfD5M8TRdf83xPS6UNScdNgTPcJpv4wxWxYGPV8sKQOA9G1X5oV/scs+Dc1JKg0tWsrbszLG1
	I9pPssBMQdTVtYL3tNNUDvcSCqfpDjTIW4LLnolfGyaPlZ/Lv+Bo8QrKF7z1fIiq/sNEnjd2ayFxO
	KIJzANMdsU2fURLul5S7BeSxYvtq8xN65Jc+jwqcxkdxuPyU7EjbWRh7x3B54Cg7h31aeax8bysls
	AFDwSNeQg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lSNKp-00DTbo-Us; Fri, 02 Apr 2021 17:11:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lSNKm-00DTb0-8E
 for linux-nvme@lists.infradead.org; Fri, 02 Apr 2021 17:11:50 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D5FF6113E;
 Fri,  2 Apr 2021 17:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617383503;
 bh=YbfjdNod2Afcii3cqRg253xvbv1FNXfdpEGGqPjjYzY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dbxR67HCN4joXiR7qPtB8PkG/2AwHWyTDF6lAvUuDfSL4Ojn5STxusKBT9K/GgW/E
 HIDvfNLkeJ7gvpWIGohHnvFMw2L19VoyYCoNVVevQJH2LTW0JIWhoJ2cdU3zfmRWT/
 9tBEhksRFFzsNJz87R0tcnAM+VCaweeUGeuf+N+AoNi+yogvFTydbl1dyAvqUVudt2
 dlpWIu49OdUdZaX7DuAEjgjqMtGtOyAi79LRkGipob9Vx40u7D64xEpHTmRKqpFzxb
 vtd7FOKLFWHqEGGAM1TWfmG2ClNQD7178YwaNB/YKxmeIOZRqnlm8dETcXonKqzhZo
 Xovbi0JgotW7A==
Date: Fri, 2 Apr 2021 10:11:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210402171141.GA1944994@dhcp-10-100-145-180.wdc.com>
References: <20210331161825.GC23886@redsun51.ssa.fujisawa.hgst.com>
 <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
 <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210402_181148_754467_62F5D7D0 
X-CRM114-Status: GOOD (  26.05  )
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

On Thu, Apr 01, 2021 at 05:49:58AM +0900, Keith Busch wrote:
> On Wed, Mar 31, 2021 at 12:10:55PM -0700, Sagi Grimberg wrote:
> > Hey Keith,
> > 
> > > While running a read-write mixed workload, we are observing errors like:
> > > 
> > >    nvme nvme4: queue 2 no space in request 0x1
> > 
> > This means that we get a data payload from a read request and
> > we don't have a bio/bvec space to store it, which means we
> > are probably not tracking the request iterator correctly if
> > tcpdump shows that we are getting the right data length.
> > 
> > > Based on tcpdump, all data for this queue is expected to satisfy the
> > > command request. I'm not familiar enough with the tcp interfaces, so
> > > could anyone provide pointers on how to debug this further?
> > 
> > What was the size of the I/O that you were using? Is this easily
> > reproducible?
> > 
> > Do you have the below applied:
> > ca1ff67d0fb1 ("nvme-tcp: fix possible data corruption with bio merges")
> > 0dc9edaf80ea ("nvme-tcp: pass multipage bvec to request iov_iter")
> > 
> > I'm assuming yes if you are using the latest nvme tree...
> > 
> > Does the issue still happens when you revert 0dc9edaf80ea?
> 
> Thanks for the reply.
> 
> This was observed on the recent 5.12-rc4, so it has all the latest tcp
> fixes. I'll check with reverting 0dc9edaf80ea and see if that makes a
> difference. It is currently reproducible, though it can take over an
> hour right now.

After reverting 0dc9edaf80ea, we are observing a kernel panic (below). We'll
try adding it back, plust adding your debug patch.

  BUG: kernel NULL pointer dereference, address: 000000000000002c
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0 
  Oops: 0000 [#1] SMP PTI
  CPU: 15 PID: 49319 Comm: fio Tainted: G           OE     5.12.0-051200rc4-generic #202103212230
  Hardware name: Supermicro SYS-5018R-WR/X10SRW-F, BIOS 2.0a 08/02/2016
  RIP: 0010:nvme_tcp_init_iter+0x55/0xf0 [nvme_tcp]
  Code: ff ff b9 01 00 00 00 45 31 e4 48 8d 7b 68 4c 89 da 44 89 d6 e8 ec e4 16 c8 4c 89 63 70 5b 41 5c 41 5d 41 5e 5d c3 48 8b 57 60 <8b> 42 2c 4c 8b 6a 78 44 8b 42 28 44 8b 62 30 49 89 c3 48 89 c7 49
  RSP: 0018:ffffaafccd0eb920 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: ffff9ad834bfcf28 RCX: 0000000000002000
  RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9ad834bfcf28
  RBP: ffffaafccd0eb940 R08: 0000000000002000 R09: 0000000000000000
  R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000002000
  R13: fffff67f07c1ce00 R14: ffff9ad78422c5f0 R15: ffff9ad834bfcf28
  FS:  00007f010087d740(0000) GS:ffff9adedfdc0000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000000000000002c CR3: 000000027b11e005 CR4: 00000000003706e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   nvme_tcp_try_send_data+0x282/0x2e0 [nvme_tcp]
   ? nvme_tcp_init_iter+0x44/0xf0 [nvme_tcp]
   nvme_tcp_try_send+0x12f/0x1b0 [nvme_tcp]
   ? blk_mq_start_request+0x3a/0x100
   nvme_tcp_queue_rq+0x159/0x180 [nvme_tcp]
   __blk_mq_try_issue_directly+0x116/0x1e0
   blk_mq_try_issue_list_directly+0x174/0x2b0
   blk_mq_sched_insert_requests+0xa5/0xf0
   blk_mq_flush_plug_list+0x106/0x1b0
   blk_flush_plug_list+0xdd/0x100
   blk_finish_plug+0x29/0x40
   __blkdev_direct_IO+0x2ef/0x480
   ? aio_fsync_work+0xf0/0xf0
   blkdev_direct_IO+0x56/0x80
   generic_file_read_iter+0x9c/0x140
   blkdev_read_iter+0x35/0x40
   aio_read+0xe0/0x1a0
   ? __cond_resched+0x35/0x50
   ? slab_pre_alloc_hook.constprop.0+0x96/0xe0
   __io_submit_one.constprop.0+0x107/0x1f0
   io_submit_one+0xe3/0x3a0
   __x64_sys_io_submit+0x84/0x180
   do_syscall_64+0x38/0x90
   entry_SYSCALL_64_after_hwframe+0x44/0xae

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
