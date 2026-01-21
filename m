Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D996C44536
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jan 2026 15:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zlyvSogMV3/fcL3NmsngU8NJDQO3PM37ghYJhKKKJwE=; b=SpuKjPZ2Tr49GA0NqhL3lkIXbz
	uhu1LaY5xDp7Wvyi+GFKrwHNorDipwxVGI8Rr4WIB/SHs7G6B45Q2LTO8EqqgRJp3lYFwxL6UaRkN
	RU4TYgkLHAwrY/LQrY0039XS91lfd+0SvcWu9VV9ok3c4CONCgyspOrj2rgYRzNJUvgFRQiZyITGl
	0gABRR7N4z2Avf8ZBHONcZK6nyz4aBVgNNiaSUHl89vJ6U7eNmTNzKD5LF35c6dHRxXw5eKVCDNuS
	cX8hm+9U3r1CqalwsdfJh6SjpAgzGOFh/jiKq+k7Rt47nBRhM1/hNmgwdusyslTYjednhrhw+5zeC
	3zJ5SARg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1via1p-00000005i7M-2EUJ;
	Wed, 21 Jan 2026 15:21:53 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1via1o-00000005i6q-1lSw
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jan 2026 15:21:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4B52A600AA;
	Wed, 21 Jan 2026 15:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3976C116D0;
	Wed, 21 Jan 2026 15:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769008911;
	bh=kRjbRHjdPxS6Mw0bVKQtAyZ9K5hinrud5WAp7cWw5n8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QIhOD8RfK+29+3ggyLqsej8EsyIekrzF5jsIgBHUwN1oS8wZ/RC7sulTP/Xj8Rlrh
	 QhFB9K2kbBGJIx10GAWJv9k1So6bziUYNbeLVb6rtJqz1lD+qIN32v2Gu3V8JLsdts
	 oBgyxwI4W/qmmrnblykrX/xT3H7cP+QYO3FWbN7EPac0GOxj6tzSBDze7hj1nMgbH/
	 KUC9vlqcZPo394FGAUj5ghYDhVAn9utia6fJdafYL2XCuJ/k2xMp0GIRqvCtlCoEtT
	 qL54AdC1IepB7bC0xnBlxe1PUXuwruT61hNtlD2cyXxrk9LomgyttvDtdZmZ48A6o9
	 qrTeHbIVy2kcg==
Date: Wed, 21 Jan 2026 08:21:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Dmitry Bogdanov <d.bogdanov@yadro.com>, stable@vger.kernel.org,
	Guangwu Zhang <guazhang@redhat.com>
Subject: Re: [PATCH] nvmet: fix race in nvmet_bio_done() leading to NULL
 pointer dereference
Message-ID: <aXDvDHaAU8cUGlZf@kbusch-mbp>
References: <20260121093854.1705806-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121093854.1705806-1-ming.lei@redhat.com>
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

On Wed, Jan 21, 2026 at 05:38:54PM +0800, Ming Lei wrote:
> There is a race condition in nvmet_bio_done() that can cause a NULL
> pointer dereference in blk_cgroup_bio_start():
> 
> 1. nvmet_bio_done() is called when a bio completes
> 2. nvmet_req_complete() is called, which invokes req->ops->queue_response(req)
> 3. The queue_response callback can re-queue and re-submit the same request
> 4. The re-submission reuses the same inline_bio from nvmet_req
> 5. Meanwhile, nvmet_req_bio_put() (called after nvmet_req_complete)
>    invokes bio_uninit() for inline_bio, which sets bio->bi_blkg to NULL
> 6. The re-submitted bio enters submit_bio_noacct_nocheck()
> 7. blk_cgroup_bio_start() dereferences bio->bi_blkg, causing a crash:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000028
>   #PF: supervisor read access in kernel mode
>   RIP: 0010:blk_cgroup_bio_start+0x10/0xd0
>   Call Trace:
>    submit_bio_noacct_nocheck+0x44/0x250
>    nvmet_bdev_execute_rw+0x254/0x370 [nvmet]
>    process_one_work+0x193/0x3c0
>    worker_thread+0x281/0x3a0
> 
> Fix this by reordering nvmet_bio_done() to call nvmet_req_bio_put()
> BEFORE nvmet_req_complete(). This ensures the bio is cleaned up before
> the request can be re-submitted, preventing the race condition.

Thanks, applied to nvme-6.19.

