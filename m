Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4370EE8B386
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 00:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IEtk4K7SrzBHxIPBCCAHD5EGhC4ZwNMcIGWq2jeii9k=; b=RLJHBA4ZR1eAeMgx2fW0bUk/VA
	pqNsYqx7yzbtzTRX6pTQjqWOBlHr7clLPZHlSOOwma/ieFuIynwMCRwIKwRNWcWmkAqsYO2Zs0YCW
	1kEc5b6a+cCYO/JXYzATlLYZyr9nfcFFTJac4H57nkPIOFxYXQ+hVhBD1vwX4W/Ym2wwoT0NbTRIs
	Vg/vEsqsSAAWfo+PJAeHAUKHMb6ph5KWyGiAlmTmkx4OGEvJ3Rb+JVVcLPlM2gVDOPvNNGbQj7ziP
	NqAwh9BipdQ3FEISRUOJoFiCjyd6rEsP2j15S4ZdGiSGN7ube9vF7J8LKrpNGxLaAhOZC6IkwKL7h
	duKniCig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnR4V-00000007eRe-0JAT;
	Wed, 04 Feb 2026 00:48:43 +0000
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnR4S-00000007eRK-0Cj1
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 00:48:41 +0000
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-5f52b0728ccso1789911137.2
        for <linux-nvme@lists.infradead.org>; Tue, 03 Feb 2026 16:48:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770166118; cv=none;
        d=google.com; s=arc-20240605;
        b=ZkzWhgzzDB+byEIF+InxP0Th2Ct2POCQsOW7/1HjWERyyGqV2TPc50eAZRZqFTOpNV
         xLg9eK4S1rv9asUW4aW6SWvgZmutkaVYAqZL8XEoCkBb3ZJSXp7lrsA77VP8WInHksSb
         33dyP6mhUQX/HjoqJjpbtFJ6eQSI92WOffk0lPgN07BgFsKu6Y5BtgL/j3uUvcIEPitO
         k8oJz0DzNEuOhvzK50ixwQ4aslRBq5mwlc69tgb2xHxUxlW9bo8NTvWEpIsvFFeOcQjN
         NU3sPwZ2f0b5aLvs1PqkH6yQFOGNHvWbEE7JoUi5SjCPdEp/jV3KrJlUPCpOnp10hhlS
         q4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IEtk4K7SrzBHxIPBCCAHD5EGhC4ZwNMcIGWq2jeii9k=;
        fh=cJW7f8VRKcF92uFs8AQLKE1CCrpDQHR/g10YAAZMU4E=;
        b=Snr+Bv9Bb4Fk0nN8azOBzSBc2ixzR9OGgB+adm3Qe7Y1ezlXvW0MQ7lXJSq4b5O+Go
         N/LqF4PhtasW+juR02Y4HDhtif+cQeZ9Nb64HYzlM0ifIcIyytJbRHhsjW1Msk8yOvoG
         aWcrDBII/Q6XQmwdi0aKBn8fCnlGARm502XwhcyyM2XRwCswNljP6EmdcDvMK9MzICJh
         CDQEF7dzqXNxMtb+4RNmdqypqqx1FaPEGXqSkTt/rRuUWCQrvRbPQxvhs+yzOK338Wqi
         zPACSs/VQXIfd8cIfQMmpIyKx1qQ0cZQct1h0XU/v5bffmdJSgbKHbsiQxnhd0u9ABBL
         eN9A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770166118; x=1770770918; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEtk4K7SrzBHxIPBCCAHD5EGhC4ZwNMcIGWq2jeii9k=;
        b=ZGhVlYcGOkAfdP5wuuUIxx+u/mrxQGUEGb2BEGDNTk6Hm4exU5rIbZ91uFxEwAcVhV
         dbeQx6cB5upsO1wCPKiBtBJ9fZ/xCDZEMVcJFcDrnWPZn6VzbGeaWqJJvPuaEI1o7bJv
         CwSYq2KM6Z5TlpBij6IxXF1NeAkRce6yiOzDRpjixbcbfHmiZGbaQI0BSIoXbd8p6Qdc
         /Rv3WWeLvMF7OkYviMksKY6d1tH1CqJ9UlJqsCKzbre14pvnbNVpgZgbFqg0UYILvejd
         jgyvsarHmVbOPQ6MrcYbT5IboOiA6oAJRgly5+mWeq/oMotyFL3CRxw7MrbO2CJoPgLR
         vw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770166118; x=1770770918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IEtk4K7SrzBHxIPBCCAHD5EGhC4ZwNMcIGWq2jeii9k=;
        b=twzvNwyzB7o1B7uMdNSotO3cThunL3bRh6cxa4zNeL2QxCkhouiSwV77AIN9uOwMHx
         FIR64K6VeO+LGwO9ezeBxVH0nOMT7yBHI8ICG2Q40V6fJeTEzv+5KvVVCQCTWk+ADjuk
         gcAS+WrP8WIxoMLg9wpCW8135tyt2d9nwKgsBNGFSqYoZZqvN5i0i2XhZilFgdiCQ4yD
         HWWbNrbI2E6RQNYfvQnM+37lNYdoGfx4TCsulvDsWQnOgFu+CjPzh2obo57dd6b9qOpv
         iEKq3n9bTG9julxseO3IKtflB6dakUrLkXh6vAmwTVSQJ/wNX95fpKXgzs8pWrGe/lk3
         yUTA==
