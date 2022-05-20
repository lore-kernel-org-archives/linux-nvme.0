Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FA0C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 12:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AW3WbgwLSP0WZKYPK3Y6DQ8WAhPkJkHKkMhSdaktb4M=; b=ewHc/IouAHsExfBbtwfhfRLtg4
	h5pYgNepPxYdTeG9RCNmH1GXXlq945Qp1nrmcA+IvQfMU/SsOGjzOT1lQAUpWNsfOPT+09fJ7DmvX
	OO1IGf6pWKUcuxqLYZVjhP/XSYACwSNscRB7GKk+sAa1OymZUQRYPKU0haOISH6cYfufMvsXxmp7C
	Bwl5TSNrhSzYTAvkEflXzsBJuKBr1WVx9JQCxY0TRCd9oTnts5h8tcYjdltgdWf68zUeBntELBto/
	Mr7dHnHV35Ze8A6U288CNK1rt3H+nLjKDm2LRgcZ4fLVbrqGPds5aU9HeoQ6gZFF8F/hQhNayoFzX
	3r16RKUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ns1vp-00CNvJ-Nd; Fri, 20 May 2022 12:40:37 +0000
Received: from mail-qv1-f45.google.com ([209.85.219.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ns1vn-00CNuJ-1Z
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 12:40:36 +0000
Received: by mail-qv1-f45.google.com with SMTP id s5so6550819qvo.12
 for <linux-nvme@lists.infradead.org>; Fri, 20 May 2022 05:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AW3WbgwLSP0WZKYPK3Y6DQ8WAhPkJkHKkMhSdaktb4M=;
 b=Fi/jD4uQHqjZTPu1hPpEmaJiA9x2vCKACcpRpo7m1f03wgZC+ywA/H8UJvtADTmWtK
 vbDHrJMq7mEtO6pEd/N0mLoqGdHpShiX8RActTvGAZgEjLuNHuuGHP/qX4g9tKnsfwDJ
 SpNpHATGPbSdOsgvxQ9LFUhClA99+yyJmOvMSOsBnP8NOO38Ii74YDHX/GA8iFrtUHtt
 ZbiyPoBRptjOiak8EC54+GSWrrg6SqU7zfHA22o7UIFqhbdg3Hm9xGDvb/bXENIf5RwG
 bujMzz9SeikRd6Js5HERxVPvh3xDSeJneWnAiIxT+vBSNj5pYlkM45BDChnF4zw5i9AY
 DgbA==
X-Gm-Message-State: AOAM532ooHZZ7or2b/qWJgOGrO9kMIZbDKZXaiI3tu3eUdlC+V50v9JM
 bmR+S8GtbSQDTtkQNCmI1uJC1BkUDeZy4w==
X-Google-Smtp-Source: ABdhPJwkDUxNngZfFPesozA1ayq8hMj7siJ0S40d6p54vL0yPjYhVhsiX//OaOVWTwZtZjj4RG6fIA==
X-Received: by 2002:a05:6214:500c:b0:435:6b7d:5bc3 with SMTP id
 jo12-20020a056214500c00b004356b7d5bc3mr7787798qvb.92.1653050433262; 
 Fri, 20 May 2022 05:40:33 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com.
 [209.85.128.176]) by smtp.gmail.com with ESMTPSA id
 c16-20020ae9ed10000000b006a33fc1113csm2063757qkg.23.2022.05.20.05.40.32
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 May 2022 05:40:32 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-2ff7b90e635so19976107b3.5
 for <linux-nvme@lists.infradead.org>; Fri, 20 May 2022 05:40:32 -0700 (PDT)
X-Received: by 2002:a81:9b0c:0:b0:2f4:c522:7d3c with SMTP id
 s12-20020a819b0c000000b002f4c5227d3cmr9969695ywg.316.1653050431948; Fri, 20
 May 2022 05:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <6285958d.+Z2aDZ4O1Y9eiazd%lkp@intel.com>
 <0530d502-1291-23f3-64ac-97bd38a26bd4@roeck-us.net>
In-Reply-To: <0530d502-1291-23f3-64ac-97bd38a26bd4@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 May 2022 14:40:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU3SYOwE5ftDwymQpVwWmpbC=1Ytyp0Y9GaeUS2i1cP+A@mail.gmail.com>
Message-ID: <CAMuHMdU3SYOwE5ftDwymQpVwWmpbC=1Ytyp0Y9GaeUS2i1cP+A@mail.gmail.com>
Subject: Re: [linux-next:master] BUILD REGRESSION
 736ee37e2e8eed7fe48d0a37ee5a709514d478b3
To: Guenter Roeck <linux@roeck-us.net>
Cc: kernel test robot <lkp@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-staging@lists.linux.dev, 
 "open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>,
 linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org, 
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 KVM list <kvm@vger.kernel.org>, 
 DRI Development <dri-devel@lists.freedesktop.org>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Linux Memory Management List <linux-mm@kvack.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
 linux-sparse@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_054035_131733_CFAC5328 
X-CRM114-Status: GOOD (  27.17  )
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

Hi G=C3=BCnter

On Thu, May 19, 2022 at 8:48 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On 5/18/22 17:55, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux=
-next.git master
> > branch HEAD: 736ee37e2e8eed7fe48d0a37ee5a709514d478b3  Add linux-next s=
pecific files for 20220518
> >
> > Error/Warning reports:
> >
> > https://lore.kernel.org/linux-mm/202204291924.vTGZmerI-lkp@intel.com
> > https://lore.kernel.org/linux-mm/202205041248.WgCwPcEV-lkp@intel.com
> > https://lore.kernel.org/linux-mm/202205122113.uLKzd3SZ-lkp@intel.com
> > https://lore.kernel.org/linux-mm/202205172344.3GFeaum1-lkp@intel.com
> > https://lore.kernel.org/linux-mm/202205190527.o9wVEvHI-lkp@intel.com
> >
> > Error/Warning: (recently discovered and may have been fixed)
> >
> [ .. ]
> > drivers/hwmon/nct6775-platform.c:199:9: sparse:    unsigned char
> > drivers/hwmon/nct6775-platform.c:199:9: sparse:    void
>
> This is getting tiresome. Every driver using outb() on m68k will
> experience that "problem". As far as I can see, it is caused by
>
> #define out_8(addr,b) (void)((*(__force volatile u8 *) (unsigned long)(ad=
dr)) =3D (b))
>
> in arch/m68k/include/asm/raw_io.h. I have no idea what the
> "(void)" is for,

