Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B26AC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 22:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ajABxSWxUsCKK9Od/qyGt1skys7+Os0a1j5QneotZAc=; b=o1k8PxLF9aWWdRpgL+1LYTpaUi
	cRYf9UGe4D3tO2IqRCq/J+vZbR17cDFDDh5O7hPTKSAGqhMMK7vpt+G3mjRl13bD6yAzvwcQiCdW1
	vlKA7VOd5vL3F7KdNGbQa1dcTS+8ftPJBOEJ7QG0ZfNdXOIx5MColEkY3c4oOwYvy9P6PFN1Lws+9
	Z2fUg7RysB8x8Fp6GOfglz9F6/6nGGsbAAh/PsjzAhJtqIxzHBbADxIHtwQZuQiIt59a+Kd9RFLfN
	Wupc6H5Vi/Kro6oZKXI7MWz/m0Sz9yDK2/pr4cnLw6z5dFafKu152a0lQ2zLranX/3d43Em5zyMk/
	4i1OXE4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oF0pE-00Br71-Q4; Fri, 22 Jul 2022 22:08:48 +0000
Received: from mail-pf1-f181.google.com ([209.85.210.181])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oF0hq-00Bl4T-Er
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 22:01:11 +0000
Received: by mail-pf1-f181.google.com with SMTP id e16so5501268pfm.11
        for <linux-nvme@lists.infradead.org>; Fri, 22 Jul 2022 15:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ajABxSWxUsCKK9Od/qyGt1skys7+Os0a1j5QneotZAc=;
        b=Rk15/hWo8+SsZvY7d7KPzvApbR4D8P8Z6+MXowX3879RH0BhsGnedE2tL3dSwx3mPU
         QW2z5LN6goiQeHJqT34vsRGaJadlC3SRGB33wX8NhtoCwGKkwPurtwGirS6WvxPyuK6w
         EdURhHMl34n8McsVPEg547jWLVFa2V79XtZK6ZhPBLLWrwYy6VtrlGOjA9qTPV5XA4Io
         OF8I2xCYfcJgTWf5YN0ckqAzMrS2rKT5/5FXv/6c7N2WzD+j4+5Nbi3dEYA7JH0DjNRh
         QiXBcXsCc+ARNB1wccTHqrOy6uiB9st87cPpXAhykfCie3bryCkPC01cqKjeUCBhawsx
         gwwQ==
X-Gm-Message-State: AJIora/90ebUAQgyweHm17fVJVc9NwbaBBbuGEfcY0QSu89pe1OVtZYm
	P1m0H7mRzwe670SVsJucaYs=
X-Google-Smtp-Source: AGRyM1vg+HIfwhtPL+PdWNr+gthVaYVrLjl4aYh4LyhLKIfuUmvhrIx/NVwQSMMB+QOUIwNSw5D80g==
X-Received: by 2002:a63:5b5f:0:b0:416:1e31:5704 with SMTP id l31-20020a635b5f000000b004161e315704mr1494610pgm.523.1658527269253;
        Fri, 22 Jul 2022 15:01:09 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:805b:3c64:6a1f:424c? ([2620:15c:211:201:805b:3c64:6a1f:424c])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902a38800b0016c46ff1973sm4220464pla.228.2022.07.22.15.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 15:01:08 -0700 (PDT)
Message-ID: <a1cceb79-c72c-5a76-ed7a-156c09505692@acm.org>
Date: Fri, 22 Jul 2022 15:01:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv6 07/11] block/bounce: count bytes instead of sectors
Content-Language: en-US
To: Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
 damien.lemoal@opensource.wdc.com, ebiggers@kernel.org, pankydev8@gmail.com,
 Keith Busch <kbusch@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-8-kbusch@fb.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220610195830.3574005-8-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_150110_563175_2FF1E337 
X-CRM114-Status: GOOD (  19.24  )
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

On 6/10/22 12:58, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Individual bv_len's may not be a sector size.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   block/bounce.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bounce.c b/block/bounce.c
> index 8f7b6fe3b4db..fbadf179601f 100644
> --- a/block/bounce.c
> +++ b/block/bounce.c
> @@ -205,19 +205,26 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
>   	int rw = bio_data_dir(*bio_orig);
>   	struct bio_vec *to, from;
>   	struct bvec_iter iter;
> -	unsigned i = 0;
> +	unsigned i = 0, bytes = 0;
>   	bool bounce = false;
> -	int sectors = 0;
> +	int sectors;
>   
>   	bio_for_each_segment(from, *bio_orig, iter) {
>   		if (i++ < BIO_MAX_VECS)
> -			sectors += from.bv_len >> 9;
> +			bytes += from.bv_len;
>   		if (PageHighMem(from.bv_page))
>   			bounce = true;
>   	}
>   	if (!bounce)
>   		return;
>   
> +	/*
> +	 * Individual bvecs might not be logical block aligned. Round down
> +	 * the split size so that each bio is properly block size aligned,
> +	 * even if we do not use the full hardware limits.
> +	 */
> +	sectors = ALIGN_DOWN(bytes, queue_logical_block_size(q)) >>
> +			SECTOR_SHIFT;
>   	if (sectors < bio_sectors(*bio_orig)) {
>   		bio = bio_split(*bio_orig, sectors, GFP_NOIO, &bounce_bio_split);
>   		bio_chain(bio, *bio_orig);

Do I see correctly that there are two changes in this patch: counting 
bytes instead of sectors and also splitting at logical block boundaries 
instead of a 512-byte boundary? Should this patch perhaps be split?

Thanks,

Bart.

