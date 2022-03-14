Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F100C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 07:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AQlorQjpb94RJ4u1xjFTCZlWB3PpjRzEFBaNaT6R8Gs=; b=f0a0YWGCrl1zMP3fOTh/ci321a
	4ljjThWyoX70W0S9xJ9gvwRKQ6qZcBj08P0h0/vJKpPb+cmfGEs50WaazXPy1lMYWx4TBEWst3xYS
	pMEVae9W2aEwVcSD0QkDTBoNb0weZH6PbhW/yC6cfi/xnr2v6CYEQZhydMxulRjpPPUtqxztaBuV+
	/8IYt4osfqizJgiaTj1MFnnz6yuNULKncVKkFJ6UNNcBOEzs49mGcRvgvVmj0sIUxFjAErvSTZEYk
	D26BZXFUWAThMSPkBg2y4aSgLDYX7zAnX2pQ+0bP+/nt5W0DMFRtgLI9l4BJStmTnB1iKMzhh0IyJ
	DoWMvjeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTfKp-004BAr-T8; Mon, 14 Mar 2022 07:41:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTfEz-0047SG-VM
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 07:35:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D43EF68AFE; Mon, 14 Mar 2022 08:35:37 +0100 (CET)
Date: Mon, 14 Mar 2022 08:35:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Pankaj Raghav <p.raghav@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 jiangbo.365@bytedance.com, kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
 Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220314073537.GA4204@lst.de>
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <20220310094725.GA28499@lst.de>
 <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
 <20220310144449.GA1695@lst.de> <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
 <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
 <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
 <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_003542_256472_CFA7099C 
X-CRM114-Status: GOOD (  22.95  )
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

On Sat, Mar 12, 2022 at 04:58:08PM +0900, Damien Le Moal wrote:
> The reason for the power of 2 requirement is 2 fold:
> 1) At the time we added zone support for SMR, chunk_sectors had to be a
> power of 2 number of sectors.
> 2) SMR users did request power of 2 zone sizes and that all zones have
> the same size as that simplified software design. There was even a
> de-facto agreement that 256MB zone size is a good compromise between
> usability and overhead of zone reclaim/GC. But that particular number is
> for HDD due to their performance characteristics.

Also for NVMe we initially went down the road to try to support
non power of two sizes.  But there was another major early host that
really wanted the power of two zone sizes to support hardware based
hosts that can cheaply do shifts but not divisions.  The variable
zone capacity feature (something that Linux does not currently support)
is a feature requested by NVMe members on the host and device side
also can only be supported with the the zone size / zone capacity split.

> The other solution would be adding a dm-unhole target to remap sectors
> to remove the holes from the device address space. Such target would be
> easy to write, but in my opinion, this would still not change the fact
> that applications still have to deal with error recovery and active/open
> zone resources. So they still have to be zone aware and operate per zone.

I don't think we even need a new target for it.  I think you can do
this with a table using multiple dm-linear sections already if you
want.

> My answer to your last question ("Are we sure?") is thus: No. I am not
> sure this is a good idea. But as always, I would be happy to be proven
> wrong. So far, I have not seen any argument doing that.

Agreed. Supporting non-power of two sizes in the block layer is fairly
easy as shown by some of the patches seens in this series.  Supporting
them properly in the whole ecosystem is not trivial and will create a
long-term burden.  We could do that, but we'd rather have a really good
reason for it, and right now I don't see that.

