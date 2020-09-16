Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3563C43461
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 16:03:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB6B72222C
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 16:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oc2yy5j9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6B72222C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DexttgoLGxjF+enlnfUmRO4aAwHJIGM06bwDm+vuyyE=; b=oc2yy5j9KjmtCFZWPYPv1DQzf
	FIq9H2kbEt9RZHP55t22KRdpGuVq3azq+u/RP2T99GW6yVN0YR44jyGrIYD1BzP4TTx2SfUkWu0wo
	S4e2qEqnkwV2lJHFhuwyeveOx/6nyjiM+Yqi09JPFRsupfW1j642djtm2fhue2A5pjaCVRGfpzbqs
	Dm8wA6VYDzw6YzYj2UfvW162WxqLHOeDz3CmPyW/AAiw7TpAbydJI7jFIgaWdHUS58TS10jmvNIsC
	zSe7+L4e5KERq9pbCyzCedehcaZQJvjwaduIf51pb1FtanIAQ8DuFocZJLqwABWFIYPnSusmiuudR
	AZFzuTm6w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIZtq-0006X4-1r; Wed, 16 Sep 2020 16:03:14 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIZsf-0005lo-1B
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 16:02:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3120B68BEB; Wed, 16 Sep 2020 18:01:56 +0200 (CEST)
Date: Wed, 16 Sep 2020 18:01:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH V2 1/2] nvme-core: fix nvme module ref count Oops
Message-ID: <20200916160155.GA12777@lst.de>
References: <20200916035326.9229-1-chaitanya.kulkarni@wdc.com>
 <20200916035326.9229-2-chaitanya.kulkarni@wdc.com>
 <73c9b0fe-ed1d-5cd5-137c-9c6ab9baa1f2@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <73c9b0fe-ed1d-5cd5-137c-9c6ab9baa1f2@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_120201_319489_72085AC6 
X-CRM114-Status: GOOD (  21.57  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 16, 2020 at 09:58:38AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2020-09-15 9:53 p.m., Chaitanya Kulkarni wrote:
> > Introduce car dev relase function, get/put the module refernece which
> > allows us to fix the potential Oops which can be easily reproduced with
> > NVMeOF passthru ctrl :-
> > 
> > Entering kdb (current=0xffff8887f8290000, pid 3128) on processor 30 Oops: (null)
> > due to oops @ 0xffffffffa01019ad
> > CPU: 30 PID: 3128 Comm: bash Tainted: G        W  OE     5.8.0-rc4nvme-5.9+ #35
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.4
> > RIP: 0010:nvme_free_ctrl+0x234/0x285 [nvme_core]
> > Code: 57 10 a0 e8 73 bf 02 e1 ba 3d 11 00 00 48 c7 c6 98 33 10 a0 48 c7 c7 1d 57 10 a0 e8 5b bf 02 e1 8
> > RSP: 0018:ffffc90001d63de0 EFLAGS: 00010246
> > RAX: ffffffffa05c0440 RBX: ffff8888119e45a0 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: ffff8888177e9550 RDI: ffff8888119e43b0
> > RBP: ffff8887d4768000 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: ffffc90001d63c90 R12: ffff8888119e43b0
> > R13: ffff8888119e5108 R14: dead000000000100 R15: ffff8888119e5108
> > FS:  00007f1ef27b0740(0000) GS:ffff888817600000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffffffffa05c0470 CR3: 00000007f6bee000 CR4: 00000000003406e0
> > Call Trace:
> >  device_release+0x27/0x80
> >  kobject_put+0x98/0x170
> >  nvmet_passthru_ctrl_disable+0x4a/0x70 [nvmet]
> >  nvmet_passthru_enable_store+0x4c/0x90 [nvmet]
> >  configfs_write_file+0xe6/0x150
> >  vfs_write+0xba/0x1e0
> >  ksys_write+0x5f/0xe0
> >  do_syscall_64+0x52/0xb0
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > RIP: 0033:0x7f1ef1eb2840
> > Code: Bad RIP value.
> > RSP: 002b:00007fffdbff0eb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f1ef1eb2840
> > RDX: 0000000000000002 RSI: 00007f1ef27d2000 RDI: 0000000000000001
> > RBP: 00007f1ef27d2000 R08: 000000000000000a R09: 00007f1ef27b0740
> > R10: 0000000000000001 R11: 0000000000000246 R12: 00007f1ef2186400
> > R13: 0000000000000002 R14: 0000000000000001 R15: 0000000000000000
> > 
> > With this patch fix we take the module ref count in nvme_dev_open() and
> > release that ref count in newly introduced nvme_dev_release().
> > 
> > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > ---
> >  drivers/nvme/host/core.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 8b75f6ca0b61..c5f9d64b2bec 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3261,10 +3261,22 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
> >  		return -EWOULDBLOCK;
> >  	}
> >  
> > +	if (!try_module_get(ctrl->ops->module))
> > +		return -EINVAL;
> 
> Aren't we also still missing the nvme_get_ctrl() here? We have a
> reference to the controller that's not counted; which was the original
> bug, and we need a reference to the module to be able to put that
> reference...

Yes, indeed.  Pulled from nvme-5.9 again..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
