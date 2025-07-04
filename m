Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A9CC83F03
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jul 2025 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VOrNKDtv4mY2pT9EDlIkWqiS73OnVUntUZCbjMuDRfM=; b=WvJjvF+aokUS+rxspfzTJ4XiPz
	3I8hAd134O8HcBuwLOsNwW1D8dZrYhxbrTZpGY+lHuzJ+xLEB7XGEHuoukcMQrSyfNUD5StZQ3/up
	zKO1M/VTUpD3anUOqCbBd1H6WsUQ3VosZAnOsujV9xfwI/LB6f+ACA7zWBXX7IcZqdK5dtgJgFObO
	Ygf+yJgnp+3pK8eLnSq+1/ZvgTwBKAIFWkPrcW51/UdXe6LtavgO2ZtvtmDHX7lxpxGlq2JFxc/va
	M3h+nqVT6wJ6Co7UdiWsgT1q1cFBMT5VrJZV5VgGxeq1kItYMxLE0qXnEn0Cyaiqi1mrOGv2WGVXR
	alylf8ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXhK8-0000000Eeyk-1Nyf;
	Fri, 04 Jul 2025 14:23:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXh6P-0000000EcYl-0Znb
	for linux-nvme@lists.infradead.org;
	Fri, 04 Jul 2025 14:09:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751638160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VOrNKDtv4mY2pT9EDlIkWqiS73OnVUntUZCbjMuDRfM=;
	b=JU1snoZ9+q22io2H4fTGYcNTkW2V9WCHpGRnFdzAwQPnoctHuhty9Iff0/d4b/F+UFjEZJ
	5BO9ubQ1xsCQgeOYmD4afmoBtoUW2EpNoX3OfmHlczIegMqV8L/MqgybztaPz59DMoVOtJ
	WSN22yin1yV5MhJveG26JXRqVt5qOL4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-R8XTFgAsNHWcCOT8ay4REA-1; Fri, 04 Jul 2025 10:09:19 -0400
X-MC-Unique: R8XTFgAsNHWcCOT8ay4REA-1
X-Mimecast-MFC-AGG-ID: R8XTFgAsNHWcCOT8ay4REA_1751638157
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-32b71af3b28so4607751fa.3
        for <linux-nvme@lists.infradead.org>; Fri, 04 Jul 2025 07:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751638157; x=1752242957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOrNKDtv4mY2pT9EDlIkWqiS73OnVUntUZCbjMuDRfM=;
        b=QgKPudAQVAK3tQDvQLrqwAHwJiPZ4xl1nA7us6L6Bws823Ui4gxAIC95iYZt4n2rUV
         C+6mRByxoAvLGnNSWlxRRoE58b345jA0RbtxPfjLn0GktKxeKBxdcocpSgXGCW8p3jSw
         mq2Yz5SngaGSpDjF2pHmr53PaZTTUhhHzpbOaikI2RbzZsPQ20uGfeDq4yHZSakKMhfP
         EufvMQw3VDq0Wo085ZFcKzS5qdxQY8jDOpb1dUL0jCH/R+69GqhHUdTzaXH7L7maHXFB
         FQTjhmQSImUGTeMSzsRwqeMFBJxOsZ0yFvaVBNwp7yIVNBoiLBECNz4MWuYwGri8v25N
         TA1g==
X-Forwarded-Encrypted: i=1; AJvYcCWqwnvJE7CBhbw2FV2UEc9DAfE63EfSpgoB+VWfDbZ2B+v+I3NqD2h65xhErJccJDZo0kwrNzUTLFDa@lists.infradead.org
X-Gm-Message-State: AOJu0YyW1Aod48NiCWGjG+oLDZOJdejAIymSJLzSNloTb2X6tGj+wL+q
	HRg0xuUhx6K5hMZX0mHo7XGCsG+w4GocI2SpNi/ONHUeJwZGkoXK/A5D2plFHKKKcGdLvZG/NYT
	3SNM5r+DqvoqxScpw6q1vUXDH79zBL4aaTHAzFRkZBoDsmpsnPHx5l1mWznVz/l5h1LRfilDhCs
	V3VDB06enC8MqrM/g4gcuo+vcbBWmoK9jCSbnop6DY3paSTmONZ4cyWg==
