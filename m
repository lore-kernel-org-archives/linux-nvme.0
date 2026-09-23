Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EF8C9830B
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mgl2fzrtLyoiFrBfNonxZVX3GZjaxX+KyLU7gYeHtiE=; b=hnKGSMAz2goOblNk28HCNFMYEu
	JHCkK9WopegcnEHWHgvqGIIY3dcHn05zuA6YHmUKK3R4O8ogzoBNBBqmKFtS2Vzv/CMGKQYzYiQv9
	/RwgpIxGx0v9bBk+wfclxK3rCkb9hwwJWd5mL2IxrCl16bjTrTmReCifpYgi9MXhlPQHV62febvSd
	keulc+WbnFnNZWMC42ddr36LN/+TLVFYVJTn/5tJ8nfSDDC6wpxE3e8aTc/0r91Nnacc/4w0m6AiX
	AxcfRo/Hbk3l55Ct8ewYlVCZILkWY6Hnj2D4HAGil+msT1OPQBLH+eSqJSrG70UWheReO6mdYQKuD
	DSkyZM+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9OOr-00000008bTG-19Qb;
	Wed, 23 Sep 2026 14:56:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9OOo-00000008bSs-37ah
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 14:56:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790175401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mgl2fzrtLyoiFrBfNonxZVX3GZjaxX+KyLU7gYeHtiE=;
	b=iejodJnyID9u5TOT5LXICNL8o9nPiJ8LbMUyj41jD4U+qdRGIlqS5nZTZO4WOj0i6Agg6G
	hGoEDUpV2jJ653Nnsh8YkC/CMtk6X+2TCChMbL0aS2Eu6r77snzF2wcaiIN+UGdEuW3NKa
	MCmAF8V/wbSU3Vdkc1yfdu7pV75uu5U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-40K4EzNXMlyP7dmVNTKeDA-1; Wed, 23 Sep 2026 10:56:40 -0400
X-MC-Unique: 40K4EzNXMlyP7dmVNTKeDA-1
X-Mimecast-MFC-AGG-ID: 40K4EzNXMlyP7dmVNTKeDA_1790175399
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e6ba4abdfso12706625e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 23 Sep 2026 07:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790175399; x=1790780199;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mgl2fzrtLyoiFrBfNonxZVX3GZjaxX+KyLU7gYeHtiE=;
        b=lQ+OhOaaRlT1rOo4F05fbDIoaLieF9pp3379iAZhdJSHIrpp7fKE5Rfn5B7SUXBlfI
         ggzpe7uDtpE3rY+5tU6CgRojmekaXUnZeIbfB/pK9sC+K5kmpqNFw1AHr+PbW+XYEBH4
         Od2+Gluxi1kHDeqHcjWBOB5gJHRhEeX7UFri/VNsJ4hYz7wDeFzSMu2A1oj5/HFEssst
         /PP1Xqja/zk/B5+wJhN3VOD02o8qfL3l9sSPfRqZl2K1LCIr/8akZP1xegdowHMS0366
         Tlg5psDktYrhUrRbQxIXT7iJ5Awcpa9X0nbezjRZO8PNmjOoH7Bren+hFZRcbObRJ8bI
         VAgw==
X-Gm-Message-State: AFuF++n0A1ONuEM4fL5AEG5tQmZGH4Jm9zO7PGBDa0nesndqhZ2WDs92
	Q666MH46hSnquH4AibxSPYsKoNhtdh8dPXFSyPGjtqa80MPjbbyNae+8i/z1E6ikoJrkmPsNw7v
	Vv/bqUrINHCXrUWRm9P/EOHVtqeKhx+E9gTM6EHvkU/MoZ8DfSStxLrO90WF/2K/ygW8IdhO/sj
	Uhtdf6vY532Q088duSZxXd5nhc7iT4bTHJWm11BglI9Sw=
X-Gm-Gg: AYBFou3xM/bpwiVmjz/P8mVZ0gZS7QF355a7K94ObMwJSHf6JNSnNW6HSUkhdNryy0Q
	nofAj8lO9kAQ3xkAXqx+HBl7m5kEr3LZHDdJjaQD6sRnljH1BhF4b1ZBptesl03NvESg60qr2au
	ODqRZeWUmkOquV2iR2uF4VbWY8e5i/4/HKoKmiilpIHrWsd9KEjPp2Qog6obBeJOAFvpZvqfEfP
	c1HnxIhyzKvmrrLMQ==
