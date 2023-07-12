Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E807EEB64DD
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 16:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oAuCX7b/d1hbHKp+310Sb1Zp5QGgY2qfzYziff3Pm1c=; b=r+z3+MP1U5ZRRbUIUY6UxmAfZC
	Lf5oQBegwXlhIN9QpbpDGUxzDKRSmdJP41F+iMMGVFtrVCMIrSxxY7FMBGqvvTZPhmmwP+H2ktvwo
	sSIOhuJaTxG0VXVKlL/wfZOg9tsP70PCS+8xdY2WpZ0hswagiwyM/IAps5W8IgMeBQKcCYz2oHEN7
	/5OHidbD51C+LBDrE3rx9vYdHdXrWbN50sna3e9o3hrd415jfmU+ZUNoPEUxFxeNWatl2Zz/qMcjc
	pP5k/+AzOpMxwKq3MyzYEQ0+klmTbjsF0fO3DgdmxmEKLH927WdM4idt4/dzUrQwmbfxWyMpAZhMu
	TcXhX6vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJd4b-000eha-0V;
	Wed, 12 Jul 2023 16:52:17 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJd4Y-000eg3-1V
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 16:52:15 +0000
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso11059032e87.1
        for <linux-nvme@lists.infradead.org>; Wed, 12 Jul 2023 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689180730; x=1691772730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oAuCX7b/d1hbHKp+310Sb1Zp5QGgY2qfzYziff3Pm1c=;
        b=U5ONKyp89d8LjT1vJe3usI67MT+9QxOmfVCOnV8Qu1V72IlaDhrnb03Zsqn440Rr4M
         B2fBHx4diBfDXv+wMUC7thn/86QRjglRTgYGshZRHvXSfInKy4w8SLCg8k7tPgXo0aOw
         FTpHc/9OLYlhJB4h56Lq2MX4SsudXF3Dy0Ws4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689180730; x=1691772730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAuCX7b/d1hbHKp+310Sb1Zp5QGgY2qfzYziff3Pm1c=;
        b=HrmbDvrcdXaGW9G36okDutc1kULHW1WEZyB6RXTDMykh4sLf3+3r2F2/xi11+dhsgc
         gajEaMXXfQWFbI3eVUA1Gv8z0tfvsYL0ONXHH4VrO5gCnBq4vJHCz9a9rOCGEvzNdprV
         lXvlIE9rM1KZq9q9/I7rkjuyQ/LQ++h06GpL0CcbWTcAfHhWnZPw3vDuCwKGHcPJf+vC
         YoPWikcILmZlY3GTjXQ4nGvPgvKoBV1cbUlyQCXxf9y+vQ81clImEIELpHoXD8KDniYB
         9RIXmP+qfPQUPdCqIjz3o4PqyEg69AZlPnA4ZUTUN5X3wKYzqTYyqEo8ze4Q7tMV4Utl
         0apA==
X-Gm-Message-State: ABy/qLY2u7sGnAOB6nK/hDKs65WDRhfray4wlUEl3oS9fVe9BFIkxiBr
	OUOAerfQeiEoQVn5El7FFjTf8q96vPZXItjg9KlDaLPU
X-Google-Smtp-Source: APBJJlHzD7ZiaYKt7FblyI9JlD5cg0g2nhTdIWae4RQZ0n8fbFIv3q1IR5ypy1tCFCBxyyBnbncraQ==
X-Received: by 2002:a05:6512:3253:b0:4fa:5e76:7ad4 with SMTP id c19-20020a056512325300b004fa5e767ad4mr15096568lfr.10.1689180730231;
        Wed, 12 Jul 2023 09:52:10 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id g12-20020ac2538c000000b004fb763b5171sm785473lfh.86.2023.07.12.09.52.09
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 09:52:09 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4fba74870abso11073326e87.0
        for <linux-nvme@lists.infradead.org>; Wed, 12 Jul 2023 09:52:09 -0700 (PDT)
X-Received: by 2002:a05:6512:3090:b0:4f8:4512:c844 with SMTP id
 z16-20020a056512309000b004f84512c844mr19547117lfd.48.1689180728994; Wed, 12
 Jul 2023 09:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com> <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info>
 <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com>
 <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com> <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
 <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info> <20230711120609.GB27050@lst.de>
 <CAHk-=whXh9sgLo24RO02JjfD0m3HE5NADRPWoEd+dW6bruFhVA@mail.gmail.com> <20230712164546.GA31434@lst.de>
In-Reply-To: <20230712164546.GA31434@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 12 Jul 2023 09:51:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whA9rmvNfo=8iKmtimayiA2Aus4XvPwcDrA53G2rfGP0w@mail.gmail.com>
Message-ID: <CAHk-=whA9rmvNfo=8iKmtimayiA2Aus4XvPwcDrA53G2rfGP0w@mail.gmail.com>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
To: Christoph Hellwig <hch@lst.de>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Pankaj Raghav <p.raghav@samsung.com>, 
	Keith Busch <kbusch@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Sagi Grimberg <sagi@grimberg.me>, "Clemens S." <cspringsguth@gmail.com>, 
	Martin Belanger <martin.belanger@dell.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	John Meneghini <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux NVMe <linux-nvme@lists.infradead.org>, 
	Kanchan Joshi <joshi.k@samsung.com>, Javier Gonzalez <javier.gonz@samsung.com>, 
	=?UTF-8?B?67CV7KeE7ZmY?= <jh.i.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_095214_502512_DB26E204 
X-CRM114-Status: GOOD (  14.61  )
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

On Wed, 12 Jul 2023 at 09:45, Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jul 11, 2023 at 09:47:00AM -0700, Linus Torvalds wrote:
>
> > and we have NEVER EVER seen devices with reliably unique IDs. Really.
>
> Sorry, but that's bullshit.

Christoph, you are *literally* involved in a discussion where this is the case.

What you call "bullshit" is what everybody else here calls REALITY.

The fact that *some* devices have serial numbers in no way implies
that all of them do.

And if you think that they all do, you are the problem. Literally in this case.

So you had better really internalize this "there are no reliable
serial numbers in general". Because it's simply a FACT.

> Well, let's try something like this (co-developed with Sagi) that
> allows it for non-multipath PCIe devices, which covers the quirks
> we've added so far, but also add a big fat warning, because we know
> people rely on the /dev/disk/by-id/ links.  Probably not on these
> devices, but who knows.

Looks sane to me.

          Linus

