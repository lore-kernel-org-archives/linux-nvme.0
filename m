Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72850EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 16:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oMWZAChJYV60SmdxsBdiqmGcST+PLRNcYlCxSrWksj0=; b=BV8ZSl5DvpwQDUNk1HwRnB4Bwi
	IheuIzwQReoiokNWzIvt+yr9byAANrVv78GgDa0alEYMEFfOdfBGIRzUfz7t2/tbaVAdTSHaHgbTA
	G+6cSL8c6oEMWBvBoH2bxccOLnW5kCKtSxzmA/dAwre2Jprq80FNaIM2XjDeSGVkPABtAWlFhLBM3
	sYnM5mNZe2etqVxaLFJYAl7Y4NHskvMsRKJ+Nya+ewa+518J0hYAiY5642IKWOid1NeQ3Mps+5XQw
	COp2+402kdzF2ti1jz47rYj3duaA2ZH2CURs1RLG14fx8Ewxe5tljoQL/57ardKTrJuxFBVc1ooV+
	yPlXy4SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJd1L-000e6z-1m;
	Wed, 12 Jul 2023 16:48:55 +0000
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJd1I-000e4i-15
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 16:48:53 +0000
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b701e1c80fso112779101fa.2
        for <linux-nvme@lists.infradead.org>; Wed, 12 Jul 2023 09:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689180526; x=1691772526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oMWZAChJYV60SmdxsBdiqmGcST+PLRNcYlCxSrWksj0=;
        b=OzIG9tcyjgiGDx/eybshSZrStq6XkAy1tOVGAZJnYDCqAuqjbELpkAm+QygN3K3LyI
         yY5XB8rHmVGuYATmMmnbyGdr5UhoGnwayQro5d5X0axCA2PjYCuHWXXwcuENyzDB6tm8
         Bti8kw4mcTNRjy1eWXnICvnGuhDr4Jg7RnaCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689180526; x=1691772526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMWZAChJYV60SmdxsBdiqmGcST+PLRNcYlCxSrWksj0=;
        b=eLgXCkRkAsSAXw9V0NdkTPuClb5aGWzLP5bMQO32enKgHmlXiPd5k4HE1AFGtdYGKV
         0yUHwIxvF+7Yf///yxPz+XWeVfyMTSZYnpbjyRM6tBd600rERBs2DZHiXUj5jRLIEJVk
         J4+zsWiBC6j/j3LiO9Eb7gc9fynJjVn4aNe+RPDLBsCUr8wwrt41wFwfO3IVD3wiA98L
         y/fvNBgQXX66GVdE9HUn6yu1mnhfpZEq05YWpvHngRI8k4xQYJNIcF8R/c0j7xcqDsdU
         d6DchvCM9DzBNDctRvZhgWEdHNIDpBPJiOodMpIFHRY/0nB/IargbscaXl+3kZhMfvoF
         uu0Q==
X-Gm-Message-State: ABy/qLa1GUrEi/qAAY+2rX8tLmJhV8e06nAGPt0PdpKLV4UsZvlCFqNX
	5ws6FIW3NrRiS0dir6y2LMWULSSH25haDtorQCMZGkx7
X-Google-Smtp-Source: APBJJlE8xgA67kTjdA+GB+r9Jiy111GkDzvTJXDs6wJ8u+Tnc02EUJif+KnMVOUOqFDVyY8TNXZ5AQ==
X-Received: by 2002:a2e:890a:0:b0:2b6:d6e1:a191 with SMTP id d10-20020a2e890a000000b002b6d6e1a191mr16328441lji.23.1689180526440;
        Wed, 12 Jul 2023 09:48:46 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id h23-20020a2eb0f7000000b002b47a15a2eesm1035442ljl.45.2023.07.12.09.48.45
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 09:48:46 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so11588959e87.3
        for <linux-nvme@lists.infradead.org>; Wed, 12 Jul 2023 09:48:45 -0700 (PDT)
