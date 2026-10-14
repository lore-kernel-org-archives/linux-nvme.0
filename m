Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48899CC6B2A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 11:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l4HIVicNUEkWaEf5vxreRaAv/P+iiyWT06y2a+BOPck=; b=OXFPcBxYH7ci/HpeHbsvVcqybb
	Sr/99n6Q0Jyt1fLO7EP5bBURuZ9T5225Jclsg1016UNh6rxS5xty+LRKY+6/Q8yYEisrpcwSZHoAq
	kmQHp5V49gx0NUIsFf7X6OGvaPeSoHR3sWTw/jX4u5a/Ru73gLlf8AZIyVPtRVPtrIrLkQq2MeIg3
	xDg7LMd1k+qQv+8vrrSCIVY7KpmzygKtwNuDvZgYrUM9UF5sEdWSN37Yqi9UGJ9kn07PRyv/2zKTA
	LLqzh1H3MozqFJgfhH0oMkXpx5H6U7MS9mPE80LA5h9Yyze+omvOKjRsnM9U6V5xGC1GiMhCHcO/W
	NIeieVpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGwqE-0000000FI0H-1ei2;
	Wed, 14 Oct 2026 11:08:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGwqC-0000000FHzJ-15Qu
	for linux-nvme@bombadil.infradead.org;
	Wed, 14 Oct 2026 11:08:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l4HIVicNUEkWaEf5vxreRaAv/P+iiyWT06y2a+BOPck=; b=MkA0ymaMU0R/0xDnJl7TM6o97v
	VzCWpcqee35Eqz3f7kVAAAwkv50jhEtU+S8tGUCCvVdhBBDDEFsPgUivFPBQXgbEDe2ICpnAu8Gux
	UFduYfTBrobWOIuXtOHBv+40xlOVZ4bQonazgZ5YovTvO4d6VmjjKe083TUTu3PF6WhMBODaucKXa
	IlFV0rAtkKXsek69+bVhU6hT8qdl/ViIQSMiykgBK1ifdSsF8ISPb1LAdUMSLXk7mnQuyuqINp80p
	biL548TZt+DRYtp7GGksQjUw0TiyBk4uq2SnSMoHWlcutV+PatsUPtonSemG5RZHSHkoEKplTj4Qj
	MEp2pywg==;
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGwq9-0000000GfTB-25YR
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 11:08:11 +0000
Date: Wed, 14 Oct 2026 13:08:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791976085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l4HIVicNUEkWaEf5vxreRaAv/P+iiyWT06y2a+BOPck=;
	b=nB6LFWfZvb8nqlWPiOb13UkngmDtaGsp/QS9XPkasOJ8ITVIizl4r3tQZJ0yL0qyi6CeOc
	81bbrJQumGG8Gv/y0Ps+h2CH9Z25ifL1Ynqus4BGX0yvIW7b+8raic/ddxDVZ/zx2vSqlU
	pkRcs8kkShGvMHJd01nYDdTW+pyuD/ZhMUP+1ZiW2nFaDMcOQdYCO6Vx3jDQY8rhtDSGs6
	oQPECjuoGdzWJUlrtXTGb4TxDdI2jDTmJoGjfx6jUT0sd7SIy1RceCuzLrgPFzGPJCYW88
	5EY9tBu3ygBLeAz0ZmHLGW+OX6dW8e8tvJwoLzic8OIcrGi1PrB9O2EcCR9o7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791976085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l4HIVicNUEkWaEf5vxreRaAv/P+iiyWT06y2a+BOPck=;
	b=pnHayja4QgBTOO90/DVNLIclCUyCzXLwNHAYkrwFM9XyUDN5y5XkXt1mBdqixkYG1S4tIQ
	rprbRQUHVC+2dYAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>,
	Surabhi Gogte <sgogte@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH 1/5] nvme-tcp: initialize pf_cache_lock when allocating
 the controller
Message-ID: <20261014110804.VsqI0ZaP@linutronix.de>
References: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>
 <20261014-nvme-fabrics-isolcpu-v1-1-355156be27b2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-nvme-fabrics-isolcpu-v1-1-355156be27b2@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_120809_730454_D1D96C9B 
X-CRM114-Status: GOOD (  12.02  )
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

On 2026-10-14 09:46:39 [+0200], Daniel Wagner wrote:
> From: Daniel Wagner <wagi@kernel.org>
> 
> Since commit 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation
> and startup") the I/O tag set is allocated before the I/O queues.
> blk_mq_alloc_tag_set calls nvme_tcp_init_request for every request,
> which takes pf_cache_lock of the request's queue, but nvme_tcp_alloc_queue
> initializes that mutex only later.  With CONFIG_DEBUG_MUTEXES the first
> connect triggers DEBUG_LOCKS_WARN_ON(lock->magic != lock) in
> __mutex_lock and lock debugging is disabled.
> 
> Initialize pf_cache_lock for all queues when allocating the controller
> and keep it for the lifetime of the controller.
> 
> Fixes: 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation and startup")

I only see 2a8513091d2f0 ("nvme-rdma: parallelize I/O queue allocation
and startup"). That tcp commit is not in next-20261013.

Other than that, it looks reasonable ;)
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Sebastian

