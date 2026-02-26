Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C1FFD45FF
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 01:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sEWUQMZ05EtBjzI5lji+PdbLp/pfTrbiE6YP6gDAUAk=; b=XPDL5NJ6Uh52oatWedfwAhGv6E
	scqelRQpAe0vHqrlXHzmJDNIEI8UVuLgOnn7fxEN1lOEJUEXj2MtdGPelIxc+qmqrxdsKK2ywsR6h
	g4IH4SiicTFJ1Y92WzGaL4cBL0mSgIKmIxcZFif2lvTeIRWH8x4vzzqFAQUAePUZROI2BO4G7yr/m
	lYhsbMkC1gGigGjaa14RntSFXyQezA0LnNakuSpzIkOXEbn9wczwwXbC9wKqOsAtWQpjMor2D4uET
	5kM1Y9P9kAcj2iHR+RSF8Fx2KL4ULO+HBymxZBhYCtNlmuqnND6rJqt66183P5glHqCFaHHO8RT1+
	LxBhwMww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvQEp-00000005BnO-44Zx;
	Thu, 26 Feb 2026 01:32:23 +0000
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvQEn-00000005Bn1-1XnZ
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 01:32:23 +0000
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-5ff19e74779so168098137.0
        for <linux-nvme@lists.infradead.org>; Wed, 25 Feb 2026 17:32:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772069539; cv=none;
        d=google.com; s=arc-20240605;
        b=JMiI5O9ydRIK/pxNUHjhZTrbIz7jmAm20WLwVuI+vlLx4j9U2+URGSm/e9muaLPrgp
         3KcHVj1EdhuVm1s0b6px6BaJ7dggT4Pldxkifmh8cdJhasDZ8W18hQmAwpUuMgkBq5Bo
         jt1eTJLILUG+8n/yuD46NdV+3mds76JhjHYuSKntGdCU+jTnCSO+CchIEU/8bz2Qe9Ot
         3IHbdAl8eMo16I3iik0xhF/m2QxI9JcAGOE1QNEjMIoLk+77KOHWTgU2BZdgrIvjEw/a
         L2m65LpTAZiQIiAQLc6FKMSPF83VcpopQPdz7JhBqrLJyIGAyK33gMWfC3ff7/hUTvIp
         py3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sEWUQMZ05EtBjzI5lji+PdbLp/pfTrbiE6YP6gDAUAk=;
        fh=twMB5GDl5QIZsVr3K4XIDNW8P6A9YiW0raI3ZOvIYQA=;
        b=a0ERKou5Hk63JvgOhTY3nnh6ZljbO1YBUvAbFBzOUysI7I1T235M+BilrFIA2Kf2dw
         RufCIDwAS+NvdgiiP3u+6z4Z2a/FO5okBqqcwCLq2ri0/+hYzDFwZydVnUnkymS2WdKY
         CvY98AdNyGJWm6yvMJqwc2JQW6Ddpx9PC31HzybyPBup4P8scvaD3gMqkMZphVDfQWaQ
         ZsBVb/kSxUA0Hcw1+xzIUAME2vqNHfF9vgTCI8SXiDsxJDj+MwwcYwFkIzXJ8l1LVLsA
         8s2S/3Hy2ukhcFACayJzj7O8+is+or4F82X/PtYqkcV8Zr2kTYvNFvJxf60z/GqDp7Ko
         1MoA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772069539; x=1772674339; darn=lists.infradead.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEWUQMZ05EtBjzI5lji+PdbLp/pfTrbiE6YP6gDAUAk=;
        b=QDVHbZLOPdKGkjFrb2jGsagWbQ9D4HV/xfdHl6fYultS1K+htxTMXve0RFw2jMJO9S
         EL0ddaWOGxX9jCT6cHagvxteN9W96xBjE1htBMSOCy4BdohondRMtMv9eSkj5WrfW7vx
         MOlgwoOrG1nfUdafTL2MsDo1sjVFRPH/r36IJwSNfl6chyMfzzy1t5gbLmROrUyU2p3j
         3pJCmjuTCjmXirn4Gzmqaxj/j7k1nii+Rlrg9nCDwHpqA9zH8Vw88efXYiPd53Sgq0Wd
         pmaeXHi0EG1l+gR+RxNyxDAfDoodPG4y83kQ3S4+Njq2W1fxNfn0c4uvYfDqTyXSJD9i
         kTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772069539; x=1772674339;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sEWUQMZ05EtBjzI5lji+PdbLp/pfTrbiE6YP6gDAUAk=;
        b=krLpogfeVJ1gBwq0lwtJwnh+wdrtwB3B0VLFA6OLVf+FB8YeGMxAVbdiYaeVrWhhP/
         JHcuZe9ZKCde5IiUBE/DRLVTRBQW0JFdEZfFiay58dApLc6wjPUb32H3kYf8ZRAoOlCk
         iT8jziHfgTq4CBbloBEE4vCMTss681y+JbjOUl9PIzL0Hk2N9ZGccNvnsdGFJpfN1YB8
         5bkE6Z77JUz+WTR/axWWc9zXALlrgbKoRelefoeFDYIjiE4XwgO+3cjr28VIGsyFmFDM
         Ll/0xA6hY8E58ZKp6U5a1tSPG9/oBvFjJ9dzdsNG6FoGqbBb5eJqOPglsqLvYq1b43WD
         dUaw==
