Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D22C77B7A
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 09:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h7De2dV56C4HlWldqRhiqrthNBSi3YmqE+PsGIwemH4=; b=gDBwCLYZ0UawNjsJNJx8B8lVrp
	1HeoAS6jVRoFqo9ota3x97f86Vr1xgrGaYYfYOaJOjnM9DOUYL4jGkLTfLNaU2DZcPZGN5CMyuDiZ
	2e6Kzu1KWUfi5ExARHk7usB7IIyszmFZRDJQlpS9B/kYcJeiVepAt663V5HcuzB8YL+87MzdWaUc5
	emeY/qSNV36wTKyUzaNDaRe9du0WqY6ncynE7sjxTxic6UMryn8eeAt0NrjpG+Wx92KRH7PMepcpE
	Y7IgUyx636usqBaRn5Mu6hcqJuxIsteZKHQwwspbzvSh5+pgt+/AD1xn35q74n8yv6Lv6n+rIOuDW
	dMjTLOiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6phi-005JGG-27;
	Wed, 07 Jun 2023 09:43:46 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6phe-005JCY-1o
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jun 2023 09:43:44 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-514953b3aa6so938697a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 07 Jun 2023 02:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1686131019; x=1688723019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7De2dV56C4HlWldqRhiqrthNBSi3YmqE+PsGIwemH4=;
        b=Fxs73X18plukFoRmWCEATURAToiPof++AhV2rd1/T2MKXGmjDCPWn+q8ZXibWIJoCl
         fHfu9DBj0R01NVvwasXQiY0lKT1FhoYR2X+c5jE2FnzXFR9NQ6iXute09sA4dYi5/gck
         psOWHas6uKWqFB5zNcQ7IrWLWew12mqmJwAS2YNr2ADMxS+LziF4JcFGcR/G6Q7NeZ7C
         gnc9umHxHhpwxSNb/FTgvTAZTX6T0jxAAcpIFEs4lHfCZdM6nb4VJD4c8dc11CL9vYmB
         PP/GUtutiKFcuL2dMJlAWegEn3D5UBxmkW546B+kzx0X64ETqnOp9+wz6iaKHcNDX6z+
         mItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686131019; x=1688723019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7De2dV56C4HlWldqRhiqrthNBSi3YmqE+PsGIwemH4=;
        b=X9YzHN/vQ8VAQfF8tJiqnQvChPwImsOEmIONwkm153unpY7hL0FVq576KgkVjh/PUR
         Zj4Q6pYDnF9dIxULtHwyI1U7FU1RbKMmr8BSlPPVg7TH3h8PN+2bQRKbQF9YOilEvLaO
         bhPE/sH139hT7xvJQ/75jXbTkDBCKb7HXfPXNE4sgayequuMUNwYnCqfSTQHyCvNApFH
         NtF3eM/5iB+xW2+9Bc8d/HyMSLGeh1b+NDlDaPhGNm+CAXSRzSX3AE71uMZ/71l0ocQ4
         a61DFALlcqHtgeaX7N1n2oacP/+jXC5V+wc7p4nan5EwvB737ol8qbwgxnC0yIFtFhcq
         q3EQ==
X-Gm-Message-State: AC+VfDwPJWDh+sSnYJ5oc5dcLqaTGfOMfKAUOzAXt3N1vBMK53g8cxGD
	3UVHXl9iSuFRvB7yrmq8UmTRW963DqwLrOYHEGu9jIBT99sVU61rAPZ+Fg==
X-Google-Smtp-Source: ACHHUZ5Zsd3dLhUTQg2QCup0RdocqPkCkN0n7M2rugZo5XtKl4/VHXYLtkyrTBeTzA0h2H5Q3Eo78GSAj7z6EomEI0Y=
X-Received: by 2002:aa7:c6c8:0:b0:514:7f39:aa82 with SMTP id
 b8-20020aa7c6c8000000b005147f39aa82mr3567915eds.27.1686131019731; Wed, 07 Jun
 2023 02:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-25-hch@lst.de>
In-Reply-To: <20230606073950.225178-25-hch@lst.de>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 7 Jun 2023 11:43:28 +0200
Message-ID: <CAMGffEnM-XmQWjBu8EmXxFPouH9uQX45gL2PFW5vQJu5OaaYjA@mail.gmail.com>
Subject: Re: [PATCH 24/31] rnbd-srv: replace sess->open_flags with a "bool readonly"
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>, Josef Bacik <josef@toxicpanda.com>, 
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>, Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com, 
	linux-block@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org, 
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_024342_604613_466AEDB8 
X-CRM114-Status: GOOD (  22.56  )
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

