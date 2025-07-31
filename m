Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70B1C87FCA
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Jul 2025 14:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kf6j1R5D/tbgbGEyMH2jXV6V2+9rCIaZQZaqfQWq+aU=; b=smxTGqL4yDP8JPykKR4Hzu91Wb
	hrDZZaGIqVidvBjKxYYh3b/zthGq7eC2X2VmSqunpA68ulgBqFbYnbWJX54+h73xmjAVgCX0VArRp
	i+hCr5fSNqR/oDwPXSii5axjKHBd0BfOosYbn4BRdBp2LjhGjg9O5LmVlUNySiJwyAVm3tELEwgi5
	I07cmJG2NR675ah6djjeay5mziOAgCW22UkgEHnbU+7S8A9nHzrDVWcxc1Hew5XIsCVjsUTMM+5F7
	74/AnP1AIduVaemwyPAJdrNvTJC0BhoZAynBR+P9vWi/pnzIeVowNlobbIJz8ssD5zv2bKIjJlUtl
	viL4rFYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhU12-00000003nAq-1lVI;
	Thu, 31 Jul 2025 14:12:16 +0000
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhTLb-00000003hDV-35qE
	for linux-nvme@lists.infradead.org;
	Thu, 31 Jul 2025 13:29:29 +0000
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3e3f6ae4d08so3679605ab.1
        for <linux-nvme@lists.infradead.org>; Thu, 31 Jul 2025 06:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753968567; x=1754573367; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kf6j1R5D/tbgbGEyMH2jXV6V2+9rCIaZQZaqfQWq+aU=;
        b=IO2u1NLxhblqpnOkekWuti2fCW5vGgjj3jWor+3zH0WfhjH21i6P7mvtmJXAqAe607
         jXZvz+qO+2IXV1IBmxQDDWOcOVWziAwsKDiLxA53qj70IhZWL5ImSdLE4Ukm7GjJx96R
         yV39fsoB/U50Nd9v2f3QE9cCGUbqo4TKC0WNNNVr6MOf1iIpZXFng00qWOGK18ycw6M1
         /KTpJuCMcvFu6D4mU+j8Gd/CREMC7cGdLP2HFlSMcnK0BOglru5fnEWQqcwobawGCY8D
         TPQCLhwX7NRbWQvjvOPRmHX9XWVA9TbAGyYJ3icotobaAVeq1coSmlesxI9huKqhTbc8
         6ZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753968567; x=1754573367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kf6j1R5D/tbgbGEyMH2jXV6V2+9rCIaZQZaqfQWq+aU=;
        b=Nf0Q31LlSaIHkuNDJaXelfx4zKPQfcFa8cqqoFtKC/0AMFDBSVCkLftB9ktZ7wymA5
         WYX78YSo54pTM/gUfbUFkSTIchnPbNrEAE73HTf3vZMezRO6hTkKdtNQrJbehARIPNRn
         oYhKYSiUbvCHvSGiJr+6TGvJecxNLhObSly1jgF4KxvtTjlKPPGYrBHavVe+gYcpz2U5
         l72CPVQ2LjzWynYU+lIfaBBLzcwVIE/VPICpRwmM/HMdMrW+TMKfWgv1D1nOX3Z/qtFK
         +8iMwsyxUaY2lrcEmx2ApxMaq3mF+DA6VY09ugAcMJ1VYFl5W73FvFdUviNMkqmtE/wp
         viSA==
X-Forwarded-Encrypted: i=1; AJvYcCVc175biCbatkwxeKXsv++kxqKS3QmRgehwjBapiMfugDPiXRA5FLWkWncFBhhSvYN9TMva7nLtzJoZ@lists.infradead.org
X-Gm-Message-State: AOJu0YyK2u/UjjjHto4gL1kQTc74j9vD1G7YWryZxNDBQfRl6QNF3kSb
	T/mxgUoJrLiVKr5T30jju4Gc1geDH3XSsqn7oR1bZCE3QvyuB3IUi8qbI1ihjpHQDvo=
