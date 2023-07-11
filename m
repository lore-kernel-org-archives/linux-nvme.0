Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DF4EB64DC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 16:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U2CJtNA/0mITyVD5x12gejKNioPrhHv1tiOXdLtkt0Q=; b=2Bv+sCZ8iXw6CzgLqxUFV/DKm+
	3RE5ZVapYXt7YjUBdeHzvhG5+M8OLTw5RJT4iICaear2pKZWiysCjNovWUqKOlrX9bGne3/aJX0I7
	q69x+ONnk34No1W3ZzBpF3+BbeTFF58Dzjxs6UWV8fMa0krVhQ/A8x/8WDbYWOp37+sbKV3DySrxX
	4M1hz/7Jg2AihjJz+WSxT5GBL/cnpDJ/47cf5izrCNwj+1mx3sdZeaBBsqNc9kDl/Ik/8b9N7KUce
	Fxz8LeZH6BQgLE/Js70XJRMjxJHi5qDulap6liVppAVDm03gVl+9BVkKVryRcfwfDJoFxz3tYBbg0
	lJmNpmfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJGWK-00FRKz-2o;
	Tue, 11 Jul 2023 16:47:24 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJGWH-00FRK2-2J
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 16:47:23 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99384a80af7so685200366b.2
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jul 2023 09:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689094039; x=1691686039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U2CJtNA/0mITyVD5x12gejKNioPrhHv1tiOXdLtkt0Q=;
        b=N6lUfM9xyDBFSEOwcDGoOztLFxWfJrlE21PVgUyc+Ew8kndlrMvq8Jt1zCTDN6Zj3M
         96vw1X6PlwkUYaxos886m25KGTwo4b0mm3CVObOQF9L6eBJ7vWBFBRvkOXDxQlouVjN8
         oZQS8Dsh4yqPdQmdrJIrG0HbZz0njCs1v8LJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689094039; x=1691686039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2CJtNA/0mITyVD5x12gejKNioPrhHv1tiOXdLtkt0Q=;
        b=g4R6pn96ssEOVNKpwGrAm6vVzRuJLuH1ZEzNP2C1F3oz4rKM4nxMkmhBLElLpBAIox
         FeJPqoWJ1dtnqnTT+yKPzTEhULRZA4MCZq2fR5W7+LfpqZ4ucByAEUuYOqQlrKK5rx6i
         6s/e4/giTm91b2TQxMw8P9HfFqzGoWkHQ6gFBKZupra2E0T5BU74tjg4+XWqZaPK188P
         k/CbTvGQDE1FDxca8V5dHz2YtTeM7DwbL8p0mlWNI5csyE/TzHuAcC9DcEbEH9LaH1x/
         Oo2FJ4L9L6eeEJmSj8dd/UfXZqqm00uN+D6ZEGpDJdk2Lr0Fmc7sFHkFa8GgqeRkscF/
         RmIg==
X-Gm-Message-State: ABy/qLZPcIKCCPJZJ4wfwlaVCQ+NcAt5qnUFgHba9pcyJHw/7dLCErSE
	ZWCp0+SLblUBFVq8qDTyfHa5n3K/UMp5IJ+x8ytYFzHu
X-Google-Smtp-Source: APBJJlGVwtwZ0wnFicVsgAcEq8JBYGqdiJ1bmJMAhAsADMzcwfrSxEoeBLcgfHx2PbOazg8VeOUP/Q==
X-Received: by 2002:a17:906:17c9:b0:974:1838:88d8 with SMTP id u9-20020a17090617c900b00974183888d8mr13252394eje.57.1689094038913;
        Tue, 11 Jul 2023 09:47:18 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00992eabc0ad8sm1387466ejt.42.2023.07.11.09.47.18
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 09:47:18 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso7257265a12.3
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jul 2023 09:47:18 -0700 (PDT)
X-Received: by 2002:aa7:d052:0:b0:51e:2a57:1d93 with SMTP id
 n18-20020aa7d052000000b0051e2a571d93mr13616464edo.16.1689094037813; Tue, 11
 Jul 2023 09:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com> <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info>
 <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com>
 <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com> <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
 <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info> <20230711120609.GB27050@lst.de>
In-Reply-To: <20230711120609.GB27050@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 11 Jul 2023 09:47:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXh9sgLo24RO02JjfD0m3HE5NADRPWoEd+dW6bruFhVA@mail.gmail.com>
Message-ID: <CAHk-=whXh9sgLo24RO02JjfD0m3HE5NADRPWoEd+dW6bruFhVA@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20230711_094721_781194_7EEDC7B5 
X-CRM114-Status: GOOD (  23.04  )
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

On Tue, 11 Jul 2023 at 05:06, Christoph Hellwig <hch@lst.de> wrote:
>
> As far as I can tell Windows completely ignores the IDs.  Which, looking
> back, I'd love to be able to do as well, but they are already used
> by udev for the /dev/disk/by-id/ links.   Those are usually not used
> on desktop systems, as they use the file system labels and UUIDs, but
> that doesn't work for non-file system uses.

The thing is, the nvme code seems to actively do completely stuipid
things in this area.

> And all this has been working really well with the good old enterprise
> SSDs, it's just that the cheap consumer devices keep f*cking it up.

Christoph, deal with reality, not with what you think things should look like.

Anybody who expected unique ID's is frankly completely incompetent.
People should have *known* not to do this.

 "Those Who Do Not Learn History Are Doomed To Repeat It"
          - Santayana

and we have NEVER EVER seen devices with reliably unique IDs. Really.
We've had these uuid's before (ask Greg about USB devices one day, and
that was *recent*).

We've always known that vendors will fill in a fixed value, and
somebody still decided to make this a correctness issue?

Christoph, don't blame vendors. Somebody did indeed f*ck up.  But it was you.

> If we'd take it away now we'd break existing users, which puts us between
> a rock and a hard place.

Well, here's a suggestion: stop making it worse.

For example, we have this completely unacceptable garbage:

        ret = nvme_global_check_duplicate_ids(ctrl->subsys, &info->ids);
        if (ret) {
                dev_err(ctrl->device,
                        "globally duplicate IDs for nsid %d\n", info->nsid);
                nvme_print_device_info(ctrl);
                return ret;
        }

iow, the code even checks for and *notices* that there are duplicate
IDs, and what does it do? It then errors out.

Then expecting people TO WAIT FOR A NEW KERNEL VERSION when you
noticed something wrong? What an absolute crock.

So stop blaming anybody else.

I think the code should *default* to "unreliable uuid", and then if
you're sure it's actually ok, then you use it. Then some rare
enterprise user with multipathing  - who is going to be very very
careful about which device to use anyway - can use the "approved
list".

Or "Oh, I noticed a non-unique UUID, let me generate one for you based
on physical location".

But this "my disk doesn't work in v6.0 and later because some clown
added a duplicate check that shouldn't be there" is not a good thing
to then try to make excuses for.

            Linus

