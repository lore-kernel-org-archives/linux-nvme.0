Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FD1EB64DD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 07:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rjg+hl9YspXXm0IG+7csRqCTK6A/U1FFIIEGhuO5jxU=; b=kF95TbeuNE75mRaNnjY7iJQNgy
	yBDcAfak/SCGsCMMGiUn1psJbaifE5eLS9TXA6e2P9C7lRr+E1xemPIfts8IzZVzh4gdxiqfTJDr4
	JoyewKF32Erts3w2jns4Af1nrvGzvXdbZaNC8oENhOxdIhWdKeDgahlkp6UE47GMd7WDK8X/73b1t
	VMd+nfFMmZanY55wpXUDiuywwfDINEDyWdWGKKzXW85gIOxaDfp576xsF4xL+Jd6hy0gvOdMe72V0
	b+Bp4wTVyr5TyUYZlGv2L4we91NtKzzCt3k2hp3fKDcA6LNdjU65oCzCsjvOhVIq+BoBcmWIR/YL9
	6EWs76+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTe0s-004J9A-1L;
	Wed, 09 Aug 2023 07:53:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTe0q-004J8Z-25
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 07:53:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691567627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rjg+hl9YspXXm0IG+7csRqCTK6A/U1FFIIEGhuO5jxU=;
	b=dtvulmyIyyWuXdpEmvJzSsr3/9by2eyT+HPdwXFX3yKpB6I5RNAfgr62oDs4aJWMDBzFEr
	JFxVOp2gmskFIbdS+sEVJw9XMrE3OboQYzLFyi5DLXVQT+T2IPH1pz8lco6cwBu85/cT20
	9v27QSKcOqOH7KwDD5cjpxIVZxLser0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-aGAmfeL0OverE2Yzcbrx7A-1; Wed, 09 Aug 2023 03:53:46 -0400
X-MC-Unique: aGAmfeL0OverE2Yzcbrx7A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9852C801CF3;
	Wed,  9 Aug 2023 07:53:45 +0000 (UTC)
Received: from fedora (unknown [10.72.120.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FA50492B0F;
	Wed,  9 Aug 2023 07:53:40 +0000 (UTC)
Date: Wed, 9 Aug 2023 15:53:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Guangwu Zhang <guazhang@redhat.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] nvme: core: don't hold rcu read lock in
 nvme_ns_chr_uring_cmd_iopoll
Message-ID: <ZNNF/2NEPYCeiXlM@fedora>
References: <CGME20230809020844epcas5p30e520491fa59ab8c20836d4275931e8f@epcas5p3.samsung.com>
 <20230809020440.174682-1-ming.lei@redhat.com>
 <20230809065920.GA19415@green245>
MIME-Version: 1.0
In-Reply-To: <20230809065920.GA19415@green245>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_005348_752429_3CCBC5A2 
X-CRM114-Status: GOOD (  16.86  )
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

On Wed, Aug 09, 2023 at 12:29:20PM +0530, Kanchan Joshi wrote:
> On Wed, Aug 09, 2023 at 10:04:40AM +0800, Ming Lei wrote:
> > Now nvme_ns_chr_uring_cmd_iopoll() has switched to request based io
> > polling, and the associated NS is guaranteed to be live in case of
> > io polling, so request is guaranteed to be valid because blk-mq uses
> > pre-allocated request pool.
> > 
> > Remove the rcu read lock in nvme_ns_chr_uring_cmd_iopoll(), which
> > isn't needed any more after switching to request based io polling.
> 
> > Fix "BUG: sleeping function called from invalid context" because
> > set_page_dirty_lock() from blk_rq_unmap_user() may sleep.
> > 
> > Fixes: 585079b6e425 ("nvme: wire up async polling for io passthrough commands")
> > Reported-by: Guangwu Zhang <guazhang@redhat.com>
> 
> Thanks Ming. Looks fine, but any link to this report?
> I don't see this breaking in my tests. So I wonder how to reproduce and
> improve the coverage.

It is reported in RH BZ2227639, and follows the stack trace:

[ 3286.960425] BUG: sleeping function called from invalid context at include/linux/pagemap.h:914
[ 3286.960434] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 530910, name: fio
[ 3286.960440] preempt_count: 1, expected: 0
[ 3286.960443] RCU nest depth: 1, expected: 0
[ 3286.960446] 3 locks held by fio/530910:
[ 3286.960450]  #0: ffff8881108e40b0 (&ctx->uring_lock){+.+.}-{3:3}, at: __do_sys_io_uring_enter+0x535/0x980
[ 3286.960476]  #1: ffffffff9b72a320 (rcu_read_lock){....}-{1:2}, at: nvme_ns_chr_uring_cmd_iopoll+0x5/0x270 [nvme_core]
[ 3286.960530]  #2: ffff88837937b098 (&nvmeq->cq_poll_lock){+.+.}-{2:2}, at: nvme_poll+0x129/0x180 [nvme]
[ 3286.960553] Preemption disabled at:
[ 3286.960555] [<0000000000000000>] 0x0
[ 3286.960691] CPU: 1 PID: 530910 Comm: fio Kdump: loaded Tainted: G        W    L X  -------  ---  5.14.0-345.el9.x86_64+debug #1
[ 3286.960700] Hardware name: Dell Inc. PowerEdge R640/06DKY5, BIOS 2.15.1 06/15/2022
[ 3286.960704] Call Trace:
[ 3286.960707]  <TASK>
[ 3286.960720]  dump_stack_lvl+0x57/0x81
[ 3286.960734]  __might_resched.cold+0x222/0x26b
[ 3286.960756]  set_page_dirty_lock+0x1d/0x130
[ 3286.960773]  __bio_release_pages+0x266/0x470
[ 3286.960811]  blk_rq_unmap_user+0x2a8/0x660
[ 3286.960824]  ? lock_acquire+0x1d8/0x640
[ 3286.960839]  ? sched_clock_cpu+0x15/0x1b0
[ 3286.960850]  ? find_held_lock+0x33/0x120
[ 3286.960870]  ? __pfx_blk_rq_unmap_user+0x10/0x10
[ 3286.960876]  ? __lock_release+0x4c1/0xa00
[ 3286.960894]  ? __pfx___lock_release+0x10/0x10
[ 3286.960908]  ? mark_held_locks+0xa5/0xf0
[ 3286.960938]  nvme_uring_cmd_end_io+0x204/0x300 [nvme_core]
[ 3286.960974]  ? __pfx_nvme_uring_cmd_end_io+0x10/0x10 [nvme_core]
[ 3286.961020]  __blk_mq_end_request+0xf6/0x4c0
[ 3286.961042]  nvme_poll_cq+0x71e/0xe40 [nvme]
[ 3286.961102]  nvme_poll+0x134/0x180 [nvme]
[ 3286.961121]  blk_mq_poll_classic+0x179/0x420
[ 3286.961153]  bio_poll+0x1f5/0x440
[ 3286.961182]  nvme_ns_chr_uring_cmd_iopoll+0x16f/0x270 [nvme_core]

Thanks,
Ming


