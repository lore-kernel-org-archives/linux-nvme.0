Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB5FC001DF
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 13:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ikT4eVyvU7rhrS+ize2bjoA90gbY2TMQg4mIfd48ApQ=; b=N7cxQYfk0dXDvWFvpFak2IuV0Q
	DmQ/dZeSHswBLqEoopY1w5ikzAhPBlJNKFQegziL/3mmLuD+lqK28aeRfG5Zoq+AbdUIH/gJh6XP4
	hlH3h4LVCioHa91kUG7mp24hM2yNVYGP4ibWZ/+eais4iIKYYe9+NAIKLzoUl55/V+9eOSfuPnS0f
	Ty42WrPIUdwnwwiekNPz0Jk+22xNnrRRHmK6wWf3ZJhqb6X+6hk+Aq6bcBj1RWjRmkRHqoNTGBXkQ
	BPP0tW0JdRZ+bjOkiF/KYkdRPK9GzAadSzYjp9gI1offoy/dXA9rL6G6x33qJyGnxRObSJIkIpir2
	SVNBtLag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTFv-00Fr4X-08;
	Mon, 31 Jul 2023 13:48:15 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTFs-00Fr34-0C
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 13:48:13 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3fe23319695so1860455e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 31 Jul 2023 06:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690811289; x=1691416089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikT4eVyvU7rhrS+ize2bjoA90gbY2TMQg4mIfd48ApQ=;
        b=aLayGXG9tbag614/HU9E1845Xa8Pl5m17BZ7ccvNH/ZimpZTiiaHFUy/0aWFnvkZ6I
         KX6KlfjBOV+nA9DM8uN6Shp5J6Fvrold8Z9b73dMUTqP+HBGJ0sqbtG8SSnR32rd4YAJ
         ja4Z4G1DDTbNyb5M3kHevq5eruRton+ESybXEnZLD/gtuPd/mCnQ8pUjlXxhmuC7ZA89
         JoR/g4qo6klapEHy/TwdFcOIMUd9w1ItZ86GTRhZvLp/F/tyhJC8LWfoJveSxmeqUsoN
         DX0328heTc3dq+8al+/p9VJTLXAHnRGhKfdFGDR5anI0Y61Mcd1cdD9BjRuNDicSPDjL
         k5YA==
X-Gm-Message-State: ABy/qLaiyWDJtAjcyx+9ljFQYPbd7iv1CgC2V5DFiXqPjbWa0c0ylGAk
	49qYlG+Wz2AVki4yyLfg6LU=
X-Google-Smtp-Source: APBJJlHzIl7oBxUG9npgFa7lnX//G0bzokzmDd6/BDw6xr9rfZFGMTY9Ml/5ICTHv5ypgn2mJoEnGg==
X-Received: by 2002:a05:600c:1e11:b0:3f8:efad:31ee with SMTP id ay17-20020a05600c1e1100b003f8efad31eemr5927310wmb.2.1690811289035;
        Mon, 31 Jul 2023 06:48:09 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003fbd9e390e1sm14212166wml.47.2023.07.31.06.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 06:48:08 -0700 (PDT)
Message-ID: <3e08284a-9163-a83f-b7eb-e5b697e45947@grimberg.me>
Date: Mon, 31 Jul 2023 16:48:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nvmet-tcp: fix data digest calculation for multiple
 H2CData PDUs
Content-Language: en-US
To: Varun Prakash <varun@chelsio.com>, hch@lst.de
Cc: linux-nvme@lists.infradead.org, Rakshana Sridhar <rakshanas@chelsio.com>
References: <20230727150731.5905-1-varun@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230727150731.5905-1-varun@chelsio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_064812_102343_3FD407BA 
X-CRM114-Status: GOOD (  22.96  )
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

