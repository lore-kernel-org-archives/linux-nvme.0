Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0B6C77B7C
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 13:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5J9a5kf3kmdYh2Ndj6S+0+amm34/1HJ3W1fY7sBGzIs=; b=1rRRLknO8cgdMS530Xqlj0qkgE
	2zImHSHN8vEY1e3DeSt+Op+CMXuxpl+0mu3aaU2b425UJzDoh6UNXz/pUItadxA189XhCk89XD0/6
	EBeq+796wCsRIjaHvsEorXpE6yi0v32HpM7KbrgJFYz3U7BDQGQIhKl9pIYW10D0tMzPENiWdOFx5
	cHtz+oB1uW+VfdC44mNb0cV5YYtJSHEBfousgjfGjVIc7EB9ty6vIB4iL+VZHLNg/gi4fbkZZLQQY
	LT7I/6j9JT/Z3bue+7p935+Ywa8PsejEm3Ax/i9idOU6xOciG2FGrTLYCapeb6Q8UUE0w+nHQZSWO
	/F43SuDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptU1m-00G6KN-0A;
	Mon, 01 May 2023 13:57:18 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptU1h-00G6Jv-31
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 13:57:15 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f16f792384so6723735e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 May 2023 06:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682949431; x=1685541431;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5J9a5kf3kmdYh2Ndj6S+0+amm34/1HJ3W1fY7sBGzIs=;
        b=WSu39iCPUpcp9eh/yu7SBtoOCme3U/9F8aqwcawsvNZydyggo5u3Mllb2Wu8UMhcyO
         qFcI/1TmcZ8N2vrlGldxHfPC0hjB0pJju5whd1EFnlGHp2IuWOy/KX9i7CY7F41FMqKL
         uEITrLyvQA7zmQiqLvB/hDO0VcxeTxVw+uIM7ih053Y9L06KU44GypaSjxrHTwZJ1rT1
         f6CmyVDLq18Xrl1utELme+axIEC2ZvW8kyJTlXICMXSNk6BOq9GvE45kFN3hkw9A13Di
         LTjLqu3kbDjsztGvSfGKntVIhSJJwH2Gxu2m122fB7lHRVC4skqKwS5xdZAJYd69WCjP
         PMsQ==
X-Gm-Message-State: AC+VfDxxNrhU9ovb+vlfwzpfbfznVUjaqMx6TwuPm3OA9qQ1b1g9n6mj
	WlyliWrq98Pyc4e0BrattrM=
X-Google-Smtp-Source: ACHHUZ7huY9T4MZzSyl932OZ5qbrifrmg+VePH2kBZVD2pNW6t9H7hY3XxVgttyySFZmhsuk8n5wWw==
X-Received: by 2002:a05:600c:310a:b0:3f1:960d:68ce with SMTP id g10-20020a05600c310a00b003f1960d68cemr10825464wmo.3.1682949430985;
        Mon, 01 May 2023 06:57:10 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c444900b003f173be2ccfsm47590803wmn.2.2023.05.01.06.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 06:57:10 -0700 (PDT)
Message-ID: <012a86ad-933a-2948-29d3-764346afbd6e@grimberg.me>
Date: Mon, 1 May 2023 16:57:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/5] optimize some data structure in nvme
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, hch@lst.de,
 kch@nvidia.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_065713_997665_36EC09AE 
X-CRM114-Status: GOOD (  19.10  )
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


> This serie is a proposal to slighly optimize the memory needed for some
> structures used in nvme.
> 
> This follows the discussion in [1].
> 
> Honnestly, I'm not convinced that this serie really brings semething.
> Because of the way memory alocation works, and its over-allocation to try to
> avoid memory fragmentation, some limited gains are most of the time useless.
> 
> It could still help:
>     - many holes in structure can, at some point, have its size reach a threshold
>       (this is specially true if such structures are allocated with kcalloc() or
>       kmalloc_array())
>     - it can save some space in some other structures if embedded in them
>     - it can save a few cycles if the structure is memcpy()'ed or zeroed, for
>       example
>     - can reduce cache usage
> 
> With that in mind, patch 3 is a win, patch 4 is likely a win, the other ones are
> much more theorical.
> 
> The changes are really limited, so even if the gain is marginal, maybe it still
> makes sense to merge them.

Don't see why not, given they make do the structures smaller.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

