Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961D5C5DF66
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 16:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=98pTz1wjWa3DC15z3yywDMfFCjc1xmvSAJlUL+hubU0=; b=GUNVLJJ889Op1Q8DrML9GS8fL4
	+UrFVCiMR53mLEzNKHD/FBJSOjWEKyDjkDGlIG6hapvocG+0p6lNLHv44oc/s7807CziWQGAOliIq
	igR4U18ER6/YF/WUE7hpw+Wk2sYM7K+YCtju0r1v0Izjj5HQSr2PbXG4xWlH10flHWOk6Hf3GuuEH
	fnPu6QfFVmmJl1C9ofZ9xmgNteo/6wESD5790pHMPWhLuSpHROdMsFjgGcNGLiFZeOuunji3qdwH3
	uI9cCviGvenJvHYPq3DSGNPmUXfY1IXcUm/wG5Ao02qBpzwz/ODYap7+Pl05cBiTF+FKOD1xzkTPt
	j+9jt7sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ww0LE-00000006Wv9-0ybX;
	Mon, 17 Aug 2026 16:37:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ww0LB-00000006Wuh-1PV5
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 16:37:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786984655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=98pTz1wjWa3DC15z3yywDMfFCjc1xmvSAJlUL+hubU0=;
	b=GeYGVVGpx4mFHHtVG8Xo6dJ7PagFN0nMbgQP1hsmOKKl0PZO2UKktk9PMylG7BnqtGZW8d
	LklsyE1YAb1RgHWONJhHof270zTvFg16E0NDQC4AKqV7xVf6NysU33ZQp5mfMc/l1aE6bf
	sCKF2NoOI3novIMJJF2BMyLe7skr/E0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-N2kfu-ugNPGlIHzVEBWZbQ-1; Mon, 17 Aug 2026 12:37:29 -0400
X-MC-Unique: N2kfu-ugNPGlIHzVEBWZbQ-1
X-Mimecast-MFC-AGG-ID: N2kfu-ugNPGlIHzVEBWZbQ_1786984648
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47407691804so2179848f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 17 Aug 2026 09:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786984648; x=1787589448;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=98pTz1wjWa3DC15z3yywDMfFCjc1xmvSAJlUL+hubU0=;
        b=Hbnzwqzj47n0WB022/tizrpsiJJ9XPzlZTBwIOfl7BMDXjpcJlv6EylCH4nYw8dbOq
         XztUSyDNgWYERfPTCpyRWAIk8HFNDyZ4b+ilw1DSLfymISA8KxGGzwPbF/WUvGqsePjH
         i5JDX8J62VX9HJoTaBYdKuXIjFw9w75WF2LYmjAC5u8L8V1wqcoug9517ljty5VdRsen
         p9lOWNN0ZQWX/9RVEXnJynh7Pp5e6lSGyD+3au3/RgTU6Iv1gRayafC2+sCYYq0tUu7o
         YhVlpNoJ8PVON7GeZ6VWU6V+A4Y3xJ7nrqdgRR8NHPkq5ewp+miVX4eFlUscIz6tRXac
         wByA==
X-Forwarded-Encrypted: i=1; AHgh+RpZ7FzN/ywTveoMEruk1Y6OLjzaruNth7VndAGalfV3EzLRnV0a2crEwnh/yf31f3uJwGUZBs2J550u@lists.infradead.org
X-Gm-Message-State: AOJu0Ywew7weM5OGaLb8EJ1h7ea/mJ6X3KZqNHiKYlfmZXhUTY8LHeoA
	CrL6OPLl19pbf7C/X/ykb0tjKccJ7oZfgldGfYc207joVBCIiTSq+kdLwJZNzsSSdf+RSeg9wnQ
	umdH2wAojsvLnMq78CrR0OM1kGPOHQ769n26rGO8NJ7re51dn4T0E5k5C9xu453qXAqR3
X-Gm-Gg: AR+sD11eWULnqXry6uHH/KkTu10YrjuLwMrkND+xzHD37ULJdUtcYbXVh0Z/dlC5GsN
	e4UAG02GXK4bnTCPsyHxinLVNhiuBoBMFQvHcRXaF+4+VOitz1eA+dF7nXaxT7iqELBqSzeicwm
	8NM6QgiE8Ep0B1dAF45KucZMu4SlEUDssMul7auXbP8jGPgi16GFZjC5U6Zmeqiu7ATyG7O8CGK
	xhqexgrgnhUPprheTgAjlddf1R9rZ0dodCkQf0ydgdm2XqFlVqOO6w4tCtTdmsrkT3RIAA3qhVZ
	orm0Dfot+1SbM7KmPT0ewZsNOR6vimA5HhrYTC77Ov1nqwM4PZTU7iuqWUBohP77Z0psdsHRmsa
	etEsZfjv2pC6krEAeLzzCTO+6MeZshSV6PnvwoxOzDv0=
X-Received: by 2002:a5d:5f56:0:b0:481:5167:a9a4 with SMTP id ffacd0b85a97d-4816071c181mr42522372f8f.7.1786984647855;
        Mon, 17 Aug 2026 09:37:27 -0700 (PDT)
X-Received: by 2002:a5d:5f56:0:b0:481:5167:a9a4 with SMTP id ffacd0b85a97d-4816071c181mr42522299f8f.7.1786984647459;
        Mon, 17 Aug 2026 09:37:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b660sm5386882f8f.15.2026.08.17.09.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 09:37:26 -0700 (PDT)
Message-ID: <e2da7cc1-3ab8-408c-b561-345de5a33963@redhat.com>
Date: Mon, 17 Aug 2026 18:37:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 axboe@kernel.dk, Jeff Moyer <jmoyer@redhat.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>
References: <20251014150456.2219261-1-kbusch@meta.com>
 <20251014150456.2219261-2-kbusch@meta.com>
 <1805eed3-90ec-4f62-9d71-e3f898a464ad@redhat.com>
 <aoMi6y2qsnRVembg@kbusch-mbp>
 <0023a895-7b04-44cd-a90f-c9d587a49519@redhat.com>
 <aoMxLBmKfFo_-i1u@kbusch-mbp>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <aoMxLBmKfFo_-i1u@kbusch-mbp>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ghb7Nm5kH2sv-q9L80_2QCZajaQKpzd7TJpbIdhJ0gk_1786984648
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_093737_461497_C7FFF999 
X-CRM114-Status: GOOD (  10.93  )
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

Hi Keith,
On 8/17/26 6:05 PM, Keith Busch wrote:
> ---
> diff --git a/block/bio.c b/block/bio.c
> index 4074a0496b93f..c343788e1f96e 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -859,6 +859,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
>  	bio->bi_ioprio = bio_src->bi_ioprio;
>  	bio->bi_write_hint = bio_src->bi_write_hint;
>  	bio->bi_write_stream = bio_src->bi_write_stream;
> +	bio->bi_bvec_gap_bit = bio_src->bi_bvec_gap_bit;
>  	bio->bi_iter = bio_src->bi_iter;
>  
>  	if (bio->bi_bdev) {
> @@ -1969,6 +1970,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
>  		bio_integrity_trim(split);
>  
>  	bio_advance(bio, split->bi_iter.bi_size);
> +	bio->bi_bvec_gap_bit = 0;
>  
>  	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
>  		bio_set_flag(split, BIO_TRACE_COMPLETION);
> --
Many thanks for your quick investigations. With that patch I do not see
the IO errors anymore so it seems it fixes my issues.

Thanks

Eric


