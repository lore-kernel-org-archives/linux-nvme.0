Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E933C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 22:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=em5zCJrORblXF6ZwaZ+68vuw/ptEQHtpGgIbYM3pA/o=; b=BWdTGSZcKyhmT97tcas1/fuIfF
	v6NTwcVIjHPGt1xZ/nPDpsWU4t2L8v5kjOU4dsrOZMXCRCPwREKiBC89gPygtFk8G3AXhsuq8kNgx
	Tzyrkkzfm9JbFhiGWbcaePaxMtOgizVMRjMwcJaN6YXkys8aR3ZGdgWy48HUEbrtRZATm1r697IKM
	Jb+5O285j+wJw8oNjW49oW8kixrqPa0xVGQ9RQXRBewclPy2XPNIRZwTsaj4TXTsXueeOnDSPmLZb
	Wc1Et6KOY4lcVdiYOIE0tLGo2xMx81aokSx/P9/SKF/k98yWuhQJJAJcswva2C2ljPEOgjo/qp/Nl
	cv03IM1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weKlY-0000000FYtC-4762;
	Mon, 29 Jun 2026 22:47:48 +0000
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weKlW-0000000FYss-1PgL
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 22:47:47 +0000
Received: by mail-dl1-x122d.google.com with SMTP id a92af1059eb24-13981833e13so4718706c88.1
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jun 2026 15:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782773265; cv=none;
        d=google.com; s=arc-20260327;
        b=R9F+PFdwd7mlxFkzcEcHojL2bRHFlrKcPLhPUwPhp0ekOAVOGbEX6SuMokSSWJNc0W
         b5LeuE0yM3fWttKe1utjH/Nm7kadYjFeE3sToBsOos2p7FrBLaoQddm9P+/ZUYQXrVVQ
         Heqn9Y3hzYS1r91F2xUT+F5iVHooVEpFONCtoQF1AC/xHYnfTBM8fxBs+uVDVuWE+76x
         KFqbRbbbxk+vCNC104wTlbGzA0+1cufK/AwpGFtwE3J85KXIyVP0F0SLaBPwTHxDGw6R
         zSkO0GOOZrk3/mzJ+QwB+uAGO/zh+AkavgMpnaXpXsUbw4+AsH7lLverKA9RzBZG58v7
         08jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=em5zCJrORblXF6ZwaZ+68vuw/ptEQHtpGgIbYM3pA/o=;
        fh=IddAW4Sgi6S7SnhYnaQgAoVITWl1gDb4ZFykOEQuP18=;
        b=VML6gF5mTjybcwD/ox8xLyI7PbzfdqDnGwPXjoP+KFrCp61BI3vwZqqowCwhzpekQa
         1PrWuhM49xUQK4DxI8GqjVRe20Uc9ojsbYe+VHmSWVuwhq/R/uUbiJ4VQcaewvu0Y1Rd
         mU/laNvZPhx1NzuBGqWkDdFdavvbCntZSA34UPZ1+mDoO0G+I7RyOr/5Vcb/F1+njEuh
         8ZldcWmfMq+ukQVhc+ZMthPcYYQyUI1JWN5jjk1Qsdu7SEAJ5Qq9uRJU9DR9JtON0R68
         xXcpiM4rVOMAJA9xGo2nfAsY/dQdGIFecW0J1N12Q8h7m4gE1gnOTDrczHEKhrBfPIpl
         PU+w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782773265; x=1783378065; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=em5zCJrORblXF6ZwaZ+68vuw/ptEQHtpGgIbYM3pA/o=;
        b=QfzKfMZu2TJJKLq4WI080+RXpELmCbDEApz9COP1U0jPnifFQKnJK+EinzsyVTEt0P
         NIGVWX56Antdqh2BSZBjqRdZ5YOOsJi449NS+Nbg/k7R0a9HodfkZXwD3jGZOwwZx/bX
         P0MX+oJG3WDTq+E4FLSae/mVydecBS1UHfyyQPQQ/rZzGFsQ6ifUYk86Wr8O6o28VBkd
         dBYWqKM/gtVobCrd3eKvxX4SVYqGqrgewwaTicPLnXUcd3FAmnDi02YeGkZ8y1GCaNx4
         k47CEG6MMpQ5x6rD00xPQYYkYwkhWeWfo8e/ymzW4IccSwz1Cva4H9hbpM6n9dlF6SAM
         GECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782773265; x=1783378065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=em5zCJrORblXF6ZwaZ+68vuw/ptEQHtpGgIbYM3pA/o=;
        b=mNsOEWk/AYffiNxvcdtKwH0MU7cScXQvwW4EdzLGRuaiUmH56baw+QV/WwWT8hZqnO
         INLNQcitorXxNJ0tXd/31UAfNH2cYCXReQ592DfUKSiR14dOORrNuvm0MeVW0l5a5Bay
         HiN7YDjok9UnnVbWOH4N/eREt7n8VaLoMgO3OYvO8Pa9fN8RYyhHj8t5c7Si3GbAHQc9
         pelz06mx6zttbjbRtNmQSsRDN+Qdr6GvP+zgGmCQnS/uOdQWOgGoAwe1bXCtaSzDcnKI
         XNeyoS74Y6TgrVl++z97eMSAUS00lJL9iYh54gu9QcRLJfEDiBdJhz6Jjc/1UwzZIfC2
         FuRw==
