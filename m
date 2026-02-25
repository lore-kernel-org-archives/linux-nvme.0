Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFABFD45F7
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 21:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vB9FeLIHdzkOeJQl8sZ1jnIIU5NTPuPRUQDCv7qOk1c=; b=XqEP1mjVE4SUPPwrMNEgGqFzkQ
	x7bKn4ca3J3Cicu6XLIEydHdCtmg/M4xa1xyQyVUjAKcImNj/8TME2GYr38GuVIxJi23co+Wl4HE+
	MejFiaNNbmBu83hN6+o0+da69So7EAB9k8m5BJyNCUj9c+l5PR1rfOvlIhr+O8JbfaEb/KPzCjU32
	wCovNFKbb91ZZZfKc0tj6hZRMG9JUEVqK9zITy24w2PIV5RcNuT/pG7s+q+N7Ae1jV97CvStx/HFK
	LyIRRanKbMsYynuGEYOLNj9BgqprnGoVfX7hGY0SQzh1NjaAYDsbVlKOKAuSMOFbo7ay8nab1fUo7
	Tt75pHUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvMfd-00000004xG3-1ooX;
	Wed, 25 Feb 2026 21:43:49 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvMfa-00000004xEp-3eJc
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 21:43:48 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-65f93fff5c5so1086a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 25 Feb 2026 13:43:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772055824; cv=none;
        d=google.com; s=arc-20240605;
        b=gcSOAX/5feIslRUb7ZVaTzrhoYuPs9SHFlz3JI4shzySrYPRzh/cgOEaTm3giDgyCH
         KmFb2Kr+oneakU4vBxXW0tDodt9yaq6/xEfrkuCM/t7tjurqJg4/suhdUMpEIFBK0v6f
         /Aj9LHf0X0Md3a3i2oPj8b8dwoFQJvegRo/jEbyFEPqFxqR3l7LM4tHL2HbXov7d33Rl
         rqB/BNiMRaADi9QKrWW/7FVv/E30D3KWIOibirVTVIx8FAclbFPjJKoH9NTv4ByyhVLZ
         cOEiWeb4k4FrLRDARlSHojOCEEBqa8YxZn3Ut+VUF2xSBmbWnzJ5nWIzkVw5MPVE8/T9
         DYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vB9FeLIHdzkOeJQl8sZ1jnIIU5NTPuPRUQDCv7qOk1c=;
        fh=qhkXcux3TaEWKaHFHSffsTcF4tGu4stNP1F2Srgdxh8=;
        b=KXWhhdRC6hB6aGbQh/IEn8+5GPwAacnyvPhA8Jp3L394fPUYvoTaX+K0N88e1Mcjsl
         c2YF8wA/vG0udIKTCibUtEsyNPWdXwVojq1jxbF8cnJBqDt6TQzdZ0VT9A6s6daAhRCv
         qsZJRHWwyjT1aIVvL/7NScg7NRg8tHK7ZfcsJJ1WFS87LrczCNlBF5zEijcR/yfJIc4l
         05ZCr7VsaFyeke0OvzUvOIxFqx4Vsx84vGolV0S2DwqGSozw2KnTWoY1V98C22N5MrDA
         JgW54tjrr+CsRoJN2cDDGpAtjrDbALSI+3xS6lvBsmoJPr2+wVOIOyWKak3O7RfSGfkB
         CesQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772055824; x=1772660624; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB9FeLIHdzkOeJQl8sZ1jnIIU5NTPuPRUQDCv7qOk1c=;
        b=jNyCocvEdSUEKekNYvi4HPvWr22mNolZBjFzfQ7gZNu7cKQGwr1nLMzTCSznpP2vHx
         VjSR2N/Pn5nkVl963O/bWnP9Nj3gDWJhm1KlhLO5X+KY57DRMq1Ekq9mQLc24w50NAgn
         vk8goxWv7UxOshxybtwDdYWQ/JK1fGaUwBfsBIWin0k6GGO5EbUA5AmEj5bEgXDak5ab
         0rcAR/mEktDJ5nW76J6KM7Dbg+i0of1j4qNQcwzKM+b+6EP33U5fS8pbgAjXlZvSMTmY
         I6I8i+0+ts+Yyme/QlzuBaHm44+U3STmAZlhxuCMalAARzcq7FX68i1XbM6VF6ofy9QY
         iJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772055824; x=1772660624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vB9FeLIHdzkOeJQl8sZ1jnIIU5NTPuPRUQDCv7qOk1c=;
        b=E6O9aDen9xsU9MQ3E+OCciz0RG4MQVrHt/DW8n51q7nrEeHOWPxEJ9BmhjyQIc4dim
         oF9uHJ21PeScgpe2HDEll9F90BKSS5pLrYTlmMnkBf7QZ8FFG/F4tmL07U+OiF9Ep3hr
         bz20tRca/Sxdw1WGNwUBno6CBXNsEkmfhApfKFmA5WLMA0I/4OaSt/EQFuBpfzqz1kZW
         vvh1QkP8lflyPVVTs4IpLA++Z/c9OurXDgR1DdEFPnzCXQw74bfYxCkjRGlEkRBxJ3Xl
         PulelqGdvF5RFNZpzJK6EGwmFQ0mtR3P4knTAVhEx0z+Z5u1BjaysFgg/oP+opZ9rsLz
         y/Fg==
