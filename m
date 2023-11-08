Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4060FC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Nov 2023 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x6N7aXY0visQOIXZ8UGjSzyhz665XWKI2a8tunkGXSQ=; b=q6GGykUtahmpjv8umK5u69dfRk
	FFEda0IcxyYJ2Raykvfi01yRTyxtjJoc4SUZIAND+JYbmXgW59lo46MlWu9i9vge+vRIMuIYKJiie
	H7rY03LeilOWFCgP3nXMmzlDjA+2jtnpl0qtKRwBEWhvZCRAFBQc49qViKV+LhFW0W/s1a6crPJPl
	mxykG1asUMzqyuF83LyRjlYdEiIyltgc2ZfXSDbddOh0LR6kreJHx+v/U3swceBRRu++nh79e4nud
	/O790uB3UKBBEVj71f531q6C6RwT4tzva/xnVfaRBGtdhj2WYX3iapJREaTp2WjR2GOl7GGWMVgJ9
	yrlL2MPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0lI2-004HjG-2i;
	Wed, 08 Nov 2023 16:20:26 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0lHz-004HhU-35
	for linux-nvme@lists.infradead.org;
	Wed, 08 Nov 2023 16:20:25 +0000
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3593d2018bfso5541895ab.0
        for <linux-nvme@lists.infradead.org>; Wed, 08 Nov 2023 08:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1699460421; x=1700065221; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6N7aXY0visQOIXZ8UGjSzyhz665XWKI2a8tunkGXSQ=;
        b=YQ0IkUgN4haPCyHKuU1WVNX7nsS5fIiunogfB4fIXxeBj6+p7kDYmIWKRWGXgE6qQ4
         t6e6s55Zh0Km1rLLSsj8dwy2MrPQ5+r44cIeQcW4fOqiuKsu5dwpiixBjqTZR9zk3UZ+
         ILr96P29aq0fTpAStQG9dZZxAv4YTdYMKiu2j8AdBGpYvJS0hUyEPq0rNKbwyoY/rN28
         chDnIzff2vQZ/HweE/n3x8yqzRFrwc4MY3vqa/66iTyd5vde8j5jlST7UabYBV1xdb/c
         spf0l+A0keCnNy6O+UJjpLG7GQ8vX+TJ9n1J9d4WQewTbHBCuJXKWjmKPU4dS5foffu9
         klTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699460421; x=1700065221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6N7aXY0visQOIXZ8UGjSzyhz665XWKI2a8tunkGXSQ=;
        b=fvi0ea9c2DOiprOahw2qFmriA5uk+r03txPp3zHvCqCGG2s19IGalEfo4B/Z/WyvDx
         smNJKNrCsz80TQ7es7klnr9oOfPQ69SnP9RT8+yD/BjadNAvllrVxAXPNMjFFGd7fM2v
         8X12wX9hcD/f7jahHTVUmKoL6T9/1u+Uy7xa81IcAm3rXtTOhIDOTFQhPh8ONfu0TgAv
         gDqLE2RLP7hHFm7mbudQCg8jVeQ7giXCCdDOMjJzk6MLkHFbXzhCkKOvKsbk8f1PJPVY
         FXMloGURohi5/9W2m6ZXPa9C6waSoL59gZSWrM1/lslX0Z7rgGkmLimgjJszcVnB6Jku
         fMAA==
X-Gm-Message-State: AOJu0YwXfMNol6ZdYmRtSe7QtFpGIhx3DanIBKQbul/+CqRFFUzk3mbT
	DnUdxzMsIQtmHCuGrVXUWzskzQ==
X-Google-Smtp-Source: AGHT+IHJeFZ84gLYA2Wg/3BogHMaq6vD7IQ/sKZjHFt1G9RyEBd8BlnA18tGItEDeg5n7ntmcNJomA==
X-Received: by 2002:a92:2e0b:0:b0:359:9c0:de81 with SMTP id v11-20020a922e0b000000b0035909c0de81mr2482115ile.2.1699460421664;
        Wed, 08 Nov 2023 08:20:21 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d1-20020a056e020be100b0035267e68782sm3768594ilu.22.2023.11.08.08.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 08:20:21 -0800 (PST)
Message-ID: <b7624859-fe70-4f59-8aa3-8bd00307dd04@kernel.dk>
Date: Wed, 8 Nov 2023 09:20:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for 6.7
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <ZUu0J09yJmK72bKa@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZUu0J09yJmK72bKa@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231108_082023_990660_576FCB93 
X-CRM114-Status: UNSURE (   9.50  )
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

On 11/8/23 9:15 AM, Keith Busch wrote:
> The following changes since commit d2f51b3516dade79269ff45eae2a7668ae711b25:
> 
>   Merge tag 'rtc-6.7' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux (2023-11-05 18:49:40 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.7-2023-11-8
> 
> for you to fetch changes up to 706add13676da7ad213b65e92b94af5efc8c4131:
> 
>   nvme: keyring: fix conditional compilation (2023-11-08 08:07:08 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for 6.7
> 
>  - nvme keyring config compile fixes (Hannes and Arnd)
>  - fabrics keep alive fixes (Hannes)
>  - tcp authentication fixes (Mark)
>  - io_uring_cmd error handling fix (Anuj)
>  - stale firmware attribute fix (Daniel)
>  - tcp memory leak (Christophe)
>  - cytpo library usage simplification (Eric)

Pulled, thanks.

-- 
Jens Axboe


