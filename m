Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562DECF6BE3
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 03:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z40aKN3SG0PtI/PdQsW28kYsRpyy2hZlmBccAVG7Xkw=; b=BqTr+MDRVSmX2N2e7+cLcP/6rn
	pe2Ke2ZT05VBdtuQLRWdwYts5wfdzWtzw/lVf73AkyaFLDm/maUZx5BqMA9Xy6m8DW4eCDreOkGBU
	qucDeTtB0FMTSWVg9B65CfSzW4WCDBREd9TsnYJaFYk2mcvsWHSrZBTZwARgELcN8hC0Un7U9ZrfX
	FtaWUyJWQmZzfFKQuNswO2BEixLM88J59IKZf09mZ3xXov5SgPtDmGFmjVgZXmdA6I3r0Oh97O1ID
	dPeOtNZdpd5gUYU624JDkOjUmHEsyoNpU5rTdjG2UBor5/95U+tcz2DsN6cLh4M3CWX7IzMPItd+j
	iZrv6T/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdK2X-0000000E76J-1KaN;
	Wed, 07 Jan 2026 03:16:53 +0000
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdK2T-0000000E75u-1Ibk
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 03:16:51 +0000
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-943d0cafe77so534724241.3
        for <linux-nvme@lists.infradead.org>; Tue, 06 Jan 2026 19:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767755808; x=1768360608; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z40aKN3SG0PtI/PdQsW28kYsRpyy2hZlmBccAVG7Xkw=;
        b=KQAuxCSSLstRpUCG8sO1X3MrZCmPfd9EZSinEyuSmud1T55JtSNu1ULOaeYZXMILi3
         ThGVds5V4nu101OxyuNCw5YMlbFtZbRhVYMwpty7Lc23MS80t+5/B6OPuI5zZdDPqY8/
         ecRZPrLbUBOyfYkMDif+Fs1MRiRPqtI97UkQXSvqOEAjlLd+rqvdB6idd/AJATPS7iqU
         iEBxhMo+A5ffbMnCQwO9jGspzghG9SVIewwACdzbn72+hIFQM1uyQIu0euWoLjboc0c5
         RXkQqTkphds64wR5zf6mFjNqFH1V2D5fsK3VYWTAF6IT+l7MfQHmWbJLLpSsv8qBJtwL
         ZORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767755808; x=1768360608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z40aKN3SG0PtI/PdQsW28kYsRpyy2hZlmBccAVG7Xkw=;
        b=Ve9mnWIYTCvg84+HCboNZrCiYQc8RkWKAvgtug20Jk89d0kDqzDiSY7LBXs7KFCF7s
         dJIfVA37y5D0T0bjOkcdZpayvycFLox8nNyEGFvWrl8u0l42p2XiWF+ygd9MZp4caE4j
         peToPy9oYXMx0sPT8FCLboQESkb83N4be4BMzf/lddyv1vkRb3V38RwgiDuUD6XniRcP
         mVmO0h8LbE2vY0/N2StcWqZURJcCUuQ1lgg6rXs2A9Oiuw2jnPGcRYJ2vwQCVY4Im87C
         hwUokmV5uK/BOqVrH4i09JCDaG3Ga3bi3z2n8cmAsl7mtI91gtFlokb7x2KxV96azVvj
         Uz6g==
X-Forwarded-Encrypted: i=1; AJvYcCX8jIKoYZ/Xy0NQ/pOsFu9fMjELt2uX8rVE9Voo8fjQiCjzjmOIM9AKLIttGfLuwGZyF8dWx/z7zDkl@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/Hc2UCZqdecNH5lFJO9XI/6cpgqYO5zSNLHL8LqoKhqNtomXZ
	6HshVxJYLkI5M15LjbQS+FyQmb6uzb3D6k9U4jT7HukpBz6NdID8r5o3Og7awGViMaI5P5lKY4g
	i3pltl2/akJgIkROE2gZeANanDShX/MOYVutlp74GHw==
X-Gm-Gg: AY/fxX5oOctjd1gWjWYk2SE+f25RQcHhIIMccMe92Ro25t5gQl3LawEq1P6bI8+Aznz
	RmR+pJ1ZSRrExMXXjB+A3Q2sMLgDIVeBRVH5BaGySMK/43eimEHsRBT1H52dNqJlWW4blAesQY/
	1s++IemBrc9RjeAIGXPMkjwAbdSJJ2xj0/2ZM7jSx6J/frqNAfOwQLWuOi4xGkd3FgK5c63845A
	byqQhd7KY0nAuIRWlzrqUgAXVYCk68bLLwOtAYnsEf2MDhHfPCD6NzhQg/buZ14Cz28xcw=
