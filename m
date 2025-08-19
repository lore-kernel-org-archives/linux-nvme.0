Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA1ACA0EF5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Aug 2025 18:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bt6loWo/hh8+nt8BE6dLlvh3bgytAsqG24S0bAIeUcg=; b=KvKv3rsROqMnPlsSL6MPOCPQEy
	BOcxu4bzb+qIguycR3crao/eI1xi6kUOMvs1PZt47klvZwZLc7w5gYk/88svADRvGkAUv6cNyWuSf
	ggiJ31iNPGERAooUfDnS4mASlkGrEXi+IwX1p0jvY9EaQfmBnYvJtH28jtzdZkiO+W5o0FhRjRWtN
	qVXCWRdkyGXI2CZP05sEt4+UfYDqTK9+wNRWFJwtTNl9hJaDNvZa17FxU7Waahn18mTE+QtbJ5d4v
	Z4bKVEefFjoKbVVubG6tZF+XtbWWmG9EbXSkmPthLSa7VZju2ASTFMLTbstOZi2lVYKJ0/OpiOdXR
	ud4XevKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoQql-0000000BDnD-1kn7;
	Tue, 19 Aug 2025 18:14:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoMce-0000000Adf7-0oE8
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 13:43:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755611011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bt6loWo/hh8+nt8BE6dLlvh3bgytAsqG24S0bAIeUcg=;
	b=emfjUjGHM4okq0tV+ubDfSJBB6snw6O15TeNJ6K98cuXR0smxsIYKgHCFw1ZZFj3Fza8dT
	ESZ0vx2+uAiUl+dZLxwpnARyxfRORHE3XqL8AUqtYRrrHlAGXOg98/2smeK5zJQppVo002
	VD8By1ypXiUJdtOouYr65jA7O0Q0qvE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-nLASh2vRN6GDp_5TzAXp_A-1; Tue, 19 Aug 2025 09:43:29 -0400
X-MC-Unique: nLASh2vRN6GDp_5TzAXp_A-1
X-Mimecast-MFC-AGG-ID: nLASh2vRN6GDp_5TzAXp_A_1755611008
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-333f8ff5d2bso23721461fa.2
        for <linux-nvme@lists.infradead.org>; Tue, 19 Aug 2025 06:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755611005; x=1756215805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bt6loWo/hh8+nt8BE6dLlvh3bgytAsqG24S0bAIeUcg=;
        b=bWrZXTrX6rnvl2K83S8kGeonTGdW/GOMmWRGrM61MQ4afE8Mj3rjNUkY0frJ6Xe8gY
         IFHVAOl4QiPNVOBgPmdZ+UVlH6UpNVSZXsZTmPnajkcHHhgj4R1rm0FOJq5cEry4XJ1j
         17b+r1oGIERlQoLyx4dwBbg/ralUZTWRfLNtCUM+V7+HsnRl0BogZP1HPUzDwiZ/YSO1
         tWxL0V4mEgZywRNdDHeovIS75E1nAWt/NLkHZgSZY9booyb110OQmL2tjci5kbqUbGpX
         4ut5rTa8TusWtRm5yBeVxjuhAwLMvl2HSZgjnstEZQJBigdIZ9s0+oT1KNs4sAIviVbH
         81eA==
X-Gm-Message-State: AOJu0Yxma1JUY8yHQYLXppjSkJrOytHWgOoB0VCHP94oR7mRuh5C+ubQ
	6/+HltEQyHEzS57j3QDftAp2LaDiw8PeyWnW//MTpyrRGlLfPiR6p6VYWblUy+vjeI82hECIP/t
	icKIm+6nRueF04x8FzFiUAloeiL2hj9IHDaiKA01lpqbY2Ik9PdAQOkWQQkkXuR2AqyqqUB2fwN
	1y3MCL7TNa00Mc2m7aIdn/kbAxeIXsOWyBDHEqwDpDSqPI+CuJJGU=
