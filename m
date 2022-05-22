Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F46C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 22 May 2022 11:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BOcP7c+b/aIig+wDwK1ySXDPQYBqPco/XJdaO5tL43M=; b=GQbGjTmZE7M9mx1/B89DAxLYxN
	QPSxozFyEHDZcvsmHEMosZXPOjlVueW+N8W69uCOO1eaH3BNZzD8lLsemx84eDw3U0wfMdCFipeYY
	uP6015Vg74PaOMiEtGodmDuqfdZ7OmnFNJv8WuI6OgqlW5Zup7CW9F8ITjm7T1hQTkOjTNKSe0n8v
	ezxg9Gj1tc0oTTi7RDP+0lJfdHAV7bFCPwi1BxTc/l6mgsxammwuTMA+H883P2/C0VmJKCTucExM/
	OJ3LMmUbcFxcsNBuzZZh09TwX7gClYLWDzPtICvzx66hlslZxtt2/abMAJY0TIzFI2u/iJEk4MZ2y
	SfM9dpWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nsk0a-001DMk-0P; Sun, 22 May 2022 11:44:28 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nsk0U-001DLv-9q
 for linux-nvme@lists.infradead.org; Sun, 22 May 2022 11:44:23 +0000
Received: by mail-ej1-x634.google.com with SMTP id jx22so9958862ejb.12
 for <linux-nvme@lists.infradead.org>; Sun, 22 May 2022 04:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=BOcP7c+b/aIig+wDwK1ySXDPQYBqPco/XJdaO5tL43M=;
 b=HbiWaat1vy9fqglT1AQ5mQ5JjCpkhO+E8jnEtRhzPiif0qrvDKKdx8B95OMkJtx62f
 50z5Sn4S5OQoHLNAGBGDcg/pM3dJVc3FeOKAJ33h9DBUzBryUmLfBVNeEMKJeo3lBUaX
 xorGA9zq+QsM0EimtbURXWG1azBOZqa655UGvWWFRHq2vv0bEgZ9hUSxdC7AyrZSM0K1
 gmpjbX5Ksc66SeqRZbC++YgqZxATC9x3cgK6OQg6EKrLFj22uin13ycLwqXmbpFKdEyk
 gTfnlwyzGuksJcevZj0OkBT28KA9vQfDd/xROApkgmO1+q7Yd8+18f+ljXPwZEs2QkaW
 cj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=BOcP7c+b/aIig+wDwK1ySXDPQYBqPco/XJdaO5tL43M=;
 b=jiU2r4ey5q9QOfqE4E4iEqiy7Q6/aeMTS8r/0xw33FdsKYO+ENxc1aZxvhsdD6FEid
 5Sq76+1yAyxn4NlijkiOuw7AeKDo/2LGJfrIUFKKzL9oIgJ+tRWDjGaLckAjGKins01x
 nReUVffB7OcnVj06cAC73OtCmkPWqsycg/a0lJIuvddmRXT2SgDFpbCyNRTNCiqaNIU9
 QezSejy7J/vf4P4qi7PFc0ZcOfSJT4Og57Tcel/0n/pKI+Yzh6qSdWprrEasS6pw2YVA
 aHcKmzfDWdEZsOpKwBpVC7HZTQu9gp5edckyH2tqL9A2GPa3Xm/1ZtteIaKZs2Q5S1w+
 NOTA==
X-Gm-Message-State: AOAM530vrOjaRPbGeuwN28V0VTjrAZsSirYIVGai0JPOShbwcrYyn/pe
 vFjC6znbM0T41CriXGVbJT0=
X-Google-Smtp-Source: ABdhPJzRfCqhzI7QwnogN+fhYc0fh38naDmT7SQjDe2PeOI83f57DAXoKHZfwtI5G/K8ujCSqBK8Kw==
X-Received: by 2002:a17:907:6d98:b0:6fe:b83f:802d with SMTP id
 sb24-20020a1709076d9800b006feb83f802dmr6984772ejc.182.1653219860369; 
 Sun, 22 May 2022 04:44:20 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
 by smtp.gmail.com with ESMTPSA id
 5-20020a170906024500b006fe8bf56f53sm4766942ejl.43.2022.05.22.04.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 May 2022 04:44:19 -0700 (PDT)
