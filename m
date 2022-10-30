Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F474C38A02
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 16:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hCx3cRWTU2411jE+KDtgdGSXF7QyHVeG6t+G1ZUrigM=; b=QTfQJ932f/v1j/bwLKPPq2FiVF
	PEmPhJSFXSYZ6Gj6aBp5nQ0s60OFXBT7Wztm9yuHUGsgGdxuLdfMBxz/1nTUSG14FoYynS1N68lAI
	J6miPYsmSofUlL2m/xtway/IJC/6J0fPaUV2KCBtzcQGVS9h59KjtMSTr2iL0Zw25/xR/ckU//2KB
	41dXchIENOaEt8aDnXIbkLhLkmNnygJWrGvCOSWFP7YoR6eBiYkXHYc6ak3OqSrdRaa7XTk0W/b/Z
	S2dK+EGrnn5JKRJEdq48xDhUT9CLwhvOipJKl4OEvKvM+r7DE09LRshBedGD0rvjzndFg9EBThVl3
	U1iBRE1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opB5P-000T8l-Li; Sun, 30 Oct 2022 16:22:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opB5N-000T6V-IG
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 16:22:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A48F968AA6; Sun, 30 Oct 2022 17:22:53 +0100 (CET)
Date: Sun, 30 Oct 2022 17:22:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Message-ID: <20221030162253.GA10408@lst.de>
References: <20220928195510.165062-1-sagi@grimberg.me> <20220928195510.165062-2-sagi@grimberg.me> <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com> <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me> <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com> <1b7feff8-48a4-6cd2-5a44-28a499630132@grimberg.me> <YzcJdeR82tHbFGAh@kbusch-mbp.dhcp.thefacebook.com> <414f04b6-aeac-5492-c175-9624b91d21c9@grimberg.me> <20221025153017.GA24137@lst.de> <f214dff7-9562-5f32-38b3-51bfc1216e98@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f214dff7-9562-5f32-38b3-51bfc1216e98@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_092257_765594_83204E68 
X-CRM114-Status: GOOD (  24.29  )
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

On Tue, Oct 25, 2022 at 06:58:19PM +0300, Sagi Grimberg wrote:
>> and even more so the special start/end calls in all
>> the transport drivers.
>
> The end is centralized and the start part has not sprinkled to
> the drivers. I don't think its bad.

Well.  We need a new magic helper instead of blk_mq_start_request,
and a new call to nvme_mpath_end_request in the lower driver to
support functionality in the multipath driver that sits above them.
This is because of the hack of storing the start_time in the
nvme_request, which is realy owned by the lower driver, and quite
a bit of a layering violation.

If the multipath driver simply did the start and end itself things
would be a lot better.  The upside of that would be that it also
accounts for the (tiny) overhead of the mpath driver.  The big
downside would be that we'd have to allocate memory just for the
start_time as nvme-multipath has no per-I/O data structure of it's
own.  In a way it would be nice to just have a start_time in
the bio, which would clean up the interface a lot, and
also massively simplify the I/O accounting in md.  But Jens might
not be willing to grow the bio for this special case, even if some
things in the bio seem even more obscure.

>> the stats sysfs attributes already have the entirely separate
>> blk-mq vs bio based code pathes.  So I think having a block_device
>> operation that replaces part_stat_read_all which allows nvme to
>> iterate over all pathes and collect the numbers would seem
>> a lot nicer.  There might be some caveats like having to stash
>> away the numbers for disappearing paths, though.
>
> You think this is better? really? I don't agree with you, I think its
> better to pay a small cost than doing this very specialized thing that
> will only ever be used for nvme-mpath.

Yes, I think a callout at least conceptually would be much better.