> On receiving H2CData PDU current code calculates data digest for the entire
> transfer length, it works if host sends only one H2CData PDU per cmd, if
> host sends multiple H2CData PDU per cmd then target reports data digest
> error.
> 
> This issue was fixed in commit fda871c0ba5d ("nvmet-tcp: fix receive data
> digest calculation for multiple h2cdata PDUs").
> 
> commit ed0691cf5514 ("nvmet-tcp: fix regression in data_digest
> calculation") reverted the fix done in the above commit.
> 
> Fixes: ed0691cf5514 ("nvmet-tcp: fix regression in data_digest calculation")
> Signed-off-by: Rakshana Sridhar <rakshanas@chelsio.com>
> Signed-off-by: Varun Prakash <varun@chelsio.com>
> ---
>   drivers/nvme/target/tcp.c | 31 +++++++++++++++++++++++++++----
>   1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 05163751f2e5..e5e3498675af 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -415,8 +415,8 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
>   	return NVME_SC_INTERNAL;
>   }
>   
> -static void nvmet_tcp_calc_ddgst(struct ahash_request *hash,
> -		struct nvmet_tcp_cmd *cmd)
> +static void nvmet_tcp_send_ddgst(struct ahash_request *hash,
> +				 struct nvmet_tcp_cmd *cmd)
>   {
>   	ahash_request_set_crypt(hash, cmd->req.sg,
>   		(void *)&cmd->exp_ddgst, cmd->req.transfer_len);
> @@ -447,7 +447,7 @@ static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)
>   
>   	if (queue->data_digest) {
>   		pdu->hdr.flags |= NVME_TCP_F_DDGST;
> -		nvmet_tcp_calc_ddgst(queue->snd_hash, cmd);
> +		nvmet_tcp_send_ddgst(queue->snd_hash, cmd);
>   	}
>   
>   	if (cmd->queue->hdr_digest) {
> @@ -1152,11 +1152,34 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
>   	return nvmet_tcp_done_recv_pdu(queue);
>   }
>   
> +static void nvmet_tcp_recv_ddgst(struct ahash_request *hash,
> +				 struct nvmet_tcp_cmd *cmd)
> +{
> +	struct bio_vec *iov = cmd->iov;
> +	struct scatterlist sg;
> +	u32 data_length = cmd->pdu_len;
> +
> +	sg_init_table(&sg, 1);
> +	crypto_ahash_init(hash);
> +
> +	while (data_length) {
> +		sg_set_page(&sg, iov->bv_page, iov->bv_len, iov->bv_offset);
> +		ahash_request_set_crypt(hash, &sg, NULL, iov->bv_len);
> +		crypto_ahash_update(hash);
> +
> +		data_length -= iov->bv_len;
> +		iov++;
> +	}
> +
> +	ahash_request_set_crypt(hash, NULL, (void *)&cmd->exp_ddgst, 0);
> +	crypto_ahash_final(hash);
> +}

Maybe instead of (re)coding crypto_ahash_digest, maybe we can do a
little hack to pass the request sg from cmd->sg_idx which is already
set when we build the pdu?

Something like:
--
+static void nvmet_tcp_calc_recv_ddgst(struct ahash_request *hash,
+               struct nvmet_tcp_cmd *cmd)
+{
+       struct scatterlist *sg;
+       u32 sg_offset;
+
+       sg = &cmd->req.sg[cmd->sg_idx];
+
+       /*
+        * adjust the offset for the first sg element if the received bytes
+        * is not aligned to page size (and adjust back after the ddgst
+        * calculation). A bit hacky but we don't need to do the hash digest
+        * update per sg entry this way.
+        */
+       sg_offset = cmd->rbytes_done % PAGE_SIZE;
+       sg->offset -= sg_offset;
+       __nvmet_tcp_calc_ddgst(hash, sg, (void *)&cmd->exp_ddgst, 
cmd->pdu_len);
+       sg->offset += sg_offset;
  }
--

untested but I think it should be ok. It's kinda hacky but prevents
us from doing it entry by entry. Maybe it's too ugly.

