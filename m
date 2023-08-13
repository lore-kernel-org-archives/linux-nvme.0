Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E56C001DB
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 15:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Il0m/lOqz0vfB+XlsodsH9+I+amK+zd4Tb9YP5hNen0=; b=XZjSp+VgIYij6SG/EoQIWsxr0l
	lYCpIFgTlHC1m/ji2zODqUur/NHuCq5jHKSDuilU6QDfS2R9r6XreKyvxou0dM8MsLeSbIgUK5Hxl
	yUGFaPU/98RB7o3mi1qjhKsBuoGOuJcqwQ9Pp+if2f7Fiz/oS3Gq0xttuLOyKqOzIIdlvQAHwJ9cV
	BIhvgHsYWqGfU5gFw5ioMwlbOMFuyryW5zFP0qM2lxnWukzdfGXGJIPMAT711gm5bPcQ0cwLrg0Z2
	6Ccyh1I7bICwyKRv0EWhUOkBsdNQFvC9fIiiXIZny6VR8G8RH5I+Nd4I/dv9GmrI4LFpf6pmwtpIS
	VT1Fb17w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVCZT-00FI7g-2B;
	Sun, 13 Aug 2023 14:59:59 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVCZR-00FI7J-2a
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 14:59:58 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3fe8d816a40so3470215e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 07:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691938796; x=1692543596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Il0m/lOqz0vfB+XlsodsH9+I+amK+zd4Tb9YP5hNen0=;
        b=H3/eAYuHbEwV+qfduyizSgflgho00vqm77ra39iiSzVqtFb5/kViAJjGmN7QZhiqUE
         grygRiGSARzdOVYQBcYZvDlNx7DI8VnDRVYqQkQTltNZudJ0XmJc1cHSF6HlNPS+pGT0
         mU7KYQrvRoZK4eKHCMmnfUIYjpfGOtFAayhWCuQzPFzul2/OoHBSO1Fm/u9pUhfnjl8E
         Ng90m70PUh5XpguK5QST4w28z44VOF3b3x+ozuLwAG5IlfHrJf58jIE8xh5l1DEnU81Y
         abBPfxQwS1wKYEaka4+vW6pAiiAG2f22aShVD9CF4MMUtx4nfU2oXJvsSgz4bLEpEe+Y
         85tg==
X-Gm-Message-State: AOJu0YzJkcmkAzRYJyjCZtL9O/r6XbCjsi4Jl5m/+6JujLOHk2Zhuk7h
	FH44Je5Z1FFFkAiTiKrpNeY=
X-Google-Smtp-Source: AGHT+IHTrX97QvCgayVEBdbqNUrzi0Oa+3iNx1L7BGPGmJ1HsLfOLo9itX/W7HaXgjAK5iLkZmhtQw==
X-Received: by 2002:a5d:5484:0:b0:319:7624:4c8d with SMTP id h4-20020a5d5484000000b0031976244c8dmr711423wrv.0.1691938795912;
        Sun, 13 Aug 2023 07:59:55 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id pk15-20020a170906d7af00b0099bcf9c2ec6sm4690166ejb.75.2023.08.13.07.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 07:59:55 -0700 (PDT)
Message-ID: <1098c6a6-50cb-8704-9041-03c431155dfb@grimberg.me>
Date: Sun, 13 Aug 2023 17:59:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH blktests v3 00/13] Switch to allowed_host
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Hannes Reinecke <hare@suse.de>,
 James Smart <jsmart2021@gmail.com>, Bart Van Assche <bvanassche@acm.org>
References: <20230811093614.28005-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230811093614.28005-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_075957_838287_CBC0A7B7 
X-CRM114-Status: GOOD (  10.86  )
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


> Addressed the comments from v2. I also added cleanup code to _nvmet_cleanup() to
> make sure we do not leak resources when something goes wrong. I run into this
> while testing and all tests after the first failure failed then.

The name of the patch series suggest that it switches to allowed_hosts
where it does that in 2 patches 11+12 out of 13 patches. The rest are
just bug fixes and unifications. It's true that any series will include
fixes, cleanups and prep patches, but this is too far :)

I'll let Shinichiro accept as he wish though.

The cleanups look fine to me.

