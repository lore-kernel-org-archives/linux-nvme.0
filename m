Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76268ECAAD5
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Sep 2022 05:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L72YPnZCJh4XTV/mFZMIoFaf5AHd33GDFgqc5uCs2QM=; b=FsZWLLGPGGIh+AMv0X+SJpYgXy
	og/wW4L/rWjuI0KfS+gx8NJAnmfj0JD+w0r+ukaVYVDt43vvhKBy9dPe1FGsT0JRGx2VsDNR4bBWl
	uVI+nXQzyln0bKIt6rhUqZm48agdfvryCOh4LYwhxI7S9apEorWAmY1BmRUVABnBAs05LbOTPEgWO
	jKVDHPq2mkhHmu+bm8SeENsBD1Sa8MmiDE2hJbelH2KEhDhSDuYczpxj6zMN8acyv4VI5YPEo9rHi
	ouhYSOsLXLyDWwEqSsyGyoXaEzwy2XmXeKQg4wcZXt4AFN+VqVFW4DF3hbbXXf2lUPeWgThUkzMqr
	X/yB7jbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWt4z-006S9H-9A; Sat, 10 Sep 2022 05:30:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWt4w-006S4i-MK
	for linux-nvme@lists.infradead.org; Sat, 10 Sep 2022 05:30:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A536368AA6; Sat, 10 Sep 2022 07:30:45 +0200 (CEST)
Date: Sat, 10 Sep 2022 07:30:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Jonathan Derrick <jonathan.derrick@intel.com>,
	Revanth Rajashekar <revanth.rajashekar@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Guenter Roeck <linux@roeck-us.net>,
	Serge Semin <fancer.lancer@gmail.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-hwmon: Cache-line-align the NVME SMART
 log-buffer
Message-ID: <20220910053045.GA23052@lst.de>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru> <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220909_223054_895242_9F1D8488 
X-CRM114-Status: GOOD (  10.51  )
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

I think this will work, but unless we have to I'd generally prefer
to just split dta that is DMAed into into a separate allocation.
That is, do a separate kmalloc for the nvme_smart_log structure.

Guenter, is this ok with you?