X-Gm-Gg: ASbGncu7oMF544o+IQIuPyMhBSZk8HMiSyGaYddvEZhVXL1YDv8N695pVX1/3jQnpzC
	06ySKQ7lBNm64q6edNA+hPuEjJlA0Ae1xTGIZIahdVmBocGKtA9/dFvDvzWE1rY1DDVYLEWOYwV
	FhCg==
X-Received: by 2002:a2e:a582:0:b0:32b:488a:f519 with SMTP id 38308e7fff4ca-32f00c889efmr7833511fa.6.1751638155206;
        Fri, 04 Jul 2025 07:09:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB59XkjZpu9peglaAwPR2m1GGWoAEsmWmWQsl6Xf4+KVDJYuU5UV6fbyjB8kcFQIhNwsxoqChY3uFHFh3qQYw=
X-Received: by 2002:a2e:a582:0:b0:32b:488a:f519 with SMTP id
 38308e7fff4ca-32f00c889efmr7832341fa.6.1751638153263; Fri, 04 Jul 2025
 07:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
 <20250703114656.GE17686@lst.de> <CA+-xHTH2rxWwAao0EuNbhubqA2mrXOTZ7r1p-hcTieieomx75g@mail.gmail.com>
 <2025070408-starlight-pandemic-0266@gregkh>
In-Reply-To: <2025070408-starlight-pandemic-0266@gregkh>
From: David Jeffery <djeffery@redhat.com>
Date: Fri, 4 Jul 2025 10:09:01 -0400
X-Gm-Features: Ac12FXxMPP32h9UySF1ham11qALBr4OrI6VVO4XXxXfqe7L1atg--F_Y1lT2gNE
Message-ID: <CA+-xHTFKh0VUJ0r4K5L5b0dmrs9d1+cNkqf4HvKa4E-r_+u2CA@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] shut down devices asynchronously
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Martin Belanger <Martin.Belanger@dell.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>, 
	Lukas Wunner <lukas@wunner.de>, Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Jan Kiszka <jan.kiszka@seimens.com>, 
	Bert Karwatzki <spasswolf@web.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VzX7JpDD-tjUPP9fELhp5CkIu5Tu9aEXHYQmzPWk22Q_1751638157
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_070921_248556_FD524457 
X-CRM114-Status: GOOD (  22.39  )
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

On Fri, Jul 4, 2025 at 9:45=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jul 04, 2025 at 09:38:15AM -0400, David Jeffery wrote:
> > On Thu, Jul 3, 2025 at 7:47=E2=80=AFAM Christoph Hellwig <hch@lst.de> w=
rote:
> > >
> > > On Wed, Jun 25, 2025 at 03:18:48PM -0500, Stuart Hayes wrote:
> > > > Address resource and timing issues when spawning a unique async thr=
ead
> > > > for every device during shutdown:
> > > >   * Make the asynchronous threads able to shut down multiple device=
s,
> > > >     instead of spawning a unique thread for every device.
> > > >   * Modify core kernel async code with a custom wake function so it
> > > >     doesn't wake up threads waiting to synchronize every time the c=
ookie
> > > >     changes
> > >
> > > Given all these thread spawning issues, why can't we just go back
> > > to the approach that kicks off shutdown asynchronously and then waits
> > > for it without spawning all these threads?
> > >
> >
> > The async subsystem fix is something that should be fixed regardless
> > of async shutdown. Async shutdown's use just exposed its thundering
> > herd behavior which is easily fixed.
>
> Great, then please submit that on its own and get the maintainer of that
> subsystem to agree and accept it as I have no way to judge that code at
> all.

Unfortunately, it does not have a maintainer listed and sees limited
activity. Would CC-ing some of the recent developers of kernel/async.c
to ask them to review be recommended in this situation?

David Jeffery


