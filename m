Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B949E98FC2
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 06:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XjnxrByH2GvRBEuNEnFZr53nst0jKv1IcAIuYTn7Ew4=; b=r1MjPvCxzak4WxvrC1azSsQOv9
	uFOCGwwBmd8AVFtMd9spE3lwD522yuuGvKjAuJX8AmDPp1DRlC3lPg83S1PuFKYJSgzqxQTYIMA4o
	O49dx4EKuQdhjmDkvy5eyO51bn/9k12CsJEl4cg4XPn+xasF2/cleNul23b/iRri6TGXTliG9Uu2J
	xmFzZjlxEh/yvEV7a/wntiMcgwxvuuqlkIA2rdSr0N7ccU5Oy4E2s9PniqNCVDwEaIGOSvCN0xWqL
	9Kd6oICcTag1SZxXqJyahb9ghuapkSBoDImobNTFPDOMWGJMiscKYBTcl+wPmynaE0V/uD3CleabL
	xYIB7Xvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAir5-00000009lfp-0CcP;
	Thu, 09 Apr 2026 06:27:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAir2-00000009lfI-0F7G
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 06:27:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 996B368BFE; Thu,  9 Apr 2026 08:26:59 +0200 (CEST)
Date: Thu, 9 Apr 2026 08:26:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: song@kernel.org, yukuai@fnnas.com, linan122@huawei.com,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	kmodukuri@nvidia.com
Subject: Re: [PATCH V2 2/2] nvme-multipath: enable PCI P2PDMA for multipath
 devices
Message-ID: <20260409062659.GA7335@lst.de>
References: <20260408072537.46540-1-kch@nvidia.com> <20260408072537.46540-3-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408072537.46540-3-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_232704_243570_2A952950 
X-CRM114-Status: GOOD (  25.58  )
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

On Wed, Apr 08, 2026 at 12:25:37AM -0700, Chaitanya Kulkarni wrote:
> From: Kiran Kumar Modukuri <kmodukuri@nvidia.com>
> 
> NVMe multipath does not expose BLK_FEAT_PCI_P2PDMA on the head disk
> even when the underlying controller supports it.
> 
> Set BLK_FEAT_PCI_P2PDMA in nvme_mpath_alloc_disk() when the controller
> advertises P2PDMA support via ctrl->ops->supports_pci_p2pdma.
> 
> Since multipath can match paths across different transports (e.g. PCIe
> and FC), not all paths are guaranteed to support P2PDMA. Clear
> BLK_FEAT_PCI_P2PDMA from the head disk in nvme_mpath_add_disk() if the
> newly added path does not support it, ensuring the feature is only
> advertised when every member supports it.
> 
> Signed-off-by: Kiran Kumar Modukuri <kmodukuri@nvidia.com>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/nvme/host/multipath.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index ba00f0b72b85..48d920ce803f 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -737,6 +737,9 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>  		BLK_FEAT_POLL | BLK_FEAT_ATOMIC_WRITES;
>  	if (head->ids.csi == NVME_CSI_ZNS)
>  		lim.features |= BLK_FEAT_ZONED;
> +	if (ctrl->ops && ctrl->ops->supports_pci_p2pdma &&
> +	    ctrl->ops->supports_pci_p2pdma(ctrl))
> +		lim.features |= BLK_FEAT_PCI_P2PDMA;

I think we can just add this unconditionally here, similar to all the
other feaures above the ZNS conditional as any non-supporting controller
will clear it later.

>  
>  void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
>  {
> +	struct nvme_ns_head *head = ns->head;
> +
> +	/*
> +	 * Clear BLK_FEAT_PCI_P2PDMA on the head disk if this path does not
> +	 * support it. Multipath may span different transports (e.g. PCIe and
> +	 * FC), so every member must support P2PDMA for it to be safe on the
> +	 * head disk.
> +	 */
> +	if (head->disk && !blk_queue_pci_p2pdma(ns->queue)) {
> +		struct queue_limits lim =
> +			queue_limits_start_update(head->disk->queue);
> +		lim.features &= ~BLK_FEAT_PCI_P2PDMA;
> +		queue_limits_commit_update(head->disk->queue, &lim);
> +	}

And this really should go into the core block code in blk_stack_limits,
so that BLK_FEAT_PCI_P2PDMA is cleared whenever a non-confirming
device is added, similar to BLK_FEAT_NOWAIT and BLK_FEAT_POLL.


