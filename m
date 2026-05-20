Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F3ECD4F3C
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 15:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aZMpsSMzyFe7vhXQUFxUc/6nYjHW4Wyu8MVYsvKO6X0=; b=c6G++eQKFD4yazLlQT7HutLWXk
	h9YEUMt0rQyBZZA5G/OwAEbhAdbZ3rebWMC2NbLYNSgl9dRDQaaKhEORMbjtV3L7hs5BZYE9p5a8J
	I+Kc36qj1kQN9u4BsEbTPIqhRQZ+viM5d6CrgKSAGs54516kgmQ3eKHfxqHnkaHpYxy4d3ipIPyyp
	moheNJrtZwkXoaaktqlRt54JZNSMn0OCpRkObVkIY5WHidqEWVLeA6kaoCRAh4v1aR9qjiHU0qlPr
	Ec4JAdb9LAAKg+jKaTz4hC3L2UMJGAfnggIJhIfFX6w7bZ9Rw7V1Z2rPSDyUoi+qIWPh+rCnYnt/h
	kJAJExKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPip7-00000004ywx-0Dfz;
	Wed, 20 May 2026 15:27:05 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPip4-00000004ywO-09fj
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 15:27:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BC72441A6E;
	Wed, 20 May 2026 15:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFB71F000E9;
	Wed, 20 May 2026 15:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779290819;
	bh=aZMpsSMzyFe7vhXQUFxUc/6nYjHW4Wyu8MVYsvKO6X0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bu0NOiqB43LG/qOGM0no+trU9dTDk2rb7jnb3Uj73WKkOl9m9NziliGpFvx+8+wKi
	 4w40k3xOyFK9p8jlPFvcfbQrq6WFkWcJw7iHe45rV0MEdXZQKM+6YUHAO38tM2cbMv
	 XhFiHj6i4NTGnZMKMYfnVNGzsfNtv9Qq/admLR+1ZRsKG7Dh6Cdky6kTxlfX7Nq+Rt
	 9ZHvFfl7JYcwzyZZpr91h6ALOlTKS1aQv+WwJCz16EvIadbQSNqK4mmEXTxMk/kIVr
	 hsNQspwqXeNQ8xpi9RacghS7AdaRMVRQudHmXRFIzsBxLyegZvGICx4cWxmOEmSv1d
	 ilbp3lVJvfK1w==
Date: Wed, 20 May 2026 09:26:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	tom.leiming@gmail.com, coshi036@gmail.com, Igor.Achkinazi@dell.com,
	dlemoal@kernel.org
Subject: Re: [PATCH RFC 5/5] block, nvme: add failed_bio callback for
 multipath bio failover
Message-ID: <ag3Sweie8nWMpmqq@kbusch-mbp>
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-6-kbusch@meta.com>
 <20260520072746.GD14937@lst.de>
 <ag3ORafKCTyn7TBA@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag3ORafKCTyn7TBA@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_082702_446863_EAFF0C70 
X-CRM114-Status: GOOD (  19.32  )
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

On Wed, May 20, 2026 at 09:07:49AM -0600, Keith Busch wrote:
> On Wed, May 20, 2026 at 09:27:46AM +0200, Christoph Hellwig wrote:
> > On Tue, May 19, 2026 at 10:23:26AM -0700, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > >
> > > The nvme driver has long utilized a zero capacity to indicate the path
> > > isn't reachable, which creates a race condition with IO dispatch when
> > > paths are being detached on a live system: when the block layer rejects
> > > a bio early due to a capacity check failure, drivers with multipath
> > > support using the original bio have no interception point to redirect
> > > the bio to another path.
> >
> > Trying to reverse-engineer - the problem is that the block-layer
> > code catches being beyond the capacity and directly completes the bio,
> > right?
> 
> Yes, and in the case being addressed here, the "zero capacity" setting
> is path specific, hence the driver wants to attempt a failover. I
> imagine general capacity violations are not path specific though, so
> this is kind of a weird case.

Oh, and it's not just the zero capacity IO error that multipath wants to
hanlde. It's also that we've marked the path's disk dead, so there's a
race if bio_queue_enter() will call bio_io_error() that this patch
handles. I should have mentioned that case too, which wasn't handled
with the BIO_REMAPPED flag suggestion.

