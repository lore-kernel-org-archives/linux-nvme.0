Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A435EC433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Apr 2022 21:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FwKvzDls4uZguxFUkLXf4+nfUJikOvM4SY7CUtlSysk=; b=H8Ok70w4yrTyssw95jVYqN82xv
	P/027IaSLXrO23TGG5vQFGvZusE0nAb3ej+1TzGddo+sRRK4z6kyGUcWMUth322gmaymiXUY2M4dQ
	zOOvrA4l+qX5InO1JNB5xlRxpNhMrNO1/I555vrxI1F5SYMXthjTkXUwquhpFgdQoUExDRpidO380
	Y++3YA8I59rD2iNy+IeDB0uaVip3stMY2YX1khY8nt1sXDSWKwGYfwmepX6+3sXiQK3OskRE/cKuy
	MXIC1n1R7Fls909mQNmfagKyZ6V3JpwLn5OnDgfhWNl1aITKkGR2FQsViyNWCtc51IH9VTDESPNAN
	J2K9YixA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nalGt-00A7SB-GJ; Sat, 02 Apr 2022 21:26:59 +0000
Received: from mout.kundenserver.de ([212.227.17.13])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nalGi-00A7Ps-3O; Sat, 02 Apr 2022 21:26:49 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MXpQA-1nVGZt0ZvY-00YDqr; Sat, 02 Apr 2022 23:26:45 +0200
Received: by mail-wm1-f46.google.com with SMTP id
 l62-20020a1c2541000000b0038e4570af2fso3398355wml.5; 
 Sat, 02 Apr 2022 14:26:44 -0700 (PDT)
X-Gm-Message-State: AOAM532YcbIrT0meG6wwWtK5SjXI8wX/3+qX9mMDI1ZDvg+huPdIRiL+
 HQD21ro5HphrZPlJgwaXm4eRh/yEleYcr3BN/yk=
X-Google-Smtp-Source: ABdhPJylADU8u1Uad2avcKqoy4J12Y7Ldo8r2ly4hCBr2blS2EVb+EGXxI00qvmV4NpEdPUxq7mTzkMgGKL7bOTsU7M=
X-Received: by 2002:a05:600c:4e11:b0:38c:bd19:e72c with SMTP id
 b17-20020a05600c4e1100b0038cbd19e72cmr13758469wmq.174.1648934804584; Sat, 02
 Apr 2022 14:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-7-sven@svenpeter.dev>
 <CAK8P3a27-eWP=krGQOp29krcc7bVME9=MbN6B3Rs7Q4Ran_VFw@mail.gmail.com>
 <7876eb84-9803-48dc-ab6b-27d49858e27a@www.fastmail.com>
