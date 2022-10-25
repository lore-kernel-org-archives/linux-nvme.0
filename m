Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C311C38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QTgpvGimh8Oe/HceaI7CjlYQ3yTxHkn3r+XcrdBwr08=; b=sKpa8O7WM0Dd1Jt3fgG0Tt1odu
	HjiLnwQbXt3cTHX4sCrEU13oY4AGnv4bdSEeRlc5gG/IF4nOas4bC+lX9WSql/LuWAegDsBxH7kUj
	hZXoENj/fbdibfkDiEmiftIe/+l2kDPmVfEkApp2+bpqd8OkuDrxfK4Vrc2vyqV4a85lmgD2PQQ6E
	hxfedjPaEMROPuBK8LBuOiff0sxowpbb/DaLP8CBvjte0g4xyKCOacy8631Br7WI1UHVORKWQlX+d
	d+eB8mQQnr55S/UQypgRzoD9yEiGbXZWK5MV4SWZ2OTiyoppb/IKVI3SvM4ksBBACNCxsBDxG3Fqf
	eBG4cCCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onLsp-0066HO-4O; Tue, 25 Oct 2022 15:30:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onLsm-0066Gf-HP
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 15:30:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1111968C7B; Tue, 25 Oct 2022 17:30:19 +0200 (CEST)
Date: Tue, 25 Oct 2022 17:30:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Message-ID: <20221025153017.GA24137@lst.de>
References: <20220928195510.165062-1-sagi@grimberg.me> <20220928195510.165062-2-sagi@grimberg.me> <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com> <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me> <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com> <1b7feff8-48a4-6cd2-5a44-28a499630132@grimberg.me> <YzcJdeR82tHbFGAh@kbusch-mbp.dhcp.thefacebook.com> <414f04b6-aeac-5492-c175-9624b91d21c9@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414f04b6-aeac-5492-c175-9624b91d21c9@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_083024_738008_8719141A 
X-CRM114-Status: GOOD (  20.30  )
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

On Mon, Oct 03, 2022 at 11:09:06AM +0300, Sagi Grimberg wrote:
>> make up the multipath device. Only the low-level driver can do that right now,
>> so perhaps either call into the driver to get all the block_device parts, or
>> the gendisk needs to maintain a list of those parts itself.
>
> I definitely don't think we want to propagate the device relationship to
> blk-mq. But a callback to the driver also seems very niche to nvme 
> multipath and is also kinda messy to combine calculations like
> iops/bw/latency accurately which depends on the submission distribution
> to the bottom devices which we would need to track now.
>
> I'm leaning towards just moving forward with this, take the relatively
> small hit, and if people absolutely care about the extra latency, then
> they can disable it altogether (upper and/or bottom devices).

So looking at the patches I'm really not a big fan of the extra
accounting calls, and especially the start_time field in the
nvme_request and even more so the special start/end calls in all
the transport drivers.

the stats sysfs attributes already have the entirely separate
blk-mq vs bio based code pathes.  So I think having a block_device
operation that replaces part_stat_read_all which allows nvme to
iterate over all pathes and collect the numbers would seem
a lot nicer.  There might be some caveats like having to stash
away the numbers for disappearing paths, though.

