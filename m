Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5CDC5DF81
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 18:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XuK/2TYFRr/k7ksufLToFfpbpuUiwIVt1IGE+TxZcFY=; b=R4+C+D3itveFnyZmddpI6sSiaA
	zBG9Wbjbw8CsN7r5tiX5GqymvtporVV0b1pEyDZvlXFVkZ0fJeg+8G5/yOkS2X/madkH7dLWKY96V
	3YJRJOWr4A0eHhHUwrlrGB6QikQnCBYAK6+j1d+VGeet/wVoxxRA+PVom1WjBoNYm6RGStQTz08hM
	x3RDqdgIOahdW1eUeSI+oGp4wrv4qL2N2aRj6dTsGAplvn5f2TquFnghD1351RgbhUEpR7tTNh3iR
	d7+kkxdyN0uuF7dvx3e7bZl4nGMRIbMAlzTT2cKokShEMuxGsYBeZKU1oo8avN8N2HTShg3krP0Ki
	1pQ46u7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwl5d-0000000ANWR-36Pc;
	Wed, 19 Aug 2026 18:32:41 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwl5c-0000000ANW8-2gY5
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 18:32:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8AD3C60AAA;
	Wed, 19 Aug 2026 18:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D12F1F000E9;
	Wed, 19 Aug 2026 18:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787164359;
	bh=XuK/2TYFRr/k7ksufLToFfpbpuUiwIVt1IGE+TxZcFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RPHry27Y8+JRRcJnXao4ZDp90QM6dkopKJFvp57UKfDjTm7QHgBVDYlrOqMfij/c2
	 Y2ONY6lRoY9CJw6fuQzgU5GuMhBY6AJA9MmX7SzU68qMn1ayw73E5sCgyTMLCm5fC5
	 b47XzumAQ/loI9U+o/pwiax9IgsU0xoHb8GtgiaxwBcuADMItbqLOUGyhC7WDI+o8s
	 pvL9EEE3xn6GSngNOQdBnuS0pwq2TKdEMUYOWC9bthMBsh769nZi4oFkmgbiIMaxlE
	 dTHnnwXdhhHq4by+Ctf2vmGmbjXYaYr0vGSaZLo879k8lK7AMA3rAUXkbysCJ7MIlF
	 SPD/pI2PObnSw==
Date: Wed, 19 Aug 2026 20:32:33 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Rihyeon Kim <rihyeon8648@gmail.com>, justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <aoX2wcyhpakryWHX@ryzen>
References: <20260814143833.1953415-2-cassel@kernel.org>
 <20260817061815.154794-1-rihyeon8648@gmail.com>
 <aoMkX_davK7TWlaj@ryzen>
 <aoXLiFruG5s1nKch@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoXLiFruG5s1nKch@kbusch-mbp>
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

Hello Keith,

On Wed, Aug 19, 2026 at 09:28:08AM -0600, Keith Busch wrote:
> On Mon, Aug 17, 2026 at 05:10:23PM +0200, Niklas Cassel wrote:
> > It seems like Keith did prefer your patch, but as you said, your patch does
> > not avoid a NULL pointer dereference in nvme_auth_free().
> 
> But you're replacing a NULL pointer dereference to a derefence to freed
> memory. That should be fixed too, and I'm just saying checking a pointer
> for NULL before dereferencing it is more clear than checking if a list
> is empty.

I am not following.

The options is freed in two different places, depending on if the
ops->create_ctrl(dev, opts) call in fabrics.c:nvmf_create_ctrl() was
successful or not.

If the ops->create_ctrl(dev, opts) call in fabrics.c:nvmf_create_ctrl() was
successful, the teardown path will be:
core.c:nvme_free_ctrl(), which calls nvme_auth_free() (which will use
the options), nvme_free_ctrl() will then call ctrl->ops->free_ctrl(ctrl)
which will free the options (since the ops->create_ctrl() call was successful,
the ctrl will be on the linked-list).

If the ops->create_ctrl(dev, opts) call in fabrics.c:nvmf_create_ctrl()
fails, the teardown path will be:
core.c:nvme_free_ctrl(), which calls nvme_auth_free() (which will use
the options), nvme_free_ctrl() will then call ctrl->ops->free_ctrl(ctrl)
which will not free the options (since the ops->create_ctrl() call failed,
the ctrl will not be on the linked-list), fabrics.c:nvmf_create_ctrl() will
thus goto out_module_put, which then does a goto out_free_opts, which
calls nvmf_free_options().

In both cases, nvme_auth_free() will access memory that has not yet been
freed. So I don't see us dereferencing freed memory.


Kind regards,
Niklas

