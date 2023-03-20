Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6658CC7618A
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Mar 2023 15:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=knDpxN/J+logq/gYSas38uHqDy6FJ5gT1auehUzIlVk=; b=BE+hoy8zO1mGeORxHaUn3khQzp
	opZixfc2LCDLZL52r0B92ncTYRjifvXJ33jfpCAGbXWENSJKy2NnQKYWyp9kT0dLEIFINVZ+6CYq0
	zRZD31igdLBu6EmIKhxz0DmZu1h3YgyxV2cUnjuPb5OdeZS9ZkXZuVFCJBtEDSlYtKTHA75nmZt6H
	6y5AM+z4tra9ILfBfM3n5vYQrVsoFKgM7ojppcZPl1F0ezu/PsuSV+BGGqKgPFU6QqWgiwA2Jd9eX
	p5lc8BjWjuAD8MUX2uND6nEGWA7Gw/+hjrQhGIVWQnppUJicgS/7XSH+K/vz+MMjzvb/BwlQ8N2XF
	3y5exDEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peHc7-009awt-16;
	Mon, 20 Mar 2023 15:39:59 +0000
Received: from mail-qv1-f41.google.com ([209.85.219.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peHc5-009avV-0L
	for linux-nvme@lists.infradead.org;
	Mon, 20 Mar 2023 15:39:58 +0000
Received: by mail-qv1-f41.google.com with SMTP id cu4so7863033qvb.3
        for <linux-nvme@lists.infradead.org>; Mon, 20 Mar 2023 08:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679326790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knDpxN/J+logq/gYSas38uHqDy6FJ5gT1auehUzIlVk=;
        b=nAvZVfQR+F1ki/NVq86fjMhNZZiU3c1n+nyAnBUD8CtxTR3vKv2jyLoXki7stPanG7
         uiKAFsAUsiLGM8oNpCIBOx3cKtFlPcqo3I2cfHMGHSDbwCmY2LNvxILDcSOxseJi/kTF
         BXOYjxEPsymMAlJz3kG9ZfMu5aEToB8Q4gM8OfLOO+bFPy6avv6gNr350wEnbx7APBA1
         Bwe8VRdDKD9KppFycz/4LgIdVIf3kzinNTdSan+l3IktdLbxJiRHAqQ+aTzgRd4ps+1I
         /1GqrXeRmWmEOCCRacO6JOR1VPw07AcyR/3mbdtSC2cA4eBeexud3o5kk8A8WXhQSJLB
         T3xw==
X-Gm-Message-State: AO0yUKVqTapPiqvvWcfET/640nLs28cuP60X+jEm2c4ZrD5ABa2qN7Kr
	kjtBERAMTg/bMx0sIKhpbxEK2hk+lwiydQ==
X-Google-Smtp-Source: AK7set+7S6FbEg5tMdq24xLAqykOnRyBDSfv7GSJaMJvLhPfQO+p5ezlDgPRBWld8F1LvJ9YhfoePQ==
X-Received: by 2002:ad4:574a:0:b0:56e:b16d:ec93 with SMTP id q10-20020ad4574a000000b0056eb16dec93mr60831305qvx.4.1679326789754;
        Mon, 20 Mar 2023 08:39:49 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id r132-20020a37448a000000b007466432a559sm5316275qka.86.2023.03.20.08.39.49
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 08:39:49 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-544b959a971so197070797b3.3
        for <linux-nvme@lists.infradead.org>; Mon, 20 Mar 2023 08:39:49 -0700 (PDT)
X-Received: by 2002:a81:bd51:0:b0:541:9b14:949e with SMTP id
 n17-20020a81bd51000000b005419b14949emr10558480ywk.4.1679326788920; Mon, 20
 Mar 2023 08:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <af0a1f2194fc9a6f8a95cf6c82277b8b0377d029.1679311226.git.geert@linux-m68k.org>
 <CADUfDZocrTZq2MPKFFNuJc5yBabG48EiEURwn7-t2UBuVZxCWg@mail.gmail.com>
In-Reply-To: <CADUfDZocrTZq2MPKFFNuJc5yBabG48EiEURwn7-t2UBuVZxCWg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Mar 2023 16:39:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWMih6kqSZaKq5p+UVOjTOCWdeUeif2y2ugtgcVOPmzyQ@mail.gmail.com>
Message-ID: <CAMuHMdWMih6kqSZaKq5p+UVOjTOCWdeUeif2y2ugtgcVOPmzyQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-tcp: Fix implicit padding in struct nvme_tcp_term_pdu
To: Caleb Sander <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Arnd Bergmann <arnd@arndb.de>, linux-nvme@lists.infradead.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_083957_149550_1C87DA6C 
X-CRM114-Status: GOOD (  29.84  )
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

Hi Caleb,

On Mon, Mar 20, 2023 at 4:34=E2=80=AFPM Caleb Sander <csander@purestorage.c=
om> wrote:
> The nvme_tcp_term_pdu definition needs to be updated anyways to match
> the spec. FEI is at offset 10, so it isn't 4-byte-aligned. I think we
> have gotten away with this so far because the NVMe/TCP driver never
> sends H2CTermReq and doesn't interpret C2HTermReq.
> Mirroring numdl/numdu in nvme_get_log_page_command, the definition
> should look something like:
> struct nvme_tcp_term_pdu {
>         struct nvme_tcp_hdr hdr;
>         __le16 fes;
>         __le16 feil;
>         __le16 feiu;
>         __u8 rsvd[10];
> };

Great, so it was compliant only on m68k? ;-)

> On Mon, Mar 20, 2023 at 4:29=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> >
> > On m68k:
> >
> >     drivers/nvme/host/tcp.c: In function =E2=80=98nvme_tcp_init_module=
=E2=80=99:
> >     include/linux/compiler_types.h:397:38: error: call to =E2=80=98__co=
mpiletime_assert_723=E2=80=99 declared with attribute error: BUILD_BUG_ON f=
ailed: sizeof(struct nvme_tcp_term_pdu) !=3D 24
> >
> > Indeed, on m68k the minimum alignment is 2 bytes, not 4 bytes, thus
> > triggering the check added in commit 7e87965d3807ab1f ("nvme-tcp: add
> > nvme-tcp pdu size build protection"), and indicating that NVMe over
> > Fabrics TCP on m68k must be incompatible with other platforms.
> >
> > Fix this by adding explicit padding.
> >
> > Fixes: fc221d05447aa6db ("nvme-tcp: Add protocol header")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> >  include/linux/nvme-tcp.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
> > index 75470159a194d97f..ba8f82672e39730f 100644
> > --- a/include/linux/nvme-tcp.h
> > +++ b/include/linux/nvme-tcp.h
> > @@ -115,6 +115,7 @@ struct nvme_tcp_icresp_pdu {
> >  struct nvme_tcp_term_pdu {
> >         struct nvme_tcp_hdr     hdr;
> >         __le16                  fes;
> > +       __u8                    rsvd2[2];
> >         __le32                  fei;
> >         __u8                    rsvd[8];
> >  };

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

