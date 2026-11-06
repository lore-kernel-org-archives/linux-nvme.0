Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E6D606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pe2Oer1F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ROnX3Nt7A5boPei9LatpyCyRjgC4NGMOOepN6Pc8qqM=; b=pe2Oer1FyW4fSvfhzpEXBfp3pq
	LpsmfoEwOnzANqZc3F/pFVKOM7dspGpX7yIrHvgDsZrxc79Gn0Jm0/3Jgi3zZYNQXB6M4T8MeRABf
	dCHDVbvnbN80DYHTkaDuaQgOv7fwd7KQXaP4CdgDUiD5sXR4kuH2AmThtkon9cGPNX5VtbGNt+aLN
	WHrg8KRePdj5qDwEe0JFvj7yuywzQWpI0zG074hCC12wpsd67KcMf/n1ERBS1ky9KcJaRCWNtHhdF
	pH3aKU4BKMlkA/JmWcGK7T/4obmlAB2nv9X6KCcFXMy/K8m+l/e6qSysZ58T4E7akWD5/Fc/ytCnH
	csvSexPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHHe-0000000BxB7-0KLR;
	Fri, 06 Nov 2026 10:34:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHHb-0000000BxAg-0GA8
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 10:34:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8413068BEB; Fri,  6 Nov 2026 11:34:51 +0100 (CET)
Date: Fri, 6 Nov 2026 11:34:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/6] nvmet: take subsys->lock in
 nvmet_subsys_attr_tbkas_store()
Message-ID: <20261106103451.GC5453@lst.de>
References: <20261106015842.3534898-1-kanie@linux.alibaba.com> <20261106015842.3534898-5-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106015842.3534898-5-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_023455_249397_9B351D31 
X-CRM114-Status: GOOD (  18.49  )
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
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 09:58:40AM +0800, Guixin Liu wrote:
> The tbkas store handler walks subsys->ctrls to force every controller
> to reconnect, but it holds only nvmet_config_sem for write.
> subsys->ctrls is protected by subsys->lock: nvmet_alloc_ctrl() adds an
> entry under subsys->lock, and nvmet_ctrl_free() removes it under
> subsys->lock with list_del() + kfree(). A concurrent controller
> teardown can therefore corrupt the walk.
> 
> This is the same bug fixed for nvmet_subsys_attr_qid_max_store() in
> commit 9f426f140511 ("nvmet: take subsys->lock while
> force-reconnecting in nvmet_subsys_attr_qid_max_store()"), which
> missed this second instance of the pattern. Take subsys->lock around
> the list_for_each_entry() loop. ->delete_ctrl() only queues
> asynchronous controller teardown, so it does not re-enter subsys->lock
> under the loop.
> 
> Fixes: e98e45e9465b ("nvmet: Add traffic based keep alive support to configfs")

I'm pretty sure I saw this fly by already in the last days.  If
that wasn't you we might already have something like this in the
queue.

If not:

Reviewed-by: Christoph Hellwig <hch@lst.de>


