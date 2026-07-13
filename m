Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FB3C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 07:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W7EGPT+93qBbspFTa9JheTnJDFdz5yWllXim2t/YJw8=; b=IUStL52Cs3TOvD6Bo54V8gjOE9
	wUifOYQrrEO9T9zsgEp5a1usN2q+h+RkjTRKjRX1so8ltSLUTWttsG/eZVK4vik1V4OJLndYmRv5b
	zAYNkpTUkSrOHGROuG4u06LBWkzfG9HzxAQJNshRGqRvw82y8qe+Uh/UhHVzEEi2UxOHnb8Za7PGj
	9wu+uNf/8Yn5+LlL/u7kkiciYMXBJrYSWtAR0QHg4J3Gz/5Z11cSr/JNRt2nj80hfvmUSMj8UxBLu
	P+Ft5KHPndY2ZRu0t5ZBhhAB24WIrSbs5Xk/lxJ9zfkYuik9/WG6Ywhl0rVY6ptvGJHhZZ86EpjM8
	UoIvUJWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjB5U-00000008PTF-48dx;
	Mon, 13 Jul 2026 07:28:24 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjB5T-00000008PSy-1NGl
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 07:28:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D3A5243B1C;
	Mon, 13 Jul 2026 07:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCDF1F00A3A;
	Mon, 13 Jul 2026 07:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783927702;
	bh=W7EGPT+93qBbspFTa9JheTnJDFdz5yWllXim2t/YJw8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bIU5gE9EIbZVwV5cgWH3lGUM8FTSwCpYCgHQF3L3rnvGYJ7Ib40QvziRpAdNdA0po
	 mBZb5UiWNHTD0FZOeXjgncGOrL/BiQdw1Wl0lYbx69v1l6OiFTY/GaRcsnFIpSZKTc
	 vCRODOj3vB/mxtF2c4ydOwM/ScyoPn//FFv0B2aAlaFGABTuzEX7gRVwze6JPB5IPe
	 fc+c9YJqOto3MgMCLR/i2Ku3LeaqzqIuVtmMkom37DURC/wm/bzY5za+q16XnX3LOJ
	 mC0+oBmFJS70YbPXhILN+PGZ0QgHJ0MtpOd+axfFkDvNbSisH4y1D4jf/Xg5LOrV/l
	 rBmZxD/g0PA7g==
Message-ID: <43f0a5fd-e300-4d9f-b0cc-f0aab42fbb08@kernel.org>
Date: Mon, 13 Jul 2026 16:28:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: pci-epf: fix use-after-free in
 nvmet_pci_epf_exec_iod_work()
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20260713043250.75514-1-shinichiro.kawasaki@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260713043250.75514-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 7/13/26 13:32, Shin'ichiro Kawasaki wrote:
> nvmet_pci_epf_exec_iod_work() submits an I/O command with req->execute()
> and then waits for the command to complete and transfers the data back
> to the host. This wait is not needed for commands that do not transfer
> data from the device to the host. To decide whether that wait is needed,
> it reads iod->data_len and iod->dma_dir after calling req->execute().
> 
> However, once req->execute() is called, the command may complete
> asynchronously on another CPU. For commands that do not require a
> device-to-host data transfer, nvmet_pci_epf_queue_response() calls
> nvmet_pci_epf_complete_iod() directly, which can free the iod before it
> reads iod->data_len and iod->dma_dir, resulting in the KFENCE use-after-
> free:
> 
>  BUG: KFENCE: use-after-free read in nvmet_pci_epf_exec_iod_work+0x288/0x798 [nvmet_pci_epf]

Looks good, but I would do it like this to simplify:

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 4e9db96ebfec..485ce759391a 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1594,6 +1594,7 @@ static void nvmet_pci_epf_exec_iod_work(struct
work_struct *work)
        struct nvmet_pci_epf_iod *iod =
                container_of(work, struct nvmet_pci_epf_iod, work);
        struct nvmet_req *req = &iod->req;
+       bool no_wait;
        int ret;

        if (!iod->ctrl->link_up) {
@@ -1638,14 +1639,16 @@ static void nvmet_pci_epf_exec_iod_work(struct
work_struct *work)
                }
        }

-       req->execute(req);
-
        /*
         * If we do not have data to transfer after the command execution
         * finishes, nvmet_pci_epf_queue_response() will complete the command
         * directly. No need to wait for the completion in this case.
         */
-       if (!iod->data_len || iod->dma_dir != DMA_TO_DEVICE)
+       no_wait = !iod->data_len || iod->dma_dir != DMA_TO_DEVICE;
+
+       req->execute(req);
+
+       if (no_wait)
                return;

        wait_for_completion(&iod->done);


-- 
Damien Le Moal
Western Digital Research

