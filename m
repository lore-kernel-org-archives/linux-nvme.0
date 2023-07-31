Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5BDC001DF
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 13:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GdLAgHbaIhUuS5ie7DVrkYjcjVNXTKW5lqZtOXrdOjM=; b=zMwzBC6ggxV7+okRh2hZjVF641
	aM/hX0yYHy9B9UBCkyXPotM8yGk9uuinQpv7N+VdmO+dvPliQZ/am9wPMUEKAsp0VGw/Y7shkmyTj
	Xp6IDCSVy+0pq45OkFHeTwMbkmTlAgzBhT+049uqfJ6oj8nhJUGknSISbRXKKDsLvvwOsB68WSjrj
	+5wlALU0R3aolamtBl1hgTRnUzxAorjOTf2FFudOKC84wOkGAWT5KVlZIf9UXbpLR4la+IajWyxlx
	uhEj5A4Eg5gvF6+8Tqi5IUq9atwLEGQaKVzEVGjQosfA+NNGOePgmdctLOoR6JNl8xlBUlaAJZ9mD
	8HFW1UrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTJT-00Fs3e-1P;
	Mon, 31 Jul 2023 13:51:55 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTJ0-00Frgn-0c;
	Mon, 31 Jul 2023 13:51:26 +0000
Date: Mon, 31 Jul 2023 06:51:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@infradead.org>,
	Keith Busch <kbusch@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] nvme: zns: limit max_zone_append by max_segments
Message-ID: <ZMe8XvFDDdAom97/@infradead.org>
References: <20230731114632.1429799-1-shinichiro.kawasaki@wdc.com>
 <e0f88870-73a8-05a3-024d-52cefcdef71d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0f88870-73a8-05a3-024d-52cefcdef71d@kernel.org>
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

On Mon, Jul 31, 2023 at 09:03:46PM +0900, Damien Le Moal wrote:
> I feel like a lot of the special casing for zone append bio add page can be
> removed from the block layer. This issue was found with zonefs tests on real zns
> devices because of this huge (and incorrect) zone append limit that zns has,
> combined with the recent zonefs iomap write change which overlooked the fact
> that bio add page is done by iomap before the bio op is set to zone append. That
> resulted in the large BIO. This problem however does not happen with scsi or
> null blk, kind-of proving that the regular bio add page is fine for zone append
> as long as the issuer has the correct zone append limit. Thought ?

A zone append limit larger than max_sectors is odd, and maybe the
block layer should assert something.  I think the root cause is that
many NVMe devices have a very large hardware equivalent to max_sectors
(the MDTS field), but Linux still uses a much lower limit due to memory
allocation issues (the PRPs used by NVMe are very inefficient in terms
of memory usage for larger transfers).  So we cap max_sectors to the
ѕoftware limit, but not max_zoned_append_sectors.

Zone Append needs some amount of special casing in the block layer
because the splitting of Zone Append bios must happen in the file system
as the file system needs a completion context per hardware operation.
I think the best way to do that is to first build up a maximum bio
and then use the same bio_split_rw function that the block layer would
use to split it to the hardware limits, just in the the issuer.  This
is what I did in btrfs, and it seems like zonefs actually needs to do
the same, but I missed that during review of the recent direct I/O
changes.

