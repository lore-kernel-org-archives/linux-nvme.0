Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCEAC47095
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 17:39:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A54D6109F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 17:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A54D6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pdvpO0KhwVTY4H1STGYnv1OxE9QjuY4b5UTQ6JL1++I=; b=KxuUstqkhCZLlA
	QvQpqc0QXJmcskfzEXqnBNDMHDwHtHAVfh+SW3FvakcZgop2g737eA7RJGoQMm/ypixF1UMy+WBrQ
	fpOPTc7au0bOVW1K2yqvc9vHGrikS2f/Mnz0LIBJq20C84BMTpEKghUaVVNsnFaht8/ybc7nahDMO
	zJtzReZUo6FIiYd432UL6Od29S+SkZwYgwoEgGXIgP2wWojwx7u6etSQVsVbC5wU4acz/lJdqDn/R
	QNW9TSt/oexcpfUQ97iWIZBtKyEy9pJSF5en42olkGq0urriKkTqKxNhUHypnUp6KdMzVQfJBZqfk
	AdGRDXU+DggmCe54WzxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqJDu-004rh2-5E; Mon, 07 Jun 2021 17:39:38 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqJDI-004rUd-B9
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 17:39:02 +0000
Received: by mail-ed1-x535.google.com with SMTP id w21so21276777edv.3
 for <linux-nvme@lists.infradead.org>; Mon, 07 Jun 2021 10:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Jv6mdenEAUjxxqG8V1uZdiIteEsL88sRg9uJb9rd/1c=;
 b=MMyHMqib86ziBTzj86CHQvyb6ZCknnaHgqX8rvkmpfzD4d1nlV6Zhj2mRavi5vCzah
 ly/8jU65nHFXVshC9ypULejtjivTqZPc+KqXcY66Ct9m3OsgNkSLiSiyDozorH5A9JHJ
 fcTvowf6WrEf8xiyiEWnhQ0MnyE7Sp7/Ckd8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jv6mdenEAUjxxqG8V1uZdiIteEsL88sRg9uJb9rd/1c=;
 b=E2/ku+wP2UtfII4pwXD3UIo5k3BBmiQtjR8KrLAUrZ0YJDTg9bcJ0kn8OJZdPldqMH
 RivnYRazW0tw65TsFCyIXDdBsXjeeQsfiE5/4gyOPV9uMiRW/3JLQ3Co4Eth0zAWmGtu
 86sqrYHaRB5Szyu2KlP/UNjoFWWhKHU2JLa/zsYXmbqLz5mBN4RCJxHyw9UINDD+4jSk
 098nqNUA/CW4d+tU+A+s26gmc2U4cIrM8whKsTYyAnjYCEKdpYllOLXh58+k0RFvcZFE
 zxcE3oPFafxkpuBfvJaQoZKNmhFJqOjD72URoy0movmNs60IKl/KjnwI6RYzKudRsoQI
 opqA==
X-Gm-Message-State: AOAM530Y45/+S5AvRXOHIAzF0la7VljsMmd2N/2am4Tv8fq2Igy1eX+3
 Fra40H46wIa0v5FU5HIUmJcxnvYZUdOA4qCu
X-Google-Smtp-Source: ABdhPJwhHs/ieFinJaf4bje4PqV7Drf8aTwn1rreOGVT0qsBtgeonZnpjXYmu++sgR8nVh2lScJdQw==
X-Received: by 2002:aa7:c450:: with SMTP id n16mr21167163edr.386.1623087535905; 
 Mon, 07 Jun 2021 10:38:55 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com.
 [209.85.208.48])
 by smtp.gmail.com with ESMTPSA id c7sm6771576ejs.26.2021.06.07.10.38.54
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jun 2021 10:38:54 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id w21so21276627edv.3
 for <linux-nvme@lists.infradead.org>; Mon, 07 Jun 2021 10:38:54 -0700 (PDT)
X-Received: by 2002:a50:9346:: with SMTP id n6mr20997175eda.365.1623087534175; 
 Mon, 07 Jun 2021 10:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210607173156.5548-1-mario.limonciello@amd.com>
 <20210607173156.5548-2-mario.limonciello@amd.com>
In-Reply-To: <20210607173156.5548-2-mario.limonciello@amd.com>
From: Raul Rangel <rrangel@chromium.org>
Date: Mon, 7 Jun 2021 11:38:43 -0600
X-Gmail-Original-Message-ID: <CAHQZ30DXX+H=jPO74wKwsfN2nOgEjdyiUpkR8HWYN1L_EO-ucA@mail.gmail.com>
Message-ID: <CAHQZ30DXX+H=jPO74wKwsfN2nOgEjdyiUpkR8HWYN1L_EO-ucA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] ACPI: Add quirks for AMD Renoir/Lucienne CPUs to
 force the D3 hint
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-acpi@vger.kernel.org, 
 david.e.box@linux.intel.com, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
 Alex Deucher <Alexander.Deucher@amd.com>, 
 Prike Liang <prike.liang@amd.com>, Julian Sikorski <belegdol@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_103900_448950_99649975 
X-CRM114-Status: GOOD (  19.91  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jun 7, 2021 at 11:32 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> AMD systems from Renoir and Lucienne require that the NVME controller
> is put into D3 over a Modern Standby / suspend-to-idle
> cycle.  This is "typically" accomplished using the `StorageD3Enable`
> property in the _DSD, but this property was introduced after many
> of these systems launched and most OEM systems don't have it in
> their BIOS.
>
> On AMD Renoir without these drives going into D3 over suspend-to-idle
> the resume will fail with the NVME controller being reset and a trace
> like this in the kernel logs:
> ```
> [   83.556118] nvme nvme0: I/O 161 QID 2 timeout, aborting
> [   83.556178] nvme nvme0: I/O 162 QID 2 timeout, aborting
> [   83.556187] nvme nvme0: I/O 163 QID 2 timeout, aborting
> [   83.556196] nvme nvme0: I/O 164 QID 2 timeout, aborting
> [   95.332114] nvme nvme0: I/O 25 QID 0 timeout, reset controller
> [   95.332843] nvme nvme0: Abort status: 0x371
> [   95.332852] nvme nvme0: Abort status: 0x371
> [   95.332856] nvme nvme0: Abort status: 0x371
> [   95.332859] nvme nvme0: Abort status: 0x371
> [   95.332909] PM: dpm_run_callback(): pci_pm_resume+0x0/0xe0 returns -16
> [   95.332936] nvme 0000:03:00.0: PM: failed to resume async: error -16
> ```
>
> The Microsoft documentation for StorageD3Enable mentioned that Windows has
> a hardcoded allowlist for D3 support, which was used for these platforms.
> Introduce quirks to hardcode them for Linux as well.
>
> As this property is now "standardized", OEM systems using AMD Cezanne and
> newer APU's have adopted this property, and quirks like this should not be
> necessary.
>
> CC: Julian Sikorski <belegdol@gmail.com>
> CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
> CC: Alexander Deucher <Alexander.Deucher@amd.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Prike Liang <prike.liang@amd.com>
> Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

It's unfortunate these systems have already shipped. I'm guessing they
can't have their firmware updated either. So I guess it's the best
option for now.

Acked-by: Raul E Rangel <rrangel@chromium.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
