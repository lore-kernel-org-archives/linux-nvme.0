Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B34EC77B7C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 15:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jsW6zqBgtCDTnvN34Xc+Lxt07USTsTvI2l+xYg+WY9U=; b=DHYR7T3zz6AKKtTaOs00T3Cq8J
	ZwMIuiiAEbVNCTJ9txw1FFHtRe3i0xgwHwcKkkdZ98pSQ0nJz3887gkNPFg46t5rHJDgIH4i9J2lH
	6zpZvCqIJh2d8WMgtp7ZhYStlok1uG5UpEBncBCBip+WSqQ821n7ceH+mZPcnwxY2gndy41xNy0sM
	8J6PzxIlK8dULiu2S+Jdta9xZ6AuskdGRuEPpY7TkXQfPL+Ievv9Kot/+OUo5ZDrz0O/eKefpHikq
	FWn2KDqO4qqdxregbJmijqSjBiWDTsj4VQ0M0T0xINLtBzpeQZsoZ8b+WhXB+sdAh+B9P03BvbQQl
	It2DK3Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWzNk-00000008n9K-0nAi;
	Wed, 02 Jul 2025 15:28:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWydL-00000008eUp-2u6O
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 14:40:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751467221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsW6zqBgtCDTnvN34Xc+Lxt07USTsTvI2l+xYg+WY9U=;
	b=YPZ0uZW15g1nWXIm0whjQt2qsZVczbtXqUap5Rdvmm1Er4gBsPyzPOtCmP4vqCTct9T0bF
	5jhtkeKBpxhb65Qd2fvamEVaj27htmXieCTWkYBs8AEbLFpgz5YzgPCVt8fHkkLc0SZ2Li
	32rK8vkTY/gHvqQ4/+GuEgC4PDj3Mho=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-CF_9QuEzMPq_7LLiWgBGuA-1; Wed, 02 Jul 2025 10:38:49 -0400
X-MC-Unique: CF_9QuEzMPq_7LLiWgBGuA-1
X-Mimecast-MFC-AGG-ID: CF_9QuEzMPq_7LLiWgBGuA_1751467128
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-406792ddc01so4498915b6e.0
        for <linux-nvme@lists.infradead.org>; Wed, 02 Jul 2025 07:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751467128; x=1752071928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsW6zqBgtCDTnvN34Xc+Lxt07USTsTvI2l+xYg+WY9U=;
        b=BKiiIbKdhYPW/1YKnHIkMAiIRCQugNpwJwCULu0vzbDyRPz1dsVLhWMIggfWn7OX0p
         F4qxgJ05F4HDTbjo02RTsiIw0VLFdJafvmXz9fllFqXVi1RGXV/V8YqSFAvCaO5uYfpm
         Vb8Pp0S7Rs9PY7sWUQ3rtV08qgAISDYb/qUQEXhTfzP7csS4/y4VpI6Fy/lj4Rpel6tc
         uIg1wefpfptdneReb5thO6uFgdUnlcvv85qb5/11PPuToA4feufvAZEN+sM79C2+A9Yp
         kQDgO/42VrerTofzmSNimkAH4FQ8uRLw6EcGSOZXqXHcdH9/qziip6NCu+gKfWlzOxZU
         0K1w==
X-Forwarded-Encrypted: i=1; AJvYcCUkZ1dqEDzPljm0CCFszo1oPf65QjwEbPEaLBG+xI0tEy7ZYAUQFPjocHtJZ5lcpbkQA+GcOSmDTs1K@lists.infradead.org
X-Gm-Message-State: AOJu0YwsApM6QS/6R0CWM4zlGC0gGleUL7+Kvq4LGa5ExtUGaP9pqY9t
	jsXajF/ks9cLOMeSL4idqh5zAUDucqnDCQgGKPhiZc8CBP076nKAaOH/MtjmiOCB+w9LRuwx9HI
	NiGl4Vjl/w563usueQC9ArrFkDYVPiu+Z8Ul2m2CexYhY/hcXJTpwKzltpSzuAFeOUS9/NtHkWB
	5txCc9gd0NTWNv2endsnLsaBJIwz1ULuQLb7UWyFeaq5c=
X-Gm-Gg: ASbGnctmwKcOOWd+8E8sX/W1q9ZgHA6v65FUaK4wqu7urOtT/UjqJ9lA5hYf8HIHcQO
	oMoZRasMg3I45in/M4kqAhscrUswCZAxnCjlRaNX3465S3idC9WxEeVRO5qSVsc03ar3lyy8YLQ
	Jjfg==
X-Received: by 2002:a05:6808:1b90:b0:3f8:3489:d93d with SMTP id 5614622812f47-40b88816cbemr2174556b6e.25.1751467128346;
        Wed, 02 Jul 2025 07:38:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGJkEyRApKN9Snn2Qns9uRFnPDyzYI0heJJY+yiOKE3hkdxWXuRgqyrbD2KwH2XrfLhobH6R7OolRAxc95iss=
X-Received: by 2002:a05:6808:1b90:b0:3f8:3489:d93d with SMTP id
 5614622812f47-40b88816cbemr2174514b6e.25.1751467127863; Wed, 02 Jul 2025
 07:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
 <20250625201853.84062-3-stuart.w.hayes@gmail.com> <2025070157-undaunted-curler-bda3@gregkh>
In-Reply-To: <2025070157-undaunted-curler-bda3@gregkh>
From: David Jeffery <djeffery@redhat.com>
Date: Wed, 2 Jul 2025 10:38:35 -0400
X-Gm-Features: Ac12FXy9HjgNoFaB4FAc6SLNfV66UqBtwIgyuy9-ldwc1GEwfSJnUe5aDVCjxV4
Message-ID: <CA+-xHTEk_N6qE5w+hWxXfSMJLQ5tFROMVZnr5h2HUmrwEKVdNQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] driver core: don't always lock parent in shutdown
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Martin Belanger <Martin.Belanger@dell.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>, 
	Lukas Wunner <lukas@wunner.de>, Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Jan Kiszka <jan.kiszka@seimens.com>, 
	Bert Karwatzki <spasswolf@web.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y4uwUXge0uCKWNm2j9_4L5Zo7X_tFo9Avb3ciDanMpc_1751467128
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_074023_840887_6D09F6F7 
X-CRM114-Status: GOOD (  26.41  )
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

On Tue, Jul 1, 2025 at 5:03=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 25, 2025 at 03:18:50PM -0500, Stuart Hayes wrote:
> > Don't lock a parent device unless it is needed in device_shutdown. This
> > is in preparation for making device shutdown asynchronous, when it will
> > be needed to allow children of a common parent to shut down
> > simultaneously.
> >
> > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > ---
> >  drivers/base/core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index cbc0099d8ef2..58c772785606 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -4823,7 +4823,7 @@ void device_shutdown(void)
> >               spin_unlock(&devices_kset->list_lock);
> >
> >               /* hold lock to avoid race with probe/release */
> > -             if (parent)
> > +             if (parent && dev->bus && dev->bus->need_parent_lock)
> >                       device_lock(parent);
>
> What about parents for a device that is not on a bus?  Don't they need
> to be properly locked?

From my examination of the code and history, I do not believe so.
Locking the parent was added before need_parent_lock was added, and
when the other locations changed to depend on need_parent_lock to lock
both, device_shutdown was left always locking both.

It is simple enough to change the if checks to:

if (parent && (!dev->bus || dev->bus->need_parent_lock))

if you think my understanding is wrong and some bus-less devices have
come to depend on the behavior.

David Jeffery


