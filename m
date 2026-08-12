Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC369C5B56A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 18:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d8ydX2OpIcKxMSr0OhxO7ClOo6XDEYK4Z+XCSqRZD7E=; b=yBBhT//Oviv3A8FpBFxwhSo7sp
	LeqWUtafGWnl+yCNHkcQGABRCzSzzX52A4S8KxqqhAYeq2W/CQsOaC10cyHoRCK2jM+JmXZS6P20a
	862Pu5VlF4L2UHuJ1AeUv80N5b3arIhVbJdEDPNHJSa8+xIDtwRFw4zDh8BqxWgBREETbDAel2gTA
	gaq2yHSjq31BAazeWbS0FaUwTbrWGvL5cAAM1y28IxIvwFL03wfI0iAHWuslk+6WTLYzEQd69tB2p
	1sWdOruKPxgk+/tWWnxJOMXADJcw95pShFoeS3lPW3eXy1wLncJfn02LW8UTaMYqdm2k+3BtnONyL
	+TZ1hY4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuDma-0000000Go2H-0VHO;
	Wed, 12 Aug 2026 18:34:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuDmX-0000000Go1g-1nZ1
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 18:34:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786559668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8ydX2OpIcKxMSr0OhxO7ClOo6XDEYK4Z+XCSqRZD7E=;
	b=EBGCgMtcoJqwa1gBP99FYYGaL9zEaA12TX/eA4z+gJkgdQBdZvzip8yFnTnGYCmof0qOdl
	3xYgDNIrc+QG0w1XdipGctjEn2etHU6NcAwzBRossqSkhc+K7zE3cO32+OAzlMHLIynPV7
	DtKDEL3Q6zxVMfaG1eaQFB3pLg+zVuQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-FqCJ00diOv6De1sg1AxMmQ-1; Wed, 12 Aug 2026 14:34:21 -0400
X-MC-Unique: FqCJ00diOv6De1sg1AxMmQ-1
X-Mimecast-MFC-AGG-ID: FqCJ00diOv6De1sg1AxMmQ_1786559661
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47162f83c75so77799f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 12 Aug 2026 11:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786559660; x=1787164460;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d8ydX2OpIcKxMSr0OhxO7ClOo6XDEYK4Z+XCSqRZD7E=;
        b=PA5u+ynx8N8zLkw7P1fV4z//th4qQES8PZo0KUUmybdL9WQciPBRV/CS5Vdbi6bdR8
         nWZzRFd5HklTYtHJ45MnyEMVwvMmv2w1sz8QuojoLeH4+6PBUnqBe3Axjsq0iIpX7KL+
         Lcf5z7w90WMPOcG/YuyBOo9hCXjCUqOqGAeyxvgkhE/RpM4z+kYjqHsVxpxQF0U68Tjr
         Fzc50kg+23hxOVUfGSwsOUGTHumM/RyYvFmAjeRpj7XkmLA9mY2dRbMQfDHDHNW5oLHf
         xb3JM0jU+jMr7PbfCCqgHM2bz5XKnIuYGHltFojAHQgdiFaLyLP/SuRRlKdFaowd9g20
         6/kA==
X-Forwarded-Encrypted: i=1; AHgh+RpTZoyDMZaB+HVaXtoZ2+NVnr/9Ett5UmnHzg6Y5rue7j297XEGgHbL2dKoALtCDqthpoMrWzRkc7dk@lists.infradead.org
X-Gm-Message-State: AOJu0Yy5VwfeFpfGPx2I+ECgSbzNJi82SA6CPQCPjx69rB9QkE76ttui
	h0+uvau0kUfyoTbq54zCf0PezjZlq7Orm0PMIjMHE2VTB5zFFLGW6t2RJMqZBttgaoOGVs6BBZ+
	n1CRUCxqkzlEZdIOQM3XEHueOPlivc/tWhrDO+DVxtUVTqG3ZXidiOAC1khzaPuFVCVNpqYCard
	W7vILnaA8Colvj4X/Smt8MlIquaRa062TwXr5Ywlk6ACw=
