Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96DEC7618A
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Mar 2023 15:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gev+lmTSygz71wO6A6cNgtj4LSfVrLddOXwraPWxX2c=; b=irPrKy4GytNkOJxUCreVGWDE/a
	7xcTerD4HY3pyrkfxFWrdcB4yc2DhStvrSB/7uBdgkZl9hx5FfFQEsDxONy/cOgeoN+DpEmGLuPWf
	da1HKHEvMucpMxJp+GcviiPii07Yi6z17JjBs22mQ5MjirS5ETEaeOACrfffsYHCqlJlZXJyzhU//
	T86G+k5a3Iydst1NnCXwrzceRJGv+jx1SlR3mWHmkUswR/t8oYptqHYPYP7LKkw4Y+d6bL50FpOX4
	ICJBNz9nC00UZayYazUE8aBuK4KbWUz/uakaqW7hJ2v2VQhns4HxPsC84EYpjCmJB/tz9cuVhpcTX
	c1Kp0CDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peHXC-009Zrh-0B;
	Mon, 20 Mar 2023 15:34:54 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peHX9-009Zqm-1b
	for linux-nvme@lists.infradead.org;
	Mon, 20 Mar 2023 15:34:52 +0000
Received: by mail-ed1-x535.google.com with SMTP id ek18so48372270edb.6
        for <linux-nvme@lists.infradead.org>; Mon, 20 Mar 2023 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1679326489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gev+lmTSygz71wO6A6cNgtj4LSfVrLddOXwraPWxX2c=;
        b=EgUCBDYYrWJ5uO3T3dPxpCLgj6ldA9iqzSVSSnyLEPMFRBGzlbSwKaNXuLT1kwwMDD
         WYsOYVmlR3FknZMj+rIWX/vZ7lkujwgz3kV3O1G++PNMj+H24ZqMjSO269ShhpoiD9pH
         Ime1XpUSigSDSAbS/eH2zQ4WfbpCVDKjA83jOw3+YcOzcfIJwNDqcd+GzhURUgmFsdRZ
         IjyKkNSVtViPm/1xdRhRss1rW3drQMuh4hQ1+eWYNtXzbg2hR7pRJexI7OXIlyOLTo/O
         6CMa1Tio0W2f+U8KSTx36GZd2zyueusC6uuwVeEE5xI5xyoDmAV3XzhfhNvsdwvUVQfH
         GugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679326489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gev+lmTSygz71wO6A6cNgtj4LSfVrLddOXwraPWxX2c=;
        b=Su9eilZEStbvzed2aKzXaysI1xFLKY4DyOZ/iCPOBYP1nYOFtlvuLjShZ0K/m7DoeG
         Afm0tz82V1UusJF9wUvqrsECdP2PDNHFnAC0Cul7asAd8C1Qs4gsuJwBYLMUSD4jIFUZ
         qe1tX3zNucis+ZuDt3+JaYAn8t6EPXqMksG2A+uQyyCq4qxIwGMQUhiaMwDuke3T1uj1
         9djCfmerMGYx5FbgfajOgNyaWa3MteLU0TeGaellyNaGYLvKFazDw9wQQ+kAcT4zx1/x
         hHAPXJvvlYfLeHg4mYVT/4W8/DEVMyJICe2vg5XcHMytpkEmQ12VVQFL+i1EAtMvyRsg
         0Gcg==
X-Gm-Message-State: AO0yUKUQbAq/LX0mF0csTJW7VPVwo2yrBdzdvpbsEJGkBqaHAasFzGQu
	3JuYIAIuYssXYIBH8P7jJDLqRzXRpZ/p0WLIqtMWTQ==
X-Google-Smtp-Source: AK7set9t1GSZQvLjwHP75VPWyy4c6sXRoX5WbHLyQmpI3SxhTwuy82upwft7ydf/sZudpjbyLo4B7u6+zU0Qc1Y/V0g=
X-Received: by 2002:a50:d594:0:b0:4fb:7ccf:337a with SMTP id
 v20-20020a50d594000000b004fb7ccf337amr6576541edi.3.1679326489177; Mon, 20 Mar
 2023 08:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <af0a1f2194fc9a6f8a95cf6c82277b8b0377d029.1679311226.git.geert@linux-m68k.org>
In-Reply-To: <af0a1f2194fc9a6f8a95cf6c82277b8b0377d029.1679311226.git.geert@linux-m68k.org>
From: Caleb Sander <csander@purestorage.com>
Date: Mon, 20 Mar 2023 08:34:38 -0700
Message-ID: <CADUfDZocrTZq2MPKFFNuJc5yBabG48EiEURwn7-t2UBuVZxCWg@mail.gmail.com>
Subject: Re: [PATCH] nvme-tcp: Fix implicit padding in struct nvme_tcp_term_pdu
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Arnd Bergmann <arnd@arndb.de>, linux-nvme@lists.infradead.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_083451_730910_358D55E5 
X-CRM114-Status: GOOD (  19.94  )
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

The nvme_tcp_term_pdu definition needs to be updated anyways to match
the spec. FEI is at offset 10, so it isn't 4-byte-aligned. I think we
have gotten away with this so far because the NVMe/TCP driver never
sends H2CTermReq and doesn't interpret C2HTermReq.
Mirroring numdl/numdu in nvme_get_log_page_command, the definition
should look something like:
struct nvme_tcp_term_pdu {
        struct nvme_tcp_hdr hdr;
        __le16 fes;
        __le16 feil;
        __le16 feiu;
        __u8 rsvd[10];
};

Best,
Caleb

On Mon, Mar 20, 2023 at 4:29=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> On m68k:
>
>     drivers/nvme/host/tcp.c: In function =E2=80=98nvme_tcp_init_module=E2=
=80=99:
>     include/linux/compiler_types.h:397:38: error: call to =E2=80=98__comp=
iletime_assert_723=E2=80=99 declared with attribute error: BUILD_BUG_ON fai=
led: sizeof(struct nvme_tcp_term_pdu) !=3D 24
>
> Indeed, on m68k the minimum alignment is 2 bytes, not 4 bytes, thus
> triggering the check added in commit 7e87965d3807ab1f ("nvme-tcp: add
> nvme-tcp pdu size build protection"), and indicating that NVMe over
> Fabrics TCP on m68k must be incompatible with other platforms.
>
> Fix this by adding explicit padding.
>
> Fixes: fc221d05447aa6db ("nvme-tcp: Add protocol header")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  include/linux/nvme-tcp.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
> index 75470159a194d97f..ba8f82672e39730f 100644
> --- a/include/linux/nvme-tcp.h
> +++ b/include/linux/nvme-tcp.h
> @@ -115,6 +115,7 @@ struct nvme_tcp_icresp_pdu {
>  struct nvme_tcp_term_pdu {
>         struct nvme_tcp_hdr     hdr;
>         __le16                  fes;
> +       __u8                    rsvd2[2];
>         __le32                  fei;
>         __u8                    rsvd[8];
>  };
> --
> 2.34.1
>
>