X-Received: by 2002:ac2:5f01:0:b0:4fa:6d62:9219 with SMTP id
 1-20020ac25f01000000b004fa6d629219mr14025309lfq.62.1689180525640; Wed, 12 Jul
 2023 09:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com> <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info>
 <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com>
 <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com> <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
 <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info> <20230711120609.GB27050@lst.de>
 <CAHk-=whXh9sgLo24RO02JjfD0m3HE5NADRPWoEd+dW6bruFhVA@mail.gmail.com>
 <ZK2PgNizcMLW+S/V@kbusch-mbp.dhcp.thefacebook.com> <f0e8de7b-655c-9932-16d4-105decff9a6c@grimberg.me>
In-Reply-To: <f0e8de7b-655c-9932-16d4-105decff9a6c@grimberg.me>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 12 Jul 2023 09:48:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhGcG5vuzWMOpy0fE6MYD6V_H7aWLU1wf=RSJV8y=9FA@mail.gmail.com>
Message-ID: <CAHk-=whhGcG5vuzWMOpy0fE6MYD6V_H7aWLU1wf=RSJV8y=9FA@mail.gmail.com>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Pankaj Raghav <p.raghav@samsung.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	"Clemens S." <cspringsguth@gmail.com>, Martin Belanger <martin.belanger@dell.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, John Meneghini <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux NVMe <linux-nvme@lists.infradead.org>, 
	Kanchan Joshi <joshi.k@samsung.com>, Javier Gonzalez <javier.gonz@samsung.com>, 
	=?UTF-8?B?67CV7KeE7ZmY?= <jh.i.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_094852_393358_2C9A8773 
X-CRM114-Status: GOOD (  19.62  )
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

On Wed, 12 Jul 2023 at 00:38, Sagi Grimberg <sagi@grimberg.me> wrote:
>
> Perhaps we could fallback to what we do in wwid_show()?
>
> "nvme.%04x-%*phN-%*phN-%08x\n", subsys->vendor_id, serial_len,
> subsys->serial, model_len, subsys->model, head->ns_id)

That's not going to be any more unique.

Yes, there is *slightly* more hope that a simpler "serial number"
might be different between devices, but honestly, when I told
Christoph to learn from history and not assume UUID's are unique for
hardware, that "history" is literally decades of serial numbers.

Why do you think things like dm/md generate the UUID and literally
write it to disk? It's because those unique serial numbers have never
ever existed.

And absolutely NONE OF THIS IS NEW. This is not a nvme issue. SCSI
disks allegedly has a VPD page 0x80 with a serial number. Not only
won't many devices report that VPD in the first place, even if they do
there's no guarantee that it's actually unique.

And USB devices are *supposed* to have unique device serial numbers
("iSerial"). I think it's literally been in the spec since day#1. And
some even do. Quite a lot absolutely do NOT.

It's just fundamentally cheaper for hardware manufacturers that do
mass manufacturing to do completely identical pieces of hardware.
Serial numbers and UUID's are _fundamentally_ hard and expensive at
some level.

If you sell overpriced garbage to enterprise users, then a serial
number or UUID will most definitely be part of the package. Because
that is _literally_ what "Enterprise hardware" means: "Overpriced
garbage with a provenance and somebody else to blame".

But if you sell to the mass market, and aren't going for people who
pay extra for provenance, a serial number or a UUID is pure overhead.

Sometimes it's easy enough to do, and people do it.

But if you *rely* on it, *you* are the problem. Not the vendor that
was churning out a million devices for real users, and that was
spending all the effort on just making it work.

Basically, I think all of these things are purely for fabrics and the
nvme target side.

Expecting serial numbers from a PCIe device is pure fantasy.

And, more importantly, it's stupid and wrong. Exactly because we've
been here before. Don't repeat mistakes from the past.

By all means _report_ things like serial numbers. They can be very
useful for tracking. But never *ever* rely on them for basic
functionality. People absolutely will have two identical devices from
the same batch, and unless there is some actual hardware compliance
verification, they will not have unique serial numbers.

In many cases, the best you can hope for is that the duplicate ones
are *obviously* duplicate (ie "all zeroes" and similar). But you
shouldn't expect or depend on even that to be the case.

             Linus

