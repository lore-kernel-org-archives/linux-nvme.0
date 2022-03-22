Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FEFC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 08:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bfnkf14SMvXLEDpYtnyFXWgBJkrPXdNS6f5tqJz2CVQ=; b=TWa1qVFRABbZuL0xOELTOUMvWQ
	vZaMXpFBaDKHlEdyF91F7HYV5F8cs4hWKPn+CoC8sB0NFnAei32ZR3FCqxCWvGlQ2M/8Cw5f1S76/
	RWSj2jM9XTUd5nZ0/JSUeIQl/AWJ4/gvU5m8k1cYc9vDqxBNHffBiwjVD9hTVkmsOHWZFSDblONv2
	cmXrPFBgsMlRO3mUoC4ZE2mfq0F04T2z12BEpbE2yh3HBJDKltacELJ3cQx+bW9LfV8qmazNdXMh9
	0eA2xN0/7X/EpzadWZ+f1QxKq7pf2jh4nCORFjCfEfn/EHgGQ439TODOKd6swoc1adOoDSrfcGHVv
	u6N5zT2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWa34-00ARm2-O7; Tue, 22 Mar 2022 08:39:26 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWa31-00ARlL-R0
 for linux-nvme@lists.infradead.org; Tue, 22 Mar 2022 08:39:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8908E68AFE; Tue, 22 Mar 2022 09:39:14 +0100 (CET)
Date: Tue, 22 Mar 2022 09:39:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 kanchan Joshi <joshi.k@samsung.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: Fix zns drives without append support to
 export correct permissions
Message-ID: <20220322083914.GA26494@lst.de>
References: <CGME20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180@eucas1p2.samsung.com>
 <20220316093423.17906-1-p.raghav@samsung.com> <20220316105016.GA9393@lst.de>
 <72344561-a6fd-bb61-bed1-3aa12bd8cc02@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72344561-a6fd-bb61-bed1-3aa12bd8cc02@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_013924_062380_D7A7C2FF 
X-CRM114-Status: GOOD (  21.46  )
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

On Wed, Mar 16, 2022 at 03:28:30PM +0100, Pankaj Raghav wrote:
> Hi Christoph,
> 
> On 2022-03-16 11:50, Christoph Hellwig wrote:
> > On Wed, Mar 16, 2022 at 10:34:23AM +0100, Pankaj Raghav wrote:
> 
> >> -		test_bit(NVME_NS_FORCE_RO, &ns->flags));
> >> +	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO));
> > 
> > This will now set a namespace that was read-only due to unsupported ZNS
> > features writable during revalidation.
> 
> >>  	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
> >> +	nvme_set_disk_mode_ro(ns);
> 
> > And this will set a disk that is read-only due to NVME_NS_ATTR_RO
> > writable if the controller supports all essential ZNS features.
> You are right, this is not the right way to fix it.
> 
> What do you think about setting the disk permission after the disk info?
> That won't introduce any race and also makes sure all parameters are
> correctly set:

I don't think we really need the nvme_set_disk_mode helper,  but we
also need this call for the multipath disk.

Otherwise the approach looks good to me.

