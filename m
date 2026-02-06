Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF93EEE20A6
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Feb 2026 15:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hGQBxRDZvTlf47Wu9lDxdnyR2cqQuj+x+M/+cDeQX7w=; b=kxelr3Q+3NoRVgOXODEImd7/Qo
	soYeS8UJ0v+GLZpQD+UqMOmZT9J0nsG4rDTbswNZlKkf9hoQhTpMCwpk73dGoRGpBiDjzGXyvyz4Q
	l/dosq8iMDwY/nvcCnWv+NsN4K7w303wfeRJAawAgiFze+sB9XQt9UhuOc0hPnubc5bstnqaGN3d3
	Vv9tuyE/9of+zec0Bv1aSPXqmdu9cXaCI4gTS20pQYr0ajuUYWT6gq/YCSQYWfsJqTyUrKk1sly/a
	TpfszeROhigZILZvv94AHro9tQSnnTPX4IJxOsQPuLI/QyG6Uog+VlA+ThaMjBkw2SL7AD2Kv5nUO
	MJr3VHlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voNPU-0000000BT8a-2ndi;
	Fri, 06 Feb 2026 15:06:16 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voNPS-0000000BT83-0lc4
	for linux-nvme@lists.infradead.org;
	Fri, 06 Feb 2026 15:06:15 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-6505cac9879so2840463a12.1
        for <linux-nvme@lists.infradead.org>; Fri, 06 Feb 2026 07:06:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770390372; cv=none;
        d=google.com; s=arc-20240605;
        b=Cspc7OzxKzrNGA9Wz1j5n1ffmz0j1PRau21p5C/MunwDHzNN4oRHkzD4hHknPojrur
         96ssPH0/6IIM5pwVXhOqrmZxBwtFdQqDrdO2c0V/UBjsIUqTlvJ/M2PCOTgBkw9ODj3c
         ZHgn0ZuZK+DC44TYzfOVK6NAWP0oXbVldE9Zwpg5S6SAxPt1AgKRf/2Maw1+KWziue0+
         lUnlIOnxEhx2inRQZTNJ27sb0RV06pyhR0yioBiwuxEruAEf6OHitd757KMIPZ0TCkXB
         Oqu+imLLPXUcNS8R0tn2W87wasR42lLWjPvon40IXPk6ZzHoTjPN33qzqykJnjyoLWKV
         5mtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hGQBxRDZvTlf47Wu9lDxdnyR2cqQuj+x+M/+cDeQX7w=;
        fh=PkFycu4YDRI8aFKDLws2Wkw172U5Ru+9tyYSeIXtPLM=;
        b=hVLIaGhcwlt4yZ7jsTU9KXMItsjZV8VxstisMYI5TjyiaTLvI5sCbY5s2Ue1dDi/P2
         8klXygEusuk5QA/UBSTpchPf1JvR5y+iXPNb/KgjkJPlHM6sf+6eYNa3kBPfVAg1lCFQ
         xXl6mHRnlJ19MC/QQVb4FEIPyn4sxTXcn6A8im5qEPHJD1SdFzXcSxxj1Esx+Wh92eoF
         MK/+4Ia5EU85qc4rAz3Tkz1vAFvU6H6GynM2AUjsQaW3TlaBuqJkrWbEbSxTD94Sk4FU
         0qlYkiMyfkjBwU1b4g3R6rBNhbNNUltW9H7qvZfdaRhYzR+OuWWKEO+oT78W4uvTEzRq
         OCNQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770390372; x=1770995172; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hGQBxRDZvTlf47Wu9lDxdnyR2cqQuj+x+M/+cDeQX7w=;
        b=ctLk23hr6JJlcLe5hvLRKdZgQufo2602D8G7KyA2+GrKJrGzXkqRncbA83YnqBzinK
         DWnDgcmLya40sz5axIyO29TSqAfIN30JncKXN+fDSdvcCfmAQ209rNkTFvEuZyLzLNPj
         DEG0chq7pE8rodRxLKrvVaaPFhIsyW120Q77EOsSzohmDHCm+74eLXBhAVow7LtmZfyT
         JTPYZW50nLbEXUovMKFH8zeJY57tyvlgm6vWRRXDbAvDzXO60JKgjEEfO88npFDGAzng
         jzTclieSDGfLqBEM/n2apypbCxib4M6yu1eiM0T60NPYBy1SA59AzPlW6BYi0fsa5XHz
         MXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390372; x=1770995172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGQBxRDZvTlf47Wu9lDxdnyR2cqQuj+x+M/+cDeQX7w=;
        b=UVwPBnOan0NAR7u+M+OKAVlD92WV74zpMpyUT1vGJdOqOMZjbLBU/1/tNGBP/E5wos
         FjOplcjAgOJLRwWOCcg6KZbjdq7STLrWkgjvhZ4RuW2//Zxj2dbsVGHngCEffygeP9Tp
         eZsCegvLmJFPZkP6P6l2h8wUHR/wfDnxgAFps/UsuT1RMkdpuqoG9+xracI9QLAxZ7ew
         suvHWEVNQb0VdVuo0QgACI5mEWHSAmuEhXR4fKMbiGY787tRTp7Pa7QoeU0mSZWAcj/v
         rbMXGxRjyqqJegDDG2Zj1cZDKvSUmVkeqAZzNMNIgNpBVRTHvs2RmZU6ywB7VuUD3CoY
         K6Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVNNZGSksfAI8eWCmsNhmIFVsVx5zgK9QX0yx4rVLWkP1ivMNBVJvQo+0FzVWKhS6r/xSLDTFpXkXjF@lists.infradead.org
