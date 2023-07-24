Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8712EC001DF
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 15:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QHalsPiIjOJICk+12JzmvIaqdpQtqn7Opn0O9pjUlF8=; b=u6im6h624yFXV6rAh9rIK9kUDu
	WJOrwipg47eNEiXFDsprm7juZRlRVP1rt7plz2V9L28Hn4v5hinvBthMl8cJx3MMoR7Gwter7FRBY
	jE5fmroCVidF2S+6uuJDIYFyEImBY0vYiFVG+w4TRERvXtBYwz2BSbSUNJKV9RZNQ2jORupyMx7M4
	KpUct7KmoDNsLw5ngkEd2XGKPy+mp/Sgj2Myxn0SBqZAuZHLmcLf9STlz5JRnUMfuZSQTybxLVvvC
	T2RAKs742QkdmbPLFHSWt1Izai8lHjFkjkRQMoGT9zLZs22e7AzFvow5x5Ab9E/T3DJxp5UnLpJ6t
	Cra/bnog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNxHV-004hzv-2s;
	Mon, 24 Jul 2023 15:15:29 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNxHC-004hyH-0K
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 15:15:12 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8ad356fe4so27343935ad.2
        for <linux-nvme@lists.infradead.org>; Mon, 24 Jul 2023 08:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1690211706; x=1690816506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHalsPiIjOJICk+12JzmvIaqdpQtqn7Opn0O9pjUlF8=;
        b=VwSvTh/CzcMOR5/cfL2TDFbE0Wndu8p5pZXZDnxVQQPXyXWgesmMgPaYbxBorrobMV
         MsYDUdTVaXMwsX+sVp0vEZHGRp0+qyS7NkuAeTQFd2DpyzWUhw2fYqrU2zJJn+gfOO8z
         jTXDnpEVGPQIgUct5q4KvbT9noytx0BHGRYELS1oGwy+1aVR8pV5mNSTyBP5Hk28Pe8l
         P12ZzQmofUONPDeQB3oM7Hy21hmYlcxPSRDx1IlYA3KkNX+txSvXq17UoGzCoK6CYZuB
         xkw6nLG0uXshTKeeUhSPFjDFD9tUhS0tlYxRGwGJhGIZD291YUQq6EHwofVNC6SDVT2X
         mPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690211706; x=1690816506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHalsPiIjOJICk+12JzmvIaqdpQtqn7Opn0O9pjUlF8=;
        b=UCyazQpvfDUD/j4lKVzIsTf0jsHqk0H345rUxZ5DPHUxiiHogAt67H22df9xf/s9Ia
         HjqWaIiqtTgI/JiwD6qff6sSqHntqUyjRuB8JqVZ2bnjOnZG1b9BJfBGBHMKoz2AujGP
         xILhKq8SKeb/S4XOqbFpPHk7vUpPc8wfS7fT7re3w/jzXShFd94nnPaZU47+u8gl++RN
         e8+IANGxp4BLmPCn+cY/gHOkgvailjnWQC+sy4b6pEkejzTsEO4Rc8eaPH2mtPof0+v/
         YUM1tM1kLQ88fH+U+AytLZYR8TvyoLnD+PDKQJC4xciR1T6xAkW9EiZ/Kirh4yhuNLPm
         NOMg==
X-Gm-Message-State: ABy/qLZX7BAGPkAN8V8UpoocG+rfS+qpKTE2shc4+/4P4HsdD++1zMyE
	eyC+suZvMxQ0LlKhwXmIuDehEgY8iiJg+/satA2BKw==
X-Google-Smtp-Source: APBJJlFd5G+gDxZu0mAOIv80etz3WeRYs2anVj4swrc5lGK0g2F23mRkGVuBfS2D5w2oW/7djnd6s84tSFaRrBcdz1U=
X-Received: by 2002:a17:90a:7489:b0:262:e807:9a43 with SMTP id
 p9-20020a17090a748900b00262e8079a43mr8851323pjk.31.1690211706518; Mon, 24 Jul
 2023 08:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230724090611.705366-1-sagi@grimberg.me>
In-Reply-To: <20230724090611.705366-1-sagi@grimberg.me>
From: Caleb Sander <csander@purestorage.com>
Date: Mon, 24 Jul 2023 08:14:55 -0700
Message-ID: <CADUfDZr9bNo17_NmWLCu_kVdURQn7XbbwtZoi2XzF8NTNyL_VA@mail.gmail.com>
Subject: Re: [PATCH libnvme] fabrics: don't pass sqflow_disable if the kernel
 does not support the option
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_081510_640490_4DF07918 
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

Hi Sagi,

On Mon, Jul 24, 2023 at 2:11=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
> Instead of retrying again without it.
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  src/nvme/fabrics.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
> index fd761d10d0cb..2a9d8dc7f23a 100644
> --- a/src/nvme/fabrics.c
> +++ b/src/nvme/fabrics.c
> @@ -1026,7 +1026,7 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t h,
>                 return NULL;
>         }
>
> -       if (e->treq & NVMF_TREQ_DISABLE_SQFLOW)
> +       if (e->treq & NVMF_TREQ_DISABLE_SQFLOW && h->r->options->disable_=
sqflow)

How do we know options is initialized here? It looks like that's done
in __nvmf_supported_options(), called from nvmf_add_ctrl(), which is
called a few lines later in this function.

>                 c->cfg.disable_sqflow =3D true;
>
>         if (e->trtype =3D=3D NVMF_TRTYPE_TCP &&
> @@ -1038,16 +1038,6 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t h,
>         if (!ret)
>                 return c;
>
> -       if (errno =3D=3D EINVAL && c->cfg.disable_sqflow) {
> -               errno =3D 0;
> -               /* disable_sqflow is unrecognized option on older kernels=
 */

The kernel didn't add support for reporting its supported options
until 5.17. If the kernel doesn't report this information, we fall
back to default_supported_options, which represents the options the
kernel supported when the reporting mechanism was added. These include
disable_sqflow, so h->r->options->disable_sqflow will always be true
(unless support for it is removed in the future), even if the kernel
is an old version that doesn't support it. So if this disable_sqflow
fallback behavior is necessary for older kernels, I don't think it can
safely be replaced by the h->r->options->disable_sqflow check.

> -               nvme_msg(h->r, LOG_INFO, "failed to connect controller, "
> -                        "retry with disabling SQ flow control\n");
> -               c->cfg.disable_sqflow =3D false;
> -               ret =3D nvmf_add_ctrl(h, c, cfg);
> -               if (!ret)
> -                       return c;
> -       }
>         nvme_free_ctrl(c);
>         return NULL;
>  }
> --
> 2.41.0
>
>

Best,
Caleb