X-Gm-Gg: ASbGncsF2OjgNqUDKrQH44DFYPSB5QhqP3D0UK8V+FVbnrF+hKFAjn2QwX9XY99/NVY
	iUC22ca6VE3U8fzlKD9mYn8q+yHAI5YSrj3MRznMwL5XnsCJlPBY0z4kaN1pBWWdNJxSp12/j5P
	3XyG9rpDfoe0dGeHW9rYJ15Q==
X-Received: by 2002:a2e:b8c5:0:b0:332:625e:c8ff with SMTP id 38308e7fff4ca-335307ca0ddmr7278151fa.34.1755611005234;
        Tue, 19 Aug 2025 06:43:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENjz53wpqcEASnJ4T7qQyHDcc7d2TgBWnoCBHMY0BHVr3vWpm5L1kzvy25rey8d1tq+k1j31DmUYVGZmCSw6M=
X-Received: by 2002:a2e:b8c5:0:b0:332:625e:c8ff with SMTP id
 38308e7fff4ca-335307ca0ddmr7278001fa.34.1755611004701; Tue, 19 Aug 2025
 06:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAAiJnjqKqMHjrPLOvY5sCXiQR0n6pMvm2mS5pQEqy2XY1cD_6Q@mail.gmail.com>
 <7a48ed7a-bbc6-4847-94bb-8fb08def0ca4@suse.de> <CAHj4cs91w8-PRJUsMJVBqp=WLSgo-OnT7PuovpALQmqX=f4abA@mail.gmail.com>
In-Reply-To: <CAHj4cs91w8-PRJUsMJVBqp=WLSgo-OnT7PuovpALQmqX=f4abA@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 19 Aug 2025 21:43:10 +0800
X-Gm-Features: Ac12FXxmwDqInPvu-2KFnDQVysBuAKDOCyY709ZkGgUDvGjBmv1-OlXLhF-T-lk
Message-ID: <CAHj4cs8oUX6-0nZYpNKNkuR=r9huRERB20GigOOKZzVnc09pGA@mail.gmail.com>
Subject: Re: Unable to reconnect namespace via NVMe/TCP
To: Hannes Reinecke <hare@suse.de>, Anton Gavriliuk <antosha20xx@gmail.com>
Cc: linux-nvme@lists.infradead.org, Chris Leech <cleech@redhat.com>, 
	Maurizio Lombardi <mlombard@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BwBwpA6b_TFCcGelUEvD3BIXx9NWymqDHGe08488HLc_1755611008
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_064332_299519_55DAFDAB 
X-CRM114-Status: GOOD (  20.59  )
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

Hi Anton

Please try to add the uuid in the device field, which should fix your issue=
.

