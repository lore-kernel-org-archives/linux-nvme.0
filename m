Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608B1C54E64
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 05:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oOcknLi1QMvHLfJOYeXQxPeeL3YWYeR59TrNvQj+qN0=; b=Pv27LEWm0vNzQZFHstPY/3qDJH
	HgszdKW35k4/vKTk3ohBZg5X3rO6wtcVcLbnczk+K0sOvLzxsUsZNM413tf6ckGzHkWIhtDmyry1L
	D4qBi9T28Fdo8GvfrEGK97KQm99ApyWcdMYg71IHa3/XIuFxO7V/cuz5uF6T8qZW5CgZIH7vtPZpM
	qe2CMDqa6Is+8o6dZz3oEQgkuEeSDHQYkvt7YXT0FKJcOpWVQWTN44m/4CrKOed60pGtMS4l7qVzr
	td6iWIKhlrjleyQKACdEeVF1vG+25TTEIFo+nKhYBG5ZEfe6L5m3twMTWnH5BO4SZ+DpXjNOErN5l
	yUzoMk6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpiWo-0000000CayY-3AGb;
	Thu, 28 Mar 2024 05:42:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpiWm-0000000CaxY-0J87
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 05:42:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EE17D68B05; Thu, 28 Mar 2024 06:42:08 +0100 (CET)
Date: Thu, 28 Mar 2024 06:42:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 04/30] block: Introduce blk_zone_update_request_bio()
Message-ID: <20240328054208.GA16087@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org> <20240328004409.594888-5-dlemoal@kernel.org> <20240328041457.GC13510@lst.de> <86114cba-535b-41e9-9b85-bac2fbdc1ed3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86114cba-535b-41e9-9b85-bac2fbdc1ed3@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_224216_296343_6ED1E43C 
X-CRM114-Status: GOOD (  17.42  )
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

On Thu, Mar 28, 2024 at 02:20:17PM +0900, Damien Le Moal wrote:
> I do not think that is corect. Because is_flush indicates that RQF_FLUSH_SEQ is
> set, that is, we are in the middle of a flush sequence. And flush sequence
> progression is handled at the request level, not BIOs. Once the sequence
> finishes, then and only then the BIO original endio should be done, meaning that
> we will then take this path and actually do blk_zone_update_request_bio() and
> bio_endio(). So I still think this is correct.

Well.

lk_flush_restore_request with the previous patch now restores rq->__sector,
and the blk_mq_end_request call following it will propagate it to the
original bio.  But blk_flush_restore_request grabs the sector from
rq->bio->bi_iter.bi_sector, and we need to actually get it there first,
which is done by the data I/O completion that has RQF_FLUSH_SEQ set.

I think we really need a good test case for zone append and FUA,
i.e. we need the append op for zonefs, which should exercise the
fua code if O_SYNC/O_DSYNC is set.


