Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDDEC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 13:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XGZuj6mfM0WiW7dFClmKDN/m8Wp8N5NVkKRnuNf5FHI=; b=Pyt2q86HTSBxQvPe7NvyV2DjsQ
	sw7Hocx5uyDKSUs9pyYQywRoY83KJ2WAglZAYXgbvsmO5aw669zvg/WjSk44ti+TNYNnCs/UPu5V7
	KUUeOfA/fUS/8NjiNaOmdIhwXOtOuiw4c62OgHFqXkAFFWYGEr6g2/UqvEWI10XVYTYobwU/QhyS+
	OG1gnces97amZKb8Oz+91vZ5g2gJkbvIV926FQ3GcG7SGzb2lPV2oHDGEPCn7ebT3wyTs1St0N3/P
	81tDicVpjF4crfiijyqibcYWNnn1L6mmZMTDiRoM4YdS+XHAqTsV+r4jg2PJa0+YyovyyFr4w1900
	ap/hmC0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njKr4-00ERh6-J4; Tue, 26 Apr 2022 13:03:46 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njKhS-00ENLt-4M
 for linux-nvme@lists.infradead.org; Tue, 26 Apr 2022 12:53:51 +0000
Received: by mail-pl1-x62e.google.com with SMTP id p6so2194330plf.9
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 05:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=XGZuj6mfM0WiW7dFClmKDN/m8Wp8N5NVkKRnuNf5FHI=;
 b=jUW+XerKm+gckNXcPR28kn671NB9irnirM7ke2RCRs49GzhQfZMNn6mc3xAym1/8Gz
 XUvegXuQo6TlMheUzNqzVDwv6nolmPNKjYQ7Oo/NO+t1B2vD/fHU4sbkctaA0LE1jb/X
 OvC5Fv2iyqHlI4wNq+jvO/8WpfmflFPbGW0WNOwgo3EOocCKMbOy3o0hoo5x4ilJ//Jn
 L8qNyv32alr3Q/9go11ew4oiij4atIIxXNVf7vDEWMeuOFaoir54dM8WAYH/2gU4wL5+
 15JnMsYugKBlY7Ol0I4KmNdySqkmR/ojxWf0uOsQGQlQ2NimozxK5atRqr7AdvTjGvB4
 zLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=XGZuj6mfM0WiW7dFClmKDN/m8Wp8N5NVkKRnuNf5FHI=;
 b=v4LsMV1uqrRGOXjPt3LRI4T4eRTRfYKdCiKtHDZSOEtJur8Z1+8HthPHW9nAuL3LnR
 olOU9NuBb/J8SQgTxQQVXZaFB+QmL+uWtnU+d2a6tfE0CimuE75RAbZxbt6GIS6TzwQF
 Td3pwVTCfAr7iWPNsE1U6GwUKOmW9zO9WyNSAuXuuOgZLFiEnQDiE+iWAmUaPmiw2gj+
 uJKwvyBnP+58Fp3Sil1zVMbIWrEqIMkRZ0UXdGVGjiaGOzqf+E2yJ3mqymZoKC2szwH9
 r5rPxIBeQiBWtjBPsJ+eci0Qehd5oGv24Zp8VWE/2v8UC/BeluN5M4qh74GPxIr5Pg32
 ibmA==
X-Gm-Message-State: AOAM533hQ0TetvVjADI3WlGxvjlIt0qCeQ2/9hUXQM+mdi+5chUFw5qJ
 4qUaFoDOnvm6f6ufF3HN5J/UgQ==
X-Google-Smtp-Source: ABdhPJy/WEj9zweDE/V+h2hN87dJgN2vLon9Ml/lvxLnl0k+2f2FZENIKar4FtjLlI8bpwfUnSa4ZQ==
X-Received: by 2002:a17:902:7045:b0:157:144:57c5 with SMTP id
 h5-20020a170902704500b00157014457c5mr23215069plt.86.1650977627984; 
 Tue, 26 Apr 2022 05:53:47 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a63ab0c000000b00381f7577a5csm12498921pgf.17.2022.04.26.05.53.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Apr 2022 05:53:47 -0700 (PDT)
Message-ID: <53b9382d-83a0-5d20-784b-3a7403713f94@kernel.dk>
Date: Tue, 26 Apr 2022 06:53:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 08/12] io_uring: overflow processing for CQE32
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, Stefan Roesch <shr@fb.com>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 kernel-team@fb.com
References: <20220425182530.2442911-1-shr@fb.com>
 <CGME20220425182611epcas5p2c999ed62c22300b8483c576523198c4e@epcas5p2.samsung.com>
 <20220425182530.2442911-9-shr@fb.com> <20220426062826.GC14174@test-zns>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220426062826.GC14174@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_055350_238079_CDF60E4B 
X-CRM114-Status: GOOD (  20.20  )
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

On 4/26/22 12:28 AM, Kanchan Joshi wrote:
> On Mon, Apr 25, 2022 at 11:25:26AM -0700, Stefan Roesch wrote:
>> This adds the overflow processing for large CQE's.
>>
>> This adds two parameters to the io_cqring_event_overflow function and
>> uses these fields to initialize the large CQE fields.
>>
>> Allocate enough space for large CQE's in the overflow structue. If no
>> large CQE's are used, the size of the allocation is unchanged.
>>
>> The cqe field can have a different size depending if its a large
>> CQE or not. To be able to allocate different sizes, the two fields
>> in the structure are re-ordered.
>>
>> Co-developed-by: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Stefan Roesch <shr@fb.com>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>> fs/io_uring.c | 31 ++++++++++++++++++++++---------
>> 1 file changed, 22 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 68b61d2b356d..3630671325ea 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -220,8 +220,8 @@ struct io_mapped_ubuf {
>> struct io_ring_ctx;
>>
>> struct io_overflow_cqe {
>> -    struct io_uring_cqe cqe;
>>     struct list_head list;
>> +    struct io_uring_cqe cqe;
>> };
>>
>> struct io_fixed_file {
>> @@ -2017,10 +2017,14 @@ static void io_cqring_ev_posted_iopoll(struct io_ring_ctx *ctx)
>> static bool __io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
>> {
>>     bool all_flushed, posted;
>> +    size_t cqe_size = sizeof(struct io_uring_cqe);
>>
>>     if (!force && __io_cqring_events(ctx) == ctx->cq_entries)
>>         return false;
>>
>> +    if (ctx->flags & IORING_SETUP_CQE32)
>> +        cqe_size <<= 1;
>> +
>>     posted = false;
>>     spin_lock(&ctx->completion_lock);
>>     while (!list_empty(&ctx->cq_overflow_list)) {
>> @@ -2032,7 +2036,7 @@ static bool __io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
>>         ocqe = list_first_entry(&ctx->cq_overflow_list,
>>                     struct io_overflow_cqe, list);
>>         if (cqe)
>> -            memcpy(cqe, &ocqe->cqe, sizeof(*cqe));
>> +            memcpy(cqe, &ocqe->cqe, cqe_size);
> 
> Maybe a nit, but if we do it this way -
> memcpy(cqe, &ocqe->cqe,     sizeof(*cqe) << (ctx->flags & IORING_SETUP_CQE32));

Unless you make that:

memcpy(cqe, &ocqe->cqe, sizeof(*cqe) << !!(ctx->flags & IORING_SETUP_CQE32));

that will end in tears, and that just makes it less readable. So I don't
think that's a good idea at all.

-- 
Jens Axboe


