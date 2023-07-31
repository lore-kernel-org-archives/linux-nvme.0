Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388F7C001DE
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 13:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ytsM7PIFfzlNovndDv1vmd8xZArNHlp4ssMKjJ+U1gk=; b=oE7J38fj2cVGoAJJXfUOA3TInI
	quiZ4YG+BdT7Byqx73nuZOd/3iZQxKTtgVCqanAWdC4b9l/hNZRZtcG59DxHBJMlmsPYa1IcxIXQ0
	WmQFun2L7FJw85gehMr88W+6bTIb2pQrh599iyJlGVH60Hs+iG4qbaKy6WbIK/FT/+Drf27Qy5sgD
	u9E5O6aooZfKptAPCmUTgE3HWZL3zwgwLGR78rVNxtndPy5rlCtybFfVjHuyowX8GNxIAmpwGx5Xh
	MOGTqpzNa3TrPWSChpuixnKeENDN08q0ZHqbLUV6jfs06cDh8B++RthRtlQDj3THjpCr/gkbBqI+4
	dtD2oYXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQT9B-00Fq9q-1L;
	Mon, 31 Jul 2023 13:41:17 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQT99-00Fq9L-0a
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 13:41:16 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fa86011753so8739305e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 31 Jul 2023 06:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690810873; x=1691415673;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytsM7PIFfzlNovndDv1vmd8xZArNHlp4ssMKjJ+U1gk=;
        b=DKdK0+bu68ehArfK6avVj+fCvOC9IMDlQd2xfXkr15kIPE0LmJGdLwXrbAQw1RYmGU
         QoYKXgzS1wefwTP5pE8BPi+RGTNMKDPTH+WKA5Hd7bSG/1YbsAA45ZA/2DCotraemoqc
         ZUjcOy30ylcnR4IkgVTeXcrn6BMLILeVnQavQ2BNOpAu9KFluMhLDcZqATF2dbUNN9Q/
         mYWUSBc+eaoMP1REsnbh6cwh6Rqh6x9/JdT1EswAn8JGHvMU8Ba4FcDZPNs9uT4VbgN3
         71Zfnjo4/L7gXEACVHt8v9aJA5fNb+8pVMlO4bBfW325QFAhX7A0vTFm6fbCgk4VWA4o
         1hrQ==
X-Gm-Message-State: ABy/qLbB3tSC//4P0LMQqFVkOp6Aas13robTqF25s/fwE2xy0hOWvbdc
	jYwPV44TLy2wVGUIyZe0bxWIVdW7ZTo=
X-Google-Smtp-Source: APBJJlEN7AjWR6l6dGfV0mSOmkrteHVgjAnI116M5b5BAbbdbUJbsAfn3YeB61In4tWq6DzcjUFrwg==
X-Received: by 2002:a5d:4ec2:0:b0:317:5f08:32a3 with SMTP id s2-20020a5d4ec2000000b003175f0832a3mr5458843wrv.6.1690810873073;
        Mon, 31 Jul 2023 06:41:13 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a8-20020adfed08000000b0031417b0d338sm13161926wro.87.2023.07.31.06.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 06:41:11 -0700 (PDT)
Message-ID: <d0badb81-782c-52c8-2b05-06ca6c696157@grimberg.me>
Date: Mon, 31 Jul 2023 16:41:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nvmet-tcp: pass iov_len instead of sg->length to
 bvec_set_page()
Content-Language: en-US
To: Varun Prakash <varun@chelsio.com>, hch@lst.de
Cc: linux-nvme@lists.infradead.org, Rakshana Sridhar <rakshanas@chelsio.com>
References: <20230727150550.5851-1-varun@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230727150550.5851-1-varun@chelsio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_064115_243646_A2309974 
X-CRM114-Status: GOOD (  14.20  )
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


> iov_len is the valid data length, so pass iov_len instead of sg->length to
> bvec_set_page().
> 
> Fixes: 5bfaba275ae6 ("nvmet-tcp: don't map pages which can't come from HIGHMEM")
> Signed-off-by: Rakshana Sridhar <rakshanas@chelsio.com>
> Signed-off-by: Varun Prakash <varun@chelsio.com>
> ---
>   drivers/nvme/target/tcp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 868aa4de2e4c..05163751f2e5 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -348,8 +348,8 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>   	while (length) {
>   		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
>   
> -		bvec_set_page(iov, sg_page(sg), sg->length,
> -				sg->offset + sg_offset);
> +		bvec_set_page(iov, sg_page(sg), iov_len,
> +			      sg->offset + sg_offset);

The second line alignment modification is unneeded.
Other than that,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

