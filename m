Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA32EC4361B
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 14:57:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6221423601
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 14:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6221423601
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=p0/5NcJwaECZjY+SQkLMzt+BUMK8Jwcf8Dj3s9ukeUU=; b=0wuS3Kl1oGUCBLUAfGBY3q+fj
	3zq4Y+1edeagAWQBgacuukamfMdgCWzt+FbnIf3vo5m5WoiCuM+e5XYDnhU5BZS6XSZXwL4bqEN4o
	JgpdbaVHBjac6TtliGw3EB4PAxltTCG6nnGhymenpPJr2F/lWNdoQWPX+dltDq4KAOGcdTq5Vb3qX
	3YZ8vTStuK7XkVYLa5G6Tf0JSiQgEauvWIMEyrcyjpgQ/9fPHSAxZeo0CSG7+IXokUmqN/6K/8Vyy
	DjYOGcA2NtAjXhySei4YxBE4sJkHedGGbJmFklvql4DubF9oFh7EB+k8ohvWnUCb8nCOm9B90TDup
	89wyksssw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmHxG-0005TN-HN; Mon, 07 Dec 2020 14:57:34 +0000
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmHxD-0005Sc-Tv
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 14:57:32 +0000
Received: by mail-il1-x142.google.com with SMTP id x15so12444007ilq.1
 for <linux-nvme@lists.infradead.org>; Mon, 07 Dec 2020 06:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BdzMWmghWMnmqJzPNphPqafzWOiOvEaXvaPDnRpTyig=;
 b=XAbT0sIGBd/lF/JpvMHWnpZhkY6ndEKj+4VNfzBQa+YwFTpXwWhd82chdPi99aEdtR
 TJfRyYD7rqsjkjYOtmVR9fkbdH3SXZii52oM+mc7xsE2GI5CyRu3lDB5DFVOX0Af3saH
 0cjWRLbl/3VTVuxnR1/sgozX4ifKxZUAfq4kodrdjf3JSrfLySW6hU2/h036dSXZpwaB
 18HvdbtEJo5jUs6y+1SKBCyHRXkiQO7CjoMU6QSHtFzOZBSKYKdTczI+DuJa6vgfQbH2
 Brt5cucKMyHJWrLnvsxu8EpYRjASHs0KY0TzYcT1fT3m7V1bjRnp79R2unvmGEr9iWbw
 gVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BdzMWmghWMnmqJzPNphPqafzWOiOvEaXvaPDnRpTyig=;
 b=bq37/dzoYw5g2osBgvMWIOumY9ZfnJdRArpTGKUCnOGF6yYK4jAlI6L/wiZFR4PC2z
 hCk1l3hxp87OIGNoGDTbV/JKI+Y5zznjW5+dehdHzyKir/uE1flLOxTW8w/hbvgXlB6Q
 rEmcdVwxB38s4tu4GfEFVVrWYoJ1VPA2lK/odCm9CNhQPAM0zmFULf4fGZiLDbvmPnri
 e84YWafcPPZpR0GHlNjaQzPTXMGujXF1tlMqJUGoU3RMZ5qSuNIt6QqGkIxlydW4Bpyl
 9dxFBUDzMIgLhFcunDEdrt2DtPDa2sUQ6AB+TCZ7Brb/ncQ7HWMtLpoeR2HwQmsGQehw
 9RLA==
X-Gm-Message-State: AOAM533Uk1eZs76MzfTLs8Y7xrPLUzjHRjWv8ej4qzZ5t+E9Zc7MwHvB
 13WX3e6oPeedsgy1EHn6B2E9JslI3oPUYt0Jvkw=
X-Google-Smtp-Source: ABdhPJzWgUFyUwn4oRQGFwhc7sjEZmk8MIUigwiYjc70guXN2OnSLrKLaIK50f+C57huiWudj+gdKgGdrTXAcHcP4D8=
X-Received: by 2002:a92:4c3:: with SMTP id 186mr21869621ile.177.1607353048343; 
 Mon, 07 Dec 2020 06:57:28 -0800 (PST)
MIME-Version: 1.0
References: <20201207131918.2252553-1-hch@lst.de>
 <20201207131918.2252553-6-hch@lst.de>
In-Reply-To: <20201207131918.2252553-6-hch@lst.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 7 Dec 2020 15:57:21 +0100
Message-ID: <CAOi1vP9q7iGLmDryWJ0Duk2uQODr5W=5RCt2GAAxKk+N_k9OOg@mail.gmail.com>
Subject: Re: [PATCH 5/6] rbd: remove the ->set_read_only method
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_095732_022063_CCA09EF3 
X-CRM114-Status: GOOD (  19.91  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Mike Snitzer <snitzer@redhat.com>, Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ceph Development <ceph-devel@vger.kernel.org>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Dec 7, 2020 at 2:21 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Now that the hardware read-only state can't be changed by the BLKROSET
> ioctl, the code in this method is not required anymore.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/block/rbd.c | 19 -------------------
>  1 file changed, 19 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 2ed79b09439a82..2c64ca15ca079f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -692,29 +692,10 @@ static void rbd_release(struct gendisk *disk, fmode_t mode)
>         put_device(&rbd_dev->dev);
>  }
>
> -static int rbd_set_read_only(struct block_device *bdev, bool ro)
> -{
> -       struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
> -
> -       /*
> -        * Both images mapped read-only and snapshots can't be marked
> -        * read-write.
> -        */
> -       if (!ro) {
> -               if (rbd_is_ro(rbd_dev))
> -                       return -EROFS;
> -
> -               rbd_assert(!rbd_is_snap(rbd_dev));
> -       }
> -
> -       return 0;
> -}
> -
>  static const struct block_device_operations rbd_bd_ops = {
>         .owner                  = THIS_MODULE,
>         .open                   = rbd_open,
>         .release                = rbd_release,
> -       .set_read_only          = rbd_set_read_only,
>  };
>
>  /*
> --
> 2.29.2
>

If nothing can mess with read-only state after set_disk_ro(disk, true),
looks good.

Acked-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
