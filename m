Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9D8C3600C
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Mar 2025 23:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZEq/Fka6YRBKENdOliwx1ILIyB+IBRwt7XPFaRfOBxw=; b=DPOpM4jyxlzqS+QRNSgRiecBva
	tVrkzwEtCoVOON1lIKyX8g9sLb0X9/dnwvdB5WpQ6uGbWkEZLMLUK9peE89M/giCN9gs/q+fPQ7na
	9Q4IiIkb507cL5yAQQUqHmJR4+IHwRWXjeWFVy18XSVCMtgwDxO/RxLXHINXobHGpZPxe87lWyb7C
	M66ZksevSCVG5yfvDe/ZZXc6x1wHjTq+03APx/J4pIEVB+DvawLPO5On0XWtW+3Pk1sNm5hh8eWlq
	8il/SWWbOxo6PfgnHyjBRr/qnTtoZrA27cbNvbpgoCP2D8LRRvNzufFNzYBW/nbc6TO9Ys7tovBti
	y9YChygA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzP0B-00000001cNz-1dww;
	Mon, 31 Mar 2025 23:57:11 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzOz5-00000001cKX-2nxK
	for linux-nvme@lists.infradead.org;
	Mon, 31 Mar 2025 23:56:05 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-3054e2d13a7so284663a91.2
        for <linux-nvme@lists.infradead.org>; Mon, 31 Mar 2025 16:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743465362; x=1744070162; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEq/Fka6YRBKENdOliwx1ILIyB+IBRwt7XPFaRfOBxw=;
        b=MCr9KOgNVcblMOvrkL2bTDU4zszzDIVMJPdrQWVsoccdLd7DezTPhax+vhriKiUXpn
         Qwev/1VrxA9gwVFy2o7e/NuVOl7C93t7DD5sLtse9PcaONH2A0wNbZcfzNKseqKGsxYU
         Iv31JCh/Xmkyr4TcEcim4o9Z/DZt1Lax7acZfZZWN2j4+TcG2xtM7qlFJIdXqsteDtDy
         eImvAj+VYxSI92CEBM9Dor9ZByY51dDRsID+0cjdbqJyeWZGJCuf8QepNCNB4YJUIIz2
         382u2IzrTUiXFEpBoS1yE9Udo+hNwg8beFwPh9kQl5KHeR4/AJr/Qkxes3AyVAFFQTuC
         pLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743465362; x=1744070162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEq/Fka6YRBKENdOliwx1ILIyB+IBRwt7XPFaRfOBxw=;
        b=r/nHC2HVKM05a5L+JBln9wOqJVuOzgf0oEIHKQrCACM7KCLyp+rr6ApFv5U6kVkgz+
         /VCJvfmzHdmATqGH92HkCviUgyU8p7PVrd8NYsubCIDs6Ti4pOCift9HG/5Mn8J52f84
         azePmIoigVeci6yCZD1BQOjcYJ7wvqdDd6+LTZkYBfNk27KTvXUY5fJl5dVzA3u3D42K
         rm8yyym7MgojTP12sEFvDDx3hmaiH56+dtadSSKTXmbL8LG8T7UWz5pmRxB/e+i5KFvU
         0FvYTGjmJE1kXaLO3GlgGf8jhNSXAG5+jiQHU8Mt21hGEc+/xWP+I9wgdHuj8rYKdVQd
         +pWA==
X-Forwarded-Encrypted: i=1; AJvYcCUND4hRvh/7aEcyQZH8+xuAfj1I+B6I/3lAJkqW3G9K0cblIhywM0nz+CzzkJDb34oC0VRsS3RSrnPu@lists.infradead.org
X-Gm-Message-State: AOJu0YwJ5ZJCLcD9G3rhrbaN5H2yLD5fT9EoOvcG19fiRz59NnPSpH4X
	OJga6XAG2Suoypgd1USlgb/n+v8hVNLIsUzrjnoSIycRc+jb9ThdJardrFTx02hzjNN2o5sKZxo
	CLG6x4aL/l4KgXPk2uLWB1twmNcXT6wNRPFPoB5YWUbhT40BZvd+2og==
