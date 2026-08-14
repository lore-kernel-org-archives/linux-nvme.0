Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B9EC5CFDB
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2026 12:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g57BPbBjVyFYadXJrMobD1BBS6GenGZ8fGUkvoQD0vk=; b=JrWCKhmTxgz17QfFb8kz8wVGfY
	UMKfJtz/4kDQXIgsSW7Zl/UnZezMT7o4oOS597N81Fqfi9vi0b1b4uOaNVoVZkyJj8mdON7gRjNzR
	nFdsfAOcfQYTybruESjhHcK/WQN6wySt5XC1m9LJYmFkMkZUPNLh9YClbBWWqaPwTJOCr5G5Jk+lJ
	vAIOuNGJ4D1cPHaKXtR7xX4CswVmrzhdz9bjTCWHa/qLhEj14Tq8LgNsNnvP8uBuAgm7cxgbvDYNP
	aNi1GZxk2v+tHL8NpQMpo8lu9e7UqjJNLa92SVeqYHRUwspu2GNePUXd0BTDt7AMZy+WiPNJbhUuw
	+Gg0TUWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuqnz-00000002dWn-1um1;
	Fri, 14 Aug 2026 12:14:35 +0000
Received: from mail-oo2-x05.google.com ([2607:f8b0:4864:31::5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuqnw-00000002dVf-2rTW
	for linux-nvme@lists.infradead.org;
	Fri, 14 Aug 2026 12:14:34 +0000
Received: by mail-oo2-x05.google.com with SMTP id 46e09a7af769-7edcd5f9e55so286938a34.1
        for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2026 05:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786709671; x=1787314471; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g57BPbBjVyFYadXJrMobD1BBS6GenGZ8fGUkvoQD0vk=;
        b=Sdr9Vtdjde5r9MvSKLgpYT5fxRGKje/uH9lmI+hGQ2LwCxocoBiVQunEfAq1HXwZLr
         hPMzJqapxSqxHzRjn8AZJ2UhWOOXMOamqxgAu9F4m4iVFP/rtLd5q4bcKEVcbQVv0xZw
         QEbrVUKADloWcRi+h71HOs8yowEjNyfnmx50vXWobNh3MW/Frc1bYyy+/k8Rwhakl9kO
         Q9JdrsmTcQ7Qdutonqk004Glj483DdzhQOWvlSFz8+rFGlXl/D1CC2euiHJejumhvF+/
         6WRl/39TAPC0kXAwgZSBkq1qVoInUAmM7zQS3zK6GcdtnUW77R/PXwMQA3OsgzJD7G+0
         G2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786709671; x=1787314471;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g57BPbBjVyFYadXJrMobD1BBS6GenGZ8fGUkvoQD0vk=;
        b=hHM0eqLMfMJMAOUPSFrxN0Ngeo2+Ov2zY0/7t2LeJFsBfn7CTyOo92Q+RHfmDj9Sh1
         a4tDUC4Fh8X8b/YsXosqzjW32mxOjG231G+2741qLVvbb0C74iuxNPuX56Xvwj5rI4gG
         CmL65zWFnfR/jycoX2Vd4JPp5ok9ZSR/G8utdl6PtS/t0E4GR0Z4TDI0CWeNbthEM8QD
         4kCVuZkRW+KDlaOAsszWnsJvDUXJrRC5vaV2R+aAgJJCpNpXOMtMSfIHJVYCKqa3Mili
         1LJkGo48dvq4tR7beg4zqqqK5JL2JKgtE6pzqF8o6geJRgmxQLskBRJoh92nwMctLE0U
         UDhA==
X-Gm-Message-State: AOJu0YxKja7ugj9ZnQ6nyMy8fyB/184qRMzFRzyOWUI2RwS6fdBGebzO
	XH7fneMaPDznclT1gWjgSnaAaZ5gU7suoOjeoJm8k6md9L3GEzlzddCARVBDz9IbNDh9cU3ELsS
	cvHZLa4tp3Vfs
X-Gm-Gg: AR+sD117OkOjxuhFptQBg95WA3vw8stjeqgUMkKYho6B62pt4faDDPHKjtVgA8yqmRF
	0yj7MBkifd1nM0HScnpuj+urf4PBuwyY3MW/JU33nCHBRtL0A4B8oZom4Foxq1m9iQVRgOgH9ln
	EgUlof5sfHZV8soFPfKpdKetDAB0dgaNeqc6pMVA3ggVnYFhrlua1dibJiR+FIovuFyubPHW8jQ
	a7R28ivwrRIPuSSfcv7klWrAxtKTnTICkATJ+yQuHK+KpUAHdA89VnbHAmLeuSvXFhBawl+2taE
	xdwtBcTWiYo0k+3wTeCS7UqoO743kuZ6SEVruytdruL9CWoGsfmlnDlNBD3hR8MgC/MrwVSPZ0b
	Q3TXi8P7DWG/w+hC1LPCYzekSN8ECSRYdKQdTLvj9muGkcjEm5we/zhkshf2IQI9OZfcxHiRwzh
	hr+zAMKpV1p9o1KN/Xt3qosDxiSKMdjLy9UicOmJEutLelp49HAvveXXQTXNZ8BMC64yCv3zXme
	1DGvfXVYpt0ZtSjFUCNODGmcHvrC+kVYsiEGcfLOHO3bok=
X-Received: by 2002:a05:6830:2992:b0:7f1:deb5:5a5a with SMTP id 46e09a7af769-7f3de55432cmr4921749a34.9.1786709671361;
        Fri, 14 Aug 2026 05:14:31 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3e8197905sm865606a34.0.2026.08.14.05.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 05:14:30 -0700 (PDT)
Message-ID: <59c3dfa6-be4a-4b88-9c13-60541f0ac989@kernel.dk>
Date: Fri, 14 Aug 2026 06:14:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL v2] nvme updates for Linux 7.3
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <an44rv4ZgsxxyFD8@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <an44rv4ZgsxxyFD8@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_051432_988107_CEE18CEC 
X-CRM114-Status: GOOD (  15.24  )
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

On 8/13/26 3:35 PM, Keith Busch wrote:
> This time with the summary in the tag.
> 
> The following changes since commit f01f5275feb77bac9fefbbf7cc584fe0b3850a92:
> 
>   ublk: snapshot batch commands before preparing I/O (2026-07-02 06:25:21 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-7.3-2026-08-13
> 
> for you to fetch changes up to f1a8846e06388113dfdbb89dee005083fa9afdf9:
> 
>   nvmet: fix max_qid race between configfs and controller allocation (2026-08-13 09:26:44 -0700)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 7.3
> 
>  - Enable context analysis for the nvme host driver, annotating the
>    subsystem's locks, along with the LIST_HEAD_GUARDED support it needs
>    (Nilay, Marco)
>  - Harden the tcp host and target against malformed PDUs and out of range
>    SGL lengths (Yehyeong, Ibrahim, Greg)
>  - Fix unserialized page_frag_cache use in nvme-tcp request setup (Dmitry)
>  - Bound identify, FDP and passthrough descriptor parsing to the allocated
>    buffers (Hari, Guixin)
>  - Zoned namespace fixes for host and the target (Xixin, Guixin, Yao)
>  - Apple controller fixes: page aligned admin queue buffers, NVMMU TCB
>    setup, DMA direction and admin queue teardown (Sven, Gui-Dong)
>  - Add a namespace level debugfs directory exposing reservation state, and
>    ABI documentation for the host sysfs and target configfs interfaces
>    (Guixin)
>  - Fix cdev and namespace lifetimes (John)
>  - Parallelize nvme-rdma I/O queue allocation and startup (Surabhi)
>  - Fix nvmet-rdma response resource leak on queue teardown (Shin'ichiro)
>  - Authentication fixes: AUTH_RECEIVE buffer and an out of bounds read in
>    negotiate (Xixin, Bryam, Guixin, Eric)
>  - Fix pci-epf use-after-free and CQ reference leak (Shin'ichiro, Yifei)
>  - Reject passthrough of driver managed Set Features (Chao)
>  - Various error path and teardown fixes across the host and target addressing
>    issues with use-after-free and leaking resources
>    (Guixin, Maurizio, Ewan, Zhengrong, Jiang HongHui, Myeonghun, Yang,
>    Geliang, Yehyeong)
>  - Various cleanups and typo fixes (Nilay, Guixin, Pan Chuang)

Pulled thanks

-- 
Jens Axboe


