Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68E8C6FA83
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Sep 2022 14:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eGVLnUXdLTSfEezFqkimxWUYAr7YNEs1IRAv8HQhGUQ=; b=bdio9SxoLzNVJM/xmLJWy1bf8n
	i0hj+ys6uCOE4tmWlOA8DG0iz6rOx6Lxn0NOIUk8xy4IEVEy1OmkuqxI+DYhqsutGd/0qzarMCazX
	q00//TBabI949FjoviXdb7D7U22Tth8q3NjE+a/SRNx3qoKI11USrODCTA3iR4buUUX2oiaMNgfrc
	jHt9txzoGYXAsW8Z1gpP+IuulKBNStURY1jGlxHmdDELIP4O0BF3VJp0rJC8CpWvEH9myWaHxHFnU
	MUvVI9YnS5RFoFpYiCayzuV8yHw6pUr2GshtuZqS76Y4u4lfksnbAclZ+UmlGgtq8mrewQjjiqhe2
	bUugiLUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpHL-005Ovf-KZ; Mon, 26 Sep 2022 14:40:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpHI-005Osh-Ro
	for linux-nvme@lists.infradead.org; Mon, 26 Sep 2022 14:40:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 61F5068AFE; Mon, 26 Sep 2022 16:39:59 +0200 (CEST)
Date: Mon, 26 Sep 2022 16:39:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Revanth Rajashekar <revanth.rajashekar@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Guenter Roeck <linux@roeck-us.net>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-hwmon: Cache-line-align the NVME SMART
 log-buffer
Message-ID: <20220926143959.GA19918@lst.de>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru> <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru> <20220910053045.GA23052@lst.de> <20220910123542.tzxg2blegw55z5fj@mobilestation> <20220912082909.GA10666@lst.de> <20220925222325.irltbraf4e2j4vtq@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220925222325.irltbraf4e2j4vtq@mobilestation>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_074013_086142_9A8C657E 
X-CRM114-Status: GOOD (  13.35  )
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

On Mon, Sep 26, 2022 at 01:23:25AM +0300, Serge Semin wrote:
> IMO both the approaches seem unclear if a reader doesn't know what
> they have been introduced for. Anyway do you insist on using the
> kmalloc-ed buffer here instead? If so I'll resubmit the series with
> this patch updated accordingly.

I don't like the __aligend version too much, but I can live with it if
you strongly prefer it.

