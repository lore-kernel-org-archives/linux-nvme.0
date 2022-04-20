Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939E8C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 09:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iLxfDbKlrh+CIcs+oFEB6M9YP4srK/D4LpUXThItqRs=; b=rU7Sh57Gr5gJQlGkGKEIpG5twC
	VUEDiQzGj6Qe+biQxIacjFDwFBP6Shz7rQFCGcuW9tYOCKUy10rixmI24HNVYPLi+AOn/7RpBJY73
	kNuz04aR0+8i1cWpvX9e1RoQx0+MtuOIZWVAqx54GGM/atRHQcawEbxXIKDIROKmNyVVz2N9MiasV
	CpyUrbulzAL/QYkGaefEfPnT2J3kFgw1v6vYcQ1W64FQ3o4VzrtQo8H85B2wVdRkH05SXvptT7tUx
	WTTcMobH50xpm3kBOARBGE+VOgVFC/ahYZZ5KwG3mVDL20NxkJEQjSQbirQUerTTlLa8aUbFLLv+X
	GxlxUIsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh726-008QEl-2d; Wed, 20 Apr 2022 09:53:58 +0000
Received: from mout.kundenserver.de ([212.227.126.134])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh71t-008QBG-TK; Wed, 20 Apr 2022 09:53:47 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MFbFW-1nhg3W3ALO-00HAjc; Wed, 20 Apr 2022 11:53:40 +0200
Received: by mail-wr1-f49.google.com with SMTP id t1so1500647wra.4;
 Wed, 20 Apr 2022 02:53:40 -0700 (PDT)
X-Gm-Message-State: AOAM533qehnY/fMYQ1bHZymzY0MDccbdp7LnqUKWM4xo0Y2EbCb2Qm2W
 Tp68DL2ij5xfMJdM6HaSMMdId6G0ntdEfu8mVcI=
X-Google-Smtp-Source: ABdhPJwJPuI7Y1qtWlrDJp9C+nSYUzTzOJUfqs4AGk8MfQmW4nHphkYeGXo9SzAnynjyQA61TRt2Y+NXKTusJSUq7H8=
X-Received: by 2002:a5d:6983:0:b0:207:a226:df4b with SMTP id
 g3-20020a5d6983000000b00207a226df4bmr14835629wru.192.1650448420348; Wed, 20
 Apr 2022 02:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220415142055.30873-1-sven@svenpeter.dev>
 <20220415142055.30873-7-sven@svenpeter.dev>
 <20220419053157.GA31530@lst.de>
 <866f79b1-6c02-4248-ac98-594829fed204@www.fastmail.com>
 <CAK8P3a2CWZb3vdHQvseJZQwPbUFDRo5Z9aGb7iVgodT1YeB5Yw@mail.gmail.com>
 <20220420043437.GA1123@lst.de>
In-Reply-To: <20220420043437.GA1123@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Apr 2022 11:53:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2-p=eW8jA=HVztFTq7mUMidRKcyFC_7RB5_8O2NmBxpg@mail.gmail.com>
Message-ID: <CAK8P3a2-p=eW8jA=HVztFTq7mUMidRKcyFC_7RB5_8O2NmBxpg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] nvme-apple: Add initial Apple SoC NVMe driver
To: "hch@lst.de" <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Sven Peter <sven@svenpeter.dev>,
 Keith Busch <kbusch@kernel.org>, 
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Hector Martin <marcan@marcan.st>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
 DTML <devicetree@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, linux-spdx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:QZRU58Nxc8rSy3QLFzd4ppjhUTzhgq9RyVRGTVNMGAQnsfGY7nO
 dkjDNzEFM1f6qheXCt6YDnI96VnCDcJsrj4EAqygxVK7t8Phl5umkq4vnHK1Y9tGekJTLdd
 NF3bdLaPed1wSsBE3Yfvfh0hFPkkPgAkKSyPQYgB9vuKoIuHhlrNRnZn1/muzar8qBlcstX
 ZwAe25zfqLP9M6TAEnEvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t9HduKFjRTs=:92tOnlpLfhwmY5cKRaQygE
 rjNxg9amm1YjsRRBYRmoJVCIr102X0wAFqttZTHLLeUZnd2v9C02fsKq69TYQfvCHgRbr1vnn
 QRkgzIcidYikUv/dt1SgfVnU5pF/rU87NyvW/1AMVWZ8nJo4jQ6C6pUXESn7C88wfwBuevDdH
 NHxMGbehAGS3ojFofq2xKkvHd2c2G5uGoLfEq1aTDxkt681eLdhevGK3pX7sMPCKFidD2lycP
 GpgMs2/ZCghIi5gXZUwy6Hd/dDCi9r7Ctt73+1hdYyfi934qCR444a8nwyQVYJF/sMPxj2DUe
 JC1WWBmlfKX8SMq9qd3uuthAkNIAc9aWfTiyqfFwVMH0FZcJyXUSCcZIeiGsRO+f9RFM6uw0K
 naxoVtxXRkiaQCC4pPVNASY0e3YiqyCbbI4LjxRyNsgBRCIfaREpsE1caANbiJNLprv2WO6oR
 KHBCji9/CS3CWWJACkiTYFDNnIc++mLRYMEiscToaSIrKJgK9QaTYHocIIYgg3ARYYgfY+Qdp
 CHy26TP/GTlcofKWwDHjsYC4SptA6bNsdj8pNLlAj7iKYu+M5MycnP2hYXSKOMHNque2QH/Qn
 rj1tSwwWRX9ZISDzPLtVxIBBxCso+ypSCJSDTsQpPtQ16+bNUPWAGxd7Z9kxWSsQWJd+ZTdnX
 AqNQuCVPkG8DUUOIqURzA0ptuEI+lrJBpBfSep12tSLjeqWM9ZefNz5myTIUmpYcIYtmPS8B5
 /s6JXxx+5FQNT+vx3EtEwI9fla6TDO0dwHHejPI+xng6rtlYAodiMikv8VKGLcodR70RhxcM7
 HuR3TbrCtMcyyhBz7Ym7/kLItpAZ+Fj47/Vyl3r2Dn+VZR9dBs=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220420_025346_280752_5160475E 
X-CRM114-Status: GOOD (  23.03  )
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

On Wed, Apr 20, 2022 at 6:34 AM hch@lst.de <hch@lst.de> wrote:
> On Tue, Apr 19, 2022 at 11:52:15AM +0200, Arnd Bergmann wrote:
> > > I just checked again and 64-bit accesses seem to work fine.
> > > I'll remove the lo_hi_* calls and this include.
> >
> > If you remove the #include, it is no longer possible to compile-test
> > this on all 32-bit architectures, though that is probably fine as long
> > as the Kconfig file has the right dependencies, like
> >
> >       depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)
> >
> > I'd prefer to keep the #include here, but I don't mind the dependency
> > if Christoph prefers it that way.
>
> So thre's really two steps here:
>
>  1) stop uing lo_hi_readq diretly which forces 32-bit access even on
>     64-bit platforms
>  2) stop using the io-64-nonatomic headers entirely
>
> I definitively want 1) done if the hardware does not require it.

Yes, of cours.e

> Trying to cater to 32-bit build tests on hardware that has no chance of
> ever being used there by including the header seems a bit silly, but if
> it makes folks happy I can live with it.

As I said, I don't have a strong opinion either, it's either a trivial change
in Kconfig or a trivial header inclusion and I'd pick the header one because
it's more obvious what this is for without adding a comment.

      Arnd

