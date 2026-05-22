Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A1ECD5BB0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 15:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3+aFvAmkl1XLjFG9oa21EFhMu1CC+zWmNJ2DltYhFFM=; b=HzdDXWJp67shED5k8r0i8dZR4H
	724MExesIuOlPIeWUH0EiubbhZmisgGhQaYjHhtwQlJ1KvL6I+Adh/3ghgBOqGyo2Ah5fEbLKHevq
	DU7+Jf6AJ+WQsrjKzxqTxWpKmhf7oUCftplykOVsFrSS7A8tgrxKorkTStsQ1HrZCT//iz1Dmaglf
	uzUWzoUBmaD4aCFIS51JZc84izCzuvO3baNtAApZbO38WGNRtH08gy/0xx7Ryi3PZRZxzNg30X7ML
	PE/LMilXotgt0fzjW3l6dhHhrJwmD3St8BcrJdCfNKtlTK2F8sDemn3nk1AJpgPM5OtOIr/FeMDt0
	iYJKhXBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQRsk-0000000BGUH-2YpN;
	Fri, 22 May 2026 15:33:50 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQRsg-0000000BGTe-3wtu
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 15:33:48 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-bd21ffaca79so1445758766b.0
        for <linux-nvme@lists.infradead.org>; Fri, 22 May 2026 08:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779464025; cv=none;
        d=google.com; s=arc-20240605;
        b=MV6m2P3ZFrax396km/WvkaG/WjldQ+Gepg3rC1cmAJ/3DKixrfoYedA8j7sh+wTwq9
         OXd/N22GBMTzMEmVe3AEYYS7/MIRvVGRPWGRaSDc12GRv0h+JhmaI5WYx0p3IFlq9ezs
         infXLgG2zEsWYCdJlPK9VSI/+67T4Mx9m5xBYNZ7UFS/OMx5l+Rb0ahMD8Xt0JmUuUeG
         6dM0TArZ9aeu0nakaYP7Z+MUytkC8FqMRju2CtdoMvRPzrxIsqMXQIZG6c34W/mPCY0/
         vd3YSNUPmwVBHseiZl4EgM64q+v3Zs9pR0BZ7r97ga+xktOKObrOJoTacwO3qcoLclVa
         uEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3+aFvAmkl1XLjFG9oa21EFhMu1CC+zWmNJ2DltYhFFM=;
        fh=rbgRdycgeFcIBjzo/zLw1rPAQnUQ6qXpkIU5hqXZn4c=;
        b=bfVqRkfQLdN+ekqyHoCsd7D83ma4NCqVS1QMNna1vSeVXWiO29w1UuOrhHZayXQ94j
         HLnx6HHLq0TFsfh+k4KsFj5DV3Kp0t4N4Rn99sXB6aotsw2nkHtDh7SOJHX/WK6sAinI
         kyGOOcDlk4+x8IZ+ftLayY+RXvXzzLKgLxL+40LkhnXfvsWGn7+hCv+UNu5sZi3UMBA3
         aocUQFEFExCj0DU3MuI3AIxGaN/UlgltG6K3BFHmy8nFlWu5Ym6SsvYUgdOHuototEhJ
         10Ry0tj0HnGGXa/00ikwcb0/LEijArt0qZ6gB/qAs63OTFL/OyTzaU34d9RoJNuHRJfJ
         gP6A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779464025; x=1780068825; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+aFvAmkl1XLjFG9oa21EFhMu1CC+zWmNJ2DltYhFFM=;
        b=HW9ToTTzT+UAoSsVmG34qNGnMFU9+wjtOj3E9ymsOOUlv8y2RHCmqHFanSpWRpOL2c
         wY4R9/Kppr0ta9GYmQmTgtCDqHLRs27lvGh81mx1vWxicR/Q/GEaBXz/lGbllQtNTvmp
         GfINQkY7h4g2QY0+X5BrSxZirALrYUpEk/GourLCudUt/oClwe5A8QFSnr7TN5zcJHT8
         UfxrzR+Yye3C+VSdTpzp4cbIkaoe77IU+qsUS1i5XcWoMagTQAaXc/guDvlUyeVTuY5V
         xe3HDk0YWaanmqGK+OMMtjMtbXt2hsRNyoTsL2Jss2nUzS7M4wIMtweU+qgf7w9/I1iD
         oYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779464025; x=1780068825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3+aFvAmkl1XLjFG9oa21EFhMu1CC+zWmNJ2DltYhFFM=;
        b=eaA1lnM2jYL/ecW97h0NSIJdHsyALEDrZ3D9H6qwQWx0v5I+VVlXjwYEHI5f1EVozm
         9o05uTyc5NbZfMRk79GjK+OZFuYitNKZCM8r/rdK0Zkov6Ayc/GA6L+wKcYRmBRJ/hz5
         0wJbSxuFZVtS2XtH/xM4vDdMe8EXKA/sOoPuNE+e2TLQkTgfubw/IN2ZVxG5Ma6U8Sak
         azIYPq+p4JnEq5U8ObJmRIFeOFfl7VGX4Ur2finsizia38dVo5FtGHySpAHAczxCruaS
         0boyov+DxIV5XpXvNkvZHiGdPBUNo9KGeZx3MQi5AMNJJOODC1jLhK8dpeFs2FSppznT
         gh4w==
