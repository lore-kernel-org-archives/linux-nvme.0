Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B23E77188
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2024 14:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XDGxAFOz1ZIJJob0FNn+F7UkMCJGzcNMN4DWFulZBZc=; b=CtY6m8wpVOqUuveRdn0EG8Pnfq
	Udk91SxOobDufi9Z+lEiYRDJt1vMLz2xTzrmWTB2TuegaRB4qmfCGTiHbe/8g5gL4bwBhyk7qaS/e
	Qx8n88H3rlUumdTuMtBfPnYQoiIUu6Mmflw6/vZl3NQ2YPRSK5+Q6D697IT8M6hbtvWxt0UsgLoK+
	Ja629orYeAeOLg/ztif/bhUqGONOT42lt7wvKmxVpeuanijNK1iGtQfKOv7h9wS3LltCcqnzauIan
	Z7rkPHjgzwP0K64mzGGfcNzE5w+DwP+IikHUXzNLmAiOHhZylHqydz5ThWFGwa1yL8eJoLfkpTEkt
	LcLc0LPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNuz6-0000000Gphl-2i3T;
	Wed, 18 Dec 2024 14:25:08 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNuz4-0000000GpgX-28Fk
	for linux-nvme@lists.infradead.org;
	Wed, 18 Dec 2024 14:25:07 +0000
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-844e12f702dso224145739f.3
        for <linux-nvme@lists.infradead.org>; Wed, 18 Dec 2024 06:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734531904; x=1735136704; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XDGxAFOz1ZIJJob0FNn+F7UkMCJGzcNMN4DWFulZBZc=;
        b=1o7GSmBiB6hdmLjtB9h7xJU6BbCakOz1wHWLxx2aJHPH0dcJYurl7Xeksmck3ipavp
         t8rQ3wN5K7GPlmUjt7ejSL/dORQVVW1JrLIiTnkOL0pHwOCaeQAUHIs1SGJOOdMZcXPb
         C/gordn7LQ2rvijY6nV3aQVLm8Wi6zFrQwb9WPbO9edMJxIdOoE7sLgO2mPqTysBPJIu
         dDd/abrzLzog2A8b1CEYcREXrBOIMilYEcV6WFf5I1g1AzN5qCnFp+GAw9mB6TO4fTYK
         v4fnCIxtrgDoQnr6wgpsVaBc3BVMr4rW4z3S5Zyt18AnIgMT7F1OxAll6m6Q6uykITlS
         KORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734531904; x=1735136704;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDGxAFOz1ZIJJob0FNn+F7UkMCJGzcNMN4DWFulZBZc=;
        b=daHcqq4bZBW1YLyHHoQ+giiXflhrToBxlEHTxTFjACyUap503vg/CAeaBX5DowI8wf
         xqC2wn8SQsgw9Cj0LA7Ywqf6HVY2LPg3OO4Rf9waGDoyhHSpNzpIQEBWHK1bfLvIPEW/
         xTytMPYUAgVaO6MX/Wz1NIGloahSfaoZojhNcA74gcXaS/ECfTIV3OgXatU6CM0SCxP/
         6PMqsraOFdHQvC+jFmUak1mgnzEtd1na27HJZmmrxfoKrEyyL7pxXQpoR5nQq7WMVFIy
         DAtUq5gQOlmJoZNFPxeoojEYxgWKUwx92LnBA3LpC6voMPgPQJWvDXvSOvZfeLUGoY0E
         /dqg==
X-Gm-Message-State: AOJu0Yz4DS2LMPjD883MbVDsqmmxPzMo9HUTC0wqLlyd5tPcVW82nsee
	BbJ/jjgPJLMtws4NmNx181UR59hcAO/GLTKkCCULlhAnthSaC/KG2KAoYWMLmGIPG6tPgF/EfVg
	E
X-Gm-Gg: ASbGncsFeYmkEq8YasTgdExFAw/DMJe4tgmGKXcTB4FXer5E0ZBWdB+xltwdpUbnXwx
	TzRBb9yrK72FYzCBm0eDjfW3q9gqaTgR3RQJ9qEEb7u4ZWQUcjRAppyapJExSey/KZGgxVmUaal
	UBI/qUhWHXJRG4lIe/6GrS8A7ndUSqPJAAU0M6MgTbNFj5CTbMjJWfnANs77GVU9yDreDtc4Ywb
	ZQoYp2Jh2GuT5QurPiMxnpP5q1OA5Ead362lNvuyEa1Am83yejH
X-Google-Smtp-Source: AGHT+IGTVbkyRNru3nJx7Luee4Ngoho+YlhdN76BflDibPijqaQyfN6N5qx+grXbPrP/steEtnph4Q==
X-Received: by 2002:a05:6e02:99:b0:3a7:be5e:e22d with SMTP id e9e14a558f8ab-3bdc013324fmr26330665ab.2.1734531904600;
        Wed, 18 Dec 2024 06:25:04 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b2425c4b3dsm26973945ab.0.2024.12.18.06.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 06:25:04 -0800 (PST)
Message-ID: <3504c4c4-62f8-4f97-b810-f5357ffb980e@kernel.dk>
Date: Wed, 18 Dec 2024 07:25:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block size limit cleanups
From: Jens Axboe <axboe@kernel.dk>
To: linux-nvme@lists.infradead.org, Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-block@vger.kernel.org
References: <20241218020212.3657139-1-mcgrof@kernel.org>
 <173453176105.594208.15853494245370355166.b4-ty@kernel.dk>
Content-Language: en-US
In-Reply-To: <173453176105.594208.15853494245370355166.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241218_062506_557712_478B4FBF 
X-CRM114-Status: UNSURE (   9.99  )
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

On 12/18/24 7:22 AM, Jens Axboe wrote:
> 
> On Tue, 17 Dec 2024 18:02:10 -0800, Luis Chamberlain wrote:
>> This spins off two change which introduces no functional changes from the
>> bs > ps block device patch series [0]. These are just cleanups.
>>
>> [0] https://lkml.kernel.org/r/20241214031050.1337920-1-mcgrof@kernel.org
>>
>> Luis Chamberlain (2):
>>   block/bdev: use helper for max block size check
>>   nvme: use blk_validate_block_size() for max LBA check
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/2] block/bdev: use helper for max block size check
>       commit: 26fff8a4432ffd03409346b7dae1e1a2c5318b7c
> [2/2] nvme: use blk_validate_block_size() for max LBA check
>       commit: 51588b1b77b65cd0fb3440f78f37bef7178a2715

JFYI, gmail puts all your emails into spam, because it can't
authenticate them. This seemingly happens to everybody that uses
kernel.org as the email, if they haven't updated to the newer setup. You
should fix it, I only saw the emails because others replied.

And please trim the way excessive CC lists on patches like this.
Cleanups don't need to go to tons of unrelated lists or people.

-- 
Jens Axboe

