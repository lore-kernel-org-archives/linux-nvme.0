Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC08CD6E57
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 10:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rqdbFhnrEuxasCnLv2W7Y80kjNrFYfx6PUMJ0O+PdvA=; b=trZBNoK8I4BUm3pNBJfMvrFfx6
	mY9vdVG2XVPASI7xoMtIb+yjwA9vCQNwAsemlkva5UXl5mwvV8LVgq1o+Ru3ClX6uWVP0lywzLlME
	L7z6CtQjVT0dq95m+kwU5oVHNOgnNn8PsKzLldYV18cztJAMSPsCxp4OypdaOPRBMdBuKcc7mIMUn
	QTqaufEkrw1CQFeP2zE4giYzgUIpXv8FILZ8zifv4IZU21EHJK04rkazZWDaVsiO3g3BI8ibCJgrU
	Tm20BUxnKwyFFFQZt2QddbDwZYosCXObk2et2Dh+J6h16b4BqmFDQ+cWULUZv+D6JLgVfA90JjpT4
	aWiMHAyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUM7U-0000000Ck7f-1KxK;
	Tue, 02 Jun 2026 10:13:12 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUM7R-0000000Ck6m-029F
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 10:13:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4938E443BD;
	Tue,  2 Jun 2026 10:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9681F00893;
	Tue,  2 Jun 2026 10:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780395188;
	bh=rqdbFhnrEuxasCnLv2W7Y80kjNrFYfx6PUMJ0O+PdvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FnS9meFTN6M/JBLioKTSFNaVLQ0Q7PIxqzgHMSZXiVDTpNiG3COWTrD1x3JBIGB7M
	 9gXPPbfdO5lIJAm0DxcVOFUFrNRMIzdsodHo+W8uTQyce2qUiJ7yKkPFSjcBXuFA5j
	 gle/GtlzElF4TYQVJfQ0F+YGu97TEF3qLKEWe4MIEQ+9LIjvERvSh8yxxGK2vEefOv
	 r9Epfwv4htrTjym4JvFVmciUJ4JmeWBj/wxOzYp5/tM7gOqZPQD4uQaabWRb/kQsiL
	 4U/qozXMHemaylj/Sl00Xjw5YN/tNirkcmGg7aQ5Ie6m/4fOhYeJDVhResbC4seDC7
	 oIBb+ZOxqtDVQ==
Date: Tue, 2 Jun 2026 11:13:02 +0100
From: Keith Busch <kbusch@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 2/2] nvme-tcp: lockdep: use dynamic lockdep keys per
 socket instance
Message-ID: <ah6srseW316tqOZa@kbusch-mbp>
References: <20260530052045.296749-1-shinichiro.kawasaki@wdc.com>
 <20260530052045.296749-3-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530052045.296749-3-shinichiro.kawasaki@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_031309_160680_240D9F67 
X-CRM114-Status: GOOD (  12.34  )
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

On Sat, May 30, 2026 at 02:20:45PM +0900, Shin'ichiro Kawasaki wrote:
> -static void nvme_tcp_reclassify_socket(struct socket *sock)
> +static void nvme_tcp_reclassify_socket(struct nvme_tcp_queue *queue)
>  {
> -	struct sock *sk = sock->sk;
> +	struct sock *sk = queue->sock->sk;
> +
> +	lockdep_register_key(&queue->nvme_tcp_sk_key);
> +	lockdep_register_key(&queue->nvme_tcp_slock_key);

...

> @@ -1468,6 +1473,11 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
>  	kfree(queue->pdu);
>  	mutex_destroy(&queue->send_mutex);
>  	mutex_destroy(&queue->queue_lock);
> +
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
> +	lockdep_unregister_key(&queue->nvme_tcp_slock_key);
> +#endif
>  }
>  
>  static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
> @@ -1813,7 +1823,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>  	}
>  
>  	sk_net_refcnt_upgrade(queue->sock->sk);
> -	nvme_tcp_reclassify_socket(queue->sock);
> +	nvme_tcp_reclassify_socket(queue);

On a subsequent error in this function, I think you need to call
lockdep_unregister_key directly in on of the goto error cases since we
don't call nvme_tcp_free_queue for this failed queue.