Date: Sun, 22 May 2022 13:44:18 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guenter Roeck <linux@roeck-us.net>, kernel test robot <lkp@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-staging@lists.linux.dev,
 "open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>,
 linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 KVM list <kvm@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-sparse@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [linux-next:master] BUILD REGRESSION
 736ee37e2e8eed7fe48d0a37ee5a709514d478b3
Message-ID: <20220522114418.vcirenoehfx4efas@mail>
References: <6285958d.+Z2aDZ4O1Y9eiazd%lkp@intel.com>
 <0530d502-1291-23f3-64ac-97bd38a26bd4@roeck-us.net>
 <CAMuHMdU3SYOwE5ftDwymQpVwWmpbC=1Ytyp0Y9GaeUS2i1cP+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdU3SYOwE5ftDwymQpVwWmpbC=1Ytyp0Y9GaeUS2i1cP+A@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220522_044422_405959_A7341208 
X-CRM114-Status: GOOD (  25.01  )
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

On Fri, May 20, 2022 at 02:40:20PM +0200, Geert Uytterhoeven wrote:
> Hi Günter
> 
> On Thu, May 19, 2022 at 8:48 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > This is getting tiresome. Every driver using outb() on m68k will
> > experience that "problem". As far as I can see, it is caused by
> >
> > #define out_8(addr,b) (void)((*(__force volatile u8 *) (unsigned long)(addr)) = (b))

Not directly related to the root cause but the cast on the LHS is over-complex.
*) If the types are correct, 'addr' should always be a 'u8 __iomem *'. Casting
   it to an unsigned long will throw away all type checking: pointers of
   any size, of any address space, any kind of integer, any scalar value will
   be silently be accepted.
*) Then, when casting an integer to a pointer '__force' is unneeded because
   it's meaningless (because the integer has no type info about the pointee).

The most correct way to write the above would be:
	static inline void out_8(u8 __iomem *addr, ... b)
	{
		*((__force volatile u8 *)addr) = b;
	}
this way, you can typecheck 'addr' (but maybe it's the idea/the argument is
not always type clean?).
Otherwise, if the cast to unsigned long is kept, '__force' can be removed.
 
> 
> Indeed.
> 
> For the sparse people:
> 
> The full error is:
> 
>         drivers/net/appletalk/cops.c:382:17: error: incompatible types
> in conditional expression (different base types):
>         drivers/net/appletalk/cops.c:382:17:    unsigned char
>         drivers/net/appletalk/cops.c:382:17:    void
> 
> Basically, sparse doesn't like "a ? b : c", if the return types of
> b and c don't match, even if the resulting value is not used.

Well, you know that the motivation for sparse was to be stricter than GCC.
In this case it's simply what is required by the standard:
	    
    n1570 (C11) 6.5.15
	One of the following shall hold for the second and third operands:
	— both operands have arithmetic type;
	— both operands have the same structure or union type;
	— both operands have void type;
	— both operands are pointers to qualified or unqualified versions
          of compatible types;
	— one operand is a pointer and the other is a null pointer constant; or
	— one operand is a pointer to an object type and the other is a
          pointer to a qualified or unqualified version of void.

Also, yes, the type checking is independent from the fact of being used
or not (because the type of an expression must be know before any kind
of processing can be done on its value).

> E.g. outb() on m68k:
> 
>     #define outb(val, port) (((port) < 1024 && ISA_TYPE ==
> ISA_TYPE_ENEC) ? isa_rom_outb((val), (port)) : isa_outb((val),
> (port)))
> 
> where isa_rom_outb() leads to rom_out_8() returning u8, while
> isa_outb() leads to the out_8() that includes the cast to void.
> 
> So the best solution seems to be to add more "(void)" casts, to e.g.
> rom_out_8() and friends?

I kinda think so, yes (I suppose that rom_out_8() is never used as
returning a non-void value). But in truth, I think it's the excessive use
of relatively complex macros that is the real problem (an using a conditional
expression not for its value but for its side-effects). Can't outb() be
written as something like:
	static inline void outb(....) {
		if (port < 1024 && ISA_TYPE == ISA_TYPE_ENEC)
			isa_rom_outb(val, port);
		else
			isa_outb(val, port);
	}

With this you have better type checking, no trickery, no need for extra
casts, no problems with double evaluation, it's more readable (to me), ...
But yes, I suppose it's not really simple to convert all this. Sorry for
no being more helpful.

Best regards,
-- Luc

