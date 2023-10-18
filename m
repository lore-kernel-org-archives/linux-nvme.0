Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B90CDB47E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 18:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jrap/YtB/Sd8Wus7hHKRx+7IUNmLTOe1yzTe7Ucyy5s=; b=ut4dhdMimdP50/3rHZy0rM0XDH
	376ld+pBqKLHAFcakxPpWoZA7AjBViXnVKmK5axcip9vFp7m2igy4B9+e5rRdD6aamzYOpWVI86MX
	TNuliEfyaC4diHItolCTKA55iUbnvGauqS/rfqe5kGEl9wXJOrsHUfVhmoXR25OOykK4FxqEOuYVv
	erA6ou0B+oTIXGzCiu/MjAXY+zNn0i9+gBbTOrqzB1BepuOhg8Iglx/ZPbYFoe/2gcIHKaK+ngiRZ
	gJSlPlkxpnPIgHl6GwZLAm0VQdJAlTeWUlNyWT9poYO/+4HhT/wveOKui7d3JH76VhAwM0dWefrr/
	Tm6C+vWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtBTJ-00FTmG-0A;
	Wed, 18 Oct 2023 18:40:45 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtBTE-00FTl8-1E
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 18:40:43 +0000
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79fab2caf70so58654539f.1
        for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 11:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697654437; x=1698259237; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jrap/YtB/Sd8Wus7hHKRx+7IUNmLTOe1yzTe7Ucyy5s=;
        b=a5C7aFg5j97lF9rV1jTvukTOHG4Nf7ZR2tjzQUeOBNbI47RqfEM1C6dEc+hCAhAwta
         GwprDFAdaziUQ90plEWIiatd6qY68DsmUMeHkrhGoNsNKzxKQVO0rQmZckeDmr79938N
         QlE/kHBRCX9FKpPoVF+XTBN/cfTfXwfneF372nE1XdzlmK9k1rVu5wZqdgh4lT2v+v7o
         SFeHwJtavKQWSLuz6qAOtD3d1sWk6k6XW++qhribozNWpr6zlyIZdi+/gUqCwfUOcWKn
         UMOtE4tRX++ggdcWkxjaPX6igmfehak/joqOkUowmENwFCAx4V9VMUz0H+E81FjO+VzG
         tf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697654437; x=1698259237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jrap/YtB/Sd8Wus7hHKRx+7IUNmLTOe1yzTe7Ucyy5s=;
        b=HKLK0OrinhE2axITMPTpMfH2AEUOi0hhGYcxdz5dzBr36p5HuyL8flW5Fnah+I3gpF
         8kDN0jYV4MyGHlVnvnXL6h5BIQucR3X9Jc9gEHzwTBStvx+Wz9E6uICealOcxIaTAtZ3
         +SAonNgJTpFzKiCIz7bMqqrrKO/jTO5+4/jsWCKiUlt8/OB5bD2RxPFFKw2R3grqeSIi
         hhBOIDfJb3Va091N1KuxyQmVPdky4ulgqLwlQge+EF4mDZo2xtDE7W1dYvQr8k0DLrTf
         pqBpvNmXAamjUcNsxwt63ftcbyQTSKUh6DdO8cnmwkWYh84hSYcw/e+bW9XuLpQ76/+6
         i0Ig==
X-Gm-Message-State: AOJu0YxdzLPg/cVvh3O1OpYyHHCY63ZzOruwwpCEnbws3mBmbusBB3YG
	cN3OadsGIj5jhvg95Kld8Le/bg==
X-Google-Smtp-Source: AGHT+IF/mw2nhMnShefoRjeknfThW7m2powVt1fzQRugKjjDxEyb9jncdBW+U6Mw21aiUl3At14ZmA==
X-Received: by 2002:a92:d2ca:0:b0:34f:a4f0:4fc4 with SMTP id w10-20020a92d2ca000000b0034fa4f04fc4mr162371ilg.2.1697654437401;
        Wed, 18 Oct 2023 11:40:37 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s5-20020a92cbc5000000b0035797ea96f7sm1298810ilq.9.2023.10.18.11.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 11:40:36 -0700 (PDT)
Message-ID: <2f6cdecc-d51b-4cbf-a0dd-ccd22fac8a98@kernel.dk>
Date: Wed, 18 Oct 2023 12:40:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Unprivileged sgl-only passthrough
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, joshiiitr@gmail.com
References: <CGME20231018183620epcas5p26ab74bdd1f2739ef3ec1ee2431329dc4@epcas5p2.samsung.com>
 <20231018183003.41174-1-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231018183003.41174-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_114040_608153_A9710CF6 
X-CRM114-Status: GOOD (  10.87  )
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

On 10/18/23 12:30 PM, Kanchan Joshi wrote:
> Patch 1: Prep. Adds the meta-transfer ability in nvme-pci
> Patch 2: Enables fine-granular passthrough with the change that i/o
> commands can transfer the data only via SGL.
> 
> Requirement:
> - Prepared against block 6.6 tree.
> - The patch in uring-passthrough failure handling is required to see the
>   submission failure (if any)
>   https://lore.kernel.org/linux-nvme/20231018135718.28820-1-joshi.k@samsung.com/

I didn't have time to follow the previous discussion, but what's the
reasoning behind allowing it for SGL only? IIRC, we do have an inline
vec for a small number of vecs, so presumably this would not hit
alloc+free for each IO? But even so, I would imagine that SGL is slower
than PRP? Do we know how much?

-- 
Jens Axboe


