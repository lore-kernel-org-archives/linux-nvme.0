Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B64C5DF66
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 15:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eo2+YfxM63ujcSnJDyWIW/AYTNaxfj+sSZ6E63Xt7EI=; b=qJ3U5BlnYph2/pvcmM9i9Dv2+p
	mA2KoIvgml6LE7g5uv6xIWH9OLLqu/gyj9WHaMR0DpKPna8BqyFh3RlEjn11A83l2YEIMGlbTapM5
	olqobgEZSMBDGRWI91m1bqKJ/QCh/8W2CMoE1HEa3HIbgl6QDyXdksAZ41AComtQzdfSCZgE/ERc+
	HKcm9uDeevlifQqWzqOiKUe9zMPi8NEM0+7bmHKCtdlVaUR/FbZ86iESHiMOT2BScJRRwtkJO2lrK
	imPApewwdyvkpzivy6nxVRzLBTTviRIIGkoHlYfbPrdC32ADpDY8m3Y0h1p+6P+SqEgBvUOY73zfr
	4vyNe+Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvyys-00000006N1E-3gCk;
	Mon, 17 Aug 2026 15:10:30 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvyyr-00000006N15-1aEe
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 15:10:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C784042390;
	Mon, 17 Aug 2026 15:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389D21F00A3A;
	Mon, 17 Aug 2026 15:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786979428;
	bh=Eo2+YfxM63ujcSnJDyWIW/AYTNaxfj+sSZ6E63Xt7EI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GWiF8OtrLKaPMx47NgR3aA3GaVU99i413uugrlObg9GGI18V21ou+/4eV3w3iTZw1
	 4lFs5PFA1CGnskE8zCwVI4ZMrcPtArjTFnJ+9S6Op1Iqy84C+Pxf3k2N53XxhiBjv+
	 8wKsvSTclRO8b8f7dwYurRMvm6er5Y5ihYa3p4JWBkBHPo0Vs0MuGG+YsJ4nq3aL+e
	 7eGiQvbTYB60h4aVqZkGX+tvI0Rp8fCK3ALtxYqtQ/tzI2S2htcgRwxdpMwRXKox2M
	 wQXeF0ItWWPom0dI9nopDOp4lqrJD6X21sTQREeOgcr6CapeNs3bWLgipb6Y4d347c
	 y3IQa7ICLOTkw==
Date: Mon, 17 Aug 2026 17:10:23 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rihyeon Kim <rihyeon8648@gmail.com>
Cc: justin.tee@broadcom.com, nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <aoMkX_davK7TWlaj@ryzen>
References: <20260814143833.1953415-2-cassel@kernel.org>
 <20260817061815.154794-1-rihyeon8648@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817061815.154794-1-rihyeon8648@gmail.com>
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

On Mon, Aug 17, 2026 at 03:18:15PM +0900, Rihyeon Kim wrote:
> Hello,
> 
> Thanks for the explanation, and for picking this up.
> 
> My testing of v1 and v2 never reached this case.  The syzbot config has
> "# CONFIG_NVME_HOST_AUTH is not set", and I was not aware that the
> dhchap option tokens are compiled out when it is disabled.  A connect
> string containing dhchap_secret= is simply rejected, so every run I did
> tore down with ctrl->dhchap_ctxs NULL, and there was no path that
> dereferenced ctrl->opts.
> 
> I rebuilt with CONFIG_NVME_HOST_AUTH=y and swept fail-nth 1..200 over a
> connect write containing dhchap_secret=.  You are right:
> 
>   clearing opts at out_put_ctrl:   dies at attempt 20
>   this patch                       200/200, with 35 of the injections
>                                    landing in nvme_add_ctrl()
> 
>   Oops: general protection fault, probably for non-canonical address
>         0xdffffc0000000008
>   KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
>   RIP: 0010:nvme_auth_free+0x99/0x450
>    nvme_free_ctrl+0x231/0x6c0
> 
> The injection for that attempt landed in kobj_map() under cdev_add(), so
> this is the nvme_add_ctrl() failure path.  ctrl_max_dhchaps() then
> dereferences ctrl->opts at offset 0x40.  Clearing the pointer really does
> just trade the double free for this NULL pointer dereference.  Good catch.

Thanks a lot for verifying that the Sashiko comment about the NULL pointer
dereference in nvme_auth_free() can actually happen, and was not only
theoretical.


> 
> Your version also addresses the two things I was unsure about in my
> earlier mail: fail_unlist: covers the two exit paths after
> list_add_tail(), and checking list_empty() while holding the lock keeps
> ida_free(), put_device(), and nvme_fc_rport_put() on the unlisted path.
> 
> Dropping my v2 in favour of this one.
> 
> Tested-by: Rihyeon Kim <rihyeon8648@gmail.com>

It seems like Keith did prefer your patch, but as you said, your patch does
not avoid a NULL pointer dereference in nvme_auth_free().


My patch should also avoid a potential sysfs NULL pointer dereference as
reported by Sashiko:
https://sashiko.dev/#/patchset/20260811125310.165487-1-rihyeon8648%40gmail.com

which is currently also only possible for fc.c, because of the
'ctrl->ctrl.opts = NULL;' hack.


Personally, I prefer this patch, since it makes fc.c more similar to rdma.c,
tcp.c, and loop.c, by checking if the controller is on the linked list or not,
rather than setting 'ctrl->ctrl.opts = NULL;' before the teardown is even done.


I agree that this patch adds more code than what we ideally would have wanted,
but I don't see any other way (other than completely refactoring the ownership
model of the controller options - which would require much bigger changes -
and would most likely require changes to both fabrics.c + all the different
transport drivers).


Kind regards,
Niklas

