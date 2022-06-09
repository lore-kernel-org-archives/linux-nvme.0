Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A64FC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jun 2022 08:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HTw/gzxaEhLz0nOO9Yj7AYPfaN2PQMST+llLMdzvydw=; b=zxmuW1lIMW8GHnsbE9HsS/1nx0
	VyO1L9vhIe3PYpBkiLflKjQVsA8+0MnayG0tcf6n8dQPcIrWKuO2jz79vr2smlTjoMZjYT+YZN5E5
	OGCE5XKt9Sh3aVUQa1FV7lQIc4donKLqMYwC23HDTkX8A9dBABeGDZg47EGEPD8E4IneHoM8VO6Ue
	f8WE9Cm4ES+AeGmzA/LLHknDxTiE77s3hyovWLbp7RBMTyVQArAyH7srKQ8Xr/f2G2AyTLywDyppf
	GhE2ERnRcIxoE95LGJlAddqBFEjzQ6leCtGJsnWwmQSHwg+Cb4UqUV0r9qsVrbJ6V7nc9b09aIEVA
	NekGhtkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzDPX-000C5m-S2; Thu, 09 Jun 2022 08:20:59 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzDPV-000C1N-AC
	for linux-nvme@lists.infradead.org; Thu, 09 Jun 2022 08:20:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 350186123E
	for <linux-nvme@lists.infradead.org>; Thu,  9 Jun 2022 08:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A6EC34114
	for <linux-nvme@lists.infradead.org>; Thu,  9 Jun 2022 08:20:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EYtWQSgb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1654762845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HTw/gzxaEhLz0nOO9Yj7AYPfaN2PQMST+llLMdzvydw=;
	b=EYtWQSgbPAUzIQ2wOciMa+e2kTiux9AzFT975Rk5Sjd67oALzPSbeAwjjwrtU/pphEZeKN
	H/auFZ50/S3m1XKEliNuIetYpeX31YgK/vH6+2v5wKBjtSYASBj4hVuNyZ8wX3sDdh/xFF
	6K/ANd16GVjNVWMfWzk7NKJoVul7C8g=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id de7d763e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
	for <linux-nvme@lists.infradead.org>;
	Thu, 9 Jun 2022 08:20:45 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id r1so11947317ybd.4
        for <linux-nvme@lists.infradead.org>; Thu, 09 Jun 2022 01:20:44 -0700 (PDT)
X-Gm-Message-State: AOAM5326uPe4eZovZtaFYDb7fkFy+WLBb6qCpUZmKphdGw3tTWuJGCzb
	anMsV/mkpThpURsPYcxTiHuUf3cA7dNIHHN2HuE=
X-Google-Smtp-Source: ABdhPJwavQ6tDj1c3W2gP6rzri/NSuiXE0/Aiadbq+tXb2epGwQOC3X2d2qK5Top6IhY7jfK/xTXrPuTTgE/QZt/DZ8=
X-Received: by 2002:a25:83c2:0:b0:65c:bc75:800b with SMTP id
 v2-20020a2583c2000000b0065cbc75800bmr38694681ybm.373.1654762844293; Thu, 09
 Jun 2022 01:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <Ykyf5Zuz1W8yHhNY@zx2c4.com>
In-Reply-To: <Ykyf5Zuz1W8yHhNY@zx2c4.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 9 Jun 2022 10:20:33 +0200
X-Gmail-Original-Message-ID: <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
Message-ID: <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
Subject: 2 second nvme initialization delay regression in 5.18 [Was: Re: [bug
 report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR observed
 during blktests]
To: Yi Zhang <yi.zhang@redhat.com>, alan.adamson@oracle.com
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220609_012057_432455_601BAC13 
X-CRM114-Status: GOOD (  11.99  )
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

Hi folks,

On Tue, Apr 5, 2022 at 10:00 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Using a Samsung SSD 970 EVO Plus 2TB, firmware version 2B2QEXM7, in case
> that's useful info.
>
> I also noticed a ~2 second boot delay on 5.18-rc1:

Just FYI, I am still seeing this delay in 5.19-rc1.

Boot lines from 5.17:

[    0.882680] nvme nvme1: missing or invalid SUBNQN field.
[    0.882719] nvme nvme1: Shutdown timeout set to 10 seconds
[    0.885227] nvme nvme1: 8/0/0 default/read/poll queues
[    0.887910]  nvme1n1: p1 p2 p3
[    0.888317] nvme nvme0: missing or invalid SUBNQN field.
[    0.888361] nvme nvme0: Shutdown timeout set to 8 seconds
[    0.906301] nvme nvme0: 16/0/0 default/read/poll queues
[    0.910087]  nvme0n1: p1 p2

Boot lines from 5.18 & 5.19:

[    0.846827] nvme nvme1: missing or invalid SUBNQN field.
[    0.846857] nvme nvme1: Shutdown timeout set to 10 seconds
[    0.849043] nvme nvme1: 8/0/0 default/read/poll queues
[    0.851595]  nvme1n1: p1 p2 p3
[    3.226962] nvme nvme0: Shutdown timeout set to 8 seconds
[    3.253890] nvme nvme0: 16/0/0 default/read/poll queues
[    3.263778]  nvme0n1: p1 p2

The Samsung 970 EVO Plus has a ~2 second delay that wasn't there in 5.17.

Any idea what's going on?

Thanks,
Jason