X-Gm-Gg: ASbGncuff0gflpyssTGijHmElu4Qnt0vB/mOdk3fTBRlAUvgtaVGBzIh1Yq0xl5GLl2
	QDoU+9w0oudg/maC8ipCjVLjV5IDiFOdxE34wnNDhOqFB8WkpMhsGd1ysB55598qqLE4v/WB5hI
	PA0mEcwEW2M23tpBNP5s1j6/M/zjT7Us8GiTpdvD/K4PXy3p5nPODD0tmpOQ7qenUnZMkHxY2FN
	zkd5QJXg4AHD8dwy8E3XBeQsAtKOO/5xYF7S+QiJEtcMndnW8Ae6c2hVndQ0RVtjZBVZ3QZgz/c
	KueMroDenWCE34xl2Lyd/ZlvbD7fNEuoySmG/vN3AikDUikmMy57iHW/w2raEGVzIWSgPHUaZDf
	bpFz/rEbjT/qelL8g8wQ=
X-Google-Smtp-Source: AGHT+IEerQhtiILzuNpwnLDq8PgdsqS0ljYeqYQb8rsPPKxK0XUHuixbp9UkIkFkN048y/HBRX82Zw==
X-Received: by 2002:a92:d784:0:b0:3dd:a0fc:1990 with SMTP id e9e14a558f8ab-3e40580a081mr29145025ab.3.1753968566714;
        Thu, 31 Jul 2025 06:29:26 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55b1ac2esm504759173.1.2025.07.31.06.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 06:29:26 -0700 (PDT)
Message-ID: <d7ddaf65-00a0-4b90-b596-5db1a5169950@kernel.dk>
Date: Thu, 31 Jul 2025 07:29:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v30 03/20] iov_iter: skip copy if src == dst for direct
 data placement
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com,
 gus@collabora.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org
References: <20250715132750.9619-1-aaptel@nvidia.com>
 <20250715132750.9619-4-aaptel@nvidia.com>
 <59fd61cc-4755-4619-bdb2-6b2091abf002@kernel.dk> <253zfcs2qaw.fsf@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <253zfcs2qaw.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250731_062927_848311_D056D3D3 
X-CRM114-Status: GOOD (  23.33  )
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

On 7/25/25 10:22 AM, Aurelien Aptel wrote:
> Jens Axboe <axboe@kernel.dk> writes:
>> This seems like entirely the wrong place to apply this logic...
> 
> I understand it might look strange on first sight to have the check
> implemented in this low level iterator copy function.
> 
> But it is actually where it makes the most sense.

Please stop rationalizing what is a blatant layering violation.

> Let's assume we move it to the caller, nvme-tcp. We now need read our
> packets from the socket but somehow when we reach the offloaded payload,
> skip ahead. There is no function for that in the socket API. We can walk
> the SKB fragments but a single SKB can contain a combination of
> offloaded and non-offloaded chunks. You now need to re-implement
> skb_copy_datagram() to know what to copy to and where at the socket
> layer. Even if you reuse the callback API you have to take care of the
> destination bvec iterator. You end up duplicating that iterator
> map/step/advance logic.
> 
> Our design is transparent to applications. The application does not need
> to handle the skipping logic, and the skipping is done in a generic way
> in the underlying copy function. It also will work for other protocol
> with no extra code. All the work will happen in the driver, which needs
> to construct SKBs using the application buffers.  Making drivers
> communicate information to the upper layer is already a common
> practice. The SKBs are already assembled by drivers today according to
> how the data is received from the network.
> 
> We have covered some of the design decisions in previous discussion,
> more recently on v25. I suggest you can take a look [1].
> 
> Regarding performances, we were not able to see any measurable
> differences between fio runs with the CONFIG disabled and enabled.

I'm not at all worried about performance, I'm worried about littering
completely generic helper code with random driver checks. And you
clearly WERE worried about performance, since otherwise why would you
even add a IS_ENABLED(CONFIG_ULP_DDP) in the first place if not?

-- 
Jens Axboe

