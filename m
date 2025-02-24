Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474FBC021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 14:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A8HaXlR9u2VxW7sZGMGAjhN5x9iZlxNTTKDd/Sk8rKU=; b=Xucm3780Ul8W6L3zaDTrf9XobX
	YxLr+jqUy63ixk2/LBysAvJAMg1Zlwcynr8jTFAf6JgplvKGHjIoHBXpE5oLUKAPQBeBgkrPKzBeo
	3PDrFx68wajmInm+nQMr+KvzmOwg3z8+GF+2bLyo6XluCA3/YVwDVbt87kN6+TN2+qvRGqkLri0Vt
	0rtDlgu8kNEi7oLJH1KOy4VEwpVL9QLsKgcZWwmlO3gLdYq8oySg9qmdaMd9fTrdMrYZ2d7vL/k/I
	PKlxN7LXJOAtUhvIrj4xBN7vGldJ2z8yOurrPf+FBWzd5RhipTjzjKc/A97x5vy3NzWRueUbLM/qt
	0Jfe0COg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmZeU-0000000E8nS-3hcA;
	Mon, 24 Feb 2025 14:41:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmZDa-0000000E30D-3Vw5
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 14:14:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9A7E168B05; Mon, 24 Feb 2025 15:13:49 +0100 (CET)
Date: Mon, 24 Feb 2025 15:13:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Meir Elisha <meir.elisha@volumez.com>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvmet-tcp: Fix a possible sporadic response drops
 in weakly ordered arch
Message-ID: <20250224141349.GA1022@lst.de>
References: <20250223072845.3470297-1-meir.elisha@volumez.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223072845.3470297-1-meir.elisha@volumez.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_061359_017659_15DA6C46 
X-CRM114-Status: GOOD (  23.58  )
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

On Sun, Feb 23, 2025 at 09:28:45AM +0200, Meir Elisha wrote:
> The order in which queue->cmd and rcv_state are updated is crucial.
> If these assignments are reordered by the compiler, the worker might not
> get queued in nvmet_tcp_queue_response(), hanging the IO. to enforce the
> the correct reordering, set rcv_state using smp_store_release().
> 
> Fixes: bdaf13279192 ("nvmet-tcp: fix a segmentation fault during io parsing error")
> 
> Signed-off-by: Meir Elisha <meir.elisha@volumez.com>
> ---
> Changes from v2:
> 	- Fix barrier semantics
> 	- Use rcv_state instead of state variable
> 
>  drivers/nvme/target/tcp.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 7c51c2a8c109..714d920d14e1 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -571,10 +571,13 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
>  	struct nvmet_tcp_cmd *cmd =
>  		container_of(req, struct nvmet_tcp_cmd, req);
>  	struct nvmet_tcp_queue	*queue = cmd->queue;
> +	/* Pairs with store_release in nvmet_prepare_receive_pdu() */
> +	enum nvmet_tcp_recv_state queue_state = smp_load_acquire(&queue->rcv_state);

Ovely long line.

And another thing purely cosmetic: while I generally like initializing
variables at declaration time, doing that for something like
smp_load_acquire which should go with a comment looks kinda weird.

So maybe just split the assignment out from the declaration?

> -- 
> 2.34.1
> 
> This ordering is critical on weakly ordered architectures (such as ARM)

Something weird is going on with this description below the actual
patch.  This should normally go above.