The "(void)" makes sure there is no return value.
Which matters if the result of a function returning void is propagated
to another function returning void.

> but removing it "fixes" the problem.

This introduces new problems (m68k all{mod,yes}config):

    In file included from arch/m68k/include/asm/io_mm.h:25,
                     from arch/m68k/include/asm/io.h:8,
                     from include/linux/io.h:13,
                     from include/linux/of_address.h:7,
                     from drivers/gpu/drm/msm/adreno/adreno_gpu.c:13:
    drivers/gpu/drm/msm/adreno/a6xx_gmu.h: In function =E2=80=98gmu_write_r=
scc=E2=80=99:
    arch/m68k/include/asm/raw_io.h:34:80: error: =E2=80=98return=E2=80=99 w=
ith a
value, in function returning void [-Werror=3Dreturn-type]
       34 | #define out_le32(addr,l) ((*(__force volatile __le32 *)
(unsigned long)(addr)) =3D cpu_to_le32(l))
          |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~
    arch/m68k/include/asm/io_mm.h:397:26: note: in expansion of macro =E2=
=80=98out_le32=E2=80=99
      397 | #define writel(val,addr) out_le32((addr),(val))
          |                          ^~~~~~~~
    drivers/gpu/drm/msm/msm_drv.h:468:32: note: in expansion of macro =E2=
=80=98writel=E2=80=99
      468 | #define msm_writel(data, addr) writel((data), (addr))
          |                                ^~~~~~
    /drivers/gpu/drm/msm/adreno/a6xx_gmu.h:141:9: note: in expansion
of macro =E2=80=98msm_writel=E2=80=99
      141 |  return msm_writel(value, gmu->rscc + (offset << 2));
          |         ^~~~~~~~~~
    In file included from drivers/gpu/drm/msm/adreno/a6xx_gpu.h:11,
                     from drivers/gpu/drm/msm/adreno/adreno_gpu.c:20:
    drivers/gpu/drm/msm/adreno/a6xx_gmu.h:139:20: note: declared here
      139 | static inline void gmu_write_rscc(struct a6xx_gmu *gmu,
u32 offset, u32 value)
          |                    ^~~~~~~~~~~~~~

These can be fixed using e.g. (there are more in the Adreno driver):

     static inline void gmu_write(struct a6xx_gmu *gmu, u32 offset, u32 val=
ue)
     {
    -       return msm_writel(value, gmu->mmio + (offset << 2));
    +       msm_writel(value, gmu->mmio + (offset << 2));
     }

> Either case, this is not a problem with the nct6775 driver,
> nor is it a new problem.

Indeed.

For the sparse people:

The full error is:

        drivers/net/appletalk/cops.c:382:17: error: incompatible types
in conditional expression (different base types):
        drivers/net/appletalk/cops.c:382:17:    unsigned char
        drivers/net/appletalk/cops.c:382:17:    void

Basically, sparse doesn't like "a ? b : c", if the return types of
b and c don't match, even if the resulting value is not used.

E.g. outb() on m68k:

    #define outb(val, port) (((port) < 1024 && ISA_TYPE =3D=3D
ISA_TYPE_ENEC) ? isa_rom_outb((val), (port)) : isa_outb((val),
(port)))

where isa_rom_outb() leads to rom_out_8() returning u8, while
isa_outb() leads to the out_8() that includes the cast to void.

So the best solution seems to be to add more "(void)" casts, to e.g.
rom_out_8() and friends?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

