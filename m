Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD0BCCD1BE
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 06:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JgVwjB7aiRoDdE5H2f9ktuOrYc8NDTeWF04TCDO/NWI=; b=pXle0ji9qIUz5JW5+FBwfS8/EN
	ZhqF5O1I4TCESPr55tlmEo8+oBGrnlqVwg3y3zMNNT9acwGDCG7vKlyyrO4b6B8DtEwiNMFAevz4Z
	fPEoNRNoV3v5VtVqvHVuTabwAv6kUnBGKR9jsZ1lXi9qpaykGUCOW4Pk2BN6PTUR/mvh6w853Nqc5
	1+vJgacIxseo2d7Xi4YcEFWtA+q0/Hdbuv6SaY7lHM+/B6L2ZswP8Jx1Y8rH4O1QnOZ+Zjgqs6cU/
	ZOpk1a2swxZbLF/y/oioxPthPiHZgB4DiHRZgFaxvAhX/xcf+LmbSqJa8+Xvpud4cqMvzO55Q+Jjs
	mZYzIL3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSJ0-00000001eo8-3kSr;
	Wed, 22 Oct 2025 06:26:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSIy-00000001enm-3t5G
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 06:26:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 21F2A227A88; Wed, 22 Oct 2025 08:26:35 +0200 (CEST)
Date: Wed, 22 Oct 2025 08:26:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] nvme-pci: Print error message on failure in
 nvme_probe
Message-ID: <20251022062634.GA4790@lst.de>
References: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com> <20251020-nvme_probefail-v1-1-a420046d98f0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-nvme_probefail-v1-1-a420046d98f0@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_232641_128982_45E469F5 
X-CRM114-Status: GOOD (  14.07  )
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

On Mon, Oct 20, 2025 at 05:29:07PM +0200, Gerd Bayer wrote:
> Add a new error message like
> nvme nvme0: probe failed on 2004:00:00.0 (result: -19)
> that makes failures to probe visible in the kernel log.

Is that really a thing drivers are expected to do?  If it is generally
usefull I'd expect it to be in the driver core.

Also for nvme most "interesting" errors happen in the reset workqueue
and not in ->probe itself.

