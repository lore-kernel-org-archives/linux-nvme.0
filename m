Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0184DC25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 06:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UE/yl0u0KU8BQtoZBClXQLaYI2McwywMhZT0h/U/b5s=; b=zTlv1XsfRH6FXSvkcJ3XUlabH5
	yzOIRWMTyvpl3BgFqjRZJ5g2UsUNSL3/s/iEfZ38R4V/+h+o/FcJ/1+p8KUk+Pyj5KkyM2ga71ok5
	zuQM4AAbP2BVBWFlZA53qbCQ2Am54RVcHtGPhjxGKKIQ0ShAxtM66+3EjSjrJDKun4cTye6xVETzk
	cC38cLP0DnfBvLcjerPbenrtQ8gmMyVHvMLwB2l6KpXDY/GNjCujzfMCSPAcQKooUbSisjGQlm3Xz
	3+OUZMyzn8wkZ1iKbeB0JjLe5E6oPDUrMVi/m6sR3UMQ5BVy/JUNEsInw2dxBFS3k1SkLmcqdh5YY
	iZLPgpSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuqv-00000007eLq-3EgS;
	Tue, 11 Jun 2024 06:19:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuSO-00000007aY5-3Rho;
	Tue, 11 Jun 2024 05:54:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B228C68B05; Tue, 11 Jun 2024 07:54:05 +0200 (CEST)
Date: Tue, 11 Jun 2024 07:54:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph B??hmwalder <christoph.boehmwalder@linbit.com>,
	Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Roger Pau Monn?? <roger.pau@citrix.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
	drbd-dev@lists.linbit.com, nbd@other.debian.org,
	linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 02/26] sd: move zone limits setup out of
 sd_read_block_characteristics
Message-ID: <20240611055405.GA3256@lst.de>
References: <20240611051929.513387-1-hch@lst.de> <20240611051929.513387-3-hch@lst.de> <40ca8052-6ac1-4c1b-8c39-b0a7948839f8@kernel.org> <20240611055239.GA3141@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611055239.GA3141@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_225409_111881_6A5D1460 
X-CRM114-Status: GOOD (  13.63  )
X-Mailman-Approved-At: Mon, 10 Jun 2024 23:19:24 -0700
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

On Tue, Jun 11, 2024 at 07:52:39AM +0200, Christoph Hellwig wrote:
> > Maybe we should clear the other zone related limits here ? If the drive is
> > reformatted/converted from SMR to CMR (FORMAT WITH PRESET), the other zone
> > limits may be set already, no ?
> 
> blk_validate_zoned_limits already takes care of that.

Sorry, brainfart.  The integrity code does that, but not the zoned
code.  I suspect the core code might be a better place for it,
though.


