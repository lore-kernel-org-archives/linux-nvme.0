Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52ED606A31A
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 23:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UyIKHxuI;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1Ga0sQ7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YOE9zxrNKax2JkchOH7/1IG0IQ1S7GmH8Auc8qD48TU=; b=UyIKHxuIMHmLo2OFZHOmYahxGI
	ah4is+raRbhgx0voOL1xWN1vEOEUEWO9K5glH8pxp29ngtgM6hnhEyd6C8LOLZVp/mZNlTrBP2Dbo
	ZMpsDa/I5jekyuNVVUcaMtm7P8tSUwL8lZDAWb+khjMhxQlPTxC/bVtDquwxHudkneimmye57b5Kw
	sA18RLBtqIhvEWy1Pq33STy5FMKLZTQnRVPYCVWnAVzzJ0lO9PeMkMCcCu1o8bY87i++AsTPdT1O9
	smmV42RrThcPIJR5isFcxj2ztVU+wXJfNxCUs+NyP8KjwyBQ5qU1g/DwYL73iusX0f1c64gwLAvdH
	NBw8AGlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLqDv-00000005tNz-0fd1;
	Tue, 27 Oct 2026 23:04:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLqDt-00000005tNt-1ZxA
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 23:04:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C46CF41A0B;
	Tue, 27 Oct 2026 23:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5163D1F01825;
	Tue, 27 Oct 2026 23:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793142292;
	bh=YOE9zxrNKax2JkchOH7/1IG0IQ1S7GmH8Auc8qD48TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A1Ga0sQ7QwTXszn2AN0v6Qftalj1+97wvk1BdOHhjbfMFDthk41RJheMKDL0QGJHZ
	 64OGoICGqGDPAbnprTDVAHZJDD0IDKhKOANSurqq2DVFBjHwzXzDSRuIK2vMxqZo8c
	 cU7IuOw3PuZTHbQ5kWgxGE4pkZw+3YHtWMrevnBPzowUSCBBqZ1yTcYbIseAN1tIHh
	 YWg8CAvqoW8vNg3PILRJSJsKw2ULAV9JVRtjPTGDjAoZ7vJD6dh0ezg/trrPgVFKnb
	 wyqSSohontetoadD0wpu5M9M6/XphKfzlcaUj8iWBQf3JAfw8TXio1OwzeKWvT4QyR
	 eRwo7WmCb3fNg==
Date: Tue, 27 Oct 2026 17:04:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, hare@kernel.org, sgogte@purestorage.com,
	wagi@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-tcp: fix request PDU size when header digest is
 enabled
Message-ID: <auEuEoILz3cndXOV@kbusch-mbp>
References: <20261027194710.334495-1-christian.aurichzm@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027194710.334495-1-christian.aurichzm@gmail.com>
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 04:47:10PM -0300, Christian Aurich Zanettini Martins wrote:
> Since commit 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation
> and startup") the I/O tag set is allocated before the I/O queues.
> nvme_tcp_init_request() sizes the PDU with nvme_tcp_hdgst_len(queue),
> but queue->hdr_digest is only set later by nvme_tcp_alloc_queue(), so
> every I/O PDU is allocated without room for the header digest.
> 
> With hdr_digest enabled, the digest is then written 4 bytes past the
> PDU, over the header of the next PDU in the page_frag cache, and the
> target drops the connection on the first I/O:
> 
>   nvmet_tcp: unexpected pdu type 159
>   nvmet: ctrl 1 fatal error occurred!
> 
> Queues that a later reconnect adds for the first time have the same
> problem.
> 
> Set queue->hdr_digest when allocating the controller, together with
> pf_cache_lock, so it is valid before any request is initialized.

Thanks, applied to nvme-7.4.

> @@ -1948,7 +1948,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>  		}
>  	}
>  
> -	queue->hdr_digest = nctrl->opts->hdr_digest;
>  	queue->data_digest = nctrl->opts->data_digest;
>  
>  	rcv_pdu_size = sizeof(struct nvme_tcp_rsp_pdu) +
> @@ -3098,10 +3097,13 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
>  	/*
>  	 * The I/O tag set is allocated before the I/O queues, and initializing
>  	 * its requests already allocates the PDUs from the page frag caches of
> -	 * the queues, so initialize their locks here.
> +	 * the queues, sized by their header digest setting, so set up the
> +	 * locks and hdr_digest here.
>  	 */
> -	for (i = 0; i < ctrl->ctrl.queue_count; i++)
> +	for (i = 0; i < ctrl->ctrl.queue_count; i++) {
>  		mutex_init(&ctrl->queues[i].pf_cache_lock);
> +		ctrl->queues[i].hdr_digest = opts->hdr_digest;
> +	}

A follow on bonus patch can clean this up a bit by introducing a helper
function, maybe nvme_tcp_init_queue(), and initialize all the basic
fields there.

