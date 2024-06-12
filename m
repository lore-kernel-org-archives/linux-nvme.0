Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B589CC27C75
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 05:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dIwYGkX4/4dGLyGh5yUblzd4L1p9u7UcPnuemPo2wBc=; b=e4SSHEZlboilnFjPIQcxrwjq7o
	2/m1RicnS3YfGZ2XZ+Yku4ZDh0jFiAL7Xa8Y66vkcsFd+g31Kl04mj3YpQf8zlxpCdoq4BdYHIDUo
	im72A18kQxRKo2LSm1ZOaJW+62he0O1+q9MKOEvysAs1Fw6k/h81M+UYVI8TVuW3KZG1dhZWXgodl
	LKnrLVLQtvOatz/fecM/+mTG6nRJlxrbeEX8FhIDVxLAJ/4MI7WktExyBmtL7PoF2cvIFaE9e/6E5
	Kx6MiXtuOJOOCJongLyQNnkLjM5Jso0znMB44hmGiph2e8/xoEPjJdPuoal7xByY21We5iYfNJUlg
	ikxZOvnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHGFy-0000000B6hw-14Zn;
	Wed, 12 Jun 2024 05:10:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHG9C-0000000B5vk-1WEq;
	Wed, 12 Jun 2024 05:03:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0069168C4E; Wed, 12 Jun 2024 07:03:41 +0200 (CEST)
Date: Wed, 12 Jun 2024 07:03:41 +0200
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
Subject: Re: [PATCH 21/26] block: move the poll flag to queue_limits
Message-ID: <20240612050341.GA27049@lst.de>
References: <20240611051929.513387-1-hch@lst.de> <20240611051929.513387-22-hch@lst.de> <d1775d3f-daaa-4193-9f68-06ec47563b35@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1775d3f-daaa-4193-9f68-06ec47563b35@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_220346_679994_3105C794 
X-CRM114-Status: GOOD (  12.17  )
X-Mailman-Approved-At: Tue, 11 Jun 2024 22:10:40 -0700
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

On Tue, Jun 11, 2024 at 05:21:07PM +0900, Damien Le Moal wrote:
> Kind of the same remark as for io_stat about this not really being a device
> feature. But I guess seeing "features" as a queue feature rather than just a
> device feature makes it OK to have poll (and io_stat) as a feature rather than
> a flag.

So unlike io_stat this very much is a feature and a feature only as
we don't even allow changing it.  It purely exposes a device (or
rather driver) capability.

