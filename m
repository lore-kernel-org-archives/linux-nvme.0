Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E40BC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Dec 2021 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P8Qlq0IP76FBJPtbKTV0K0to60+5xjfpAElrt5bnfUU=; b=hsJqn7BbXQzd041nmOc4GNoFfU
	zXmKiyUMqfIKtYgFAbzOj2kY/yboZQpZqVnUrft1N6OT1cO/I9dAx6NvngIk6QIZ0lwRJ4s972X/q
	Ax5wSl4bOLhX3aLoxtuclfm5FTBNzGGwBY2BKgQAyYOzrYabSduZRFj0r8DIFP1RpobMGyy2XCimw
	ZULIT1YcoxK3Kc+4uhI6/WP69YBvzeny63Xve7N7OVunTVL0u5inyN1pPs4uKG8crfPhf+CES8buQ
	O2ElNeS6Ce3XC1L4A7tGDA1Pkk2Ucv/Z1kt8fquD51ejk7fyLeISjFLwUeoII6HhE1Om7M4Ao1KLY
	xuY/f9Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1muGvI-004nHH-KV; Mon, 06 Dec 2021 16:33:04 +0000
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muGvG-004nGC-1r
 for linux-nvme@lists.infradead.org; Mon, 06 Dec 2021 16:33:03 +0000
Received: by mail-il1-x136.google.com with SMTP id w4so10766232ilv.12
 for <linux-nvme@lists.infradead.org>; Mon, 06 Dec 2021 08:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=P8Qlq0IP76FBJPtbKTV0K0to60+5xjfpAElrt5bnfUU=;
 b=7YoMmeZOFlE/gf1crOSyXJawN2jjGiLYiNQnMA8S3fU/7lAXGqTATxFQZ98EEv62Am
 qugOz8oc0aT+XD+6vTX8I2Y5WMqcL7Y0COE9Q4pa6h0TP3S15EXWv5aayyq8kjXettb0
 sKV4BbkZ9j4f5YfqRckWydtN+De0O0d8aUQ7V0N9ajANDpViYJ9Nx/pP1Kv5lIjn2h+Y
 pvrnFYBtQpKYOMB2JHSdAshiDBt8OQ2V4nJfFbyCs4t2v+zOntyEGcyO35EexfzjqHul
 2F/pSdhkCtqs+LDKyqoHXa9LInjDLnp1vTnVaueX2V43LeYg9kXExHXaa0Ri+tZodcbz
 rUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P8Qlq0IP76FBJPtbKTV0K0to60+5xjfpAElrt5bnfUU=;
 b=26WUjSWLO2xweLkpwQNSm6YBX7o0lipf/5vCn325DDRBuuBo4+gdAkJeJDd+XbAHjI
 Yl6/oPVrugVITAmd6MB0PxEM08payIj3626UXbaW8b2Xo7PsFgv8p837aAJfXvlh9R5u
 2iSZhKa8KHsFJhHO+HxCKu+n9PwfMltx5h2aYoTOQK9WWaoXI8/R63V6LN8hW+Xv5TzH
 n2IJldDhgBf0jZJ8jFmj/PM0Ym6TjVwYNjEgCrlgnOmIoSluQEBzb8xfDMjpOhBnNncf
 jhx5e2TxtSBI0YnWaoHA21yYSP7QYPmtayyQpDhTggYUMMfmcztyeJG2atVb+G+nmBMF
 LZzQ==
X-Gm-Message-State: AOAM532CbShAaSwJuYkrVxJ7fktM+80FOwVFWA3H17JLg+4VaGCi4onM
 B/ipupKKA7uNscf4ZSOaOMt+jQ==
X-Google-Smtp-Source: ABdhPJw9v+Yf5V5dzAP3iWDNSr8+U2o4BdRnJwxT6jym1Wu7eblVVX7mcv6YcSbbQGUcTiBvkXvX/g==
X-Received: by 2002:a05:6e02:1a08:: with SMTP id
 s8mr12128889ild.158.1638808381464; 
 Mon, 06 Dec 2021 08:33:01 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id x7sm6753239ilq.86.2021.12.06.08.33.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Dec 2021 08:33:01 -0800 (PST)
Subject: Re: [PATCH 2/4] nvme: split command copy into a helper
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20211203214544.343460-1-axboe@kernel.dk>
 <20211203214544.343460-3-axboe@kernel.dk> <Ya29+OXo3SBh7UNo@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <89485d2c-a0e2-c7fb-90fc-ecc500e49127@kernel.dk>
Date: Mon, 6 Dec 2021 09:33:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Ya29+OXo3SBh7UNo@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211206_083302_147621_9E7016CF 
X-CRM114-Status: GOOD (  11.81  )
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

On 12/6/21 12:38 AM, Christoph Hellwig wrote:
> As mentioned last time I really don't like the proliferation of
> tiny helpers with just two callers.  See my patch I responded with
> for my alternative.

I tend to agree with you, but for this particular case I really don't
think it's better to not have the helper. I did try that version too,
but you end up with several sites duplicating it. So while I agree in
general, I don't think this one applies.

-- 
Jens Axboe


