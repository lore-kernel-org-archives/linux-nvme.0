Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0C0C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 14:41:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD8B361164
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 14:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD8B361164
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N8w05oFbWFAKCVP+4JWSz4RxyHp111NubKrEF9wnPKo=; b=SaR440/WkhsBKntNtfveJda7qc
	ebMZgV3Phxe6myR06wY/1tuteCK+xKzS3gkXddQHIwwNofauYaeDYdv5SAZrmYjzwqucPeAfPOHHV
	GhJ8eGNvA6tzefrcB7gZLknXj5pcl66jA9ki9UDsCQYiYWtbLv8BAqwW9pkKb8CQsfatv2gznIl14
	ktPgWnp4673fodd09srTjtx3+CoXLLNb8j3ismxjGrCgcKTL0p3jp1CxTUVFZjGpZinv6ZEuYy3Z1
	QhYiAUKSQMUrOgNek+Yymj/agXPeREAoIwLRNTqVM2kLx3hfHX2Dy+Bvdbn3+XkxFAg9opm32CT1x
	9hNcxMNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mafRk-00HCaq-L9; Wed, 13 Oct 2021 14:41:32 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mafRh-00HCZd-B6
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 14:41:30 +0000
Received: by mail-io1-xd35.google.com with SMTP id i189so3296976ioa.1
 for <linux-nvme@lists.infradead.org>; Wed, 13 Oct 2021 07:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=N8w05oFbWFAKCVP+4JWSz4RxyHp111NubKrEF9wnPKo=;
 b=Myav3CG0zG04zE12d6m6SVr7/m0adi9m4yMsK2J7Eaj/X7c8Xdh8yYg9DBENVcOtn/
 Uju1XHf7s07kXg616ul1um7FHNEwbbuxUxP8Wi0gVlvEluvUjxIM/1Dt9bN4du2xdX+O
 MQQcyL7tisqYvgIa8IAW11892BPmXM/6R78WHD1WEHANp3yIubG/L8D0e2B1kiWrr9mH
 dzhY1y224aFyvPOAZhG5j60FNDRba8UdCErSaFHSvi4eJC4AJ3CAaLjzSA4lhL5czW+A
 vCe51yDgrnd9fETvNZeEvr6kbiXIREbDfy7TugKMeVqY1KvW4quVlERwtPdTSBbnIl+z
 iE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N8w05oFbWFAKCVP+4JWSz4RxyHp111NubKrEF9wnPKo=;
 b=OAtC1O0LWJHEiXQ1nznJ01KePpZzL9lSL9yqjkQywTj7EIrJWVUbcYu3kiyv0B4rvf
 AEdjc938rLU+qLxTAZj+XGU41cyzpVyGpVOU3uGxMg4jrLMwWM82BPxxICQePsFRL6rM
 pdC0Fe3giazYCEQ/6TbdrLy81w/XcUBOWFWN7fqhNpm6otf57Rk/Bj/6wJYJjV5SQ4Fg
 Q09Dx0AV84cpkS5eynu75fGvOX1vd3zEiPeKBP8A2u9t2CRr9AU00klD5whMEA1KVJ7D
 Zsox97FsbpLRMZXEtI24ACw4xSb6BirVsSlchMk2wUGq8fotiH5DvQMK6RHWPBS3R4ol
 FOjw==
X-Gm-Message-State: AOAM533Hi79OKhI6nAQFA9EIgkwlU3X64bW3jlBG4gmermFQ4NiEc9sH
 BP2DvG9lRHBSd81KCgjjaTBveKUehx6GyA==
X-Google-Smtp-Source: ABdhPJwAQWHVgfXcDNmIvOl5VZ5cHRfQm/2paaeVAg37P91R1vJ9/R0PNySzfpWqhnl7sVhGGiOPdw==
X-Received: by 2002:a02:c484:: with SMTP id t4mr22699476jam.37.1634136088080; 
 Wed, 13 Oct 2021 07:41:28 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id h5sm7127030ioz.31.2021.10.13.07.41.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Oct 2021 07:41:27 -0700 (PDT)
Subject: Re: [PATCH 5/9] nvme: move the fast path nvme error and disposition
 helpers
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-6-axboe@kernel.dk> <YWaDQiwoo/vjNXxZ@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <044549fd-b3eb-cfa8-b687-42726c2ed08e@kernel.dk>
Date: Wed, 13 Oct 2021 08:41:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWaDQiwoo/vjNXxZ@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_074129_454241_CDACE4B4 
X-CRM114-Status: GOOD (  14.50  )
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

On 10/13/21 12:57 AM, Christoph Hellwig wrote:
> Please Cc the nvme list for nvme changes.
> 
>> -static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>> -{
>> -	if (likely(nvme_req(req)->status == 0))
>> -		return COMPLETE;
> 
> I think the only part here that needs to be inline is this check.
> The rest is all slow path error handling.

I think I'll just kill this patch and check nvme_req(req)->status in the
caller. If it's non-zero, just do the normal completion path and skip
the batch list.

-- 
Jens Axboe


