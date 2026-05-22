Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67419CD5BB0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 22:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HJcB/e2HM/yLdfe9uuc/g+BNz/ESpcJ1k5dnE+m7fZo=; b=CWcRtyj4LWt9usUu54uFTsS9Mi
	WyoSzLIHmQn3JImfLtlZZHVIpBt4h1p+lEnJEJpvT+GWBBhXTUFTWV5P6hWGZB6gmefyO32dXxeOj
	823oUU9wDQGSEg2z5LM9oaS+xVYStRFyYo7m82FhqL+GsEx5PZdZH5QOxomCPtr+zXLOUcaZOhnu2
	QWKhdBh+Co5/tfjnIYVv8tiNN8yFGrmrmKAY994rMVZlepC14fMJyI+QK1pcloKKq+/fqSXAb8pko
	t/g8luw/L9jLs6/xbUu9FG8lL1HLsnjopqQv+wlpN3q2FJnDCfTZ2xiAqa9T6/c339eTJzhgAb5pM
	onvJfOzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQYnA-0000000C9p1-0JuL;
	Fri, 22 May 2026 22:56:32 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQYn8-0000000C9oW-06Oa
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 22:56:31 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-6870f904c6bso6671704a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 22 May 2026 15:56:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779490588; cv=none;
        d=google.com; s=arc-20240605;
        b=lSj3ZEaGsITkzVUlOXkTn2KmVp/1G1eWtGQYuw/VUez72ZQiWitnzsJLiyBqIkXGPr
         IwTFh4dN5g5V488sU2gxyRq+sxgbWdFOxF4R/ZX13TeSdtyJGmN43ZtYI1NUJ0fHomOf
         d2kbvMXtbr9QmBHS8Z2rDAzlNNStpWHorNjo3xy/L73CZX7Nj8DrhZ+kuwB4ks0I1Q5r
         fvIUr7Ok0c+780+blSnwq+yJbR65mKIxbBwKf+W8lll9xoKRDLroN0LEK6nyk7taO+lU
         7RBtCloHL13IGWPG+94sPRsXG0Lf4Urx+Z9IwbTMV91xgpwyCxRd1vAzJCbka02nSAwW
         /0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HJcB/e2HM/yLdfe9uuc/g+BNz/ESpcJ1k5dnE+m7fZo=;
        fh=6a95mKy1DtaxL61dGCDQcUUy5+2gtEOFQIkU2h6xRVc=;
        b=b83K+YIOUvkSt8DNWTOd8dnLcFjLbwhutTApvf3v0jXEWKhigDwwO87fGCi2XeKeaT
         wpEOgdFyhrP1jmQNZhT52jpCnvtHRjvW0VpbkAOhAmCiJXqvdZJRFUjLp5XVmeQgLRzM
         1wtKYElqJ+0xRiTWcroEuW6z7NV7NfzUYARw6XkBd1gC5dfVZefPRmD0mmlaphlUVUaz
         6/PcxRJDxdVLwnHZMAUR/KY7D1bEccGwoUBEolnqbn0k2ftPbiCWZNPVJp0FAi/zRAoW
         0i2FePBdUh8yDi7Vf9ulpRAupJOYHnDHqB680mCcJqA7nla8JXKrfcOjbw2ECQnzDLb7
         NFDw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779490588; x=1780095388; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJcB/e2HM/yLdfe9uuc/g+BNz/ESpcJ1k5dnE+m7fZo=;
        b=iDxFaP0Y4XYe7t7bDjANufLa6gPiEV4lw6RaOKEy3JX4k/kAPdB0mN1lxLy0k6Rj2J
         IdN7V+vqykpl63Q1vXn+ANA9s5lW8prBs6c8T/yOdXUmE04bnomdNhm52h+sPfzG7nky
         Kitrtb5JOJseRU5jPj+/V+dOrhU1LHahSjiCPPVaMj00sKSd/fv8XG+Y79C24dWfd0Bc
         wl5KZPtjmPV0CN/1OF4d7Aj/+TFucQsvCzoRaoRH5i5+HUORm3D/DbDPJrDRiCAXsqxh
         Y4RIExVjSPv0bWhLmZIrHWsvND7S5EfiDBbOqZmP/vVdRHhZHbq+Jl24YCbkkb/mlAng
         /gRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779490588; x=1780095388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HJcB/e2HM/yLdfe9uuc/g+BNz/ESpcJ1k5dnE+m7fZo=;
        b=rYVtZ5v58f7yR29TD3pH7AQHfGT10M2vCLNb8s7rUTw4NRM2JhTODcE8M1A3syi4MN
         d8vMwtDv1dKH4xdb548nQlvG8QtGns0jGZA2v5UPnJeliXEb2yEF383XrX2meqDWKvI9
         YiZTUCt8UemVUKUJdW3szZbpOtill3XhLSDzt1p0rS4FkHGhsGQSss4lsuiuYglBPYBH
         GLOIM1rddtd/oKQmhDKdwDEJQl+FrsNxjyaWqmJSCehgAeGt3pgCKRSzwy4e8nvFNPHL
         VWJmXiAOgFL8vvsWQABW2L/nTPRsqEI1EpjsTYcFHRob9UHHJv82DRa+3vmjXtb85JTs
         9j7Q==
