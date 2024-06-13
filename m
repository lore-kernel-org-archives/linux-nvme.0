Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB17C27C6E
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 14:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MzX4bwlwiNC10czWTfABuK3O0pJ28zjku3+H7w7Zy2U=; b=0bAwqrK3fB7JJ7jJ0pVBN9/94a
	eGb89i9+YBsAZ/rN4GdFXJKhZzcH8oeeFgXidCChmWbEQF3NQMrrjix6vK2uaW5tfrGyqyZKYNtH1
	Yq2YW34PnLii0KxBREJc+0BC5S51S+wEg+o/UkLPYYQydtCpmLgLT1YXC8U1QRHTvwdoIvBOr9B2a
	2JMNC6nLe7+bgb5xFh6AWmx54PmbI1mMikdL29nwuwbmqs5rS4nAhxslHqUKstRkG1Pbm2wNh/9vg
	DMxP3dZICLsyQapY+AGwIycvgzCRLFTtqMEOyUigTUPMu/pksLbbmsUx59nJpw3nzvSDk7Bobm/78
	zNJuo0iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHl6Q-0000000Gsfr-0h7L;
	Thu, 13 Jun 2024 14:06:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHgvb-0000000G0KT-3j32;
	Thu, 13 Jun 2024 09:39:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7DE0E68B05; Thu, 13 Jun 2024 11:39:18 +0200 (CEST)
Date: Thu, 13 Jun 2024 11:39:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
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
Message-ID: <20240613093918.GA27629@lst.de>
References: <20240611051929.513387-1-hch@lst.de> <20240611051929.513387-3-hch@lst.de> <40ca8052-6ac1-4c1b-8c39-b0a7948839f8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ca8052-6ac1-4c1b-8c39-b0a7948839f8@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_023932_185771_F2B1EFDD 
X-CRM114-Status: GOOD (  10.11  )
X-Mailman-Approved-At: Thu, 13 Jun 2024 07:06:53 -0700
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

On Tue, Jun 11, 2024 at 02:51:24PM +0900, Damien Le Moal wrote:
> > +	if (sdkp->device->type == TYPE_ZBC)
> 
> Nit: use sd_is_zoned() here ?

Actually - is there much in even keeping sd_is_zoned now that the
host aware support is removed?  Just open coding the type check isn't
any more code, and probably easier to follow.


