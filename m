Return-Path: <SRS0=jKil=NA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD5FC4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 11:31:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC166054F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 11:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1AC166054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bMP9cvFkxENjvl1sm0BNDqR6FyLWlxwD6RhGH8IM0j4=; b=GhHD5wTlzmJ0Gb
	LGPSOMaxtB64PRjVodlZyd3BLkhVsZL7ycfLUrw/agZzJTv5w090u3uahjNuUjEIZeuGkvHOIK2Wc
	c2KqbhbMBIaLA9a7N6NpgfdLOzVIr3HJX7vUI6A9RK/SDotl6jlZc+jJfNwPr8hpCPqxZwiqkrmMG
	dB3kyE3jJVTla0lUOyM9RErpfDwy0GsYse/3jSX82fVR7qIxgbE1Q7IiETTQdlVaGtuSAXZmtFouh
	0h2aImeGfbtv5AZkld0dTkxKypysc9DU6iFlTa1sKR5gM4OOdXH5ajVKk5R/xofPV3MOCEADGhjKi
	SQlMqYOvlLU+BGrWbtvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mD3Uv-000NUA-NG; Mon, 09 Aug 2021 11:31:13 +0000
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mD3Uk-000NQX-2p
 for linux-nvme@lists.infradead.org; Mon, 09 Aug 2021 11:31:05 +0000
Received: by mail-ua1-x92a.google.com with SMTP id m39so1566004uad.9
 for <linux-nvme@lists.infradead.org>; Mon, 09 Aug 2021 04:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IV6BRlu5nqWBo0sf/tGMiDpNp/29jpZe7hZGlMgK9TE=;
 b=pd99atNghWR2EXFgv8XZJakjfWaxf7WhyknLM8kIoOHa4YgdfnoTPB5B5yZKzpLLeL
 8Obky1Touzww7JJ1LPkDR5ussYz78TDCT/aOUVtyInKRanV+yhskxWy13r4ELz5Zt3+W
 j9ZgRTqbG9Kk64HZ1JdseYys90ZGg5RbdLCoMBVBvfCnnouHZHy1qNjIffFsLIDWhKR3
 uEtKIcbj7BvqzUXb9yfl6fU6G44H8iNCHs0xPANj5Q3vS42f1YwZgr2i8eKmWNKpr9uz
 y4W3Mq4knk8u4HtsRKPZJo69FOfCe9ybgJAnEPiZm5i2N8d8t0qXR+Sy+nPjW/M5xCMV
 9Ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IV6BRlu5nqWBo0sf/tGMiDpNp/29jpZe7hZGlMgK9TE=;
 b=jMjmDf8eaLMJtF17XLdBQuZ0wt0a7CpZNxbrqRp47xIBa22cMXs+HCgLkDh415uBu7
 v/sgNCLZOw0NOxwR0zJbz6gvd3a6qdbiMuriW2/IZkCA9bvhZiJcVGN2hm7uUuGhgXO4
 Qt1CHmrHJx/R7oiblO70oiNRP19vXxrbEHzfi4cNgde6JPGTJ0zW9V1Dxn2bbXMg1XNR
 dwQS4Dp/kZnP2hnAacffi7PgY97bFuG29VTLakgRaRDIqpbQQW7u24sjiAj0xYtn4r/k
 qupkambqJVJ9GN5Anth038U8bM5oN0bm8j+3g0XJ0hvTa8LRdBCcheRrYVTOV+yik/JZ
 hnaA==
X-Gm-Message-State: AOAM5336ITf8nvn52Xsa2RVMUcEKqhBOwf9KMqnHaWrM67ltjC9521bG
 HPueOQKGVuLwYmekr5ljgM4mFCf7TL2VAPMYIXF42w==
X-Google-Smtp-Source: ABdhPJy6uKMGreNLvF0Ki8YaGC8NZzCCp3R6j9fbKII+5cbhRx2RkmK8Ng+IHjA2Ta3Qj2A+jSG6gNmoplJ+Wp8abWQ=
X-Received: by 2002:ab0:6f4b:: with SMTP id r11mr15007620uat.104.1628508660724; 
 Mon, 09 Aug 2021 04:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210809064028.1198327-1-hch@lst.de>
 <20210809064028.1198327-3-hch@lst.de>
In-Reply-To: <20210809064028.1198327-3-hch@lst.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Aug 2021 13:30:24 +0200
Message-ID: <CAPDyKFoSKwamqRdQNkgwKTixSwXPEf9dB4jSiOh73DqXOZ1yGg@mail.gmail.com>
Subject: Re: [PATCH 2/8] mmc: block: cleanup gendisk creation
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
 Song Liu <song@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, linux-block <linux-block@vger.kernel.org>,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, 
 linux-mmc <linux-mmc@vger.kernel.org>, linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210809_043102_198968_7DDF609E 
