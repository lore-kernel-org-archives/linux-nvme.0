Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAD1E7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 07:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BCsDIPqWJtUePPmB+Ol4o+scGQlI/dbcDUgBhMt+gpE=; b=Y2rDTIUSDPHOfwQTco6WRKgbnu
	741+qOmxzwUSxHpJeNj5Hni0kcXObDRhLvUPg1X4o2anlnYC0U25tRNeMV+jls62hmoHDoa1OogeB
	Wdm9HxOTgrDQBQC2RkZbOW4wQtfGnure6ZcdUTCYlzIzaUnxRqtlomfDuGJJSdm8+3Rbk/boxjDZo
	C2ozumDyxHa8K2ottRCxb0BBCD4PsOJ2WAX9PJCdXHt94r86d2g1jZjbfnbalEjpJsny+ECiphev+
	U0VcsPxfEkJENmXHY8TF9UMhpVhFgaTq4TcP8+kaG5eIZzoqgE819NerZn5GXioPYTJhEPXyPa9l0
	6s2sEVUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKuWj-0000000AXAH-3X5C;
	Tue, 10 Dec 2024 07:19:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKuWh-0000000AX9X-0pbY
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 07:19:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 20BEC68C4E; Tue, 10 Dec 2024 08:19:18 +0100 (CET)
Date: Tue, 10 Dec 2024 08:19:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCHv12 00/12] block write streams with nvme fdp
Message-ID: <20241210071916.GC19956@lst.de>
References: <20241206221801.790690-1-kbusch@meta.com> <20241209125511.GB14316@lst.de> <Z1cVx-EmaTgdFgVN@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1cVx-EmaTgdFgVN@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_231923_377984_B77FB285 
X-CRM114-Status: GOOD (  23.38  )
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

On Mon, Dec 09, 2024 at 09:07:35AM -0700, Keith Busch wrote:
> Yep, pretty much. I will revisit the partition mapping. I just haven't
> heard any use cases for divvying the streams up this way, so it's not
> clear to me what the interface needs to provide.

Yes, it would be good to understand use cases first.  I just threw the
patch in as a POC to show we can do it.

> > One thing that came I was pondering for a new version is if statx
> > really is the right vehicle for this as it is a very common fast-path
> > information.  If we had a separate streaminfo ioctl or fcntl it might
> > be easier to leave a bit spare space for extensibility.  I can try to
> > prototype that or we can leave it as-is because everyone is tired of
> > the series.
> 
> Oh sure. I can live without the statx parts from this series if you
> prefer we take additional time to consider other approaches. We have the
> sysfs block attributes reporting the same information, and that is okay
> for now.

I'll try to find some time this afternoon for an interface, but if it
doesn't arrive in time we can probably drop if for the next submission.

