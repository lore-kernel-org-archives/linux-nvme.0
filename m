Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839D0D3900B
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jan 2026 19:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0teKoFJhNTQo64s382zvN9Vkvtlc93XKoD9YKexQVJw=; b=MRwZNXILhhWp0rDePhHkMN2IMp
	+4B7bswDwCMX4AJEDAosQW6e46ovEJWKZ6QZT7SZeMPPtDY1wbRyMHXs8QJKkWp5O7sXMAcIaDGgK
	eKNnz1FsMarQvDd4LcoA1JhVPaf9UJrv4guyWLrxG9jshTMKcMgi5trJjvT8Dvkp+QDFEiv4twaZd
	BvzQ7e+sz12x1Vzsp0+3nd6xboUUBfWL/swpnQyOyjoKh29DYmZJjqEAmlzrIq0a4sZ1n44KYwuvY
	JT6pQWGJ+FfSNGzOOjy/49gE+796C9OrIZ4pVDSBdACau4xgRvdLTUMX6iK6sSS3QtjFGIJYFJE0V
	tviNQJyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg6fA-0000000AVKA-39bj;
	Wed, 14 Jan 2026 19:36:16 +0000
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg6f8-0000000AVJj-0UT0
	for linux-nvme@lists.infradead.org;
	Wed, 14 Jan 2026 19:36:15 +0000
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-4558f9682efso88584b6e.3
        for <linux-nvme@lists.infradead.org>; Wed, 14 Jan 2026 11:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768419371; x=1769024171; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0teKoFJhNTQo64s382zvN9Vkvtlc93XKoD9YKexQVJw=;
        b=1+rs8bOF8Y3Vt7kbG1QdboV+EOypbi+IcbNyNXPTid08ayOyjq38UBBvMMIG4RZ2Uq
         KXGYxEOjLaV3mkmEAZl0euEqenyur9VNYhpIIEdH3NE56PFtigW3OZItE9bGLCT1iaF3
         yuq4r4se7U4CYEqF66Zq3a4oTTJR8KqT163H5dpwUAItIaZpHxjX5ulswOLKSG8YUsn+
         iS5BLNJiwQsMohQeKrbk/xHJBKjCVMrbMGxK8VdjKIOIHPyvvNisnY6CpO2SBangrSf/
         9LyRNQtOdN1HVjTPmsGoIk//T2szfkBBOEJn3hnOJXlbyA+R0Vt3FEFtpO9yctXrITFy
         N3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768419371; x=1769024171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0teKoFJhNTQo64s382zvN9Vkvtlc93XKoD9YKexQVJw=;
        b=uofK0nYMQ7aCtqk0GksvAWAHu0+sQYC55gSPKQuzsBZToRDpUsgVvkJkSEq/TRZjZf
         J6S8qVlem4E5sBHwXwWpO2GwY8/iRReQxqXgAXrPKyHbJuZZ0PKMJRaNTforkiFGTvsB
         6H6w79tZ4asV1qMjpyuzfwjZlr6OaxfqusFLg9u2I8jbnfYtaiJnu2iqF0Pw22yBDtWu
         43dkvNB58vpzYxJiBU4vdUoxijmhNVGdynJ+ZfAnE62QP8t5LKUMflugIhRba3w+damA
         BkTr7BKmO+sAjfoaR8GhgJPoMySp5BWxskms+Sw4SY7WwmAnTwiKrI5Ago7xt7AY0fn+
         B5lQ==
X-Gm-Message-State: AOJu0YwQsVvSjN0F5dnRm4ocAZQCOSyz7se6/34OZEqN6ILQ/wW5UrRi
	h041xsWnikWtfBp/jJvHWz95rFTRKN8nBwF6ZlJgl9NIoxnhCJKal4yW3zU9VF5N/YA=
X-Gm-Gg: AY/fxX5y8/mw4oP/YRDt6lrRkmX1CJx7drquvswFABa8wR72WZJ98+3E5L8qiNYGV9q
	tksjFSnv532Ak7IrKk3iVDf6IhJAr15eOxf8kRtURz4A/iFSqg2gBSu+cLqQqnlFxK7CO3Q0i+R
	hq+tDN4xyhRnsTB6eHto66+4uM6Ii9bRmAdzNhFSbdM7IKJJn/LrWQrbfbmcKgxY8tUBjuemn0a
	he/AQkOrW5DxNTCVwucq5NofA/f9vfpqnT1vw5tGbrgDqOORKrlsh0zulk0XBMibdvV4ei3/+yk
	D5k3zomI39pQunGO0OPIdMjkcbRQmUV/eskdoRyRRE0ArYID447gzSrnNLRsdcV9m/eFr0uin68
	J1zpK8j5yabsQrCmLxmQu+0rwi/ArRKB/LihwWjfYulQFbe0DHI4pNh6YJDZYxPfUkO4xb35q+s
	bOrc/rABc=
X-Received: by 2002:a05:6808:318d:b0:450:c877:fd98 with SMTP id 5614622812f47-45c714936f6mr2557042b6e.21.1768419371526;
        Wed, 14 Jan 2026 11:36:11 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5dfb6256sm11842467b6e.0.2026.01.14.11.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 11:36:11 -0800 (PST)
Message-ID: <602e772f-b3e9-4bba-8cea-8ab94bb64b65@kernel.dk>
Date: Wed, 14 Jan 2026 12:36:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.19
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
 sagi@grimberg.me
References: <aWfiu2Twr5_lT9zq@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aWfiu2Twr5_lT9zq@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260114_113614_406603_D8C196A5 
X-CRM114-Status: UNSURE (   9.90  )
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

On 1/14/26 11:38 AM, Keith Busch wrote:
> The following changes since commit 9869d3a6fed381f3b98404e26e1afc75d680cbf9:
> 
>   block: fix race between wbt_enable_default and IO submission (2025-12-12 12:51:11 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.19-2026-01-14
> 
> for you to fetch changes up to 0edb475ac0a7d153318a24d4dca175a270a5cc4f:
> 
>   nvme: fix PCIe subsystem reset controller state transition (2026-01-14 07:21:31 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.19
> 
>  - Device quirk to disable faulty temperature (Ilikara)
>  - TCP target null pointer fix from bad host protocol usage (Shivam)
>  - Add compatible apple controller (Janne)
>  - FC tagset leak fix (Chaitanya)
>  - TCP socket deadlock fix (Hannes)
>  - Target name buffer overrun fix (Shin'ichiro)

Pulled, thanks.

-- 
Jens Axboe


