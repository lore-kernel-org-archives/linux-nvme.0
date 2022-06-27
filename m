Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04E4C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 06:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FH4jSVws9haryRdZSRMDZOzK4AKXTyKxRKHPdjPvt8Q=; b=MQlGY01pbC0ow6Oh2evH6XTp3L
	3sRb9sBUDT3Hx8emjEjVnsI/+bU4/0R+Y271gTocyqg4iCWaBEJPYwhsXjhH7DYG52FUXbWko5WUg
	qeVtxWZlGflzg+3X5FwujKYDm8gHXKivXugGfN4ef9dQEtifbj72V40COXjMP6k96v+/pVHT4D6cZ
	oCgcHIqXcK2BKmBfUUeTuQ9nw85PQoGxugDQMP/ay6qGFhD8LmyqizvNThoBTp+zxQ0UIPMlrkQCP
	rjzxgYOlrQhBHnPIXg41wY+OEPX4I6X8o2/wCGRalJxwodIP8Wi8tY9/Gj6R9dtlU6HLMfO0hCd6+
	lpX0q9Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5iY0-00GBEa-Re; Mon, 27 Jun 2022 06:48:36 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5iXx-00GBB0-4S
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 06:48:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2430B21BED;
	Mon, 27 Jun 2022 06:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1656312509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FH4jSVws9haryRdZSRMDZOzK4AKXTyKxRKHPdjPvt8Q=;
	b=YxkBit0vRWPuZy3VJPVxyojwXrq7vUH8ihpPECVZb/MnzrKo3tdfXNb1tyg44C+ZffnfGr
	lRcGEwgQ68wVENe+zJy+pViOqLMfR1nyJ8K/9Z358LJWyhK1M6tklFOuaosX/KjrCsub1A
	cv/1HYFXF6BI5gBZe4IG2lXSEYCxUlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1656312509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FH4jSVws9haryRdZSRMDZOzK4AKXTyKxRKHPdjPvt8Q=;
	b=1en4jZExnYlsa7z7LMKVpDOko5vXEv35rBP1nQ8m221hZ54UKvFIohIXHOVCJYSbxWVaNI
	yL/lF2dPZG6V3uCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 167F913456;
	Mon, 27 Jun 2022 06:48:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id urxeBb1SuWLZYQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 27 Jun 2022 06:48:29 +0000
Date: Mon, 27 Jun 2022 08:48:28 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-tcp: always fail a request when sending it failed
Message-ID: <20220627064828.7b2dmnwks675mu53@carbon.lan>
References: <20220626092451.32694-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626092451.32694-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220626_234833_395579_3BD90F98 
X-CRM114-Status: GOOD (  22.61  )
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

On Sun, Jun 26, 2022 at 12:24:51PM +0300, Sagi Grimberg wrote:
> queue stoppage and inflight requests cancellation is fully fenced from
> io_work and thus failing a request from this context. Hence we don't
> need to try to guess from the socket retcode if this failure is because
> the queue is about to be torn down or not.
> 
> We are perfectly safe to just fail it, the request will not be cancelled
> later on.
> 
> This solves possible very long shutdown delays when the users issues a
> 'nvme disconnect-all'
> 
> Reported-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

I've tested the case where we disconnect all controllers in a multipath
setup. In this scenario we reliable ended up waiting for a register
read/write in the shutdown path. With this path, the I/O fails
immediately and we don't wait the extra time out time for the I/O to fail
eventually.

Tested-by: Daniel Wagner <dwagner@suse.de>

> ---
>  drivers/nvme/host/tcp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index bb67538d241b..009c2cf3f106 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1180,8 +1180,7 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>  	} else if (ret < 0) {
>  		dev_err(queue->ctrl->ctrl.device,
>  			"failed to send request %d\n", ret);
> -		if (ret != -EPIPE && ret != -ECONNRESET)
> -			nvme_tcp_fail_request(queue->request);
> +		nvme_tcp_fail_request(queue->request);
>  		nvme_tcp_done_send_req(queue);
>  	}
>  	return ret;
> -- 
> 2.34.1
> 