X-Received: by 2002:a05:600c:3b21:b0:49f:bd3c:bc25 with SMTP id 5b1f17b1804b1-49fdf25486bmr41518255e9.32.1790175398674;
        Wed, 23 Sep 2026 07:56:38 -0700 (PDT)
X-Received: by 2002:a05:600c:3b21:b0:49f:bd3c:bc25 with SMTP id
 5b1f17b1804b1-49fdf25486bmr41517685e9.32.1790175398258; Wed, 23 Sep 2026
 07:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260902200547.184734-1-jtaubepe@redhat.com> <20260902200547.184734-8-jtaubepe@redhat.com>
 <ab97f32b-31dd-4975-a8b2-b445110ae3a9@suse.de>
In-Reply-To: <ab97f32b-31dd-4975-a8b2-b445110ae3a9@suse.de>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Wed, 23 Sep 2026 10:56:27 -0400
X-Gm-Features: AclHuK-DXEgf8h50oy37YCFQPiuZykx03xaAenYlWJQtQSO7dJcvZ7KWpU5nfJA
Message-ID: <CADRr4bePoiDnWX_XrMWtQe=1g4Yrw1_dK86EV2k9XZR0HnL+UQ@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: IPJoj8LH92nkXDO08DckFFFa1jybn1W6ROzQz4ci8VI_1790175399
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_075642_958891_825E7530 
X-CRM114-Status: GOOD (  31.18  )
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

