Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2FBE810DA
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Sep 2023 13:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mVeTZGGBbCfNxnl3TtP3DFUymKRrU4x98mkucv93FOI=; b=yvpwoJvtpE3hsjrRH/4N9XXSTU
	M+51g5FFznk8cfeWf6WLM6uSZPUScSxGMk8zgCjmRnG7CmzL5REIZO2w92lB2jaAYJoqsi9YDhr8J
	cW1khA5qNySI/JZuBjHxg/nhsthzhLzjgZwQG/1I37iw0YlXjzmH0EzlWqjOIGMAzwzuzy2L/HKGj
	/ueENlAkkFQ5QomhWakDKGEqliWNtaS70jKY+v2kdQ7dhVnjDn1IV1DrccUCIlut6b92my/5uB9fh
	a1x9EOOgSXUqzmoyBpPpiwylguwP4COMuR3jZcYxcR7yoC7lT+DQGtPePGZlObqcN00AYcSF+35J2
	eXVocDng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlUqu-0012UK-1Y;
	Wed, 27 Sep 2023 13:45:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlUqr-0012Tc-22
	for linux-nvme@lists.infradead.org;
	Wed, 27 Sep 2023 13:45:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695822316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVeTZGGBbCfNxnl3TtP3DFUymKRrU4x98mkucv93FOI=;
	b=ZW/LiygFkjbfRQElXJYh2EXGgJhyNGGZc/CsgNEXC5nnUnGDUM0nwKOMAiXkH/uHJLofUa
	LA/Mr1k1sHWJ6YWkGmYSZJVje2HGoEAy1ACL9OGHqhm7Q3NGSg4YbT0dOXZAGke+HnTOFN
	+OhsHRIPdK6th8I2qXo4vuoX4yNtkKE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-qb_HHUwZMQOZ5ZwGw7NQIw-1; Wed, 27 Sep 2023 09:45:15 -0400
X-MC-Unique: qb_HHUwZMQOZ5ZwGw7NQIw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-323306960e3so3883736f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 27 Sep 2023 06:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695822313; x=1696427113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVeTZGGBbCfNxnl3TtP3DFUymKRrU4x98mkucv93FOI=;
        b=ZDDLNCkK/jUCLpp78Csoaq9niebsgUunRUkk82fej3L9XhacRMRpdLkB+uMHUdVKHy
         n5eXOmJUoyGXmHTHiCv1prsJv34Ap7BWtkgJEjrRJ7giWeiDpB/ZRd1lYBi5XcZ++JXu
         OAh3rHHT1JR5cNLG9MhZ5GnbJlmx72VsrG1glFKnpIqQDIJSYq7TePn09Sc2Spg70yXf
         Jl4E3bsVFUuWmcQ2zYBMqw0rzFAvrDP4TRvMCcrd+ZSQYCldxiF9sKoXW7kvhLndF20l
         BIIm/nBUN5xer91bH0+YYJ6D9G2ElyuVx36EB8RGv3bbvz+oKPmLx+EIoWwi0VsxWfNj
         K64Q==
X-Gm-Message-State: AOJu0YyGE6EeO6vDDHmNEeNoCBpFltAlZpdorD4FtBjcZZS8Mboixsxj
	KHWECDotFWV4mnIntMu35bY2xdIW3mUVVamYlhBZf5SdD2E0/1+KO5YRLf7q/87tPWp56IoTdl0
	ChUUgVH9iyf1WjxdahveNkCXOu7C5uaFsSbVrqD4RhQY=
X-Received: by 2002:adf:e7d2:0:b0:31a:e772:ddf0 with SMTP id e18-20020adfe7d2000000b0031ae772ddf0mr1704762wrn.53.1695822313297;
        Wed, 27 Sep 2023 06:45:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQrqartgjeDbCYBbqBx8vzbzSxFt1LVxta6HaaPIEHcTtl77yQ06eJSH9MCqsx1qI8O2wd+wrYv3BrJ8YlRyA=
X-Received: by 2002:adf:e7d2:0:b0:31a:e772:ddf0 with SMTP id
 e18-20020adfe7d2000000b0031ae772ddf0mr1704742wrn.53.1695822312914; Wed, 27
 Sep 2023 06:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230925163123.16042-1-emilne@redhat.com> <20230925163123.16042-4-emilne@redhat.com>
 <5df9a1f8-fb2d-4819-88a8-a3f3c32cdab5@suse.de>
In-Reply-To: <5df9a1f8-fb2d-4819-88a8-a3f3c32cdab5@suse.de>
From: Ewan Milne <emilne@redhat.com>
Date: Wed, 27 Sep 2023 09:45:01 -0400
Message-ID: <CAGtn9rkp25s6fpDOGGmibXEg9cNwPBO9dUKLH3xZsL6CQSi8cA@mail.gmail.com>
Subject: Re: [PATCH 3/3] nvme-multipath: add "use_nonoptimized" module option
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, tsong@purestorage.com, jmeneghi@redhat.com, 
	mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_064517_743379_4CF0442C 
X-CRM114-Status: GOOD (  20.63  )
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

Yes, you are probably right.

I added this patch because what I found was that, for arrays I was using,
the nonoptimized paths had almost the same characteristics as the optimized
paths for some workloads.  They had a small amount of additional latency.

And, it is helpful to have paths available with slightly different performa=
nce
in order to experiment with the behavior of different path selectors.

I'm OK with omitting this patch but I wanted people to see how it could be =
done.

-Ewan

On Wed, Sep 27, 2023 at 3:41=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 9/25/23 18:31, Ewan D. Milne wrote:
> > Setting nvme_core.use_nonoptimized=3Dtrue will cause the path
> > selector to treat optimized and nonoptimized paths equally.
> >
> > This is because although an NVMe fabrics target device may report
> > an unoptimized ANA state, it is possible that other factors such
> > as fabric latency are a large factor in the I/O service time.  And,
> > throughput may improve overall if nonoptimized ports are also used.
> >
> > Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> > ---
> >   drivers/nvme/host/multipath.c | 22 +++++++++++++++++++---
> >   1 file changed, 19 insertions(+), 3 deletions(-)
> >
> No. Please don't.
>
> There's a reason why controllers specify paths as 'active/optimized' or
> 'active/non-optimized'. If they had wanted us to use all paths they
> would have put them into the same group.
> They tend to get very unhappy if you start using them at the same time.
> (Triggering failover etc.)
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                Kernel Storage Architect
> hare@suse.de                              +49 911 74053 688
> SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andre=
w
> Myers, Andrew McDonald, Martje Boudien Moerman
>


