Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FC0D29C33
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jan 2026 15:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wte8eMJNDbcrKLuDulK17hs1mTpYcPcujxWR+qNMyWA=; b=fyVr9wIyUyAiahuL7CN6NdzPKS
	n/9uBlI1es91jr8ucGU2EdTC+1Ju3aulqOYxp/CZyYlhenDWtDG6NXHfQGYViQClNyWWyT1c27/b2
	5qyzS4GNcJcsWUMiL5pgR8923yIwMhnxhzA4IiGmgVHbDMLYCsveYHc5+AGqqocCqRh50cJz+4dEw
	usQT0MhjjOAnEAG2IQ74jp+NVVbZR1cUZUD7feJMPw5pWZMMQvv0I33/YSEQjZdZABNwfPDkCOZt2
	mCPjkFW8dpBMwvVVnDMk8GKidXrB6LeEMOMJhhQndhqi2kyx8drjpL56wvnSx5QipjbInoGuPLH6u
	KtdzHdWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhr2T-00000002Krb-2sXF;
	Mon, 19 Jan 2026 15:19:33 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhr2L-00000002Kot-07x8
	for linux-nvme@lists.infradead.org;
	Mon, 19 Jan 2026 15:19:32 +0000
Received: by mail-oi1-x242.google.com with SMTP id 5614622812f47-45c7f550f46so2665155b6e.3
        for <linux-nvme@lists.infradead.org>; Mon, 19 Jan 2026 07:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768835954; x=1769440754; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wte8eMJNDbcrKLuDulK17hs1mTpYcPcujxWR+qNMyWA=;
        b=Pv7SCFa5C9HuW6hQatpcATad583BggExEY56HaTo1UvliYJId/vHBW6Tc9fs9CfFv0
         q16aIQcuz8CKVkD79Qbwq4TRTKY5/uIgWGF9J5MG3Hht6n/itkJhdnHKGxZLifEcnthv
         s78vatmOMV31CDNJArnahbtpTFkMwS5zv0ASs/UXJYIoR/9KK8zCgX2vuBp32Op/Yv4c
         S0RQPTNqfCo8r9Ydk0/NK/B2Yqb75XUdU+TjwIIXn2JXfX7XCR9WAEEOJ4g2eHEgqTLy
         MKLciTru65V+a5lsHRgt6E0BeojNy31saXLu80pou7F9sWDeF0FUHGMf5pBPIQ4saxQC
         x6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768835954; x=1769440754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wte8eMJNDbcrKLuDulK17hs1mTpYcPcujxWR+qNMyWA=;
        b=I4VJ0kxOrxtkqI4cnV0rLbW8EdO58jUgfnnKkEsQ51Oguc7PUs26D2UOk8DtKwU4fu
         eeM0dn5ESnMV7sQqXPa4Pi3uNXetig39qLOsPHO+obWApDFddsVee9qOLBy3/ehn7H4I
         TQ+/hxDEGY4uvlmG31lMuyWIhlAzhJVMpsvdBMdavvSpwZ9Cy2wEc4VmxkL8w6qDc2S3
         C2T9E1bVPbojQ2LjPl3E+H0H1BxnpY3qV5GC/3XnB65y9HNJjEspm5nNmTFADpU71hF+
         mwn5KDv+wtlTcdihPYwL4HQyC7r9joxbXDSRWoWApMBj2P1RweczXY29mWwaYlTBOsdY
         5tGw==
X-Forwarded-Encrypted: i=1; AJvYcCUxFTD7tczgO3g3BXNU49I4SeysWqvtksKlXmxt5fS6VVQl4cUrX7c9JwTg+VxGRwwXqQrsaUk6Cqpe@lists.infradead.org
X-Gm-Message-State: AOJu0Yy7L3XGPVTnCK0/LKtYB7EGEI/WUYkXIrS/Wq/4BTUNHZ29jxjj
	5rAJo3zEegz5GSRyh7mWcFFVb8Gzry5xclk+H4daqstGqlIGj7XmZxJP/82leXRH0C0=
X-Gm-Gg: AY/fxX5ynaASzFjYHo7gz9F8FKDCT0Yj3/7rLR9f7U08nVDfvRgfgCiJvBv2WTNUhWq
	dgP3ilioM4fXZH1lBSQkQg2f+50WImbFu9Muke/RvE8tXWmEfGUjg+nkPqjYtj4XQK6MKeI8Qhq
	CZWFcf31xisuaW97XcSQCzx20+BV4XUsv8KwEMliuYQ4FstsipTFX6T+cLpnpny6rV4eS+TxUwA
	1EERx5yIR6QI05f+tPFOK0uryJfqxIKUQRwcwiUAJ7b5DFZqVuk6ErGSnbwuUaaWfrYWRgwsv3P
	Z69pwcs4kT7YGPqE7bs74Tbg69BqBbt1HtI2idNClPfJb0SDmSU5lt84YwXMTkHIwCwbBk4+a/m
	YWqMAVPbkUnnCXAkFmw/EsCgz6+daTvfcL5gv2S2Xnzy9XyctfCFrLL9+XWVonZ1EwUVcloD+WF
	6p7Ky1aIQ/ElOw79+/zNyKqjRGSwnwRy9NiIQsKZuD4fdRm9okHKPKQE/x9aGLeZYLrq+WXKauF
	5Ge33sS
X-Received: by 2002:a05:6808:650a:b0:45c:8d9d:8db4 with SMTP id 5614622812f47-45c9c0c3149mr5241188b6e.55.1768835954379;
        Mon, 19 Jan 2026 07:19:14 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bd5c64asm7047741fac.16.2026.01.19.07.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 07:19:13 -0800 (PST)
Message-ID: <9859f637-d8f9-48e0-98ba-42cc6255c73b@kernel.dk>
Date: Mon, 19 Jan 2026 08:19:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] nvme: optimize passthrough IOPOLL completion for
 local ring context
To: Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260116074641.665422-1-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260116074641.665422-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_071925_208202_2509895D 
X-CRM114-Status: UNSURE (   9.10  )
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

On 1/16/26 12:46 AM, Ming Lei wrote:
> Hello,
> 
> The 1st patch passes `struct io_comp_batch *` to rq_end_io_fn callback.
> 
> The 2nd patch completes IOPOLL uring_cmd inline in case of local ring
> context, and improves IOPS by ~10%.
> 
> 
> V2:
> 	- pass `struct io_comp_batch *` to ->end_io() directly via
> 	  blk_mq_end_request_batch().

This is a much better approach indeed. Looks good to me.

-- 
Jens Axboe


