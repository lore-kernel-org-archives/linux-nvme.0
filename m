Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE4EC41513
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 05:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yki2d10VIN6kSyd4ufUs2LVg6lXNlPgZwbFomvhVCdw=; b=RuWliv6/rTxjdanGF5tSENS78h
	0s8WwzuI0/0g2clbRFySjtj3RxGLEFTVCAjATNpl/iyD6kxrKSMAoChIPS9MCyj8l9MTdRmMPj8Cb
	hQI5OoOLvMJJW0P0+D8U5x5zUAfK9OmFonEbV7eQVeLtgivgFPqJF2oWXcz9y/Phe0j28gSldK8z3
	bdO4MmvjmftmZZmDX75PkUQ30q9gZU9CyKCU9Z9uvm/k9awWUq22QTqgJ1GyK3pc7LnYHF0U4D7Ld
	a+SZ5i3pDjT88TbdZ8UEr2kUIlP049J8SdvzHxKui1PLzR1YV4zzNYyiHhq/h7EhjozYruiPvuQ0h
	CM2SkdpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHGFw-0000000B6gQ-26fo;
	Wed, 12 Jun 2024 05:10:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHG48-0000000B594-2x6V;
	Wed, 12 Jun 2024 04:58:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6FC9B68BFE; Wed, 12 Jun 2024 06:58:28 +0200 (CEST)
Date: Wed, 12 Jun 2024 06:58:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
	drbd-dev@lists.linbit.com, nbd@other.debian.org,
	linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 16/26] block: move the io_stat flag setting to
 queue_limits
Message-ID: <20240612045828.GC26776@lst.de>
References: <20240611051929.513387-1-hch@lst.de> <20240611051929.513387-17-hch@lst.de> <d51e4163-99e3-4435-870d-faef3887ab6a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d51e4163-99e3-4435-870d-faef3887ab6a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_215833_062175_E229A59E 
X-CRM114-Status: GOOD (  16.91  )
X-Mailman-Approved-At: Tue, 11 Jun 2024 22:10:40 -0700
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

On Tue, Jun 11, 2024 at 05:09:45PM +0900, Damien Le Moal wrote:
> On 6/11/24 2:19 PM, Christoph Hellwig wrote:
> > Move the io_stat flag into the queue_limits feature field so that it
> > can be set atomically and all I/O is frozen when changing the flag.
> 
> Why a feature ? It seems more appropriate for io_stat to be a flag rather than
> a feature as that is a block layer thing rather than a device characteristic, no ?

Because it must actually be supported by the driver for bio based
drivers.  Then again we also support chaning it through sysfs, so
we might actually need both.  At least unlike say the cache it's
not actively harmful when enabled despite not being supported.

I can look into that, but I'll do it in another series after getting
all the driver changes out.

