Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84026C27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 05:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7GOq09YPV5WKvKiqDxdCpSznJOrv/nBzOVzuKrdTRsk=; b=fM10S79MkAD5nXy2S3r3ay3L+p
	TUvt3kG7rUhxqAE49XYPZFjW/6EkTw3e2KqmGyYGkMHC1OWQjHlvhAeuKPBGb5zPPowFcufMSKc7x
	qgIricf4ii9VzuYFs7vN9KR//C7i26R2DCv3i2L1AnnLwUWfUH6zS9/zN7iI6Sqr2UBzhl84frL/N
	Oqr5hQy8SFfvcK6dZTeydxF6pSHFgIdtthbsiC1Hv6pm6aMNSyEvp1MOLY6wN8Tg6nW0rnrfCr8aN
	uHPnaLKv31WMCa1xugEeF5vvUL4N8ybdbsa6TuJNLlCdbTE02UynBU6RseR1mLRweQ7989rXgPC8t
	kXaWzNBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sML7I-00000005RkG-16Me;
	Wed, 26 Jun 2024 05:22:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sML7D-00000005Rht-3b0Q
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 05:22:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 04B43227A87; Wed, 26 Jun 2024 07:22:39 +0200 (CEST)
Date: Wed, 26 Jun 2024 07:22:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
Message-ID: <20240626052238.GC21996@lst.de>
References: <d7ae00c8-c038-4bed-937e-222251bc627a@acm.org> <20240604044042.GA29094@lst.de> <4ffad358-a3e6-4a88-9a40-b7e5d05aa53c@acm.org> <20240605082028.GC18688@lst.de> <CGME20240624105121epcas5p3a5a8c73bd5ef19c02e922e5829a4dff0@epcas5p3.samsung.com> <6679526f.170a0220.9ffd.aefaSMTPIN_ADDED_BROKEN@mx.google.com> <4ea90738-afd1-486c-a9a9-f7e2775298ff@acm.org> <de54c406-9270-4145-ab96-5fc3dd51765e@kernel.org> <b5d93f2c-29fc-4ee4-9936-0f134abc8063@acm.org> <05c7c08d-f512-4727-ae3c-aba6e8f2973f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05c7c08d-f512-4727-ae3c-aba6e8f2973f@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240625_222244_108049_A10D9148 
X-CRM114-Status: GOOD (  13.93  )
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

On Wed, Jun 26, 2024 at 06:18:18AM +0900, Damien Le Moal wrote:
> 
> DM can deal with "abnormal" BIOs on its own. There is code for that.
> See is_abnormal_io() and __process_abnormal_io(). Sure, that will need more code
> compared to a bio sector+size based simple split, but I do not think it is a big
> deal given the potential benefits of the offloading.

It's not just dm.  You also need it in the partition remapping code
(mandatory), md (nice to have), etc.

And then we have the whole mess of what is in the payload for the I/O
stack vs what is in the payload for the on the wire protocol, which
will have different formatting and potentially also different sizes.

