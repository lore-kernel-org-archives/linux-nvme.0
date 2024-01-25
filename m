Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85607C47258
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 08:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PH3OTw5I1+Rw/5v3dWuEHJc9vjwt6dMfoe5KVEFKi0E=; b=x3TIfqHNjtcrCJWy4v5MYN51As
	l6RTIsn/g0r4FDlZEAVLe0G2AYPIU5Cm9caK89IhLyTvD8RhhLIjFtxwjUdi4q5NfK5Gm5Aj8+O63
	gVJOmM57Si9v4xGzClWtrKusBYHZZlx+ay0ly4SAzXa92Tx8i3e6Xinn1no42tFx2I5JcYoCxRzBp
	x43eBm+33cTKj4l58IVQLtqgJKKNy8Y6sIqj3+6+CcxUp3GxbwKZGhOFBKrYZwIC1wGLXhG7xuV7B
	ufC9Ptrp20oD02raFhbMT4nbkhCkZcop6IUSx/PC8oOR6p0LQZ+o1GdEVO/0kuPVO2x4Uuk+jKUeV
	hToQ+paw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSur3-007Flw-1X;
	Thu, 25 Jan 2024 08:12:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSuqz-007FjA-2N
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 08:12:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6FB1D67373; Thu, 25 Jan 2024 09:12:42 +0100 (CET)
Date: Thu, 25 Jan 2024 09:12:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 05/15] block: add a max_user_discard_sectors queue limit
Message-ID: <20240125081242.GB21006@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-6-hch@lst.de> <Za6zg-pA8IJkIb_b@kbusch-mbp.dhcp.thefacebook.com> <20240122183857.GA7029@lst.de> <ZbEwUDrmTlWTfK75@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbEwUDrmTlWTfK75@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_001253_943220_D29D9441 
X-CRM114-Status: GOOD (  16.37  )
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

On Wed, Jan 24, 2024 at 08:44:16AM -0700, Keith Busch wrote:
> > > > +		min_not_zero(q->limits.max_hw_discard_sectors,
> > > > +			     q->limits.max_user_discard_sectors);
> > > 
> > > Shouldn't writing 0 disable discards?
> > 
> > I mirror the max_user_sectors behavior here, where 0 disables the
> > user limiting.  But yes, that would be a behavior change.
> 
> But a user should be able to disable discards, right? Unless you really
> want to match max_user_sectors, I think you could default the user
> setting here to UINT_MAX and use "min" instead of "min_not_zero".

Not a fan of having different semantics for the different attributes,
but given that we've had this or 9 years we better stick to it, so
I'll change it.