X-Google-Smtp-Source: AGHT+IEjRlZp1SfTrcr5oPFw793tyAdjOpxxkaJ6P1rGh+EfNGDVI5ZBHDgI0gdXH521u7lk3fu6YvSWPlCXft1fAYk=
X-Received: by 2002:a05:6102:598a:b0:5db:e96a:8bfe with SMTP id
 ada2fe7eead31-5ecb68586fdmr307585137.13.1767755807892; Tue, 06 Jan 2026
 19:16:47 -0800 (PST)
MIME-Version: 1.0
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-9-mkhalfella@purestorage.com> <c698d201-0099-47a7-b5b0-d2322da63ea0@grimberg.me>
 <CAPpK+O0dmysf6HxQN68q-JzSm-YATXQ1ZUcz-D56-+4WE-Aj7Q@mail.gmail.com> <3fb01be3-e162-42fa-8d75-2e96a89b2004@grimberg.me>
In-Reply-To: <3fb01be3-e162-42fa-8d75-2e96a89b2004@grimberg.me>
From: Randy Jennings <randyj@purestorage.com>
Date: Tue, 6 Jan 2026 19:16:36 -0800
X-Gm-Features: AQt7F2rxjegci74KnHG9FN8ANo-m9VWewoNgE2KeNtnqx2PHyWANebl73bN8OCA
Message-ID: <CAPpK+O152NEqCrzzLEsUiDiO=CS6OYLfeZ4RN-KGVSH2XTXMOA@mail.gmail.com>
Subject: Re: [RFC PATCH 08/14] nvme: Implement cross-controller reset recovery
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Aaron Dailey <adailey@purestorage.com>, John Meneghini <jmeneghi@redhat.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_191650_023468_D9564E99 
X-CRM114-Status: GOOD (  33.50  )
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

On Sun, Jan 4, 2026 at 1:14=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wro=
te:
> On 31/12/2025 2:04, Randy Jennings wrote:
> >>> +
> >>> +             if (!ret) {
> >>> +                     dev_info(ictrl->device, "CCR succeeded using %s=
\n",
> >>> +                              dev_name(sctrl->device));
> >>> +                     blk_put_queue(sctrl->admin_q);
> >>> +                     nvme_put_ctrl(sctrl);
> >>> +                     return 0;
> >>> +             }
> >>> +
> >>> +             /* Try another controller */
> >>> +             min_cntlid =3D sctrl->cntlid + 1;
> >> OK, I see why min_cntlid is used. That is very non-intuitive.
> >>
> >> I'm wandering if it will be simpler to take one-shot at ccr and
> >> if it fails fallback to crt. I mean, if the sctrl is alive, and it was
> >> unable
> >> to reset the ictrl in time, how would another ctrl do a better job her=
e?
> > There are many different kinds of failures we are dealing with here
> > that result in a dropped connection (association).  It could be a probl=
em
> > with the specific link, or it could be that the node of an HA pair in t=
he
> > storage array went down.  In the case of a specific link problem, maybe
> > only one of the connections is down and any controller would work.
> > In the case of the node of an HA pair, roughly half of the connections
> > are going down, and there is a race between the controllers which
> > are detected down first.  There were some heuristics put into the
> > spec about deciding which controller to use, but that is more code
> > and a refinement that could come later (and they are still heuristics;
> > they may not be helpful).
> >
> > Because CCR offers a significant win of shortening the recovery time
> > substantially, it is worth retrying on the other controllers. This time
> > affects when we can start retrying IO.  KATO is in seconds, and
> > NVMEoF should have the capability of doing a significant amount of
> > IOs in each of those seconds.
>
> But it doesn't actually do I/O, it issues I/O and then wait for it to
> time out.
Retrying CCR does not actually do I/O (trying to place your antecedent),
but a successful CCR allows the host to get back to doing I/O.  Every
second saved can be a significant amount of I/O.  If you were given a
choice between a 1 second failover and a 60 second failover, of course,
you would go for the 1 second failover.  However, if I was given the
option of a 10 second failover and a 60 second failover, I would still
go for the 10 second failover.  50 seconds is still extremely valuable.

>
> >
> > Besides, the alternative is just to wait.  Might as well be actively tr=
ying
> > to shorten that wait time.  Besides a small increase in code complexity=
,
> > is there a downside to doing so?
>
> Simplicity is very important when it comes to non-trivial code paths
> like error recovery.
Okay, yes, unwarranted complexity, even with some benefit might not
be worth it.  I can see that my comment could be taken as flippant.  But
the extra complexity here yields an important and material benefit.

Sincerely,
Randy Jennings

