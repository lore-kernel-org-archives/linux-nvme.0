Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD560606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Bwp+vDNT;
	dkim=pass (2048-bit key, unprotected) header.d=arkamax.eu header.i=@arkamax.eu header.a=rsa-sha256 header.s=mail1 header.b=EAYL5sJi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=xsDPcl4VWhweDfiGUPM8Ly7mRWZ2wmjNBixQpr1q+Bc=; b=Bwp+vDNTDzXg6A
	H30TGnU6CtiTWj0s/HvZ+BaxFBhqZ4GK5kEcNzWtEyfaV2HyabxR8lMGnRPoXiuQjOkU4MwJh4mXQ
	zxIJGHtUOvf8tei0kjFXxmsZH2fvpX7gDTZtYQU1abb9pZcCwjukz9Xgd22M17Lq947+U0o7gZ4yH
	va0MBQZ6eYjCuHzaLe8ESwPjuxyOfNPaqYncAy7nlCd8dEN0mX/B9l4WM6WjIunIpSKxs3Z6OuElu
	+FObgO54S639GT9Ng9ESQW9bgStAYDeI/pEClBlbjzfXxsg7Kf5eTGIe5kc3kVX7RXvhO9NFbUGIi
	b1pnnciIoUwx+/1ClHiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSoV-00000009mPM-2g2g;
	Thu, 29 Oct 2026 16:17:15 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSoQ-00000009mOz-3V1B
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 16:17:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=29dGElikh/WBgH
	IvNtOpSKByZ017BhP2xXz/NJ0MDpg=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=EAYL5sJi9ghXvTtsV0bBe0RC4Q/pJi1ucNooI
	axXT+QcHckMclG0gWKHnz2lW4AcSS0DJkzC2HwNizNfwdBdMGAijpeVwRPS0vM8NmX8Ptj
	//iHQmu+lIKxtEf99tDLnuE1ecrFb4VuRgWhgxvi1InlV1AdPWSbObcP6Xa0KWsBxVlJPd
	oF9Ko8yj4qNaXAW0GwXccFx4cPZqQ5ZrziSYVf590mp3Qj+I92dMPU8PnqJxdxErmpriPQ
	1R3rBoHOEJl8Zb61cYdHjHmzfBNJ26QI++2qLVHUpC3Oh0etfIrFSFEPkba6ShwlhWsqIA
	dCs6F1Wg7OUW3KaVTpL8zxOvw==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id beaf6948 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 17:17:05 +0100 (CET)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 17:17:05 +0100
Message-Id: <DMHGH067QOG0.2YOA9906BH1X7@arkamax.eu>
Cc: <axboe@kernel.dk>, <hch@lst.de>, "Josef Bacik" <josef@toxicpanda.com>,
 "Keith Busch" <kbusch@kernel.org>, "Sagi Grimberg" <sagi@grimberg.me>,
 "Hannes Reinecke" <hare@kernel.org>
Subject: Re: [PATCH 08/19] nvme-tcp: start error recovery when a send fails
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Keith Busch" <kbusch@meta.com>, <linux-nvme@lists.infradead.org>
X-Mailer: aerc 0.22.0
References: <20261029155252.2332266-1-kbusch@meta.com>
 <20261029155252.2332266-9-kbusch@meta.com>
In-Reply-To: <20261029155252.2332266-9-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_091711_551806_F581ED20 
X-CRM114-Status: GOOD (  18.40  )
X-Spam-Score: -1.1 (-)
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Oct 29, 2026 at 4:52 PM CET, Keith Busch wrote:
> From: Josef Bacik <josef@toxicpanda.com>
>
> When the target closes a connection, nvme_tcp_state_change() calls
> nvme_tcp_error_recovery(), which does nothing unless the controller is
> live. While connecting that's fine for the queue being set up, its
> Connect fails and the attempt with it. But if an already connected queue
> is closed at the end of the attempt, nothing fails, the notification is
> lost and the controller goes live on a dead socket. Every request on
> that queue then fails with "failed to send request -32" and is retried,
> forever with native multipathing, and if it's the admin queue the first
> keep-alive fails too. Nothing but a manual reset recovers it. The Linux
> target closes its connections at exactly that moment after a fatal
> error.
>
> Start error recovery when a request can't be sent, as nvme-rdma does.
>
> Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Hannes Reinecke <hare@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/tcp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index bc46e5f3eaa79..9e15311e7d9cc 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1437,6 +1437,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue =
*queue)
>  			"failed to send request %d\n", ret);
>  		nvme_tcp_fail_request(queue->request);
>  		nvme_tcp_done_send_req(queue);
> +		/* The close may have come when nobody could act on it */
> +		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
>  	}
>  out:
>  	memalloc_noreclaim_restore(noreclaim_flag);


I remember I posted an identical patch several months ago and I
self-nacked it because it made blktests md/001 fail

https://lore.kernel.org/linux-nvme/DDNRV5MAVQCF.2SH49C0P5MKVF@bsdbackstore.=
eu/

You might want to check if it's still the case before merging it.

Maurizio


