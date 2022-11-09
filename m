Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0925C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 06:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wYJT4SSAWZ3yO4LbgN35yeFQWA0Xc1NaS26FOMl7Nt8=; b=Q6OsNtZ0z9HUrdMaQtsFQ6lknB
	g0uhqutOrKstb4xBHPfBYTuhmDn/13JDbJvBdXjxf4z+GbZa4pjjokby28/j+viAWiap1NtMFSOjd
	HD3pAd5yGPdKM00pO3uS4+dZuOQ8zVtE2qFQqtOZ/XlCGZiAci0ZWsBFNEl9wHXS6dxczQTZu9r0X
	o56Np5mW1qcigF+jZMhYDwIdpJUDb6P4WWRM4k6jp0K+d8/QXYQ/nwWD+5idCAzbyFe1zee2WIsOc
	He7SL7vhw2wULwTEmjgy6VbgVfv5MQyN69JBqfF0oqssLmHw3hzo6+nyWdP+rgMAGorlArG3eMW1/
	2tu2i4jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oseSH-00B6Ww-4s; Wed, 09 Nov 2022 06:20:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oseSA-00B6W0-L3
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 06:20:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1613B68AFE; Wed,  9 Nov 2022 07:20:43 +0100 (CET)
Date: Wed, 9 Nov 2022 07:20:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Gerd Bayer <gbayer@linux.ibm.com>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: nvme-pci: NULL pointer dereference in nvme_dev_disable() on
 linux-next
Message-ID: <20221109062042.GB10528@lst.de>
References: <fad4d2d5e24eabe1a4fcab75c5d080a6229dc88b.camel@linux.ibm.com> <20221108074846.GA22674@lst.de> <Y2qQk/LuiNNdmdRD@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2qQk/LuiNNdmdRD@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_222050_852733_1B351E2A 
X-CRM114-Status: GOOD (  11.22  )
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

On Tue, Nov 08, 2022 at 10:23:31AM -0700, Keith Busch wrote:
> This looks good to go. I vote apply for 6.1, and we should consider
> merging your larger refactor for 6.2 after more test/review.

The problem doesn't exist yet in 6.1, it is caused by the recent
quiesce rework.

