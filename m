Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218D4C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 14:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tbJ3eFJkh/E7Y4DNaMoAT+nkhu3e6n8bE/bz40gdlyo=; b=A3GGSMOS/OX9MxZCbU5NanCC5h
	14bCpXG9HoWABt1zcsYohoHNnNavRP/Aq/M26draqBN2ZnNXPMiD6zxyfZ1hXiZBOzaSfZBIHnHWv
	/NmtoeIrJFD/w9I0hRVW14OslSuqaexDqUjBaVzr634kLOIZU6EiS0hMIoZYMb3qnIySxVI131UZL
	+80eM8ot8MraU+3aXWU6HzPZw0gc4D3dEHyW1Dn6gdESBelBNw0mUz0po9zoh693CEUBoUJ4CbjJt
	aJr/kLwcJb0GJ2ZhOoE4oPMZgIH7AAPGiSasINw+eTQoKUK+bCGCYIeuI52Jf1sZKEJGQiIOJhlT3
	EXL3htfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSK2C-00DAd5-0u; Thu, 10 Mar 2022 14:44:56 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSK29-00DAbR-Nd
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 14:44:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AB73D68AFE; Thu, 10 Mar 2022 15:44:49 +0100 (CET)
Date: Thu, 10 Mar 2022 15:44:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 jiangbo.365@bytedance.com, kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
 Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220310144449.GA1695@lst.de>
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com>
 <20220308165349.231320-1-p.raghav@samsung.com>
 <20220310094725.GA28499@lst.de>
 <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_064453_943903_C302BCB3 
X-CRM114-Status: GOOD (  16.11  )
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

On Thu, Mar 10, 2022 at 01:57:58PM +0100, Pankaj Raghav wrote:
> Yes, these drives are intended for Linux users that would use the zoned
> block device. Append is supported but holes in the LBA space (due to
> diff in zone cap and zone size) is still a problem for these users.

I'd really like to hear from the users.  Because really, either they
should use a proper file system abstraction (including zonefs if that is
all they need), or raw nvme passthrough which will alredy work for this
case.  But adding a whole bunch of crap because people want to use the
block device special file for something it is not designed for just
does not make any sense.

