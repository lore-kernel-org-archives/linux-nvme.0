Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885D9CCF9FF
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 08:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ja1ecSFn5o1JlkV6H5gg7BEfBTzU4LFhx2LoOzyKAZY=; b=LXaU8lDZvrfc8pToQOCIkzh9kM
	2BTL9MshcrJBnrrtr99U8JLu7LTLxGMMivpUND4djXbS/q7oCdt+pkmNpSF6laHiOQ0+Vuskqo9YB
	zubDWo8/zWRzwmlIRkcEqp/RQMQdc3aI3EcCSnjXRAaOCw9MvAkq5NF+xdIh3X/+b5heu4tL0cFIQ
	ZRItYWiKJNe8U1VVVs468Oyqr9poA3PiS/HrrDxWNRKmUfb7rL0yInCChbEwJYI3U2D1qDXV9wNpx
	16pEk4vdsr4OOSq/djdm/9Apz1IsS7a43/XKJ8muUb4v+MBsAO21APSD5EjPUiy5McSRbNsr244+H
	PgrIB0Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEknJ-00000005gqX-49cW;
	Fri, 31 Oct 2025 08:47:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEknH-00000005gpO-1Rgg
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 08:47:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 86B16227A88; Fri, 31 Oct 2025 09:47:31 +0100 (CET)
Date: Fri, 31 Oct 2025 09:47:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>, dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 05/13] block: reorganize struct blk_zone_wplug
Message-ID: <20251031084731.GE8798@lst.de>
References: <20251031061307.185513-1-dlemoal@kernel.org> <20251031061307.185513-6-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031061307.185513-6-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_014735_596098_770F2772 
X-CRM114-Status: GOOD (  11.49  )
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

On Fri, Oct 31, 2025 at 03:12:59PM +0900, Damien Le Moal wrote:
> Reorganize the fields of struct blk_zone_wplug to remove a hole after
> the wp_offset field and avoid having the bio_work structure split
> between 2 cache lines.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


