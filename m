Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44098C55160
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 11:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ruTePSnnSCvYyFByfbakbG1f3IFNsDvcH5EG7c//Tf4=; b=lOP3Ox75jDB6kluOrU8dO0Tykx
	gOfe4/Wzm4YglgpkG8UjmQ2EuE1fAKrsb4SIN0gryXwmGMQhTpjNVK1QWEmc5GkHS+NgNBHWJcodB
	e4jLE7Xs0seoBhIH6H/NeQwRoN3VxaAPATV+/N3hv442t1LfBctvk7mrk6Ve6H7OEKmYPBeyYRQRF
	1sRQxHM2d/Woe0HVxYeRnz7fAwO7Wyy985J0jQ/CSG2hQo8MGrJ5D6/w0fNoAnRwRU6IJLgOWKdv9
	ibxaty2Sk2XX3ZAGzCB5PGWz2aQoqN3sLd8Xtl3sVb/WIm1CZDpFmae9czUp06efbLaq/9u6CGNmk
	Kge9AQlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpP4q-0000000AMbX-3kXS;
	Thu, 30 Jul 2026 11:37:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpP4o-0000000AMax-1A1H
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 11:37:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CEAD268C4E; Thu, 30 Jul 2026 13:37:22 +0200 (CEST)
Date: Thu, 30 Jul 2026 13:37:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: clamp FDP placement handle count to the
 buffer size
Message-ID: <20260730113722.GD25454@lst.de>
References: <20260730043105.3071328-1-kanie@linux.alibaba.com> <CGME20260730051151epcas5p1c47d82291b2bd4437fcf14e7816c4c8e@epcas5p1.samsung.com> <20260730043105.3071328-5-kanie@linux.alibaba.com> <749b4476-6d8c-4573-b51b-662b0ff57db3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <749b4476-6d8c-4573-b51b-662b0ff57db3@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_043726_468653_D2918FCD 
X-CRM114-Status: GOOD (  15.13  )
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

On Thu, Jul 30, 2026 at 03:10:59PM +0530, Kanchan Joshi wrote:
> But I feel the need to improve (what we have) with a follow-up patch:
> 1. Revise the cap, from S8_MAX - 1 to U8_MAX; since bio->bi_write_hint 
> is u8.

Signed 8-bit -1 is indeed a really odd value, and from looking at the
original commit I'm not really sure how we arrived there.

> 2. And a dev_warn() to know if head->nr_plids go above the 
> kernel-defined cap. It's possible/fine for device to have more placement 
> ids, and if that happens, this can tell.

Yeah.