X-Forwarded-Encrypted: i=1; AJvYcCX9OQWYtfOPJI5SF83XxDpI+jcDEWlGmeEArRxYQf7WCCzefEpi6GVaURv6AK1BIf7So0GrOepBNQeC@lists.infradead.org
X-Gm-Message-State: AOJu0Yx4bGQodxYqyXROqUismvYrdoRcn6ZsbQUOFRIi08fDPNOVljMK
	znGe7U7vsLHt824k/t/3aDKGbpWm1JLrobArsnG2rGmU6sHx5NHvQiD5OY1yXr7D6UDB4laah4E
	ECrWNZw/epGc6vIRKPwysxx9qz+huvt8ARvwVNzGm
X-Gm-Gg: ATEYQzya/F6+RkqPgHV/GhRPIyg/vr1WigPkcPSCJshuDjf+fByqQT3WTk9DpJcU9qo
	COKZymG29K77kAREc3W11zHbQW2XKVbofRmN0yQhMshycr1uOMr1TFNB2iciOGXRwigZcxHinIq
	TV4ICbR5xwG5VMHT4naSYPPEdxSufCiHDFvQA7Qvd9KZErsR74Z3+jyn+t7WCa1PUd68P8e1OVY
	9YhPBc0srgULJid/rOBWdi8/HwO9tkqae8VVTJCDBhVqItjiIu6BTh9996yBwxkyHPXuylxkS39
	4mG6Y4n04lcZ7bwvziSXHmEw3Nm9rArYYgwz0Q==
X-Received: by 2002:aa7:c7cf:0:b0:658:e7a:6fa7 with SMTP id
 4fb4d7f45d1cf-65fab61a7b0mr11377a12.4.1772055823405; Wed, 25 Feb 2026
 13:43:43 -0800 (PST)
MIME-Version: 1.0
References: <20250619111806.3546162-3-yi.zhang@huaweicloud.com>
 <20260225000531.3658802-1-robertpang@google.com> <7d2a3f65-4272-46c1-991a-356f0d2323cb@huaweicloud.com>
In-Reply-To: <7d2a3f65-4272-46c1-991a-356f0d2323cb@huaweicloud.com>
From: Robert Pang <robertpang@google.com>
Date: Wed, 25 Feb 2026 13:43:31 -0800
X-Gm-Features: AaiRm53fO14_kYBnlB-QimzynwfGzteAR7wRZiT1Sf0awQgFveGcUyR_Z7IWsCY
Message-ID: <CAJhEC05L7QEc9iY7gFZVK3SPYvFhtFyURss6xQgZ-qWwZZkFjA@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20260225_134346_950275_69ABF5CA 
X-CRM114-Status: GOOD (  32.99  )
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

Thank you for your quick response. Please see my comments below:

On Tue, Feb 24, 2026 at 6:32=E2=80=AFPM Zhang Yi <yi.zhang@huaweicloud.com>=
 wrote:
