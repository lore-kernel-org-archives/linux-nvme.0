Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A0ACF34A4
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2024 12:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xl6YQ2xTePOPYj0gr0LM0wS8u4/Jvqs51RnNJ9BfHAo=; b=mYWr/4WHpmmw9JxHgqRI8kQp80
	s3CDEAeO2DBMUNw/ga57C+jZTp3OEfLKG0NyXWmkwLL3opctClrr+vTRHGUqmLd3wnvJy0n6sBmvJ
	foAkQ6x5+wqlh69B2WPsPBletFj5xlOj66J5doLzv+/DZqa48QF6MhTg9c44pFBTSFtdNrzSqv3/A
	b1X7o/Ebs2eMMNA3WV9apro8n3/Yt3PYALylugCuvHLm3N4edrPmUT97OKSFd8Y0exXoqeDmvVgiu
	+BItdaas1638V7KVCI+hsk15hfX4ILhDtHnLX0XO27PtnPBdwgkcohZPPdJsUHv5B2sZFtd91I39b
	YZUoOrFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swLMZ-000000094xc-1lnC;
	Thu, 03 Oct 2024 12:55:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swLMV-000000094v7-27BQ
	for linux-nvme@lists.infradead.org;
	Thu, 03 Oct 2024 12:55:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BBB5E227A88; Thu,  3 Oct 2024 14:55:16 +0200 (CEST)
Date: Thu, 3 Oct 2024 14:55:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
	hare@suse.de, sagi@grimberg.me, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, asml.silence@gmail.com,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-aio@kvack.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241003125516.GC17031@lst.de>
References: <20240930181305.17286-1-joshi.k@samsung.com> <20241001092047.GA23730@lst.de> <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk> <20241002075140.GB20819@lst.de> <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk> <20241002151344.GA20364@lst.de> <Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com> <20241002151949.GA20877@lst.de> <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com> <a8b6c57f-88fa-4af0-8a1a-d6a2f2ca8493@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8b6c57f-88fa-4af0-8a1a-d6a2f2ca8493@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_055519_967990_3E75E8DC 
X-CRM114-Status: GOOD (  13.89  )
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

On Wed, Oct 02, 2024 at 11:34:47AM -0700, Bart Van Assche wrote:
> Isn't FDP about communicating much more than only this information to
> the block device, e.g. information about reclaim units? Although I'm
> personally not interested in FDP, my colleagues were involved in the
> standardization of FDP.

Yes, it is.  And when I explained how to properly export this kind of
information can be implemented on top of the version Kanchan sent everyone
suddenly stopped diskussion technical points and went either silent or
all political.

So I think some peoples bonuses depend on not understanding the problem
I fear :(


