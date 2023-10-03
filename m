Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F1FE7AD78
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Oct 2023 16:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RWGSFLvn3PrkusXh7MBceL7AtiQ/tilWHf4r3zGln5Y=; b=k94iVMCm1JIuo5kgDrekwYINcq
	+Cy/mBY2YiWkZZYyufzswYsCVUNA4x+aZ8h3ajSM7qqtXFB84efCcQ9aiM+7aJeKhB+wzoPRGmqRj
	odTOjxd+kbfrulnmqWulkgL4gJdmTiXb80M0Rh5eJPrcDQS0+hHM6gB+IYRc0vNCOpf2HkE25k61t
	6V8vExC1wH+cOpOI8uxdJGdcXwiLLSHJM6sUQK34sXzyZcRXfALyf4tmFPP6ikzdGKrH8ub/WdXxk
	FiEC+zh0DwR3WROpLze1P1BgMH39rcNPgaS604I1r4OkfimCBcCmqj/x+dAuIEB/pOZDgwjJ9hcxP
	Woe+UESg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qniXk-00EzdL-0t;
	Tue, 03 Oct 2023 16:46:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qniXh-00Ezc8-2Q
	for linux-nvme@lists.infradead.org;
	Tue, 03 Oct 2023 16:46:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A048F612D7;
	Tue,  3 Oct 2023 16:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE218C433C7;
	Tue,  3 Oct 2023 16:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696351600;
	bh=b9xYQ/SIeRx1steUhZNvfdYjdKSQQNxP5+nQLygoX8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eis379LSrq4moB6PeZW1RvAM4nhf0sZKfGfS3cT0rK95JV6R/CGaRr8qFu1aVUFAv
	 2j34VOtmyC12+JgmRgtoZAB7ILlBAt9i66WpxuDKol2q+ozw+BwLnonx0y2OeyM1ss
	 Ow+qqzB+OHQfuoXujya8AA8Ui3j5w2iIY251ByO2wkC5JxjTLfgbL3B2gt0Z2uWxUq
	 G88Q8VARki+3hHa8tl3rWmSYAymOI0RN8mQw6nrpXE2G3GwfiDJJvqKgQZIRJStemV
	 AXmIjwo9mABdKrd3v8UZXnPpONgWF57z1h+YIkVo1yLky67eiBc19PqntINn8fkYE9
	 KK0mNobKeWoaQ==
From: sj@kernel.org
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	zahavi.alon@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: Fix a possible UAF in queue intialization setup
Date: Tue,  3 Oct 2023 16:46:37 +0000
Message-Id: <20231003164638.2526-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002105428.226515-1-sagi@grimberg.me>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231003_094641_863241_499A5367 
X-CRM114-Status: GOOD (  22.89  )
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

Hello,

On Mon, 2 Oct 2023 13:54:28 +0300 Sagi Grimberg <sagi@grimberg.me> wrote:

> From Alon:
> "Due to a logical bug in the NVMe-oF/TCP subsystem in the Linux kernel,
> a malicious user can cause a UAF and a double free, which may lead to
> RCE (may also lead to an LPE in case the attacker already has local
> privileges)."
> 
> Hence, when a queue initialization fails after the ahash requests are
> allocated, it is guaranteed that the queue removal async work will be
> called, hence leave the deallocation to the queue removal.
> 
> Also, be extra careful not to continue processing the socket, so set
> queue rcv_state to NVMET_TCP_RECV_ERR upon a socket error.
> 
> Reported-by: Alon Zahavi <zahavi.alon@gmail.com>
> Tested-by: Alon Zahavi <zahavi.alon@gmail.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Would it be better to add Fixes: and Cc: stable lines?


Thanks,
SJ

> ---
>  drivers/nvme/target/tcp.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 97d07488072d..d840f996eb82 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -372,6 +372,7 @@ static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
>  
>  static void nvmet_tcp_socket_error(struct nvmet_tcp_queue *queue, int status)
>  {
> +	queue->rcv_state = NVMET_TCP_RECV_ERR;
>  	if (status == -EPIPE || status == -ECONNRESET)
>  		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>  	else
> @@ -910,15 +911,11 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
>  	iov.iov_len = sizeof(*icresp);
>  	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
>  	if (ret < 0)
> -		goto free_crypto;
> +		return ret; /* queue removal will cleanup */
>  
>  	queue->state = NVMET_TCP_Q_LIVE;
>  	nvmet_prepare_receive_pdu(queue);
>  	return 0;
> -free_crypto:
> -	if (queue->hdr_digest || queue->data_digest)
> -		nvmet_tcp_free_crypto(queue);
> -	return ret;
>  }
>  
>  static void nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
> -- 
> 2.41.0
> 
> 

