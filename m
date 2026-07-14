Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EF9C44501
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 05:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pPFEbt6Cy9Ghbb0Mpkr4VsyiJHJHxMHJQG5IdOgfrLw=; b=SUPqaD57h0RPZ/0/9oI4y/tP86
	1LTeQxtsd/fr0KvziDSUoPkTj3lxcdFPR90JqQDr/RcWftFC3+Mg4a5kiUlbtkghJ07V7ZQHSOX/m
	KPVHUeSTCjuzPxzI2lpFAq+8Jg0OCxxsHhw8rY3BfAxFJsjUHH3+mJkc1s6MzZhxN9E1jbw07EjPu
	5vLcBFGcZ1iSBs//t+YrxH0R4Ek81yDWGUFLrcuHR2yW7PMM/x0QuQFFyfhuEL65D+yXEq8spd/Xq
	4SHV20vfFjporikyeHaHaXhcSBYtd9nM+e5faDh1en/VvDm4ttN2fgBc0FFYYtIcyEV/bc+NZaj+K
	uOigff3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjVbq-0000000AvcQ-2q8h;
	Tue, 14 Jul 2026 05:23:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjVbp-0000000AvcB-1m3R
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 05:23:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0D7BC42D79;
	Tue, 14 Jul 2026 05:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D231F00A3E;
	Tue, 14 Jul 2026 05:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784006587;
	bh=pPFEbt6Cy9Ghbb0Mpkr4VsyiJHJHxMHJQG5IdOgfrLw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SGhpNbUaJ/B3EmC+JdUT7NirSb/pdQHc3cGrPBg0N32Jf3AHEODNCGmHi5gLGXQwA
	 t9zKpj+4VYxpTvCJ1loqIQRwtDeXauw1Z0dRRB2jyBlj++pXPnl0t12lJLJRACmyzp
	 1d2pg+0i9sxN0DjPDnUYgOy1HpWJN23nsOJZw5NMtnu1wIYWViEI1Mfaaiay8bPUBm
	 VtJx7XbaAvGoiwKyRLxvCIg442rfuFeLqWGJprEx8Fh9iJd8blff6PRM7vzIU8zQHi
	 3TQ1VatQ0ffvlWJK5O5j2o+nmen6mGIUwblL8O5Wf36C9mD3fobj6lCsI4FiMbQcaF
	 MeKRKmyTMy3yw==
Message-ID: <e4b28eda-fd08-4baf-b310-f9593593ffec@kernel.org>
Date: Tue, 14 Jul 2026 14:22:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet: pci-epf: fix use-after-free in
 nvmet_pci_epf_exec_iod_work()
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20260714040031.207362-1-shinichiro.kawasaki@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260714040031.207362-1-shinichiro.kawasaki@wdc.com>
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

On 7/14/26 13:00, Shin'ichiro Kawasaki wrote:
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
> 
>  Use-after-free read at 0x00000000fdfa6d03 (in kfence-#63):
>   nvmet_pci_epf_exec_iod_work+0x288/0x798 [nvmet_pci_epf]
>   process_one_work+0x15c/0x4f0
>   worker_thread+0x18c/0x30c
>   kthread+0x130/0x140
>   ret_from_fork+0x10/0x20
> 
>  kfence-#63: 0x00000000e3de0e71-0x00000000c938ad62, size=712, cache=kmalloc-1k
> 
>  allocated by task 10 on cpu 0 at 73.995480s (0.005122s ago):
>   mempool_kmalloc+0x1c/0x28
>   mempool_alloc_noprof+0x40/0x9c
>   nvmet_pci_epf_poll_sqs_work+0xd4/0x344 [nvmet_pci_epf]
>   process_one_work+0x15c/0x4f0
>   worker_thread+0x18c/0x30c
>   kthread+0x130/0x140
>   ret_from_fork+0x10/0x20
> 
>  freed by task 131 on cpu 3 at 73.995521s (0.008385s ago):
>   mempool_kfree+0x10/0x20
>   mempool_free+0x44/0x64
>   nvmet_pci_epf_free_iod+0x88/0x98 [nvmet_pci_epf]
>   nvmet_pci_epf_cq_work+0xfc/0x280 [nvmet_pci_epf]
>   process_one_work+0x15c/0x4f0
>   worker_thread+0x18c/0x30c
>   kthread+0x130/0x140
>   ret_from_fork+0x10/0x20
> 
> Fix this by referring to iod->data_len and iod->dma_dir before calling
> req->execute(). The remaining iod accesses such as iod->status are only
> reached on the device-to-host read path. In this case,
> nvmet_pci_epf_queue_response() signals iod->done instead of freeing the
> iod, so the iod stays valid.
> 
> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

