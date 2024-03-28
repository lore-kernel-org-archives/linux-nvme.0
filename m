Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602CAC54E64
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 04:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mHB3T9nRALK8TzF3uU7lqnCT+S9O8I1GoxjejVW74Us=; b=zkTUreGpXjPe3Xn0mu32P/HKeb
	oKDRZnRNLdT4pjz0oDgkb2J+H8upO+Lsc4QTd8SouxjbcJiRgj8fFBZJzIO1RZilq09guskjKky/r
	3ZCNfNPsLLxwG+CJF67RsfjomtnGdiCHnPVzMgCdM7OxUdZv37lTGmQWTumsT+d4g9n1vn5VBHVVb
	kMX7e3ZTG9Vu1RYjRF8jzEdIABDzpMn8hP0/6brCY9ceowLKja5Ab5CbEeYRgv7cU3a6V4reVoQUA
	jFLK6L4/HfKtsbH93GjhHdAieudquFrkstFrwYdmN1YmEC0jdhCTBzwKm6ioa874ssNGaKI6esRSX
	79kPmoGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rphi5-0000000CRCA-3zdd;
	Thu, 28 Mar 2024 04:49:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rphi2-0000000CRAs-2WQ3
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 04:49:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F3A8268B05; Thu, 28 Mar 2024 05:49:47 +0100 (CET)
Date: Thu, 28 Mar 2024 05:49:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 10/30] block: Fake max open zones limit when there
 is no limit
Message-ID: <20240328044947.GB14113@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org> <20240328004409.594888-11-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328004409.594888-11-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_214950_971515_93C33EA7 
X-CRM114-Status: GOOD (  15.12  )
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

On Thu, Mar 28, 2024 at 09:43:49AM +0900, Damien Le Moal wrote:
> For a zoned block device that has no limit on the number of open zones
> and no limit on the number of active zones, the zone write plug free
> list is initialized with 128 zone write plugs. For such case, set the
> device max_open_zones queue limit to this value to indicate to the user
> the potential performance penalty that may happen when writing
> simultaneously to more zones than the free list size.

Setting max_open_zone needs to go through the queue limits API and
be done on a frozen queue (probabaly my merging it into the other
assignments done later in zone revalidation that are done with
the queue frozen).