X-Forwarded-Encrypted: i=1; AJvYcCXw5hLrG8nJ6kkREj1A/IQOnGEAruiQHZF8dbx/N2QUcyJwK/lTcUfR1wOUL3Fyqo4H13CCsqQo+gfs@lists.infradead.org
X-Gm-Message-State: AOJu0YwmuHxEq/DCmXgicVz22Jt+RftFKjLS5VQKZCd5/FsneOnaj7el
	OBZIn6Pd+iBFKxjS136FOdCg9imdge3fQ4+FdtU1M16xSm6ZuTfk3ZZ+njKwvlGDRn+qK7Ozvj2
	14KQPl9ht0eli+KVzvgmgYnlQJ7kBsTz4/XW6WHmkWaXIyipDwwBI2pM=
X-Gm-Gg: ATEYQzxVd7vVzqYL232n5+z0uc1+CqosAGvCwBGJ1s4TpkS96zp/+EzaeL4/0WI6vOI
	uDgwhjHrbF+KUeQATeYQgzID8t0fPkvb5NFwb2bG4y6M9MBg6Sh3ONEkabui7otoGIdI3D04Su9
	da5HHv54F17U5gxWR2oWA42jb6SWVSr8wfMl4ZZIl9Ay5/AIBwdTiicvUg9XD/7T0PT2pe2xHHU
	H+C3unChRSF6zl9V7oq03EsqeJwjxuGCIgweGf1F5SQGEllkuqeaDyGux8AwejxH7XNjjWRSbrC
	ZUSj7GguvbMmQTQ6DOfuRQCar+2+W94nRpGO85Urmr8t1mFtwlrOvjlvDIjaZJCiOIqS1g==
X-Received: by 2002:a05:6102:2906:b0:5ff:172c:2d92 with SMTP id
 ada2fe7eead31-5ff209d5c8fmr265860137.8.1772069539167; Wed, 25 Feb 2026
 17:32:19 -0800 (PST)
MIME-Version: 1.0
References: <CAPpK+O3zB4Y7L6u0jmVkM2eQs2D1DEJJMG_AXgM+HBs4wkLStg@mail.gmail.com>
In-Reply-To: <CAPpK+O3zB4Y7L6u0jmVkM2eQs2D1DEJJMG_AXgM+HBs4wkLStg@mail.gmail.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Wed, 25 Feb 2026 17:32:08 -0800
X-Gm-Features: AaiRm51dXLBdHZXafeN6ZXBh2Im_3ISQg6sNjkDbyPISk5yYAa9nQxnE66RBpXw
Message-ID: <CAPpK+O3fFkbs-E05a8t+JfwCb+Wpj-trNOi05uO_zp8wF65nCg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] demo Linux nvme initiator driver stretched and
 dispersed subsystems
To: lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_173221_556424_367CA120 
X-CRM114-Status: GOOD (  10.43  )
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

On Fri, Feb 13, 2026 at 5:16=E2=80=AFPM Randy Jennings <randyj@purestorage.=
com> wrote:
>
> I'd like to demonstrate the Linux nvme initiator driver interacting
> with a stretched and a dispersed subsystem, run through some workflows
> and illustrate usecases that are possible with one and not the other.
> No, this is not necessarily production code.
A few more details:
I am still interested in extending the namespace mobility and
synchronous replication use cases to NVMe. As instructed, stretched
subsystems have been implemented on Pure=E2=80=99s array. I will demonstrat=
e a
Linux host and Pure array stepping through these use cases. I will
also demonstrate and discuss the limitations that come from this
approach and solicit alternatives. Finally, I will demonstrate a
hacked Linux initiator that implements dispersed namespaces that
avoids those limitations (this is not even a prototype, just a
demonstration).

Sincerely,
Randy Jennings

