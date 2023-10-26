Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E36C25B48
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Oct 2023 13:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=20XxON5XilTKGJ9SIc8r5pwdKYtKKocsfNkQqf5x/4c=; b=bsNFWttPRMg8Ckz3wcz1YuhMch
	eJW24ZbwaoyYyPNy+6jN9H4UeUE4G+jxtt7N1/oRWjXh/jht4MRqOTxnbatMC9BIE9hiyWxm7xiXM
	+XlJDbxypnfxgzchV4k67LlCeWB+Leqp8fkhEveIAIVrDMo2EKSHE1PmdQHXrJWEoPb3iS8zEERSd
	6WXwF9RXZS7OlJs48qQKUMhaG2J14t+bJqedKFGjEHrnOvsHLMqof1PsP5TX848lFgGqHpieH4+uk
	y6x2kNFvWjPWuCEbPpaN/qDEd2r3Te5l8f+5SdtMcx/3I4NzOxzjPRXqK44d9MwuLEBgrH5wlcaHj
	mVg56olw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qw0tp-00Ebbd-28;
	Thu, 26 Oct 2023 13:59:49 +0000
Received: from mail-yw1-f172.google.com ([209.85.128.172])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qw0tm-00EbZR-2K
	for linux-nvme@lists.infradead.org;
	Thu, 26 Oct 2023 13:59:48 +0000
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a822f96aedso7025937b3.2
        for <linux-nvme@lists.infradead.org>; Thu, 26 Oct 2023 06:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698328783; x=1698933583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20XxON5XilTKGJ9SIc8r5pwdKYtKKocsfNkQqf5x/4c=;
        b=NUd/YRaYOMhTANM4zfIcDPy3QR/tyJyQqYbtpWk0KbOF2oUphH1c6MyeyIF8XNk/hK
         LQTAzCPLdn/3bvf8uZfMi66JkldxZEj71piEj9Db31/4pdw3God6jqJGivAHbXTslPkr
         W8dGcSxr1z0QbadfRlCxiJZNa1C2eAQKjd+SgJLST2Y+dCGBUZKu7LwT5PdxFJnpR6Im
         1oOAnDrSfSSqME2pCFdbnI3pna8LpPPkElf7VUyn+0kGXp41BrAHfv5N1sfQdPvJNYCm
         2UTwPw+lSbQIhfxC3ymJ68kZ/ToEoYIGy1Sj/zGICHSbBQgz2ce6F9U4eVfumPti7RLE
         cZzQ==
X-Gm-Message-State: AOJu0YzYBRnU/Hf4aoOcCtr7YD2bwMAzGlEtb8BsnymyEtPp6Yn4PdO+
	KMmDS+HfsXlpsPV9jrXCa2fOSJ3I3xzixg==
X-Google-Smtp-Source: AGHT+IEXVBepFhUIvym3EOtpyMR/lL0nZtd0zmW8UwyPFWf2LX6lsQvCib5OSvos3rcSIuPmXNuO/A==
X-Received: by 2002:a0d:d344:0:b0:5ac:d1c1:bd8d with SMTP id v65-20020a0dd344000000b005acd1c1bd8dmr10776310ywd.39.1698328783063;
        Thu, 26 Oct 2023 06:59:43 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id v19-20020a81a553000000b00576c727498dsm5999587ywg.92.2023.10.26.06.59.41
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 06:59:42 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-da0344eb3fdso648488276.3
        for <linux-nvme@lists.infradead.org>; Thu, 26 Oct 2023 06:59:41 -0700 (PDT)
X-Received: by 2002:a25:ef48:0:b0:d9b:4f28:4f7a with SMTP id
 w8-20020a25ef48000000b00d9b4f284f7amr19582865ybm.55.1698328781289; Thu, 26
 Oct 2023 06:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook>
 <20231020044645.GC11984@lst.de> <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
 <202310201127.DA7EDAFE4D@keescook> <20231026100148.GA26941@lst.de>
 <710149630eb010b18b69e161d02502bc3b648173.camel@HansenPartnership.com> <20231026095235.760f5546@gandalf.local.home>
In-Reply-To: <20231026095235.760f5546@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Oct 2023 15:59:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV9CcjGkpF=FGe_U5XtbF08bKTEYkPSxArO1zBwnug0Wg@mail.gmail.com>
Message-ID: <CAMuHMdV9CcjGkpF=FGe_U5XtbF08bKTEYkPSxArO1zBwnug0Wg@mail.gmail.com>
Subject: Re: the nul-terminated string helper desk chair rearrangement
To: Steven Rostedt <rostedt@goodmis.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Christoph Hellwig <hch@lst.de>, 
	Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_065946_764483_F1266B38 
X-CRM114-Status: GOOD (  22.13  )
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

Hi Steven,

On Thu, Oct 26, 2023 at 3:52=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
> On Thu, 26 Oct 2023 07:39:44 -0400
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
>
> > While it's nice in theory to have everything documented, it's not much
> > use if no one can actually find the information ...
>
> Does kerneldoc provide an automated index? That is, if we had a single fi=
le
> that had every function in the kernel that is documented, with the path t=
o
> the file that documents it, it would make finding documentation much
> simpler.
>
> Maybe it already does? Which would mean we need a way to find the index t=
oo!

ctags?

Although "git grep" is faster (assumed you use the "correct" search
pattern, which can sometimes be challenging, indeed).

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

