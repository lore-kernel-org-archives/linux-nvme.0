Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCA0E77198
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 15:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=raIBaOod1xMyefMLxYPEWUE5sm5+Gx56uqpvRyIpdsA=; b=xEAXdKmtPRylnUNKcW7MAXFsHv
	gLDC1uga0iDWvpMGs0/HltF9XYNw85RrBkX6zAnHuMciClClUMXMLeuyUwZeBz7AA4IS/AC8P4CjM
	HWDXLg/gKh5DX7fHnl5JbVAVkPKiD0SYnRp7XvPNo3KCJE2bcNq/e79ftBZkjzP4Dajoxu8GT9ct3
	f74cOASK05r/gxdT5I8CYO5Ld1jmQ18esspltQRFVYGn5+cQiyhNsUZ9feMfOunQjZhGVDAYrnb/B
	MP/qi4/FC1pYUw4/hSKUSwEDUK/q12zPidCnVcPbYzpJNn2I7uCB9X5f+GlDiRgoIayWOdfNJ+f+v
	w9DS7Ezw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUp3e-00000001mCW-33gz;
	Mon, 06 Jan 2025 15:30:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUp2v-00000001m43-0SSr
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 15:29:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 20E4F68C7B; Mon,  6 Jan 2025 16:29:32 +0100 (CET)
Date: Mon, 6 Jan 2025 16:29:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 1/3] block: Fix sysfs queue freeze and limits lock order
Message-ID: <20250106152931.GC27431@lst.de>
References: <20250104132522.247376-1-dlemoal@kernel.org> <20250104132522.247376-2-dlemoal@kernel.org> <Z3tOn4C5i096owJc@fedora> <20250106082902.GC18408@lst.de> <Z3u7Twc4UPWvlfJJ@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3u7Twc4UPWvlfJJ@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_072937_290957_3BA5F440 
X-CRM114-Status: GOOD (  21.77  )
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

On Mon, Jan 06, 2025 at 07:15:27PM +0800, Ming Lei wrote:
> On Mon, Jan 06, 2025 at 09:29:02AM +0100, Christoph Hellwig wrote:
> > On Mon, Jan 06, 2025 at 11:31:43AM +0800, Ming Lei wrote:
> > > As I mentioned in another thread, freezing queue may not be needed in
> > > ->store(), so let's discuss and confirm if it is needed here first.
> > > 
> > > https://lore.kernel.org/linux-block/Z3tHozKiUqWr7gjO@fedora/
> > 
> > We do need the freezing.  What you're proposing is playing fast and loose
> > which is going to get us in trouble.
> 
> It is just soft update from sysfs interface, and both the old and new limits
> are correct from device viewpoint.
> 
> What is the trouble? We have run the .store() code without freezing for
> more than 10 years, no one report issue in the area.

No, we had various bug reports due to it, including racing with other
updates.  Let's stop trying to take shortcuts that will byte us again
later and sort this out properly.


