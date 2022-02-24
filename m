Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D212C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 23:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HqdafFZN7Mg0MLzwQvGvjz2TufWUH4f0XGT1MppWkVw=; b=ox8YSCnt4ZzUzB/Xo2kdM7qK7g
	MwxFOVa9YdGpTWUcMrf/0Ssn/sfxRcyVVL3LlKAwSO1pWzynkEidwHRhu09ZCsFtWu7JWMeQFVj4X
	q/qVWK6qv/OUoYrV3ddzLcrh2GWg2lroCUbWyfvTFWXAMouUA3nl/M3iP4OGg9toiObZ6c4l4DMx7
	NoAg0TUWyog+Znk1Vp/qrKtnJ/0ogUT8nJIhwm8C5CtcWFoEiZDHfDjEZuXKuYhVroWWLJWxLKnNC
	K7kWQ5xEyeNTYKXF2BKa+/C4Q6z5YPXi90ZGmsPvNncFz13I2fKuhge6lbAayODfxWNJwXm6fqe+X
	XTDZVODw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNNGI-002fPN-Iq; Thu, 24 Feb 2022 23:11:02 +0000
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNNGF-002fP2-Dg
 for linux-nvme@lists.infradead.org; Thu, 24 Feb 2022 23:11:00 +0000
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-2d641c31776so15125897b3.12
 for <linux-nvme@lists.infradead.org>; Thu, 24 Feb 2022 15:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blockbridge.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HqdafFZN7Mg0MLzwQvGvjz2TufWUH4f0XGT1MppWkVw=;
 b=YdWTmijlIe/pjO8587kaY+3Wx8+8dezqvEMnOhapN95l3NW1IeMqxYOPRMu98Xv+7Y
 9920sKXpIVI1UwrJo+NQKv8RdwL91RbrdZ6+IfAQuIMXu2wHap5WjWH0NVkchf2JBpAS
 +IQVvAGnQ1IuPP9bcJLI3KXO4L8Knm9OpZsfL3fr+JE4r0C2Qx5W0QP0932E5D4uBl0M
 AM0jNkLwaTZDof48yEjdShjRLvd3vLdkYc9mwTkdFv7l0EBC1Gfb7se688nZunVVAlPf
 4BwmjkSryp+/ZabYS80x2FXkhQ11d7j6nGHnFiLwEomd8PM35qeJKr6rK2xkKg8l0Vt4
 P20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HqdafFZN7Mg0MLzwQvGvjz2TufWUH4f0XGT1MppWkVw=;
 b=dFJiboQBUqXVbuTTPROBSCPZLgPD19z8GxF+uIEjTPUUV3RppkOxxJ4O0fBGlJ7MI+
 wvoZ8YnfRQKT6ydvuOqKTBvjESFW3Bp0LE+Jidev5bXPdXH9KvedBb/WtY4RUcqpsToX
 l24FI/07FyGwf6zrnOI97Za1mbkj8vXMyJWST5uYo031CzC4tm9ykBh6y9XP1Of/Tu4Z
 /LV0pF7kFIIDJfV9DkmxaDHjLcjTc5grQaepEGvIhhlGCVq7gH7CxK1W1eiUoFOaoIKt
 9M3Z6xA6XWGToUzSr8/lYcZ1B1UMTb+o1h6BLSbBn78nmfV+ZNLNh5gycjMFlBx8q+UR
 xKJA==
X-Gm-Message-State: AOAM530KxISiaXQscILVlAlIKp30vu7lawxLpUGApV/yP/IroNSiEzPw
 nV/nO3GOoh/q0xrm69M0wJkKYK6Rpe6VIkyBNOrS94MLih3fiw==
X-Google-Smtp-Source: ABdhPJz7f5CIO4mQx5TCN6zFEQJUOmlDhIc4D/KxTDYTalKEHMKD9wh+nbzKm9g4zTaWYTRObzenNUicF8jl3A94H1A=
X-Received: by 2002:a0d:d908:0:b0:2d0:c7c6:b569 with SMTP id
 b8-20020a0dd908000000b002d0c7c6b569mr4817351ywe.412.1645744258569; Thu, 24
 Feb 2022 15:10:58 -0800 (PST)
MIME-Version: 1.0
References: <CAHex0coRbCPVnwVfeHYVxLHQp3HRd5V3aWZJ5uVwyyr-zk9=Sg@mail.gmail.com>
 <d01b7cf5-e46c-0cf3-5e58-64547f84817e@grimberg.me>
In-Reply-To: <d01b7cf5-e46c-0cf3-5e58-64547f84817e@grimberg.me>
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Thu, 24 Feb 2022 18:10:22 -0500
Message-ID: <CAHex0crgDtzTcC1BMECvPsCUcdn_CtPeLLKQAtF2R=Yc=kELTA@mail.gmail.com>
Subject: Re: nvme-tcp: invalid h2cdata pdus in response to r2t
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220224_151059_492217_A53813DA 
X-CRM114-Status: GOOD (  19.48  )
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

Good news. The patch applies cleanly with offsets. And, I can confirm
that the host driver issues multiple data h2c pdus correctly. The
various combinations of digest options work as well.

Of course, there are options for target implementations to avoid the
need to send r2ts, but in the interest of correctness and
interoperability, it seems valuable to fix this bug. Whether or not to
shepherd this through to other kernels is a different question...

On Thu, Feb 24, 2022 at 4:22 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > As recently as 5.16.10, when a target issues an r2t, the host driver
> > responds with an h2c pdu of whatever length was requested. If the
> > requested r2t length exceeds MAXH2CDATA, the response causes a fatal
> > transport error.
> >
> > In reviewing the code, the driver does not appear to generate multiple
> > h2c pdus in response to an R2T. We're a bit confused because commit
> > 1d3ef9c3a39e seems to indicate that the code behaves otherwise.
>
> Yes
>
> >
> > I can see there was some discussion and work on this back in November.
> > Is there any plan to incorporate the fix? If so, is this likely to
> > make its way into LTS kernels?
>
> We'll need to see if it applies cleanly... If you have specific desire
> you can send a backport to a specific LTS to stable kernels.