X-Gm-Message-State: AOJu0YxSY4i4OogD9dtl8mqQTsL04mKHRFxRPPehfobHUIxt9jeUPl3t
	9iV629MoLMVWcgSWEl6Zv56LqchZ5INEP0O252toy6UHZ0ep18Gvu+mwZQYE/ANT+y/4v3bIYLO
	esODP9Wk4axhBBMzL43ZwXfHh6dMa3w==
X-Gm-Gg: AZuq6aJzJKfs7cXNDf4f0CiFcvRlNd9hVBJtWtS/Rn6CVt9Fko0f1904zvT7sOhSo8g
	hMAWiMnMHgkTkEz4DymwpAAlEYqAosOMSKnOvIVBMb41pJZp1g6I9Vwq3Lqp5xn7Zddmre09YzA
	d187w7vZg9zSH0X6pm9fIMJk6jS+aOtAUcaMvtRNGo6nyGjtk1Gr5Hu7LQNZvaZiRQXRBSkVxbE
	2IPAlaLYVmnW7kqfHIMiJBmA3D1wDTzwvouXC668qqJsiJjTLa8CqmwNd5BVaVylKpjrqtW3pzw
	VJN4N3mRLFcAkQntnG0UmpP9SBphF9Dc7Bqu3SJ1d2S5YqpRgcjKGtCebD4oDGBHo+i0
X-Received: by 2002:a05:6402:5113:b0:658:dbf:d1a0 with SMTP id
 4fb4d7f45d1cf-659841a2f31mr1582224a12.30.1770390372219; Fri, 06 Feb 2026
 07:06:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1763725387.git.asml.silence@gmail.com> <12530de6d1907afb44be3e76e7668b935f1fd441.1763725387.git.asml.silence@gmail.com>
In-Reply-To: <12530de6d1907afb44be3e76e7668b935f1fd441.1763725387.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 6 Feb 2026 20:35:34 +0530
X-Gm-Features: AZwV_QhZUfBhtu2huNeoyo9GkYijd3hbyMiyHPwiXwArHA1o3azl0x64XYjc0yI
Message-ID: <CACzX3AuNL0g_VvxMSbUu185rvn97+NpZqOVj246-9q9hAVPa9g@mail.gmail.com>
Subject: Re: [RFC v2 04/11] block: introduce dma token backed bio type
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260206_070614_238748_9EBD6347 
X-CRM114-Status: GOOD (  12.59  )
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

> @@ -328,6 +328,29 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
>         unsigned nsegs = 0, bytes = 0, gaps = 0;
>         struct bvec_iter iter;
>
> +       if (bio_flagged(bio, BIO_DMA_TOKEN)) {
> +               int offset = offset_in_page(bio->bi_iter.bi_bvec_done);
> +
> +               nsegs = ALIGN(bio->bi_iter.bi_size + offset, PAGE_SIZE);
> +               nsegs >>= PAGE_SHIFT;
> +
> +               if (offset & lim->dma_alignment || bytes & len_align_mask)
> +                       return -EINVAL;

bytes == 0 is a dead check here. Probably you would like to check the
length of the first and last segment to match with what the normal path
below is doing.

