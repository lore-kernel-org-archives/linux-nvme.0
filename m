Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA776C4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 09:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W4iccx2nbdY56tbnppHcKoGsfLokH5pJ3lhsp4c71Fo=; b=P7cORGolMu/fWEdZXzsChlD4fJ
	SU6DgReExtBLLXJNTg9h9d2lmzXBXEW4vGtq8jKFHno0GFHRM/3nqB4mijPKh0DOln6L9pOyp35v7
	Vwp/9Xf5tZ4AhDbmKvvESaL8emisCgv7JtcxLhX9BNWxeSStOfxjIWOTzx/KASQQwxpInA33R2SAM
	SrZEkyfvufsxYjgGzuoxExJvij3sjzRZ4OMQwIMGibxwh7Ece6oPPWP5wrWbBjMUxJJJTREdFwqfG
	bfHjZdVt1hNGfzWiJbSzSUrr7K10LNM0P4fiagtDaVN8ts/A/zzAsAwfH68ymtpwOwPed0kMRq7VW
	e3H3dpNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxNz3-00000001ad6-2zsw;
	Thu, 18 Apr 2024 09:23:09 +0000
Received: from mail-pf1-f178.google.com ([209.85.210.178])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxNz0-00000001acc-3xFr
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 09:23:08 +0000
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ee0d5044e6so1650b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 18 Apr 2024 02:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713432182; x=1714036982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4iccx2nbdY56tbnppHcKoGsfLokH5pJ3lhsp4c71Fo=;
        b=ukkKaP/EaOMWJFdaDlNOJqkfTqXuQVBDr9dgnueUfAeEzjEBQj9Ydq1U9EHDTWoUOP
         Cs4hlfjzBkCyZvA6pWaT7kkE1ZtGGW390EDC8rGJBGPQtFaaa7bR6JYrTMDhN2KPs4xv
         MeAwngGmZCB9Xq8CjugrUBZ5s2/RGLYahtaUBrBMpzF3G/Q1h7flAmA7z28M1fKpKj5P
         CW2jLUV/zUhv7Yh9O03cDCtQ5+65GalraNKRs/9Y/zmHSrG5KXxj/ZFhJXrwUu8u3EwD
         YcRxBdAYzTAWcjJItLdSnL8edjaxVJqDS4Zwv/k/+yGMgtJW3qLnZZ9XpaQnG2ewiWtr
         urlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqHM3B0evFWZf9Z1cmqSp/nY2t+ptUAGjUq6Vo+EK7rRZD0nhrQSeLe2wopfeHH/Kj41zD1OU8Ipjr9hK3MYwOgNUSQnhSjIUh9KhucxQ=
X-Gm-Message-State: AOJu0Yyv4BsrjKuemzxvXiJbaQ/SOqB/U7rMRuOZ0AUs5GYMicufu4DP
	fkHkpy6HHgnXiAZUvbY9tNYPUcTWzjoUK1ASFg9nzOgKETFXUFwW
X-Google-Smtp-Source: AGHT+IEMt/GjDKx9eYdAUfKLPRFNzIvuw7oCrrJJ65efR+z/oXknCJ8RBZsVeJMww+f6bPNX2SHKQg==
X-Received: by 2002:a05:6a00:2da0:b0:6ea:8604:cb1d with SMTP id fb32-20020a056a002da000b006ea8604cb1dmr2847275pfb.0.1713432181921;
        Thu, 18 Apr 2024 02:23:01 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id e4-20020aa79804000000b006ecc858b67fsm1067685pfl.175.2024.04.18.02.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 02:23:01 -0700 (PDT)
Message-ID: <4f80a818-0e3e-48fd-a28d-aeaf11491253@grimberg.me>
Date: Thu, 18 Apr 2024 12:22:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-cli spdk plugin
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Daniel Wagner <dwagner@suse.de>
Cc: Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Tomasz Zawadzki <tomasz.zawadzki@intel.com>, Keith Busch
 <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <xulnfwru3jfl2nooq27yym7nx3cdpxqslzqz5nvwnkymncapnt@pzascju2tmvf>
 <20240417142610.GA31809@lst.de>
 <7a926cbb-51f9-4e03-b737-b4434b1270dd@kernel.dk>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <7a926cbb-51f9-4e03-b737-b4434b1270dd@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_022307_082519_B3E2A06F 
X-CRM114-Status: GOOD (  15.10  )
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



On 17/04/2024 17:31, Jens Axboe wrote:
> On 4/17/24 8:26 AM, Christoph Hellwig wrote:
>> On Wed, Apr 17, 2024 at 10:33:17AM +0200, Daniel Wagner wrote:
>>> There is a PR [1] pending, adding a spdk plugin for nvme-cli. The
>>> problem this new plugin tries to solve is, that with the recent change
>>> to use sysfs only for discovering the nvme subystem, nvme-cli
>>> lost support for spdk.
>>>
>>> My question is, should we have a special plugin for 'list' and
>>> 'list-subsystem' or should we try to get this somehow integrated into
>>> the existing code? So that 'list' just works?
>> І don't think nvme-cli should deal with anything that is not driven
>> by the kernel nvme driver.
> Exactly, why on earth would we care about spdk at all in the first
> place, nvme-cli or not.
>

As long as it does not introduce a maintenance overhead I don't particularly
care. My suggestion was simply to make nvme-cli operate on a path-prefix,
which is a very minor change. One can even argue that its justified for 
a container
bind mounts (although I've never seen someone bind mount to targets other
than /sys and /dev ...)

In any event, if the spdk folks can make their devices interop with 
nvme-cli, I personally
am not strictly against it if it doesn't require a burden on nvme-cli.

