Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18FDC38A2D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 18:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wlC+luP//VGMJKCbeoo6PRgK7iMy7X03JGv5f7UBNuw=; b=l4NYZCbmp3Urm1uIoaXKI1z+ST
	+k5MqC0DixnC1y6H1tkQm2VAztwgibxiqB2KNXjkgSiyszovhwvEolB71/BEV3wTaNE2yrNUSx4I8
	KpxFCHiyn6Xq3DYc6Nz+07rUQsgXcfOonnidIVsdwXTzUQdBa5xNq5TuhJ5nBYhztTlmnk83jPNPQ
	pAg6m2kGYr9mnOQut3CQ1Qstt46s1rXqmi7WjuPQ3X3lBPcHMYtPdb20Vh8tzbSNe26fi2E/bfwfr
	Q6wVH8UkiaIBKInI6r1zW9Ati4cCKt9N/cAQlaXWj9a0iuUiq5uCRHfi/XmQyT9jTC+GjqH3VknnR
	hNBw1LuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onkzm-00AWaO-1t; Wed, 26 Oct 2022 18:19:18 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onkzj-00AWZc-Ok
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 18:19:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 458EBB82399;
	Wed, 26 Oct 2022 18:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C2EC433C1;
	Wed, 26 Oct 2022 18:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666808353;
	bh=8EvYPbSSijqZFuBkCYcBaF0KbkNG2qzDe4asIYGvjrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eG3nNGsGguC1+l95AG6qRejh2hJ73RUpQwrdq5OC14EnQehSWCicKhXUB/Hsfvnpr
	 +QacavGqjUVzsP1E/PO05nZUgSCsloermdBdNgbeZ7Hi6ewQMT2mHJDU2zhXe/xSep
	 l4AJ+Mlsbpg1/4vFHsMJckHCtjcawo5PHIPiS6y91VEUcBOcZuYLsVm/rGScwSP0xg
	 zAMxjpqtnZpq3XIAf0Z9Du2VuExseGqQPgN5MwveOc6ilaAFNLzdFG2FEsrjUG+Xca
	 /wz31hwxJgZN1vy/vsT5aYNavtx9VDe7GF/uQhW5j6iVUqbGHo2i/YgabOnuXJQzG3
	 RLb7VW3Q+KK8w==
Date: Wed, 26 Oct 2022 12:19:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH] nvme: quiet user passthrough command errors
Message-ID: <Y1l6HSvH8iYswEaD@kbusch-mbp.dhcp.thefacebook.com>
References: <20221026170715.2657664-1-kbusch@meta.com>
 <52e66f7f-30a8-0726-3db5-dee2b010c1a2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52e66f7f-30a8-0726-3db5-dee2b010c1a2@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_111915_967966_79DB8A77 
X-CRM114-Status: GOOD (  16.64  )
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

On Wed, Oct 26, 2022 at 06:04:32PM +0000, Chaitanya Kulkarni wrote:
> On 10/26/2022 10:07 AM, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The driver is spamming the kernel logs for entirely harmless errors from
> > user space submitting unsupported commmands. Just silence the errors.
> > The application has direct access to command status, so there's no need
> > to log these.
> > 
> > Cc: Daniel Wagner <dwagner@suse.de>
> > Cc: Alan Adamson <alan.adamson@oracle.com>
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> 
> 
> This should do the trick, however it will be great if reporter
> can provide tested-by.

Pretty easy to test. Just send an invalid command from user space:

  # nvme admin-passthru /dev/nvme0 --opcode=0xff
  nvme0: Admin Cmd(0xff), I/O Error (sct 0x0 / sc 0x1) DNR

With the patch applied, the kernel message is suppressed.

