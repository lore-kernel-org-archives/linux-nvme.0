Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A30C27C4F
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Jun 2024 13:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PpJVArXnfD1gJGwSlZy8hYot2UR3RMaatDvx0IO2VfU=; b=188jTt6gkdeCYffZKbeIGYiDEL
	w9W0Pr6WJ7fUSR//7siSaD5qKYTod5NCb2cR4hEC+eg4J5BUWkaGVdnq/gDzWxbGP+7GQYhnrPknE
	/i4LiBeO+TE+mbAKMU2x11j6ixKN4d+AVVLV8GPiidlYSJDIS8ncASpw6tzFUyMVPclsrpBE4c8on
	71Kp4ZTRTvKiKI1EXyziXLYdT56tGr+HEF+Dv/8ygNBDuiMDYUlbGNBqb/YNHKJrpht8RstO6WxY+
	yh59PfQWW4Amv7o0ZfMD9OiJtJF6nCwhUwQQ1Sna3vX07iNM2VJAc0kqHxTOU/54ABR7p1Pzv5aPu
	6hDmMVcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNun6-00000000SDT-3P3R;
	Sun, 30 Jun 2024 13:40:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNun3-00000000SCY-3Tsz
	for linux-nvme@lists.infradead.org;
	Sun, 30 Jun 2024 13:40:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719754823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PpJVArXnfD1gJGwSlZy8hYot2UR3RMaatDvx0IO2VfU=;
	b=NXmBzOVBqjYrufLB11wI+qDr5P8y9btUOId7SWT59pHV/uwwIQRJJf0eWq3P5AoXaiy19U
	7thR732+u0H3tT7g6GwMJ3XXyjjLrTDCgMYrRiTV4H7u2c7a41ZJmhQhqrqxEyr7JBQDlh
	oZYzEotOxOcaVIXJd0tI9ZCEKfWBHV8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-JUCwpazyNwCOoI7ZaS9hkw-1; Sun,
 30 Jun 2024 09:40:17 -0400
X-MC-Unique: JUCwpazyNwCOoI7ZaS9hkw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47FCA19560B4;
	Sun, 30 Jun 2024 13:40:14 +0000 (UTC)
Received: from fedora (unknown [10.72.112.39])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 022E719560AA;
	Sun, 30 Jun 2024 13:40:04 +0000 (UTC)
Date: Sun, 30 Jun 2024 21:39:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@lst.de>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
Message-ID: <ZoFgLxGXrk4VCR03@fedora>
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240630_064025_971545_E644B481 
X-CRM114-Status: GOOD (  11.92  )
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

On Thu, Jun 27, 2024 at 04:10:53PM +0200, Daniel Wagner wrote:
> group_cpus_evenly distributes all present CPUs into groups. This ignores

The above isn't true, it is really cpu_possible_mask which is
distributed, instead of all present CPUs.

> the isolcpus configuration and assigns isolated CPUs into the groups.
> 
> Make group_cpus_evenly aware of isolcpus configuration and use the
> housekeeping CPU mask as base for distributing the available CPUs into
> groups.
> 
> Fixes: 11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed interrupts")

isolated CPUs are actually handled when figuring out irq effective mask,
so not sure how commit 11ea68f553e2 is wrong, and what is fixed in this
patch from user viewpoint?


Thanks, 
Ming


