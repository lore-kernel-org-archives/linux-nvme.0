Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8704C04E69
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 14:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t7W0c0lPm/+AXFw1hghT8af4Ha098Ln/xEqAt+UBUVk=; b=rPXIFc7vv5AhetNxd5ONdMgqYl
	qvIuFvS5pvjd3c6azNC1xV/zOZh82cnZ8zsGl09YTKP1yrIWAcetA24y8U9LTvNLa/SBJg8ndQmCc
	OA+7GjWOEM4G+n0tiChjJuMqOCtpKxtNnt8idj9+9sOBCgDh+2OaTuS3bg4GcXTNGhVD7v8WWLF+q
	ctBC2Ua20LxvcSowCgZf+zeXc/Ub3YHb3jMcD8ac0sj1rtaOjfsf6Zu94Bd82zDie+Mqf69l6rdGV
	1rr/Xvnt5kQ/7eFmEfeD/DuI9rpCqQwulENBj6D25i6Nb16qqe1aWuQDnbRF/PAm/wJJxUn5vlnCQ
	SmSuHq5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU6oA-007t61-1A;
	Thu, 10 Aug 2023 14:38:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU6o7-007t4w-2G
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 14:38:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691678314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7W0c0lPm/+AXFw1hghT8af4Ha098Ln/xEqAt+UBUVk=;
	b=aYmcl+pfOXFo4+bXZyncD5yqXSShV9TZDPg5kQEmCXswuAgPTA2sCHaGyRYCdZIIiwkVwU
	5HLpidbrehfNnl5dNR7J0SKzGe8s1eoPsb8tXMSesTkdGIDVVBt2uFXcaxhm5zxGe4SLmI
	6aRnXYk9uE8/za5pZ2V4fdj65sqGPzo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-Njrx65N-MRStMdaj0YhgbQ-1; Thu, 10 Aug 2023 10:38:33 -0400
X-MC-Unique: Njrx65N-MRStMdaj0YhgbQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-564e1843717so1274388a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 10 Aug 2023 07:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691678312; x=1692283112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7W0c0lPm/+AXFw1hghT8af4Ha098Ln/xEqAt+UBUVk=;
        b=gxWe8A/VOo4u8I6rOZ8mB6N27v/ZmZzv/xqeS4FLYVtSo3L2mOHm0Rsk0ql++/MKmZ
         wbN3JmoQ32VnxMo/ce4RhgsPHmOyYmp9hMz+4UoWXCvDO0GfAkdSCMpvAMf94ttmAb0f
         A+lox/xnw5d79S04suCsHEOyMxK3PG7jpkmoVCC0H/5la+02RPQCKJihwk0GuxdmPbDs
         uNghwU2wQVniMnPriy9fWYccdHIj/ZvpQ7fzfB7LAd3fmaSv2G3x/XNZ2V9jdkfgv1cr
         O+AKAZVayMyj9WetZY/MTiGstqG32/emfNnC+pMkbnyV52cJB22JFygLYjM+OWBBzH39
         d9HQ==
X-Gm-Message-State: AOJu0Yw3kbhyJAFNpl/nkCbmzDyPpMNP0BehGBkYMxZPVGlLIRrylH5w
	pfyNIGM3By5qJ/mks3TBUVf1C7ZqbsDlHKLbp5E5OEX7BupNud4mKjeZAJhFWkghW1uKBj1cd2x
	PdphBLF2QGG1nklJxPAHohNhlBEwfNld4siiWB9SI8ME=
X-Received: by 2002:a17:90a:fe5:b0:269:2356:19fb with SMTP id 92-20020a17090a0fe500b00269235619fbmr1973769pjz.15.1691678312103;
        Thu, 10 Aug 2023 07:38:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEknc/uFiNFwgJkb8GLMBu5GIVbyWK9XpeUzVzAXC+QoqHBqvXCKKZs9+YcOrzvD0+gtpjE8Tftb4E87x/Y05A=
