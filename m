Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C117C87FDC
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jun 2023 04:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jeVnrOV1EV2Jv8KgTlC0B4lqR8S0n0kMPSfRktLMFwI=; b=3FPop73doeOC1X7zHqHzKWASSI
	o6jpnqUtJBGQ6ZpBSCpJfdRasqcVp6IG1IDCGAE0+3YoUsHGknpj12DPMNshuiD/fYmXZCQUm8l+M
	lUUbjMd0l7yfTSdvqdI9Yb4y0aCLaeajPmUx0Yi/j1nZ5SGUDiicFRwqJ+YPDubtbCjL/ZpvhTRcJ
	HAZR39VnRI25XA1VMjVLYuVbwy5twX+VbTU4fxJPeYNvP7YuGAZiGsukebD/UFytBn09zMZbrIl/x
	hYv4hS918tHOKDr5XYYvB2FNOeH+afSC67K0Be4SH0GCUbu8hXbAMVOIfVfAWAgc9SLMz0b1tKKXx
	BdM8YweQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7Tib-00BasM-14;
	Fri, 09 Jun 2023 04:27:21 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1q7Tfy-00BaXx-39;
	Fri, 09 Jun 2023 04:24:38 +0000
Date: Thu, 8 Jun 2023 21:24:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, linux-scsi@vger.kernel.org,
	willy@infradead.org, hare@suse.de, djwong@kernel.org,
	bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
	nitheshshetty@gmail.com, gost.dev@samsung.com,
	Kanchan Joshi <joshi.k@samsung.com>,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v12 5/9] nvme: add copy offload support
Message-ID: <ZIKphgDavKVPREnw@infradead.org>
References: <20230605121732.28468-1-nj.shetty@samsung.com>
 <CGME20230605122310epcas5p4aaebfc26fe5377613a36fe50423cf494@epcas5p4.samsung.com>
 <20230605121732.28468-6-nj.shetty@samsung.com>
 <ZH3mjUb+yqI11XD8@infradead.org>
 <20230606113535.rjbhe6eqlyqk4pqq@green245>
 <ZIAt7vL+/isPJEl5@infradead.org>
 <20230608120817.jg4xb4jhg77mlksw@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608120817.jg4xb4jhg77mlksw@green245>
X-Mailman-Approved-At: Thu, 08 Jun 2023 21:27:20 -0700
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

On Thu, Jun 08, 2023 at 05:38:17PM +0530, Nitesh Shetty wrote:
> Sure, we can do away with subsys and realign more on single namespace copy.
> We are planning to use token to store source info, such as src sector,
> len and namespace. Something like below,
> 
> struct nvme_copy_token {
> 	struct nvme_ns *ns; // to make sure we are copying within same namespace
> /* store source info during *IN operation, will be used by *OUT operation */
> 	sector_t src_sector;
> 	sector_t sectors;
> };
> Do you have any better way to handle this in mind ?

In general every time we tried to come up with a request payload that is
not just data passed to the device it has been a nightmare.

So my gut feeling would be that bi_sector and bi_iter.bi_size are the
ranges, with multiple bios being allowed to form the input data, similar
to how we implement discard merging.

The interesting part is how we'd match up these bios.  One idea would
be that since copy by definition doesn't need integrity data we just
add a copy_id that unions it, and use a simple per-gendisk copy I/D
allocator, but I'm not entirely sure how well that interacts stacking
drivers. 

