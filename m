Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCECC27C5E
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 10:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FpxmJoSW99hJx9JZ3U2DWGrUs+PthUzBo3UheVm8ELE=; b=T4EoTfh2Z/HuDKcjDtDvpoXNmr
	UOtULEN4XktAlce5EKGFY2Bs5zSmDIJSg57EZykbA9em4kvtxHgejcGa+TN225S6rm3sBrhwwY+ZC
	xvv1uFroTBx3ji+r2szOzhg9DppIgvN6TxoEVBI82YEDCQa7HWmGys6/5dFdc6tBXUtJHzrwyktOq
	1IoyJ0JGxiwARjRJ8mZoflwpQAVUyRJSe8DOvILn23TlU4Y1/5mXf9q/aL23PIQiI1GNx+CqSNFOX
	Idmy302savEL67i5zF6fkN/Fadj0xrdKH9wnDbyLKHx8N1wwgkdLfBIAgmKty+xSFgMrDruBhF0Ga
	GsP2tVFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGbrV-00000004YD9-1cPn;
	Mon, 10 Jun 2024 10:02:49 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGbrP-00000004Y87-2A2m
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 10:02:46 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-35f223c99a3so132489f8f.2
        for <linux-nvme@lists.infradead.org>; Mon, 10 Jun 2024 03:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718013761; x=1718618561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpxmJoSW99hJx9JZ3U2DWGrUs+PthUzBo3UheVm8ELE=;
        b=mVM8759p/b7eg2QrdAuTuZk+0FIr9RCjBqWbA93ZjwDJcPlLEr2NO12FPlj050LbtH
         WHK6dwVckE/ERAmvNLhuVw8mZ/xKadny96vEfV7JcA38EPx1lX1aAv293Fml5Z1Lz5Mw
         kEbELAJoH4kB0Y/Xt65LXJCoQE+yrXzKWlmkdjy3dXmPkheZe9D0AvwNCniZ9pao4ugb
         f8s7PtNZQ5+WgvljCCXRTBEKGbVrodzK6d0nZxS3GTIZDzCj4xtXOmBlDqkC7rsaijvx
         y7BxqgJ8ZHHLK/m6U01q1vNDjX1FDDYOku5Ce4QbLICN6Yk1jGXPQaJVXOb2aSu5xdLi
         +5EQ==
X-Gm-Message-State: AOJu0Yxbx3LIYbY1BgJK6PrnmiW1DS35zjYfgCpFEOT3RHHFcNlSytCN
	nMteoY/jZnMJmUXGMRZ+6dILFjYJp6erfCTG29yK1yasm/GhWYBG58nX2jx1
X-Google-Smtp-Source: AGHT+IFc4quup2PVQI04GykPP1rc368w7lB7TmA/X2/kJcjFKtZl/DbVIOsQEIAkB5HL6h1SIVn8pQ==
X-Received: by 2002:a5d:64cb:0:b0:354:e778:3665 with SMTP id ffacd0b85a97d-35efee307bamr7496441f8f.5.1718013761158;
        Mon, 10 Jun 2024 03:02:41 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f212aed2esm3248721f8f.26.2024.06.10.03.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 03:02:40 -0700 (PDT)
Message-ID: <fe0a1e51-8b88-4f6d-98ec-a5e6c2a12e8d@grimberg.me>
Date: Mon, 10 Jun 2024 13:02:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: nvme: target: core: deref after null
To: Alexander Sapozhnikov <alsp705@gmail.com>, Christoph Hellwig
 <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240607134340.11-1-alsp705@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240607134340.11-1-alsp705@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_030243_721669_20A85A41 
X-CRM114-Status: GOOD (  16.76  )
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



On 07/06/2024 16:43, Alexander Sapozhnikov wrote:
> From: Alexandr Sapozhnikov <alsp705@gmail.com>
>
> After having been compared to a NULL value at core.c:813,
> pointer '(**sq->ctrl).sqs' is dereferenced at core.c:838.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
> ---
>   drivers/nvme/target/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 06f0c587f343..5a67d2bc0c55 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -827,7 +827,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
>   	 */
>   	ctrl = sq->ctrl;
>   
> -	if (ctrl) {
> +	if (ctrl && ctrl->sqs) {
>   		/*
>   		 * The teardown flow may take some time, and the host may not
>   		 * send us keep-alive during this period, hence reset the

This is a redundant check. sq->ctrl and sq->ctrl->sqs have the same 
lifetime. If
sq->ctrl was assigned, it means that it was allocated and needs a final 
put to
fully cleanup. ctrl->sqs is allocated in nvmet_alloc_ctrl and freed in 
nvmet_free_ctrl
which is the final reference.

