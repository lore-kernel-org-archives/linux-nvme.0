Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373B7C001DE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 16:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3PpmVW8yD4WauoBd2TH4PHSeTQfMge2Qk4VqJ7Zp92Y=; b=t+Is8WfruRioKea8Gn7TOWwvJ7
	tsSrpFigHq5k1KocGllf3aLZEh5CgkRMYEKOXUWboVffBhF6nUG4T1SjtVI5IwjVKZ/vLcxdUvOmk
	og1giVWmM/wc28Y+16G5+ZzFLYu46jo7nHUkWuk8WHj6hTka98nR9h6+DAYE3xzbA9ptT0XmdSwJ8
	RfhPnODzmQ1sMAfHOvKlGk3ZgSYw14IS4qu9glp0cpFIWPm4Rl8t44AiO7rMhDsDZqZYzslp4ni1b
	5DrOKInz9SGzXvIy+NmLsy+mknvWDWC45TY6BpuTGmfS8e5w1kKwMTetQT4svikyES5mvi/gnSJUr
	B0sfH/cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVDrM-00FRK8-1B;
	Sun, 13 Aug 2023 16:22:32 +0000
Received: from wout3-smtp.messagingengine.com ([64.147.123.19])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVDrJ-00FRJD-2X
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 16:22:31 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 03E9F3200805;
	Sun, 13 Aug 2023 12:22:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 13 Aug 2023 12:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1691943742; x=1692030142; bh=3P
	pmVW8yD4WauoBd2TH4PHSeTQfMge2Qk4VqJ7Zp92Y=; b=sTVnjPQ/gDZUvEyv+p
	ZglthFzb1Rk5T5EfIKgeANVFQupcXgAI52KvRdxiYIS2qnq4BYvaHsTLlu2VM4H1
	4aSOfdUpEiJFkm30YLpwX+cVONWYQ2x5uhBlWbnO0wWfEC8Qfjq2GU4/YBxYOaBm
	OKc3x2bbxiU5GWeGLx9TbFRnAocOVr0Vxl4wX+xhN5IIY3rpHmgSzHeVYvPKv3Bc
	0yOYNFatg+m12zA6e+/CAoG1EAtf/HhPotfINk81Q5e49Bx9QJfF8SHan2XIScNT
	XeT7fXOdaKbYcRdy6ut1cBT29MFjMLlOiPGnsck79HpPqhd63r5NeulFkUllE/iT
	MVVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1691943742; x=1692030142; bh=3PpmVW8yD4Wau
	oBd2TH4PHSeTQfMge2Qk4VqJ7Zp92Y=; b=bL3P7GjHvTK6up8CBFG243xLf6lWh
	g2h1kNBcQ8ZgKI0/BVTgZhqVKqOp3Ku+bEXM2mIByudlSTLJzCaTNbVWHj6874sc
	mJioFVj7y2hzoL9Rw3cNoDMA6t99c6lXUT3KU1KfVvQlKMyKffw714K5I/hFAfpy
	oO8GZYr1VmAvd049yZRwTf9CJTvyO4nqspqCktwgXsTB/yV3eLH9Dt/035fv2a0p
	2yfQ2G3cZ7V1kiEoUAVWE2MvPG8ptsYYoFIWKfDQXefpcnfliUQDX2Ass4jIB1YN
	9tsBT7ZbGWXfRVKacN/nKDT4sgMEFlx/S0Jb/bzsDUh7l7IZdyAYUOHig==
X-ME-Sender: <xms:PgPZZLVyKMkjB6r_4Gn_oeWfLL7ku4PSf11JLiY3ZpifIxUJ_9loLg>
    <xme:PgPZZDmRGfqSquV42_iT8zdmPi8xRonja8y28RHeLHAlcyQ6ZReQ56CBWMJ2QSVoM
    uUiVsGU2ojVxg>
X-ME-Received: <xmr:PgPZZHZjSLuQ6ofAa98pEfb4aiwOeOBWKrkuEoAnu7D1XkeFr_n5aRDORZ8atTbv6jZP2r30KS93ka5fNE1FSPe1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtvddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:PgPZZGXJ2RCiMuXEEyGgBzQgrH4b4XaYtXLFmFKlP3SYJW4VakDfvg>
    <xmx:PgPZZFlCC1PNxGVsrudGnRFVIyt3D7HwfRYd1snM8nLICnWayhM4pg>
    <xmx:PgPZZDfSWVLoNbsebm2_jQPwhcZcU-CXlWd8J2i_D9YxOowOFDfF_Q>
    <xmx:PgPZZOBYfRPY04z8MwvPUlhWRcFkqszgUpSvEuX5eJKVE9tHJfYatg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Aug 2023 12:22:21 -0400 (EDT)
Date: Sun, 13 Aug 2023 18:22:19 +0200
From: Greg KH <greg@kroah.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: stable@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6.1.y 1/2] nvme-tcp: fix potential unbalanced freeze &
 unfreeze
Message-ID: <2023081344-scorebook-crib-d330@gregkh>
References: <20230813144500.15339-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813144500.15339-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_092230_158892_B63AFED8 
X-CRM114-Status: GOOD (  16.56  )
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

On Sun, Aug 13, 2023 at 05:44:59PM +0300, Sagi Grimberg wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> Move start_freeze into nvme_tcp_configure_io_queues(), and there is
> at least two benefits:
> 
> 1) fix unbalanced freeze and unfreeze, since re-connection work may
> fail or be broken by removal
> 
> 2) IO during error recovery can be failfast quickly because nvme fabrics
> unquiesces queues after teardown.
> 
> One side-effect is that !mpath request may timeout during connecting
> because of queue topo change, but that looks not one big deal:
> 
> 1) same problem exists with current code base
> 
> 2) compared with !mpath, mpath use case is dominant
> 
> Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/tcp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Next time, can you give us a hint as to what the upstream commit is for
this and the other patches you sent?  I'll dig it out for now, but it
makes it much easier if I don't have to do that :)

thanks,

greg k-h

