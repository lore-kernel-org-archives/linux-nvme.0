Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919F3C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 09:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EDqyRdhYnb9M1XMOG4X5CSh/FJ2XKI6Btl8RCyPZq18=; b=dh3YlwqCAdBDGDrwSTKXosm+ee
	U/cOXQXzAaUI50d0iMHrbig5OFFHNQil1BdkbspUY6j8jb2u3NvMmVByyviCEV302umxWav7lcGtX
	XQbqSVRYLa0eLP1LvkGikxgaV/SR1QZ6kiULMdF0CHqrEFs8Ps51i3mbf7F13yPkmdS5g/VEdmIJd
	R2UviuSwBZoDan/vF2B7Mk1b3MTaA8QpYa9hiROvHb40gDa09CLDEoLL6PO/EZjTaaSXDAheQx39J
	Y3XnatR31Ll8QxkiE+uXnUhHUYjq1oLtO2uA7053koffCs2eOiHk3QO900TqPHkHGn9xOXr6loBJA
	00f3LznQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOD9I-00000002Pjh-0FFa;
	Mon, 01 Jul 2024 09:16:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOD9E-00000002Pj3-39Ls
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jul 2024 09:16:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719825391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EDqyRdhYnb9M1XMOG4X5CSh/FJ2XKI6Btl8RCyPZq18=;
	b=cTNl0fyOHcEMT7X2y43m8dtIGNFEHBixrPLc+qDdEmWfP1LBMg0IU8VO1TXCTsY3x8iIcC
	mYNt53X9+CSRV1AH8KSPP0/YxO+7qloVBkftCyKXeNbzeWseRkJlvMo7GoxPAkvqI+sFWy
	1kwt37Gt8IhOptrV5aVKNLlXMa8itYI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-NPstdspGOHmTb05q43_i_A-1; Mon,
 01 Jul 2024 05:16:28 -0400
X-MC-Unique: NPstdspGOHmTb05q43_i_A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BFCFB19560AD;
	Mon,  1 Jul 2024 09:16:25 +0000 (UTC)
Received: from fedora (unknown [10.72.112.45])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85E941956089;
	Mon,  1 Jul 2024 09:16:16 +0000 (UTC)
Date: Mon, 1 Jul 2024 17:16:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <dwagner@suse.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@lst.de>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	Mel Gorman <mgorman@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
Message-ID: <ZoJz23UJLQ0NKpH4@fedora>
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
 <ZoFgLxGXrk4VCR03@fedora>
 <b2ncik6c7xicsnzihhwfjjqood2yys52tzotohjnxj6o2mapg5@m364yzsjbvs2>
 <ZoJY6a1CHCENAZZ8@fedora>
 <0d8a5256-9719-45c5-b098-237b5a82fd36@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d8a5256-9719-45c5-b098-237b5a82fd36@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_021632_887994_89FD1AE8 
X-CRM114-Status: GOOD (  29.70  )
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

On Mon, Jul 01, 2024 at 10:43:14AM +0200, Hannes Reinecke wrote:
> On 7/1/24 09:21, Ming Lei wrote:
> > On Mon, Jul 01, 2024 at 09:08:32AM +0200, Daniel Wagner wrote:
> > > On Sun, Jun 30, 2024 at 09:39:59PM GMT, Ming Lei wrote:
> > > > > Make group_cpus_evenly aware of isolcpus configuration and use the
> > > > > housekeeping CPU mask as base for distributing the available CPUs into
> > > > > groups.
> > > > > 
> > > > > Fixes: 11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed interrupts")
> > > > 
> > > > isolated CPUs are actually handled when figuring out irq effective mask,
> > > > so not sure how commit 11ea68f553e2 is wrong, and what is fixed in this
> > > > patch from user viewpoint?
> > > 
> > > IO queues are allocated/spread on the isolated CPUs and if there is an
> > > thread submitting IOs from an isolated CPU it will cause noise on the
> > > isolated CPUs. The question is this a use case you need/want to support?
> > 
> > I have talked RH Openshift team weeks ago and they have such usage.
> > 
> > userspace is free to run any application from isolated CPUs via 'taskset
> > -c' even though 'isolcpus=' is passed from command line.
> > 
> > Kernel can not add such new constraint on userspace.
> > 
> > > We have customers who are complaining that even with isolcpus provided
> > > they still see IO noise on the isolated CPUs.
> > 
> > That is another issue, which has been fixed by the following patch:
> > 
> > a46c27026da1 blk-mq: don't schedule block kworker on isolated CPUs
> > 
> Hmm. Just when I thought I understood the issue ...
> 
> How is this supposed to work, then, given that I/O can be initiated
> from the isolated CPUs?
> I would have accepted that we have two scheduling domains, blk-mq is
> spread across all cpus, and the blk-mq cpusets are arranged according
> to the isolcpu settings.
> Then we can initiate I/O from the isolated cpus, and the scheduler
> would 'magically' ensure that everything is only run on isolated cpus.

blk-mq issues IO either from current context or kblockd context.

> 
> But that patch would completely counteract such a setup, as during
> I/O we more often than not will invoke kblockd, which then would cause
> cross-talk on non-isolated cpus.

If IO is submitted from isolated CPU, blk-mq will issue this IO via
unbound kblockd WQ, which is guaranteed to not run on isolated CPUs.


Thanks,
Ming


