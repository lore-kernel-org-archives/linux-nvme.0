Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BCBC54EE9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 17:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sbvQ8+O7Iu5pDsUhnetggBoxhwtGlOoUgDtHy9h5j3o=; b=ynT2vt6s2H5LLlheP01j4NCd9b
	TY1h2Zr2TcsP9u8H1BplWzbDG1S9X/f2cXL/NhhOT1RFVQOV+73qMBc9iM4vQaOt6pQAlEwDztaz5
	Yeidih9GjRDPRreu2JumGhtnF0r6+slrLEMZy4XlEwhE/AnFp4MClmd+g53Nh6EKA68dnQM0U1wFv
	HasLR0KnG/p1wTrl89giYT6ONx5tjDrPuypniBcuJDZiMV+A5GDLJ/TcaWKJiNzIAi/km4ue3g9Wk
	WNHCoZMit33yXhrcewrukQ9MO9vaGy6ODPLK2Nf1gp0m3twEkGyh8ILA1szPHgX1OcoZTaH3nbOH2
	LOi5YB6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odbBe-00HRyR-T0; Wed, 28 Sep 2022 17:49:34 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odbBb-00HRwj-LA
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 17:49:33 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 8-20020a17090a0b8800b00205d8564b11so2319662pjr.5
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 10:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=sbvQ8+O7Iu5pDsUhnetggBoxhwtGlOoUgDtHy9h5j3o=;
        b=ExvBbQ5KKBknu9xSg+qWbY/X1hG+kanpywR1B5ZpLcX5zZMnkusUvVsE2yTTNy5dS2
         KCUd9fpK0oJsxxdKmsquEDXqv/RqAl7gJrDyiBrtgLMVwNiZsMEao2uixWNVPMzCHm65
         FjlvXnxkvLI34FlfoH2qArhBK8IaqHYaS7EB7QuO85H5tr8wWWKsqASJDnhE6xwbZXiU
         UpdfLCo9hO90zqVeAVVQBS/NdcKO2uCxQUkreZpEvZySxDRIIeSU39dV/l3zbmWfI/eP
         Dg8uW0kll6L/k/5+b2dTO5ij+YIQRhM4MmSA5sl7+6opXvMDtTlilsugD3ft2z8W2Wha
         6gQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sbvQ8+O7Iu5pDsUhnetggBoxhwtGlOoUgDtHy9h5j3o=;
        b=KPuiH3KToexnuzi0wqI+cAGw7QaKBWTnZs7O9hTFpNDXpM6FTtUAzM/KIjqY2Y1B6j
         /ya+seeibGLfmtewNKtojdPbxmqAzUjq3+S8ESw5PW4W1ohX74WoArcFlMw54jzc1+GB
         jeoR1h68PzVeRN9JZo3pJnn9z8x0s15yVBUUH0n90wytVSZ+glLzrr3dEwZrc6+TbJ0I
         kf71Pbv4WT6oHPjIUq8yJmd4Dz1qHY+CFyKsuUbhWRQR1GCBtaiovMsL68wdoqwu6/v9
         D+IinlGBvw1qEfQt0QrWiDU1GTdFWNonexLZX5NLmI3OTNAtbY6YpnqkCVN37FNk5Sxu
         Yf4Q==
X-Gm-Message-State: ACrzQf3GKOZ82TbFDHCabjPubtVaxyfud6zyPbtsY+8B7Je8T/aER4ow
	5vuzdmO+TqKPFbZyUtc2XGWnQw==
X-Google-Smtp-Source: AMsMyM6mVbp8UjUgd6Ua1oZ/TXcLqXeNHxfIUwGmNRJyCLGXI4Ip9GabzGAflN9Nblr0Z3b/p3hrUg==
X-Received: by 2002:a17:902:da81:b0:178:1d8b:6cb4 with SMTP id j1-20020a170902da8100b001781d8b6cb4mr948463plx.43.1664387369974;
        Wed, 28 Sep 2022 10:49:29 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f27-20020aa79d9b000000b0053e3ed14419sm4256392pfq.48.2022.09.28.10.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:49:29 -0700 (PDT)
Message-ID: <6ffd1719-e7c2-420f-1f9e-0b6d16540b46@kernel.dk>
Date: Wed, 28 Sep 2022 11:49:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH for-next v10 5/7] block: factor out bio_map_get helper
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com
References: <20220927173610.7794-1-joshi.k@samsung.com>
 <CGME20220927174636epcas5p49008baa36dcbf2f61c25ba89c4707c0c@epcas5p4.samsung.com>
 <20220927173610.7794-6-joshi.k@samsung.com> <20220928173121.GC17153@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220928173121.GC17153@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_104931_725809_E0193C6D 
X-CRM114-Status: GOOD (  20.59  )
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

On 9/28/22 11:31 AM, Christoph Hellwig wrote:
> On Tue, Sep 27, 2022 at 11:06:08PM +0530, Kanchan Joshi wrote:
>> Move bio allocation logic from bio_map_user_iov to a new helper
>> bio_map_get. It is named so because functionality is opposite of what is
>> done inside bio_map_put. This is a prep patch.
> 
> I'm still not a fan of using bio_sets for passthrough and would be
> much happier if we could drill down what the problems with the
> slab per-cpu allocator are, but it seems like I've lost that fight
> against Jens..

I don't think there are necessarily big problems with the slab side,
it's just that the per-cpu freeing there needs to be IRQ safe. And the
double cmpxchg() used for that isn't that fast compared to being able
to cache these locally with just preempt protection.

>> +static struct bio *bio_map_get(struct request *rq, unsigned int nr_vecs,
>>  		gfp_t gfp_mask)
> 
> But these names just seems rather misleading.  Why not someting
> like blk_rq_map_bio_alloc and blk_mq_map_bio_put?
> 
> Not really new in this code but a question to Jens:  The existing
> bio_map_user_iov has no real upper bounds on the number of bios
> allocated, how does that fit with the very limited pool size of
> fs_bio_set?

Good question - I think we'd need to ensure that once we get
past the initial alloc that we clear any gfp flags that'd make
the mempool_alloc() wait for completions.

-- 
Jens Axboe



