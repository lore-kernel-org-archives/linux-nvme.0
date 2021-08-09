Return-Path: <SRS0=jKil=NA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA641C4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 11:31:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9610F60F8F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 11:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9610F60F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/Jfek6adJhCv0H60+udkleKKL0iKNAKNROc3fC29M/Q=; b=ZjRISXisdjaGDJ
	c1+y/zQCDyV0hX+qNF3gpi7HtEC+AV6kQJEGJ4ysfrYnvdtLcfWvdf9cEfsYnokFYrwBZ+T/Y6tYj
	xG38huygIA9YSrB45kUDi9MGQl4vFCnEFsvA++uhpS1Ug8uEzeCpggCYKXbYzN1SZ8HP0hGMt2Imb
	6E1wNtyBOv86VhOo9ZxkYtZJDHhR/5bnmRj3ssft0tB6iVud/2SXGa/vBOJRtbckBjTnLcsu0XuQm
	ZzDhWJVAg6xML+lcoai/1k6yF28u/LZHdBYEO7smfckXWHnFYvSiXGR9dDBy9VRnij8oORXlRKbWz
	FbI/tK7RvGM5ghAHdmtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mD3Ui-000NQQ-Oj; Mon, 09 Aug 2021 11:31:00 +0000
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mD3Uf-000NOf-Np
 for linux-nvme@lists.infradead.org; Mon, 09 Aug 2021 11:30:59 +0000
Received: by mail-vs1-xe34.google.com with SMTP id b138so9805905vsd.2
 for <linux-nvme@lists.infradead.org>; Mon, 09 Aug 2021 04:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fOiX5Fq3KXnBSLuawZfkvyDmjzsFYZZ+98EOQpFNGTM=;
 b=Uqs8Zs2QVxW19OPp6ZaYropMD8wq8XzkZj7QkVLqpPM9d4D1VE73zWGn2Wd4wVWWKo
 dCiEE20W3t4lEemNh9QhNYlHhoPpHwiij4/ziwEVih9Dv2II0zRp36htHJQnUV2V3WAN
 O3jpAmIUQ6x2uVTrMnu5r3hD17yyOicUYsFwihDXtVyLWJBVa8NqrtYlkcV1Lf7YLJMn
 9ILGVliAuaAmSDBjeEjxnw2gB0BnYc2oZAxv7NlNmtNgoZDf251iTf/dNeOLBlVK2opR
 GfIiXhpUH1vkvSo3w0n/gNe2zE30sKnNIiqxyZ0E3/cg3vcOLsR06s9dCjztnYA6RJQZ
 CeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fOiX5Fq3KXnBSLuawZfkvyDmjzsFYZZ+98EOQpFNGTM=;
 b=XCwBzUiieapDiFzO5tn/v65nLsRF15L0eCHxpAwFm4JHhqo7IqEkqg7OMe3Cdb6r9R
 EzChA8OiKvYM+2wpuzcmwLBVeRaBR2r4Vmweq3Att8kFDA7Jgw+G7oc8yq8B3RSJqbFf
 vElXF0RYF3u6ppNgsxjrLUmXJ+FLmFcDQ0kNg0K3+XPAk9inguoM91khbj8PnyXgv/0G
 0EMy/YGe9l9jtu6VbKcI+NmCH8Ey5kDg3KnbS36IJNbYkYaC9qeQaqchFG/ZutmaIVSA
 2Y1EGpKRl84ofI/BsYwcDwF86EvV9gxEuZL1V3BD+BvuaqQyIAPWALPs3hgWRMTW2Jon
 j0cw==
X-Gm-Message-State: AOAM531MFQDkL3Sep4vE4TBgaRakqzy5lYrbmiaUZTQ8DH6X0dKQGfhM
 QlL9R5ZUKG0YA9rvLGFwaqxciGEDB+/nX8MMoCCZ3A==
X-Google-Smtp-Source: ABdhPJzFsvgytRJWqLZxvtQilzSUmLu3e4lpYoG45hUphYdCxvnwzfo5c76bu9iRy/GrvrZdQeDel/HkqPDrIvVs0T8=
X-Received: by 2002:a67:7c11:: with SMTP id x17mr15676775vsc.55.1628508654832; 
 Mon, 09 Aug 2021 04:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210809064028.1198327-1-hch@lst.de>
 <20210809064028.1198327-2-hch@lst.de>
In-Reply-To: <20210809064028.1198327-2-hch@lst.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Aug 2021 13:30:18 +0200
Message-ID: <CAPDyKFrpKqadCXZNypdk2rp8n1T1Xk-BO2B0FQ=rzbKyz_k8wg@mail.gmail.com>
Subject: Re: [PATCH 1/8] mmc: block: let device_add_disk create disk attributes
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
 Song Liu <song@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, linux-block <linux-block@vger.kernel.org>,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, 
 linux-mmc <linux-mmc@vger.kernel.org>, linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210809_043057_823781_388FB058 
