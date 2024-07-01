Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AE6C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 07:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M+g42u0E0RJmKENIvoxoEw3yJCtdKnco3k8DpYO4KE0=; b=SuCj4zOJAXE4u8FKg2BWIp1nP+
	wloN9n1NAd9QM6vAN6q8lAFTTc98MUSiGQfX2+MAs3MvBJYp7NwLQzoMHSRPQC7gMsRL+o4nqamO5
	HCqlEZScwJy4Z4vBTzbqAOcGj6iMYQLPkljgj8bgLZSLLcHsnF4uxzruPonONtzW7618dw5o/gpiT
	wUBTyQ+nq5oxSwhsLXlo4Wv64eCL7eBDX9RIia8rjAfa+GzyuN0EtEWhIHrKhvskNFwUGUv3KwdHV
	lJhvXPxoy3b33i7YlTOWUGw4DIuyOkTuu+5roHpFSbIiEiwqEqok7Tv4SGXU3f2ZH1Z/Mg8W9YKL5
	ta+1Bj0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOBM4-000000020kf-3av2;
	Mon, 01 Jul 2024 07:21:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOBM1-000000020k9-3pXi
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jul 2024 07:21:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719818496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M+g42u0E0RJmKENIvoxoEw3yJCtdKnco3k8DpYO4KE0=;
	b=TNjTi7BxFekd93M/TjrCY2zXFYLf+uufMJpiehKXhVpFsX4NrrYLS+LpnaeCLJKooDHqBO
	BPVK3/CcxNagO/HA2tUjIwKHaBq5NdCw1+j6LcCxi+H5aGC84/0jD1OnTC/0XdJyp9R8XJ
	gTpboaKzy0pEI2FvRNXNmp3wPXbV98Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-6rDNLKIsNk6DoD4JULhg0w-1; Mon,
 01 Jul 2024 03:21:30 -0400
X-MC-Unique: 6rDNLKIsNk6DoD4JULhg0w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7B1419560B0;
	Mon,  1 Jul 2024 07:21:27 +0000 (UTC)
Received: from fedora (unknown [10.72.112.45])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D40A3000229;
	Mon,  1 Jul 2024 07:21:18 +0000 (UTC)
Date: Mon, 1 Jul 2024 15:21:13 +0800
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
Message-ID: <ZoJY6a1CHCENAZZ8@fedora>
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
 <ZoFgLxGXrk4VCR03@fedora>
 <b2ncik6c7xicsnzihhwfjjqood2yys52tzotohjnxj6o2mapg5@m364yzsjbvs2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2ncik6c7xicsnzihhwfjjqood2yys52tzotohjnxj6o2mapg5@m364yzsjbvs2>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_002138_059151_78E5377B 
X-CRM114-Status: GOOD (  20.04  )
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

On Mon, Jul 01, 2024 at 09:08:32AM +0200, Daniel Wagner wrote:
> On Sun, Jun 30, 2024 at 09:39:59PM GMT, Ming Lei wrote:
> > > Make group_cpus_evenly aware of isolcpus configuration and use the
> > > housekeeping CPU mask as base for distributing the available CPUs into
> > > groups.
> > > 
> > > Fixes: 11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed interrupts")
> > 
> > isolated CPUs are actually handled when figuring out irq effective mask,
> > so not sure how commit 11ea68f553e2 is wrong, and what is fixed in this
> > patch from user viewpoint?
> 
> IO queues are allocated/spread on the isolated CPUs and if there is an
> thread submitting IOs from an isolated CPU it will cause noise on the
> isolated CPUs. The question is this a use case you need/want to support?

I have talked RH Openshift team weeks ago and they have such usage.

userspace is free to run any application from isolated CPUs via 'taskset
-c' even though 'isolcpus=' is passed from command line.

Kernel can not add such new constraint on userspace.

> We have customers who are complaining that even with isolcpus provided
> they still see IO noise on the isolated CPUs.

That is another issue, which has been fixed by the following patch:

a46c27026da1 blk-mq: don't schedule block kworker on isolated CPUs



Thanks,
Ming


