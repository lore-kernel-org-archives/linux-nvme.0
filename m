Return-Path: <SRS0=/f9n=N4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04885C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 17:11:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB9D660FBF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 17:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BB9D660FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DNDZH7R8bijGDyFYBcnAsSp1OiElsMqLpSoyRTsxLBU=; b=zvUYkUVsvdhW7c
	B5JZPU5xsgiIsTSgh8U5D5XOXwZ7SXLonhLqjg1FU59rH34VkfsYV49lXSsNv7NJgalRwWxC6UyWr
	MTAtDkrsFrMQ7cF7bEr3B0awrn89xJPkWYjM+poMrhbMf8KooZnWM2mbk2QvWoUa8cYmPTkZho+vc
	vwvdhCMTrLF48dZ34ax/8c868MfGDG47+ons9yZZ5yvRvrfwc8ubJN0IaFA1lmWQV/GA2PhsK0aTL
	4kvUCkpGet4JukX6EDU5WpTPiND5RX9Lx07Z7mG7kEnBAMTuaCrzc1r4FV3VyzOcbfoNa0MzDb1+j
	sXS5J/SDzNujSmxbgpDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNI9H-001Oo9-Jz; Mon, 06 Sep 2021 17:11:11 +0000
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNI8v-001Odx-3d
 for linux-nvme@lists.infradead.org; Mon, 06 Sep 2021 17:10:50 +0000
Received: by mail-lj1-x233.google.com with SMTP id l18so12270936lji.12
 for <linux-nvme@lists.infradead.org>; Mon, 06 Sep 2021 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eBV6xJO0OJaH8jzRZsLqKsR9gePhFCKXaYbJlTL1SK0=;
 b=LFms5S3j0LvWEYimyPf3cb4Aisdn+Fk0RcpOrMN+ZdxUItBFt03MZgAJyCUWWC62gA
 xL6pVj/R4056hMSTJXWaAAW0XJxWY95ANL2inlfc7gjmf6BFW8UdEkjBN6OfL9igtewV
 2JgY9QMy4BbUAgVA1jm1THz+5T5uS585jDOW2nVtjNTStboUZCsKHDlx3pvPga5s2Aea
 dvtTuh0M4AIM0YiFHE2rv2jMoWzeXBDMGduAbcmjYKzTNfr7wM1AzhSBU6ieiQ9XTDvy
 XQyK9QeN2IRddAghms+zRMV1up63wzN38bLJRWblvnD5e2vOcie3vnIumG6eir16lfbi
 jm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eBV6xJO0OJaH8jzRZsLqKsR9gePhFCKXaYbJlTL1SK0=;
 b=aftNCTr2cuRtoYr1z5I41C0QNh4XHMSyP/iz8a2tQpTK8haGciJ/YVjg3aNLVAcsLu
 RTl62Rx/yDbUAW1+z3iZ2DvIv6+DiUBz9rwSVAXLpBwSqZcd8EA8pu4+4ujoYw1FDVsQ
 VRz9vGW4yJlHi+7pcaoFI+W2Rp3e7YdtuTWy59P8k0MTIbRfhTaexsTgjay1Rqtz8rkR
 NZyYMLwe9ntXYdeK9hAj7TNCMH7IvE04oNrv1529abQAAAyVNVzJodJpGi+9d0HvoP9o
 QdXV9+i8JzJSgdcoOyhukid1lyMVIMlmojdGn8eiOjg9ace88Cxh8Tm8Jso0sho2AHP8
 Guew==
X-Gm-Message-State: AOAM532tFq8iioOCC/4nsT32mhEYWu0/FfyWDxh/8NQcsv99ST+v8bAa
 e2w+qZcVw+ukmd5TCIH8bSYI0QqPytVuykFdbaH0RUgmHlU=
X-Google-Smtp-Source: ABdhPJxhSEFI8wMN4u5XHazx2hzbbCQEPxdsCfALNn+wlwsdQueMDsoHtriqduJghpS67u2M98pG6gst9sXWJqwHE5o=
X-Received: by 2002:a05:651c:1b3:: with SMTP id
 c19mr11757010ljn.16.1630948247165; 
 Mon, 06 Sep 2021 10:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210830212538.148729-1-mcgrof@kernel.org>
 <20210830212538.148729-5-mcgrof@kernel.org>
In-Reply-To: <20210830212538.148729-5-mcgrof@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 6 Sep 2021 19:10:10 +0200
Message-ID: <CAPDyKFp9HTjQ_6c2tHuPhhixfcnFa8XQBrPO2PqoB113BszLJw@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] mmc/core/block: add error handling support for
 add_disk()
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, kbusch@kernel.org,
 sagi@grimberg.me, Adrian Hunter <adrian.hunter@intel.com>,
 "Bean Huo (beanhuo)" <beanhuo@micron.com>, 
 Avri Altman <avri.altman@wdc.com>, Stephen Boyd <swboyd@chromium.org>,
 agk@redhat.com, 
 Mike Snitzer <snitzer@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
 Christoph Hellwig <hch@infradead.org>, Hannes Reinecke <hare@suse.de>,
 Bart Van Assche <bvanassche@acm.org>, 
 Ming Lei <ming.lei@redhat.com>, linux-scsi <linux-scsi@vger.kernel.org>, 
 linux-nvme@lists.infradead.org, linux-mmc <linux-mmc@vger.kernel.org>, 
 dm-devel@redhat.com, nbd@other.debian.org, 
 linux-block <linux-block@vger.kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210906_101049_194676_4AB27EC3 
X-CRM114-Status: GOOD (  21.18  )
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

On Mon, 30 Aug 2021 at 23:26, Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
>
> The caller only cleanups the disk if we pass on an allocated md
> but on error we return return ERR_PTR(ret), and so we must do all
> the unwinding ourselves.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Queued for v5.16 on the temporary devel branch, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 6a15fdf6e5f2..9b2856aa6231 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2453,9 +2453,14 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>         /* used in ->open, must be set before add_disk: */
>         if (area_type == MMC_BLK_DATA_AREA_MAIN)
>                 dev_set_drvdata(&card->dev, md);
> -       device_add_disk(md->parent, md->disk, mmc_disk_attr_groups);
> +       ret = device_add_disk(md->parent, md->disk, mmc_disk_attr_groups);
> +       if (ret)
> +               goto err_cleanup_queue;
>         return md;
>
> + err_cleanup_queue:
> +       blk_cleanup_queue(md->disk->queue);
> +       blk_mq_free_tag_set(&md->queue.tag_set);
>   err_kfree:
>         kfree(md);
>   out:
> --
> 2.30.2
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
