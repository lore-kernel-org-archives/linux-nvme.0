Return-Path: <SRS0=e03W=M2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF463C432BE
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Aug 2021 15:56:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A4460F45
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Aug 2021 15:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A0A4460F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pmb2fWfRznJvDW+Yihxwbc8iMrZFnzi/0Y36IRHSIdM=; b=wg6+Z94UdbeMRb
	w8Nr/fG8uCAx/9Czv0WWGnd2dh5zZhQden7fgIzDLKjSgp07ixz1DnV2jlmU+SMkmLXBN2M5mfnbd
	b1slZXYGtSduMnPEFGUQEFaQUD+blzQOphDGrT5wKeZRUQOx3SgQZep9lzauKo6Ru6H+MzZEFKA81
	lZBikjUtKy6s7A/xWM1s1Id6/RW5isi2geqUKhAmrjPk6/r58aBiJYsNpD3A8vlfd4XRGpvMugTCK
	l0eNPDdPOcJ6fwXEcSOtg9IY8u9LjpDFV4ntt2ufB2JLEJPaqN2SrYLo97MxcwYQokYAH19p/CuvP
	yQfR6QiMLqUYOp58QHEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mAwlo-003TqH-9f; Tue, 03 Aug 2021 15:55:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mAwlA-003Tdb-Df
 for linux-nvme@lists.infradead.org; Tue, 03 Aug 2021 15:55:17 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5578E60FC2;
 Tue,  3 Aug 2021 15:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628006114;
 bh=Xh6xJ92/S8QXvRgpEhtrmDAUaqiUF3pjAB51iTXYzY0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=u6u0UA20JK6/uxxm0UZN0jh044NTws23FKkrg1V/RltDduec9W3y+q/HNHp8Ph+95
 QziDsQuuGZLp2FlaJT8PNc7Mgvd1ciuUJQwfwmyfUxxnuj+ZvJnefRiU6osN/yXZXY
 TYjsC1TkJ2B75mtxrpWAsGgeaYFaQSYiAKmYev2S/McYZWr5+St3wQc5XS6JKN1sBd
 ZYTA+Z3QvVTGxl6WvYHi9EoKxzHpPB7vC8a/I7Ngb3FUuGj/RhjHw5EeOkoOWBAMp9
 aygpT+Diy+vbSirADPF4vPfWAsOpAx6Ekm+9wPXHknNBePrw9DgL4oKd1dAzcu+2S6
 43gYuOt7z/y6Q==
Date: Tue, 3 Aug 2021 08:55:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ruozhu Li <liruozhu@huawei.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: don't do scan work if io queue count is zero
Message-ID: <20210803155512.GA2294634@dhcp-10-100-145-180.wdc.com>
References: <20210803090630.14425-1-liruozhu@huawei.com>
 <20210803090630.14425-3-liruozhu@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210803090630.14425-3-liruozhu@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210803_085516_548856_D1A5D2C7 
X-CRM114-Status: GOOD (  17.06  )
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

On Tue, Aug 03, 2021 at 05:06:30PM +0800, Ruozhu Li wrote:
> kernel panic when try to rescan ns when io queue count is zero.Because
> kernel BUG_ON when hctx_idx is greater than ctrl->queue_count.
> --
> nvme_rdma_init_hctx+0x58/0x60 [nvme_rdma]
> blk_mq_realloc_hw_ctxs+0x140/0x4c0
> blk_mq_init_allocated_queue+0x130/0x410
> blk_mq_init_queue+0x40/0x88
> nvme_validate_ns+0xb8/0x740
> nvme_scan_work+0x29c/0x460
> process_one_work+0x1f8/0x490
> worker_thread+0x50/0x4b8
> kthread+0x134/0x138
> ret_from_fork+0x10/0x18
> --
> Defence it by not allowing rescan ns when io queue count is zero.
> 
> Signed-off-by: Ruozhu Li <liruozhu@huawei.com>
> ---
>  drivers/nvme/host/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dfd9dec0c1f6..d9f837eb3e26 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -141,7 +141,8 @@ void nvme_queue_scan(struct nvme_ctrl *ctrl)
>  	/*
>  	 * Only new queue scan work when admin and IO queues are both alive
>  	 */
> -	if (ctrl->state == NVME_CTRL_LIVE && ctrl->tagset)
> +	if (ctrl->state == NVME_CTRL_LIVE &&
> +	    ctrl->tagset && ctrl->queue_count > 1)

Why is the transport driver leaving an unusable tagset allocated when
there are no IO queues to support it? I think it should free the tagset
in that case. At least that's what pci does.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
