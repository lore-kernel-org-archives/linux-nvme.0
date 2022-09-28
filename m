Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36793C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 13:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y4CRwJTCmV2dgd++IDqduezpwxwZIxQ6/WfR9v6lDDo=; b=2qw6fLOQpYt2p7JEwcVD2e2uHs
	NkyTea1QFDrdWwf0V1DfRVqtIdAPF9LikrwgCZrvXlnqYmafdfTHrWG7yXw4fwuubSd0fz1NkpOBw
	zlKDcWtaaPePIbwlPRTdyXvDfZWITvb/mKnQLYijgUUc2PHlgZHnJyqjF8CpMx15t56zLRZm81U9W
	z5OGql/BNU29rxdoOZdf+o+DlFCkdD3QHOQvHsPbWF8A3ECFFR0g/O3N9lnDNd5O8NwbV0F2uJyVO
	HP61sjh5Exwn1ReNO+M/dvW9H3ETNTrQvKnNHxt07FwzOs9LKaGBzlyr273+KfPAJ0J1sWHh+cEHt
	KQP1La4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odXXV-00Gam9-4x; Wed, 28 Sep 2022 13:55:53 +0000
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odXXS-00Gakn-RX
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 13:55:52 +0000
Received: by mail-ua1-x92b.google.com with SMTP id t21so460311uar.7
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=y4CRwJTCmV2dgd++IDqduezpwxwZIxQ6/WfR9v6lDDo=;
        b=U07gc71CMClhBjWhvOD3AT4pWZWDLqu1fCzni0cYkPNGKyArVQrAniK1jZ/xuLdBbm
         qzz4pVoUbjcQBEemuomaq6c8HSbvaiGWghG8n8CzZXwxPOrHfRVsEIuxA2Go4GsMt0N/
         uP1YwbGuPtFzhejseu+PbqZ1yCiRbvDGgZ67P9aNptnQNucdn+aaJ5cf0PnSg+0NM4Nw
         +ahXAxIY0fmHOCrsFlCdEQpdTZiqjiBmexd8f3S/5G++93R0AR60UDzUn6TKeZ5dQ/tc
         enRJtndELbhz/7asmC7nkF/zFzYnizyZelgD9ZztB2jKsbxp9osT6Zk4WDlczzOLA2e/
         YZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=y4CRwJTCmV2dgd++IDqduezpwxwZIxQ6/WfR9v6lDDo=;
        b=Upqs83+Ol2Tqf3x60sk2AWOingRqxY1DwgfoJ/UdXuMiaH+p4KqesDly6iqJPrDwak
         vQGyGjOLjocusrvZB7k0RpJ9TSRcwslk4tQH5WpP8lzCSevoQb6lcWWu6mKzpSoQkGVL
         Wmqj4fBq9h2wKeDeE7nLHxqSuhTm9acSUbzgB7ARI2fhOFoP/1PKhmNzEdRJbcaRxp8z
         CzDIoBajAtVwWK+aoJzyzTzz/43n6yf+ozn2U5/5y6vx0VoXo7cTk9H2yUfFXa0f4Xq0
         8SFqP7mhLRAAu6ABPR3V0TiVF/S6rpLg2nMZYvgYcIcz4jRPgCCuA+POz1X35ZWvDeXi
         MVHA==
X-Gm-Message-State: ACrzQf0VK4JKDIhxJOOK7eAJQkVM2jWNXuGadL5wIl1+I8Q7wotF3nJ2
	fG2dwtVsW8wTaYg6MRmKz2YFdd3O7fQXppFWyw==
X-Google-Smtp-Source: AMsMyM4j1OKkxAs1lqcZaiS1oPGxF9Yq2Hs4nWWihhfCK/srKXciqdLJOTvPxtuRjxOy9b+AEBYnopME2Xf/dc1kbIk=
X-Received: by 2002:ab0:3c93:0:b0:3c0:b089:1081 with SMTP id
 a19-20020ab03c93000000b003c0b0891081mr16558499uax.9.1664373348779; Wed, 28
 Sep 2022 06:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220927014420.71141-1-axboe@kernel.dk> <20220927014420.71141-6-axboe@kernel.dk>
In-Reply-To: <20220927014420.71141-6-axboe@kernel.dk>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 28 Sep 2022 19:25:11 +0530
Message-ID: <CACzX3AtYRa6avG5Gf8jgE4Mz1PdeSCri=Q+PvetR3dOOgbS7OA@mail.gmail.com>
Subject: Re: [PATCH 5/5] nvme: enable batched completions of passthrough IO
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Stefan Roesch <shr@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_065550_912483_CBB1515A 
X-CRM114-Status: GOOD (  19.26  )
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

On Tue, Sep 27, 2022 at 7:19 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Now that the normal passthrough end_io path doesn't need the request
> anymore, we can kill the explicit blk_mq_free_request() and just pass
> back RQ_END_IO_FREE instead. This enables the batched completion from
> freeing batches of requests at the time.
>
> This brings passthrough IO performance at least on par with bdev based
> O_DIRECT with io_uring. With this and batche allocations, peak performance
> goes from 110M IOPS to 122M IOPS. For IRQ based, passthrough is now also
> about 10% faster than previously, going from ~61M to ~67M IOPS.
>
> Co-developed-by: Stefan Roesch <shr@fb.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/nvme/host/ioctl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 9e356a6c96c2..d9633f426690 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -423,8 +423,7 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
>         else
>                 io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_cb);
>
> -       blk_mq_free_request(req);
> -       return RQ_END_IO_NONE;
> +       return RQ_END_IO_FREE;
>  }
>
>  static enum rq_end_io_ret nvme_uring_cmd_end_io_meta(struct request *req,
> --
> 2.35.1
>
Looks good to me.
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

--
Anuj Gupta

