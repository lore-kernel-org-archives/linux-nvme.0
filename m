Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC62C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 06:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WEiEqrKYRs3fSz3prNAWq9FwH6iEIRga+xKC1LvpndA=; b=qkIXvyvcOn9VgXp497zRejSlXY
	M31Y8LMgGSjQDOinTIyIbRZISKjpdsS/pdfuDXEsco/avLK8V/WQPn1SQJDW1cZNz5T3TaCfOISAy
	3a3eCn0a2wuB0/d9mkpE4gCw2zEO/WVhJeUW75whHq6Dttk9JkrsvXg/H46Yk4YrCDmG5UK+5qYim
	jrJ7PH/bjhKhY2OlLjSxPJ/irnAN7Q1R+zokoupatMCGwU6du55V+g7/3u1g/gSI4VYzACggqpPCD
	qJ87yfLDOGGnfetwMma5Q5D87oVJQrRKp/X7JUfqpcFg9ZtJqhizMHvzQ83Vx60sg2uzg8RGElIuU
	kRK7PPnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTe5s-003vlf-PO; Mon, 14 Mar 2022 06:22:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTe5k-003vkS-Dg
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 06:22:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5904468AFE; Mon, 14 Mar 2022 07:21:54 +0100 (CET)
Date: Mon, 14 Mar 2022 07:21:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Pankaj Raghav <p.raghav@samsung.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@edc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 kanchan Joshi <joshi.k@samsung.com>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Fix zns drives without append support to export
 correct permissions
Message-ID: <20220314062153.GA3007@lst.de>
References: <CGME20220311201638eucas1p18b9c5ecb3442b5a53bba233591d34db0@eucas1p1.samsung.com>
 <20220311201608.275384-1-p.raghav@samsung.com>
 <1bbc81a0-19f0-433b-28c2-b22d28176e37@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bbc81a0-19f0-433b-28c2-b22d28176e37@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220313_232204_649371_0D10C1A0 
X-CRM114-Status: GOOD (  12.71  )
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

On Sun, Mar 13, 2022 at 03:15:08PM +0200, Sagi Grimberg wrote:
> There is a call just above this, why add another call?

NVME_NS_FORCE_RO is set in nvme_update_zone_info, which is called after
nvme_update_disk_info.  I think the suggestion from Damien to move the
set_disk_ro call out of nvme_update_disk_info and directly into
nvme_update_ns_info so that it can be done later is the right thing to
do here.