On Mon, Sep 21, 2026 at 10:03=E2=80=AFAM Hannes Reinecke <hare@suse.de> wro=
te:
>
> On 9/2/26 10:05 PM, Jesse Taube wrote:
> > To allow testing of multipath failover, add a sysfs attribute to set a
> > remote port as marginal. This will allow the fcloop LLDD to set the
> > marginal flag on a remote port, simulating a marginal link.
> >
> > Example:
> > Turn on marginal for a remote port matching wwnn and wwpn:
> > `echo 'wwnn=3D0x200000109b5f2956,wwpn=3D0x100000109b5f2956,marginal=3D1=
' >
> > /sys/class/fcloop/ctl/set_marginal_rport`
> >
> > Turn off marginal for a remote port matching wwnn and wwpn:
> > `echo 'wwnn=3D0x200000109b5f2956,wwpn=3D0x100000109b5f2956,marginal=3D0=
' >
> > /sys/class/fcloop/ctl/set_marginal_rport`
> >
> > Suggested-by: John Meneghini <jmeneghi@redhat.com>
> > Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
> > V10 -> V1:
> >   - New patch
> > V1 -> V2:
> >   - Fix reference count leak in error path
> > ---
> >   drivers/nvme/target/fcloop.c | 50 +++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 50 insertions(+)
> >
> > diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.=
c
> > index b63af3b643a6..9977c2a71bd5 100644
> > --- a/drivers/nvme/target/fcloop.c
> > +++ b/drivers/nvme/target/fcloop.c
> > @@ -6,6 +6,7 @@
> >   #include <linux/module.h>
> >   #include <linux/parser.h>
> >   #include <uapi/scsi/fc/fc_fs.h>
> > +#include <uapi/scsi/fc/fc_els.h>
> >
> >   #include "../host/nvme.h"
> >   #include "../target/nvmet.h"
> > @@ -21,6 +22,7 @@ enum {
> >       NVMF_OPT_FCADDR         =3D 1 << 3,
> >       NVMF_OPT_LPWWNN         =3D 1 << 4,
> >       NVMF_OPT_LPWWPN         =3D 1 << 5,
> > +     NVMF_OPT_MARGINAL       =3D 1 << 6,
> >   };
> >
> >   struct fcloop_ctrl_options {
> > @@ -31,6 +33,7 @@ struct fcloop_ctrl_options {
> >       u32                     fcaddr;
> >       u64                     lpwwnn;
> >       u64                     lpwwpn;
> > +     u32                     marginal;
> >   };
> >
> >   static const match_table_t opt_tokens =3D {
> > @@ -40,6 +43,7 @@ static const match_table_t opt_tokens =3D {
> >       { NVMF_OPT_FCADDR,      "fcaddr=3D%x"     },
> >       { NVMF_OPT_LPWWNN,      "lpwwnn=3D%s"     },
> >       { NVMF_OPT_LPWWPN,      "lpwwpn=3D%s"     },
> > +     { NVMF_OPT_MARGINAL,    "marginal=3D%d"   },
> >       { NVMF_OPT_ERR,         NULL            }
> >   };
> >
> > @@ -120,6 +124,13 @@ fcloop_parse_options(struct fcloop_ctrl_options *o=
pts,
> >                       }
> >                       opts->lpwwpn =3D token64;
> >                       break;
> > +             case NVMF_OPT_MARGINAL:
> > +                     if (match_int(args, &token)) {
> > +                             ret =3D -EINVAL;
> > +                             goto out_free_options;
> > +                     }
> > +                     opts->marginal =3D token;
> > +                     break;
> >               default:
> >                       pr_warn("unknown parameter or missing value '%s'\=
n", p);
> >                       ret =3D -EINVAL;
> > @@ -199,6 +210,9 @@ fcloop_parse_nm_options(struct device *dev, u64 *nn=
ame, u64 *pname,
> >
> >   #define TGTPORT_OPTS        (NVMF_OPT_WWNN | NVMF_OPT_WWPN)
> >
> > +#define MARGINAL_OPTS        (NVMF_OPT_WWNN | NVMF_OPT_WWPN | \
> > +                      NVMF_OPT_MARGINAL)
> > +
> >
> >   static DEFINE_SPINLOCK(fcloop_lock);
> >   static LIST_HEAD(fcloop_lports);
> > @@ -1663,6 +1677,40 @@ fcloop_set_cmd_drop(struct device *dev, struct d=
evice_attribute *attr,
> >       return count;
> >   }
> >
> > +static ssize_t
> > +fcloop_set_marginal_rport(struct device *dev, struct device_attribute =
*attr,
> > +             const char *buf, size_t count)
> > +{
> > +     struct fcloop_nport *nport;
> > +     struct fcloop_ctrl_options opts =3D {};
> > +     unsigned long flags;
> > +     int ret;
> > +
> > +     ret =3D fcloop_parse_options(&opts, buf);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* everything there ? */
> > +     if ((opts.mask & MARGINAL_OPTS) !=3D MARGINAL_OPTS)
> > +             return -EINVAL;
> > +
> > +     nport =3D fcloop_nport_lookup(opts.wwnn, opts.wwpn);
> > +     if (!nport)
> > +             return -ENOENT;
> > +
> > +     spin_lock_irqsave(&fcloop_lock, flags);
> > +     if (!nport->rport || !nport->rport->remoteport) {
> > +             spin_unlock_irqrestore(&fcloop_lock, flags);
> > +             fcloop_nport_put(nport);
> > +             return -ENOENT;
> > +     }
> > +
> > +     nvme_fc_set_remoteport_fpin(nport->rport->remoteport, opts.margin=
al);
> > +     spin_unlock_irqrestore(&fcloop_lock, flags);
> > +     fcloop_nport_put(nport);
> > +
> > +     return count;
> > +}
> >
> >   static DEVICE_ATTR(add_local_port, 0200, NULL, fcloop_create_local_po=
rt);
> >   static DEVICE_ATTR(del_local_port, 0200, NULL, fcloop_delete_local_po=
rt);
> > @@ -1671,6 +1719,7 @@ static DEVICE_ATTR(del_remote_port, 0200, NULL, f=
cloop_delete_remote_port);
> >   static DEVICE_ATTR(add_target_port, 0200, NULL, fcloop_create_target_=
port);
> >   static DEVICE_ATTR(del_target_port, 0200, NULL, fcloop_delete_target_=
port);
> >   static DEVICE_ATTR(set_cmd_drop, 0200, NULL, fcloop_set_cmd_drop);
> > +static DEVICE_ATTR(set_marginal_rport, 0200, NULL, fcloop_set_marginal=
_rport);
> >
> >   static struct attribute *fcloop_dev_attrs[] =3D {
> >       &dev_attr_add_local_port.attr,
> > @@ -1680,6 +1729,7 @@ static struct attribute *fcloop_dev_attrs[] =3D {
> >       &dev_attr_add_target_port.attr,
> >       &dev_attr_del_target_port.attr,
> >       &dev_attr_set_cmd_drop.attr,
> > +     &dev_attr_set_marginal_rport.attr,
> >       NULL
> >   };
> >
> Please don't make it a fabrics option.

What do you mean by fabrics option? How should I fix this?

Thanks,
Jesse Taube

> Setting is via sysfs is
> sufficient seeing it's for testing only.
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


