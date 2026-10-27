Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF22606A323
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gixyHtKh;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tS0khtXw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=DdqPE1hxlr3HcgV5Z9+I8/97tTXj8KtZhhg4o4QDLzc=; b=gixyHtKh+eh25Q
	jyE0OSrCzCJlx4K2fQDAMgCSwMz+kY5WoYv+YsY8t5Fi42cp01n7Y8ns7hFkrokyoFB7lZCdY5p//
	G6ZtBY8vZJlt2MptBXV+ngTsnJRawc1BKtsmYp7AemJTkmP93uDUzfz3v2smgInqEyUpgRnytraZY
	oGJr8u9STaIN4ovnI4SWdrwokZgiNOSe7TZAQq0frs/ccd1lCNI6psXIu4S9oESfE1+6Y1G/GNhCE
	+UfeFCEVLwXQqM8bvvjOVTTAXfLDHnh73ttvQGxdt3rxjtyO5CX8oo3YgB580XzlOKt8cH0W2eD6E
	RjPvCQg2XEvgnQ2LZ3PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLiAt-0000000526T-016P;
	Tue, 27 Oct 2026 14:29:15 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLiAq-0000000525h-18Cq
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 14:29:13 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-c4395d31228so639885966b.1
        for <linux-nvme@lists.infradead.org>; Tue, 27 Oct 2026 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793111350; x=1793716150; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DdqPE1hxlr3HcgV5Z9+I8/97tTXj8KtZhhg4o4QDLzc=;
        b=tS0khtXwCgnEcj2BAb/5z4KZMJdL2VI43oVP+pIlFIkWCYEA2kFdsL30VpIU1BHx6/
         BzybgHXxqRNiNrDUCZGfZ5SFBcX1cK3i6/adLfJXFz+x8+GfnW62r9lSeqsNt88r7exR
         3yeoLSGJEaeyM44Ajg60XlHFcgYDaO2SPV103aImsg0LYwPWlOuTJ4nIv4RoYeBBShP3
         RrE8GwjshnDINQXxFOkK0AsZiFgzyYQlA9LZ0/sMqyqFKY9bNI72mUJdNy+5XUT/gKoT
         Mva3z0w6rI1hfULcJ4vC5uo+B777lh8bq2AbFxlcG2Z33vxqoD09M9NWWgpACO/R9enF
         XXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793111350; x=1793716150;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DdqPE1hxlr3HcgV5Z9+I8/97tTXj8KtZhhg4o4QDLzc=;
        b=NMGs2OwBTFnckeVB7WLDdrTuiGWCK31T0tVCanH4HMD2+obPzlndwPL4DS5LckaAZK
         HUvm+FJlm6ng3CPPlF30CKWbX9l6audln0aP2bYRi6DldHa0ubnRVD/cAO7DzLuoKK8u
         1BZiBENeDebmwM+2HWMb5zNOsRZsJM6/BXsSX1DTrA/BrmM+zSMl4AD0aAeOrjjOuQ/8
         +bEyGVoaaMX9VkRYhm5F4XLzSOf++jZpC5pvGwW30jqjk0WEdiSQywrR69VPJRrfXawi
         o1v6JE6CaZxCReP/ReoAhS5y5KnriFcGGg0uVubEBqXz9fZ+Pi6JK8goZHscDiJQhmYo
         8iyw==
X-Forwarded-Encrypted: i=1; AKwUvBzHeHWxY4HVAMMX1rQoqkArLFESOmah9T+Xin8D5aq2Zoy3x/ZKObYNHQQwTh/QVb9M/3F3U8PeoEdb@lists.infradead.org
X-Gm-Message-State: AFq9FYKz/am2yQ1etEXesk6kbboa7rlQIkRJNOtACA51I2TtFc8itGfK
	z3Dh+MovKWGQsOdjoAB7or8o6Z+yHTFFcGJ9Artd3bk+S3vyP7Co4aTIrMbnSQ==
X-Gm-Gg: AYBFou0kq6lX3enbHQet7uj/HHoBcB0L7AkRsfVhr770+KjjUkpuNT2X16++q43bsdC
	EzLvMsi7rmYYN4YBWfQLXI4BAg9OeN9lqvbMb1ntWSCaPUGZt1NjA0mKLWyj1RkfUtPKdMI3UAa
	UvcW5XKbqhquowmuUX3JzWlRmKNgoxm4aqIKE4gSwEAORcqfThaYbKP13kDwxCP3YfPNFu/Gt2S
	S1X/41ml2IJdQBAspFI2IJQxsGBYLLycJ0vWZpauKtRmY5trQRCvyOauc+ssL/C91FQUZtkvVSF
	E0NCwNZ6BLgXp2DiCled6OyfGDKX2JzfanrRNF8IJ+8OI9EgmlqjvYw3BsRzGFXGVcAsLnMnWZ4
	8O478Tk4D3ZRsUbspTVqRMNx8qDCxx2UFXOgOqQLVDMervPxyd2AzRkpe3RExuPZ6k01tYdPer6
	87ev9MM6l4P1ER1ZvV0P/vDRX/DbGjP5U1uw6qLKawevLac+IkzHNNN2gkFHkPbes2o02fqUJU9
	+s6pTNasuhXuK6UX9XTSJG6tyRGsdPVFLWbYPeWVLaUi/wRHIGh19IN26e1ACsCqa6SerWKwl/1
	sMg/YEGZ+5/SG1ihiP74ZskeCsHPCm9K/YzCDNFBXjeuR+ubZkj64AhMvPZkmJze0+kU1d/I7v8
	NuCzZnbDul/ULg0R6kS47ALa8gKCLJQ==
X-Received: by 2002:a17:907:6d22:b0:c2e:4b90:3c56 with SMTP id a640c23a62f3a-c46bddb306amr1127968566b.13.1793111349505;
        Tue, 27 Oct 2026 07:29:09 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a50c434asm151877066b.5.2026.10.27.07.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 07:29:08 -0700 (PDT)
Message-ID: <08e772c7-5e32-4e0c-b161-49ba970c6595@gmail.com>
Date: Tue, 27 Oct 2026 14:28:59 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block, nvme: minor fixes to dma-buf support
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@kernel.dk
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20261021184658.644645-1-kbusch@meta.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261021184658.644645-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_072912_339821_5EA08D3F 
X-CRM114-Status: GOOD (  14.56  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 19:46, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Just a couple minor fixes. I wish I could say I caught the first one
> myself, but no, I prompted an LLM to look at it.
> 
> I am assuming changing the bi_offset type to accomodate large offsets
> isn't acceptable as the bvec_iter's size appears to be packed to be
> small. I think there's a path to accepting larger offsets through
> bi_idx, but the patch proposed here is a safer quick fix.

It'd be curious to hear how you want to pack it. On the same note,
we'll eventually also need support vectored readv/writev and very
likely have the same problem. E.g. we'd either need to keep map in
another field (perhaps in bio only), or demormalising data and
keeping an array of {map,off,len}.


> Keith Busch (2):
>    block: reject dma-bufs larger than 4GiB
>    nvme-pci: detach dma-bufs only on removal
> 
>   block/fops.c            | 4 ++++
>   drivers/nvme/host/pci.c | 4 +---
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 

-- 
Pavel Begunkov


