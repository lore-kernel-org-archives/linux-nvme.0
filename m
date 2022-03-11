Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759B8C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 22:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CORCsW85L9pqGOpLrx1bc5XyZ9E33aiq8UjLnt/1kLQ=; b=EocmtEZg+Xla6vKnUiBiiiDveH
	VTtPE5IbjMLZxSI9Qvr3+fluC8wGQY1R53Ct9B9chN8n3jmlK8xI1OaO5U7NSy9DTFFWpUWrdkVwp
	IS99zZBP4tCQdH4jue9wcRiIl5cO6XG2EVOZhmi6FUbgIRli8XBAXD99/EWTBXdZcqHSPyvDVybD/
	ty0iWfh5NuDFdU3vu++xj3waKBYXAeB5TGOVVocQ962G1mh1jH65okScBWxG62GkufZudS1gvbU4J
	0j8z1QQ5Ha0yzlIVl6aeQnodZPeYSA/gfEe54u8bjoPIqTLGF98yIYqeDt25CwNIaXpeOXTPTh/Xv
	U5ElWh8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSng7-000O0g-Ty; Fri, 11 Mar 2022 22:24:07 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nSng6-000O0E-FW; Fri, 11 Mar 2022 22:24:06 +0000
Date: Fri, 11 Mar 2022 14:24:06 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <p.raghav@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 jiangbo.365@bytedance.com, kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
 Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <YivMBj7+j/EZcMVV@bombadil.infradead.org>
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com>
 <20220308165349.231320-1-p.raghav@samsung.com>
 <20220310094725.GA28499@lst.de>
 <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
 <20220310144449.GA1695@lst.de>
 <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
 <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
 <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
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

On Fri, Mar 11, 2022 at 01:31:02PM -0800, Keith Busch wrote:
> On Fri, Mar 11, 2022 at 01:04:35PM -0800, Luis Chamberlain wrote:
> > On Fri, Mar 11, 2022 at 12:51:35PM -0800, Keith Busch wrote:
> > 
> > > I'm starting to like the previous idea of creating an unholey
> > > device-mapper for such users...
> > 
> > Won't that restrict nvme with chunk size crap. For instance later if we
> > want much larger block sizes.
> 
> I'm not sure I understand. The chunk_size has nothing to do with the
> block size. And while nvme is a user of this in some circumstances, it
> can't be used concurrently with ZNS because the block layer appropriates
> the field for the zone size.

Many device mapper targets split I/O into chunks, see max_io_len(),
wouldn't this create an overhead?

Using a device mapper target also creates a divergence in strategy
for ZNS. Some will use the block device, others the dm target. The
goal should be to create a unified path.

And all this, just because SMR. Is that worth it? Are we sure?

  Luis