X-Gm-Message-State: AOJu0YxpnR1RDGaUFr4KH6vwQPvCTOoVxMhxPecUEaYXdLWEj5I0Ud54
	OQRGk0y0uzsE6dSCbKerbzJJzoXtudtsrVm1U9Z82qSdo/Ktg/MIhV701KBpfvzEnhYjfpPI2Tc
	O+om/LDd4BWcFsad6NipQUSx5FNTiMyY=
X-Gm-Gg: Acq92OEVIWEbTMgBdYEi/qI0UhhcSwF5OH8YggfCrSYib9uAZ03MJDFPaQMOC17njBR
	iMRhX17+mY/suWrGvp9Ug1z2H76/GY7LKMoCSTu/+crqgvi83z8CFbuL0Rb1vTaUpfM9nrj1KZY
	9fNbPgVd4VBBE8ChdXjVjddpZuPSUeuZA5UIOT96lZT3Q23Hl3tm9tIWhMwtaFsMkWxzNkdCRig
	x7pbRK4wsqMw27dWHVQgGX8+SI/X9mC3pMkVaAxX4s2hhMhyRaTUkCBAR6ZsJcPTDQ/Wzz7ei6o
	EgtSibc=
X-Received: by 2002:a17:907:2678:b0:bd0:7949:a931 with SMTP id
 a640c23a62f3a-bdd2a408de2mr253483866b.27.1779490587950; Fri, 22 May 2026
 15:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260522162639.395802-1-coshi036@gmail.com> <ahCvVhKxRLRPWscH@kbusch-mbp>
In-Reply-To: <ahCvVhKxRLRPWscH@kbusch-mbp>
From: Chao S <coshi036@gmail.com>
Date: Fri, 22 May 2026 18:56:16 -0400
X-Gm-Features: AVHnY4IJhP2KNXzNWcBYPwpl1MYDM4HAy5YYc9Osda9WCyQNdgTYq8ghwSQJLng
Message-ID: <CACd_6n10kCX3USoHqs9OJdAfzDf8B0wUz06Aw77J0K9WhF=TEw@mail.gmail.com>
Subject: Re: [PATCH v4] nvme: reject keep-alive passthrough on non-fabrics
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, 
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>, Maurizio Lombardi <mlombard@arkamax.eu>, 
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>, 
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_155630_120470_5314E57C 
X-CRM114-Status: GOOD (  23.48  )
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

Hi Keith,

Thanks for the feedback, I understand your idea now. Patch v5 will
incorporate the advice.
Thanks again!

Chao

On Fri, May 22, 2026 at 3:32=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Fri, May 22, 2026 at 12:26:39PM -0400, Chao Shi wrote:
> > +/*
> > + * Some Set Features commands change controller behaviour that the dri=
ver is
> > + * not prepared to handle on every transport.  Reject such commands fr=
om
> > + * userspace passthrough rather than letting them put the controller i=
nto a
> > + * state the driver cannot deal with.  The list can be extended as oth=
er
> > + * problematic features are identified.
> > + */
> > +static bool nvme_passthru_cmd_allowed(struct nvme_ctrl *ctrl,
> > +                                   struct nvme_ns *ns,
> > +                                   struct nvme_command *c)
> > +{
> > +     /*
> > +      * This only filters admin commands (ns =3D=3D NULL).  I/O comman=
ds share
> > +      * the opcode space with admin commands - Dataset Management is 0=
x09,
> > +      * the same value as Set Features - so they must not be inspected=
 here.
> > +      */
> > +     if (ns || c->common.opcode !=3D nvme_admin_set_features)
> > +             return true;
> > +
> > +     switch (le32_to_cpu(c->common.cdw10) & 0xff) {
> > +     case NVME_FEAT_KATO:
> > +             /*
> > +              * Keep Alive is optional on PCIe (NVMe 2.0a 5.27.1.12) a=
nd the
> > +              * driver only arms keep-alive for fabrics.  Enabling it =
on
> > +              * other transports starts a keep-alive command the drive=
r is
> > +              * not set up for and harms idle power states, so reject =
it.
> > +              */
> > +             return ctrl->ops->flags & NVME_F_FABRICS;
> > +     default:
> > +             return true;
> > +     }
> > +}
>
> This doesn't need to be its own function. You can add these checks to
> the existing nvme_cmd_allowed():
>
> ---
> @@ -50,6 +53,18 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struc=
t nvme_command *c,
>                         case NVME_ID_CNS_CTRL:
>                                 return true;
>                         }
> +               } else if (c->common.opcode =3D=3D nvme_admin_set_feature=
s) {
> +                       switch (cpu_to_le32(c->features.fid) & 0xff) {
> +                       case NVME_FEAT_KATO:
> +                               if (ctrl->ops->flags & NVME_F_FABRICS)
> +                                       break;
> +                               fallthrough;
> +                       case NVME_FEAT_HOST_BEHAVIOR:
> +                       case NVME_FEAT_HOST_MEM_BUF:
> +                       case NVME_FEAT_NUM_QUEUES:
> +                       case NVME_FEAT_AUTO_PST:
> +                               return false;
> +                       }
>                 }
>                 goto admin;
>         }
> --

