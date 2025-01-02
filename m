Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49596E7718B
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jan 2025 01:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YNr1rXS1vIkqIrqKoIVzubAiZxkGNO4+xORbgIVwToU=; b=igYq7ZigHjmHd+Ef+sEsWnZPs0
	dlEJt7XVLoGk2pxL/J3daH5qokofrXNjGKZp62nWuPQ1+0eMGXVcXvkVVV9dTpKLpwfP/8gMZsFpe
	dcSNaRSW8j2gZhxdmeiNe2mVJF/ls76xcFTRsL9w3Crkv66VLHXF8z9rA2VKy2JsM6eNGue1fl/5Y
	9TzTJ30ACjr7FIBzYxt6hKrPU/pXgjbNCCq1Qo/09RdQVAjkImp0O1T52AP214JTdvVTwRJc6++VG
	ceWHMSVxr+YUxKBJR8zag18VzYNLtfd0deFPtjtEppHsIcs/9zrR/d6Yuwb1F0VpLpWYIXqlYioCO
	bxicBNRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTAMA-00000009Zmi-3497;
	Thu, 02 Jan 2025 01:50:38 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTAM3-00000009ZmG-1wIs
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jan 2025 01:50:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735782625; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=YNr1rXS1vIkqIrqKoIVzubAiZxkGNO4+xORbgIVwToU=;
	b=T71JKlnzbQoz5jLyhGpbsQ4vfC3zNUDIkkWpUZUQ3BBB+z844HXnrpG6WFnnf9QizO4SNCu0D0FWtQI2I565kPI+RrriAreOesbE4WYmjMeTCFnCVp0cWF9TDnvMSrPa06CEW5hulTUc1znOjDq8wK9Tryu/xwwUyL0ddg1oXaE=
Received: from 30.178.82.231(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WMhj8aV_1735782621 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Jan 2025 09:50:23 +0800
Message-ID: <e7039df5-8720-4f62-8cf2-58a60451d91b@linux.alibaba.com>
Date: Thu, 2 Jan 2025 09:50:21 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v3] nvmet: handle rw's limited retry flag
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20241209015344.60861-1-kanie@linux.alibaba.com>
In-Reply-To: <20241209015344.60861-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250101_175032_194768_255CB812 
X-CRM114-Status: GOOD (  19.57  )
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

Hi Keith,

     Could you plz apply this patch?

Best Regards,

Guixin Liu

在 2024/12/9 09:53, Guixin Liu 写道:
> In some scenarios, some multipath software setup places the
> REQ_FAILFAST_DEV flag on I/O to prevent retries and immediately
> switch to other paths for issuing I/O commands. This will reflect
> on the NVMe read and write commands with the limited retry flag.
>
> However, the current NVMe target side does not handle the limited
> retry flag, and the target's underlying driver still retries the
> I/O. This will result in the I/O not being quickly switched to
> other paths, ultimately leading to increased I/O latency.
>
> When the nvme target receive an rw command with limited retry flag,
> handle it in block backend by setting the REQ_FAILFAST_DEV flag to
> bio.
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> Changes from v2 to v3:
> - Add the rb tag from Christoph, thanks.
>
> Changes from v1 to v2:
> - Add details to commit body(Christoph).
> - Add the rb tag from Chaitanya, thanks.
>
>   drivers/nvme/target/io-cmd-bdev.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index 0bda83d0fc3e..6380b60fd490 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -272,6 +272,9 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>   		iter_flags = SG_MITER_FROM_SG;
>   	}
>   
> +	if (req->cmd->rw.control & NVME_RW_LR)
> +		opf |= REQ_FAILFAST_DEV;
> +
>   	if (is_pci_p2pdma_page(sg_page(req->sg)))
>   		opf |= REQ_NOMERGE;
>   

