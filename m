Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E083EC19F32
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ITh2RUVY5wCCil+wQIfZR9V+b9msHaRgp63zMH1h+lc=; b=W31mJv5s8s6siXny/qIA0Qetwy
	XfWAE7aAryui4c9vW4bWSUapLD7rng+Ihl6xadVegN9e/k9MYxPGSCaaS5ot7VQ5CUzrVHjuGjLY9
	kqCYGqhnbAL+g12qF729DNQcZpjY8hYsWfMObAbABHw7enghuuFRi0MJpiFDuaJh++qUDYctXkmCH
	dT9jsNt2Gt6ORZ6fZTY/W2T/WhtdEc3iqyOfbmNIJRSS8rt294qCu/B5BW0SFXhGSWyH6GobAJSFe
	fROcLZW0FejlknVnlyMYztxP8WH2vTw3IhHd0sArNKwbRZhwabt2H3WCXzikaeQvrzXpDxqRQ9nF2
	YdMIolIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpppL-00000008MmO-023F;
	Wed, 05 Mar 2025 14:34:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpphA-00000008LHC-2gtq
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 14:26:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5863368AFE; Wed,  5 Mar 2025 15:25:55 +0100 (CET)
Date: Wed, 5 Mar 2025 15:25:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix signedness bug in
 nvme_tcp_init_connection()
Message-ID: <20250305142554.GA18330@lst.de>
References: <0f3be9ff-81a1-4c33-8960-75de2c239ae0@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f3be9ff-81a1-4c33-8960-75de2c239ae0@stanley.mountain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_062600_822259_43C0D2AB 
X-CRM114-Status: GOOD (  14.81  )
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

On Fri, Feb 28, 2025 at 12:39:41PM +0300, Dan Carpenter wrote:
> index 8a9131c95a3d..361b04ec5b5d 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1495,7 +1495,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
>  	msg.msg_flags = MSG_WAITALL;
>  	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
>  			iov.iov_len, msg.msg_flags);
> -	if (ret < sizeof(*icresp)) {
> +	if (ret < (int)sizeof(*icresp)) {
>  		pr_warn("queue %d: failed to receive icresp, error %d\n",
>  			nvme_tcp_queue_id(queue), ret);
>  		if (ret >= 0)

I hate these magic casts.  What about something like:

	if (ret >= 0 && ret < sizeof(*icresp))
		ret = -ECONNRESET;
	if (ret < 0) {
		...


