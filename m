Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281E4CCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 10:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=20KPvSH60Gu9HfJ3XE5IMskk/pDpyvPS0D4tdrVoMm8=; b=FeqoxymSKPzEp8YkRhVHcDGVaf
	eb+MvT7NhGLtvwaXJyK324qBCyJ9X5QuuzS4N0GOr/WZFJQWqZwX7uEzrDozCcBWWnm+yIONPze0/
	zR/Kmqhheyw7WJoAcOmA/sP08jM/wTAJYAhmxcORCbZ6z5WHo3kj0JMMOOVR/2FvBaAQSzwUdLp6w
	QkUsGoLMBOjtAVidniBVeIJcgYovQXTctAUw9YzZ55O8YYdhpac+ed2+n49vIrull7immoLTptoML
	zgDbBHXobKQIR5sd4feW45H9H2MNEhlKTqGDUYhFba45bW+kdjpAq7N7p3Oi5djHbv1xUSPJS5Io/
	YAj9HKRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFroE-00000009dJn-2p2I;
	Mon, 03 Nov 2025 10:29:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFroC-00000009dIp-1eFL
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 10:29:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C497E227A87; Mon,  3 Nov 2025 11:29:02 +0100 (CET)
Date: Mon, 3 Nov 2025 11:29:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 08/13] block: introduce blkdev_get_zone_info()
Message-ID: <20251103102902.GB8369@lst.de>
References: <20251031061307.185513-1-dlemoal@kernel.org> <20251031061307.185513-9-dlemoal@kernel.org> <42dc640b-28e9-4706-91dc-dd075e736065@acm.org> <1276e2be-4d8b-4c59-822c-3af4490de24e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1276e2be-4d8b-4c59-822c-3af4490de24e@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_022908_571961_58505459 
X-CRM114-Status: GOOD (  16.10  )
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

On Mon, Nov 03, 2025 at 03:08:30PM +0900, Damien Le Moal wrote:
> On 11/1/25 06:40, Bart Van Assche wrote:
> >> +/**
> >> + * blkdev_get_zone_info - Get a zone information from cached data
> > 
> > "Get a zone information" -> "Get zone information"
> > 
> >> +	sector = sector & (~(zone_sectors - 1));
> > 
> > Please consider changing the above assignment into:
> > 
> > 	sector -= bdev_offset_from_zone_start(bdev, sector);
> 
> That is a lot more arithmetic for the same thing.
> If anything, I think this should be:
> 
> 	sector = ALIGN(sector, zone_sectors);

That would have to be ALIGN_DOWN I think.  Which sounds useful to
clean things up to me.


