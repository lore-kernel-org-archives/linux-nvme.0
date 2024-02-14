Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3BBC48BC3
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Feb 2024 20:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qd2aiPI9hKK8zn318SlhqtdzM62v1ZVBF4dOWFWdohA=; b=PIKmUzMTH+Vv8RAzeHqtyHpbCa
	u/N4rIS8mPEgTDOwcfkMl3LT7P+iHOvqeKw+CCW4cyt8ZeynxSa4R1Ggkp3QNQCxa4toFfmi5pZUN
	kcH44PEONE2DcMJlY394vqUzUxC0rKo/4pJa6jNL0UNWupTbWF1/3uKJr/uE8UzXCinW/7QEIFrdO
	85OOhKaToUr+XnNJDdxq7pXJo44/zaZzpmSUqI4oChbbMFL5XwC1wfjJ5yWUi+aEE7OJLG3xVKInC
	00gc1s7hMVsNkQ5O6C+XgipKcMjkOUV65u+DS9RrIuspG++KDyWv05yCZsuZqe3R2pBP6chXgA7ay
	7cGuB+uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raMIR-0000000EF91-3APq;
	Wed, 14 Feb 2024 20:55:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raMIO-0000000EF8M-3Mh0
	for linux-nvme@lists.infradead.org;
	Wed, 14 Feb 2024 20:55:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707944152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qd2aiPI9hKK8zn318SlhqtdzM62v1ZVBF4dOWFWdohA=;
	b=PfJnhvA85qrbL6krTc/g3CYlcSJugv0D16nJMM6zmVhegeqzwl4dXQGJmWordkTflWwyoI
	I652eFqXzvAX6SQQavtdW/HAHiP1LrnfkgQZek3taDzzZLozYFVp/O8/jMw+NR51UEIKXg
	Eb7goPQaZGrUlJc59KmLRre5pcDV4JI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-UD2j5_NAPn2Ipa4-xqNbMw-1; Wed, 14 Feb 2024 15:55:49 -0500
X-MC-Unique: UD2j5_NAPn2Ipa4-xqNbMw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-511535180b4so137928e87.2
        for <linux-nvme@lists.infradead.org>; Wed, 14 Feb 2024 12:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707944148; x=1708548948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qd2aiPI9hKK8zn318SlhqtdzM62v1ZVBF4dOWFWdohA=;
        b=cN+R4FiQla1h4nZKzgWe3wNxJ2cMP2YTm/cH5fhPyNdBxSM+3I8jUspaGWHFzwENub
         sMm8+nnxlZoQFJsVWXk5bsVJIYmngnUQMTIVtfCYL6UJplvEaCoqIeUwMunYplGkxP1O
         FC59VRceT/eTAru5lzIy4khVj2ixt9ZLsUHOu39b4UHqCTXPV2xIHXhi5YH7DG6v1CPL
         ngDPa+6O5RbZb26uf594Y3MpybzNnwldwMFH+UbISXYI4x+2FEhRq0ys1CBiPzYxDHPv
         vY8X9ZxlOoQjxxUFDjpHrfZvQlrzkKA/jEY8SGGIkTvzjZC9ZxgdZxzMKEW8P2FumsrR
         JGgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5hg1W0nsQwXmcD0AZdFkCQcC6Z1WmZBeBTLvIZ+gKIkruNerdmPWc0ZbOKdpRHT6yn3MOlhKFzfvc9sZ30QWgVHjU/il8K4gSFLNk7i0=
X-Gm-Message-State: AOJu0Yz1i3mJgXXpP5G400T9tmGjy7CcjpWQi988d/xMks0iuRK4FV6s
	hX/35WurStfwlZqLlOQ/BA9WhFPdJVUxKUUb2wgxb++FGU4Qo++/BOxBLVCDky0S5qqkDf+QJx5
	Eu8OMDZNzu//MKdSTFh75soaIsEcoO6noBAm8M3uIZeVCtilu364239uqJ20yYq26x8YykOmnS0
	RLCHH5hrNQMKOoUAVopr0p2/CGRtXuWQwZBGS/qAw=
