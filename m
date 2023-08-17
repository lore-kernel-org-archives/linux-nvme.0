Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873D3C2FC04
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 04:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xi6GCIvYMrXK0lOa4BzgiNbthh1VOoylxGCNWn6oKms=; b=off8RlCPaYGMJSw/LImWvYfh66
	P5wgMNavHmHpONnyxo6O7ZkUB9yx85mOmi8/zdnOrwMY3KluMEJ+UBs6CubcAs/otcenJ5pmvbqm9
	1ylM2D0DxvTP1+IbTWk4B6lONRC5JTXBo72ZaYdc9t97l91DA3c2j+FRZp3JDuzkEiLHmui873DL9
	Rjr7TTFppX89lNdZEjLyldLqovEn738zh/Zi8//P88dpAf0amM/lJgbkEPSb4pBFXee7D5CiG4Jxi
	xx6vuI24k8wtB/p95dSM0fAcyy2RPevoMxu/RTvxeso0A0h7RqQ6/nrlBHuK0TDs51XmBiYNNQOSe
	aJjnVh/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWUY6-005WDK-0M;
	Thu, 17 Aug 2023 04:23:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWUY3-005WCq-2J
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 04:23:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692246229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xi6GCIvYMrXK0lOa4BzgiNbthh1VOoylxGCNWn6oKms=;
	b=TOgHHEaspISR3hftMVxniQo8Lg+rfZ40GCwEsTfg+Vv3zIzaCuvFGVPlPxdgfEWjCdft7n
	J8zC386cJq7wtUXS4QM0n0D64u0CErX1rURgSFnNmmIYq4Ef21kaAtw1K+wZ70vLYUlDbr
	jc4bkEzywt4M/hgkMVVoI4YLUnBzavA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-GotaybTzOja1EUmGrmiEBA-1; Thu, 17 Aug 2023 00:23:47 -0400
X-MC-Unique: GotaybTzOja1EUmGrmiEBA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-26cf409f057so527045a91.0
        for <linux-nvme@lists.infradead.org>; Wed, 16 Aug 2023 21:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692246226; x=1692851026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xi6GCIvYMrXK0lOa4BzgiNbthh1VOoylxGCNWn6oKms=;
        b=E8O4GnUtPlvDf5CBBU9oULuup8hWBuliNgx6eDHModDZLXFtfPvLMZsETqtMeLSH+Q
         2IW8o8xWKlhQ8aEobLWwptD24YFKGBc09PgPGQLTPJUZhEuqPell9ddNjrSBXnN7QNyb
         Jy/BH1lacOhIzAvsun9+J4cxJO+RoUPMKzapeUHNG5QAJ3bx241Ua18451PxjCcWefTF
         UT9AM4BOYr69d4HdkLBlA1tqV1Gd6KgHJ3mXzu7l/em0LJrJfMAjd7mt0c6d1+YDy4Lm
         CNa+aKXO6qldnVQ4PXqJ3kYirsbz/jXnap3G3hbBFdxr28RuGsEI3fB2o/zYLRO7w2Tr
         2RZw==
X-Gm-Message-State: AOJu0Yy5po09/cj1A1hYS+4qytFymdJXIigBJ4g2Bh47cz6OREsqS5B9
	5ocOfOfa5tRY02/bDdHFRsiflz0NrK5r3nMGRlFBdE5dCns1LnJ9Z6ekYpB7pEoJZTUxqoUjx8s
	LJ44u+dzuQJESibevFLGh9U0E3zby8PH3FU3a04hoDZs=
X-Received: by 2002:a17:90b:3692:b0:26b:51a6:4879 with SMTP id mj18-20020a17090b369200b0026b51a64879mr3285197pjb.6.1692246226696;
        Wed, 16 Aug 2023 21:23:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU1onVSXGuWAOE2c/XJazPwZ0lwqHUTGDRZ5bFw8NnKI3WTHOgUe2yRXPrkw21yNqNF3VSvDjL9d3P5TNKiBk=
X-Received: by 2002:a17:90b:3692:b0:26b:51a6:4879 with SMTP id
 mj18-20020a17090b369200b0026b51a64879mr3285185pjb.6.1692246226443; Wed, 16
 Aug 2023 21:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230811012334.3392220-1-shinichiro.kawasaki@wdc.com>
 <149f023e-e4f4-3b36-56d5-e2d0f486439f@grimberg.me> <3zmxxrhmcpn2ogavpuropzmqbhwzqtgurkgx7cgpws3rt7qq4n@guspsox5d73u>
In-Reply-To: <3zmxxrhmcpn2ogavpuropzmqbhwzqtgurkgx7cgpws3rt7qq4n@guspsox5d73u>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 17 Aug 2023 12:23:35 +0800
Message-ID: <CAHj4cs-jn-cPTFr0Le7mkwgenTYY4g+YsCN=_3vNPLFK6CQTZg@mail.gmail.com>
Subject: Re: [PATCH blktests] nvme/rc: fix nvme device readiness check after _nvme_connect_subsys
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Daniel Wagner <dwagner@suse.de>, 
	Bart Van Assche <bvanassche@acm.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230816_212351_833940_ADCBE2F2 
X-CRM114-Status: GOOD (  14.69  )
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

On Wed, Aug 16, 2023 at 8:11=E2=80=AFPM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Aug 14, 2023 / 12:37, Sagi Grimberg wrote:
> >
> > > The helper function _nvme_connect_subsys() creates a nvme device. It =
may
> > > take some time after the function call until the device gets ready fo=
r
> > > I/O. So it is expected that the test cases call _find_nvme_dev() afte=
r
> > > _nvme_connect_subsys() before I/O. _find_nvme_dev() returns the path =
of
> > > the created device, and it also waits for uuid and wwid sysfs attribu=
tes
> > > of the created device get ready. This wait works as the wait for the
> > > device I/O readiness.
> >
> > Shouldn't this call udevadm --settle or something?
>
> Ah, it will be more stable to add "udevadm settle" before the readiness c=
heck.
> Will add it.
>
Yes, I just tried to add "udevadm --settle" and it works well.

--=20
Best Regards,
  Yi Zhang


