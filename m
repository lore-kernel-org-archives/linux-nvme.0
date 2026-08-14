Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D99DC5CFC1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2026 14:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jbkaGCoYqQTj2DrafItBG9EZ2R7G8Oyso9YhZ31wUgE=; b=OvOKzbOAC2f2DUsT1K8TObY6SF
	irb0Xw4OAeOmOiB4xioics30WUJvHbGYfuf5VvfgowGdsLrclMG1WNBwKXsz9B0PHHY12tNjjlLNI
	9j5saRT8R8X5Wqfz7UJnE3SE2AGrlVDg5/3W8BVGAqd25ftkbq1iTQpoOxewn/YHo6b9o5YnLbIFv
	yB18RmbToErNabbgpbS1J2BrIlx5d20UbBbTbcNdujRioFyZ1z/zXAYT35Y+r/7QBFgWwXPZfC38K
	gHhl8PsQgcKsb9DsUXPpHG1XHXo8ff7jOovfZOvzOCOFflM0pb8sonsQn8stC6DjpnBUsVqKcPlfd
	6bMrnAzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wut8e-00000002oUz-1sqj;
	Fri, 14 Aug 2026 14:44:04 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wut8d-00000002oUm-1ZkG
	for linux-nvme@lists.infradead.org;
	Fri, 14 Aug 2026 14:44:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D591D41073;
	Fri, 14 Aug 2026 14:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA0C1F000E9;
	Fri, 14 Aug 2026 14:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786718642;
	bh=jbkaGCoYqQTj2DrafItBG9EZ2R7G8Oyso9YhZ31wUgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VSlu0czGSHzzCkvn8DWPYHZDn6EUkQWu769ROrtRMpeIdbf1BpZOjiKfR5r3/HwR8
	 VjryX/tI7UIl97E433e4kHivigsHdrWPFfftqrU1Zaq2OhD8VpkpyQh6XlxVDcfDHy
	 JJ3/oEEbANfyu1Ni/5LTQwaxIlwPaQHarFpZ9KHkMa9SGnzE3qSW/ehhmAatP1lrrN
	 336tTVuuurfzW43JQnnQ8fIkdZTD3xGp4oztMHkEswPDPl6ku2pXmB/ae2P188YmCt
	 +GwiYEmWLq43wWLdRinTl5nKyIkcqz/hcPX84FXlfbZk+CoB0CSgsifathPzIB36QA
	 hJuzNDG5Btqzg==
Date: Fri, 14 Aug 2026 16:43:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rihyeon Kim <rihyeon8648@gmail.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	justin.tee@broadcom.com, nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <an8prQiY-Vzxf8nh@ryzen>
References: <20260812122503.196828-1-rihyeon8648@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812122503.196828-1-rihyeon8648@gmail.com>
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

Hello Rihyeon,

On Wed, Aug 12, 2026 at 09:25:03PM +0900, Rihyeon Kim wrote:
> nvmf_create_ctrl() frees opts when ->create_ctrl() returns an error, so
> a transport must not free it on its own error paths.  nvme_fc_ctrl_free()
> therefore only calls nvmf_free_options() while ctrl->ctrl.opts is still
> set, and nvme_fc_init_ctrl() clears that pointer before its last put.
> 
> It only does so on the fail_ctrl: path.  When nvme_add_ctrl() fails,
> nvme_fc_init_ctrl() jumps to out_put_ctrl: instead, so
> nvme_fc_ctrl_free() still sees ctrl->ctrl.opts set and frees opts, and
> nvmf_create_ctrl() frees it again.
> 
> Reproduced with nvme-fcloop and failslab by failing the kvasprintf() in
> dev_set_name(), called from nvme_add_ctrl():
> 
>   BUG: KASAN: slab-use-after-free in nvmf_free_options+0x30/0x190
>    nvmf_free_options+0x30/0x190 drivers/nvme/host/fabrics.c:1284
>    nvmf_create_ctrl drivers/nvme/host/fabrics.c:1374 [inline]
>   Freed by task 5534:
>    nvme_fc_ctrl_free drivers/nvme/host/fc.c:2374 [inline]
>    nvme_fc_init_ctrl+0xe17/0x1450 drivers/nvme/host/fc.c:3605
> 
> Without KASAN, opts is freed twice.
> 
> nvme-tcp and nvme-rdma reach the same error path, but their free_ctrl
> only frees opts once the controller is on the global list, so they are
> not affected.
> 
> Move the clear down to out_put_ctrl:, which both error paths pass
> through.  The same injection then returns -EIO without a report.
> 
> Fixes: 1a9e218195a5 ("nvme: split device add from initialization")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f58e57380a6083c4041d
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Rihyeon Kim <rihyeon8648@gmail.com>
> ---

I created an alternative fix that makes fc behave the same way as
tcp/rdma/loop, i.e. derive ownership from seeing if the ctrl is on
the list or not:
https://lore.kernel.org/linux-nvme/20260814143833.1953415-2-cassel@kernel.org/T/#u

This has the advantage of avoiding the NULL pointer dereferences in
nvme_auth_free() and when accessing the sysfs attributes during teardown,
as reported by Sashiko, as ctrl->ctrl.opts now stays valid for the whole
teardown.

Please review.


Kind regards,
Niklas

