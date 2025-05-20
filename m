Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93196C3ABDD
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jNI+eyCxVvzZ3yWBOQLs4twgf1ouYdI/dHpJKVcoJ5I=; b=oRSwelFH/yKfBPHbmcN13KjyU6
	RHOT2NVCO1HCc//PPovVXHPIXgTvuONMNFrzxPvoSOiyqxGksFs664VzU/Uinl/ah1sVskNzii1rr
	v1aE0JmR7Oki53WNgwEePBK33ZzezJkEnq4QQM2UStgG5YmWf9QXmrvoqkkN2ZIliKu1sSUZGyWJL
	DsyAtWXsajFgk25tk7LKtFg76f1YZoFgeuCBINyM9eidYhjODiWE2WNeNwLMTL6ek8juCYIKWFFav
	cap7aeiYf+ZUG0/e/crRK8GicdMrEPVYHtn4LXAob2jAZHrZy+3mTWOHg4r+nlKj1tsO2I1ivxTCn
	IlgHeB+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHPmo-0000000DX5e-1Cjb;
	Tue, 20 May 2025 16:25:50 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHPcJ-0000000DTpo-1Qs5
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 16:15:01 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4947635914aso60704701cf.3
        for <linux-nvme@lists.infradead.org>; Tue, 20 May 2025 09:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747757698; x=1748362498; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNI+eyCxVvzZ3yWBOQLs4twgf1ouYdI/dHpJKVcoJ5I=;
        b=v9Me98jeymspLa3+MiJAdrq1gy9VRHvvn2UoXvF9Gh8Xij3Kk8V4+eFttktUpmMRgq
         TIZx1aUashyvo09wHA6XNosBw94+zoEnQALlp+XKuDjc4hlpL7P1IibYM2eeSou7yCb3
         tNuEutigqufyLwvFhaYxwjN7KFDZZtmCFVYmzwKXKVyd6a4wsYIZ10bKCBA9nzq6GxS2
         UvDh5gVQ3KVPrwhGRI9+AF2lSchl0Uwg4DzwvKJD3Kcwhbnw+721GBmCa3SRLTUBQRKr
         h2He09utuGA3WPv3E5GlZ/q9AgCqUoBIbFT8bx7niL8PBH5pBNOhk8jScdpuQ+9C1zQA
         3MpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747757698; x=1748362498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNI+eyCxVvzZ3yWBOQLs4twgf1ouYdI/dHpJKVcoJ5I=;
        b=NU7/jIzlVjQ9lqNiBktDFDHa2PwHciQQFOQtcGH8v1iirUbX0ZHEaoa51AdNQXZv6E
         iTDXd7QfZg4sc1ilg2MiTdC16lOJUgMZpdIScMRVilXSUSh1KWOqqzqT/0ZjitRmyKcq
         5rvQ0eqXwmGMq5d49KyJC5NCu1atfqyIzsCTJ8PrQPomdsIBely9vAw+BkPwictGTE7U
         FOx0K4jmyeOV9JWBxShSEigVBKj4BUkp1nhcSdezfmxo4T3uEFP8XmQ0LFD5pU/4pq6O
         dA87wKBhNVFAK3kgOr8A6q8VXbWp3Ddtrv6/J9uRXUvW1VwEzD+hXDFVgpbcGOFwcMQ2
         W12w==
X-Forwarded-Encrypted: i=1; AJvYcCX+ts5axj+RcWjhcDVeOFpXJt2f0US8pitwn3DSWS+x7awcvgzl0P8VuEpU/cX6YHTvpfE20cs5/iwn@lists.infradead.org
X-Gm-Message-State: AOJu0YygrO+fPlCVi7WxPDmnj6ILd4ae0uF0WASjKRXbQ8W7MVdPZLV7
	uGfHpN7RokdYZwv6rq363HbUfJ9kzPvmNdU+BFDVsDAtkWyaLOb+oOnWBKXv1lxDVwZEFVr++Co
	UUipn
X-Gm-Gg: ASbGncuG8pSH8lw5+ZLycwYRLU8mhxQvZo1I/aUc+fka/GL2+Mf0H+BP2KQUXNJFETf
	e6k18+meM2ROhphED/QJ+UvistEkWcCNW3qpWeyBoyf/m5keIAN8ndyKA1oK1WOcPOPWRNv1Vdq
	C5M6ZDKGCQ4g30BtjE5uUCDZGn8f7I4vynCHbloo1eo9LoS6JgNCubvRweh8ZfzqYcpotxQZXgc
	9KRkRAad3cHjpb7LX+xGA5E7/rvw9IuB76TArf82gfa7p1QwDWd31gOECHRgsazl85nmmZD+e6x
	bK5tZkvh1nVy6JhRqn8ksZRNOxlg7vcnIErH7oLZaa3VdQg=
X-Google-Smtp-Source: AGHT+IFcy7gIAABkUAz4oVAxJQVMe5uB7za8pcx2PX4nx5y+S4aJfjyYDqiBJCea66mlfm6pVDqgwA==
X-Received: by 2002:a05:6e02:184c:b0:3db:754c:63b with SMTP id e9e14a558f8ab-3db842de1b9mr202158035ab.12.1747757686851;
        Tue, 20 May 2025 09:14:46 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc7f126188sm2141495ab.65.2025.05.20.09.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 09:14:46 -0700 (PDT)
Message-ID: <94f91748-8538-42b4-87c8-7067b5369045@kernel.dk>
Date: Tue, 20 May 2025 10:14:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.16
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-mm@kvack.org
References: <aCyniHQRl2HMjsvu@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aCyniHQRl2HMjsvu@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_091459_401915_5B2B0695 
X-CRM114-Status: GOOD (  15.11  )
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

On 5/20/25 10:02 AM, Christoph Hellwig wrote:
> NOTE: this includes changes to mm/dmapool.c.  We've not managed to
> get any replies from mm folks for it despite repeated pings.
> 
> 
> The following changes since commit 496a3bc5e46c6485a50730ffbcbc92fc53120425:
> 
>   blk-mq: add a copyright notice to blk-mq-dma.c (2025-05-16 08:43:41 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.16-2025-05-20
> 
> for you to fetch changes up to 9e221d8cf90b8599a6a3d62a1ebb712468f42a35:
> 
>   nvme: rename nvme_mpath_shutdown_disk to nvme_mpath_remove_disk (2025-05-20 05:34:52 +0200)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.16
> 
>  - add per-node DMA pools and use them for PRP/SGL allocations
>    (Caleb Sander Mateos, Keith Busch)
>  - nvme-fcloop refcounting fixes (Daniel Wagner)
>  - support delayed removal of the multipath node and optionally support
>    the multipath node for private namespaces (Nilay Shroff)
>  - support shared CQs in the PCI endpoint target code (Wilfred Mallawa)
>  - support admin-queue only authentication (Hannes Reinecke)
>  - use the crc32c library instead of the crypto API (Eric Biggers)
>  - misc cleanups (Christoph Hellwig, Marcelo Moreira, Hannes Reinecke,
>    Leon Romanovsky, Gustavo A. R. Silva)

Pulled, thanks.

-- 
Jens Axboe


