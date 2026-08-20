Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D23C5DF81
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2026 15:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KKd8910UZMHQq/I0uxLglRjAsGiypzz0OgWf9+X5MgM=; b=FhwdBmsdvJ0g+hRDbH5vlzLkLB
	PeoXpZFI5WFTuDgmnn8yQbIGA8OGsaCKdbJuQbIjmHklZOOi7dRmiJ2/qa9fuh28nk69xXMsts0IK
	wEqPlrlI1SAl6dpe0XR6PXgi6KCrksmcbC8qbPEOOKWQMQIwCjRRrdEKPF4BFRiBFbXhjD2zu10ud
	UOe+FJS5Y3Tm+CIxGg5tzXiM4cHMGs61CgmEOB71xQvgu0/WpY3RBCM1OdgagrswBGP7QD+wUx5Ll
	qwcJk5KYiPTj4Nw1s9iID15iiLgusAVTybegsAIiJovx9qeE+fDAtoFjejTqTZMJSOAJDrYHeSpYF
	ig7UVtxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx4bp-0000000Bnff-3x8V;
	Thu, 20 Aug 2026 15:23:13 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx4bo-0000000BnfZ-3bQC
	for linux-nvme@lists.infradead.org;
	Thu, 20 Aug 2026 15:23:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9A320424CC;
	Thu, 20 Aug 2026 15:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136F41F000E9;
	Thu, 20 Aug 2026 15:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787239392;
	bh=KKd8910UZMHQq/I0uxLglRjAsGiypzz0OgWf9+X5MgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z0qS9RsiQWo4e6YM6pdacr8gtDpCSj0LenjW0DXWzO8upx0AVZ6OYUsOUbFEoJ1Mq
	 J/Q0uMVodCKqxF9tJPrjutyLMVZBUYtP3FGfAJX8t4rLu0dEgOHT7dqsG0BFVqfkwP
	 nAT6YlHeGMrQiULpLJEbLWKPwXbI3wrfvpZP/KWgS3sWwgUqRPIovb6fUzsDA2fUeo
	 MFYjlLp+UARNV3/MOpBqagwx4fnw2jYnoXywZxH3D52nSy3nFfCg2mRMCU52t5nk5I
	 qdINk/YJ47D+IAQ5E0NTQyqeFvWN8CFgo7J4W0dV9q2GP2BiTVRtnYnAiDKI1SMisw
	 nU5jjuoOh0wQg==
Date: Thu, 20 Aug 2026 09:23:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Rihyeon Kim <rihyeon8648@gmail.com>, justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <aocb3ogg34WWtRSB@kbusch-mbp>
References: <20260814143833.1953415-2-cassel@kernel.org>
 <20260817061815.154794-1-rihyeon8648@gmail.com>
 <aoMkX_davK7TWlaj@ryzen>
 <aoXLiFruG5s1nKch@kbusch-mbp>
 <aoX2wcyhpakryWHX@ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoX2wcyhpakryWHX@ryzen>
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

On Wed, Aug 19, 2026 at 08:32:33PM +0200, Niklas Cassel wrote:
> Hello Keith,
> 
> On Wed, Aug 19, 2026 at 09:28:08AM -0600, Keith Busch wrote:
> > On Mon, Aug 17, 2026 at 05:10:23PM +0200, Niklas Cassel wrote:
> > > It seems like Keith did prefer your patch, but as you said, your patch does
> > > not avoid a NULL pointer dereference in nvme_auth_free().
> > 
> > But you're replacing a NULL pointer dereference to a derefence to freed
> > memory. That should be fixed too, and I'm just saying checking a pointer
> > for NULL before dereferencing it is more clear than checking if a list
> > is empty.
> 
> I am not following.
> 
> The options is freed in two different places, depending on if the
> ops->create_ctrl(dev, opts) call in fabrics.c:nvmf_create_ctrl() was
> successful or not.

Oh, not that path. You mentioned previously that ctrl->ops is
dereferenced in other places. I thought this means we can successfully
add the controller, which means the attributes are visible, but then
fail something else later that causes the opts to free. Since the
attribute was visible, something can open it before the device exporting
is torn down, and access it after the opts were freed.

