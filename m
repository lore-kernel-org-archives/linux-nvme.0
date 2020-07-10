Return-Path: <SRS0=f2/u=AV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B39CC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2020 14:57:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2EB20767
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2020 14:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EZI0jJBH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vC/fgaoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2EB20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tGXLiSW76S/2geUDQRdECVbT58rxXt1q7hhLCJ3Mgq8=; b=EZI0jJBHePm6xO63uXU1LizAM
	S+6BxM/NDqFmounIWAZ2ysR7cFEpsiR9qJCVPLvc/UYYrpNARTiGRMJoZFVKCUlQTvxUi8u8xRfo6
	nMjGBvDtlG9P6PjdqlEPeBX9B7eJ+83V76HU1/MTLzjCW+IGcj0SDWf8KkjUQf9yMbk92FWwu88WX
	dKyrCCKlTAFz1FxDJfjeN5QbK+1KhAxmndCQx8qwl/bUt1xoIJIvVhk44G7gkdk5xd9xFoPCzfm3W
	pAPHjQX2qQ9SCy/Qn7nCj53BNwBmOyHe/i+D3a2FLkZ1PS2sfwrk9j0pl04rEh0Rz9kmOdot+b8KP
	iouyycozQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtuTG-0005ft-Ev; Fri, 10 Jul 2020 14:57:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtuTC-0005fN-7N
 for linux-nvme@lists.infradead.org; Fri, 10 Jul 2020 14:57:47 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BA6F620767;
 Fri, 10 Jul 2020 14:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594393065;
 bh=FPetiydX/TWBllUX1wS/BF9HSjRKqjU1WjbYksIhO+U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vC/fgaoTqUPgMpp0DI7WgKW9Szvzd3xZyNikgppbP7ccP/82+UkN2xrZPTC7BLJV7
 +pk1OuVxGppdhobWiZP3XFcxdzR7aRTwRbYTRGY2vbOvpwpmmBr98Yr3ktbRoXS2OF
 HqmR/YdHeODGDXVvRdv20qR77Ansd0SVBFu6ecOo=
Date: Fri, 10 Jul 2020 07:57:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2 1/2] nvme-core: replace ctrl page size with a macro
Message-ID: <20200710145742.GA2424089@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200709234025.10673-1-chaitanya.kulkarni@wdc.com>
 <20200709234025.10673-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200709234025.10673-2-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200710_105746_370999_86A3B0AB 
X-CRM114-Status: GOOD (  16.62  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 09, 2020 at 04:40:24PM -0700, Chaitanya Kulkarni wrote:
> When nvme_pci_iod_alloc_size() is called with false as last argument it
> results in following oops since dev->ctrl.page_size used before we set
> it in the nvme_enable_ctrl() in above path :-
> 
> Entering kdb (current=0xffff88881fc0c980, pid 339) on processor 0 Oops: (null)
> due to oops @ 0xffffffffa05f1723
> CPU: 0 PID: 339 Comm: kworker/0:2 Tainted: G        W  OE     5.8.0-rc1nvme-5.9+ #20
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.4Workqueue: events work_for_cpu_fn
> RIP: 0010:nvme_probe+0x263/0x502 [nvme]
> Code: 00 00 66 41 81 7c 24 3c 4d 14 0f 84 98 01 00 00 3d 0f 1e 01 00 0f 84 aa 01 00 00 8b 8b a0 0c 00 2
> RSP: 0018:ffffc90000d9bdd8 EFLAGS: 00010246
> RAX: 0000000000000fff RBX: ffff8887da128000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000246
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: ffff8887c29f5570 R12: ffff888813c37000
> R13: 0000000000000202 R14: 0000000fffffffe0 R15: ffff888813c370b0
> FS:  0000000000000000(0000) GS:ffff88880fe00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f23185131a0 CR3: 0000000811c54000 CR4: 00000000003406f0
> Call Trace:
>  local_pci_probe+0x42/0x80
>  work_for_cpu_fn+0x16/0x20
>  process_one_work+0x24e/0x5a0
>  ? __schedule+0x353/0x840
>  worker_thread+0x1d5/0x380
>  ? process_one_work+0x5a0/0x5a0
>  kthread+0x135/0x150
>  ? kthread_create_on_node+0x60/0x60
>  ret_from_fork+0x22/0x30
> 
> This patch removes the dev->ctrl.page_size variable and replaces with
> the macro which avoids above oops

This makes it sound like we'd actually trigger this bug, but we
currently don't do that. I think the changelog should be more about why
we can remove of 'ctrl->page_size', something like:

  Saving the nvme controller's page size was from a time when the driver
  tried to use different sized pages, but this value is always set to
  a constant, and has been this way for some time. Remove the
  'page_size' field and replace its usage with the constant value.

This also lets the compiler make some micro-optimizations in the io
path, and that's always a good thing.


> @@ -1825,7 +1824,7 @@ static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
>  	c.features.fid		= cpu_to_le32(NVME_FEAT_HOST_MEM_BUF);
>  	c.features.dword11	= cpu_to_le32(bits);
>  	c.features.dword12	= cpu_to_le32(dev->host_mem_size >>
> -					      ilog2(dev->ctrl.page_size));
> +					      ilog2(NVME_CTRL_PAGE_SIZE));

You could replace the ilog2() with NVME_CTRL_PAGE_SHIFT. Both compile to
the same result, though.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
