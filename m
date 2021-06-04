Return-Path: <SRS0=9AXB=K6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE18C4743E
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jun 2021 17:03:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92837613F8
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jun 2021 17:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92837613F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ERX2s30MtvtJ5XUyDij44vpncjM7k9s9rhO3WsH2SyU=; b=V1YTMDY6JyvXPW
	U0BCDlYBlnJA96DYpXwmcQ7ZLJkzM4RjYygvU9sbVD7yPnyRYeeOIt6foSc10mOGNf+/5TjDNH5Co
	x6xZZVNMBmCFmn/6wayXyI4naC9lCl51JKhuJPSyvxqCbn1NbnrlvtNICBG7IaatKJWMd1LWAUogi
	YgptDz4RxJcpCsdyOkQd5ANTRK1ZdrjIMNeIUj6VnGW8lxqasaz+NaWu9PJ/IlpZx8+U1BZ/PcZXW
	6dt1B9hrj+HNbclNcZmxHCVTNEDqyUhUgdhuECq68e/zjQLb9WxEF9iQM3chp7V4Wu+OTiYxqiK8e
	OG+5LxePdWa/U7fNVYXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lpDEQ-00EVeK-9y; Fri, 04 Jun 2021 17:03:38 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lpDEA-00EVbP-Lo
 for linux-nvme@lists.infradead.org; Fri, 04 Jun 2021 17:03:27 +0000
Received: by mail-ej1-x62b.google.com with SMTP id h24so15591012ejy.2
 for <linux-nvme@lists.infradead.org>; Fri, 04 Jun 2021 10:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hq4SLEuuP8OvsxIwZ6jr2msikPiKZx06r8wHUFyD0es=;
 b=XiWOMxbuIbcUdCPVeHIHSNXstmy2V/O86RerPh6KTf+jyrdvgSTXDTV4JROfPAnZ7X
 7TF7svwa+hNQOsshwP8G+31pCYfplgJZADKr2lEHL2amnrxsMFiy0s/Pedi4WnsupgZ9
 c6q5F+dClAvdcXfgKYEFcYDNZww+uKCTPbblQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hq4SLEuuP8OvsxIwZ6jr2msikPiKZx06r8wHUFyD0es=;
 b=jEi6do5oxepCjNyTv7FeqrPayCqxRm3RN8pXCUzvr30jr79rROXEWXrsYMRLxqCc0/
 Yt5g9d19jUityXEVbbU6oRNRmVXUECx9Tbhk5tK5qZiKbIj1F0IaMylyG5jHLkw9ZY5f
 94SosD33/wsT78hZubwS1nZIXnwiL1BzfopGZPGtTbAvQwZ2V7vTD11wL4qMrXbkQrGd
 Vx3MhogXrSptQNdfV549hqBfRt+ZhAu8kFQdAsBpv+/BP6875j47mRo6e9NiNBTj7NGM
 LK7WAOoKjaWv610j0CG/gQm4VoJlzIfCA13dwHD9D/us4+uPL5aG2Lu+vkyT9Hm4RQef
 62EA==
X-Gm-Message-State: AOAM532pHb/dX7WQqDoqRzJ3NL3cEEx0wf4U7ImfRM/6x6RnMuKkElqR
 7IziB3BDKQf0jxPMu6P04rXqR7H1mdGphJ4f
X-Google-Smtp-Source: ABdhPJzogJwq2PeKtVsEDihRyglOmZCfLGHRP0O/dJKkbTEpltJYw4bEcXNxs1Bms7yVRXuPijg6jg==
X-Received: by 2002:a17:907:c0d:: with SMTP id
 ga13mr438399ejc.325.1622826199863; 
 Fri, 04 Jun 2021 10:03:19 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com.
 [209.85.218.49])
 by smtp.gmail.com with ESMTPSA id c11sm3567454edr.80.2021.06.04.10.03.18
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jun 2021 10:03:19 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id jt22so15553548ejb.7
 for <linux-nvme@lists.infradead.org>; Fri, 04 Jun 2021 10:03:18 -0700 (PDT)
X-Received: by 2002:a17:906:7fc5:: with SMTP id
 r5mr5288436ejs.474.1622826198524; 
 Fri, 04 Jun 2021 10:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210604165403.2317-1-mario.limonciello@amd.com>
In-Reply-To: <20210604165403.2317-1-mario.limonciello@amd.com>
From: Raul Rangel <rrangel@chromium.org>
Date: Fri, 4 Jun 2021 11:03:07 -0600
X-Gmail-Original-Message-ID: <CAHQZ30B9niNnqPEi5XMjjiVv+N-GAeBOC0jk20owz3UZRyT4Gg@mail.gmail.com>
Message-ID: <CAHQZ30B9niNnqPEi5XMjjiVv+N-GAeBOC0jk20owz3UZRyT4Gg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] acpi: PM: Move check for _DSD StorageD3Enable
 property to acpi
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-acpi@vger.kernel.org, 
 david.e.box@linux.intel.com, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Alex Deucher <Alexander.Deucher@amd.com>, Prike Liang <prike.liang@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210604_100322_754218_210C0AD8 
X-CRM114-Status: GOOD (  15.32  )
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

On Fri, Jun 4, 2021 at 10:54 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Although first implemented for NVME, this check may be usable by
> other drivers as well. Microsoft's specification explicitly mentions
> that is may be usable by SATA and AHCI devices.  Google also indicates
> that they have used this with SDHCI in a downstream kernel tree that
> a user can plug a storage device into.
>
> Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> Suggested-by: Keith Busch <kbusch@kernel.org>
> CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
> CC: Alexander Deucher <Alexander.Deucher@amd.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Prike Liang <prike.liang@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/device_pm.c | 25 +++++++++++++++++++++++++
>  drivers/nvme/host/pci.c  | 28 +---------------------------
>  include/linux/acpi.h     |  5 +++++
>  3 files changed, 31 insertions(+), 27 deletions(-)
>
> Changes from v4->v5:
>  * Correct extra "Link:" word in commit message
>

Acked-by: Raul E Rangel <rrangel@chromium.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
