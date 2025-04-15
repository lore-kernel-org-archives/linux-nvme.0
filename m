Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBC2C369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 23:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UWD5pI6GDA2fnJlpFdI06Xm5PY6v+zWnkPUtQT6JobI=; b=FTkBCXruGweKmi1gP1VLA+EwdX
	rh+Jmv8LFf7RHfx/le3KyTlPlTEdMvEPnQOsUf0x2mpQZrFtSYQckg5NozjIXXyxTFbICqLPwWqGR
	obyrCRCrYh6/xKJN3lxwM+j/dEVxUERQllH75D473vlvZOcB8yZoYpqPjhFzKMIW3VALIogNOiAe0
	oYTpTS+3UrZctFMnjTGoMxfmGwW9MYqu2xcT/lczxGCS/bnSdm7so6fB9Fmt+KjsCOlrqxQcyS6YU
	Y4i4zBHaDXONFL1MfBlAfWVPLkg0Kwi8BbHg9blhfm5/MrgewcbxWDSM/GCcwp6G4Uf/w3t9L0C/u
	laN5bSTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4q9y-00000007Yud-3JKX;
	Tue, 15 Apr 2025 23:57:46 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4q9v-00000007Ytt-3Ad0
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 23:57:45 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso70889565e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 15 Apr 2025 16:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744761462; x=1745366262; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWD5pI6GDA2fnJlpFdI06Xm5PY6v+zWnkPUtQT6JobI=;
        b=Z/KBld+fLYbdlULrgTi6ON/EdRdX4s6usdckl/WBvnoPCH3jj0t5KMO4LfWTcwr2RF
         I5QQjhijZH9EelGjjwBp2Cgf9jgo9hZWeWugXqZe6dN+CCHyqGYz8kB4w3i4j2l5jjvO
         vffWRL4ihi2bnqhxCqB/52Dn8NylMrbYCCDHhad7HkKbzZ3yyIPYJ/VHkUEJBg7mg2n+
         SwaXTIe9l2c7CtrtGegskd25vSlNOYCGbiJtu4A+rYkaLWCCCuUU6R/HD4fx7uSWcSni
         YCqOfVfrXGZSbfdjPCFaLBwmHKElGrLhW8VPK25zZ9pzDx3biSB6HS8TFez+ptUBDIB+
         0NBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744761462; x=1745366262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWD5pI6GDA2fnJlpFdI06Xm5PY6v+zWnkPUtQT6JobI=;
        b=g7VXlU2H6t0Ugf899ySO7NWMKOu21Ggg0j17VTL6nSZvMFBMANWd79jQ9nupSizfNM
         IiVuoW8jSUQVdTV7yjZc1wwt4eHBhF8jIVGJe9iY3QG98YYv2p0lhg3aPEYLhavsSWSd
         CEEz+G3aypfzQNDXtT0B3G1XYAOy/nRcPJtB5BTeKWPvG/aX/chiL3lUgQOJrVWqgyXf
         3dBMYO7vGAbVqWyD+0JexbySOLkcBaMo2MNPHPJRKOMCGf8HzILsR1gXv4R1qsV5/uKZ
         xddCDfah1E3sjy7fN0a5izq8uJEvvVg/PLS0g6HyYUejP9OXvxRve7Hibq7VpXG11i7B
         zowg==
X-Forwarded-Encrypted: i=1; AJvYcCUJvYZ9Z9LbosRtf7Xow3Pil8vAjoulUvutNE/a2YHmXmx9zL3W07D4uPp8Wzs1glZKO9Zc/dF/6Ufc@lists.infradead.org
X-Gm-Message-State: AOJu0YzTDC70KjQCQrIzQBTOAvmgiMsm7pyoU58MMuOHilUx13FVuQMM
	5SgKicctNRPU+2B1mfYchuibnnhTBA4MOUXKNjyGflYq5ON6OAZ0X22VUGT2U0Fa6Jx5owIcEKX
	jL4i5gS1xhTsXnF90BsMDsGem2vNZHtcbHkPIXA==
