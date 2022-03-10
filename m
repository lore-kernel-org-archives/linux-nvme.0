Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3609AC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 15:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=opeNhzijnpbZTltLhu8G8j+nCh6FZnXF3JFqUT3i2Po=; b=eTzKNDGLTI4OGnRcl3Cf4ozK0I
	4IQ5XIvJ/f/IiGwY/RYV5IRfYv+/1Z4BDA2vr2nQE5KPx96eUxqIGYjeP8r5Tdm7nAO7VYxJt005D
	ovenkty4oNf3gYHrNqWzJvqFuRkC9v0usaAYbNZJBEHdEcBorPoJ6V2TfxQomN0T2TdqirTH3e5e+
	I3NuXpZxtPgsK4DBkzg4uB6PWtIiig495SRWuXRVppuU+ARPTkr8lSikjH4od/ZI254k3NaI/L14Z
	Za4DTtaO3s5sfvoSJrfWognyS6ePHa/dLabvKhGo7+2a694zSIHckYisBlP6QcKwnv+nbruDlYq+M
	6vHI6zpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSKOA-00DHew-JX; Thu, 10 Mar 2022 15:07:38 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSKO7-00DHdp-68
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 15:07:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B248161567;
 Thu, 10 Mar 2022 15:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F45C340E8;
 Thu, 10 Mar 2022 15:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646924854;
 bh=0hp00Jy+IMNoo5h1gFYV80g0XT2H6yvLfY36fSISqJQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Mk6L/CTfW44dSyQzZ1FMHeI78vMTU6lplukD5YoKNiwUkjML3fbhaiG10sMJFnmJ8
 luKAFgWldJFTkuU8Lm75+LzgsUyeRgbhrKY+zFRhT5kpILfZVZ/5W2F/B1TfY8ctk+
 8Semr7MuyLjveVOZw7pTipBEzvQHlSmtBFTakDhk5PUcQCFmIcPxT6m5CGyLiQxIPR
 JLCnSydaSkTHU2DjPjHeBGiT2ytlwBMfyaLmB8EPdVjxlcBsu71ZutnXq/a2ugQRJz
 Is0Z/Z8CvFtRASmK/i4bSJXCVsLioTv1gKQleoTfyVZYSX3EhjyoHfmAtgLB6WbWdr
 0wrVrbvPpbvzQ==
Date: Thu, 10 Mar 2022 07:07:30 -0800
From: Keith Busch <kbusch@kernel.org>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>
Cc: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Pankaj Raghav <p.raghav@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220310150730.GA329710@dhcp-10-100-145-180.wdc.com>
References: <BYAPR04MB4968FA68FA8B670163EEC1EFF10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <C2710A6C-340D-4BFC-A8DB-28D456095468@javigon.com>
 <BYAPR04MB49684A8C6FEDA0B999ABCBB2F10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR04MB49684A8C6FEDA0B999ABCBB2F10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_070735_311224_CDF191AA 
X-CRM114-Status: GOOD (  20.92  )
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

On Thu, Mar 10, 2022 at 02:58:07PM +0000, Matias Bjørling wrote:
>  >> Yes, these drives are intended for Linux users that would use the
> > >> zoned block device. Append is supported but holes in the LBA space
> > >> (due to diff in zone cap and zone size) is still a problem for these users.
> > >
> > > With respect to the specific users, what does it break specifically? What are
> > key features are they missing when there's holes?
> > 
> > What we hear is that it breaks existing mapping in applications, where the
> > address space is seen as contiguous; with holes it needs to account for the
> > unmapped space. This affects performance and and CPU due to unnecessary
> > splits. This is for both reads and writes.
> > 
> > For more details, I guess they will have to jump in and share the parts that
> > they consider is proper to share in the mailing list.
> > 
> > I guess we will have more conversations around this as we push the block
> > layer changes after this series.
> 
> Ok, so I hear that one issue is I/O splits - If I assume that reads
> are sequential, zone cap/size between 100MiB and 1GiB, then my gut
> feeling would tell me its less CPU intensive to split every 100MiB to
> 1GiB of reads, than it would be to not have power of 2 zones due to
> the extra per io calculations. 

Don't you need to split anyway when spanning two zones to avoid the zone
boundary error?

Maybe this is a silly idea, but it would be a trivial device-mapper
to remap the gaps out of the lba range.