X-Forwarded-Encrypted: i=1; AJvYcCXorHAHvbZsR8vPBemCALC86lr4ku/ufSQ5SrPdoHZi7n25dBKdNXBWWvqRgsQRhRMkzFIBzRXQAOU8@lists.infradead.org
X-Gm-Message-State: AOJu0YxrlosWNHw1P5nL2Ahxa8GKJuLOaaicwrLthpk8s+KGMhjW7nem
	DdqRDHiPmBiUGBMwY3kiKdLOZLKZhAN96DffR7/I8mN5dGiHlxNzPS7ZkzT4j1QqdLWyvvbKyXe
	yGj/fRW9CpsdpTkV2PtSVtl63Mmr7GFV+2WvoOBhZRw==
X-Gm-Gg: AZuq6aLuQbvqMCBS6EyHNysbSP/5O8HH3PFnUbNxzDtdO4UnopHBYDYUCv4hnDwRnLP
	16u8vkBGEmPoZaJ1pAj3H0zMIDzzN6eQNlo7OIJaeFa0VyjVd9qWl30ILZPzY2WgoJkkXZoFdhz
	/u3KjuCsbnfiLH/jwJk4uD+cAqxbdpYssqyadKe6B0hFByBWTp++RJK9F+h3SrAPWEXkP58Xq+S
	mwLbVSwsl3OCMchIZb4y/k4ce9wZXuKDIe26MwYCBM+cV8snjVt+KtaNzR/H8bh7m6MhCg=
X-Received: by 2002:a05:6102:4189:b0:5f5:40ab:2d65 with SMTP id
 ada2fe7eead31-5f9395b9e53mr404779137.22.1770166117839; Tue, 03 Feb 2026
 16:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-11-mkhalfella@purestorage.com> <48a05027-9ca2-4e84-a7ac-946391ed1e26@suse.de>
 <20260203212409.GG3729-mkhalfella@purestorage.com>
In-Reply-To: <20260203212409.GG3729-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Tue, 3 Feb 2026 16:48:25 -0800
X-Gm-Features: AZwV_QhKZwOQq-2Ez7TLCQKr5FlZEaQLu6MxnV5RYtPTvTZCZU-sju74ZS5ke38
Message-ID: <CAPpK+O2FNnyk5V7L83uMXsFg+yVhDztka+UW5-tKsCVA5TgSFg@mail.gmail.com>
Subject: Re: [PATCH v2 10/14] nvme-tcp: Use CCR to recover controller that
 hits an error
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Hannes Reinecke <hare@suse.de>, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_164840_119821_D5B7F254 
X-CRM114-Status: GOOD (  23.42  )
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

On Tue, Feb 3, 2026 at 1:24=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> On Tue 2026-02-03 06:34:51 +0100, Hannes Reinecke wrote:
> > On 1/30/26 23:34, Mohamed Khalfella wrote:
> > > An alive nvme controller that hits an error now will move to FENCING
> > > state instead of RESETTING state. ctrl->fencing_work attempts CCR to
> > > terminate inflight IOs. If CCR succeeds, switch to FENCED -> RESETTIN=
G
> > > and continue error recovery as usual. If CCR fails, the behavior depe=
nds
> > > on whether the subsystem supports CQT or not. If CQT is not supported
> > > then reset the controller immediately as if CCR succeeded in order to
> > > maintain the current behavior. If CQT is supported switch to time-bas=
ed
> > > recovery. Schedule ctrl->fenced_work resets the controller when time
> > > based recovery finishes.
> > >
> > > Either ctrl->err_work or ctrl->reset_work can run after a controller =
is
> > > fenced. Flush fencing work when either work run.
> > >
> > > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
...
> > Here you are calling CCR whenever error recovery is triggered.
> > This will cause CCR to be send from a command timeout, which is
> > technically wrong (CCR should be send when the KATO timeout expires,
> > not when a command timout expires). Both could be vastly different.
> > So I'd prefer to have CCR send whenever KATO timeout triggers, and
> > lease to current command timeout mechanism in place.
Hannas, It is incorrect that CCR should be sent when the KATO timeout expir=
es,
not when a command timeout expires.

KATO timeout expiring is what happens on the controller, not the host.  The
controller behavior is specified because the host has to know what the
controller will do.  The host is free to decide that a connection/controlle=
r
association should be abandoned whenever the host wants to.  It can be
either a timeout on a keep alive (which is not KATO expiring) or any other
command.

But once the host has decided to abandon and tear down the connection/
controller association, it has to make sure no pending requests are still
outstanding on the controller side.  And that is either through CCR or
through time-based recovery.

So, if, after a command timeout, the host decides to cancel/abort the
command, but not tear down the association, we should not trigger a
CCR.  But, if we are tearing down the connection (and there are pending
commands, we should trigger CCR (and start time based recovery).

Sincerely,
Randy Jennings

