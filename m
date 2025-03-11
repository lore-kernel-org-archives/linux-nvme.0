Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50E3C2BA1B
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 18:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fzKhdeCz+LOTuoztW6ATNx7ZgVg3yjLCRJj2p7g5swc=; b=P1t/dtHK3zpYy5yAHXuGtBANJV
	QhLa5qIMvGC6WxfKx2+tYJfXTw/dXw1dh89V/yyoaqwZ774bHXWTqU31eXfliJnK3SFZYwDdr7fTl
	7RTCZh+k1fnsTl3yAEX111nQYOuIsvlmJ3aNxyiUHho0GjMw2Y9o2SREiqagYUUb6B23gr+zRJ2Om
	cAmtCRKtsOX4aJlGEUG5BFOnfiVe+nn4cBxAKG9DNkhSJga908Xvrdse9/PfF21b3DqRFw6sLj0P8
	V5hrAfULdpHS1ywIhHzaXlsdBRNSjpAh/FPziszr922xUSo4ZvRnOP1E9BQgKXEUhkrgbnR6pa20m
	tZPO7UHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ts4gV-00000006gEc-0FBf;
	Tue, 11 Mar 2025 18:50:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ts4Yq-00000006fB4-0D4O
	for linux-nvme@bombadil.infradead.org;
	Tue, 11 Mar 2025 18:42:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:In-Reply-To:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fzKhdeCz+LOTuoztW6ATNx7ZgVg3yjLCRJj2p7g5swc=; b=S6/oyBOXrVMEw6L2aRR+s1wF45
	L4vRpe6H6jrz1GwOC63REsnUHxjrDIl40D6MCo1ZaC/dZwrIBGc0YWlAp5bGWMkOV9+lL8pfrkEID
	4VwCHaw7gb1Und3V100qbuUSHlyLAIAQJaPr0yjP01l3rsEnjc/ZHUA3nDLK5lgg9j+D6VSFBQoFj
	eEykBjraZlqJZO8Uq+WSDoKpsyrdVlziYe4+P1Mk5v/lIhvjk9Za2F8JLBc3ZvGpKSklWq07OgFDc
	dV73whQHjSuoMPzutl0hWb6JlKP0GMpuYpAnx3GdaAu11lZafpKs84zecjTXIr8ITPGPagAX6/2XZ
	20+5ibRA==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ts4Yn-00000002DaS-0LEZ
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 18:42:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741718553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fzKhdeCz+LOTuoztW6ATNx7ZgVg3yjLCRJj2p7g5swc=;
	b=ID5pFKNtMI2j80wo1XNcHNwi+140sc0p4P5q+GjJitY8lRxUuZPCyYm0Yms87UHLw+2eIw
	o47mlDvdDF3yYjqYtUTll6Em6bKEHgfROgMUAWfwUXWkU3r2WbrsBMX1hk+kRK4TGGl3x0
	a85+k9wiKOPJxOwZVdlU0MqXLyA8Ocg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741718554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fzKhdeCz+LOTuoztW6ATNx7ZgVg3yjLCRJj2p7g5swc=;
	b=YgnjvFf5apxNUeLBAK+mWolf4g+xBj1E9UbtWAWORw7/F6S6pR718q+RbUKtO1sRfPcrGE
	XsU87YC9GCrONwAGOm93wiWUxLPdt8V0SpIw4cnz/nhTEg8qIeAb8aUVa2TdsqxQgK3jS1
	/TDtjBbn+2zCP/TleoXY/aVAkP6aV7k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-qCXckJADMMSFhwgFHpTg_w-1; Tue,
 11 Mar 2025 14:40:59 -0400
X-MC-Unique: qCXckJADMMSFhwgFHpTg_w-1
X-Mimecast-MFC-AGG-ID: qCXckJADMMSFhwgFHpTg_w_1741718456
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7BCE1955D6D;
	Tue, 11 Mar 2025 18:40:56 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.2.17.23])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C589019560AB;
	Tue, 11 Mar 2025 18:40:54 +0000 (UTC)
Date: Tue, 11 Mar 2025 11:40:51 -0700
From: Chris Leech <cleech@redhat.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvme-tcp: avoid inline sending when handling R2T PDUs
Message-ID: <Z9CDs7Vhl6R1aVFM@my-developer-toolbox-latest>
References: <20250307132802.111513-1-hare@kernel.org>
 <20250307132802.111513-2-hare@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250307132802.111513-2-hare@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P9N0D2A7JjABK8YTgA7nyYNyr-XWe6FWGPmgvYJMZNM_1741718456
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_184237_264190_6BF7B418 
X-CRM114-Status: GOOD (  23.08  )
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

On Fri, Mar 07, 2025 at 02:28:00PM +0100, Hannes Reinecke wrote:
> When handling an R2T PDU we should not attempt to send consecutive
> PDUs as we are running from an softirq context, and sending PDUs
> from the receive context will mess up latencies.
> So just queue it and let the io_work workqueue function do the work.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  drivers/nvme/host/tcp.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 

Am I missing something, or does this patch not actually change anything?
With sync=false nvme_tcp_queue_request will queue io_work, so what is
removing that flag and open coding in handle_rt2 accomplishing?

- Chris

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 8c14018201db..034edf852878 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -391,7 +391,7 @@ static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
>  }
>  
>  static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
> -		bool sync, bool last)
> +		bool last)
>  {
>  	struct nvme_tcp_queue *queue = req->queue;
>  	bool empty;
> @@ -405,7 +405,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>  	 * are on the same cpu, so we don't introduce contention.
>  	 */
>  	if (queue->io_cpu == raw_smp_processor_id() &&
> -	    sync && empty && mutex_trylock(&queue->send_mutex)) {
> +	    empty && mutex_trylock(&queue->send_mutex)) {
>  		nvme_tcp_send_all(queue);
>  		mutex_unlock(&queue->send_mutex);
>  	}
> @@ -758,7 +758,9 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
>  	req->ttag = pdu->ttag;
>  
>  	nvme_tcp_setup_h2c_data_pdu(req);
> -	nvme_tcp_queue_request(req, false, true);
> +
> +	llist_add(&req->lentry, &queue->req_list);
> +	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>  
>  	return 0;
>  }
> @@ -2531,7 +2533,7 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
>  	ctrl->async_req.curr_bio = NULL;
>  	ctrl->async_req.data_len = 0;
>  
> -	nvme_tcp_queue_request(&ctrl->async_req, true, true);
> +	nvme_tcp_queue_request(&ctrl->async_req, true);
>  }
>  
>  static void nvme_tcp_complete_timed_out(struct request *rq)
> @@ -2683,7 +2685,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
>  
>  	nvme_start_request(rq);
>  
> -	nvme_tcp_queue_request(req, true, bd->last);
> +	nvme_tcp_queue_request(req, bd->last);
>  
>  	return BLK_STS_OK;
>  }
> -- 
> 2.35.3
> 
> 