In-Reply-To: <7876eb84-9803-48dc-ab6b-27d49858e27a@www.fastmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 2 Apr 2022 23:26:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3d5XmtXxGwVHFSyNraOJdTaFCG1s+LNev=39eLXxGFHg@mail.gmail.com>
Message-ID: <CAK8P3a3d5XmtXxGwVHFSyNraOJdTaFCG1s+LNev=39eLXxGFHg@mail.gmail.com>
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
To: Sven Peter <sven@svenpeter.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, 
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Hector Martin <marcan@marcan.st>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>,
 Marc Zyngier <maz@kernel.org>, DTML <devicetree@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XtWTvnAHjBUVuVrLpMkEq+Y5am9tD1blMhyEEP2MVtKt0gRwQOR
 8h5p4oa8SXRlvOwuwWAr6lZ4OldhbV30j4o/HNSNSKu3g7XP6Dx4bQruDytuES6eEHIJiFn
 14TQJANbhO0d1DeJSxAIXi6HtO/3scI8fwmBTTWkfvxX5nxUMZ+LRNErFrNogkccC0447ur
 q7M8pOih094DvCr5P5Onw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GwYguUC0jsc=:l0R1j2nuiIaxZxbxg6mjSA
 ZkmFmi1zFfyUKa/kBKtC46KwNlUkBbd109cgREaNDLi2G8rcQwddTBNBCxKroKaxmrS5tEG8y
 QvutepqlZ1zkpTCklQwCGB5JmI8atDqjPLQw179lcFnYEHzHQ/9DIriqEHAp3Tqx/5F2l2rR1
 DN7pF/amIypIf5rtUh/b/nby86YJXuOGzfkgYtJ7VbPS8vTd67s8OTKAQ2b+dpMwSIf79j3iu
 pqOQri5ZKxZ53/1uRtDZKKE3cKk5mP/pztdCStcAzOql7O/jNe7quRkU0SYfTqnOqtO20pG4A
 Yh3I8IDYraeznj6YMfpA4Bc3QFHgphm1eSpA8q2H2nGXhX77qltAGKdhKtpQiSEzGA7xjCpFB
 H9fszDvtJCgMddpQncYuY7KZfLwbabq4PEYYdR/q/Y3gupkTZVH8cx49z8QITY0jYBbXfIHv4
 OVXPHibSscVUxNiHW1SKzCWEFuwOmf+/leQgL3ygg+eKOvqgcrd6bo90PbdqVoF5gq7Nyt2on
 gjL5SsXtOjGZ7s57ZIYvpIWKq8HjW/kfxXOJ0NrFtP1tTsE3xSn04SXjy2ONwaO93hOHEUmuc
 Amtufp7dXgUcQt0t2SFes1mffFhSB596drJDtKp0BPw9Mo84hEtqAxQmaGP5WdpHB6GMNZ98O
 i1AX6zV6x+C/bF8lBzyn0GgAXOncnoA4emopbrKUyCMv7UcYSwcqP2DBrWjTNxrqlm6kmriCb
 1zZMSr5Eob9vIxgcdKG1poNmSsbRQmud8v9AqUODNsFViT1ObEoD+67M3mzdXxjQh4BDQ1LRG
 /rClG0W2CPYaaz6kMQKo9XNoOI/rcc/97m7Kf9vYJub6ddRAe8=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220402_142648_473077_26627EEA 
X-CRM114-Status: GOOD (  25.95  )
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

On Sat, Apr 2, 2022 at 3:34 PM Sven Peter <sven@svenpeter.dev> wrote:
> On Tue, Mar 22, 2022, at 14:38, Arnd Bergmann wrote:
> > On Mon, Mar 21, 2022 at 5:50 PM Sven Peter <sven@svenpeter.dev> wrote:

> >> +bad_sgl:
> >> +       WARN(DO_ONCE(apple_nvme_print_sgl, iod->sg, iod->nents),
> >> +            "Invalid SGL for payload:%d nents:%d\n", blk_rq_payload_bytes(req),
> >> +            iod->nents);
> >
> > I think you mean WARN_ONCE() here?
>
> This is taken from pci.c which used to use WARN_ONCE but was replaced in
> d08774738446e77734777adcf5d1045237b4475a with this construction here.
> The commit message mentions
>
>     The WARN_ONCE macro returns true if the condition is true, not if the
>     warn was raised, so we're printing the scatter list every time it's
>     invalid. This is excessive and makes debugging harder, so this patch
>     prints it just once.
>

Ok, makes sense. If we get more of these in the kernel, we may want to
add a helper that makes this more obvious, but it appears that for now
these two are the only ones.

It could also be expressed by moving the WARN_ONCE() into the
condition above the 'goto', but I don't see a reason to change the other
driver and it's better to keep the two consistent.

> Agreed, I've actually tried replacing all non-relaxed ones with the normal
> accessors (even those inside the hot path) and didn't see any performance
> difference.
> I can use the normal ones here and I'll consider using the non-relaxed ones
> in the hot path together with a comment why they are safe in those places.

Sounds good. If you find any instances in the hot path that have a
corresponding version in the pci.c file, it would be good to keep these
two in sync, hopefully making the non-apple case faster as well.

        Arnd

