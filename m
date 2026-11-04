Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D30B606A331
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qkFOl5Fp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KJsQjtz5oT6PM9pXKEz3tHUWBZ19ymJyMqMLPOKPx7k=; b=qkFOl5FpWHsbMlLpI6au390A8c
	O7Mi9prCVA4T4dw3hB9J6Xrrtb3FuQEUMW/gs3xmPUBvEmdvHNuHLp30trY1CD62VhfMfd5BXjM/f
	Ad3+Mxe2/0JEh3QcZmIWxJ029grS5f41RWGW6lU/Qo4yXQZt052Y4/ITu5Pg+HybjBpdDCY3V9J24
	PBHYFfcCLfzscc/tAs3k0B8Ia+8o6nlouR7s+p3d4RZkvaXz/Ub1WrE/X+FrWLjgd5x/t9pdQyu0M
	WUvf4ydJorztGX4JOssnyUwtu99ksytOsSVE/peLML2Q65IHZWk2GpBCtDD7SsMq6aN4MsACP1v84
	qknnMJag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOVh7-00000004apb-0cEF;
	Wed, 04 Nov 2026 07:46:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOVh2-00000004aoC-1f0v
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 07:46:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C959C68BEB; Wed,  4 Nov 2026 08:45:54 +0100 (CET)
Date: Wed, 4 Nov 2026 08:45:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>,
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
Message-ID: <20261104074554.GA29620@lst.de>
References: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de> <20261103163748.qDpZjKj8@linutronix.de> <20261104071703.GC28939@lst.de> <20261104073710.kTUsM3JV@linutronix.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104073710.kTUsM3JV@linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_234600_581431_8D7DB9DE 
X-CRM114-Status: GOOD (  20.91  )
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 08:37:10AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-11-04 08:17:03 [+0100], Christoph Hellwig wrote:
> > On Tue, Nov 03, 2026 at 05:37:48PM +0100, Sebastian Andrzej Siewior wrote:
> > > What about
> > > 	guard(rcu);
> > > 	for_each_cpu_and(cpu, cpu_online_mask, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)) {
> > > 		if (!cpu_is_isolated(cpu)
> > > 			break;
> > > 	}
> > > 
> > > this ends up with one less function call ;)
> > 
> > Please avoid this completely unreadable and unaditable guard crap.
> 
> If you/ block prefers to avoid guard() then fine. I usually get punched
> the other way around.
> 
> > How is anyone supposed to understand that above mess?
> 
> I can show you code where you start crying.

I don't cry easily, but I've basically given up trying to understand
or fix code infested too much by at and other CLASS/__cleanup magic
like the core VFS code, because my brain can't cope with it...

> Anyway. My main selling
> point was for_each_cpu_and().

I guess the advantage would be to reduce the iteration, so it's 
probably ok.  I don't find it particularly easier to read, and given
that this is a slow path it might not matter.


