Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EDFC88E7D
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2026 16:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mPAUyctOzM13LmIs80HMlxjdyYqyk+CWoiFoO7AeDf8=; b=1tucRQsLB7kPiwlufDeXZb5Mlj
	0sOLz/E6r4Zajuh5DPmM7IWcE/Wvxxn9Uy/g+A+PRzsOSJIQRdkGRq2LZhoKQM7fkMrU32M2zk8kt
	TbB8LrmmYGJ/g4+4SMItvG+hPaRlWNjveFiGi0NZnBshJ4+MMrJQEAijAPiyAnMg+zAJVFq/5nyI7
	7xkt8h/LpOspLfVUBDb6vCJZAAmoxwoHS2GL/kYlEHKtHM8u9NNgQuLJXu6KWf9DVq5Oatr65RLpD
	lcjiPQKO9EXD7DB8LRfpzbrbVeFe3CEkr9oYXWwhsCksHLM/q3+0drYJSRbwfL4YYJP+SDa25jnhX
	MRM6fWZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6WEW-00000007SG8-0MJJ;
	Tue, 15 Sep 2026 16:42:12 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6WET-00000007SF5-321w
	for linux-nvme@lists.infradead.org;
	Tue, 15 Sep 2026 16:42:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 213BE40C31;
	Tue, 15 Sep 2026 16:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5B11F000FF;
	Tue, 15 Sep 2026 16:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789490529;
	bh=mPAUyctOzM13LmIs80HMlxjdyYqyk+CWoiFoO7AeDf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h4+4rSZ5j7kw8biVGaFPHfASappn0lOrIOsTmJUR3Sk7fVYAddartPbBJ4yPwPcL4
	 p7x+DFfUj3p/1b7d8Wk7xN4QZHWYLsM0QXTLfZVCUJw+5psYwOPfAX5zR+5yN0iF54
	 QGTFZl2woXys7r76oVWnfFKNuxPqkdEzim+QfBQSnAIrtVUCZaeO8ZQfnj3EaZaqWb
	 g3kGa3JtaILwp+bsRW+xCQILqew/JH0ct+rwfPOeE6D0XS4oWph4huYnVxHe+2OdoP
	 WCoatLnSClRsHlvC43+9X+TyzUC+u1PKC7091vNfV8JzCEkLYkw/GhKA63uX66+zO8
	 Pl8C7EKFBrGuQ==
Date: Tue, 15 Sep 2026 10:42:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Maurizio Lombardi <mlombard@arkamax.eu>,
	Maurizio Lombardi <mlombard@redhat.com>,
	linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de
Subject: Re: [PATCH] nvme: do not reset controllers in NVME_CTRL_NEW state
Message-ID: <aql1Xmn24bdQIFSA@kbusch-mbp>
References: <20260915095827.698928-1-mlombard@redhat.com>
 <e6146839-0a52-45d0-8b95-9ae0f7807493@flourine.local>
 <DLFXS43UXYEC.MEIQ5NBK049N@arkamax.eu>
 <10649bfb-a250-4352-a858-4e9b03457ae0@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10649bfb-a250-4352-a858-4e9b03457ae0@flourine.local>
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

On Tue, Sep 15, 2026 at 04:49:31PM +0200, Daniel Wagner wrote:
> On Tue, Sep 15, 2026 at 03:49:36PM +0200, Maurizio Lombardi wrote:
> > "
> >  Fix this by removing NVME_CTRL_NEW from the allowed prior states for
> >  the NVME_CTRL_RESETTING transition. It is safe to drop this transition
> >  entirely because a controller in the NVME_CTRL_NEW state is merely
> >  allocated and not yet initialized, a reset operation at this stage is
> >  meaningless.
> > "
> > 
> > For what concernes the "why it was there in the first place" question,
> > I think that the reason is that in ancient times a CONNECTING state
> > didn't exist. The controller initialization was done via a reset;
> > so the transition was NEW -> RESETTING -> LIVE.
> 
> This rings a bell. With the introduction of the fabrics drivers, the
> CONNECTING state was introduced and the PCI driver didn't use the
> CONNECTING state for while. But due to various reasons, the PCI
> transport follows the same state transitions as the fabrics ones now.

Yep, nvme pci used to always kick most of the initialization to the
reset_work, so that transport wanted the NEW->RESETTING transition.
With asynchronous probe support added, we do the initial setup without
reset_work.

