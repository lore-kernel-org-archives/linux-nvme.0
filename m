Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA22CD5A6C3
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2024 01:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Cc:References:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jM4xvE9Kiu7QJ647bQHZqlbHWN3nGI2KZwn64FG2c9A=; b=dBR2WBQDy9cjHKOqm46FrdGbSm
	JPUsI50m2mlb1J9+STV/8/KfUJxahPwhR2husMhdT2/A1a7rURzpDN8PheemjFsFNgqM/J4Mgo1Ky
	cpUp+gFV+WTY2p9x4VdYL4eR19uzghd5Na1HMyP0cRx5LXWFtz3emQM7vbl7PVtw81MTYZ2Ol7Pgw
	fZu+eX174W4yM/M5+w4D6q/poQx7pdm2zwEPMpzCcJrflp0dhlZHAPxA3EySTzExXNZzBlnBKpPgy
	QxKwIssh97fpb/OPKvW2lD7CQK3/Jhy+Hj103vH8ic5qVJ4HS0nrZon7Gmcj/CYS68XzWsx0Eekx/
	GzaDFrjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFkf3-00000009RK0-1rHZ;
	Tue, 26 Nov 2024 01:46:41 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFkez-00000009RJV-3ibb
	for linux-nvme@lists.infradead.org;
	Tue, 26 Nov 2024 01:46:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732585593; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=jM4xvE9Kiu7QJ647bQHZqlbHWN3nGI2KZwn64FG2c9A=;
	b=EL0PHXTfSgEGZR8G4qYbQAWvoXt+l36NEEzeEPb4uP7wsbQmHD2onCxgyCNwYEQ2KWVtEBGIR8FYGEDsLSXM6tMUJLiFGCx0u9xvkUPyAzoH1YakR6CLMXFrVw1JgvjoC1blO71y6ozqdYtwkmD2E4Tq81x5hhbjg9xq4U/IGkA=
Received: from 30.178.82.26(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WKG8jTQ_1732585588 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 Nov 2024 09:46:30 +0800
Message-ID: <c04513b2-70c5-4551-9a55-ca171192c117@linux.alibaba.com>
Date: Tue, 26 Nov 2024 09:46:27 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v2] nvmet: handle rw's limited retry flag
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20241125071226.95459-1-kanie@linux.alibaba.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
In-Reply-To: <20241125071226.95459-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_174638_415055_2FD6994E 
X-CRM114-Status: GOOD (  17.38  )
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

cc linux nvme mailing list, sorry for my oversight.

Best Regards,

Guixin Liu

在 2024/11/25 15:12, Guixin Liu 写道:
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
> ---
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

