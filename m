Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34D7606E821
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 20:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PsTdkTCr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hTa2IV2p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=3BSS+uJc04js/YlB2qVs7at04D+tMWzUSOIfTvRJOps=; b=PsTdkTCraGiAZJ
	pZyFPCXgxrB3YfYjJa1NY438YB+GnnbG69GIWTMTuQYZGcCeDP2smGzbRipPIff6zo4GPjq2wVsOL
	BvXtJMH82lhUnMXuR2MdnkKKL2c07Io/9Z/yBZt1k4aijby9igAWgwK0RTNIAwR76L9TxxrZD3qFl
	SA9HR9j6TP1JxmvjeOvV2QMISVaOBWLEGdFsOo322zErxP+s0kvxLJAEbt7Jvxy4S2lKOxCzaKVQK
	Hc39ZS5TUcHHzX2+yseNoHwfsEFzpJOvi8c/b3LSx2uKOtnxWZCQ6UP/gLbKk5HVJXac/XofYu8Q9
	F5Wm2WxwqJonXbhAaZRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOhB1-00000006qaF-31RA;
	Wed, 04 Nov 2026 20:01:43 +0000
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOhAy-00000006qZD-1owu
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 20:01:42 +0000
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-51f2e9e6987so1554002b6e.1
        for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 12:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793822499; x=1794427299; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3BSS+uJc04js/YlB2qVs7at04D+tMWzUSOIfTvRJOps=;
        b=hTa2IV2p3OchklmzQQ19QJEW2KYkX9njVGpm9GLcQHIQ0LwM1HOXPrwpTYF1mlDnCh
         vWwDRTx+zjZK6b9LQ2EL56CLTQwg50l4VOnJa99JKTlAu2HU7v9pQjtqS5t+uK25+LXr
         tLcxpKpcrk3uHeXfDN8ySh9/sMyffkeOoS8z55RnFyYnAte2aHbyjqMv+DkMIxnIctaV
         Q5NgMpT90N44gE3GOCA9TOLb1j/brubXLbXDp2LRHFBeIrWIf7fLEi444iBfUcXhBICZ
         WxXNLiZm3hYDp+yEncmYFjGdcpxknf7GWzIOflvBeCHqLo9RO5bAZsoDMB+NCDiuvpHz
         NYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822499; x=1794427299;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3BSS+uJc04js/YlB2qVs7at04D+tMWzUSOIfTvRJOps=;
        b=t/KvCjojXabwPYNjnO969itqYvV3+AYYwHARmzEw/CMRko+0yJfCAMhiK9pZES+/NF
         kKjwDLV6Nv5HafRA3B/y5NvL11BrJCwMNBydr0Msbh8heHg5y/oo4xdDQSzl/hqq+G6Z
         4XVB18FNSXgz+jDU6qEx0xJNs/pXGZbrjV71iFwg3PRzNfqeOqw1kjAg/PK0hUs/sY/m
         B1e4IhhDCTlMrN0Zus+NO0MUcDS80IpQ8N+tbb8YRDSm83Z9Af0XK1+7PS+i3cf7xxk2
         8AnjCYwfLuUK3cMtvi4MgOPeFubF6v7VNkUqvnJLpSHVVmEctM7OlLBKtciWWUpVYSXI
         9oLw==
X-Forwarded-Encrypted: i=1; AKwUvBy7CBow/J1n0AdlSjM8u2OvPu75rTnx3xo70izLWyGXdA47ri4okIpTdSIMkxsK0Q6cCx3ODNNiMW0B@lists.infradead.org
X-Gm-Message-State: APuU4Z8eueiLDwMALycAepeEJ3NzyvtAwTiDp0Mv93wbOI2BgroWB8ya
	YKBzsqFaors91ox4PegpVSa/EjcYR+q9OfqFW6UD9nVBTPvqBP7ZteSH0NpUMNZM51doG7aozb3
	XXaMfp80=
X-Gm-Gg: AYBFou3+DmCBaOeCVAbn5ajSDHoErxF2MvokUCKOBrmqEL47oXaspc5aI2We1GGUPHA
	L4zSalorNu5WAAsD0B3FDsxUO2ZNFohbLkUX5LZxX7V2m0phXT1G8STOBxIOMv1gE1imlZPwRkr
	5xLlKUFHQPWauDgr+w5p1tHWm1tRV2EjeEw0hXrurgw350IGYs4qBw240I9U5wbSdx4NvnbE1/j
	P26b7Bwgn5LNAobt4esv5dwe7RgnZbaYmdJXo18Qs+H7hK8jRnaM+NDrtVFJesEtRWm1HtVZVRY
	bA4U0wJkeycOx/CDT+LlXZTqYvPUvOlbIgssEXLWyeoLvd6quYDteQFiU70Ch043r68DZEISepG
	LIBt36ZWzhIvwL1LqA9m1Z99Mnz0Vn8VxG27ROdAD1qv88c+Y9qblLMDfYh7D+tCr03rh1PhTNu
	wHswPpHhskNC6gIAB9gitTn8X/wKwvfngQT0gcxUgU2F7nmI2dOaVWyJXfmAmK2TV9SwlX8QUTH
	xCCYmgchjHCj0cbhlFln+xb0gdvnxBH/9scg9H3SwFc8mmnLajYEPcsrJX/39J2CCX2Cqwx8dSV
	3/exG1XPo21NzZULslNdir7hG3JZHy8czD0rKTpwW2LQNoOQ59VpxeyMC4bnRrmLrPTsLbHozqp
	zs37fA0/c2g==
X-Received: by 2002:a05:6808:bc1:b0:4e7:f052:460c with SMTP id 5614622812f47-567be3b68d5mr333629b6e.23.1793822499034;
        Wed, 04 Nov 2026 12:01:39 -0800 (PST)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9f400fasm2430983b6e.8.2026.11.04.12.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 12:01:38 -0800 (PST)
Message-ID: <641c7c0d-0455-490a-8811-e6eda728a7e7@kernel.dk>
Date: Wed, 4 Nov 2026 13:01:36 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: reject completions for requests that are not in
 flight
To: Mauricio Faria de Oliveira <mfo@igalia.com>,
 Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Shi <coshi036@gmail.com>, kernel-dev@igalia.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261103-nvme-double-cmpl-uaf-blk-mq-v1-1-b10fea474423@igalia.com>
 <auo5a1kRTSWsAYtF@kbusch-mbp> <352cfcec6865cbf636a22442511f16b1@igalia.com>
 <auo-v5ZliGbM1Tiz@kbusch-mbp> <65414ea51d23fdbeb5d8b7bb4bd9d535@igalia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <65414ea51d23fdbeb5d8b7bb4bd9d535@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_120140_745750_F672B444 
X-CRM114-Status: GOOD (  10.83  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> I agree that a device in this state can't be used successfully, but the
> kernel should, IMHO. 
> Say, in case the device hits this due to firmware which needs an update,
> the kernel crash might prevent the user from applying it, in the first
> place.

OK, now we're really reaching... If the device is so buggy that it can't
even do basic operations without violating protocol and crashing the
kernel, then there's nothing the kernel can (or should) do to try and
prevent that. We don't cater to severely broken firmware or devices.

Please stop all of this nonsense.

-- 
Jens Axboe

