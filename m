Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49881CD4F3C
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 06:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O1AnQQz2zbPIJjvLg/dbRHXXjSeYWQUT2KgI8WLGBss=; b=HwLrRlA5k6A83gc520aDsf4OGn
	pryUBpok3/4CujKm/JJSKBquloQskryOeqD0yBVklQwQ2FxdSaF9k9fiQqSyMlxlySFx4EwBIfIYe
	dTQ4wlrMcDGHBFkZMSTfxJmmWasCphr8UtjuSUyw4u7fqzDzeNO0hs0WZ3oHeiQqQ7JVs/HnqfXpV
	2T3vshccmOq7XcTlT/T3HIe30jV48aFhDvN53i1OfK7/Sq/2vUWVZo7W6gCqiBEqIjH88yL5vboJ7
	Qwbfr7PIkgjZEtdrOBlZhyMChDbUhqOWuiZm4jeqOwDHGBcG8Z0mqT56GQYZy8zDXCKyprraUfVtc
	gOAx4P3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPE7C-00000000NGf-35ui;
	Tue, 19 May 2026 06:39:42 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPE79-00000000NFe-0gGn
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 06:39:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=+1YB2An817xfLS
	ayhkdApUvBpzmcxc+KJdpsNbhjpLI=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=Uf3Ks3SePdwLtNSp52aM7SE5jhQ++SBGXd5RT
	i3DBBYGxf/7e7SJQyuIHQmGdmV1l8rlPTibgMMYyoeC4qE39kJuXi1epkq7UZEOHavY47d
	br7UQ4yGlTqqZR+zMW95MqbQNytC7rLdlLzXAioCWXgNmphS1bX7jZhQ6uhloIm3X32o4q
	SuL9paI1TffqgrBnDmtqbbeiEjdAbZ0QhEeZLcNb54x+3BaPtQydxi9o8AjPIqvCVufeHR
	O2b2UiYCbKqMX9oocBQkreIk2pSaPYcQMwAAD3Fq+L7PMMAUq0h411qa6eBgIOALi/NsmP
	or3e53g40ZEbc5IrW//JesKRQ==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 114d66d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 08:39:33 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 08:39:33 +0200
Message-Id: <DIMG40N1AP7Y.YMM2POCWCLN3@arkamax.eu>
Cc: "Geliang Tang" <tanggeliang@kylinos.cn>,
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/2] nvmet-tcp: remove duplicate cancel_work_sync in
 release_queue_work
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Geliang Tang" <geliang@kernel.org>, "Christoph Hellwig" <hch@lst.de>,
 "Sagi Grimberg" <sagi@grimberg.me>, "Chaitanya Kulkarni" <kch@nvidia.com>,
 "Hannes Reinecke" <hare@suse.de>, "Keith Busch" <kbusch@kernel.org>,
 "Maurizio Lombardi" <mlombard@redhat.com>, "John Meneghini"
 <jmeneghi@redhat.com>
X-Mailer: aerc 0.21.0
References: <cover.1779170418.git.tanggeliang@kylinos.cn>
 <246690f4c28333cc83f63081a36b85174465c9b7.1779170418.git.tanggeliang@kylinos.cn>
In-Reply-To: <246690f4c28333cc83f63081a36b85174465c9b7.1779170418.git.tanggeliang@kylinos.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_233939_825018_1C9A6940 
X-CRM114-Status: GOOD (  14.59  )
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

On Tue May 19, 2026 at 8:10 AM CEST, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> The cancel_work_sync(&queue->io_work) is called twice in
> nvmet_tcp_release_queue_work(). Remove the second one as it is redundant.
>
> Fixes: a208fc5672177 ("nvmet-tcp: fix a race condition between release_qu=
eue and io_work")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  drivers/nvme/target/tcp.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 8a243d22a511..af7ce384b3cf 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1616,7 +1616,6 @@ static void nvmet_tcp_release_queue_work(struct wor=
k_struct *w)
>  	nvmet_tcp_uninit_data_in_cmds(queue);
>  	nvmet_sq_destroy(&queue->nvme_sq);
>  	nvmet_cq_put(&queue->nvme_cq);
> -	cancel_work_sync(&queue->io_work);
>  	nvmet_tcp_free_cmd_data_in_buffers(queue);
>  	/* ->sock will be released by fput() */
>  	fput(queue->sock->file);

I think that the second cancel_work_sync() is done because
nvmet_sq_destroy() can potentially end up calling
nvmet_req_complete()

nvmet_sq_destroy() -> nvmet_async_events_failall() ->
nvmet_req_complete() -> queue_response()

and this kicks a new io_work.

Maurizio