X-Gm-Gg: AR+sD12NPcfECmUiNJ+9ZjD4GVvC7tkLLkjeyeHfFvbPp2qJ64nFSyedeZA5IZ9e4Xd
	2WB3vyifhmyNmslfps7DoqJ/cGfMadoZSNtgtXW7uv2y/BvP0f4xsNvkK3UD0i+BFtr0kmdcqSI
	foYIycBAtjLYl4JwfObUvHq98EUBJZed2d1FC3qN4tyaBBVf6qVk7NQedIrVuSsNtviN1umFKZ/
	PSIE7d7rqJqG4Wuhg==
X-Received: by 2002:a05:6000:290a:b0:46b:70db:2113 with SMTP id ffacd0b85a97d-48158ad6652mr2148862f8f.0.1786559660625;
        Wed, 12 Aug 2026 11:34:20 -0700 (PDT)
X-Received: by 2002:a05:6000:290a:b0:46b:70db:2113 with SMTP id
 ffacd0b85a97d-48158ad6652mr2148799f8f.0.1786559660257; Wed, 12 Aug 2026
 11:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260812181300.3712426-1-jtaubepe@redhat.com> <20260812181300.3712426-13-jtaubepe@redhat.com>
In-Reply-To: <20260812181300.3712426-13-jtaubepe@redhat.com>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Wed, 12 Aug 2026 14:34:08 -0400
X-Gm-Features: AUfX_myZY21EEprqaxNYcSxFP1Y9sT2Pt-FYKifeAT1wL4eNerhDK3vKjui8tng
Message-ID: <CADRr4bf4orxm9=jCAj7EYXKVK7Nm3bgGCfjaDLztRiR2pXnJFw@mail.gmail.com>
Subject: Re: [PATCH 12/13] nvme: fcloop: Add set_rport_marginal to sysfs
To: linux-scsi@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
	Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Nilesh Javali <njavali@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, Hannes Reinecke <hare@suse.de>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, John Meneghini <jmeneghi@redhat.com>, 
	Bryan Gurney <bgurney@redhat.com>, Chris Leech <cleech@redhat.com>, 
	"Ewan D . Milne" <emilne@redhat.com>, shinichiro.kawasaki@wdc.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wOPrqfDdplg1wMNX5iLxMuOXZrrA8mAMFB3JeLVXCYI_1786559661
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_113429_544677_4B3D8048 
X-CRM114-Status: GOOD (  25.86  )
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

