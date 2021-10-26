Return-Path: <SRS0=3UZ0=PO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B11C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Oct 2021 14:27:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F038460E8F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Oct 2021 14:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F038460E8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qUicgF0s+7G+2LrcSe3uUQE5ax4fo3FLUwl7N8RYjC4=; b=NojJueHsNndMR9srzqipHNj8Rm
	D+jC/T1rkvL3rR7eGqoA9H1N/SKP5eTJwVas/FrZ1AAoXgoIZuGmt7yCJlxYqdLVcwuBi5qAjwwbF
	sl9bqg+zk825b/eiYggdDPMj7j7MVe4WdxbSznjM1Ns2TJnEYNTN00N8y79Dq6XKYEqE8cpPHDDdh
	uhLStAwlLize1nbXztsay7N5I7rlLTsDCPcZ/QgOQej4cP249MsDCOXKs1IU6pXuB5BjkR4WzGMpt
	3s8aidrgLRUEkoSm0hrmzTKBO66TOEDHgE3il7HfwkVtVdSasU7HxQGy2POTI5d0iBUyBns2Y6NvV
	JN1rgxuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfNQY-0021HC-NC; Tue, 26 Oct 2021 14:27:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfNQV-0021Gt-1O
 for linux-nvme@lists.infradead.org; Tue, 26 Oct 2021 14:27:44 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35A7F60F9B;
 Tue, 26 Oct 2021 14:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635258461;
 bh=zUzohTtTvqCqelBMurDc4bzNa1yYZdOpqCvcKYkcxLw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sy1FwFMCZjYYUbTylo4YMC+92/YtIirJxnJwXHzPeDWUejNQTjrzPdMQ+C6xfDeFs
 A+NPHpLQ0rzx6GlDoYtNvNgjDmLdS9AO7HTc3u0/JYmEDb8dwKLW6AgOGDl0UIcSAY
 7SG52HOVVgFlfnxkCZO6NlMUINqiiWqOo1QZbV/6qnW47GnIhjfADPX/K9gZCBbAcO
 1GsdGBbPovBaTtGGUlbFKQpA93IsnKaPKPFiDSQKuIpY/wU4a97e7mO9G3iYcMvHof
 eemDwCG8ujMrmCggS5zSTIjYlpCEGtgG1gbW+ARapXJEXnS7v5PBuRNCbcZFTFRQpt
 X6Ugbkwlu2gig==
Date: Tue, 26 Oct 2021 07:27:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Varun Prakash <varun@chelsio.com>
Cc: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: fix possible req->offset corruption
Message-ID: <20211026142739.GA2337066@dhcp-10-100-145-180.wdc.com>
References: <1635255115-3028-1-git-send-email-varun@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635255115-3028-1-git-send-email-varun@chelsio.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211026_072743_146612_8287AE60 
X-CRM114-Status: GOOD (  20.14  )
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

On Tue, Oct 26, 2021 at 07:01:55PM +0530, Varun Prakash wrote:
> With commit db5ad6b7f8cd ("nvme-tcp: try to send request in queue_rq
> context") r2t and response PDU can get processed while send function
> is executing.
> 
> Current data digest send code uses req->offset after kernel_sendmsg(),
> this creates a race condition where req->offset gets reset before it
> is used in send function.
> 
> This can happen in two cases -
> 1. Target sends r2t PDU which resets req->offset.
> 2. Target send response PDU which completes the req and then req is
>    used for a new command, nvme_tcp_setup_cmd_pdu() resets req->offset.
> 
> Fix this by storing req->offset in a local variable and using
> this local variable after kernel_sendmsg().

Nice catch.

Reviewed-by: Keith Busch <kbusch@kernel.org>
 
> Fixes: db5ad6b7f8cd ("nvme-tcp: try to send request in queue_rq context")
> Signed-off-by: Varun Prakash <varun@chelsio.com>
> ---
>  drivers/nvme/host/tcp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 22da856..2217897 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1048,6 +1048,7 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
>  static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
>  {
>  	struct nvme_tcp_queue *queue = req->queue;
> +	size_t offset = req->offset;
>  	int ret;
>  	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
>  	struct kvec iov = {
> @@ -1064,7 +1065,7 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
>  	if (unlikely(ret <= 0))
>  		return ret;
>  
> -	if (req->offset + ret == NVME_TCP_DIGEST_LENGTH) {
> +	if (offset + ret == NVME_TCP_DIGEST_LENGTH) {
>  		nvme_tcp_done_send_req(queue);
>  		return 1;
>  	}
> -- 
> 2.0.2
> 

