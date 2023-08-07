Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3A3EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 11:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LRJSF4PvbClJhVe2Qd2v17vUM8IVHQZnmG7bWG1heOQ=; b=iHlnmF5vyXkPTQc2MLPkzmlpt4
	iCKQdVlnref7At+ZsLAQ9IaRga0eogtczS5QbLGZTLsJPmbrFPT4VhsnfXHlbuoevwHy2fnezLE/I
	dxozkuzKHGF2zrsIcwFjuJ+MvCQ+e9blgr6uIsAobj8I1KDRgddY7Z5uthZ4gcK3yLxrER9EByqOu
	DItp6p6Gg6AI5xCOHy/fXfB5bB6T1w9l9xUuqpXqTArE/xhD3fM9oohjSu17qqwj1nAiJD7u5uP/a
	kAEyigz0Ls5WnybMSXIZ5pwAi6XXZB6//++EmC+vEuUwL1yl0nBE+B1YXzlm/Zwnt0ghcvCfBfIRI
	3iTWWDOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSyTs-00H63V-2U;
	Mon, 07 Aug 2023 11:33:00 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSyTp-00H631-2f
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 11:32:59 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3fe1b6192e8so12716625e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 07 Aug 2023 04:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407975; x=1692012775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRJSF4PvbClJhVe2Qd2v17vUM8IVHQZnmG7bWG1heOQ=;
        b=YRVeBsmriHD13URkrJsVz3gtjGTRwaCpil7XQV3MFL43jwT6M7lFUYN9C/iai593uV
         WMG+UwNBDqWJrsKKY1UAKv1nd6gYdMJsBdI+XsW/UTc/aZPm0doWAaMN8l8QVn44pu3l
         j0ottCScZqNBH1RV7NPmWtD7hzdy10P5irmk0ZfG9MGoejqpSYBeB58FXEA4c+EzXiTM
         L+Av68ZkFoqMsfubfmrinzjc5Kg4Lbv8dBTOYYjoTxF8ZiHrbGNrXGnSjFOEtEAVNQCn
         0S3xb+Usgfk3fMtDgXyIDoSg0DdrL6+xpYiGk42kzkkh4GgvTcLNRZ71V1/crMukgkXq
         ++pQ==
X-Gm-Message-State: AOJu0Yy6kz6oXlXRNgh1Sf/aO85HaTHF0Th09/73SC4iw8rwuM4GCAia
	mnSf1XHP0m88/mTueemgX9I=
X-Google-Smtp-Source: AGHT+IEXBffm+OehTboIwyemk85/L7ybd0x+oAQ7BrUPQfdQYukJatLhJ6n3RV/FOt4CsJ4wYczzZw==
X-Received: by 2002:a05:600c:c0d:b0:3fe:427c:477e with SMTP id fm13-20020a05600c0c0d00b003fe427c477emr9822681wmb.4.1691407974830;
        Mon, 07 Aug 2023 04:32:54 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c230500b003fc01f7a42dsm10464928wmo.8.2023.08.07.04.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 04:32:54 -0700 (PDT)
Message-ID: <eb0ec990-50f2-128b-93ea-5a997e36bdee@grimberg.me>
Date: Mon, 7 Aug 2023 14:32:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] nvmet-tcp: fix data digest calculation for multiple
 H2CData PDUs
Content-Language: en-US
To: Varun Prakash <varun@chelsio.com>, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, Rakshana Sridhar <rakshanas@chelsio.com>
References: <20230803105839.6139-1-varun@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230803105839.6139-1-varun@chelsio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_043257_866605_B2B4435E 
X-CRM114-Status: GOOD (  23.82  )
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



