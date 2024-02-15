Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184C2C4829E
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Feb 2024 16:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OIRZD8Rd0KwCHoYP+crBPVnbuy3I3sEeJSU2IZClexA=; b=h5Lzep7/Rdsz7NPCm+r5qyHq1n
	OGaGU15cwMBJPiRsm65CEv9wLqTWT7gUQ+SMCLaR4FoltCSxnyyYmbYfAioDP6zXqupnOfSe4JKg8
	5ocpmObt/kBkbP5pewlH+NCF5L4KFBuzOJbWakuO/MerGetI2x9HKJCc8Hb6ejl1iewZVZ3R3bt9R
	dDJ0ADEdNb5JF8KSpbctzo22Kq3Jvf2yPWEfJhNoRL0BTdXdKSJzigzOrTiQi/xpeGFjEAinX1uNG
	rZjRrmdEtuog27f75Sx0dOdutY3qX/4RaF78IEstPhs/ZCQBnbej/utEdBHdwXwyK1aFL2zZmlg1B
	0SCGd+Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raeor-0000000H1MX-4A7s;
	Thu, 15 Feb 2024 16:42:41 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raeok-0000000H1M8-2w3L
	for linux-nvme@lists.infradead.org;
	Thu, 15 Feb 2024 16:42:36 +0000
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7c427cba7a0so12962639f.0
        for <linux-nvme@lists.infradead.org>; Thu, 15 Feb 2024 08:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708015353; x=1708620153; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OIRZD8Rd0KwCHoYP+crBPVnbuy3I3sEeJSU2IZClexA=;
        b=mCXulbWFzHughsnk3VGvpgnBYE14Igx+gUBW5nri+8bfGtXYvu3JVM8G9aa/oX+UKT
         PpEx6zE7mlkm6C7/jWeDmZDL70oc1YjRETZa1O3/S70X7VxCEjWjzqdmoeod/R53iyEe
         caFtZD6tD+Gm3JnLUO8N6Ya8zbo3VZzzJAHbbkTUH+gn+nwQ8lgJNSCESWT0/tOfyzuQ
         2X020PYJ/CH7g/BKM6z0tPsEoBr9aYnGkxdREsNudeoXU1yr3XnDqBfIRjkhHKV2/wWg
         7KofHG40Hbw3JyIng0OYPf9HEtja9rk10390X4Wte5vBYz+kdw4erBI2Jvcer+7JDWpj
         SYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708015353; x=1708620153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIRZD8Rd0KwCHoYP+crBPVnbuy3I3sEeJSU2IZClexA=;
        b=iWIcxpn9pgkryP67k41gTFlzrPooA2yZO87jVQ62xtj++qZB6eizzztafed+l3ZyCY
         o+ARNmkZ+3xQEJQEUBELarjB9xbclC0KfyQRXk8G4ZkjmGd5w1k8JPvgp0ZYjuyHKPEq
         c2FdhmBl/+HqzibwcL2y/SG6Q2cTXbZeVwiMnGRTFICZb3ZtyjlUxYPG7eRALjpi76Ih
         FfiGPXz+m0Ir3A3EVwp8XrUMw53SJanc17JS7WA+ugcD4sPzXr8jfE3/JavNkIqc6rvW
         eeleDL1mG1xWm4WCTE7RSqDxOmdNRBrbxYebFgsEE8JwAIHaTg4V/MjKurL0NQD6mOs7
         +AiQ==
X-Gm-Message-State: AOJu0YylbM3K4wfyyTUJvxscX9Dq5shmQ1IDovE0BqMq1nucUQbnmNW5
	A8CazHmirZdgB2vCMGAUWaYiJxX8KorRJC8sC0xCgZ0YoYLp2IeQgMy7BvKoAVihVHvoRlx6SV0
	t
X-Google-Smtp-Source: AGHT+IF7nGLwk72ll920s3xYQAuXs3QHw2RACE0K4Ay+dm84UfFfFSmAIexfYLlXEGrl/OfBUXHWJg==
X-Received: by 2002:a6b:7e48:0:b0:7c4:9599:dba7 with SMTP id k8-20020a6b7e48000000b007c49599dba7mr2067130ioq.0.1708015353014;
        Thu, 15 Feb 2024 08:42:33 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e8-20020a02a508000000b0047333f454c0sm410100jam.76.2024.02.15.08.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 08:42:32 -0800 (PST)
Message-ID: <dbc7d1a4-b81d-4feb-ab96-4e2cf35680f7@kernel.dk>
Date: Thu, 15 Feb 2024 09:42:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.8
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <Zc43KhmATYI6tOyW@kbusch-mbp>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zc43KhmATYI6tOyW@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240215_084234_775585_CB7FEFF8 
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

On 2/15/24 9:09 AM, Keith Busch wrote:
> The following changes since commit 5f63a493b99c848ad5200402bebe26211e00025a:
> 
>   Merge tag 'nvme-6.8-2023-02-08' of git://git.infradead.org/nvme into block-6.8 (2024-02-08 15:05:18 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme tags/nvme-6.8-2024-02-15
> 
> for you to fetch changes up to 8d30528a170905ede9ab6ab81f229e441808590b:
> 
>   nvmet: remove superfluous initialization (2024-02-13 15:42:44 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.8
> 
>  - Fabrics connection error handling (Chaitanya)
>  - Use relaxed effects to reduce unnecessary queue freezes (Keith)

Pulled, thanks.

-- 
Jens Axboe



