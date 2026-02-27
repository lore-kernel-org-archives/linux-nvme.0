Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418F1FD9E29
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 01:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Xe9R0FTdq/8KgfEwhSHbjVGMoqD5nAmJr57+aBN6PM=; b=HbPE3lI7g+glCdPPLztTyy29XF
	kyQrvjRLpvmtduyURuML72d9+8uLQqTzTx/8ENpTEEdLpLAEc7K3sQXnBPwaYqaRFcJ0viSt4ic6/
	3sZFeFw7wo3w8tdNSWEC7YzOSm1tuLgW7HvaKu/RftcYsE2feETll+/qsWiSYXsSsO/IKflv4S9QO
	KL2pwp9xkJq1k5WluIRHs8eCupBKXFNKquW8rqtJWCKDAzVbf+/s9eCOOLBzXr3X2lozG5cwwtlhP
	YD5eyqdlS9Xv+z/A/llc1IQV9PaWkqw+U/KE4NBe/cF8u6QUDO/AJQhQmWbYY4Cx03+ewlsVWNh+i
	bnTsEZyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvmkp-00000007UV3-49qd;
	Fri, 27 Feb 2026 01:34:55 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvmkn-00000007UUh-2Pn4
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 01:34:54 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-65a38c42037so5828a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 17:34:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772156091; cv=none;
        d=google.com; s=arc-20240605;
        b=ATJwlTL306cnvm0hkwfrYtlGtvaynZ+vOeCqxhAP5W0aFYHuHsRXgLxH+omBPQo4A4
         YXTUfu+f+0ssNqa00HrcnVZ6LfxDSRUfQoIg6+75Ua95CBuFFmM+hM5ito2R8lZZInLG
         xQZz3wE9vCfYr19qGg1nQcsOBfNZPLczExS/OdehFTHioRkfmZnJpPhE6Ow/sQxOPWvL
         5+AWBm4e6mUiXTWDLAodZGnOhb0jrUvn/RDOqhKsGmUtwin+6grj5GNpXSl/bAMfETr4
         Wm4w4WWJr4+yNKrrVdI0Wf4LrShCR5+GCt5E9B6j+dm1KtF8hcaydzUPSgQlfksPYqjV
         BhcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Xe9R0FTdq/8KgfEwhSHbjVGMoqD5nAmJr57+aBN6PM=;
        fh=G8jhY274+64LJHi4wepi3xlWc5IMqn4RtfZrJ3gqqWo=;
        b=H4ikRd4dOPzpYL006WN7SiYdKMJTsveAFeFYNvq22UEJYxt6pX6ztFUEDrAldAqyLb
         PPgzw7xE3oxvzBOUlpOw78zhQIOv9cKOlazQAES5vM1Y2dhu80HsrFWBKPeGExSqFe+n
         4gQqiaxtF7DvrQONpcj7SxZj/NnJBkHCrWSFOWNloKqRqrie75Oj7AHmypMqXYvKjdVA
         kgXAJUDiStz4KGEMyQv7hqoF5IlwaTfh9/H7wMfCzlxJglO8JFLo9cwd5BXODUX2dZre
         vDSTj7UOziA2pYJyB31PNp+YumXKCEVSqvjsh+qAz+n0CsOEHDH5Tn/3jXGj31CbSdUR
         v3Cg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772156091; x=1772760891; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Xe9R0FTdq/8KgfEwhSHbjVGMoqD5nAmJr57+aBN6PM=;
        b=nMebCvXy0V/aCn91SQCHdIVPLhRXxZ+eqvGq2y3c1iLJutgd3sO8b6t22+Z7zd5BvA
         byZiUKBstkWLr/BMFvJKUMPGxHBeJKMJVg3JJguk9T65sD3PEOTO4rpTi2cKm6l/ciXa
         gGt5Gtdf9yA+V6YALy3lBMcStofjFbiCcMSl+rYzjCF4gd1t0YG4h7/VK8RYdC/nI7T5
         q5eQnT62KXJmR48aDsTtvLu0ppIpTNzgqn1RSchQtbfDhT233o4YRZ1eo5AMaY6ZOFAu
         blf0CepPLxBQeUKDBoRVlogtg7ZhsOIQAm/wH9xdWDlESisv+HTR0DmnTZenxFDrpMfN
         PZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772156091; x=1772760891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Xe9R0FTdq/8KgfEwhSHbjVGMoqD5nAmJr57+aBN6PM=;
        b=ik51gcMidBbwd/94l4HtUwkHAiZglB/1081Pw/V0jrd+kFP6grvJm7YbCT58ySlrO5
         7E1eCQney8Dp+TYtQgFq9YQKIjpaQi8vlSl3s8dXcWV5foPDy8rnaGPmFVc7kuygTcYo
         8n5SE4ck4O2fwEZ7A/whYmakI4LFKFRfsGxPmBTAeixkCO9tK3sa+3mwSHIls7QqSNbe
         XFazRGkukOO3dIZ6pTEW73AXh4F/QxXo1+7hdsbrg4SfW+cm2UAjI7nl3tkJ6JupQZBW
         8PPbi4TaEYqsSdslvii2LhdodnxH/SenLzkPTDjYWWUgGTr4pRTOAmidrzI6Zip4R1Hh
         le0w==