X-Received: by 2002:a05:6512:1287:b0:511:acd9:c10d with SMTP id u7-20020a056512128700b00511acd9c10dmr1759017lfs.40.1707944148519;
        Wed, 14 Feb 2024 12:55:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAdIviCY+cOciu/DFH2BuB1fIjxeT6eRhZTrKn5UOsY0w+5r+k1jdM88qSbORRZ0fRDTMriyN0YlhWiPoNZks=
X-Received: by 2002:a05:6512:1287:b0:511:acd9:c10d with SMTP id
 u7-20020a056512128700b00511acd9c10dmr1759002lfs.40.1707944148226; Wed, 14 Feb
 2024 12:55:48 -0800 (PST)
MIME-Version: 1.0
References: <20240207184100.18066-1-djeffery@redhat.com> <20240207184100.18066-2-djeffery@redhat.com>
 <CAGETcx91KahXY6ULXDpek3Xf6k4s646Y6+jn_LtfZPDDOpg7hA@mail.gmail.com>
In-Reply-To: <CAGETcx91KahXY6ULXDpek3Xf6k4s646Y6+jn_LtfZPDDOpg7hA@mail.gmail.com>
From: David Jeffery <djeffery@redhat.com>
Date: Wed, 14 Feb 2024 15:55:36 -0500
Message-ID: <CA+-xHTG2E3zMmQSKdEJHC=nnf1AX-UQ=tPY0DDHDsozP+-QL_Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] minimal async shutdown infrastructure
To: Saravana Kannan <saravanak@google.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Laurence Oberman <loberman@redhat.com>, 
	Android Kernel Team <kernel-team@android.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_125556_936114_F551D507 
X-CRM114-Status: GOOD (  20.78  )
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

On Tue, Feb 13, 2024 at 10:43=E2=80=AFPM Saravana Kannan <saravanak@google.=
com> wrote:
>
> On Wed, Feb 7, 2024 at 10:40=E2=80=AFAM David Jeffery <djeffery@redhat.co=
m> wrote:
> >
> > + * Wait for all async shutdown operations currently active to complete
> > + */
> > +static void wait_for_active_async_shutdown(void)
> > +{
> > +       struct device *dev, *parent;
> > +
> > +        while (!list_empty(&async_shutdown_list)) {
> > +                dev =3D list_entry(async_shutdown_list.next, struct de=
vice,
> > +                                kobj.entry);
> > +
> > +                parent =3D dev->parent;
>
> I didn't check the code thoroughly, but so there might be other big
> issues. But you definitely need to take device links into account.
> Shutdown all your consumers first similar to how you shutdown the
> children devices first. Look at the async suspend/resume code for some
> guidance.
>

Sure, I'll work on adding that into the order rules.

> > @@ -110,6 +115,8 @@ struct device_driver {
> >         void (*sync_state)(struct device *dev);
> >         int (*remove) (struct device *dev);
> >         void (*shutdown) (struct device *dev);
> > +       void (*async_shutdown_start) (struct device *dev);
> > +       void (*async_shutdown_end) (struct device *dev);
>
> Why not use the existing shutdown and call it from an async thread and
> wait for it to finish? Similar to how async probes are handled. Also,
> adding separate ops for this feels clunky and a very narrow fix. Just
> use a flag to indicate the driver can support async shutdown using the
> existing shutdown() op.
>
It is rather clunky. It was carried from older patches where I
mistakenly thought people wanted this separate interface. And adding
threads seemed like overkill. Others have been working on similar
patches on linux-nvme that I was unaware of. They add an optional
shutdown_wait call instead of this interface. I had planned on
adapting to work with their interface design.

David Jeffery


