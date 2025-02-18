Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DA4C02198
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 15:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QVwLNtzumTrPUd45IoqcnP6q3vtQFfpRRPa4lxdtWzM=; b=CI8gu/nqzSGoDzrhJ3AAj5D35N
	lFwIg7tYvC0LBZi8FjpLUtnrZlKZGgL7Odsm3cRuqFQ1HHxrlUV8B7vCeMAx9ASHT5w85VgC1A+NH
	GWaiJLl22UAda/c+953TFH1lkLvWN2ywCJJDNJz68qzkyIQQZjIS/2P8OKLRa0TEVik/zxhO/Pea3
	ZhLtWvOKycXwSnNbkYlEcGqY5Hzuq4Bwwn+ZRpX4OzZxr8WYIOsGNSHhCyQ0fUQM8KInVN6cXcRf5
	yoTZkeys7lT2zCWBN7c2vYksvetpVGkm85dt+rr7BxYfq650TdK7dlwIoehtKGrkdKotl5l1I26w2
	fjCzczNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPNm-00000008jPR-3UtL;
	Tue, 18 Feb 2025 15:19:34 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPNk-00000008jP2-1SBf
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 15:19:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A3934A41035;
	Tue, 18 Feb 2025 15:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC65C4CEE7;
	Tue, 18 Feb 2025 15:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739891971;
	bh=IJZK+MM8rmpJOGYsqPoh7c2IIDiPoxj8iLMXkA6jyGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n+Mxq62u4k8jU2YPfy4dfg8Rgc8Wtd5CPj2UgLzSXIo7UOZXFdB6DJu58+TwNT+v7
	 cSbMnr9xK+A9EVvs2J2wfsfbdcVv3lp9FhR512sSuZwnUO3IhH6UcYyoiKeKQHOIpF
	 Xi+5rsXxEN0gxRJ1tiFK/y6qnivdWrvGiOmzSEs1lMSk0NSrGkjhXcLDCH5VfjLMcS
	 t+3vRYHurmRArEfEf4zMa05zudQt30DB1z9Tj/uJjqWzlTMb3P8qJRsNFQAkqUQhJV
	 IPy13GQsWMlXCkliewfHsThhYSmqDGcilsRf34Y/bfyEGurGEHqeQSJwxL3mgi2hZf
	 3++IZ9Q5S8fvA==
Date: Tue, 18 Feb 2025 08:19:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Meir Elisha <meir.elisha@volumez.com>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvmet-tcp: Enforce update ordering between queue->cmd
 and rcv_state
Message-ID: <Z7SlAMLxwjuRwEBe@kbusch-mbp>
References: <20250217142210.2144548-1-meir.elisha@volumez.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217142210.2144548-1-meir.elisha@volumez.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_071932_453099_91FF1610 
X-CRM114-Status: GOOD (  20.26  )
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

On Mon, Feb 17, 2025 at 04:22:10PM +0200, Meir Elisha wrote:
> The order in which queue->cmd and rcv_state are updated is crucial.
> If these assignments are reordered by the compiler, the worker might not
> get queued in nvmet_tcp_queue_response(), hanging the IO. to enforce the
> the correct reordering, set rcv_state using smp_store_release().
> 
> Signed-off-by: Meir Elisha <meir.elisha@volumez.com>
> ---
> v2: Change comments to c-style
> 
>  drivers/nvme/target/tcp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 7c51c2a8c109..49ce2f9ac6c8 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -848,7 +848,8 @@ static void nvmet_prepare_receive_pdu(struct nvmet_tcp_queue *queue)
>  	queue->offset = 0;
>  	queue->left = sizeof(struct nvme_tcp_hdr);
>  	queue->cmd = NULL;
> -	queue->rcv_state = NVMET_TCP_RECV_PDU;
> +	/* Ensure rcv_state is visible only after queue->cmd is set */
> +	smp_store_release(&queue->rcv_state, NVMET_TCP_RECV_PDU);
>  }
>  
>  static void nvmet_tcp_free_crypto(struct nvmet_tcp_queue *queue)
> @@ -1017,7 +1018,8 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
>  	cmd->pdu_recv = 0;
>  	nvmet_tcp_build_pdu_iovec(cmd);
>  	queue->cmd = cmd;
> -	queue->rcv_state = NVMET_TCP_RECV_DATA;
> +	/* Ensure rcv_state is visible only after queue->cmd is set */
> +	smp_store_release(&queue->rcv_state, NVMET_TCP_RECV_DATA);
>  
>  	return 0;
>  
> -- 
> 2.34.1
> 
> This ordering is critical on weakly ordered architectures (such as ARM)
> so that any observer which sees the new rcv_state is guaranteed to also
> see the updated cmd. 

Something seems off if smp_store_release() isn't paired with
smp_load_acquire(). Why does the reader side not need a barrier?

