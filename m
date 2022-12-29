Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C550DC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Dec 2022 16:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zPKjCf2MD/9u6J2F6S9LMXqARbQOW+dtKLIwYAFB0Wo=; b=X5cfq0qFKlqts6ALN2nDzZBWWj
	BOC5hujhV39/HjUaVycT0XN5d4IYs0WrSZh5bBj3Wgn+lj3w8k0VQRDDkD2cEY5CHXTq9zSCO4NLy
	VAELGZk5K6N0cjoPofO7pcQiaBTx+bJF7H0R3ETl9FjRykxURNJzPAlN6Wbk1oW3PE6w+aORDvNQ6
	8JTBooMPsHkS6cLjepI0KiZIIllDpc3AtVterhvkgJCT8IPX8ze2jenqJoJIWqpoUJZcRgbdNicwB
	1kU+WhL+5xBxuYXbrOEfqN/boN8bUnvl8XGCUuexSEJka3vh1mbgb68t8p5creKMRbrgs7eBCXzJp
	iYJj64TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAvrT-00HWrb-Qs; Thu, 29 Dec 2022 16:34:31 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAvrR-00HWpd-D9
	for linux-nvme@lists.infradead.org; Thu, 29 Dec 2022 16:34:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0140561838;
	Thu, 29 Dec 2022 16:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB1BC433EF;
	Thu, 29 Dec 2022 16:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672331666;
	bh=2bMMERLZy6NqXKUW7z0Io/XkQ5LqOprHOWLCPgEBs88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u/RDY6PVHU8RQTxM93yibve49kLvUBOrDmK7ExmDJ+wrXxKyKfGvtGtCBSPzHuHDV
	 lWUS8Vy5N2xBN72PBmGctcUxhf4U1UIL6cfyfiWkLbwcOsoRpyVR7rqEqFbiIOyqWW
	 67ghMzo67Y56rrI0SfThHgFPYxJycA81rnNVj9lPpWGWvAtuCWZ8zTeI7qNXJKT/d3
	 goD3+Gwr/vNxMFWyxUttvY94jdg3rrw/dWlsZivWaRr25eHWpTFhpUM+q0DuGKp8ZY
	 mbfbeYHTEItrhNH2y9S+rGirmXeIUW96kL78/YfjX2ukO5svTgCxxB9u34HL6xm2e8
	 P+Dgc+2cHfCgw==
Date: Thu, 29 Dec 2022 09:34:23 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@fb.com>, Hugh Dickins <hughd@google.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/4] nvme-pci: update sqsize when adjusting the queue
 depth
Message-ID: <Y63BjxIJykWWTzOP@kbusch-mbp.dhcp.thefacebook.com>
References: <20221225103234.226794-1-hch@lst.de>
 <20221225103234.226794-3-hch@lst.de>
 <f0d3c027-d793-8266-7c69-30a85f884b23@grimberg.me>
 <20221228161050.GA849@lst.de>
 <c1f876cb-5004-c91e-398c-83fb007bb697@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1f876cb-5004-c91e-398c-83fb007bb697@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221229_083429_541613_8C425218 
X-CRM114-Status: GOOD (  22.11  )
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

On Thu, Dec 29, 2022 at 02:07:04PM +0200, Sagi Grimberg wrote:
> 
> > > But if you want to patches 1+2 to be taken before 3+4, I'd make sqsize
> > > to be a 0's based value of q_depth after we subtract one entry for queue
> > > wraparound. So others would not get affected from patches 1+2. Then in
> > > one batch make all assignments to sqsize 1's based like in patch 3 and
> > > change nvme_alloc_io_tagset at the same time.
> > 
> > 1 doe not make any difference in the 0s based vs not values,
> > they just reduce the queue size by 1 intentionally.
> 
> Not sure who is they here...
> 
> Anyways, I guess we'll have to wait and see if someone happens to care
> if his/hers effective queuing is reduced by 1 all of a sudden...

All nvme transports require the host driver leave one queue entry unused.
The driver was not spec compliant prior to patches 1 and 2. I'm not sure
if that "queue full" definition makes sense for fabrics lacking a shared
ring, but the spec says we have to work that way.