X-Forwarded-Encrypted: i=1; AJvYcCUkRtqNZHz4P9SalcvGlejPrUIPczgUtOJhWNMWN7TgmuQEhkkPShwIYgwiwCiGcUitIdiHhfmRawvO@lists.infradead.org
X-Gm-Message-State: AOJu0YyYYCb56hUNVEFPRdekMgKSWJ2FRspXOFBzApqjmupFe94O2tYX
	JKCNNDs02jGBRWVZXPMay8JgsX0HIKPt+AyC20eJMBtETkdxRts3peLxar/+I0tneA+tqLddWGw
	7iNeSeRAnQ9t0vxfqYnp9ViPeVB4aGC4H/Om2H/K2
X-Gm-Gg: ATEYQzwm9a3ul743TnUSEgebO0BlH72REuz3Jk8KIQlnbrPdXyRIcPqMo7XEozyYx4H
	eW9gtuQxm0E/yLnrkbPEUAcMhdn1n0MVdJ8Mgojzg5Dw6j8XTAY83SkAcuv9hwrCnf86VGq1x0y
	vPwskmvGpVIGInm/pAoExhevQHgKl4ZhGxM98J8p+CatGHbSmBtZoFTlcG7lz8ut8ZdOpVFca4d
	mrr5JLtTw66wqQ4RwZmiElkMdMXeCWVAuaSQxxWb+d/jK8CIneRB94f/G/HAgoxBGxv80XQV3n5
	AaDnbpJzvFzCwsUyAGmDBFrkmIRarJQ3XZfUhA==
X-Received: by 2002:a05:6402:4619:10b0:65f:76c8:b92f with SMTP id
 4fb4d7f45d1cf-65fab2c4155mr103050a12.0.1772156090158; Thu, 26 Feb 2026
 17:34:50 -0800 (PST)
MIME-Version: 1.0
References: <20250619111806.3546162-3-yi.zhang@huaweicloud.com>
 <20260225000531.3658802-1-robertpang@google.com> <7d2a3f65-4272-46c1-991a-356f0d2323cb@huaweicloud.com>
 <CAJhEC05L7QEc9iY7gFZVK3SPYvFhtFyURss6xQgZ-qWwZZkFjA@mail.gmail.com> <8a45c55f-8abe-4cdf-be70-208550edf320@huaweicloud.com>
In-Reply-To: <8a45c55f-8abe-4cdf-be70-208550edf320@huaweicloud.com>
From: Robert Pang <robertpang@google.com>
Date: Thu, 26 Feb 2026 17:34:38 -0800
X-Gm-Features: AaiRm52oy9vcXDycCt3HX0a8oowZo0wXmgzHk3BLllBwVjMbefXMCEMxh3i5upc
Message-ID: <CAJhEC04Vpo96SKN7iRjV0fUKXEj3oQ698RdoVAdWjRjVLpgvGw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] nvme: set max_hw_wzeroes_unmap_sectors if device
 supports DEAC bit
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Zhang Yi <yi.zhang@huawei.com>, bmarzins@redhat.com, brauner@kernel.org, 
	chaitanyak@nvidia.com, chengzhihao1@huawei.com, djwong@kernel.org, 
	dm-devel@lists.linux.dev, hch@lst.de, john.g.garry@oracle.com, 
	linux-block@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	linux-xfs@vger.kernel.org, martin.petersen@oracle.com, 
	shinichiro.kawasaki@wdc.com, tytso@mit.edu, yangerkun@huawei.com, 
	yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_173453_655594_64F172FC 
X-CRM114-Status: GOOD (  36.23  )
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

Dear Zhang Yi

On Thu, Feb 26, 2026 at 3:09=E2=80=AFAM Zhang Yi <yi.zhang@huaweicloud.com>=
 wrote:
