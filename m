Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E572CCDB47E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 05:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2EQLiRaX/YffqZzPXqXx314gzGVTb/3QHRDs3oVcvjY=; b=lJK1ZUEVX4cPxmBOuerT4wfMdm
	x6rraEuFZaSsOibLPNHTmbu3tECiYNkNIIqtI7VsLuFGXWsvFePsywZlExpC9DIfTJ9co1toh8Y/W
	nvy/MW6DgxaFrfMAjYv1M/TsBXBoIOp/uQaq6+22NX9RyuzQnC+D6PUaPG4bK2ukxzKzEglNGEeNz
	HWj4wbHc4HXIp1NQBgaLVWn2ziPUUqi0m7Uey0fr+Ka1ivT3b3S+rk6c71lR6rHB6MB9Y1xnit/HQ
	Uku1RUy15SCpGcCCHDOs8mDCV7sZ8hn4UV4LMosSFtPqtKI08t3BCQFAWWqCFEHcMpwt04shJN+kG
	0rzStR/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrB4x-002Xwd-1G;
	Fri, 13 Oct 2023 05:51:19 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrB4v-002Xw4-1I
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 05:51:18 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405505b07dfso18134875e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 12 Oct 2023 22:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697176270; x=1697781070; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EQLiRaX/YffqZzPXqXx314gzGVTb/3QHRDs3oVcvjY=;
        b=WHOyq2xh8mebZ9UOUnKdaYdf/K9EgZUsbUu3TQ0hAQ6GqWnnpZ+Q0ALZFCscPDsJxV
         zeedFeoZMBXlZqwhE568yyBKHDwJOCDDshAaMXgIW/A07cLLYA19mS06D/eefexvh/wl
         4osayRfGzbfZoZ5h1PDjdq2xg0US7gcCwl/v+B13O6PwyWGHaHKhbE22PNSLyvWK46/a
         JVxR7GwHNMz+7FSd+1d2ebGYJLgcTspO8FHLi5g7Zks+jW0m2Vcwiwxv+lWizVgOI6GK
         UZd5YRpq90KTRSicnOgiBZcgqZiSLL3CnsHOnJlasx+b1SNnj/6d8ZcAtzNknedjKund
         ryUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697176270; x=1697781070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EQLiRaX/YffqZzPXqXx314gzGVTb/3QHRDs3oVcvjY=;
        b=qyPwy33xEC7Nkmq/waxygZrYyMHSUOinFHId7rYNkl6oL8h4c/UXyZ+qWz4xogwkf/
         SOjkLr2CHF1yDM16NJA2+PEQaXRJUefVtzqPYORGyf6L84UnuJAN9sTF6PEEaf5VMBGm
         Mc0Xde4QG7V3xXem/hRyfxbg2ftF34KOu/3YweJyjypR2T5Ky9odkZLz8DBGhM1SSNLk
         MFvawbpJY6ORGqGesMGeMy0qrZ/zGLjg5/hfrdIqCrXBpcgVvRllv9gkgRdKWKhREsf+
         55vdLDoSgmbjswX89AWjWQDblFEOWoPt2cwj4en7enmhAabdDcfaG1LLSpuWmqPasWku
         G5ZQ==
X-Gm-Message-State: AOJu0YwS2LQVkYmjhSrZOTnSMwrMHJV7daVpZ0H2AGSTE5iDx5lzV7Zc
	4pOT5FCe5Sz8+n8FDP+5ssNI2t0jWrfOxkP5VT8=
X-Google-Smtp-Source: AGHT+IHkI2kWCM7Bq5gbR/LxmGFIC+e7T2WpxA61ilAcHEMybrkDb0r5fV/J8slOb0gLYbNBxvDEt96kdNvF0VSrcPs=
X-Received: by 2002:a05:6000:71e:b0:329:2649:ced5 with SMTP id
 bs30-20020a056000071e00b003292649ced5mr24730387wrb.32.1697176269992; Thu, 12
 Oct 2023 22:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com>
 <1891546521.01696823881551.JavaMail.epsvc@epcpadp4> <20231010074634.GA6514@lst.de>
 <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com>
 <20231011050254.GA32444@lst.de> <ZSbVuuE8YxgwpqM8@kbusch-mbp.dhcp.thefacebook.com>
 <20231012043652.GA1368@lst.de> <ZSgRWrcw1FFw3XRJ@kbusch-mbp.dhcp.thefacebook.com>
 <CA+1E3r+gEPQgaieuwNXuXSDp5LHCQpUa8KFc80za4L9e88bUhg@mail.gmail.com> <20231013043806.GA5797@lst.de>
In-Reply-To: <20231013043806.GA5797@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Fri, 13 Oct 2023 11:20:45 +0530
Message-ID: <CA+1E3rL8GtKBaRHLh1qYQNffbUpKHMAmBk226nR1LLSiKhfbGQ@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, 
	sagi@grimberg.me, linux-nvme@lists.infradead.org, vincentfu@gmail.com, 
	ankit.kumar@samsung.com, cpgs@samsung.com, stable@vger.kernel.org, 
	Vincent Fu <vincent.fu@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_225117_445059_7621EDAE 
X-CRM114-Status: GOOD (  18.27  )
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

On Fri, Oct 13, 2023 at 10:08=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> On Fri, Oct 13, 2023 at 07:49:19AM +0530, Kanchan Joshi wrote:
> > > precedent to start doing it.
> > In my mind, this was about dealing with the specific case when the
> > kernel memory is being used for device DMA.
> > We have just two cases: (i) separate meta buffer, and (ii) bounce
> > buffer for data (+metadata).
> > I had not planned sanity checks for user inputs for anything beyond tha=
t.
> > As opposed to being preventive (in all cases), it was about failing
> > only when we are certain that DMA will take place and it will corrupt
> > kernel memory.
> >
> > In the long-term, it may be possible for the path to do away with
> > memory copies. The checks can disappear with that.
>
> As soon as the user buffer is unaligned we need to bounce buffer,
> including for the data buffer.

Yes, but that also sprinkles a bunch of checks and goes against the
theme of  and doing as minimal as possible (at least for passthrough).
Had the plain buffer (potentially unaligned) gone down, either it
would have worked or the device would not like it and user space would
have got the error anyway. No?