>
> Hi Robert!
>
> On 2/25/2026 8:05 AM, Robert Pang wrote:
> > Dear Zhang Yi,
> >
> > In reviewing your patch series implementing support for the
> > FALLOC_FL_WRITE_ZEROES flag, I noted the logic propagating
> > max_write_zeroes_sectors to max_hw_wzeroes_unmap_sectors in commit 545f=
b46e5bc6
> > "nvme: set max_hw_wzeroes_unmap_sectors if device supports DEAC bit" [1=
]. This
> > appears to be intended for devices that support the Write Zeroes comman=
d
> > alongside the DEAC bit to indicate unmap capability.
> >
> > Furthermore, within core.c, the NVME_QUIRK_DEALLOCATE_ZEROES quirk alre=
ady
> > identifies devices that deterministically return zeroes after a dealloc=
ate
> > command [2]. This quirk currently enables Write Zeroes support via disc=
ard in
> > existing implementations [3, 4].
> >
> > Given this, would it be appropriate to respect NVME_QUIRK_DEALLOCATE_ZE=
ROES also
> > to enable unmap Write Zeroes for these devices, following the prior com=
mit
> > 6e02318eaea5 "nvme: add support for the Write Zeroes command" [5]? I ha=
ve
> > included a proposed change to nvme_update_ns_info_block() below for you=
r
> > consideration.
> >
>
> Thank you for your point. Overall, this makes sense to me, but I have one
> question below.
>
> > Best regards
> > Robert Pang
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index f5ebcaa2f859..9c7e2cabfab3 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2422,7 +2422,9 @@ static int nvme_update_ns_info_block(struct nvme_=
ns *ns,
> >          * require that, it must be a no-op if reads from deallocated d=
ata
> >          * do not return zeroes.
> >          */
> > -       if ((id->dlfeat & 0x7) =3D=3D 0x1 && (id->dlfeat & (1 << 3))) {
> > +       if ((id->dlfeat & 0x7) =3D=3D 0x1 && (id->dlfeat & (1 << 3)) ||
> > +           (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
> > +           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
>                                 ^^^^^^^^^^^^^^^^^^
> Why do you want to add a check for NVME_CTRL_ONCS_DSM? In nvme_config_dis=
card(),
> it appears that we prioritize ctrl->dmrsl, allowing discard to still be
> supported even on some non-standard devices where NVME_CTRL_ONCS_DSM is n=
ot set.
> In nvme_update_disk_info(), if the device only has NVME_QUIRK_DEALLOCATE_=
ZEROES,
> we still populate lim->max_write_zeroes_sectors (which might be non-zero =
on
> devices that support NVME_CTRL_ONCS_WRITE_ZEROES). Right? So I'm not sure=
 if we
> only need to check for NVME_QUIRK_DEALLOCATE_ZEROES here.
>
The check for NVME_CTRL_ONCS_DSM is to follow the same check in [3]. There,=
 the
check was added by 58a0c875ce02 "nvme: don't apply NVME_QUIRK_DEALLOCATE_ZE=
ROES
when DSM is not supported" [6]. The idea is to limit
NVME_QUIRK_DEALLOCATE_ZEROES
to those devices that support DSM.

> >                 ns->head->features |=3D NVME_NS_DEAC;
>
> I think we should not set NVME_NS_DEAC for the quirks case.
>
Make sense. In that case, will it be more appropriate to set
max_hw_wzeroes_unmap_sectors in nvme_update_disk_info() where
NVME_QUIRK_DEALLOCATE_ZEROES is checked? I.e.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5ebcaa2f859..3f5dd3f867e9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2120,9 +2120,10 @@ static bool nvme_update_disk_info(struct
nvme_ns *ns, struct nvme_id_ns *id,
        lim->io_min =3D phys_bs;
        lim->io_opt =3D io_opt;
        if ((ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
-           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM))
+           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
                lim->max_write_zeroes_sectors =3D UINT_MAX;
-       else
+               lim->max_hw_wzeroes_unmap_sectors =3D UINT_MAX;
+       } else
                lim->max_write_zeroes_sectors =3D ns->ctrl->max_zeroes_sect=
ors;
        return valid;
 }

Best regards
Robert

> Cheers,
> Yi.
>
> >                 lim.max_hw_wzeroes_unmap_sectors =3D lim.max_write_zero=
es_sectors;
> >         }
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D545fb46e5bc6
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/nvme/host/nvme.h#n72
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/nvme/host/core.c#n938
> > [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/nvme/host/core.c#n2122
> > [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D6e02318eaea5
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D58a0c875ce02

