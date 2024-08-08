Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C08C52D71
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Aug 2024 20:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MoXDJcmwahQwk2XNAkzjBbC4Ch2PiqhVaEdN/JPLwgQ=; b=TO1GUC/tDwoszTK5mKYKm9M02t
	4kNEkmrcryDKKC1ib8EFNvxep2hPHsBHVmy+VS1NcrL2UBZK4A+0E4EBvNn9L4j2P2dk9EPGksIT5
	DH4w43vErqJI9nAXhcTcI219iSjNeHXrmIDN+TnNqSbgBOha7rCU/9kXqxFzZSe+S0bLgHki746P2
	Zj2AksM2mc+VmmqZf8qI4PieCJiPQl7BzTfRpZmHV5nPGFA4EyCElfXlTT7d0vtG7gYiMwcg18wE/
	85t4CQXhnIPtuIPD8S/mywz3S/ucgyf0Lm3tkt8lrof7KmhW5waqZBIvSkTJXQ7lXq7AgoQbm5dxh
	Nx4QZHvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sc9xy-00000009SF9-3DfD;
	Thu, 08 Aug 2024 20:42:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbvgF-000000077mW-41Ng
	for linux-nvme@lists.infradead.org;
	Thu, 08 Aug 2024 05:27:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723094837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MoXDJcmwahQwk2XNAkzjBbC4Ch2PiqhVaEdN/JPLwgQ=;
	b=UHYWOwHZWsZ8wkpuiXDC/kQ+4GHXn/4+itsJ0StB8sqruIF1296HPvy47v8LiUXhhTLOna
	20sNRuSq6qZU7GAvySj8oZwQ6jsYDVbrgEA2c0TPOK80X4sqXm2CCDRiOCPtJTeeDolwSB
	TcGEHUQsazIMy9Fuput5dZImJucbLRk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-Q2ixB890NQ-YxhEHAlmKHQ-1; Thu,
 08 Aug 2024 01:27:12 -0400
X-MC-Unique: Q2ixB890NQ-YxhEHAlmKHQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 741021977003;
	Thu,  8 Aug 2024 05:27:07 +0000 (UTC)
Received: from fedora (unknown [10.72.116.25])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD6F61955F2E;
	Thu,  8 Aug 2024 05:26:47 +0000 (UTC)
Date: Thu, 8 Aug 2024 13:26:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@lst.de>,
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
	"brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, virtualization@lists.linux.dev,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-doc@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH v3 15/15] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
Message-ID: <ZrRXEUko5EwKJaaP@fedora>
References: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de>
 <20240806-isolcpus-io-queues-v3-15-da0eecfeaf8b@suse.de>
 <ZrI5TcaAU82avPZn@fedora>
 <253ec223-98e1-4e7e-b138-0a83ea1a7b0e@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253ec223-98e1-4e7e-b138-0a83ea1a7b0e@flourine.local>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240807_222720_109578_E359E485 
X-CRM114-Status: GOOD (  34.57  )
X-Mailman-Approved-At: Thu, 08 Aug 2024 13:42:32 -0700
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

On Wed, Aug 07, 2024 at 02:40:11PM +0200, Daniel Wagner wrote:
> On Tue, Aug 06, 2024 at 10:55:09PM GMT, Ming Lei wrote:
> > On Tue, Aug 06, 2024 at 02:06:47PM +0200, Daniel Wagner wrote:
> > > When isolcpus=io_queue is enabled all hardware queues should run on the
> > > housekeeping CPUs only. Thus ignore the affinity mask provided by the
> > > driver. Also we can't use blk_mq_map_queues because it will map all CPUs
> > > to first hctx unless, the CPU is the same as the hctx has the affinity
> > > set to, e.g. 8 CPUs with isolcpus=io_queue,2-3,6-7 config
> > 
> > What is the expected behavior if someone still tries to submit IO on isolated
> > CPUs?
> 
> If a user thread is issuing an IO the IO is handled by the housekeeping
> CPU, which will cause some noise on the submitting CPU. As far I was
> told this is acceptable. Our customers really don't want to have any
> IO not from their application ever hitting the isolcpus. When their
> application is issuing an IO.
> 
> > BTW, I don't see any change in blk_mq_get_ctx()/blk_mq_map_queue() in this
> > patchset,
> 
> I was trying to figure out what you tried to explain last time with
> hangs, but didn't really understand what the conditions are for this
> problem to occur.

Isolated CPUs are removed from queue mapping in this patchset, when someone
submit IOs from the isolated CPU, what is the correct hctx used for handling
these IOs?

From current implementation, it depends on implied zero filled
tag_set->map[type].mq_map[isolated_cpu], so hctx 0 is used.

During CPU offline, in blk_mq_hctx_notify_offline(),
blk_mq_hctx_has_online_cpu() returns true even though the last cpu in
hctx 0 is offline because isolated cpus join hctx 0 unexpectedly, so IOs in
hctx 0 won't be drained.

However managed irq core code still shutdowns the hw queue's irq because all
CPUs in this hctx are offline now. Then IO hang is triggered, isn't it?

The current blk-mq takes static & global queue/CPUs mapping, in which all CPUs
are covered. This patchset removes isolated CPUs from the mapping, and the
change is big from viewpoint of blk-mq queue mapping.

> 
> > that means one random hctx(or even NULL) may be used for submitting
> > IO from isolated CPUs,
> > then there can be io hang risk during cpu hotplug, or
> > kernel panic when submitting bio.
> 
> Can you elaborate a bit more? I must miss something important here.
> 
> Anyway, my understanding is that when the last CPU of a hctx goes
> offline the affinity is broken and assigned to an online HK CPU. And we
> ensure all flight IO have finished and also ensure we don't submit any
> new IO to a CPU which goes offline.
> 
> FWIW, I tried really hard to get an IO hang with cpu hotplug.
 
Please see above.


thanks,
Ming


