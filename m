Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47C606A333
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iFAJsb3S
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CQTCeZqbhnIGeurfVoO3U6+eh5QntykGwlsWYRX83A0=; b=iFAJsb3St916JDLyTwZpC/voJF
	b+cP9g9d3feRn+KRhvZM/j66jdxU0ORhCdOXT2qoXJTSVJjMMgP54WNoR/M/4+GX2BVLqtSckCr5S
	eVjlwD/JKvjyPsOgZsgd3887dOq7qgLRFr+qB5tn59JJ3n3eZTf/cM1Pjz6WCcvRerRbDNBYoJcyi
	XBpEfkf1qLLR+FmaNGFWMtQKu65088erLgrnXkBUjXdO37LsoJLQ+uVz7G5ZDMhO6q37eEPZPIh9c
	ycI6/ZUeMb+sYDqdQB+EBnc0Precv51MhRZZ9Awr9j6SxOhSqMA9Z5fRc+qnohHBrEWlBRWuL7BWW
	VC1LkYLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOVF9-00000004Ue2-22T1;
	Wed, 04 Nov 2026 07:17:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOVF7-00000004Ud5-20hU
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 07:17:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8613B68BFE; Wed,  4 Nov 2026 08:17:03 +0100 (CET)
Date: Wed, 4 Nov 2026 08:17:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20261104071703.GC28939@lst.de>
References: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de> <20261103163748.qDpZjKj8@linutronix.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103163748.qDpZjKj8@linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_231709_686551_35F371A2 
X-CRM114-Status: GOOD (  12.62  )
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

On Tue, Nov 03, 2026 at 05:37:48PM +0100, Sebastian Andrzej Siewior wrote:
> What about
> 	guard(rcu);
> 	for_each_cpu_and(cpu, cpu_online_mask, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)) {
> 		if (!cpu_is_isolated(cpu)
> 			break;
> 	}
> 
> this ends up with one less function call ;)

Please avoid this completely unreadable and unaditable guard crap.

How is anyone supposed to understand that above mess?


