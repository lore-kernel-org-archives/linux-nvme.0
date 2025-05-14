Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9CDC3ABCC
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 14:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HSeLQgCeSnJO9MrfHW3OsAe0wmIEhjCN/0Vyr6nJ/sA=; b=2TypTuE+iRN3R0tbabNbHZLarm
	iKhpW8fJr6V702jTTV4NxY5rm/a33mBdF4EgAz7HNDGYY/e7tIcsHtphpCX46tR6JXmm75tifWi5l
	BBO1hY5VgUmriaQe4Bq7RZ8re2GDJT1sfqv1z9k2CHYUV0oXCfinNEUNXDmCBmIyF6u5cE4Yw1u06
	mFaQHA4FcknFLaVNQN5yWVobQicnEVck/9Io8XjeYE0mGFiFM6GbUU5ty+iiVBYOCnJbBAEwMZ1EM
	NwdSYTQcjPVn0UpnG00Go1UuAu9IUh6ass+nesM1wHCDfAnwRf2NlTl/Wp4uJyfSfmEz+R9Z0icSi
	O/daSybg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFDGJ-0000000FR9a-1wQk;
	Wed, 14 May 2025 14:39:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFCeV-0000000FLoI-3735
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 14:00:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E3FEC68AFE; Wed, 14 May 2025 16:00:00 +0200 (CEST)
Date: Wed, 14 May 2025 16:00:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Leon Romanovsky <leon@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/7] nvme-pci: use a better encoding for small prp pool
 allocations
Message-ID: <20250514140000.GB25649@lst.de>
References: <20250513070025.830930-1-hch@lst.de> <20250513070025.830930-6-hch@lst.de> <aCNf_rHaLdS-WTEO@kbusch-mbp> <20250514051221.GD24101@lst.de> <aCSVSecpQ63y7g_A@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCSVSecpQ63y7g_A@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_070007_919320_8F8D4DF7 
X-CRM114-Status: GOOD (  15.21  )
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

On Wed, May 14, 2025 at 07:06:17AM -0600, Keith Busch wrote:
> But if you are trying to merge dozens of requests with metadata into
> one, then yeah, the small pool isn't large enough to accomodate. If you
> want to support that use case, then we can certainly change the driver
> to use the large pool when more than 15 integrity segments are required.

Merge is one use case.  The other is to use non-contigous buffers for file
system PI support, as a single BIO with large folios can get quite huge,
and being able to either use vmalloc or multiple pages would be very
helpful there.

