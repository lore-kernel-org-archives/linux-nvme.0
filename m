Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477B2F588C3
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2026 12:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o1rc5PrNx8CIzFOxawfNeqJKdzdyFDVHZYRJ1O/T8xg=; b=3osbh4Z1zTWT9rCku8UT15hT8Z
	Vx3ECAHXeh6P/BBgO/2oAJdM4GlNRqv8afTIXn3fvr+frTtY/50sTZAGim3hCcgJqDLl8A8/dh6PR
	uZ7KB9q19teblVWOdjaveTTOu/9wBhaiEDfyI4Ejcy/NbPPRhHOxKgSIDxFX+2vdzb7IyaslM0vQ/
	Gc77GNoC04tdS/1NHiN3AA0gJsXsoDipca/tGK0ixEiCylsTQ8W8f4CThM0B+R/XYOJLzbA2xwwdd
	kNGMss9OmtrEAm+7g6+4wdXC4lip0RbLrZAb0nb8wnQswY0usyOrzjxIz08C08vzqcNifm+mFn6is
	dQyjWtJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEndy-00000006s74-31nQ;
	Mon, 20 Apr 2026 12:22:26 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEndu-00000006s5p-2dRB
	for linux-nvme@lists.infradead.org;
	Mon, 20 Apr 2026 12:22:25 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 217576e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 14:22:17 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Apr 2026 14:22:16 +0200
Message-Id: <DHXZ8MK1AASK.VWC6067TNS7Q@arkamax.eu>
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Chao Shi" <coshi036@gmail.com>, "Keith Busch" <kbusch@kernel.org>,
 "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi
 Grimberg" <sagi@grimberg.me>, "Daniel Wagner" <dwagner@suse.de>, "Hannes
 Reinecke" <hare@suse.de>, <linux-nvme@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Cc: "Sungwoo Kim" <iam@sung-woo.kim>, "Dave Tian" <daveti@purdue.edu>,
 "Weidong Zhu" <weizhu@fiu.edu>
Subject: Re: [PATCH] nvme: core: reject invalid LBA data size from Identify
 Namespace
X-Mailer: aerc 0.21.0
References: <20260418042835.420281-1-coshi036@gmail.com>
In-Reply-To: <20260418042835.420281-1-coshi036@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_052223_004529_6F08EA65 
X-CRM114-Status: GOOD (  18.42  )
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

On Sat Apr 18, 2026 at 6:28 AM CEST, Chao Shi wrote:
> nvme_update_ns_info_block() trusts id->lbaf[lbaf].ds from the
> controller and assigns it directly to ns->head->lba_shift without
> bounds checking.  nvme_lba_to_sect() then does:
>
>     return lba << (head->lba_shift - SECTOR_SHIFT);
>
> When called with lba =3D le64_to_cpu(id->nsze) to compute the device
> capacity, an attacker-controlled controller can choose ds < 9 or a
> combination of (ds, nsze) that makes the left shift overflow
> sector_t.  The former is a C undefined behaviour that UBSAN reports
> as a BUG; the latter silently yields a bogus capacity that the
> block layer then trusts for bounds checking.
>
> Validate ds against SECTOR_SHIFT and use check_shl_overflow() to
> compute capacity so that any (ds, nsze) combination that would
> overflow sector_t is rejected.  The namespace is skipped with -EIO
> instead of crashing the kernel.  This is reachable by a malicious
> NVMe device, a buggy firmware, or an attacker-controlled NVMe-oF
> target.
>
> Stack trace (UBSAN, ds < 9 variant):
>
>   RIP: nvme_lba_to_sect drivers/nvme/host/nvme.h:699 [inline]
>   RIP: nvme_update_ns_info_block.cold+0x5/0x7
>   Call Trace:
>    nvme_update_ns_info+0x175/0xd90 drivers/nvme/host/core.c:2467
>    nvme_validate_ns drivers/nvme/host/core.c:4299 [inline]
>    nvme_scan_ns drivers/nvme/host/core.c:4350
>    nvme_scan_ns_async+0xa5/0xe0 drivers/nvme/host/core.c:4383
>    async_run_entry_fn
>    process_one_work
>    worker_thread
>    kthread
>
> Found by Syzkaller.
>
> Fixes: 9419e71b8d67 ("nvme: move ns id info to struct nvme_ns_head")
> Acked-by: Sungwoo Kim <iam@sung-woo.kim>
> Acked-by: Dave Tian <daveti@purdue.edu>
> Acked-by: Weidong Zhu <weizhu@fiu.edu>
> Signed-off-by: Chao Shi <coshi036@gmail.com>
> ---
>  drivers/nvme/host/core.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1e33af94c24..9b3bf3e4075 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2407,9 +2407,19 @@ static int nvme_update_ns_info_block(struct nvme_n=
s *ns,
>  	lim =3D queue_limits_start_update(ns->disk->queue);
> =20
>  	memflags =3D blk_mq_freeze_queue(ns->disk->queue);
> +	if (id->lbaf[lbaf].ds < SECTOR_SHIFT ||
> +	    check_shl_overflow(le64_to_cpu(id->nsze),
> +			       id->lbaf[lbaf].ds - SECTOR_SHIFT,
> +			       &capacity)) {
> +		dev_warn_once(ns->ctrl->device,
> +			"invalid LBA data size %u, skipping namespace\n",
> +			id->lbaf[lbaf].ds);

Just a nit:

If I'm reading the NVMe spec correctly, ds =3D=3D 0 has a special meaning:
'LBA format is not currently available.'
maybe we should use a different dev_warn() for ds =3D=3D 0 ?

Maurizio


