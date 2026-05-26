Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CECCD5BCF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2026 07:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0z5maDlDTON8GJtNKuGXn+nKsAnpNJVFGq8zv88jh3g=; b=PxKCv/rp7SbQDiYsoDl+GnAGWN
	fd6OJZVJpE+hG+e92TVmcd9ugUNfHxYOfeXRapJ9DUm5Pe6mcISmwm2flVeSoFrW6Cd3931ZTAJUx
	LRAZG8fxObSt7zCETGFlCwKJq4AbBwtuqQKZ54NkJMNOXE6eU3+c54rN5mj2bmV/wz61+tSSYL3H2
	4HKMzid4hpdVC+ApB4Q82SuaQT4KPfIlXlnzVDoe1/Czx5i5jGQh3vrcSr/HG4Lu7Aq9CU0q7DST3
	hsuvDv9Z0Dl5WKaaAxv9zArsQE00HJhKxlEH++hU2Knfttm6yBlvw7bOApOoTMBuZQgP1wDcMsTHx
	+hVrXHwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRlxV-00000001ElB-1iBq;
	Tue, 26 May 2026 07:12:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRlxR-00000001Eju-3mt4
	for linux-nvme@lists.infradead.org;
	Tue, 26 May 2026 07:12:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C245968AFE; Tue, 26 May 2026 09:12:01 +0200 (CEST)
Date: Tue, 26 May 2026 09:12:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geliang Tang <geliang@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Roy Shterman <roys@lightbitslabs.com>,
	Solganik Alexander <sashas@lightbitslabs.com>,
	Hannes Reinecke <hare@suse.de>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: fix page fragment cache leak in error path
Message-ID: <20260526071201.GA25581@lst.de>
References: <39d57858464bb3933160d6f7583640db086fbb80.1779702494.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39d57858464bb3933160d6f7583640db086fbb80.1779702494.git.tanggeliang@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_001210_143477_A8A1239B 
X-CRM114-Status: GOOD (  15.50  )
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

On Mon, May 25, 2026 at 05:50:19PM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> In nvmet_tcp_alloc_queue(), when a connection is closed during the
> allocation process (e.g., nvmet_tcp_set_queue_sock() returns -ENOTCONN),
> the error handling jumps to out_free_queue without draining the page
> fragment cache.

nvmet_tcp_set_queue_sock jumps to out_destroy_sq.

> Although nvmet_tcp_free_cmd() is called in some error paths to release
> individual page fragments, the underlying page cache reference held by
> queue->pf_cache is never released. This results in a page leak each time
> a connection fails during allocation, which could lead to memory
> exhaustion over time if connections are repeatedly opened and closed.
> 
> Fix this by calling page_frag_cache_drain() before freeing the queue
> structure in the out_free_queue label.

The first allocation using pf_cache is the call to nvmet_tcp_alloc_cmd
after ida_alloc.  So afaik this drain should at the out_ida_remove
label.  And given how obscure this is, maybe a comment would not
hurt either?

Otherwise this looks good.

