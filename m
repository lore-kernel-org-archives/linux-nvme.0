Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F6FC4828E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 04:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mKOKNQYLzQOWCuNLs+2ssB47fBCYYi1E6aJgiN3/y3Q=; b=TAPgsArlzgO31sGtGT26k1Y4jr
	jmN2CRI2i958XbFzZJtYN/edjD3lDPos3S/KstThM6D9HyzpvkMw0S/+d5mA2rN02TXjq6P3pgANW
	Cv6/oYf2rCteUVPc34crSJI7ucqcW3/UpFXo9Wf8UjWxVDsvUjNaIFwhrPm+tJuH93GZ6NjYRSMl0
	36/yb4T+I2vNm6nKekVI8BYc3zHFpFuNjislO3eGeNZ9pxnt7pAbmWy8fSCR1XMkfNDMslJO9FC+3
	IMVQvBxLCD8tAkfG3IvwcItriwrpopiM22o7k9JsrBfS0KbuuPYeJ3HX199gJieIY8NgGuTWorWJI
	IQ/Ls2Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVOWq-00000006Tfi-04cP;
	Thu, 01 Feb 2024 04:18:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVOWn-00000006TfB-1azm
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 04:18:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E9EDF68AFE; Thu,  1 Feb 2024 05:18:10 +0100 (CET)
Date: Thu, 1 Feb 2024 05:18:10 +0100
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
	linux-nvme@lists.infradead.org, virtualization@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 05/14] block: add a max_user_discard_sectors queue limit
Message-ID: <20240201041810.GA13766@lst.de>
References: <20240131130400.625836-1-hch@lst.de> <20240131130400.625836-6-hch@lst.de> <ZbrngpaAisIJGQ0T@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbrngpaAisIJGQ0T@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_201817_595800_CD277C81 
X-CRM114-Status: GOOD (  12.51  )
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

On Wed, Jan 31, 2024 at 05:36:18PM -0700, Keith Busch wrote:
> > +	q->limits.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
> > +	q->limits.max_discard_sectors =
> > +		min_not_zero(q->limits.max_hw_discard_sectors,
> > +			     q->limits.max_user_discard_sectors);
> 
> s/min_not_zero/min

Yes.  Fixed up right after when converting to the limits based update,
but this does create a bisection hazard as-is.


