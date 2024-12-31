Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3232E77188
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Dec 2024 17:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Be/4K31FgJKsRBu8+Xg8Ncy8T9T5Q1al+btBvPpafm0=; b=zJwRdZbMvHbhweMIruhCVNA38m
	GbGTcyrzzhx69z7yIcqRciuxPrBiGn4d+fzSxIqT6vxekW3CxASYA9DKOsnXI3n+Z971evdhFITtM
	e34FvjsLvHfMWgUz852wqYyi14SHa8vNBc0iVrRnuyy+BMcasuypM1XgpdVGGshnPtqSfjsJU2n+m
	hVwGR8/ynCHlxBe++XQSO1C0R/eN/BawMyzjcT/b/t6S3K/H+YOVnUyRNyrThLLQhhbbg60I3Fjaw
	ZXzqy67krjO6S4vx3HbBPE1a+dsFtcfP8eplKP1JuwJNyuuDOJN0mEHTyQGf2MUo9oyn3YBABF0jR
	aWeDGklw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tSgKY-00000007Ypy-1Bp5;
	Tue, 31 Dec 2024 17:46:58 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tSgKV-00000007YpW-0IRA
	for linux-nvme@lists.infradead.org;
	Tue, 31 Dec 2024 17:46:56 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2166f1e589cso163931985ad.3
        for <linux-nvme@lists.infradead.org>; Tue, 31 Dec 2024 09:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1735667213; x=1736272013; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Be/4K31FgJKsRBu8+Xg8Ncy8T9T5Q1al+btBvPpafm0=;
        b=LsHg5D05T28Hxfodkki0ZqNPh9kD6PZFGSXRWMq1VqintGTtHW3F9GOp2wy3VzVfOR
         Q6IGqUm7A9a2U7qc1qrdbByHWALGxWAyWktm5ddQC1X4iBunEs7yMztYgz5F8vIeOv4I
         lyiUkDTJDZuo9nQqe69CSE5RMfyVb6l+heBz5xhB191EfqzYX5Ym4qAv6VcF2W7+9cye
         LG13uqA7ABatCspfR/nwkULXzKW4zxVoiy4G4gpuI1Qmodq9z3bdyXLu0nNnKXFmoqpM
         csXlGKZX/afw/765hRO3wAchid3Z4pJ9cKm4BgeNTNCe4AWuyugDwHUznRcsdTCT0Xko
         z6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735667213; x=1736272013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Be/4K31FgJKsRBu8+Xg8Ncy8T9T5Q1al+btBvPpafm0=;
        b=RI0ltk/Vgo2szrtQ9vdjTCMZr5m8AlQaSB/ocZ4KF8fVq3tU/z8FtCkGsV0ET8bhjC
         MDf4E0Dh26E9tYrX+2mvbSL7FUwKR8SUKAnpe1RorhB+dqdm9B9VIRcYQK8McS6u4XN+
         ppuhKcvAYatoUhxsnIcOtV3eKp8YgEt8bbmyLG/7veH6ocpdsx+qlcfHwUux5KSePXMI
         sJboW6nGmYYUjiJ0fcuyVvcQ7cUjLmldXwAAvT8DWZ39v57gzrxd9DPwBy7+LATS3wGg
         NlVqBKwS6hhP3uoEUsRJnpIE4dyrYqGPKFc+fck8Vxw0DYG4fOP/+Blx/ikalVbOi1mJ
         kdkw==
X-Gm-Message-State: AOJu0Ywk1WuB2l4lbmG0M47qBVZDGUc5njWokuef66ekmaP3waSHd7eD
	nK475ZlEmk1E8E8TyDvG7IZbgwTeZVlF71bFGIkVtpt/2fsqfctw4m/MMV7HXXDPHAhsL4YtDzL
	u
X-Gm-Gg: ASbGncvpF/ND3I4KjQvZsLfrUnjDGcBuWBJMb22TquyTbxuNB1hIJFFYh23XNmwxLU5
	wG7b46g/qnhiEx5S83hVoBU5NCohPEcKP3GoBZqWgUOBCZlPCGeDxqkl0cor9z8yM+Ai/5fc6JA
	OOkNTXX6B1xwVv2OC4YiYnnBtsU3OCgAshd9nhhNsH0kxFwVf+2Kyv6WmC4aGFLwsd3qQCKcI1m
	LRiBj4nrWrRk3qtsWgHosRPBdSZ7BNietz2JLcneEA9xcUzQ5gaKQ==
X-Google-Smtp-Source: AGHT+IEUxI8Y0tIU5ItIdV7OfldmbA57Q8LErn1UXdOwqhPRxLyQ5Mb89A6Hl4fvXisn0Km3vsnPXA==
X-Received: by 2002:a05:6a00:ace:b0:725:d64c:f113 with SMTP id d2e1a72fcca58-72abdd20f93mr56842955b3a.3.1735667213468;
        Tue, 31 Dec 2024 09:46:53 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fd7b0sm10450748b3a.139.2024.12.31.09.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Dec 2024 09:46:52 -0800 (PST)
Message-ID: <3cd3369f-ceaf-4cb9-bb0e-c28c26cb5d7d@kernel.dk>
Date: Tue, 31 Dec 2024 10:46:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.13
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <Z3QsuprGMAMhy1i2@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z3QsuprGMAMhy1i2@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241231_094655_401408_FCD790FB 
X-CRM114-Status: UNSURE (   9.58  )
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

On 12/31/24 10:41 AM, Keith Busch wrote:
> The following changes since commit 790eb09e59709a1ffc1c64fe4aae2789120851b0:
> 
>   block: get wp_offset by bdev_offset_from_zone_start (2024-12-10 13:24:24 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.13-2024-12-31
> 
> for you to fetch changes up to 36e3b1f9abe359b2bc25e81bc47b64354e42c9b1:
> 
>   nvme-tcp: remove nvme_tcp_destroy_io_queues() (2024-12-27 13:33:48 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.13
> 
>  - Fix device specific quirk for PRP list alignment (Robert)
>  - Fix target name overflow (Leo)
>  - Fix target write granularity (Luis)
>  - Fix target sleeping in atomic context (Nilay)
>  - Remove unnecessary tcp queue teardown (Chunguang)

Pulled, thanks.

-- 
Jens Axboe


