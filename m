Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C6DD3399F
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 16:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UMiXgZ6viG7C/6Xl5fTOcvKfG5Ia+9iJj7mrS8gFGRA=; b=PYqw0mZhrKdjo01UdI7Q4gG/yC
	OO56geeFveRhc1ZnVuDJzFT1jG0IH39RSB7nJy8JykT+CYP4LUHdUUVbMPBoj9JyQAuFXYaS9pxnV
	vP1INCfwtZJZRbqy03OTkbniVM+KCQql5rIVUlzRTcacyqzfd8iAP3x7F6EHCBVbgRbk1CAPu09gF
	J6KSSYKmATiz0zvDxcrizmlRUOOjPQSdQ+ly5ajhqkFcy4GKR3/dV+hOuX59Q5aybWFCuWHU82W53
	Xop46tedbI3QfA6ddWDy/iIEkKpg3PDmZ43oVx/k2JeocyGD1r0mskKzEoXeADs24b36p1PE6g5Il
	h3620ROg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5SkN-0000000BVqM-3vkY;
	Mon, 28 Oct 2024 16:37:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5SHu-0000000BQV0-3hk7
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 16:08:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7922068BEB; Mon, 28 Oct 2024 17:08:08 +0100 (CET)
Date: Mon, 28 Oct 2024 17:08:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org
Subject: Re: [PATCHv9 4/7] block, fs: add write hint to kiocb
Message-ID: <20241028160808.GA28077@lst.de>
References: <20241025213645.3464331-1-kbusch@meta.com> <20241025213645.3464331-5-kbusch@meta.com> <20241028115932.GE8517@lst.de> <Zx-hzSwkkUMeuA5C@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx-hzSwkkUMeuA5C@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_090815_088041_7CAE0F24 
X-CRM114-Status: GOOD (  18.95  )
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

On Mon, Oct 28, 2024 at 08:38:05AM -0600, Keith Busch wrote:
> > > +	if (bdev_is_partition(bdev) &&
> > > +	    !test_bit(hint - 1, bdev->write_hint_mask))
> > > +		return file_inode(iocb->ki_filp)->i_write_hint;
> > 
> > I would have expected an error when using an invalid stream identifier.
> 
> It's a hint. fcntl doesn't error if you give an unusable hint, so
> neither should this. You get sane default behavior.

Well, why does it have to be a hint?

If I have a data placement aware application I really want to know
into how many buckets I can sort and adjust my algorithm for it.
And I'd rather have an error checked interface to pass that down
as far as I can.

Same for my file system use case.  I guess you have a use case where
a hint would be enough, at least with good enough knowledge of the
underlying implementation.  But would there be an actual downside
in not having a hint?  Because historically speaking everything we've
done as a not error checked vaguely defined hint has not been all
the useful, but it in hardware or software interfaces.

