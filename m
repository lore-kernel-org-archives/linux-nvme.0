Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2509C77B7A
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Jun 2023 06:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f2Xux0G0tFdJlDzvQzZhcAqUXfykTqTn9g16hyE21ys=; b=Q92WrnDKnpNEwNyXfwONWTPLHN
	2w7begfR/s+bLoaVtr2cotmtcX1uBxuGitRo9GXK4QXUksIgxC4c38pd3mXa2xXBJyBBb0feRoLlD
	L6ldr1+ijs6GzxTN5PCKj0TKfRMG7tdAaJADzItTXT+Rnm90F5+TMTa2RUrkSWMS83mEm0cNb3Xpg
	HciaGq2VNuDjCwE0viB6ZB2I9h/6ojF+S4lGGFjbOuCMFjneC4P4xt+eQHo8qxOgsFVSGSFMyB9Aw
	kN1TyglGAfrzX1AqGkxfKyNnUvmzG/F0VvPYhVT5rx59iOiSe1cKJ4SSARodfabEFKKG5gVQXHima
	oO8JSWPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7s3u-00FNGJ-0Y;
	Sat, 10 Jun 2023 06:26:58 +0000
Received: from mail-ej1-f42.google.com ([209.85.218.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7gcH-00Doq2-1w;
	Fri, 09 Jun 2023 18:13:42 +0000
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-977d3292be0so55136766b.1;
        Fri, 09 Jun 2023 11:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686334418; x=1688926418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2Xux0G0tFdJlDzvQzZhcAqUXfykTqTn9g16hyE21ys=;
        b=NV0CkBw4nmWEwuzFqyTgE8pMc6ohHI50RCmpRM7cASpGjLsaMap4qtpeBttp1CVMP+
         PJFTAiyy8tV4MwYEzq+Orpp94bz2dMrP+MmnKY/csTMgkNejNE9ZnmRznMciU+zpTpY7
         bPNZ4p10ZIvf05uPIgpS7ARcYLwDCRBj2AE2gzzKhiUhbrxsm5k3NP0SXxsYL0L0ic+9
         qSS1rvcmw8QV2cbSke37bmYxXv3vrqmtNhPsuyaRe+gxFjSrIAfMUMxYXmQABefirrQ0
         DcrVWwgNHQoQOdjOctypsGLJaXZYaVCvxKQphTg/PiNdgpVozz5ef+bNROFS7fxGpkfM
         lrqA==
X-Gm-Message-State: AC+VfDwyB5usC5qH7bD+Bg83h8xcx19AJwg1E8AHA3aF3OetGzbIvEmk
	PUW9tbWP8z+4Hdle+WDZFHCZVWeBupQ8Z1XnIUo=
X-Google-Smtp-Source: ACHHUZ7r7lbBrTdxRkyp2bTqJCFBDA6+Ddf+RviatN0r97z5LUsaxAu6Q2CxPlvVkZ/6P5sUxBvleBvx6ETeZa4XK48=
X-Received: by 2002:a17:906:1049:b0:974:56cb:9dfc with SMTP id
 j9-20020a170906104900b0097456cb9dfcmr1993996ejj.1.1686334417837; Fri, 09 Jun
 2023 11:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230608110258.189493-1-hch@lst.de> <20230608110258.189493-12-hch@lst.de>
In-Reply-To: <20230608110258.189493-12-hch@lst.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Jun 2023 20:13:23 +0200
Message-ID: <CAJZ5v0h61q6=JxjeUjjMz5k05HuRGWVKp_rK+9N8rug58kU_VQ@mail.gmail.com>
Subject: Re: [PATCH 11/30] swsusp: don't pass a stack address to blkdev_get_by_path
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>, Josef Bacik <josef@toxicpanda.com>, 
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, 
	Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com, 
	linux-block@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org, 
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_111341_642144_B64FA3DF 
X-CRM114-Status: GOOD (  17.44  )
X-Mailman-Approved-At: Fri, 09 Jun 2023 23:26:53 -0700
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

On Thu, Jun 8, 2023 at 1:03=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> holder is just an on-stack pointer that can easily be reused by other cal=
ls,
> replace it with a static variable that doesn't change.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  kernel/power/swap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 81aec3b2c60510..b03ff1a33c7f68 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -1510,6 +1510,8 @@ int swsusp_read(unsigned int *flags_p)
>         return error;
>  }
>
> +static void *swsusp_holder;
> +
>  /**
>   *      swsusp_check - Check for swsusp signature in the resume device
>   */
> @@ -1517,14 +1519,13 @@ int swsusp_read(unsigned int *flags_p)
>  int swsusp_check(bool snapshot_test)
>  {
>         int error;
> -       void *holder;
>         fmode_t mode =3D FMODE_READ;
>
>         if (snapshot_test)
>                 mode |=3D FMODE_EXCL;
>
>         hib_resume_bdev =3D blkdev_get_by_dev(swsusp_resume_device,
> -                                           mode, &holder, NULL);
> +                                           mode, &swsusp_holder, NULL);
>         if (!IS_ERR(hib_resume_bdev)) {
>                 set_blocksize(hib_resume_bdev, PAGE_SIZE);
>                 clear_page(swsusp_header);
> --
> 2.39.2
>

