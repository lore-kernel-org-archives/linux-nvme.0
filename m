Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4DDC3DA7F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Aug 2024 16:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IM8fYsVnwBY8ye6iqQGIAiYcjRBbRYKgCilIx+BGpeY=; b=n1wXNZl/PXpJpj5WapuQUGdKFc
	VwZJioDulXlueYn+9U5ROpo3AMZEtDnmoYbvugi7u46/K4J61EaHNAUq5GKaZkM8BMbQA3x286qP0
	wgDfChUO5OkZNHIFVTmAMoj91d2RdI40LGMoX7EdKpK/ap8AzgamgN7ohEuvM2gO2ytjg23nyTAgW
	ukPclZ0u/O1j4UEy+SEWr9dj87vyoEbmneA4hH4Zq3n0DayIquTBGz7v3ceKTFO28GtI/kihyI0ZX
	MB3FOueagY3N/W+vYKT3gz7Lh4eiBEDXXwSWHxHVfzt2OgAtD1JNFaf0I+4fOohKhB9s4E5TsJenO
	6se/6WpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdXUX-00000000pG5-3nqr;
	Mon, 12 Aug 2024 16:01:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdQzM-0000000HMrN-027H
	for linux-nvme@lists.infradead.org;
	Mon, 12 Aug 2024 09:05:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 57D9A227A8E; Mon, 12 Aug 2024 11:05:13 +0200 (CEST)
Date: Mon, 12 Aug 2024 11:05:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Jonathan Corbet <corbet@lwn.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	virtualization@lists.linux.dev, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
	storagedev@microchip.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 03/15] blk-mq: introduce blk_mq_dev_map_queues
Message-ID: <20240812090513.GD5497@lst.de>
References: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de> <20240806-isolcpus-io-queues-v3-3-da0eecfeaf8b@suse.de> <20240806132645.GC13883@lst.de> <8468546d-adae-4477-9306-ca08f32b19ca@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8468546d-adae-4477-9306-ca08f32b19ca@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240812_020516_211268_7CDB36BD 
X-CRM114-Status: GOOD (  18.57  )
X-Mailman-Approved-At: Mon, 12 Aug 2024 09:01:51 -0700
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

On Wed, Aug 07, 2024 at 02:49:58PM +0200, Daniel Wagner wrote:
> On Tue, Aug 06, 2024 at 03:26:45PM GMT, Christoph Hellwig wrote:
> > > +
> > > +/**
> > > + * blk_mq_virtio_get_queue_affinity - get affinity mask queue mapping for virtio device
> > 
> > Please avoid the overly long line here.
> 
> I thought for some reason the brief description needs to be on one
> line. It can be multiple lines:
> 
> https://www.kernel.org/doc/html/v6.10/doc-guide/kernel-doc.html#structure-union-and-enumeration-documentation

I'm pretty sure I've see line wraps there.  But if it wraps that's
probably and argument it is too lone as it isn't single line at that
point for a reasonable definition of line.