On Tue, Jun 6, 2023 at 9:41=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Stop passing the fmode_t around and just use a simple bool to track if
> an export is read-only.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv-sysfs.c |  3 +--
>  drivers/block/rnbd/rnbd-srv.c       | 15 +++++++--------
>  drivers/block/rnbd/rnbd-srv.h       |  2 +-
>  3 files changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnb=
d-srv-sysfs.c
> index d5d9267e1fa5e4..ebd95771c85ec7 100644
> --- a/drivers/block/rnbd/rnbd-srv-sysfs.c
> +++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
> @@ -88,8 +88,7 @@ static ssize_t read_only_show(struct kobject *kobj, str=
uct kobj_attribute *attr,
>
>         sess_dev =3D container_of(kobj, struct rnbd_srv_sess_dev, kobj);
>
> -       return sysfs_emit(page, "%d\n",
> -                         !(sess_dev->open_flags & FMODE_WRITE));
> +       return sysfs_emit(page, "%d\n", sess_dev->readonly);
>  }
>
>  static struct kobj_attribute rnbd_srv_dev_session_ro_attr =3D
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.=
c
> index 29d560472d05ba..b680071342b898 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -222,7 +222,7 @@ void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *=
sess_dev, bool keep_id)
>         blkdev_put(sess_dev->bdev, NULL);
>         mutex_lock(&sess_dev->dev->lock);
>         list_del(&sess_dev->dev_list);
> -       if (sess_dev->open_flags & FMODE_WRITE)
> +       if (!sess_dev->readonly)
>                 sess_dev->dev->open_write_cnt--;
>         mutex_unlock(&sess_dev->dev->lock);
>
> @@ -561,7 +561,7 @@ static void rnbd_srv_fill_msg_open_rsp(struct rnbd_ms=
g_open_rsp *rsp,
>  static struct rnbd_srv_sess_dev *
>  rnbd_srv_create_set_sess_dev(struct rnbd_srv_session *srv_sess,
>                               const struct rnbd_msg_open *open_msg,
> -                             struct block_device *bdev, fmode_t open_fla=
gs,
> +                             struct block_device *bdev, bool readonly,
>                               struct rnbd_srv_dev *srv_dev)
>  {
>         struct rnbd_srv_sess_dev *sdev =3D rnbd_sess_dev_alloc(srv_sess);
> @@ -576,7 +576,7 @@ rnbd_srv_create_set_sess_dev(struct rnbd_srv_session =
*srv_sess,
>         sdev->bdev              =3D bdev;
>         sdev->sess              =3D srv_sess;
>         sdev->dev               =3D srv_dev;
> -       sdev->open_flags        =3D open_flags;
> +       sdev->readonly          =3D readonly;
>         sdev->access_mode       =3D open_msg->access_mode;
>
>         return sdev;
> @@ -681,13 +681,12 @@ static int process_msg_open(struct rnbd_srv_session=
 *srv_sess,
>         struct rnbd_srv_sess_dev *srv_sess_dev;
>         const struct rnbd_msg_open *open_msg =3D msg;
>         struct block_device *bdev;
> -       fmode_t open_flags;
> +       fmode_t open_flags =3D FMODE_READ;
>         char *full_path;
>         struct rnbd_msg_open_rsp *rsp =3D data;
>
>         trace_process_msg_open(srv_sess, open_msg);
>
> -       open_flags =3D FMODE_READ;
>         if (open_msg->access_mode !=3D RNBD_ACCESS_RO)
>                 open_flags |=3D FMODE_WRITE;
>
> @@ -736,9 +735,9 @@ static int process_msg_open(struct rnbd_srv_session *=
srv_sess,
>                 goto blkdev_put;
>         }
>
> -       srv_sess_dev =3D rnbd_srv_create_set_sess_dev(srv_sess, open_msg,
> -                                                    bdev, open_flags,
> -                                                    srv_dev);
> +       srv_sess_dev =3D rnbd_srv_create_set_sess_dev(srv_sess, open_msg,=
 bdev,
> +                               open_msg->access_mode =3D=3D RNBD_ACCESS_=
RO,
> +                               srv_dev);
>         if (IS_ERR(srv_sess_dev)) {
>                 pr_err("Opening device '%s' on session %s failed, creatin=
g sess_dev failed, err: %ld\n",
>                        full_path, srv_sess->sessname, PTR_ERR(srv_sess_de=
v));
> diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.=
h
> index f5962fd31d62e4..76077a9db3dd55 100644
> --- a/drivers/block/rnbd/rnbd-srv.h
> +++ b/drivers/block/rnbd/rnbd-srv.h
> @@ -52,7 +52,7 @@ struct rnbd_srv_sess_dev {
>         struct kobject                  kobj;
>         u32                             device_id;
>         bool                            keep_id;
> -       fmode_t                         open_flags;
> +       bool                            readonly;
>         struct kref                     kref;
>         struct completion               *destroy_comp;
>         char                            pathname[NAME_MAX];
> --
> 2.39.2
>