X-Forwarded-Encrypted: i=1; AFNElJ+Yk9KWK8aBSjh4aD7V2WACsOOUMVB74ls4OtdZgaqePn6KP+urta8vftfhHhSsQrOv/Hon2mmGWLVc@lists.infradead.org
X-Gm-Message-State: AOJu0Yy8lZiJkBOsibDnjmjitm4od9Wew3X+eB3KyoAsjgj1bdx2u+3O
	WQ+rrMvyb99LxlTUD7NDOzPkK0/LD8gmxU3MU+kzdib6pTi1F/LfnKrafm8O6ZLs6HU/aMqNdi4
	w8N3185a9XtvOUBB7u9bxcR+eT1u4J/voZOI86jLH
X-Gm-Gg: AfdE7clHIQtrIVEJfe1oP79YP4w/8h1tHa94L8a8ZcRbvTZhd4nUH8F+X6frlubjmlx
	eH9dTCPm6/0Q2TKwtpsrUVTBVQMamaoxg14k3UpBELTa6ahX7Nk2b+tsEqyPpkxOonGZggeJNoT
	nQzrhSyl2hrfzeB7MbAkiatW24l2P0GcfO69KHkcguZWoEC/VC8nGH3nLC5MBF94PccRCywB5su
	XnO8aoCUFSHfMpn2t2snduovuVWR9D9JUocmFexTiq8ekuQg7wEImlYxJzJ4+teN0csdiq0Kuih
	SqDymg==
X-Received: by 2002:a05:7022:7a5:b0:139:9e79:43fa with SMTP id
 a92af1059eb24-13b2a1602a6mr681055c88.9.1782773264731; Mon, 29 Jun 2026
 15:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-15-nilay@linux.ibm.com>
 <20260626064916.GC11106@lst.de> <d72e3efb-875e-40b4-80cb-1fa642bea7a5@linux.ibm.com>
 <20260629125054.GC23695@lst.de>
In-Reply-To: <20260629125054.GC23695@lst.de>
From: Marco Elver <elver@google.com>
Date: Tue, 30 Jun 2026 00:47:08 +0200
X-Gm-Features: AVVi8CdCfyw5QUlPYng-1Iw4VBbAyMKxvxPdjnmeMfmbbNF6QexIOCemsewC8QI
Message-ID: <CANpmjNPgvdKLvQTFvt2OUYzG4V7GMPSmrDfV0jPbbtNxv36GJA@mail.gmail.com>
Subject: Re: [PATCHv2 14/17] nvme: fix Clang context analysis warning in rdma.c
To: Christoph Hellwig <hch@lst.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me, 
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_154746_374710_9A7427DD 
X-CRM114-Status: GOOD (  17.59  )
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

On Mon, 29 Jun 2026 at 14:50, Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jun 26, 2026 at 09:01:20PM +0530, Nilay Shroff wrote:
> >> Does switching to list_empty_careful fix this?  If not, does
> >> list_empty_careful need annotations to make this work?
> >>
> >
> > I tried using list_empty_careful() but clang still throws the
> > same warning. And yes it needs same annotation to suppress
> > the warning.
>
> Sounds like we should have annotations (or just use of data_race)
> in list_empty_careful, as it is designed to be used without holding
> the relevant lock used for modifications?

Given list_empty_careful() is a real inline function (not a macro),
you can just add __no_context_analysis to list_empty_careful(), which
should also suppress warnings about pointer-to-guarded-variable being
passed as an argument into it. data_race() wouldn't work, as the
warning is generated in the caller, but when the attribute is added to
the callee, it also suppresses warnings about arguments in the caller.