On 8/3/23 13:58, Varun Prakash wrote:
> On receiving H2CData PDU current code calculates data digest for the entire
> transfer length, it works if host sends only one H2CData PDU per cmd, if
> host sends multiple H2CData PDU per cmd then target reports data digest
> error.
> 
> This issue was fixed in commit fda871c0ba5d ("nvmet-tcp: fix receive data
> digest calculation for multiple h2cdata PDUs").
> 
> commit bac04454ef9f ("nvmet-tcp: fix kmap leak when data digest in use")
> unmaps iovec before calculating data digest and
> commit 69b85e1f1d1d ("nvmet-tcp: add an helper to free the cmd buffers")
> sets cmd->nr_mapped = 0 after unmapping iovec, both of these commits
> caused regression in data digest calculation.
> 
> To fix this regression commit ed0691cf5514 ("nvmet-tcp: fix regression in
> data_digest calculation") changed the logic to use sg directly instead of
> iovec, it calculates data digest for the entire transfer length this
> caused another regression for multiple H2CData PDU per cmd case.
> 
> Fixes: ed0691cf5514 ("nvmet-tcp: fix regression in data_digest calculation")
> Signed-off-by: Rakshana Sridhar <rakshanas@chelsio.com>
> Signed-off-by: Varun Prakash <varun@chelsio.com>
> ---
> 
> v2:
> - used sg instead of iovec for data digest calculation
> - updated commit message
> 
>   drivers/nvme/target/tcp.c | 42 ++++++++++++++++++++++++++++++++++++---
>   1 file changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index cd92d7ddf5ed..4d72b4b2b205 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -415,7 +415,7 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
>   	return NVME_SC_INTERNAL;
>   }
>   
> -static void nvmet_tcp_calc_ddgst(struct ahash_request *hash,
> +static void nvmet_tcp_send_ddgst(struct ahash_request *hash,
>   		struct nvmet_tcp_cmd *cmd)

We should call it nvmet_tcp_calc_send_ddgst

>   {
>   	ahash_request_set_crypt(hash, cmd->req.sg,
> @@ -447,7 +447,7 @@ static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)
>   
>   	if (queue->data_digest) {
>   		pdu->hdr.flags |= NVME_TCP_F_DDGST;
> -		nvmet_tcp_calc_ddgst(queue->snd_hash, cmd);
> +		nvmet_tcp_send_ddgst(queue->snd_hash, cmd);
>   	}
>   
>   	if (cmd->queue->hdr_digest) {
> @@ -1152,11 +1152,47 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
>   	return nvmet_tcp_done_recv_pdu(queue);
>   }
>   
> +static void nvmet_tcp_recv_ddgst(struct ahash_request *hash,
> +		struct nvmet_tcp_cmd *cmd)

We should call it nvmet_tcp_calc_recv_ddgst

> +{
> +	struct scatterlist *sg = &cmd->req.sg[cmd->sg_idx];
> +	struct bio_vec *iov = cmd->iov;
> +	u32 data_length = cmd->pdu_len;
> +
> +	crypto_ahash_init(hash);
> +
> +	if (iov->bv_offset) {
> +		struct scatterlist first_sg;
> +
> +		sg_init_table(&first_sg, 1);
> +		sg_set_page(&first_sg, sg_page(sg), iov->bv_len,
> +				iov->bv_offset);
> +
> +		data_length -= iov->bv_len;
> +
> +		if (data_length) {
> +			ahash_request_set_crypt(hash, &first_sg, NULL,
> +						iov->bv_len);
> +			crypto_ahash_update(hash);
> +			sg = sg_next(sg);
> +		} else {
> +			ahash_request_set_crypt(hash, &first_sg,
> +					(void *)&cmd->exp_ddgst, iov->bv_len);
> +			crypto_ahash_finup(hash);
> +			return;
> +		}

What is the case for data_length=0 ? I'm not entirely clear how this can
happen.

> +	}
> +
> +	ahash_request_set_crypt(hash, sg, (void *)&cmd->exp_ddgst,
> +				data_length);
> +	crypto_ahash_finup(hash);
> +}
> +
>   static void nvmet_tcp_prep_recv_ddgst(struct nvmet_tcp_cmd *cmd)
>   {
>   	struct nvmet_tcp_queue *queue = cmd->queue;
>   
> -	nvmet_tcp_calc_ddgst(queue->rcv_hash, cmd);
> +	nvmet_tcp_recv_ddgst(queue->rcv_hash, cmd);
>   	queue->offset = 0;
>   	queue->left = NVME_TCP_DIGEST_LENGTH;
>   	queue->rcv_state = NVMET_TCP_RECV_DDGST;