On Tue, Aug 19, 2025 at 6:55=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
> Hi Hannes
>
> I tried with the upstream kernel v6.17-rc2, and it can still be reproduce=
d.
>
> # dmesg | tail -30
> [  219.560691] nvme nvme0: Failed reconnect attempt 3/-1
> [  219.565784] nvme nvme0: Reconnecting in 10 seconds...
> [  229.795215] nvme nvme0: failed to connect socket: -111
> [  229.800369] nvme nvme0: Failed reconnect attempt 4/-1
> [  229.805450] nvme nvme0: Reconnecting in 10 seconds...
> [  240.034918] nvme nvme0: failed to connect socket: -111
> [  240.040093] nvme nvme0: Failed reconnect attempt 5/-1
> [  240.045165] nvme nvme0: Reconnecting in 10 seconds...
> [  250.274619] nvme nvme0: failed to connect socket: -111
> [  250.279776] nvme nvme0: Failed reconnect attempt 6/-1
> [  250.284855] nvme nvme0: Reconnecting in 10 seconds...
> [  260.514102] nvme nvme0: failed to connect socket: -111
> [  260.519261] nvme nvme0: Failed reconnect attempt 7/-1
> [  260.524340] nvme nvme0: Reconnecting in 10 seconds...
> [  270.754031] nvme nvme0: failed to connect socket: -111
> [  270.759184] nvme nvme0: Failed reconnect attempt 8/-1
> [  270.764263] nvme nvme0: Reconnecting in 10 seconds...
> [  280.993410] nvme nvme0: failed to connect socket: -111
> [  280.998591] nvme nvme0: Failed reconnect attempt 9/-1
> [  281.003653] nvme nvme0: Reconnecting in 10 seconds...
> [  291.249090] nvme nvme0: creating 4 I/O queues.
> [  291.264959] nvme nvme0: mapped 4/0/0 default/read/poll queues.
> [  291.271975] nvme nvme0: Successfully reconnected (attempt 10/-1)
> [  291.273897] nvme nvme0: identifiers changed for nsid 2
> [  291.283631] block nvme0n1: no available path - failing I/O
> [  291.289139] block nvme0n1: no available path - failing I/O
> [  291.294649] block nvme0n1: no available path - failing I/O
> [  291.300159] block nvme0n1: no available path - failing I/O
> [  291.305665] block nvme0n1: no available path - failing I/O
> [  291.311197] block nvme0n1: no available path - failing I/O
>
> On Tue, Aug 19, 2025 at 2:11=E2=80=AFPM Hannes Reinecke <hare@suse.de> wr=
ote:
> >
> > On 8/12/25 17:48, Anton Gavriliuk wrote:
> > > Hi
> > >
> > > There are NVMe/TCP target and initiator servers, both running on
> > > RHEL10 (6.12.0-55.25.1.el10_0.x86_64)
> > >
> > > NVMe/TCP target exports single NVMe SSD
> > >
> > >        "namespaces": [
> > >          {
> > >            "device": {
> > >              "nguid": "01000000-0000-0000-8ce3-8ee3064aa4f2",
> > >              "path": "/dev/nvme0n1"
> > >            },
> > >            "enable": 1,
> > >            "nsid": 1
> > >          }
> > >        ],
> > >
> > > If NVMe/TCP target is not available, initiator tries to reconnect
> > > every 10 seconds
> > >
> > > [ 2586.071048] nvme nvme9: failed to connect socket: -111
> > > [ 2586.071403] nvme nvme9: Failed reconnect attempt 16/-1
> > > [ 2586.071565] nvme nvme9: Reconnecting in 10 seconds...
> > > [ 2596.310921] nvme nvme9: failed to connect socket: -111
> > > [ 2596.311186] nvme nvme9: Failed reconnect attempt 17/-1
> > > [ 2596.311349] nvme nvme9: Reconnecting in 10 seconds...
> > > [ 2606.550772] nvme nvme9: failed to connect socket: -111
> > > [ 2606.551252] nvme nvme9: Failed reconnect attempt 18/-1
> > > [ 2606.551592] nvme nvme9: Reconnecting in 10 seconds...
> > >
> > > when NVMe/TCP target become available, initiator failed reconnect the=
 namespace
> > >
> > > [ 2606.551592] nvme nvme9: Reconnecting in 10 seconds...
> > > [ 2616.793080] nvme nvme9: creating 16 I/O queues.
> > > [ 2616.829881] nvme nvme9: mapped 16/0/0 default/read/poll queues.
> > > [ 2616.833685] nvme nvme9: Successfully reconnected (attempt 19/-1)
> > > [ 2616.834446] nvme nvme9: identifiers changed for nsid 1
> > > [ 2616.835618] block nvme9n1: no usable path - requeuing I/O
> > > [ 2616.856602] block nvme9n1: no available path - failing I/O
> > > [ 2616.856811] block nvme9n1: no available path - failing I/O
> > >
> > > and there is no nvme9n1 namespace in the "nvme list" output.
> > >
> > This looks like the missed re-scan issue I found recently.
> > Should be fixed with
> > 9546ad1a9bda ("nvme: requeue namespace scan on missed AENs")
> >
> > (And you are running RHEL. Please open a bugzilla with RH.)
> > (And why am I even answering that?)
> >
> > Cheers,
> >
> > Hannes
> > --
> > Dr. Hannes Reinecke                  Kernel Storage Architect
> > hare@suse.de                                +49 911 74053 688
> > SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> > HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich
> >
>
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang


