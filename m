Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F96C9830E
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 16:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8lwL4K1D0LmNyg6j112+oM7NzQaxc/i6AC7mkZYZafE=; b=N+kAt79atkQpr03vjZ75zdDsJH
	8bRNjwcOZav2dR6QN+rvuIFywC0uzCkJdjlSta7f+DIqsrbRMPwibM/iYKa/vgRm3vnqD4p2r+grR
	8tHbm+bh3k/7xaayZU2uwI49kRzQXfW+dcSlzCov9tPZymAg5Q2vU1/TsHCl5T2gTrXdgGVizJCSc
	2yHsln59Z3szwrrqGQETrom7MB17CeH7yWyjVFkPSk1KFbAWKs+9QnMXiGl8vS64GHTMjKIZpp7jB
	vwXZ8u+GYq3zeLEGRfDglxsPMB1ysUEd4xa29zQoa/Svh3a6o+8xU2Mur77nhjEIUQHo5M946CrzC
	y7RwFGnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Pe4-00000008r1H-0o4B;
	Wed, 23 Sep 2026 16:16:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Pdz-00000008r0T-1uNR
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 16:16:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790180186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8lwL4K1D0LmNyg6j112+oM7NzQaxc/i6AC7mkZYZafE=;
	b=O99ZLeHurq41nmGtnCAcA/mRTkGpn63HhXPSZqyN/1a2eecz9syJHpkc5RMaur+44eo1Ef
	Z0jTcaBCgB4xmuLiVx4jLeJdQXa+1MvOff14Y5cAFi3X2Xn90w4S7aHCc4Fmv5PSQJELc6
	HL8zhmNNld+tn0xrrGomzwZQzbpz/Ac=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-TR09gRyrMrKb6KE_ka7rew-1; Wed, 23 Sep 2026 12:16:23 -0400
X-MC-Unique: TR09gRyrMrKb6KE_ka7rew-1
X-Mimecast-MFC-AGG-ID: TR09gRyrMrKb6KE_ka7rew_1790180182
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e6683d48fso10897775e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 23 Sep 2026 09:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790180182; x=1790784982;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8lwL4K1D0LmNyg6j112+oM7NzQaxc/i6AC7mkZYZafE=;
        b=g3CX6v2E7Wmz+/GIGixhVS0zfUg4MNcZC/XxMShUeLsEvtsl7Fo3w2bt6tv5XSLNOF
         H6pHcWU71y4wiV8nyv/WbMXaZMe2dfrMXXh2E9xidYozATCh9h7XPL+OF7hfVbba32VQ
         OGMiVFUP3+N9WcIdIFmKUqQZOB6+Imr/g1bs5QbjOSh3IBX8kkHWok/3tq5E8v3HrPUl
         krtaDdVG+jNM2PFspWlAnW45h0UjGS26ye5/6KsW8CDJvbNWdVrXVMrOTrWenTFlk6HV
         XZ9zeycPabfD0kDnCFIKXNBhBphVp0CYLYFCz4GiNrpd6EjohfNXOwiDJkWi2rQBfIzR
         hMtg==
X-Gm-Message-State: AFuF++lQoxomE3vWcHguJVugqbmjc2GAdlmDsplvKqgwwPkbsRV0sb+J
	mOpLTYyV9OMORJ9KrmRzNsoQCehndfgZ43+hsT1cC/uSjPaNG468qFPdg+nkDfPTOe4WnesFHjW
	1XyLCvTQAliruJjrBf9Hid7qzqQWMx0g0+lmm4iJcD5DUb1YzAzdIkcak4wy1bCCvqCEmoxo+BY
	ctOCqH+AuzVK5RYsTGx9FB8btqfe4OMNcBSMGAxPWG5h0=
X-Gm-Gg: AYBFou2Sv4fAYYfdo3LBQ/JRlRQj1rtdfjDM6848Gv+9ERhT9Mbwx7QjbbGN0OsW37x
	9W6pT3QgT7HybLUVjJBJXUb2A9vk8QkMyy30ubqkA8i56idP2OQbF/eHS4EhmQbmsWGDnH78ErF
	J/L83akNwMxVqDdzunvNZlnp7oT2hP5TE4b+3ImkJUze6fbFFMDPd2e7BZJ+beV8g3aPuPeG1XB
	Oza7qVscQqHH9bb6w==
X-Received: by 2002:a05:600c:8b11:b0:49f:ce72:e931 with SMTP id 5b1f17b1804b1-49fdf252adfmr50312335e9.35.1790180182265;
        Wed, 23 Sep 2026 09:16:22 -0700 (PDT)
X-Received: by 2002:a05:600c:8b11:b0:49f:ce72:e931 with SMTP id
 5b1f17b1804b1-49fdf252adfmr50311885e9.35.1790180181802; Wed, 23 Sep 2026
 09:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260902200547.184734-1-jtaubepe@redhat.com> <20260902200547.184734-8-jtaubepe@redhat.com>
 <ab97f32b-31dd-4975-a8b2-b445110ae3a9@suse.de> <CADRr4bePoiDnWX_XrMWtQe=1g4Yrw1_dK86EV2k9XZR0HnL+UQ@mail.gmail.com>
 <d4879e78-2735-4f86-beab-8aa319e9162c@suse.de>
In-Reply-To: <d4879e78-2735-4f86-beab-8aa319e9162c@suse.de>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Wed, 23 Sep 2026 12:16:10 -0400
X-Gm-Features: AclHuK_OOO2Lx5nkFexAXjVTognXDMI5Nb3PQa0tcoQZ7jw26Edo1LYB-gBX5kg
Message-ID: <CADRr4bcSvLwzfSiV0LTxnhZR7oo3F1b2XEo+wwqi668Gr2BBQA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] nvme: fcloop: Add set_marginal_rport to sysfs
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Nilesh Javali <njavali@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, John Meneghini <jmeneghi@redhat.com>, 
	Bryan Gurney <bgurney@redhat.com>, Chris Leech <cleech@redhat.com>, 
	"Ewan D . Milne" <emilne@redhat.com>, shinichiro.kawasaki@wdc.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W_oFo5wIIxP00j0tHbwQ_mewHd3bU-Mrno1UydIJA7Q_1790180182
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_091628_382610_2E4249A2 
X-CRM114-Status: GOOD (  32.58  )
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

On Wed, Sep 23, 2026 at 11:34=E2=80=AFAM Hannes Reinecke <hare@suse.de> wro=
te:
>
> On 9/23/26 4:56 PM, Jesse Taube wrote:
> > On Mon, Sep 21, 2026 at 10:03=E2=80=AFAM Hannes Reinecke <hare@suse.de>=
 wrote:
> >>
> >> On 9/2/26 10:05 PM, Jesse Taube wrote:
> >>> To allow testing of multipath failover, add a sysfs attribute to set =
a
> >>> remote port as marginal. This will allow the fcloop LLDD to set the
> >>> marginal flag on a remote port, simulating a marginal link.
> >>>
> >>> Example:
> >>> Turn on marginal for a remote port matching wwnn and wwpn:
> >>> `echo 'wwnn=3D0x200000109b5f2956,wwpn=3D0x100000109b5f2956,marginal=
=3D1' >
> >>> /sys/class/fcloop/ctl/set_marginal_rport`
> >>>
> >>> Turn off marginal for a remote port matching wwnn and wwpn:
> >>> `echo 'wwnn=3D0x200000109b5f2956,wwpn=3D0x100000109b5f2956,marginal=
=3D0' >
> >>> /sys/class/fcloop/ctl/set_marginal_rport`
> >>>
> >>> Suggested-by: John Meneghini <jmeneghi@redhat.com>
> >>> Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
> >>> V10 -> V1:
> >>>    - New patch
> >>> V1 -> V2:
> >>>    - Fix reference count leak in error path
> >>> ---
> >>>    drivers/nvme/target/fcloop.c | 50 ++++++++++++++++++++++++++++++++=
++++
> >>>    1 file changed, 50 insertions(+)
> >>>
> >>> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloo=
p.c
> >>> index b63af3b643a6..9977c2a71bd5 100644
> >>> --- a/drivers/nvme/target/fcloop.c
> >>> +++ b/drivers/nvme/target/fcloop.c
> >>> @@ -6,6 +6,7 @@
> >>>    #include <linux/module.h>
> >>>    #include <linux/parser.h>
> >>>    #include <uapi/scsi/fc/fc_fs.h>
> >>> +#include <uapi/scsi/fc/fc_els.h>
> >>>
> >>>    #include "../host/nvme.h"
> >>>    #include "../target/nvmet.h"
> >>> @@ -21,6 +22,7 @@ enum {
> >>>        NVMF_OPT_FCADDR         =3D 1 << 3,
> >>>        NVMF_OPT_LPWWNN         =3D 1 << 4,
> >>>        NVMF_OPT_LPWWPN         =3D 1 << 5,
> >>> +     NVMF_OPT_MARGINAL       =3D 1 << 6,
> >>>    };
> >>>
> >>>    struct fcloop_ctrl_options {
> >>> @@ -31,6 +33,7 @@ struct fcloop_ctrl_options {
> >>>        u32                     fcaddr;
> >>>        u64                     lpwwnn;
> >>>        u64                     lpwwpn;
> >>> +     u32                     marginal;
> >>>    };
> >>>
> >>>    static const match_table_t opt_tokens =3D {
> >>> @@ -40,6 +43,7 @@ static const match_table_t opt_tokens =3D {
> >>>        { NVMF_OPT_FCADDR,      "fcaddr=3D%x"     },
> >>>        { NVMF_OPT_LPWWNN,      "lpwwnn=3D%s"     },
> >>>        { NVMF_OPT_LPWWPN,      "lpwwpn=3D%s"     },
> >>> +     { NVMF_OPT_MARGINAL,    "marginal=3D%d"   },
> >>>        { NVMF_OPT_ERR,         NULL            }
> >>>    };
> >>>
> >>> @@ -120,6 +124,13 @@ fcloop_parse_options(struct fcloop_ctrl_options =
*opts,
> >>>                        }
> >>>                        opts->lpwwpn =3D token64;
> >>>                        break;
> >>> +             case NVMF_OPT_MARGINAL:
> >>> +                     if (match_int(args, &token)) {
> >>> +                             ret =3D -EINVAL;
> >>> +                             goto out_free_options;
> >>> +                     }
> >>> +                     opts->marginal =3D token;
> >>> +                     break;
> >>>                default:
> >>>                        pr_warn("unknown parameter or missing value '%=
s'\n", p);
> >>>                        ret =3D -EINVAL;
> >>> @@ -199,6 +210,9 @@ fcloop_parse_nm_options(struct device *dev, u64 *=
nname, u64 *pname,
> >>>
> >>>    #define TGTPORT_OPTS        (NVMF_OPT_WWNN | NVMF_OPT_WWPN)
> >>>
> >>> +#define MARGINAL_OPTS        (NVMF_OPT_WWNN | NVMF_OPT_WWPN | \
> >>> +                      NVMF_OPT_MARGINAL)
> >>> +
> >>>
> >>>    static DEFINE_SPINLOCK(fcloop_lock);
> >>>    static LIST_HEAD(fcloop_lports);
> >>> @@ -1663,6 +1677,40 @@ fcloop_set_cmd_drop(struct device *dev, struct=
 device_attribute *attr,
> >>>        return count;
> >>>    }
> >>>
> >>> +static ssize_t
> >>> +fcloop_set_marginal_rport(struct device *dev, struct device_attribut=
e *attr,
> >>> +             const char *buf, size_t count)
> >>> +{
> >>> +     struct fcloop_nport *nport;
> >>> +     struct fcloop_ctrl_options opts =3D {};
> >>> +     unsigned long flags;
> >>> +     int ret;
> >>> +
> >>> +     ret =3D fcloop_parse_options(&opts, buf);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     /* everything there ? */
> >>> +     if ((opts.mask & MARGINAL_OPTS) !=3D MARGINAL_OPTS)
> >>> +             return -EINVAL;
> >>> +
> >>> +     nport =3D fcloop_nport_lookup(opts.wwnn, opts.wwpn);
> >>> +     if (!nport)
> >>> +             return -ENOENT;
> >>> +
> >>> +     spin_lock_irqsave(&fcloop_lock, flags);
> >>> +     if (!nport->rport || !nport->rport->remoteport) {
> >>> +             spin_unlock_irqrestore(&fcloop_lock, flags);
> >>> +             fcloop_nport_put(nport);
> >>> +             return -ENOENT;
> >>> +     }
> >>> +
> >>> +     nvme_fc_set_remoteport_fpin(nport->rport->remoteport, opts.marg=
inal);
> >>> +     spin_unlock_irqrestore(&fcloop_lock, flags);
> >>> +     fcloop_nport_put(nport);
> >>> +
> >>> +     return count;
> >>> +}
> >>>
> >>>    static DEVICE_ATTR(add_local_port, 0200, NULL, fcloop_create_local=
_port);
> >>>    static DEVICE_ATTR(del_local_port, 0200, NULL, fcloop_delete_local=
_port);
> >>> @@ -1671,6 +1719,7 @@ static DEVICE_ATTR(del_remote_port, 0200, NULL,=
 fcloop_delete_remote_port);
> >>>    static DEVICE_ATTR(add_target_port, 0200, NULL, fcloop_create_targ=
et_port);
> >>>    static DEVICE_ATTR(del_target_port, 0200, NULL, fcloop_delete_targ=
et_port);
> >>>    static DEVICE_ATTR(set_cmd_drop, 0200, NULL, fcloop_set_cmd_drop);
> >>> +static DEVICE_ATTR(set_marginal_rport, 0200, NULL, fcloop_set_margin=
al_rport);
> >>>
> >>>    static struct attribute *fcloop_dev_attrs[] =3D {
> >>>        &dev_attr_add_local_port.attr,
> >>> @@ -1680,6 +1729,7 @@ static struct attribute *fcloop_dev_attrs[] =3D=
 {
> >>>        &dev_attr_add_target_port.attr,
> >>>        &dev_attr_del_target_port.attr,
> >>>        &dev_attr_set_cmd_drop.attr,
> >>> +     &dev_attr_set_marginal_rport.attr,
> >>>        NULL
> >>>    };
> >>>
> >> Please don't make it a fabrics option.
> >
> > What do you mean by fabrics option? How should I fix this?
> >
> Your patch does two things; one is to modify the parser in
> fcloop_parse_options, and the other is to implement a new
> sysfs rport attribute 'set_marginal_rport()'.
> My suggestion is to drop the first part;

You want to drop the parser?

> we really should not start off
> with a marginal port, rather only set ports to marginal during runtime.

Yes it starts as not marginal and will only be set or unset
with a write to `set_marginal_rport` during runtime.

Thanks,
Jesse Taube

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich
>


