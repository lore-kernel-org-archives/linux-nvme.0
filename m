Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A38C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 01:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jn+LE2R+FPfxhQJ8o/DAUFaXpzIyjEuNUZnOJVwGh+E=; b=4h0tSJXjjk4Za0Cg1X/3/KJFD9
	p8BNrEZFZontvRC0/qr5TOhXyV+ToLoH7DMpjWv2tVNSLYLheKo5i+JOcPJy/mUBXCsPiHIwlvMqa
	uPepXk4GyjGzqjaZ1Ry+OZxqQY/PbCseZJfIiVLWbusYGaBwyFsFaGA21LIIKfaSQ2POGw4xVNT+6
	wwBoVF4pL9tK4seZMxHWvNes4z1kAjj0erRDQ2uniMoG04ndGuyc6w6l3Uh8k82ZziTlcTDaSfqeB
	hOvtIoARkTmOMrgTSfxftlw6oqmKXlXUPJwtBG7EeEKSuqeU+p350XU5bnFfZBq7BnderOzkmEQqZ
	omRSgarg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKVZb-008fPH-Qo; Thu, 17 Feb 2022 01:27:07 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nKVZa-008fP4-N5; Thu, 17 Feb 2022 01:27:06 +0000
Date: Wed, 16 Feb 2022 17:27:06 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 joshi.k@samsung.com, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, metze@samba.org
Subject: Re: [PATCH 3/8] fs: add file_operations->uring_cmd()
Message-ID: <Yg2kajMhJs0j8wcw@bombadil.infradead.org>
References: <20210317221027.366780-1-axboe@kernel.dk>
 <20210317221027.366780-4-axboe@kernel.dk>
 <20210318053832.GB28063@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318053832.GB28063@lst.de>
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

On Thu, Mar 18, 2021 at 06:38:32AM +0100, Christoph Hellwig wrote:
> On Wed, Mar 17, 2021 at 04:10:22PM -0600, Jens Axboe wrote:
> > This is a file private handler, similar to ioctls but hopefully a lot
> > more sane and useful.
> 
> I really hate defining the interface in terms of io_uring.  This really
> is nothing but an async ioctl.

Calling it an ioctl does a disservice to what this is allowing.
Although ioctls might be a first use case, there is nothing tying the
commands to them.

  Luis

