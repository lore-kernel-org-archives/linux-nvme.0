Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B6CD206A9
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PXVjDv2oTpvWk9JEN5P/mooYr1Wl4BQmv5s69QzcXNU=; b=BfHazi2WdDNzl35FujWQcHkz8L
	e08Kteh5VaQElpqfydFuOIYBvyLS6zH3UK6nFnyMmQRAdDF7S4POfbTg0CLv+2X3XyMkncWhke6YZ
	yMrL9BrImWrWSqatGAQUH49yIkjcTpDyaVC8Nfj9PbLtN5wPJziAzOFcZgLks25BQSAYlXyRCde3R
	OUQhXl2LNBQTAocxbbEwf5b54Xm8P2ih6UrzkjkkIjqfHHskhN3zynFnKL8FXC6ep3mRsRxcj74jo
	C//4hwUFzvmxlVwm584hoC2NWZZM7QNZBrWZvnZlFJn3WGzXlgZxewdBP4fZ+ff9bG1cv6AcYotM7
	yFDW6a/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRADh-0000000874l-2JlD;
	Thu, 04 Dec 2025 14:22:09 +0000
Received: from mail-oa1-x43.google.com ([2001:4860:4864:20::43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRADe-00000008741-1l8R
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 14:22:08 +0000
Received: by mail-oa1-x43.google.com with SMTP id 586e51a60fabf-3e8f418e051so734683fac.3
        for <linux-nvme@lists.infradead.org>; Thu, 04 Dec 2025 06:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764858125; x=1765462925; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PXVjDv2oTpvWk9JEN5P/mooYr1Wl4BQmv5s69QzcXNU=;
        b=r74LsVqm2rmAexWVPNaaamDzwFgqPdK/wgtrKST5FTYNIsjIjE9ACEjjYm81pL9IeT
         heKctDf8KlzgPknl77dXEWuAFt/gyQHLFu7SToArqzs9BpAzaf8ZD0/aax0dwntA79Ol
         eyDmROSnBKcDJpntv5tor4IeA1umD5isyQkcLv+dJOVPjSD8lhZfBcy13kXaL3yuj7aT
         3qFRzyM3oHZzrGOAvMjiI7j4N8+IR1M5adHqtJjUYxiLv5G9Ugse0SgSb5bp+whptwGJ
         xnkBfb3oQf3jcQ24VsbX/DKTJdmC8LhONvepcU0ODCFX8Bd+Z0v2LKZeusgY2MCPd16w
         75dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764858125; x=1765462925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXVjDv2oTpvWk9JEN5P/mooYr1Wl4BQmv5s69QzcXNU=;
        b=tU1yoIoyBMKRqDhZihiUgQh61aS8VsnjAc52MyprR3gZAxGeOhXUe/S7MkP1CxRasg
         j9HYrKWA9koqDnpLwxoNRur/6kmNO5FC6jL3Tx2muBvI0zVzo030WwVe8pbJLYFJBayT
         MWGWS08yO54dcDlE8uebGBr2EO0SBWTPho9a271gLhk+TqkdX0AZQAOoLiGsMCQ+YqfM
         SuFi3XMQ49bFg8mHr3LzCgXYYISZkjw6JWiCRuZnDy/x6KFxSM/YJOOUzXAXZzJXIM2b
         /t6yG3T9rjeq7DIe0ecb+42zWfkVn2tImx9s8shaGWW70NWF7WNTwtlAUimVzgqXAbLD
         +bjA==
X-Forwarded-Encrypted: i=1; AJvYcCUCMfe1ntzAi9nAcf8TODLuzykkHzZQrezkVWqDp1BfrK4X/IfY3FxB9cTm2qoX6wJswzAC5S2HU8vc@lists.infradead.org
X-Gm-Message-State: AOJu0Yxqj+HEVf/pSBC2wsO6S4IMUScNZaua+g3Sgakf+YIYgOy0x6Dw
	BE8plVT4yDQWeG6YRkaWTvY3UgBPxEpPzGQqyXcDTNWRPv68OdZUWi7/gYUQY7dKwgA=
X-Gm-Gg: ASbGncs7HnY+3cAxq0oG2j5n3pc8bFZp9vgINuz00ZoQvPwOjuENZBw5TBXIaE2QXQs
	cmqtJA6VUUM5Dprt7PR0KosIXNKFt76FwvGFnkSnsRE6Swl7bXC3NmvYLmvjJXAf2v3JeGoKSyB
	H1/oxNsNwDUNP5FbT0soRQgb8e2L/VBfyF2q2icRsmkSjN1zj3pf6sBA9jQC5gZnsP4q6WWpuWl
	l86IXV3qSEDCD1qfCiim2aPFD68yBoHJqTptZEM4S1Uxcj4L01YLynzsntCZ9RKuNxqpK1pz6VJ
	NJXyX89VTufUXfPkdtN8c3VSnRMcjUWffZ3lSCr5aqBqIC/Y2rFG4/z6ESc/dhadtUp5pp9lUOh
	5lRyemHy9tkT2RlUQssRGHNsjx25U0Y1/etr75YiniAxTe1ynNqV05g9sG0V7XutpOF4lEYYpcs
	BAMwfrWEo=
X-Google-Smtp-Source: AGHT+IHaFfZ3+cHcCfO4oF2Ib4EN6e7NxZ61maB+d4wtZwSX45wEyqMGZ0TPKbpTNr+eIovSQf38EA==
X-Received: by 2002:a05:6870:cb8b:b0:3ea:e4ff:9843 with SMTP id 586e51a60fabf-3f16918a238mr3491649fac.5.1764858124958;
        Thu, 04 Dec 2025 06:22:04 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f50aa9675fsm1374643fac.6.2025.12.04.06.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 06:22:04 -0800 (PST)
Message-ID: <08fd7006-3dd7-4762-9bd3-cde2a7e7f3d9@kernel.dk>
Date: Thu, 4 Dec 2025 07:22:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.19
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <aTCNwTd9E186RsXE@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aTCNwTd9E186RsXE@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_062206_710090_DD504EDF 
X-CRM114-Status: GOOD (  12.08  )
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

On 12/3/25 12:21 PM, Keith Busch wrote:
> This is a bit later than usual as we dropped part of the original set to
> provide additional time to resolve some late comments.
> 
> The following changes since commit d211a2803551c8ffdf0b97d129388f7d9cc129b5:
> 
>   block/rnbd: correct all kernel-doc complaints (2025-12-01 07:19:50 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.19-2025-12-03
> 
> for you to fetch changes up to fd87c8a7982fdb555133a6d225b636984d12c7db:
> 
>   nvme-fabrics: add ENOKEY to no retry criteria for authentication failures (2025-12-01 13:45:58 -0800)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.19
> 
>  - Subsystem usage cleanups (Max)
>  - Endpoint device fixes (Shin'ichiro)
>  - Debug statements (Gerd)
>  - FC fabrics cleanups and fixes (Daniel)
>  - Consistent alloc API usages (Israel)
>  - Code comment updates (Chu)
>  - Authentication retry fix (Justin)

Pulled, thanks.

-- 
Jens Axboe


