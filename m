Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9ECD2C55E
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 14:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LWhTM2x1Fg2Tzdw9/M1/x4CKPvpZHwNE1byy+bxbrsw=; b=zsErIqK+P6Jk89az60LXouwdN6
	Zb2DP52YLkZBtXeA+5/x7xlqVIWvBxVFZvNfe011O8OeJhczXXG0TZ/ghfxgUm16imwa6rzUKwEMT
	UBLIPEqbGI+k5NIIk+/A/HLDNsr5fFkSiWJtQt9yzbU9yVfFeSW4or4YFTTZTP+19vXVFqgOlSw9L
	u21QgUaqRv9nLme/2Njuir+GyE1xAlv+0TK4ngxNGfLTmV03dQpIIrOPMSRYTyylnuibJOwnFaPR1
	p50CYxwfBuLQxgsUKxwC8I6UDmtu1vQIKQEDUyZUS6gCH+V2dugeDcMhJqAtMU3yk/KKGwnZPk3Ds
	JB4Lz9HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Fij-0000000B4ph-3XXm;
	Tue, 22 Oct 2024 14:18:49 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Fe2-0000000B45Z-0IBh
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 14:13:59 +0000
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-83aba237c03so182571339f.3
        for <linux-nvme@lists.infradead.org>; Tue, 22 Oct 2024 07:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729606436; x=1730211236; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWhTM2x1Fg2Tzdw9/M1/x4CKPvpZHwNE1byy+bxbrsw=;
        b=TjxsJNfgmOnNA427pRw6jaC3Yzi0RniFO3Db6YBE8PTLOqa3z6z8FVxBGDGkH1XdAJ
         orQ1LXwdTxzFiiBSjVvFUB6W0zqN1fvK4/4kDHwnHlZzLWe5fUipikh04sUoon9G7GFT
         YelRX/k8jYTn1orh+ZLj9GSIGu8pJnz47DtdXqM06f1ofCxIbme4xFJNBKJpL5NjRg4X
         naU38KYZANA1Lng4+POFVDO6rViXESWPx9ZpNtO0C6StRpjw9DskfeKXf/G4Ae9KixZy
         AxIuNNijbU7QtEB3cfZgP2YlwZJKASVuVTNJeS74MkQQNIL1Fnk118HjI2PTHLHMkXyZ
         NEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729606436; x=1730211236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWhTM2x1Fg2Tzdw9/M1/x4CKPvpZHwNE1byy+bxbrsw=;
        b=YMdAmveu0OkNUr+SvHEienZ3Gz5zRC8gSAaNZBfGU31uF4GWpWo6kCDkR/h+McOm+7
         dbZ8flJ6b1JBVcqU0bYZGEugUSb00v1IMGV+0mrhO+ZQDv5oZemG5C2B6BH5d+NzT5Su
         bJ2Lv8av4YKh9RgCJSEkWfGFp5WiCalJHAcR1W8JtdhZHjmFgAjP0nFaXgnz7TdWIxXY
         IpApwV1d0PWIYBdsHcPSJD8Mjd5msz1PyXkm4RLFLQOD0uqFO5vGjnNyhshS/hCjEBL8
         yThxrFZW554eu7BHK2h0TifNbkQL7+04KZAjw1hXChgwIgG+x5ByQMX5LNGNqnIdsSC0
         WSqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDTUkVGuqTyl9aD/EtbI5vUKI6+weW+NshHnTW33PpZhRL3P+knwe14y7Y+mMB2PFav8VuYUFL8y78@lists.infradead.org
X-Gm-Message-State: AOJu0YxBxkaoqmeJz04TIdMIH7jbIp0jz61mjn82qdugDUjBZDc1nr8T
	OJ4ajgyQpnhVeUJNQYEePN4Ml6sZVsXVQKO3b5ki01/8LkWHNzpNnYBzrPuuG+Y=
X-Google-Smtp-Source: AGHT+IGA8I9ofaKfC85bHdfQpONjbuzAxrIQ5JBekH/J4Lkpz5i0HVqpcljkMWOxGIgw2HjI8p92kw==
X-Received: by 2002:a05:6602:6b0c:b0:83a:ab63:20b with SMTP id ca18e2360f4ac-83aea8faca3mr278958139f.4.1729606436030;
        Tue, 22 Oct 2024 07:13:56 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a6091bfsm1578248173.97.2024.10.22.07.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 07:13:55 -0700 (PDT)
Message-ID: <7e573e58-39b3-45c3-afde-0cfec3911326@kernel.dk>
Date: Tue, 22 Oct 2024 08:13:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 2/2] nvmet: support reservation feature
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Guixin Liu <kanie@linux.alibaba.com>, sagi@grimberg.me, kch@nvidia.com,
 shinichiro.kawasaki@wdc.com, d.bogdanov@yadro.com,
 linux-nvme@lists.infradead.org
References: <20241021110331.125962-1-kanie@linux.alibaba.com>
 <20241021110331.125962-3-kanie@linux.alibaba.com>
 <ZxbWxuzH3u6hAezr@kbusch-mbp>
 <b4bde72c-7123-4594-a064-a39aef7fa7ec@linux.alibaba.com>
 <ZxcIxhQMYt2fsPiY@kbusch-mbp> <20241022060639.GA10510@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241022060639.GA10510@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_071358_153303_45213C5A 
X-CRM114-Status: GOOD (  17.02  )
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

On 10/22/24 12:06 AM, Christoph Hellwig wrote:
> On Mon, Oct 21, 2024 at 08:07:02PM -0600, Keith Busch wrote:
>> I see, thank you for the clarification. I hadn't been paying close
>> enough attention at that discussion.
>>
>> So, minor problem here. This new feature is 6.13 material, but our
>> upstream block branch has forked before that commit. IMO, I feel
>> introducing that header movement after the merge window is poorly
>> timed...
>>
>> Anyway, I don't think I can get away with something this large in 6.12,
>> so it's going to have to be in our second 6.13 nvme pull request after
>> the next rebase. I've set myself a reminder to merge this when that
>> happens.
> 
> This absolutely is not 6.12 material obviously.  But having the
> block tree branched of before -rc2 seems a bit unusual and potentially
> problematic anyway.  Jens, can you rebase or full a recent rc in?

I can rebase it, no pull in there yet.

-- 
Jens Axboe