X-Gm-Gg: ASbGncs2IJAlhjjiNxbCu9m/rTn3yhsxZFe7Dbryd0GwHqXcLD7mG5lf9iZevZkI/9M
	I37k6czx0F9CLALoyHvHPzykpKM4AfA3fxUZ2VzVmIzdjU3dmp3j+ej5xl8T4zRtcxFvP1CcFUH
	CWoOuqeaBLXp+Wd9VaCk2jQ7Zy
X-Google-Smtp-Source: AGHT+IEGH/a3rGABDa2/mh2XtCmOTSKeNqoAZuyY5b3WmNkh66z8tCEG7KQAC/uJtaXSfm9b8H+tCKGTp34mrusVN3w=
X-Received: by 2002:a17:90b:3e8c:b0:2ff:6666:529d with SMTP id
 98e67ed59e1d1-30562e93988mr179869a91.6.1743465362263; Mon, 31 Mar 2025
 16:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250328193826.356257-1-jmeneghi@redhat.com> <20250328193826.356257-4-jmeneghi@redhat.com>
 <CADUfDZoXg39h-5gi+aVj2u1H6HC4Beyp2XPTrjJ_PMDPf11dQg@mail.gmail.com> <e22e3cd8-f792-4f20-9624-76e973cf4940@redhat.com>
In-Reply-To: <e22e3cd8-f792-4f20-9624-76e973cf4940@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 31 Mar 2025 16:55:50 -0700
X-Gm-Features: AQ5f1JqEc-i7jWqvdZxWprnCNGoZvK041yZkM41VIWbo0NwE3LXl8I8l3z6zTBs
Message-ID: <CADUfDZoNdUBuX06FB+jsduS=shgPTKxbr_dYdtS+adEe2hnVWg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] nvme: add the NVME_ENABLE_MULTIPATH_PARAM config option
To: John Meneghini <jmeneghi@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, loberman@redhat.com, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	emilne@redhat.com, bgurney@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_165603_891101_8E0ECA8E 
X-CRM114-Status: GOOD (  17.70  )
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

On Mon, Mar 31, 2025 at 7:29=E2=80=AFAM John Meneghini <jmeneghi@redhat.com=
> wrote:
>
> On 3/28/25 3:49 PM, Caleb Sander Mateos wrote:
> >>   bool multipath =3D true;
> >> +#ifdef CONFIG_NVME_ENABLE_MULTIPATH_PARAM
> >>   module_param(multipath, bool, 0444);
> >>   MODULE_PARM_DESC(multipath,
> >>          "turn on native support for multiple controllers per subsyste=
m");
> >> +#endif
> > If CONFIG_NVME_ENABLE_MULTIPATH_PARAM is disabled, could you #define
> > multipath false in place of the global variable? That would allow the
> > compiler to optimize out the multipath checks and the resulting dead
> > code.
>
> If we #define multipath to be false that would permanently disable the mu=
ltipath code
> when CONFIG_NVME_ENABLE_MULTIPATH_PARAM=3Dn, and this is not what we want=
. The purpose
> of CONFIG_NVME_ENABLE_MULTIPATH_PARAM=3Dn is to simply remove the core_nv=
me.multipath
> parameter from the kernel so the user no longer has the ability to change
> the bool multipath variable.  We want multipath to be true.

Sorry, I just meant to #define multipath to a constant. I mixed up the
boolean value. If CONFIG_NVME_MULTIPATH is set, of course it should be
true, not false. If CONFIG_NVME_MULTIPATH is not set, multipath is
already defined as false.

My point was just that the compiler will pessimistically assume a
global variable with extern visibility could be written from some
other translation unit at any time. But
CONFIG_NVME_ENABLE_MULTIPATH_PARAM removes the only way for the global
variable to change at runtime, so it can just be a constant.

Best,
Caleb

