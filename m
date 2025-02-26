Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A657C021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 19:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BZO9STZ95sF/hThjh2V4XP8IUCqoQU8S45+6Tzt1P4U=; b=w9UpDxq21QPxbYDSZ+HqgjDVly
	LIsIYtPCuZYL1fEMTnVizv0YsOrJMv86onqQ7a/ZgLLMGQfwP4Az3B1O2Mi9dQQYpcyjIfAjUZtyq
	A/r2bpHKrBCUxmPdAU+vQP0z0BD0V58C7rwZQz+Q+WAQbcYRb8L65JMU4peapR1QCMlcg5nVsFPPc
	4PemN0dnMmmY5N4UJIalFeooCcthbbaGtw72n5wtmxVD3Xi9e/n0uoQK3ZAoBbnQYrf0B3ypgRuV6
	JCirFx0AZjNDvcktiI5iMqcIMNPmQY66h3Q3NDMDwCgoJS9a4rIaS19cPLuHP2El4G3o6cp1nzxpc
	zmL5XSuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnNCa-00000005B3p-3xtr;
	Wed, 26 Feb 2025 19:36:16 +0000
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnNCX-00000005B2r-34Ak
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 19:36:15 +0000
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-855a5aa9604so4631239f.2
        for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 11:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740598573; x=1741203373; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZO9STZ95sF/hThjh2V4XP8IUCqoQU8S45+6Tzt1P4U=;
        b=ebCwhcz5MFTwj9NMb0iEKKDTwqNBFYjo5R7wTkUcDPl1mkWh9OlYQyX346g9mFEMiZ
         00NLbbx3SPYhO6u/z7OCfy30v34TADpTaxEzMgwub3F2qihJc1++H+5wsIVAsZZWwmOd
         wAc/sIpWeJkk7IlHwrrcXBqCl70M38oyLo7Z7wYFPpSR22Gkntef4fcbZK5HZjayArVo
         mHT8mZb9DAdEu+GdxA/sSsk53dHkN2Fh3/xRMqAmTjCFCRszDSrGsi+s3OOmvUpIP/hE
         iGSB7ta+XOhIHeDQ3CEXYCynAj3vu1rW+qIvT0wHYMLbEWy+9Y8eT06vKnDGKAKUr4Ra
         I0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740598573; x=1741203373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZO9STZ95sF/hThjh2V4XP8IUCqoQU8S45+6Tzt1P4U=;
        b=wwzwK2lWtKrrhy+3WpoR2v0La71aW7uCKYyZlI2K2kmgGuaQ8ROirF8rOAfv6RCsFI
         1tL1cfR+UvLqJjEAyepraEGAUIz+yr+vxsKjYIudA2wkM7gwIHZK0RGoQ1o8t5mDvxNv
         PiEV4N81Eu5sPzzxqKpfnOwIUnrLjHing31nAAZNGX7sp9Zk8ly8uZB+P26xAK2q/TV9
         IHCFRJhv4GO8RDnWbeIJLo8VkCoCncznCPab8u9FVU9Av0gAVE5BwxI7394FEgLmCTgU
         jeL8SBQF6UB8iCTDBgeoMld4zUYfV2PTO4MzG7tRZIVqTxNUF5C6DRPy+psf7qg1CvjO
         aO1A==
X-Forwarded-Encrypted: i=1; AJvYcCUj0Sg0KWgw9xOHHmAzrPn0Uw+/WaVweEJyK9zDmOu7GUeFYB806jYCNJPJ8EgUZe2IP4gWMYEGApvQ@lists.infradead.org
X-Gm-Message-State: AOJu0YzpjMDtujkgq2UGkuRVasLhbLhdHLdIQZpoBP0LfGJN6rYhOy9a
	G7uI9MgxwF0Y5rP0MU3xfRm+A0Klab/T8foqJSUhZfp4/rO+aGwRt29a+uwRGgU=
X-Gm-Gg: ASbGncvA8l5n5X+LBLPMHyKPXwDWbQ/eCvei3v7PWShdSM6lMVmbj0qjfgHy7n2GgNO
	qgkZu5adid9Dbqqk/HieUGN6is84XhIIMeFrGMgBpqWP0ewoBG0lXVDG6lUM+34EgGoYHRhK3MP
	sgCVdXfSqo6bPP29Mt+FW4bNff8lM4prD21Kg3TPRTQ3K7U20ezpGQUzTsI5/UCtHV0jDVsBv7C
	CtVdkwrm5m12vBHFkca3VslpTg/yu0Lk+cKBtDwm4ayH+8rL8gGD12AHRNZ2Vh0x/uDt5kkdEu2
	9dtomVvx1vHvZ3n18hFtLw==
X-Google-Smtp-Source: AGHT+IEbyL3881tCFlSZe9P+BIU2SFkXwfwwPxd72T/h1DgwPnDSWSN6qbGSXbtQaoY0apPWHhil4A==
X-Received: by 2002:a05:6e02:2148:b0:3d2:1206:cabe with SMTP id e9e14a558f8ab-3d2cb52f7cbmr218812255ab.22.1740598572682;
        Wed, 26 Feb 2025 11:36:12 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f04752dd55sm1043887173.113.2025.02.26.11.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 11:36:12 -0800 (PST)
Message-ID: <83b85824-ddef-475e-ba83-b311f1a7b98f@kernel.dk>
Date: Wed, 26 Feb 2025 12:36:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 6/6] io_uring: cache nodes and mapped buffers
To: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com,
 asml.silence@gmail.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: bernd@bsbernd.com, csander@purestorage.com,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-7-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250226182102.2631321-7-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_113613_772411_9A861C3A 
X-CRM114-Status: UNSURE (   7.92  )
X-CRM114-Notice: Please train this message.
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

On 2/26/25 11:21 AM, Keith Busch wrote:
> +	return 0;
> +free_cache:
> +	io_alloc_cache_free(&table->node_cache, kfree);

kvfree?

> @@ -548,11 +607,19 @@ int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
>  	return ret;
>  }
>  
> +static void io_rsrc_buffer_free(struct io_ring_ctx *ctx,
> +				struct io_buf_table *table)
> +{
> +	io_rsrc_data_free(ctx, &table->data);
> +	io_alloc_cache_free(&table->node_cache, kfree);
> +	io_alloc_cache_free(&table->imu_cache, kfree);
> +}

Ditto

-- 
Jens Axboe

