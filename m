Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD4BC0015E
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 17:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KC5NZX32e9wpP9t7OccUoxNgiPdVaAw53ZnY1DABzIo=; b=4wAQam2tBz96Cec4ERo59PLMqB
	4l5bAk9wlIuE9i5etfU/QwuAb26IzSrT4RkfzR0pitH2Iz2F9N5W/8rD3MQFrq5QTcHBrffERlmJA
	VhsJrCi+81FLx48MQIiSUyyx8z7Akpu7DTTXy0yTQyp6+qa6veWdyfXAzDLlEIAxklWKaKWlVwhLE
	giG0Fl+++FD5H5SDO5Xfy6EkYKrQN8a/QXfdpzj5K38M+qOfxyV7Lf/64wVjhAX48NqNWqffRv/AG
	9CEwWSpf08WiF0GUjJoIP7hx/NGc2t1le6PUkanIgndj1YVjyVqsFvUUWMt7LU8nnc4ifQGwovkAC
	VmSbFtHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJdjT-000mVX-1N;
	Wed, 12 Jul 2023 17:34:31 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJdjR-000mUS-06
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 17:34:30 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-977e0fbd742so903824866b.2
        for <linux-nvme@lists.infradead.org>; Wed, 12 Jul 2023 10:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689183264; x=1691775264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KC5NZX32e9wpP9t7OccUoxNgiPdVaAw53ZnY1DABzIo=;
        b=V5ei7qNp77i5LTBoJFTJBlueVE62Zfg06qBd0j+zE8znnYY9LXT/fYSf1p95hiyxQW
         2lYLhSVEEhldICudGrrNlWo0o6dw1coTWb/UQjMpL6ua6nGPz6RSZ43NaBi8S1T5Hs4w
         KZhaSW/RMSIpEHO+VxPp5rwa+kr3FA/3RaW34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689183264; x=1691775264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KC5NZX32e9wpP9t7OccUoxNgiPdVaAw53ZnY1DABzIo=;
        b=P4MOeFurRJUY3MhJwXHC6hHf7zfnqpZWV9neBNno/jmG8ZyeUt2liHOkAFW7yQ7eV/
         ZBRrTc2kRtFoIe2l62bVYqVEe0IzNkpdeWBUUj02YJcnDT+O9banS+gju3ezt/fdOsJR
         aQVLdTz7yqmg1wIYBlhZluj6QGOpf6FPme9uS0mIqXuHN+GL6y1/Tq28S5jZZ26ShuAa
         tHgXeQT5eIOQTjbqyuooZoxHp4K6RNLF8GFNeIipmu9syDDNHRbdu4k3QvrHNQrvPtif
         UBBvqmd3vWKIfrXZlX3sTEgz7uklHv/DMMY1bb+/d3vehRygJmjeK+3dsswrhhsWLYyN
         iHsA==
X-Gm-Message-State: ABy/qLYAdME4112T01TySSyyXwXr6292mdfXnSbbR1b1FWSJ0weHBKdb
	WGQzuMBJH7nuSvkGP9RAbqKc/6rYIf2wcnRroneAVIU6
X-Google-Smtp-Source: APBJJlHO1HXjBCHY9eNmXjQw4eXQ80VcX9gbv0gHQponW3ZhdzstxOzdTTV0W3GiN22MYGsKdf9jIA==
X-Received: by 2002:a17:906:5307:b0:993:f996:52d5 with SMTP id h7-20020a170906530700b00993f99652d5mr14716317ejo.25.1689183264463;
        Wed, 12 Jul 2023 10:34:24 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id r16-20020a170906351000b0098669cc16b2sm2789274eja.83.2023.07.12.10.34.23
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 10:34:23 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51e590a8d0bso4792041a12.2
        for <linux-nvme@lists.infradead.org>; Wed, 12 Jul 2023 10:34:23 -0700 (PDT)
X-Received: by 2002:aa7:dc0d:0:b0:50b:c693:70af with SMTP id
 b13-20020aa7dc0d000000b0050bc69370afmr19367439edu.2.1689183262818; Wed, 12
 Jul 2023 10:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
 <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info> <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com>
 <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com> <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
 <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info> <20230711120609.GB27050@lst.de>
 <CAHk-=whXh9sgLo24RO02JjfD0m3HE5NADRPWoEd+dW6bruFhVA@mail.gmail.com>
 <20230712164546.GA31434@lst.de> <CAHk-=whA9rmvNfo=8iKmtimayiA2Aus4XvPwcDrA53G2rfGP0w@mail.gmail.com>
 <20230712165721.GA31965@lst.de>
In-Reply-To: <20230712165721.GA31965@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 12 Jul 2023 10:34:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzetYEqj7phbJBE_ZshFq0=k3zWouJ8XyFyERgDX5sZg@mail.gmail.com>
Message-ID: <CAHk-=wgzetYEqj7phbJBE_ZshFq0=k3zWouJ8XyFyERgDX5sZg@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20230712_103429_094645_40C550DA 
X-CRM114-Status: GOOD (  12.24  )
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

On Wed, 12 Jul 2023 at 09:57, Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jul 12, 2023 at 09:51:52AM -0700, Linus Torvalds wrote:
> > Christoph, you are *literally* involved in a discussion where this is the case.
>
> Yes.  But that's not never ever.  Enterprise storage devices have been
> pretty very good at it, because it is part of the purchase specs.

Your basic logic is lacking.

"Humans are animals" and "Some animals have four legs" are both
undeniabvly true.

That still does *not* mean "Humans have four legs".

And yet hat is *literally* the kind of nonsense you are spouting.

I very much say that "some devices will not have UUID's".

That's a *FACT*.

You then say "Some devices have UUID's, so all devices must have UUIDs".

That's *STUPID*.

Can you really not tell the difference?

           Linus

