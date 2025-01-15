Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5106EC02180
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 22:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tWAMR6iel+CwV3+5uxVgjU50rbZeLQWpDRLYYHBVxzo=; b=RYy9WRqXYexgADZi02pf+DfYfl
	uEKBS/NymMiXQPkiGKbxuT6K/lHYnRs+u16iDl1ppptlGOK4Q30tIMZK/NEiBEicHW6KmcIDO+iew
	arLBB9weSikKsvp4NqdW/+Cn8x692BBxGio4wCJqzOnSVR3/IFio70eBQ8KTNXLPfDxr2cAQ94dcG
	V9ZrPuJpSOifHUulQV3UcBYARL2k1QnVQwSt01NlhlbTCBkQWyyILG3HfxeDYsEos/tWxOXeyNilt
	ISOgFZnIAc0isW4mmKpZhSrECMOfwSq//J9hfdMbT91q8tp8rMEMA7+Bfmr8OYa8VQ1YfD9//HtPG
	2K4U+Adw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYBm6-0000000DEfo-3IhD;
	Wed, 15 Jan 2025 22:22:10 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYBm3-0000000DEfQ-3uWh
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 22:22:09 +0000
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-84cdacbc373so11486839f.1
        for <linux-nvme@lists.infradead.org>; Wed, 15 Jan 2025 14:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736979727; x=1737584527; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tWAMR6iel+CwV3+5uxVgjU50rbZeLQWpDRLYYHBVxzo=;
        b=PywATDHDS5OlDxcsZHvcmVBRBk6CSl7zPNzBDWA2p1VpGLo3k0iknMVvArZQa0tn1O
         bRVJDmLBd2T6/tPFjvzdmdaBDJqYxRmdaL0F3I7yKhS7od324UTWfSNCOJ4N7+AH3xLw
         F+P62cfgfiB69tM34j50DrUsaAgR1d+8VajKrbKONwWG+rPBN8hWqBWyfRLTnA7a6e4b
         mFzyxyDxNteEl9D3R9IdHBj6GMhsp1OW9Ibn9vhpsYHNirxRohN6mu+5x+NuYl+8K3AG
         R6lSBgaLxrh86z1e3kRLpJN+PUEgK/uXNGkn/Q2KLfdAdLSiP71CghMpo9Grpziwrwgn
         26MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736979727; x=1737584527;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tWAMR6iel+CwV3+5uxVgjU50rbZeLQWpDRLYYHBVxzo=;
        b=e0JHIRrFrMOmQJSnqoWxa6x0hY23onTYi4Ta/s0oLAOud7jCb0lFovgRZDOUtRb6Br
         4OX9mIJt4fAJ3wXB2R6yb/1AzfaGTfFbPMh2T4XZMqL0fixb67gCbFVulaWDYr+MfFIc
         1HPpL8bObJsVMhkSldZmwR1syy1ac6RpdKVf20URniP+ad4wmHC38JajRaLEU7ZTU8ya
         ACPGZ2CpttHncGb7ZGLEcOQw1iUIAQjLJDHQ0Vj6wGvFfNssTxJ0mwjP2G/g5pbTV7Bp
         zcxKz/FCkotTPGJ7J3FLzSvsawhkLlhoCAam+2cwdQBCOPzSmno8651vJa+UwXpVLZfG
         soRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMdyP9PNSODCTwU5NK+kJjSLAquJZIs60bxvLYV6cvG50eDiDBo9pQite0XDHpV/2xu6PpUM0YUR49@lists.infradead.org
X-Gm-Message-State: AOJu0YwFDegtViO9SNUdkCZNZrvJdN+BSj7heeBz5KPF5bn0GgDZtBTr
	OIhZEi3PNk/bJT81xsXb6QiS/ixDsDSrRRJsA0EtShoW5quAyhoqidpbM7aQEIpUGLMoBmt2/AB
	q
X-Gm-Gg: ASbGnctrwGXEcS2JCb0hVWmU/uyEg3WE15lY7GyLRuPIph5wb3Lcmr/WoyfvKAxcwmp
	fJr9bbhircJFyUPwSHevDFN9vlmLYv9xGWZZGMzfgkRmS1rFzCJaCpXG3JWb+oiXAfunlQYebbP
	nT8BgautVHpqLOVSlyjdaW/Hz8fpClEUEVYP5jYABkr0sHrkc6eVA+iRpo+P61khcBYvHxc0gRl
	CPptfy2pbnG/wi6n9TLVny81nF1HnSymx4aQgNfetEJXkb1fDrbmg==
X-Google-Smtp-Source: AGHT+IGfyOgLd6Q9YDBCU/45DumXr3R36UEzxz3IvQvnkD5bm8/JQVjdcvSYmQ1LXm3qOHMSUJjOPg==
X-Received: by 2002:a05:6602:7211:b0:83e:5860:5189 with SMTP id ca18e2360f4ac-84ce018a2a1mr2562324839f.10.1736979726850;
        Wed, 15 Jan 2025 14:22:06 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b745c96sm4369955173.129.2025.01.15.14.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 14:22:06 -0800 (PST)
Message-ID: <6ca7f59b-f232-4bf0-984e-a4439e22b9ba@kernel.dk>
Date: Wed, 15 Jan 2025 15:22:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nvmet: fix compilation errors
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, dlemoal@kernel.org,
 bvanassche@acm.org
References: <20250115221703.62861-1-kch@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250115221703.62861-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_142208_238296_DE0E1AFF 
X-CRM114-Status: UNSURE (   6.04  )
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

What is this against? There's been no changes in the nvme tree since I
pulled it, and it doesn't apply here at all to my for-6.14/block branch.

-- 
Jens Axboe

