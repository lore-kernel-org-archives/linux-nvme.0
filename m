Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96957E7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 06:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=az2n4vRYsU266VQZUHWqUaGY9kt1sehPp2g8jjX1AoU=; b=YL8N8Wa3v7yrm/ciq+tng68nOJ
	w0X63RTMzlb5u1002+5wBPVswjhE21aBnE7/yjH29nv9QUKvyDfdP9bl+d7Gr/OTifLE67pqPwuDT
	H/ssgey/1UuqJD63Sl0OdqtNZcCvcZc47WXAbmpi6jDreGa8SX7pm67wm3kpaNfvVZz11G+bqKtnC
	EpagSdGJo4Pnr0Ya8qD+yDljShLYGv+E4tbduSDGSfvNnhiPq+XnLvl0rVAE/DQTFXHaf8jnkoVsJ
	UXMW0j3w+gfbRRw/PMVPgUXk6iJAqYTxoOykf+oHrxa7QOdnbyO/1d/zZ+XLiLB1WAKtU3R8Z20xu
	OZ2IUVGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLcKr-0000000H08m-44E3;
	Thu, 12 Dec 2024 06:06:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLcKp-0000000H08L-21Cw
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 06:06:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BF4A268D07; Thu, 12 Dec 2024 07:05:58 +0100 (CET)
Date: Thu, 12 Dec 2024 07:05:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv13 00/11] block write streams with nvme fdp
Message-ID: <20241212060558.GA5266@lst.de>
References: <20241210194722.1905732-1-kbusch@meta.com> <CGME20241211071358epcas5p11c75e89d15c153ea3a41c82a5171d9de@epcas5p1.samsung.com> <20241211071350.GA14002@lst.de> <bd53dbed-f6a9-4322-88b5-460f8e9885a0@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd53dbed-f6a9-4322-88b5-460f8e9885a0@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_220603_659725_294F35B0 
X-CRM114-Status: GOOD (  18.69  )
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

On Thu, Dec 12, 2024 at 11:21:07AM +0530, Kanchan Joshi wrote:
> On 12/11/2024 12:43 PM, Christoph Hellwig wrote:
> > The changes looks good to me.  I'll ty to send out an API for querying
> > the paramters in the next so that we don't merge the granularity as dead
> > code
> 
> What do you have in mind for this API. New fcntl or ioctl?
> With ability limited to querying only or....

Yes, new fcntl or ioctl, query the number of streams and (nominal)
stream granularity as a start.  There is a few other things that
might be useful:

 - check if the size is just nominal or not, aka if the device can
   shorten it.  FDP currently allows for that, but given that
   notifications for that are out of bounds it makes a complete mess
   of software actually trying to use it for more than simple hot/cold
   separation like cachelib, so we find a way to query that in the
   spec.
 - reporting of the remaining capacity per stream, although I'm not
   sure if that should be in the same ioctl/fcntl, or better done
   using a separate interface that has the stream number as input
   and the capacity as out, which would seem a lot simpler