On Wed, Aug 12, 2026 at 2:14=E2=80=AFPM Jesse Taube <jtaubepe@redhat.com> w=
rote:
>
> To allow testing of multipath failover, add a sysfs attribute to set a
> remote port as marginal. This will allow the fcloop LLDD to set the
> marginal flag on a remote port, simulating a marginal link.
>
> Example:
> Turn on marginal for a remote port matching wwnn and wwpn:
> `echo 'wwnn=3D0x200000109b5f2956,wwpn=3D0x100000109b5f2956,marginal=3D1' =
>
> /sys/class/fcloop/ctl/set_rport_marginal`
>
> Turn off marginal for a remote port matching wwnn and wwpn:
> `echo 'wwnn=3D0x200000109b5f2956,wwpn=3D0x100000109b5f2956,marginal=3D0' =
>
> /sys/class/fcloop/ctl/set_rport_marginal`
>
> Suggested-by: John Meneghini <jmeneghi@redhat.com>
> Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
> V10 -> V11
>  - New patch
> ---
>  drivers/nvme/target/fcloop.c | 41 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index b63af3b643a6..51a50743128d 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -6,6 +6,7 @@
>  #include <linux/module.h>
>  #include <linux/parser.h>
>  #include <uapi/scsi/fc/fc_fs.h>
> +#include <uapi/scsi/fc/fc_els.h>
>
>  #include "../host/nvme.h"
>  #include "../target/nvmet.h"
> @@ -21,6 +22,7 @@ enum {
>         NVMF_OPT_FCADDR         =3D 1 << 3,
>         NVMF_OPT_LPWWNN         =3D 1 << 4,
>         NVMF_OPT_LPWWPN         =3D 1 << 5,
> +       NVMF_OPT_MARGINAL       =3D 1 << 6,
>  };
>
>  struct fcloop_ctrl_options {
> @@ -31,6 +33,7 @@ struct fcloop_ctrl_options {
>         u32                     fcaddr;
>         u64                     lpwwnn;
>         u64                     lpwwpn;
> +       u32                     marginal;
>  };
>
>  static const match_table_t opt_tokens =3D {
> @@ -40,6 +43,7 @@ static const match_table_t opt_tokens =3D {
>         { NVMF_OPT_FCADDR,      "fcaddr=3D%x"     },
>         { NVMF_OPT_LPWWNN,      "lpwwnn=3D%s"     },
>         { NVMF_OPT_LPWWPN,      "lpwwpn=3D%s"     },
> +       { NVMF_OPT_MARGINAL,    "marginal=3D%d"   },
>         { NVMF_OPT_ERR,         NULL            }
>  };
>
> @@ -120,6 +124,13 @@ fcloop_parse_options(struct fcloop_ctrl_options *opt=
s,
>                         }
>                         opts->lpwwpn =3D token64;
>                         break;
> +               case NVMF_OPT_MARGINAL:
> +                       if (match_int(args, &token)) {
> +                               ret =3D -EINVAL;
> +                               goto out_free_options;
> +                       }
> +                       opts->marginal =3D token;
> +                       break;
>                 default:
>                         pr_warn("unknown parameter or missing value '%s'\=
n", p);
>                         ret =3D -EINVAL;
> @@ -199,6 +210,9 @@ fcloop_parse_nm_options(struct device *dev, u64 *nnam=
e, u64 *pname,
>
>  #define TGTPORT_OPTS   (NVMF_OPT_WWNN | NVMF_OPT_WWPN)
>
> +#define MARGINAL_OPTS  (NVMF_OPT_WWNN | NVMF_OPT_WWPN | \
> +                        NVMF_OPT_MARGINAL)
> +
>
>  static DEFINE_SPINLOCK(fcloop_lock);
>  static LIST_HEAD(fcloop_lports);
> @@ -1663,6 +1677,31 @@ fcloop_set_cmd_drop(struct device *dev, struct dev=
ice_attribute *attr,
>         return count;
>  }
>
> +static ssize_t
> +fcloop_set_marginal_rport(struct device *dev, struct device_attribute *a=
ttr,
> +               const char *buf, size_t count)
> +{
> +       struct fcloop_nport *nport;
> +       struct fcloop_ctrl_options opts;
> +       int ret;
> +
> +       ret =3D fcloop_parse_options(&opts, buf);
> +       if (ret)
> +               return ret;
> +
> +       /* everything there ? */
> +       if ((opts.mask & MARGINAL_OPTS) !=3D MARGINAL_OPTS)
> +               return -EINVAL;
> +
> +       nport =3D fcloop_nport_lookup(opts.wwnn, opts.wwpn);
> +       if (!nport || !nport->tport || !nport->tport->remoteport)
> +               return -ENOENT;
> +
> +       nvme_fc_set_remoteport_fpin(nport->tport->remoteport, opts.margin=
al);
> +       fcloop_nport_put(nport);
> +
> +       return count;
> +}
>
>  static DEVICE_ATTR(add_local_port, 0200, NULL, fcloop_create_local_port)=
;
>  static DEVICE_ATTR(del_local_port, 0200, NULL, fcloop_delete_local_port)=
;
> @@ -1671,6 +1710,7 @@ static DEVICE_ATTR(del_remote_port, 0200, NULL, fcl=
oop_delete_remote_port);
>  static DEVICE_ATTR(add_target_port, 0200, NULL, fcloop_create_target_por=
t);
>  static DEVICE_ATTR(del_target_port, 0200, NULL, fcloop_delete_target_por=
t);
>  static DEVICE_ATTR(set_cmd_drop, 0200, NULL, fcloop_set_cmd_drop);
> +static DEVICE_ATTR(set_marginal_rport, 0200, NULL, fcloop_set_marginal_r=
port);

Checkpatch is complaining about:
Consider renaming function(s) 'fcloop_set_marginal_rport' to
'set_marginal_rport_store'
I dont think deviating from the existing naming scheme to appease
checkpatch is a good idea though.

Thanks,
Jesse Taube

>
>  static struct attribute *fcloop_dev_attrs[] =3D {
>         &dev_attr_add_local_port.attr,
> @@ -1680,6 +1720,7 @@ static struct attribute *fcloop_dev_attrs[] =3D {
>         &dev_attr_add_target_port.attr,
>         &dev_attr_del_target_port.attr,
>         &dev_attr_set_cmd_drop.attr,
> +       &dev_attr_set_marginal_rport.attr,
>         NULL
>  };
>
> --
> 2.54.0
>


