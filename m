Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A2EE7719A
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Jan 2025 03:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gFwpZ4lNqHc8a93lKvyOmLFaFeR0q5NU2Y4FGP31Aws=; b=2Csf6UdnFc9jmXIVQWmj2tE/Y8
	hY+fXrcYs+55f3IpUq6BzAAJTWW2eB+0SIUleilidr0kBr/iHkKPt/U1etiaQLHueyr2CWsoAqleo
	2Et82cglf2J2rMNkUFnOMmY46VBVZAIS/zxM/P/vE0oyIARel6UC3GJ+4cun05jix8h5OU9TXpWv2
	i1wZ0oJ/mD05WzQD7ycMClnDqx9QI6gmwHc0NgY91pVpweTeOZ1WPK98ja9k/N5VUg+82ez3WerBT
	zZ/iXjTcU3ZfPEYh9oVvsPclm+XDFpxeMjmfCxIDnYIJ0z3y/CU+3VogLjmKvnLTZvckd7M9WZZkC
	egfVkNww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWSXG-0000000066j-0Vmx;
	Sat, 11 Jan 2025 03:51:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWSN6-0000000054T-2SyF
	for linux-nvme@lists.infradead.org;
	Sat, 11 Jan 2025 03:41:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736566871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gFwpZ4lNqHc8a93lKvyOmLFaFeR0q5NU2Y4FGP31Aws=;
	b=JDe/n3NY1qj0j1ZtrXNrtKHxWbD4dvDBKoIrfg9khYFLEDSX1ylEQjxsB3MzwZcNqalEfl
	5WV+Yo8vVAROzqAogr5rmBViWoPoHunOfaycsAAMNFlQCDjfMyzFr9R8vH0LBndEjJMKfZ
	DiCL2kI3FRXy91MFmQ48cEzMkz0xHqM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-9L9FZIIhP4Sk_aSRXlxo0Q-1; Fri,
 10 Jan 2025 22:41:05 -0500
X-MC-Unique: 9L9FZIIhP4Sk_aSRXlxo0Q-1
X-Mimecast-MFC-AGG-ID: 9L9FZIIhP4Sk_aSRXlxo0Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FD781956083;
	Sat, 11 Jan 2025 03:40:58 +0000 (UTC)
Received: from fedora (unknown [10.72.116.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFABD19560AB;
	Sat, 11 Jan 2025 03:40:44 +0000 (UTC)
Date: Sat, 11 Jan 2025 11:40:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, storagedev@microchip.com,
	virtualization@lists.linux.dev,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v5 8/9] blk-mq: issue warning when offlining hctx with
 online isolcpus
Message-ID: <Z4HoN0F0cKD5G16F@fedora>
References: <20250110-isolcpus-io-queues-v5-0-0e4f118680b0@kernel.org>
 <20250110-isolcpus-io-queues-v5-8-0e4f118680b0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110-isolcpus-io-queues-v5-8-0e4f118680b0@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_194112_702956_59EAE611 
X-CRM114-Status: GOOD (  15.36  )
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

Hi Daniel,

On Fri, Jan 10, 2025 at 05:26:46PM +0100, Daniel Wagner wrote:
> When isolcpus=managed_irq is enabled, and the last housekeeping CPU for
> a given hardware context goes offline, there is no CPU left which
> handles the IOs anymore. If isolated CPUs mapped to this hardware
> context are online and an application running on these isolated CPUs
> issue an IO this will lead to stalls.
> 
> The kernel will not schedule IO to isolated CPUS thus this avoids IO
> stalls.
> 
> Thus issue a warning when housekeeping CPUs are offlined for a hardware
> context while there are still isolated CPUs online.

Why do you continue to send patch without addressing the fundamental regression?

This patchset does break existed applications which can't follow the new
rule of offlining CPU in order.

Again, it violates no-regression rule of kernel development.


Thanks,
Ming


