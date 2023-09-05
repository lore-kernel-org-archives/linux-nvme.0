Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAA5CA0FF3
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Sep 2023 16:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TI5XKlmo+CJsjgSI4p71LCm2s0UeJLQRpJFQV+gA8+A=; b=4yCoxJEwU/KcLJ12VdNHkNlGjY
	jS7+aEj4koidEejqfGFpu7ROooFh+w9YnllCu81sqW62RTBFVMDMbjFWWPNF8B6b+jgjorIptB+AC
	kKSQBLAb+IlNJB9DN6iICGmFqKLS9NwUHne8c6Zj8ANPfSnAbJEzUkvQgvk4OyfRODndU9n9wDyCC
	VzSUVxx+7OK04sZSZ2wrho7leOhukHSSjH+gfdr6+/X40BG3jqaOIBmhygcgJ9LO9L7Pw6Dcb0hZ3
	GH0NX6qaCEOAxY03I1wcSLFkPF42rchTjO+jvcleWsExjrWq6p/lppKEps0zwDEm6TNEn4+AM/Xo1
	zSVRIfYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdZAd-006OYF-2Q;
	Tue, 05 Sep 2023 16:44:55 +0000
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdZAb-006OXY-1b
	for linux-nvme@lists.infradead.org;
	Tue, 05 Sep 2023 16:44:54 +0000
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b974031aeaso45108901fa.0
        for <linux-nvme@lists.infradead.org>; Tue, 05 Sep 2023 09:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693932291; x=1694537091; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TI5XKlmo+CJsjgSI4p71LCm2s0UeJLQRpJFQV+gA8+A=;
        b=IquW8hVu+fIO1NrG7P1FnxbCBRBQK4DGxUZnel4lm3Z0a1UFE32xa5K6wv/+ilr5QQ
         4thUEHjjEQ03v80iVtPkPKZR3kGgMQ73JE1Yb+u1HhU1l0DP/J5OYFAilamG/FtaDJhd
         Ds1jP8JrF2RPNkrkc8T94gGoVjez9vIHxpWE0VaH6IFIThRyyTydGwF3qjletHi4ZlqY
         zKkblFQ9ECGtIBu7bY8CTDHyo+00LV5/a009VFiaoyVy335SIzxZHBRTm/Trkf1ZgHrt
         G6nnNV5Uynz0V27X9k9EYECvDIAsthk+so9cSU4d3YAajOFF9Q1WY+RuRvuNI66B2yUL
         6+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693932291; x=1694537091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TI5XKlmo+CJsjgSI4p71LCm2s0UeJLQRpJFQV+gA8+A=;
        b=c1CvIpoh9P37DmC0E4L0O9HrngEnEcoPUERS61DEMHmmCW3TEsUCZYVKfRdZHgzjjP
         OXoZT/jg4B4SyEtRg6VsQpRXWkkwx+7iFslZdUzZRMctONzg/Zc+Olyw3gH2DcurnQIR
         DVRk4EI4Al3u389Qm4rXGdFYLnp8q9GBGNwlq1WHlzyyYEAqFoOqs1IDX/M0GIbUwZVE
         OQOO+YaxnkGv+xhG50z3CP9tO6n5rkOyLr8MOGzeqkMUS8vgDL03Pj9SvEkQLgwSERlf
         ozHNeDYnvBdb154p4aK/O1IAelifHwRsnDNpMrs7fG7e2RmXFKmZN4F7vkmxGYyuanzQ
         nPBw==
X-Gm-Message-State: AOJu0Yxu589Z847wpdaAytm/a/wUw2osyIGtDBGA1YZPjUmP9Lu22pYA
	sqG9VzmymdD4CBQLBkdcT3UpkWkEP6Ixc2yTWPE=
X-Google-Smtp-Source: AGHT+IG1w4iLh436pA73EaV+2xRNxHjpHWMG2DVf1y31ClKfzTSnb6cWKD3jqo09RmxUQh6Pj8ePlAmpOKwmfK004yU=
X-Received: by 2002:a2e:910d:0:b0:2bc:b0c3:9e8d with SMTP id
 m13-20020a2e910d000000b002bcb0c39e8dmr216569ljg.41.1693932290913; Tue, 05 Sep
 2023 09:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>
 <faa245bf-e925-45b0-9827-b0c9c117e06c@leemhuis.info> <ZPc8v9-lHF4jAcxL@kbusch-mbp>
 <2a379b3a-6ff3-444b-bbad-0fba0bc3a28b@leemhuis.info> <ZPdF3uqbJNSZADzv@kbusch-mbp>
 <CA+4wXKCi+idhPQHx3ywdEDHqRmOyBbhz4Gj4gGr_dDvWBWohQQ@mail.gmail.com> <ZPdYgK0ebgHtDTXd@kbusch-mbp>
In-Reply-To: <ZPdYgK0ebgHtDTXd@kbusch-mbp>
From: =?UTF-8?Q?Cl=C3=A1udio_Sampaio?= <patola@gmail.com>
Date: Tue, 5 Sep 2023 18:44:38 +0200
Message-ID: <CA+4wXKAe3==K1CoSvmRpbmPcR9QK+EuzDB-cNteNB34Cgur_0w@mail.gmail.com>
Subject: Re: Fwd: Lexar NM790 SSDs are not recognized anymore after 6.1.50 LTS
To: Keith Busch <kbusch@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux NVMe <linux-nvme@lists.infradead.org>, 
	Linux Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230905_094453_559698_62FC076E 
X-CRM114-Status: GOOD (  15.17  )
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

Hi Thorsten and Keith,

Thanks for the details. I'm still unsure if responding by email is
better or adding to the ticket, but here it goes: I have tried for
days both with complete power off of the machine and cycle-booting all
kernels in succession and without exception, 6.1.x LTS and the patched
6.5.1 kernel always recognize and operate the NVME, whilst the other
kernels also fail with the same error message. As this is my
"production" desktop, though, during the week it's more difficult to
me to perform tests with it, but I will try to do it in a more
methodic way and also with 6.5.1 vanilla.

As for the reason the Lexar doesn't catch the quirk default, I can't
say I catch the complex logic of the driver activation, but I found
out how to "fix" for my case because there are three other Lexar
models in the pci.c file: NM610, NM620 and NM760 (this one with an
additional quirk marked on it on the code,
NVME_QUIRK_IGNORE_DEV_SUBNQN) -- so I guess whatever justifies the
exception for them also justifies for my model, NM790. Might even be
the case that I would need NVME_QUIRK_IGNORE_DEV_SUBNQN (not sure what
it does) like in the NM760 case, but it activates correctly without
it.

--=20
Cl=C3=A1udio "Patola" Sampaio
MakerLinux Labs - Campinas, SP
Resume Gmail - YOUTUBE!
Facebook - Facebook da MakerLinux - Lattes

