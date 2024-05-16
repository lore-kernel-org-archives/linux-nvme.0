Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9615FC25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 16 May 2024 02:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I+7daecJRB1K8ERvqxbImKF1sffU1MhW8D6cj40EMyY=; b=UceioLMESuG+59tl5oU/H9VP43
	tGJibonYrj012IKUk4K9a7ovYg62PJwSB0dJ9Thq/Vx1LZVv/ZHtLX3JwssBbkW+gCLyEvLiQqOKR
	kT5w3uhcld8krFguOFef8o1Wcov5si/3XxLg/k3NSeKigDQWihphnXTndrHCxWGBZoVgHFZWEtZYb
	wCSEM7pI/86V3OOxlBzcMjGUD2mNbZswVmrZpsDgQiPoE+YkbCCcnY7RHkiU+a152Yvw98vsMiUvZ
	KeFVTHyvFGjAQVJBobRMKTvTDa0r4mN80byjH8aarC8os8dBShPJTf7v/Q6USgPrYcrf9y7CVXqpm
	YtozfwuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7Qsy-00000003TN9-1sdn;
	Thu, 16 May 2024 02:30:24 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7Qsu-00000003TLC-2RQo
	for linux-nvme@lists.infradead.org;
	Thu, 16 May 2024 02:30:22 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2b8efd5ee5dso1090362a91.3
        for <linux-nvme@lists.infradead.org>; Wed, 15 May 2024 19:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715826615; x=1716431415; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+7daecJRB1K8ERvqxbImKF1sffU1MhW8D6cj40EMyY=;
        b=JoqSpo8xSj7uWi0oPa9cGKDwbk9dr6RSoCv8d0L90dopV6mp7iD8jgNMCpA/WXIlmx
         0psuyeVkeW081zTn97fRnte4uYjeEzIJITWBjdAraQQROx5v0oC9+WMkukNGT0TvPLwY
         4XniSWJEBnOAFVUjlARh0S8Tb+MknGbpZyRrM16hbng9ggbCGRKeTLYrQ66rVAmg3ENh
         fk9fe0YpBCvY81ynoPoNTPWKs3f4DrgLhrM9727fXtD+WA6ikFUvb0tubCp6lAD6hWSe
         uaLAWpTjEqg1VLeR/Rc0vbMTh9M0mV3J9tkw0t+PqCLGtyWDvWBmTtKU/rpE2BKU6OIl
         Qbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715826615; x=1716431415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+7daecJRB1K8ERvqxbImKF1sffU1MhW8D6cj40EMyY=;
        b=K2h4Md0HDSSIWD5kybltgiKgq6PG61K1SDBPvDPHgpHc3PosxkDhYBlU6kX/37RLSV
         L3BJggPTq3EFBbFLzZ9s7AaaRbHUD9AHbx5Jaz4yyPvc5ycCTgthhDiGjIY402hYz8lF
         4I7tMv/s8xp9UDt67MX7gdhzvdhrD9gtj4LImZf+mgosqnfUnDL3hibFSOE62Ob3LuvM
         8w8aDMuvOuZ/2VF7dqmTbRmYxPMcVlW5Zsv9kRZZS2LN0icOA24EanTmrY3hak2iSNYT
         sgrXxSM8Jv1DPdADK0doi0KkYSQD4U54prn7X9oEXlw52DwCFgjnbC2Q+woi1DMzcVdt
         YoIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhkZ+ZzBYvBlCw0dbEeaPTIacJvStIZl/zAjK9k8b/EAKXAkcw5uR/2uAXF6My4bJPBYW8+Uq/LG24Tqni81d1PJ5F586wgu4etSnqu9k=
X-Gm-Message-State: AOJu0YyXcwNt03ld2KOnLjAVZYs7ruiAQm9DagS7txAe6/Bsf5/bbJun
	eLAyBwN67sasJus7qFEtccPdmuQV07MPHgDVP0rwi22ZQyoNgm8sB7dNGuNhhfg=
X-Google-Smtp-Source: AGHT+IHisy9+lDOgAxqwY5N2n4AXPgS6IiVdn1NisspaguWsx50BdDg5mkfFVisgYhmrskBIhdn0sg==
X-Received: by 2002:a17:903:2444:b0:1e2:c544:9bb0 with SMTP id d9443c01a7336-1ef433d37a2mr200912295ad.0.1715826614709;
        Wed, 15 May 2024 19:30:14 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30fc7sm125494195ad.133.2024.05.15.19.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 19:30:14 -0700 (PDT)
Message-ID: <8522af2f-fb97-4d0b-9e38-868c572da18a@kernel.dk>
Date: Wed, 15 May 2024 20:30:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] block: change rq_integrity_vec to respect the
 iterator
To: Mikulas Patocka <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>
Cc: linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <f85e3824-5545-f541-c96d-4352585288a@redhat.com>
 <c366231-e146-5a2b-1d8a-5936fb2047ca@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c366231-e146-5a2b-1d8a-5936fb2047ca@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240515_193020_660178_8E6C9341 
X-CRM114-Status: GOOD (  10.57  )
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

On 5/15/24 7:28 AM, Mikulas Patocka wrote:
> @@ -177,9 +177,9 @@ static inline int blk_integrity_rq(struc
>  	return 0;
>  }
>  
> -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> +static inline struct bio_vec rq_integrity_vec(struct request *rq)
>  {
> -	return NULL;
> +	BUG();
>  }
>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>  #endif /* _LINUX_BLK_INTEGRITY_H */

Let's please not do that. If it's not used outside of
CONFIG_BLK_DEV_INTEGRITY, it should just go away.

-- 
Jens Axboe


