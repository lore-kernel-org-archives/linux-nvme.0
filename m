Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BF2C25B74
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 04:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bah17vGUXfK4LrKEKFLhxf+W+v/uQhIldQwJPna0wDc=; b=3Eainui4nDB+fxo5HAi11KGp3B
	SfkbQGG5E2JER88XQuIHNYGioFWu9Bs12r2JdjR4KVio28NCsU99zmDJNB0zW7moZERTQ+SWRAIvq
	Mlg83XWUAdsA5iQvJ2LgL9utBO8SY4D9FLc3Fxuom3+rUX2qOO4nU950UDvSXhL+/2tHfuJRLsA2w
	5qR66SWj1FN9PBPQMpFfehudiO8qqZ32HipPOBCzwE8BVh9tJZDZngZp8Ur+f2BpMKJGQA1rjeIeZ
	aSWW4Ra07Qxwk8+cpkWCFFII8tFeZWkYdjQf+JWBiQM3qTaLtHHvpQTr1pM1PjO6hrGVN5f0VNzwF
	fGSUNvyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sELhf-00000001ABJ-0fn9;
	Tue, 04 Jun 2024 04:23:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sELhb-00000001A8F-3AHp
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 04:23:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C5CE968D12; Tue,  4 Jun 2024 06:23:03 +0200 (CEST)
Date: Tue, 4 Jun 2024 06:23:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Caleb Sander <csander@purestorage.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	mlombard@redhat.com, hare@suse.de, shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH-RFC 2/5] nvme: tcp: split controller bringup handling
Message-ID: <20240604042303.GA28748@lst.de>
References: <20240603230524.3854115-1-kbusch@meta.com> <20240603230524.3854115-3-kbusch@meta.com> <CADUfDZpbsNmYsVX6AvUtmkjD92zJvWWjyS7KBCDzhHSksL+tqQ@mail.gmail.com> <Zl5_p7C3UOKnp-St@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl5_p7C3UOKnp-St@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_212315_959264_5E010B24 
X-CRM114-Status: GOOD (  16.14  )
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

On Mon, Jun 03, 2024 at 08:44:55PM -0600, Keith Busch wrote:
> > > +       ctrl = nvme_tcp_alloc_ctrl(dev, opts);
> > > +       if (IS_ERR(ctrl))
> > > +               return (struct nvme_ctrl *)ctrl;
> > 
> > This cast doesn't look right, as struct nvme_tcp_ctrl doesn't start
> > with a struct nvme_ctrl field. Looks like this should be &ctrl->ctrl
> > to match the current implementation of nvme_tcp_create_ctrl()?
> 
> We can't take an offset here because the "ctrl" is an ERR_PTR, and we
> want to preserve that for this function's return value. I could cast to
> a "void *" instead to suppress the compiler complaints if that helps get
> the intention across.

Or you could use the ERR_CAST helper, which does exactly that void *
cast, but actually documents why it is done :)