X-Received: by 2002:a17:90a:fe5:b0:269:2356:19fb with SMTP id
 92-20020a17090a0fe500b00269235619fbmr1973753pjz.15.1691678311836; Thu, 10 Aug
 2023 07:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com>
 <CAHj4cs9J7w_QSWMrj0ncufKwT9viS-o7pxmS2Y4FeaWEyPD34Q@mail.gmail.com>
 <vxeo2ucxhvdcm2z673keqerkpxay6dgfluuvxawukkbunddzm2@jdkdk7y3a5nu>
 <xrqutkdhz7v6axohfxipv4or7k4jhoa57semwcxde7gletk76z@5kcashfdezhk>
 <adgkdt52d6qvcbxq4aof7ggun3t77znndpvzq5k7aww3jrx2tk@6ispx7zimxhy>
 <o2443ezmpny7dyvhiteajzgt3j7wcxo2fv7dik3h7hkjpc2h74@xeetbva55fx2>
 <CAHj4cs8TBsEct9P6iiYwsiRhgCkPbdVL0-8KkXuKZbYhVsQV0Q@mail.gmail.com> <git5brh4yq7ij65oskwd7m4pwnhfcqbvwdn7pzsbrmzv3wgsk4@xvb43h5dbo4g>
In-Reply-To: <git5brh4yq7ij65oskwd7m4pwnhfcqbvwdn7pzsbrmzv3wgsk4@xvb43h5dbo4g>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 10 Aug 2023 22:38:18 +0800
Message-ID: <CAHj4cs-RqFEWFxdCGfZA7+qHLA+JJYs6qynCvKqTDdfW+V66ug@mail.gmail.com>
Subject: Re: [bug report] blktests nvme/047 failed due to /dev/nvme0n1 not
 created in time
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Daniel Wagner <dwagner@suse.de>, linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_073835_813506_C608F779 
X-CRM114-Status: GOOD (  22.50  )
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

On Thu, Aug 10, 2023 at 8:51=E2=80=AFPM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Aug 10, 2023 / 18:21, Yi Zhang wrote:
> > Hi Daniel/Shinichiro
> > Thanks for looking into this issue, I checked the 047 code, and we are
> > missing _find_nvme_dev after the second connect, and the below change
> > could fix this issue now.
> >
> > diff --git a/tests/nvme/047 b/tests/nvme/047
> > index 6a7599b..8c0a024 100755
> > --- a/tests/nvme/047
> > +++ b/tests/nvme/047
> > @@ -52,6 +52,8 @@ test() {
> >                 --nr-write-queues 1 \
> >                 --nr-poll-queues 1 || echo FAIL
> >
> > +       nvmedev=3D$(_find_nvme_dev "${subsys_name}")
> > +
> >         _run_fio_rand_io --filename=3D"/dev/${nvmedev}n1" --size=3D"${r=
and_io_size}"
> >
> >         _nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
> >
> >
>
> Ah, I overlooked that the test case calls _nvme_connect_subsys twice. Goo=
d to
> know that the above changes avoid the failure.
>
> Having said that, the fix above does not look the best. As discussed in a=
nother
> e-mail, _find_nvme_dev() just does 1 second wait, and it actually does no=
t check
> readiness of the device. This needs fix. Also I think the check and wait =
should
> move from _find_nvme_dev()to _nvme_connect_subsys(). Could you try the pa=
tch

Yeah, move to _nvme_connect_subsys looks more reasonable.

> below and see if it avoid the failure?

This change works well :)

>
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 4f3a994..d09e7b4 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -425,6 +425,7 @@ _nvme_connect_subsys() {
>         local keep_alive_tmo=3D""
>         local reconnect_delay=3D""
>         local ctrl_loss_tmo=3D""
> +       local dev i
>
>         while [[ $# -gt 0 ]]; do
>                 case $1 in
> @@ -529,6 +530,16 @@ _nvme_connect_subsys() {
>         fi
>
>         nvme connect "${ARGS[@]}" 2> /dev/null
> +
> +       dev=3D$(_find_nvme_dev "$subsysnqn")
> +       for ((i =3D 0; i < 10; i++)); do
> +               if [[ -b /dev/${dev}n1 &&
> +                             -e /sys/block/${dev}n1/uuid &&
> +                             -e /sys/block/${dev}n1/wwid ]]; then
> +                       return
> +               fi
> +               sleep .1
> +       done
>  }
>
>  _nvme_discover() {
> @@ -739,13 +750,6 @@ _find_nvme_dev() {
>                 subsysnqn=3D"$(cat "/sys/class/nvme/${dev}/subsysnqn")"
>                 if [[ "$subsysnqn" =3D=3D "$subsys" ]]; then
>                         echo "$dev"
> -                       for ((i =3D 0; i < 10; i++)); do
> -                               if [[ -e /sys/block/$dev/uuid &&
> -                                       -e /sys/block/$dev/wwid ]]; then
> -                                       return
> -                               fi
> -                               sleep .1
> -                       done
>                 fi
>         done
>  }
>


--=20
Best Regards,
  Yi Zhang


