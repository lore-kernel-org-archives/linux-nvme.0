Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229DBC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 09:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=a6sm921oCJ80+srmCg978z5BNL
	gguQ2yhpuRzAlO6iZfSokyqtQq+wpOApin92toD5Pwp7ncm/od0yKtlPe6LXZClkC45rHmJXWK6Gf
	1lSAM5C4UYNrGB1vfLQNstmmU5e+uqeXjYlqSOTelt0FKGP9YIwbQ+eCGUSEVW/4ao95k//wzTCr5
	YNVk3uYdg5nWdSefi0yJHRrQW9uv2zTq/4YQnU/gm6y62T9MbWNqBNb/4oJGAhxwUxqBVSOL2z4sE
	2MKaP/W7/dhJP6hoUgfrrEBbuEzF+qo81K1VaNqbyTRk+GIF7uj8nSBs9UGAnD3T3Wg48Hpv/IfL9
	I5rqHwPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBYP0-0029qS-MC; Wed, 13 Jul 2022 09:11:26 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBYOy-0029mD-7I
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 09:11:25 +0000
Received: by mail-wm1-f41.google.com with SMTP id l42so6060186wms.5
        for <linux-nvme@lists.infradead.org>; Wed, 13 Jul 2022 02:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=kxnhL311eLyRr53eSzQJwo8xxR7AaZD0Gieoup/5i3qR0S5fCh7ILxgUHjY0lRjpAr
         BMPLyMZOgU2XhayxMwiNdBXVphglrzgcjfdG+DwcG/fQ/XbesbfUnvB6lzqy/kQGIL6D
         oggQcCUgK1zenz/wCnsZOP5jPjB9U5vWcLbZbyFsNRDxpaIWxz6rkCeEtgkxTmb2XLL8
         OauzofjSd9QZIaAbMv76nwZ//7YhtIVUhj4p+bF8mVV9/5gbst7+ePgK5jMCzUT7QRGj
         rHU5gH90NMwx63sRrGpRYAV2KvILT0NPPspiy+jlsY06uMENQbfiVhxNtir3go+3kGSi
         GpfQ==
X-Gm-Message-State: AJIora/U/HLiPbstFbp1TGY+OGnwmWggQwC2Bp+glSQz8AD7ezhha8rC
	kHXuhPaFTUCc7ySNYSY3wFs=
X-Google-Smtp-Source: AGRyM1s+VUgReIDMGImas24B7tmqyPSLjKyy39GA/558+o15dif6CzP40lOtHKKPhtiyQzP7KmuW+g==
X-Received: by 2002:a1c:4455:0:b0:3a2:d929:917a with SMTP id r82-20020a1c4455000000b003a2d929917amr2504865wma.38.1657703480915;
        Wed, 13 Jul 2022 02:11:20 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b003a2d0f0ccaesm1612995wmq.34.2022.07.13.02.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:11:20 -0700 (PDT)
Message-ID: <8d78d71e-b3bd-1631-646f-614a9e82e024@grimberg.me>
Date: Wed, 13 Jul 2022 12:11:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/5] nvme: rename nvme_validate_or_alloc_ns to
 nvme_scan_ns
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Joel Granados <j.granados@samsung.com>,
 kbusch@kernel.org
Cc: joshi.k@samsung.com, linux-nvme@lists.infradead.org,
 gost.dev@samsung.com, k.jensen@samsung.com
References: <20220713054914.1888305-1-hch@lst.de>
 <20220713054914.1888305-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220713054914.1888305-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_021124_301276_35078743 
X-CRM114-Status: UNSURE (   6.67  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

