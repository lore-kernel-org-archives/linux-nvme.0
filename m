Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B56EEE57E6
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 09:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=avavacijnhkGWAmp9zL+Ef26oN0ADYvRve3aVoTb6uE=; b=chK89kXwnQZAMfvSHFr9Nk1GJN
	LEEwu0mpABy8qP+4wImpYiVGcMWu8rRZ1LAkE7mvUPk4PmBzDAqYleTJM+Ot4aEWXndomX2AcoQlI
	XgSMBj+LR/rySFVMpMeTZfrBpVavmILGoV+7T7BbDwvZc5hzYJA+yL6mhBK7eHYMVU629JGLwsF4J
	TRyHNpjZXdn9jUihecTiZzxcNwbQ0QjLHjuEpWq62dT6Wb6iPQE4lG1brbU/B7ShIqUfUGl74ynXm
	/7GO1AscO0azKMAEs8LkpeQUWmK+bFMwpZKihlHFf4M8/dKyEDgHxTBxwLB7Kvm6kbF5yJZPYbxWX
	SA6JvdCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeXMO-00DMSG-0l;
	Fri, 08 Sep 2023 09:01:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeXMJ-00DMQp-37
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 09:01:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694163658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avavacijnhkGWAmp9zL+Ef26oN0ADYvRve3aVoTb6uE=;
	b=eVzQsjzQPPlyK5+wyDQciTBa5G8CnkPzCpt5aYPPu73lI0ZBrR5rLg/x9X6hUdeHqyZhc6
	QIIoXzTl4L0O9aUum2sLPKuBoj4iOBUjcyJmGDGQzIx17WVSgDjAc9H9qGkchfuRlm+FGE
	wcj+4mR/lBfVbs0dFjcCqVOjtFuDO1Y=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-TngzBBc2PQixpnpVERZi0g-1; Fri, 08 Sep 2023 05:00:57 -0400
X-MC-Unique: TngzBBc2PQixpnpVERZi0g-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26d4ced65c1so2508956a91.2
        for <linux-nvme@lists.infradead.org>; Fri, 08 Sep 2023 02:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694163656; x=1694768456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avavacijnhkGWAmp9zL+Ef26oN0ADYvRve3aVoTb6uE=;
        b=GPKUgoI3Ok/SG1jT4dLki2OMLW1VZyTSu5TA5dG02WRuIH2Ex4eUv5xijPZbDfkz55
         QNgQulFAXtAeA55LXu10qA7Nl3VnBJQdIaLF9IsG6xivvaxqjV9TRVh8V3WA/Q6mtdLL
         JOKrD8Yj2z0AhcEqI3xsG3OCW7nM4FV2LQoIXhG6Zg/wJ0NuvKuavkIvqQsgzvbhDxwJ
         HcdYlhpGc7tLZXVLt6FU1fQSxkW744M99d/XTRNsoHSdBbkxKKyk59PGUp5a4ghnaTZF
         nxxZt5XMwRHk9J+W+1oWUqXy3ebFFErFaEo9dLGbrVppUTCqE7m++Z4Ldp7gUhMklNvS
         c69A==
X-Gm-Message-State: AOJu0YylzfP9t6VYxf/UJW5Sk5G9lX9NyX/ARAfl+UR1cS7+gezj2a92
	8CmAAfunv0v5hSBZbvruqh0QGXq6Se/aqomFUZi/Oxe05211Z5y1Ji/MRiB4kDcOIlg5RpxTEa3
	ZGk8JeUN9O66s/qnuGNG2iFa5Oo4V3+hf3qCiDxHJeTY=
X-Received: by 2002:a17:90b:4c8e:b0:273:e24e:36b9 with SMTP id my14-20020a17090b4c8e00b00273e24e36b9mr410072pjb.8.1694163656245;
        Fri, 08 Sep 2023 02:00:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzt2Up0p+woejBRxepU6YMmcqxNdx1ODLrY6AilCYNYsgc1WTT81DoyPGGJnL0xhgWUuYif6U0SJwE7vCcgWM=
X-Received: by 2002:a17:90b:4c8e:b0:273:e24e:36b9 with SMTP id
 my14-20020a17090b4c8e00b00273e24e36b9mr410060pjb.8.1694163655979; Fri, 08 Sep
 2023 02:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230726142939.10062-1-guoqing.jiang@linux.dev>
 <CAHj4cs9LppxseFzZe-fj7tDaeKd0x8t8Wr-aYcjXAU-8FyfoiQ@mail.gmail.com>
 <a403c942-5b1c-c7f7-243b-81545f7f83ad@linux.dev> <065d800d-8c6c-4257-ade2-9ffa92c36735@suse.de>
 <CAHj4cs_8iC5rn+xA7_bvRifE+1Uu9jjj0wHf=5EmuW7zvaxeYw@mail.gmail.com>
 <CAHj4cs_bn=mCiVu1ZhZYUhf950TsHzdLe4++9N2ebHsLq2YGwg@mail.gmail.com> <77c0f80d-cf77-4828-93ce-5cb06405ceac@suse.de>
In-Reply-To: <77c0f80d-cf77-4828-93ce-5cb06405ceac@suse.de>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 8 Sep 2023 17:00:44 +0800
Message-ID: <CAHj4cs-3Mc0hjE1etM=EPHqcicdOHYw7MzwXb=nCnwQ+KhA9sQ@mail.gmail.com>
Subject: Re: [PATCH RFC] nvmet-tcp: add new workqueue to surpress lockdep warning
To: Hannes Reinecke <hare@suse.de>
Cc: Guoqing Jiang <guoqing.jiang@linux.dev>, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_020100_080812_F46A5155 
X-CRM114-Status: GOOD (  18.78  )
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

On Fri, Sep 8, 2023 at 4:58=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrote=
:
>
> On 9/8/23 10:44, Yi Zhang wrote:
> > On Fri, Sep 8, 2023 at 4:09=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> w=
rote:
> >>
> >> On Fri, Sep 8, 2023 at 3:15=E2=80=AFPM Hannes Reinecke <hare@suse.de> =
wrote:
> >>>
> >>> On 9/7/23 10:12, Guoqing Jiang wrote:
> >>>> Hi Yi,
> >>>>
> >>>> On 9/7/23 14:41, Yi Zhang wrote:
> >>>>> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> >>>>>
> >>>>> Confirmed below issue was fixed by this patch:
> >>>>
> >>>> Thanks a lot for the test!
> >>>>
> >>>> And I had got another similar lockdep warning about nvmet-rdma.
> >>>>
> >>> Please note that this issue is fixed by my patch 'nvmet-tcp: avoid
> >>> circular locking dependency on install_queue()' send earlier to this =
list.
> >>>
> >>> Can you please test with that one to see if it fixes the issue for yo=
u?
> >
> > Hi Hannes
> > There are changes in nvmet_tcp_install_queue and the patch cannot be
> > cleanly applied,
> > Could you check it, Thanks.
> >
> On which tree?

Sorry, I forgot to revert Guoqing's patch before, I can apply the patch now=
.

>
> Cheers,
>
> Hannes
>


--=20
Best Regards,
  Yi Zhang