X-CRM114-Status: GOOD (  29.45  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 9 Aug 2021 at 08:43, Christoph Hellwig <hch@lst.de> wrote:
>
> Pass the attribute group for the attributes on the gendisk to
> device_add_disk so that they are created atomically with the
> disk creation.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Let's try to funnel this via Jens' tree. As long as his tree is based
upon v5.14-rc3 or later I don't think we should have any problem with
conflicts.

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 102 +++++++++++++++++----------------------
>  1 file changed, 45 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ce8aed562929..4ac3e1b93e7e 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -128,8 +128,6 @@ struct mmc_blk_data {
>          * track of the current selected device partition.
>          */
>         unsigned int    part_curr;
> -       struct device_attribute force_ro;
> -       struct device_attribute power_ro_lock;
>         int     area_type;
>
>         /* debugfs files (only in main mmc_blk_data) */
> @@ -281,6 +279,9 @@ static ssize_t power_ro_lock_store(struct device *dev,
>         return count;
>  }
>
> +static DEVICE_ATTR(ro_lock_until_next_power_on, 0,
> +               power_ro_lock_show, power_ro_lock_store);
> +
>  static ssize_t force_ro_show(struct device *dev, struct device_attribute *attr,
>                              char *buf)
>  {
> @@ -313,6 +314,44 @@ static ssize_t force_ro_store(struct device *dev, struct device_attribute *attr,
>         return ret;
>  }
>
> +static DEVICE_ATTR(force_ro, 0644, force_ro_show, force_ro_store);
> +
> +static struct attribute *mmc_disk_attrs[] = {
> +       &dev_attr_force_ro.attr,
> +       &dev_attr_ro_lock_until_next_power_on.attr,
> +       NULL,
> +};
> +
> +static umode_t mmc_disk_attrs_is_visible(struct kobject *kobj,
> +               struct attribute *a, int n)
> +{
> +       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
> +       umode_t mode = a->mode;
> +
> +       if (a == &dev_attr_ro_lock_until_next_power_on.attr &&
> +           (md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
> +           md->queue.card->ext_csd.boot_ro_lockable) {
> +               mode = S_IRUGO;
> +               if (!(md->queue.card->ext_csd.boot_ro_lock &
> +                               EXT_CSD_BOOT_WP_B_PWR_WP_DIS))
> +                       mode |= S_IWUSR;
> +       }
> +
> +       mmc_blk_put(md);
> +       return mode;
> +}
> +
> +static const struct attribute_group mmc_disk_attr_group = {
> +       .is_visible     = mmc_disk_attrs_is_visible,
> +       .attrs          = mmc_disk_attrs,
> +};
> +
> +static const struct attribute_group *mmc_disk_attr_groups[] = {
> +       &mmc_disk_attr_group,
> +       NULL,
> +};
> +
>  static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
>  {
>         struct mmc_blk_data *md = mmc_blk_get(bdev->bd_disk);
> @@ -2644,15 +2683,8 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
>                  * from being accepted.
>                  */
>                 card = md->queue.card;
> -               if (md->disk->flags & GENHD_FL_UP) {
> -                       device_remove_file(disk_to_dev(md->disk), &md->force_ro);
> -                       if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
> -                                       card->ext_csd.boot_ro_lockable)
> -                               device_remove_file(disk_to_dev(md->disk),
> -                                       &md->power_ro_lock);
> -
> +               if (md->disk->flags & GENHD_FL_UP)
>                         del_gendisk(md->disk);
> -               }
>                 mmc_cleanup_queue(&md->queue);
>                 mmc_blk_put(md);
>         }
> @@ -2679,51 +2711,6 @@ static void mmc_blk_remove_parts(struct mmc_card *card,
>         }
>  }
>
> -static int mmc_add_disk(struct mmc_blk_data *md)
> -{
> -       int ret;
> -       struct mmc_card *card = md->queue.card;
> -
> -       device_add_disk(md->parent, md->disk, NULL);
> -       md->force_ro.show = force_ro_show;
> -       md->force_ro.store = force_ro_store;
> -       sysfs_attr_init(&md->force_ro.attr);
> -       md->force_ro.attr.name = "force_ro";
> -       md->force_ro.attr.mode = S_IRUGO | S_IWUSR;
> -       ret = device_create_file(disk_to_dev(md->disk), &md->force_ro);
> -       if (ret)
> -               goto force_ro_fail;
> -
> -       if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
> -            card->ext_csd.boot_ro_lockable) {
> -               umode_t mode;
> -
> -               if (card->ext_csd.boot_ro_lock & EXT_CSD_BOOT_WP_B_PWR_WP_DIS)
> -                       mode = S_IRUGO;
> -               else
> -                       mode = S_IRUGO | S_IWUSR;
> -
> -               md->power_ro_lock.show = power_ro_lock_show;
> -               md->power_ro_lock.store = power_ro_lock_store;
> -               sysfs_attr_init(&md->power_ro_lock.attr);
> -               md->power_ro_lock.attr.mode = mode;
> -               md->power_ro_lock.attr.name =
> -                                       "ro_lock_until_next_power_on";
> -               ret = device_create_file(disk_to_dev(md->disk),
> -                               &md->power_ro_lock);
> -               if (ret)
> -                       goto power_ro_lock_fail;
> -       }
> -       return ret;
> -
> -power_ro_lock_fail:
> -       device_remove_file(disk_to_dev(md->disk), &md->force_ro);
> -force_ro_fail:
> -       del_gendisk(md->disk);
> -
> -       return ret;
> -}
> -
>  #ifdef CONFIG_DEBUG_FS
>
>  static int mmc_dbg_card_status_get(void *data, u64 *val)
> @@ -2919,12 +2906,13 @@ static int mmc_blk_probe(struct mmc_card *card)
>
>         dev_set_drvdata(&card->dev, md);
>
> -       ret = mmc_add_disk(md);
> +       device_add_disk(md->parent, md->disk, mmc_disk_attr_groups);
>         if (ret)
>                 goto out;
>
>         list_for_each_entry(part_md, &md->part, part) {
> -               ret = mmc_add_disk(part_md);
> +               device_add_disk(part_md->parent, part_md->disk,
> +                               mmc_disk_attr_groups);
>                 if (ret)
>                         goto out;
>         }
> --
> 2.30.2
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
