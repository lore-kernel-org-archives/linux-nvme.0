Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F29C197A0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 23:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hnOBTCQ9+nRW7d7hGg7yNZ/aZJcC73wKnOgLg+ML2Mk=; b=r53OKWkunqWw8okPeXyMeTBs5j
	hPMHkO1dZEVwiTB4vBQWBZc51BN495xge47F+Bgrj8tG6DL9OR15eUqqj7nTthJu1NYmkv/QOX/yD
	BH6Ah9KyvXhg9BGQYm6gcpRXqYm3iP9F0ik8xeJRGgqXrBUzgFmIy8M39UGOmyVONKjbkW9JmV2iD
	rE3yCx65ZTHz+XcotW1SsE9J+30nZr365cIt+ByhubaE1HShniFSG1zvmGnklv6TFynQWCmQE2UWT
	B3mx6Zy64H2C3gAcTQZHEUTxftUeK6h54XhKdzSwC5NCP6KeyX8wgQ+DmyqS5yBHj+F1OJjOQpwnu
	j/hxgY7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5DXp-00F2wd-17;
	Mon, 20 Nov 2023 23:19:09 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5DXk-00F2vw-25
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 23:19:07 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc2b8deb23so10458405ad.1
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 15:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700522342; x=1701127142; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hnOBTCQ9+nRW7d7hGg7yNZ/aZJcC73wKnOgLg+ML2Mk=;
        b=v5G7+Z+UF/YlLBbAKLenja0sj8g1joZjAeC69GBjI4+zolkj7buepbF6KjDbBkVaE0
         D4WgBQW1f/I2ngsd1CsLprEz2tuUtZg5zM4wx/11BbGORgWm7FXYNbU2rM+UvYP9Voxs
         eQWUEQF1S9QdJIM1DduOGfFqKYfdWUgdm8EI8l7BmFgx02p/AyR0EdhK3JWu104L8uOs
         1jTXmkIf/5jQnPGauGyNcXQQizdMNGo4tOMfwUsDEHa88kPSYQxnBGeymW7bBnMQVyQx
         UJyMDtJaUCLPxUv6FeKgD8z9XUVmflETr1ard291JZmwk8rwT0AI4zB4VGkz6yys2OPu
         tIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700522342; x=1701127142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnOBTCQ9+nRW7d7hGg7yNZ/aZJcC73wKnOgLg+ML2Mk=;
        b=ktx9gzxCfN2LxFWL5ZReCsMIlgQF/1dLo4pjP2CHmydMxBqIZBcYJ9K2u61HLnCvj8
         Vl9tnt1fXCwgkJRSGguWk6yOZxn2Fx0U6qMIRQdyhVNXtQeCjmgiI8lsncsmj8fWRPWW
         bUh+HwPY3IN6PLMIX9tL9VhnvTb1A5yd8zGl9lmV7KREnU+m6x2LKrq09gxdRO7ANENR
         KsAFF2Z8G6qI2th7xFmJc774jg8H/3ZNuPfBcxm7lIrD7Wq/0XCSKY/01gnWmGmPm2DK
         Wnpykhn0/LMksXu3z0cOy88qkjon1ikwks3UgtAtnRQRTBN7UQr0yVHXN2i16NX0NUda
         LdPQ==
X-Gm-Message-State: AOJu0YzS5upDvhkmSrUsf7+lobT6vGiWvNJ3qqurHuoVZcOfu5+o4f24
	xpZGRQ+Tlq3Z0E+T9HRV/WWUExocXrdXQJDmUswjkQ==
X-Google-Smtp-Source: AGHT+IEHr/jLVxb+HhXgXcdOLcZeWZ7nxeRgUVmob9UsD/JyCgmNIprja4FDgcnfkrYzUwMQ/r6zBw==
X-Received: by 2002:a17:902:cec7:b0:1cc:3c2c:fa1a with SMTP id d7-20020a170902cec700b001cc3c2cfa1amr11754119plg.4.1700522342032;
        Mon, 20 Nov 2023 15:19:02 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902c1ca00b001cc55bcd0c1sm6605408plc.177.2023.11.20.15.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 15:19:01 -0800 (PST)
Message-ID: <8f70b7bf-35c9-430b-a52d-ce7a11a20260@kernel.dk>
Date: Mon, 20 Nov 2023 16:19:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/5] block: bio-integrity: directly map user buffers
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, io-uring@vger.kernel.org
Cc: hch@lst.de, joshi.k@samsung.com, martin.petersen@oracle.com,
 Keith Busch <kbusch@kernel.org>
References: <20231120224058.2750705-1-kbusch@meta.com>
 <20231120224058.2750705-3-kbusch@meta.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231120224058.2750705-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_151904_810052_1CF8A8F2 
X-CRM114-Status: GOOD (  21.65  )
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

On 11/20/23 3:40 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Passthrough commands that utilize metadata currently bounce the user
> space buffer through the kernel. Add support for mapping user space
> directly so that we can avoid this costly overhead. This is similiar to
> how the normal bio data payload utilizes user addresses with
> bio_map_user_iov().
> 
> If the user address can't directly be used for reasons like too many
> segments or address unalignement, fallback to a copy of the user vec
> while keeping the user address pinned for the IO duration so that it
> can safely be copied on completion in any process context.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/bio-integrity.c | 212 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/bio.h   |  12 +++
>  2 files changed, 224 insertions(+)
> 
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index ec8ac8cf6e1b9..b761058bfb92f 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -91,6 +91,37 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
>  }
>  EXPORT_SYMBOL(bio_integrity_alloc);
>  
> +static void bio_integrity_unmap_user(struct bio_integrity_payload *bip)
> +{
> +	bool dirty = bio_data_dir(bip->bip_bio) == READ;
> +	struct bvec_iter iter;
> +	struct bio_vec bv;
> +
> +	if (bip->bip_flags & BIP_COPY_USER) {
> +		unsigned short nr_vecs = bip->bip_max_vcnt - 1;
> +		struct bio_vec *copy = bvec_virt(&bip->bip_vec[nr_vecs]);
> +		size_t bytes = bip->bip_iter.bi_size;
> +		void *buf = bvec_virt(bip->bip_vec);
> +
> +		if (dirty) {
> +			struct iov_iter iter;
> +
> +			iov_iter_bvec(&iter, ITER_DEST, copy, nr_vecs, bytes);
> +			WARN_ON_ONCE(copy_to_iter(buf, bytes, &iter) != bytes);
> +		}

Minor nit, but I don't like hiding functions with side effects inside
potentially debug statements. Would be better to do:

	ret = copy_to_iter(buf, bytes, &iter);
	WARN_ON_ONCE(ret != bytes);

which is also easier to read, imho.

Apart from that, looks good to me.

-- 
Jens Axboe


