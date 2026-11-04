Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA97606A326
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EwZPj7In;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=BgO1Xsj6;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5fLGN7uT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=a5bZ2lIZiEkVoZLtojIf8IXJVOMItCBOSHoLzBHJXI8=; b=EwZPj7InO4bm9gVJUhzJrl834M
	QagPPZ3wRfGD2EcATEkdkRbbaDmEZePXQh1PvJxRnbg+1tDG/3xfNinVZbJmK473nb28j1UO7Jk0Q
	XULKTLdQbD4EOFrDhU2LaQp02ivTERCNpVMQPTCTdHMfRzOOxlaWlH7Y6S3Gm7SdGGBuj7smwC5rC
	s1qvc0Z3oDKP2beZAsNj3lYvuTi228lan4xMxb04NcVppcZN3G40jJgK7tD5+WP7YilvQ0+do7/Ps
	lp/P/CVjDAj7bSXyw45LgT8+hHDHTA6cAGvetI4dZFHQIOv4GFcU+IfMl/hHpFQPTpYk5v+37BTjK
	vR5j1khA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOVYb-00000004Xww-1LQj;
	Wed, 04 Nov 2026 07:37:17 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOVYY-00000004XwD-2TII
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 07:37:15 +0000
Date: Wed, 4 Nov 2026 08:37:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793777832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a5bZ2lIZiEkVoZLtojIf8IXJVOMItCBOSHoLzBHJXI8=;
	b=BgO1Xsj6UVvItDbkKR7DF62E98m3dvPI+mk5pF8NY4o+sygzv3liHbPn/Ust4nPxeVf55J
	07JVZVihODGmN2UvZPK478aAbJJV2hgZY7BVd6GPmxVgpfWddXeaX4k3RuK6/ahu6l2cdM
	XGG5g92pz3A+SwsKc6iqsI9Eu2rScoYLJ5vyQ93H/GNpNb02pa3Ue3lohqDxmS37ho3Ty2
	dEt9LwD7oHSNcVVDAfkH7sgkRvfDZsUAayYsjaQMTqSablNp7Vl2R3MoopS2CoTeNz5tY3
	DEZbKWa6m+zH5nBZitr0ArTPZjbVItYaYivT4MbN1FQb7HgbWNqoSgpFPCZdMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793777832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a5bZ2lIZiEkVoZLtojIf8IXJVOMItCBOSHoLzBHJXI8=;
	b=5fLGN7uTtzDfUk8Ypn+enBJObhEK8ZoIGSIFUdB73ea7ijV9e5PLm+s0K8a1alIwP+FdsS
	FHQOw+pSO+wEriAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>,
	Surabhi Gogte <sgogte@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: use a housekeeping CPU for passthrough
 requests on isolated hctxs
Message-ID: <20261104073710.kTUsM3JV@linutronix.de>
References: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
 <20261103163748.qDpZjKj8@linutronix.de>
 <20261104071703.GC28939@lst.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104071703.GC28939@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_233714_770900_A27F69AA 
X-CRM114-Status: GOOD (  10.61  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-04 08:17:03 [+0100], Christoph Hellwig wrote:
> On Tue, Nov 03, 2026 at 05:37:48PM +0100, Sebastian Andrzej Siewior wrote:
> > What about
> > 	guard(rcu);
> > 	for_each_cpu_and(cpu, cpu_online_mask, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)) {
> > 		if (!cpu_is_isolated(cpu)
> > 			break;
> > 	}
> > 
> > this ends up with one less function call ;)
> 
> Please avoid this completely unreadable and unaditable guard crap.

If you/ block prefers to avoid guard() then fine. I usually get punched
the other way around.

> How is anyone supposed to understand that above mess?

I can show you code where you start crying. Anyway. My main selling
point was for_each_cpu_and().

Sebastian

