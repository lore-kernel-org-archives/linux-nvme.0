Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840B4C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 08:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LDtWWIDoqguko+pUdjQLfQBznPwiHSC95eDCujomuVM=; b=RORRY+5QI286h0r1a6TZluBu+Q
	/xfmcaftc9+OCiMlhDZisOT4TS2xmzTEwEcyaZFzvFqgp5823H/PvN1frzl0iGYZ7gldoGU/IdS9Z
	yazAI5C6R5lOujwqJyuj3vyYMEqf0//NU6RAqpKrfQpqyngvRqaj8qMIDTOj97VAHKRI326nh7WiH
	jPuqQtvxmCqzhDUQ8xe1suA85rTN5lct7IAyaLZEYQ1o03T037YNJHuAjZLni0UbSzXBpll42/xnj
	qE56FTZZlDH41/yFdxhYqwTcl0IKBd9g97slofZN07Ww3BIuefBXQJ9tSF8mjygiJA9SbO32Qk5QV
	Ic6d4OJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOChr-00000002Idc-28gD;
	Mon, 01 Jul 2024 08:48:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOChp-00000002IbB-0fJm
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jul 2024 08:48:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719823692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LDtWWIDoqguko+pUdjQLfQBznPwiHSC95eDCujomuVM=;
	b=Ud0VuJoluLjkuK0r9pLQuQZh+H97kTv7ZGRsal/vlFUA3YeNs0fIPe7y3cbFOgm69RuwaV
	tPfgrjUR6b3KDqPXKKCo5uzIZVKxxRrL+lQW+qcaBt8Q6vUOR57uXOQbn+z2Tl7fqxxI4D
	bOaxF0bpN7ekcwHW/3zEZ7MZNrFTMQI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-Rj5SFsdSMl6F9fBBv64G1Q-1; Mon,
 01 Jul 2024 04:48:06 -0400
X-MC-Unique: Rj5SFsdSMl6F9fBBv64G1Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E9FC1944D39;
	Mon,  1 Jul 2024 08:48:04 +0000 (UTC)
Received: from fedora (unknown [10.72.112.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C1921956053;
	Mon,  1 Jul 2024 08:47:53 +0000 (UTC)
Date: Mon, 1 Jul 2024 16:47:48 +0800
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
Message-ID: <ZoJtNMUBWlJapUfb@fedora>
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
 <ZoFgLxGXrk4VCR03@fedora>
 <b2ncik6c7xicsnzihhwfjjqood2yys52tzotohjnxj6o2mapg5@m364yzsjbvs2>
 <ZoJY6a1CHCENAZZ8@fedora>
 <pmnqhamoec7u7ibtt4vccjfecp3ixgdlxzgncelvgczfbt74x5@26rjmpubji6s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pmnqhamoec7u7ibtt4vccjfecp3ixgdlxzgncelvgczfbt74x5@26rjmpubji6s>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_014813_293053_782AA4EA 
X-CRM114-Status: GOOD (  27.47  )
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

On Mon, Jul 01, 2024 at 10:19:25AM +0200, Daniel Wagner wrote:
> On Mon, Jul 01, 2024 at 03:21:13PM GMT, Ming Lei wrote:
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
> 
> Okay, that is why I asked if we need an additional HK type.
> 
> > > We have customers who are complaining that even with isolcpus provided
> > > they still see IO noise on the isolated CPUs.
> > 
> > That is another issue, which has been fixed by the following patch:
> > 
> > a46c27026da1 blk-mq: don't schedule block kworker on isolated CPUs
> 
> I've checked our downstream kernels and we don't have this one yet. I'll
> ask our customer to test if this patch addressed their issue.

BTW, you need the following one too:

7b815817aa58 blk-mq: add helper for checking if one CPU is mapped to specified hctx

Thanks,
Ming