X-Forwarded-Encrypted: i=1; AFNElJ9PzwjVjKREPu2aJB3tKm0x35brR1O85W4n9k6T/IFehC/pFqn/SSYhA0nYVn9Izxs2i6NndJYkl2dJ@lists.infradead.org
X-Gm-Message-State: AOJu0YxEb9G7fnR1j/HuwC9rmmQ9e00npS3BQgMB8n6a1tGrKh0SvcFm
	/K6FlK6bMtmr8Vhi4pxi8MqjF3/QlutO5uHOdZ4lnWwDM7hOdBFw6L5ubwOruEVg+ef4wcDDQUX
	loOAjM+ugAQKI9Z9nJdmG2SRKr24hDig=
X-Gm-Gg: Acq92OGZccggJhThptmF+oS9l15SW8MnQhRAOklPsjmCxJxXQhWlQHvB3cFMmKuXlKq
	PCFxlacecAY01qXnsp4NnR0n/S14I7P9RDqpw5qeXrPBbOBwqmk1CSxBG5B3Fh2JeorhDwCZgUK
	VR+GGfePwgfcYIGoOMQ80SeNHhwX3P7g/GkINzUS7PJ51TOXm4UWbCjuOZFFF9focME4gBiZ+pg
	p6EaSIWUjvTQh1tb+nL+WE7gKFgz7HUuokA0BkWP8sMbikzxrbCIaY5Vqyu2ZdZPuMJZiKoc+dY
	LilWXt7dQA2TIDJOtw==
X-Received: by 2002:a17:906:30db:b0:bdc:6e26:aac with SMTP id
 a640c23a62f3a-bdc6e355aa5mr289780166b.27.1779464024977; Fri, 22 May 2026
 08:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260515071248.2689513-1-coshi036@gmail.com> <ag4Y5R1X0gkZbU-g@kbusch-mbp>
 <20260521082549.GA11208@lst.de> <ag8Y5c3sjYFZzan5@kbusch-mbp>
In-Reply-To: <ag8Y5c3sjYFZzan5@kbusch-mbp>
From: Chao S <coshi036@gmail.com>
Date: Fri, 22 May 2026 11:33:32 -0400
X-Gm-Features: AVHnY4JNz-ftHY7WmMJl4LIGZh4hMiECWtD1tprsMAPRoWuPb-g0SR_3q9hlskY
Message-ID: <CACd_6n3iCo-c+BSSYrNzyBHByZGXersnFqSU0Kjf8Y=r7tHFDQ@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: reserve a keep-alive admin tag for all transports
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, 
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>, Maurizio Lombardi <mlombard@arkamax.eu>, 
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>, 
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_083346_994939_B80D39F9 
X-CRM114-Status: GOOD (  23.84  )
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

On Thu, May 21, 2026, Keith Busch wrote:
> This command is already special since we filter for it on the completion
> side. We may want to selectively filter other Set Feature commands too.
> For example, we don't want user space turning on Host Dispersed
> Namespace Support, because this driver is not going to correctly react
> to that one either.

Thank you so much. I agreed.
v3 implements this: a filter in the passthrough path
(nvme_passthru_cmd_allowed) that rejects Set Features commands the
driver is not prepared to handle, returning -EOPNOTSUPP.  It starts
with KATO on non-fabrics and is structured so other features such as
Host Dispersed Namespace Support can be added as needed.

Thanks also for the idle-power-states point - that is now part of the
rationale in the commit message, since an active keep-alive on PCIe
would prevent deeper idle states for no benefit.

Sent as a new series:
  https://lore.kernel.org/linux-nvme/20260522152807.2061501-1-coshi036@gmai=
l.com/

Chao

On Thu, May 21, 2026 at 10:38=E2=80=AFAM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Thu, May 21, 2026 at 10:25:49AM +0200, Christoph Hellwig wrote:
> > On Wed, May 20, 2026 at 02:26:13PM -0600, Keith Busch wrote:
> > > I am skeptical anyone would produce a PCIe device that supports it, b=
ut
> > > let's say someone does: what is the use case motivating enabling this
> > > optional feature in this driver? If it's just because the option is
> > > there, then I think we can just reject the user command submitting th=
e
> > > feature for PCIe transports, like I earlier suggested. Requiring an
> > > active command will just harm idle power states.
> >
> > I don't think that's quite the point.  We'd have to add special
> > filtering to fix the reproducer.  Compared to that just reserving
> > a tag and officially supporting the feature is much easier and a much
> > better story.
>
> This command is already special since we filter for it on the completion
> side. We may want to selectively filter other Set Feature commands too.
> For example, we don't want user space turning on Host Dispersed
> Namespace Support, because this driver is not going to correctly react
> to that one either.

