Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494C3CD4F5B
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 07:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TGGOXQmqj5JjTtGFSrcjha2MGSLjj4f8QR5jJSt+EqA=; b=zaF3ELQjEDm/Xx4ONkarDOwtKV
	zHzdITJkKg7t6X7dIdirZMVG4X5nqjR3v/zdKTE1dfeH6p9agFdlcjaB6ndU/d8zfOUuZucWluF6z
	ZGc0gVlIaseSnqfDw0OvAi9y4JIbMkScGFbs9/endXpy69r7mUJ5pdDXtSUMzwq+ZMCpVkgAIQP4t
	rmcordXS2nAAZZyDMlMdi/gWNb7OTAjuQzMMY3OI1mrp0WE2nX53ClhbbT89MmU5HOvMm/mWE3Q15
	BazWSDLMNmQ/y9gMylihJkiji9u5yaDWSVof0nmPaEbr1eCXIhppSoaRgGYzeFHLAjYIkY4kF2O24
	P/MkLUeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPFFR-00000000Z5c-4C4W;
	Tue, 19 May 2026 07:52:18 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPFFQ-00000000Z52-034c
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 07:52:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4B3C24436D;
	Tue, 19 May 2026 07:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102A6C2BCB3;
	Tue, 19 May 2026 07:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779177135;
	bh=fTMgLCJXbTNQwcL55iBBYGIAtce49kttu9j66ZNQqZM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qOB+G255r2dJj+4sDPaDR+yXwr8vHiJVHuGPqTt2nyY2wLHag3VwPDW7n+yZoKgyt
	 HSabOB09Mkv7YDjvVYbglY1MKuu/jPx4u1K770E8EEhCmlGLq9zpx5eLV7Dj8a7/Za
	 L5HLjoxYpuR5qOYqyawiFhnsOeaDdefRWNCir7hnhirguk39qlR/M6O2ZxtAZssbWx
	 Vcu/wQBeDmQwtVoHH9QX2oKHx71+H2n5cBYupEGTL4gzVteLToky+lpwSFPiJzGXg2
	 AOK3k/dgKmj99xUYxlZCEJyATMXcP9JsYg2s4TI3jfCPbppxbA2JH6AqvHLZpFRCOS
	 uz9nEeioMhHCw==
Message-ID: <9e01f2a39159d86cc5a342397cfd6383328a7ac5.camel@kernel.org>
Subject: Re: [PATCH 2/2] nvmet-tcp: remove duplicate cancel_work_sync in
 release_queue_work
From: Geliang Tang <geliang@kernel.org>
To: Maurizio Lombardi <mlombard@arkamax.eu>, Christoph Hellwig <hch@lst.de>,
  Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, Maurizio
 Lombardi <mlombard@redhat.com>, John Meneghini	 <jmeneghi@redhat.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org
Date: Tue, 19 May 2026 15:52:08 +0800
In-Reply-To: <DIMG40N1AP7Y.YMM2POCWCLN3@arkamax.eu>
References: <cover.1779170418.git.tanggeliang@kylinos.cn>
	 <246690f4c28333cc83f63081a36b85174465c9b7.1779170418.git.tanggeliang@kylinos.cn>
	 <DIMG40N1AP7Y.YMM2POCWCLN3@arkamax.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_005216_076711_EF031893 
X-CRM114-Status: GOOD (  21.14  )
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

Hi Maurizio,

On Tue, 2026-05-19 at 08:39 +0200, Maurizio Lombardi wrote:
> On Tue May 19, 2026 at 8:10 AM CEST, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > The cancel_work_sync(&queue->io_work) is called twice in
> > nvmet_tcp_release_queue_work(). Remove the second one as it is
> > redundant.
> > 
> > Fixes: a208fc5672177 ("nvmet-tcp: fix a race condition between
> > release_queue and io_work")
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  drivers/nvme/target/tcp.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > index 8a243d22a511..af7ce384b3cf 100644
> > --- a/drivers/nvme/target/tcp.c
> > +++ b/drivers/nvme/target/tcp.c
> > @@ -1616,7 +1616,6 @@ static void
> > nvmet_tcp_release_queue_work(struct work_struct *w)
> >  	nvmet_tcp_uninit_data_in_cmds(queue);
> >  	nvmet_sq_destroy(&queue->nvme_sq);
> >  	nvmet_cq_put(&queue->nvme_cq);
> > -	cancel_work_sync(&queue->io_work);
> >  	nvmet_tcp_free_cmd_data_in_buffers(queue);
> >  	/* ->sock will be released by fput() */
> >  	fput(queue->sock->file);
> 
> I think that the second cancel_work_sync() is done because
> nvmet_sq_destroy() can potentially end up calling
> nvmet_req_complete()
> 
> nvmet_sq_destroy() -> nvmet_async_events_failall() ->
> nvmet_req_complete() -> queue_response()
> 
> and this kicks a new io_work.

Thanks for the clarification!

When I was adding code to nvmet_tcp_release_queue_work [1], AI review
reported this duplicate cancel_work_sync issue to me.

You are right. I missed that nvmet_sq_destroy() can trigger
nvmet_req_complete() -> nvmet_tcp_queue_response(), which
queues io_work again. So the second cancel_work_sync() is
indeed necessary.

Let's drop this patch.

Thanks,
-Geliang

[1]
https://patchwork.kernel.org/project/mptcp/patch/c796d0260ffebddcaf413f7c5a3d4b3783e814a2.1779159524.git.tanggeliang@kylinos.cn/

> 
> Maurizio