X-Gm-Gg: ASbGnctuuIgsOegwhxgSFY0qWrfc7CCDsvoCEgdNoy55oftmEOKYoRiCTaw9QhSKz3O
	Pgzi30rcHNiSXNk+cS2Esr1XiAyNCrRtU50u/WLiOvtCdjNk3yYN1W+GMcesUNfOdj9spb32r5I
	dlOymfRAttHonG+mWgspd+txC5iVq2v11Acw==
X-Google-Smtp-Source: AGHT+IGGD6454gToVDn/IoUIEfR1+ItsL/HISjK3ehJg9NVRI5QeW5I9RnXyLdaCHCAikYx5stTntOwf9Gs+iVc7lQw=
X-Received: by 2002:a5d:5985:0:b0:39e:cbd2:986b with SMTP id
 ffacd0b85a97d-39ee2729edcmr926257f8f.7.1744761462016; Tue, 15 Apr 2025
 16:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org> <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <20250410085137.GE1868505-mkhalfella@purestorage.com> <738a41ca-3e4a-48df-9424-2950e6efc082@grimberg.me>
 <4cd2cbb4-95ff-4f3b-b33b-9c066147d12b@flourine.local> <4c334216-74d7-4a30-add1-67b6e023d8d2@grimberg.me>
 <CAPpK+O0tmewK7pH458TOxjtimjO9on=4YDRFbS=FPTgM+KFTzQ@mail.gmail.com> <8ac6cc96-8877-4ddc-b57a-2a096f446a4c@grimberg.me>
In-Reply-To: <8ac6cc96-8877-4ddc-b57a-2a096f446a4c@grimberg.me>
From: Randy Jennings <randyj@purestorage.com>
Date: Tue, 15 Apr 2025 16:57:29 -0700
X-Gm-Features: ATxdqUGpEGX9YZAHGCTlBMQHQBANn-EtpiIizt1Virtao_yXmWw0UoGELM1OZAU
Message-ID: <CAPpK+O2SBm6-zqbiDbUB0yubVTvTrXWn1R+GAPne_+LGvVXp6g@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <dwagner@suse.de>, Mohamed Khalfella <mkhalfella@purestorage.com>, 
	Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Hannes Reinecke <hare@suse.de>, John Meneghini <jmeneghi@redhat.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_165743_846037_6FCA8E61 
X-CRM114-Status: GOOD (  27.59  )
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

On Tue, Apr 15, 2025 at 4:35=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
> >> What I meant was that the user can no longer set kato to be arbitraril=
y
> >> long when we
> >> now introduce failover dependency on it.
> >>
> >> We need to set a sane maximum value that will failover in a reasonable
> >> timeframe.
> >> In other words, kato cannot be allowed to be set by the user to 60
> >> minutes. While we didn't
> >> care about it before, now it means that failover may take 60+ minutes.
> >>
> >> Hence, my request to set kato to a max absolute value of seconds. My
> >> vote was 10 (2x of the default),
> >> but we can also go with 30.
> > Adding a maximum value for KATO makes a lot of sense to me.  This will
> > help keep us away from a hung task timeout when the full delay is
> > taken into account.  30 makes sense to me from the perspective that
> > the maximum should be long enough to handle non-ideal situations
> > functionally, but not a value that you expect people to use regularly.
> >
> > I think CQT should have a maximum allowed value for similar reasons.
> > If we do clamp down on the CQT, we could be opening ourselves to the
> > target not completely cleaning up, but it keeps us from a hung task
> > timeout, and _any_ delay will help most of the time.
>
> CQT comes from the controller, and if it is high, it effectively means
> that the
> controller cannot handle faster failover reliably. So I think we should
> leave it
> as is. It is the vendor problem.
Okay, that is one way to approach it.  However, because of the hung
task issue, we would be allowing the vendor to panic the initiator
with a hung task.  Until CCR, and without implementing other checks
(for events which might not happen), this hung task would happen on
every messy disconnect with that vendor/array.

Sincerely,
Randy Jennings

