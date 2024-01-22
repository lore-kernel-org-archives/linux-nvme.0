Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7321C47DD3
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 18:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A13yq8YA9P7btlpsVloURXawHj0VC/8Br9wwxKDhRis=; b=DYY4+S4zAXJe+kfUvDnDdgZDvw
	irYuhgEvl8nAJr++/ATUb1VA7BI82eo0ZawstFO1sdGwMyxtK3+iWt61lLgubyO4b5L0liqfl8GMQ
	0ImsjkVTjJhYs2IEmdniOFwnnj+nfQ5vsTofsdyd5YauSC4lF2Y+ysZ/FIM4HUjYTiarKxfp7wjee
	kX4OgivtCOmNiNh8buqLSNFul6WwJMjDZ/YFTfep2s8fgoCLkRPWEZkyHhzNGfeHH+/b+05YFdYnU
	3Jqe0HqKvfFbuYGFWx7ODlHZgvc+dOdhIi/iLaRUHMvcDg9lyTcfeQ2EzHZykTo3gGlTqo96nnWRp
	NbeGyw+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRzCR-00DYvS-1w;
	Mon, 22 Jan 2024 18:39:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRzCO-00DYtB-3C
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 18:39:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D3F4F68BEB; Mon, 22 Jan 2024 19:38:57 +0100 (CET)
Date: Mon, 22 Jan 2024 19:38:57 +0100
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
Message-ID: <20240122183857.GA7029@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-6-hch@lst.de> <Za6zg-pA8IJkIb_b@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za6zg-pA8IJkIb_b@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_103909_189449_FC4F382A 
X-CRM114-Status: GOOD (  12.35  )
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

On Mon, Jan 22, 2024 at 11:27:15AM -0700, Keith Busch wrote:
> > +	q->limits.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
> > +	q->limits.max_discard_sectors =
> > +		min_not_zero(q->limits.max_hw_discard_sectors,
> > +			     q->limits.max_user_discard_sectors);
> 
> Shouldn't writing 0 disable discards?

I mirror the max_user_sectors behavior here, where 0 disables the
user limiting.  But yes, that would be a behavior change.

