Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8235DC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 20:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HYl7HLa06XTzSBAzIC7meEiGYtTOJ6AeMHykAerkVEs=; b=o9A/k9fSkmPvba1yiXkeYPdijW
	wLCLIJy7kZiY9slWlzTFykNqAxDj5nOmJlLuNQ/kpCqmv7T1ulqRBmim4rF7adl+g8s6vpjtazHBq
	ZoWDBcIfAAkHMzR8M8as+f1tZgQlCjpVsWv+tTjDn2DDg0BwM9541FsR+RbL+PyKcKbAXMlDKBJbr
	wjJlVCkrH6yJhJfjGodWXWFZjBbAUq/q2XQEfq8HRM3W3iWr9Mdv+bDfwPGzW7lvcXM9/4OPfCoSy
	LA+5l6eWj8LrtHrWz0niQpudVVb0U9YSWqqMwziq20hW8IjUgppaCKKi+jxI2qlK70Er5L6cIGJkX
	SLcPdvJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSPVK-00DzAj-64; Thu, 10 Mar 2022 20:35:22 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nSPVH-00DzAa-RX; Thu, 10 Mar 2022 20:35:19 +0000
Date: Thu, 10 Mar 2022 12:35:19 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
 jiangbo.365@bytedance.com, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/6] nvme: zns: Add support for power_of_2 emulation to
 NVMe ZNS devices
Message-ID: <YiphB2Me63kD7T5t@bombadil.infradead.org>
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <CGME20220308165436eucas1p1b76f3cb5b4fa1f7d78b51a3b1b44d160@eucas1p1.samsung.com>
 <20220308165349.231320-5-p.raghav@samsung.com>
 <d13c40a5-3f87-fb2c-155e-dd64535067ac@opensource.wdc.com>
 <cf527b75-8fba-96ba-659d-fbb46fbe9de7@samsung.com>
 <bdb92eac-59ef-3ba1-16cb-31219e3a264b@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdb92eac-59ef-3ba1-16cb-31219e3a264b@opensource.wdc.com>
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

On Thu, Mar 10, 2022 at 06:43:47AM +0900, Damien Le Moal wrote:
> On 3/9/22 23:33, Pankaj Raghav wrote:
> > On 2022-03-09 05:04, Damien Le Moal wrote:
> >> So for a power of 2 zone sized device, you are forcing an indirect call,
> >> always. Not acceptable. What is the point of that po2_zone_emu boolean
> >> you added to the queue ?
> > This is a good point and we had a discussion about this internally.
> > Initially I had something like this:
> > if (!blk_queue_is_po2_zone_emu(disk))
> > 	return sector >> (ns->lba_shift - SECTOR_SHIFT);
> > else
> > 	return __nvme_sect_to_lba_po2(ns, sec);
> 
> No need for the else.

If true then great.

> > But @Luis indicated that it was better to set an op which comes at a cost of indirection
> > instead of having a runtime check with a if/else in the **hot path**. The code also looks
> > more clear with having an op.
> 
> The indirect call using a function pointer makes the code obscure. And
> the cost of that call is far greater and always present compared to the
> CPU branch prediction which will luckily avoid most of the time taking
> the wrong branch of an if.

The goal was to ensure no performance impact, and given a hot path
was involved and we simply cannot microbench append as there is no
way / API to do that, we can't be sure. But if you are certain that
there is no perf impact, it would be wonderful to live without it.

Thanks for the suggestion and push!

  Luis