X-CRM114-Status: GOOD (  26.62  )
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

On Mon, 9 Aug 2021 at 08:44, Christoph Hellwig <hch@lst.de> wrote:
>
> Restructure mmc_blk_probe to avoid a failure path with a half created
> disk.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Let's try to funnel this via Jens' tree. As long as his tree is based
upon v5.14-rc3 or later I don't think we should have any problem with
conflicts.

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 49 ++++++++++++++--------------------------
>  1 file changed, 17 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 4ac3e1b93e7e..4c11f171e56d 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2328,7 +2328,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>                                               sector_t size,
>                                               bool default_ro,
>                                               const char *subname,
> -                                             int area_type)
> +                                             int area_type,
> +                                             unsigned int part_type)
>  {
>         struct mmc_blk_data *md;
>         int devidx, ret;
> @@ -2375,6 +2376,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>         kref_init(&md->kref);
>
>         md->queue.blkdata = md;
> +       md->part_type = part_type;
>
>         md->disk->major = MMC_BLOCK_MAJOR;
>         md->disk->minors = perdev_minors;
> @@ -2427,6 +2429,10 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>                 md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
>                 cap_str, md->read_only ? "(ro)" : "");
>
> +       /* used in ->open, must be set before add_disk: */
> +       if (area_type == MMC_BLK_DATA_AREA_MAIN)
> +               dev_set_drvdata(&card->dev, md);
> +       device_add_disk(md->parent, md->disk, mmc_disk_attr_groups);
>         return md;
>
>   err_kfree:
> @@ -2456,7 +2462,7 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
>         }
>
>         return mmc_blk_alloc_req(card, &card->dev, size, false, NULL,
> -                                       MMC_BLK_DATA_AREA_MAIN);
> +                                       MMC_BLK_DATA_AREA_MAIN, 0);
>  }
>
>  static int mmc_blk_alloc_part(struct mmc_card *card,
> @@ -2470,10 +2476,9 @@ static int mmc_blk_alloc_part(struct mmc_card *card,
>         struct mmc_blk_data *part_md;
>
>         part_md = mmc_blk_alloc_req(card, disk_to_dev(md->disk), size, default_ro,
> -                                   subname, area_type);
> +                                   subname, area_type, part_type);
>         if (IS_ERR(part_md))
>                 return PTR_ERR(part_md);
> -       part_md->part_type = part_type;
>         list_add(&part_md->part, &md->part);
>
>         return 0;
> @@ -2674,20 +2679,13 @@ static int mmc_blk_alloc_parts(struct mmc_card *card, struct mmc_blk_data *md)
>
>  static void mmc_blk_remove_req(struct mmc_blk_data *md)
>  {
> -       struct mmc_card *card;
> -
> -       if (md) {
> -               /*
> -                * Flush remaining requests and free queues. It
> -                * is freeing the queue that stops new requests
> -                * from being accepted.
> -                */
> -               card = md->queue.card;
> -               if (md->disk->flags & GENHD_FL_UP)
> -                       del_gendisk(md->disk);
> -               mmc_cleanup_queue(&md->queue);
> -               mmc_blk_put(md);
> -       }
> +       /*
> +        * Flush remaining requests and free queues. It is freeing the queue
> +        * that stops new requests from being accepted.
> +        */
> +       del_gendisk(md->disk);
> +       mmc_cleanup_queue(&md->queue);
> +       mmc_blk_put(md);
>  }
>
>  static void mmc_blk_remove_parts(struct mmc_card *card,
> @@ -2876,7 +2874,7 @@ static void mmc_blk_remove_debugfs(struct mmc_card *card,
>
>  static int mmc_blk_probe(struct mmc_card *card)
>  {
> -       struct mmc_blk_data *md, *part_md;
> +       struct mmc_blk_data *md;
>         int ret = 0;
>
>         /*
> @@ -2904,19 +2902,6 @@ static int mmc_blk_probe(struct mmc_card *card)
>         if (ret)
>                 goto out;
>
> -       dev_set_drvdata(&card->dev, md);
> -
> -       device_add_disk(md->parent, md->disk, mmc_disk_attr_groups);
> -       if (ret)
> -               goto out;
> -
> -       list_for_each_entry(part_md, &md->part, part) {
> -               device_add_disk(part_md->parent, part_md->disk,
> -                               mmc_disk_attr_groups);
> -               if (ret)
> -                       goto out;
> -       }
> -
>         /* Add two debugfs entries */
>         mmc_blk_add_debugfs(card, md);
>
> --
> 2.30.2
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
