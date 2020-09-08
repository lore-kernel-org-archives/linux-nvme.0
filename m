Return-Path: <SRS0=ETB4=CR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969D1C43461
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 08:54:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD302166E
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 08:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jbIR9pBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD302166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zhg2J+JrM2Hc3wtCoy0FNS9Lm0YiLxHKvBWpDl54T3o=; b=jbIR9pBaCqhhdv55iqiQJNdZp
	qsLYw1h9y+6sMkNg39khiHZLaNmdIQ3W+1JzvhX1shgFSb0Ep7w7MVVo+2oEBcIMJSZ9YujvWzXw2
	p4skWGJK+u4Wxuum0pRK4Gcb23/eytK8IQcSR5LVt68KoZhD/z9DtDASkI2nhp3Gy8aOYYTsaUPBv
	o4697PoY8cdFarv5Ju+6zY4enzU16ne7sYtPEpIBe9SibRgYOQNCgxeQr93mw/oMC02vYRIRPtUrb
	tH+qik+s1MDt+IKhw6H9imBHWzBeuwfBuiclrgBDjwRK9DKUmZWdfWNhjfs4eKbzLlAiuN7kSXPUg
	S3vQbQ01w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFZOE-0002XA-8c; Tue, 08 Sep 2020 08:54:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFZOC-0002WP-37
 for linux-nvme@lists.infradead.org; Tue, 08 Sep 2020 08:54:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D196168AFE; Tue,  8 Sep 2020 10:54:05 +0200 (CEST)
Date: Tue, 8 Sep 2020 10:54:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 3/3] nvme-core: fix nvme module ref count Oops
Message-ID: <20200908085405.GC17413@lst.de>
References: <20200904023929.5320-1-chaitanya.kulkarni@wdc.com>
 <20200904023929.5320-4-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200904023929.5320-4-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_045408_259704_E8B47494 
X-CRM114-Status: GOOD (  19.27  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This looks odd.  The char_dev code should grab the reference to the
module in 

On Thu, Sep 03, 2020 at 07:39:29PM -0700, Chaitanya Kulkarni wrote:
> In the passthru controller enable path current code doesn't take the
> reference to the passthru ctrl module. Which produces following Oops :-
> 
> Entering kdb (current=0xffff8887f8290000, pid 3128) on processor 30 Oops: (null)
> due to oops @ 0xffffffffa01019ad
> CPU: 30 PID: 3128 Comm: bash Tainted: G        W  OE     5.8.0-rc4nvme-5.9+ #35
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.4
> RIP: 0010:nvme_free_ctrl+0x234/0x285 [nvme_core]
> Code: 57 10 a0 e8 73 bf 02 e1 ba 3d 11 00 00 48 c7 c6 98 33 10 a0 48 c7 c7 1d 57 10 a0 e8 5b bf 02 e1 8
> RSP: 0018:ffffc90001d63de0 EFLAGS: 00010246
> RAX: ffffffffa05c0440 RBX: ffff8888119e45a0 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff8888177e9550 RDI: ffff8888119e43b0
> RBP: ffff8887d4768000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: ffffc90001d63c90 R12: ffff8888119e43b0
> R13: ffff8888119e5108 R14: dead000000000100 R15: ffff8888119e5108
> FS:  00007f1ef27b0740(0000) GS:ffff888817600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffa05c0470 CR3: 00000007f6bee000 CR4: 00000000003406e0
> Call Trace:
>  device_release+0x27/0x80
>  kobject_put+0x98/0x170
>  nvmet_passthru_ctrl_disable+0x4a/0x70 [nvmet]
>  nvmet_passthru_enable_store+0x4c/0x90 [nvmet]
>  configfs_write_file+0xe6/0x150
>  vfs_write+0xba/0x1e0
>  ksys_write+0x5f/0xe0
>  do_syscall_64+0x52/0xb0
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f1ef1eb2840
> Code: Bad RIP value.
> RSP: 002b:00007fffdbff0eb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f1ef1eb2840
> RDX: 0000000000000002 RSI: 00007f1ef27d2000 RDI: 0000000000000001
> RBP: 00007f1ef27d2000 R08: 000000000000000a R09: 00007f1ef27b0740
> R10: 0000000000000001 R11: 0000000000000246 R12: 00007f1ef2186400
> R13: 0000000000000002 R14: 0000000000000001 R15: 0000000000000000
> 
> We fix that by taking a module ref count in nvme_dev_open() and release
> that ref count in nvme_dev_release() atomically with ctrl get/put
> respectively.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/host/core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a1707afcb710..8445293c74e3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3263,6 +3263,12 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
>  
>  	file->private_data = ctrl;
>  	nvme_get_ctrl(ctrl);
> +	if (!try_module_get(ctrl->ops->module)) {
> +		pr_err("try_module_get failed for cntlid 0x%x\n", ctrl->cntlid);

No need for a debug printk here..

Otherwise this looks good and should go to the front as it is a problem
even without the passthrough controller.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
