Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A718C02185
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 06:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DeeXX8V4qNCj/nNIFb72otntWdvZMUjv7VKrUZtiTyM=; b=hMANMpcMn/NYR4pD1uWmC/Dbi0
	8k5mKIGgoETB4e7/trgFvp2RfARUWPxNyFuplWUIXvw8kRr3F43KzZLsRCdtsqZPy6U4VKEaz5/PK
	u4tp/eQqHftTjZT0APOXjevAiB983QT1CFP898Kyi0DfbIXviDadAJ7BPY+otsSFfIOHWeOsBl3vH
	fnzLOCMUzfYeEvcxpVhnWNNydi4n560dLzocSKJ/nw9jf8RNvl2j3gwpXFzAFGbpH5FRjwlLOdNrZ
	AtGF2qRwOkHZGu5oa48dp6I74296v//oFWhy5syaP6XQqNujd5rL0Wr45ZHUwJ4ORYhiVtpncBJVs
	qRR6ScQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXx3G-0000000ApE2-0P4g;
	Wed, 15 Jan 2025 06:38:54 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXx2O-0000000Aoy8-2isN
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 06:38:01 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-21675fd60feso139859015ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 14 Jan 2025 22:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736923079; x=1737527879; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DeeXX8V4qNCj/nNIFb72otntWdvZMUjv7VKrUZtiTyM=;
        b=OcZhxXF6TN0x9IBeLbKad0YJIs2+wrE0Rj4p2DOj/toIO17TsdPaHzQdmKXCJLXoXn
         FZVqwsZ9FOZKQLPUofauL26o3AkgC8dwtmUc2f8Rx8OZ2x8Qop6UfOsw5/LFdwUTDrcn
         kcYh451a1gFLBvnfuD62PQ6Oil9glawvjwguj4rlkOfMuq5jT23xw19RPZ+ho+Gi2YBz
         Qxv/Sl2vUBOH/8brCJhrqXXYYjvAETAWaGuDBda+PL+xvqAQUzibL8qCbwchDZ3DJy1M
         PEuCmqJVKwIuc6APl7iL2mYq35APBuiCP3VUOaBTJSlejgv1QyTZeguwK9rpSkY404ky
         FJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736923079; x=1737527879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DeeXX8V4qNCj/nNIFb72otntWdvZMUjv7VKrUZtiTyM=;
        b=wcifIxwL9FJdF9qbHo8QC2svunluxvWuPuPbzrIEH+qA7z4s0XBdr/yU2TvZoYBcaY
         P6zoP4+S0+/7XyQOaDEuxCG7+JL+9YNmMb08clHlf7PLC+Sem8gUzBXzrYEB12Tj+ll6
         FSA6HwMWqsL0hTRC1+u4W5EAjZcnsWp+/cgOyU9DkrDBoWCM5jB5K8/nfrHE9OgHLawX
         hm56XtoL3GsNPUwBwE/6/ebN1pReTkxs2GOT/GM2Bd2Bx6pav6l30ZXMK94p8hho1WgA
         QIcjrYnTywO9FyrbQR8pj0EFduqE3fQTGty/5eVUMLLzaUUpIs2QlPXUIR4h1mIaRMjG
         2AkA==
X-Forwarded-Encrypted: i=1; AJvYcCUOf2mH0AIhjI1qOYpMDQ/MGOfN3PdAN1+ckuexfbxezc1cYj4JRLXSy+bhAkQs2tqXncTOsMBmQI7S@lists.infradead.org
X-Gm-Message-State: AOJu0Yzlh7qW36QS39OWavk/hbwfsZptSL6YbRFWQgFDqtsETkOt8/EV
	GrZJf19JkowWm1+smQk6wuSADe5zDyduld9ib372kuuwBjJ2XzS738U3wcFTrUe4DmwCXg1qloj
	fCpnpOM+5LArvBr+l6ax1wJgEK1M1h4aGA1Y=
X-Gm-Gg: ASbGnctAftc7wIfBYXw6hNnYGRsNRRi2bvPnj4VEsYoposrUoqF8dtbqwuIC/HEvABz
	T9qnSMf3uVi88sjp+BP2nhqAbJPILbXluyDDGmpwe1fTjxa6u6hJWLXZ9Uev7q/R2dGTv
X-Google-Smtp-Source: AGHT+IEtlsZBoTLyH7bctfVhdE3Hgj0ldBoJBXJMa3OO6Cm5zOvn5pt4QNw+F1gkxmQZcLOAvuOEOGIjk+k0xKPLEmw=
X-Received: by 2002:a17:902:c406:b0:215:3fb9:5201 with SMTP id
 d9443c01a7336-21a83fe4b43mr463249525ad.44.1736923079279; Tue, 14 Jan 2025
 22:37:59 -0800 (PST)
MIME-Version: 1.0
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
 <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info> <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
In-Reply-To: <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
From: Bruno Gravato <bgravato@gmail.com>
Date: Wed, 15 Jan 2025 06:37:42 +0000
X-Gm-Features: AbW1kvaUsKoAjd4YX0symRsTqpgY7AJbLMSkdBzJvPBjtNC_gann497SFL8XyWQ
Message-ID: <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: Stefan <linux-kernel@simg.de>
Cc: Keith Busch <kbusch@kernel.org>, bugzilla-daemon@kernel.org, 
	Adrian Huang <ahuang12@lenovo.com>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, linux-nvme@lists.infradead.org, 
	Jens Axboe <axboe@fb.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_223800_689665_1C70D314 
X-CRM114-Status: GOOD (  11.87  )
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

I finally got the chance to run some more tests with some interesting
and unexpected results...

I put another disk (WD Black SN750) in the main M.2 slot (the
problematic one), but kept my main disk (Solidigm P44 Pro) in the
secondary M.2 slot (where it doesn't have any issues).
I rerun my test: step 1) copy a large number of files to the WD disk
(main slot), step 2) run btrfs scrub on it and expect some checksum
errors
To my surprise there were no errors!
I tried it twice with different kernels (6.2.6 and 6.11.5) and booting
from either disk (I have linux installations on both).
Still no errors.

I then removed the Solidigm disk from the secondary and kept the WD
disk in the main M.2 slot.
Rerun my tests (on kernel 6.11.5) and bang! btrfs scrub now detected
quite a few checksum errors!

I then tried disabling volatile write cache with "nvme set-feature
/dev/nvme0 -f 6 -v 0"
"nvme get-feature /dev/nvme0 -f 6" confirmed it was disabled, but
/sys/block/nvme0n1/queue/fua still showed 1... Was that supposed to
turn into 0?

I re-run my test, but I still got checksum errors on btrfs scrub. So
disabling volatile write cache (assuming I did it correctly) didn't
make a difference in my case.

I put the Solidigm disk back into the secondary slot, booted and rerun
the test on the WD disk (main slot) just to be triple sure and still
no errors.

So it looks like the corruption only happens if only the main M.2 slot
is occupied and the secondary M.2 slot is free.
With two nvme disks (one on each M.2 slot), there were no errors at all.

Stefan, did you ever try running your tests with 2 nvme disks
installed on both slots? Or did you use only one slot at a time?


Bruno