>
> On 2/26/2026 5:43 AM, Robert Pang wrote:
> > Dear Zhang Yi
> >
> > Thank you for your quick response. Please see my comments below:
> >
> > On Tue, Feb 24, 2026 at 6:32=E2=80=AFPM Zhang Yi <yi.zhang@huaweicloud.=
com> wrote:
> >>
> >> Hi Robert!
> >>
> >> On 2/25/2026 8:05 AM, Robert Pang wrote:
> >>> Dear Zhang Yi,
> >>>
> >>> In reviewing your patch series implementing support for the
> >>> FALLOC_FL_WRITE_ZEROES flag, I noted the logic propagating
> >>> max_write_zeroes_sectors to max_hw_wzeroes_unmap_sectors in commit 54=
5fb46e5bc6
> >>> "nvme: set max_hw_wzeroes_unmap_sectors if device supports DEAC bit" =
[1]. This
> >>> appears to be intended for devices that support the Write Zeroes comm=
and
> >>> alongside the DEAC bit to indicate unmap capability.
> >>>
> >>> Furthermore, within core.c, the NVME_QUIRK_DEALLOCATE_ZEROES quirk al=
ready
> >>> identifies devices that deterministically return zeroes after a deall=
ocate
> >>> command [2]. This quirk currently enables Write Zeroes support via di=
scard in
> >>> existing implementations [3, 4].
> >>>
> >>> Given this, would it be appropriate to respect NVME_QUIRK_DEALLOCATE_=
ZEROES also
> >>> to enable unmap Write Zeroes for these devices, following the prior c=
ommit
> >>> 6e02318eaea5 "nvme: add support for the Write Zeroes command" [5]? I =
have
> >>> included a proposed change to nvme_update_ns_info_block() below for y=
our
> >>> consideration.
> >>>
> >>
> >> Thank you for your point. Overall, this makes sense to me, but I have =
one
> >> question below.
> >>
> >>> Best regards
> >>> Robert Pang
> >>>
> >>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >>> index f5ebcaa2f859..9c7e2cabfab3 100644
> >>> --- a/drivers/nvme/host/core.c
> >>> +++ b/drivers/nvme/host/core.c
> >>> @@ -2422,7 +2422,9 @@ static int nvme_update_ns_info_block(struct nvm=
e_ns *ns,
> >>>          * require that, it must be a no-op if reads from deallocated=
 data
> >>>          * do not return zeroes.
> >>>          */
> >>> -       if ((id->dlfeat & 0x7) =3D=3D 0x1 && (id->dlfeat & (1 << 3)))=
 {
> >>> +       if ((id->dlfeat & 0x7) =3D=3D 0x1 && (id->dlfeat & (1 << 3)) =
||
> >>> +           (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
> >>> +           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
> >>                                 ^^^^^^^^^^^^^^^^^^
> >> Why do you want to add a check for NVME_CTRL_ONCS_DSM? In nvme_config_=
discard(),
> >> it appears that we prioritize ctrl->dmrsl, allowing discard to still b=
e
> >> supported even on some non-standard devices where NVME_CTRL_ONCS_DSM i=
s not set.
> >> In nvme_update_disk_info(), if the device only has NVME_QUIRK_DEALLOCA=
TE_ZEROES,
> >> we still populate lim->max_write_zeroes_sectors (which might be non-ze=
ro on
> >> devices that support NVME_CTRL_ONCS_WRITE_ZEROES). Right? So I'm not s=
ure if we
> >> only need to check for NVME_QUIRK_DEALLOCATE_ZEROES here.
> >>
> > The check for NVME_CTRL_ONCS_DSM is to follow the same check in [3]. Th=
ere, the
> > check was added by 58a0c875ce02 "nvme: don't apply NVME_QUIRK_DEALLOCAT=
E_ZEROES
> > when DSM is not supported" [6]. The idea is to limit
> > NVME_QUIRK_DEALLOCATE_ZEROES
> > to those devices that support DSM.
> >
>
> OK.
>
> >>>                 ns->head->features |=3D NVME_NS_DEAC;
> >>
> >> I think we should not set NVME_NS_DEAC for the quirks case.
> >>
> > Make sense. In that case, will it be more appropriate to set
> > max_hw_wzeroes_unmap_sectors in nvme_update_disk_info() where
> > NVME_QUIRK_DEALLOCATE_ZEROES is checked? I.e.
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index f5ebcaa2f859..3f5dd3f867e9 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2120,9 +2120,10 @@ static bool nvme_update_disk_info(struct
> > nvme_ns *ns, struct nvme_id_ns *id,
> >         lim->io_min =3D phys_bs;
> >         lim->io_opt =3D io_opt;
> >         if ((ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
> > -           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM))
> > +           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
> >                 lim->max_write_zeroes_sectors =3D UINT_MAX;
> > -       else
> > +               lim->max_hw_wzeroes_unmap_sectors =3D UINT_MAX;
> > +       } else
> >                 lim->max_write_zeroes_sectors =3D ns->ctrl->max_zeroes_=
sectors;
> >         return valid;
> >  }
> >
>
> Yeah, it looks good to me.

Thank you for your confirmation. I will follow up and submit the patch
to other maintainers for their review.

Best regards,
Robert

> Best regards,
> Yi.
>
> > Best regards
> > Robert
> >
> >> Cheers,
> >> Yi.
> >>
> >>>                 lim.max_hw_wzeroes_unmap_sectors =3D lim.max_write_ze=
roes_sectors;
> >>>         }
> >>>
> >>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D545fb46e5bc6
> >>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/drivers/nvme/host/nvme.h#n72
> >>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/drivers/nvme/host/core.c#n938
> >>> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/drivers/nvme/host/core.c#n2122
> >>> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D6e02318eaea5
> > [6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D58a0c875ce02
>

