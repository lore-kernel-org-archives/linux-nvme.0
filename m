Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAF9C636CC
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Feb 2023 06:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zGmpAvzCdgFAmTJNAzaijTb+kKF96qa7eUG/1biudOw=; b=jwffFWw3lVl2ip1Id8hZ8Osygx
	z88IO3hI8FEt8Qm0usot3xWOZ7KOLN7oOd0Y2E1fjCL+FYhdQEroKA1uQt1/nPk2qgUT2Wd3Ga6eX
	HXtDK5nLqchk9Er68RNgkrevUdC00OZLHtu4TwIDk6JRwq/++kxO4xl1eRG/GPudSJIQI9wtisW6O
	k4OcyXitLOwIdLlwNdQU0fETNJnLikvACeZJs32drHEdBWlBQ2qsUHzmvw0a/5tYtGoqkI9E0GKSF
	kTFnmih513cLJckNhxDE+4aapZbFdYaFdQINPquRAWaucKvHaNaiTGGqXjmGLiWhYjuyz7AqMIwst
	dF10LzTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPdvw-00EIdr-EW; Wed, 08 Feb 2023 06:27:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPdvn-00EIcL-O8
	for linux-nvme@lists.infradead.org; Wed, 08 Feb 2023 06:27:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9664068BFE; Wed,  8 Feb 2023 07:27:37 +0100 (CET)
Date: Wed, 8 Feb 2023 07:27:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: check for allocated queue in
 nvme_tcp_get_address()
Message-ID: <20230208062737.GA14870@lst.de>
References: <20230207145548.113618-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207145548.113618-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230207_222747_964014_FC32C565 
X-CRM114-Status: GOOD (  20.82  )
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

On Tue, Feb 07, 2023 at 03:55:48PM +0100, Hannes Reinecke wrote:
> We need to check if the queue is allocated, otherwise we get
> a kernel crash as 'queue->sock' is not allocated.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/tcp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 4ddf3e7b252a..487ea3e8b6c4 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2859,6 +2859,9 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
>  	struct sockaddr_storage src_addr;
>  	int ret, len;
>  
> +	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
> +		return -EINVAL;

I'm not sure this is enough.  The queue could be freed right after
this check.  I think we have to cache the address information
somewhere instead and ensure that it is always valid.

