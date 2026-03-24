Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40597F532E5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 06:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rST8OFBT4ceK3L1SFWHfwWvn6p9rN8af7twnNgCs8mw=; b=giYhxR+xfw4n26Cskh71j/4Xle
	O+/Lwz2gEchiNZ1/gam/YmbZUFd2gQzLHR/7llHHRAyqtOmAEr38L9AXlMmiA97OH2/EWdyf83Mnh
	03ci9ZTYAXj5H7E4dFITdLt0D3vtp9AQM5gQ3R4fP1t+QadQcCqDyq8rDbNFwepxHGGkZeTVRv3ex
	y1sVXX3femKmlmBYAewZxHP6tu6C56FpTRZrkd1lEQXrOjLrj+9NdpWd+xoPOoqiJJ9Tsg8l3vLIx
	naY7uxA0IfbDH+LXN0RdAeBcMrE9GJYbB9al4grhwtXM+tO6q+ZX+gb0fHGp74I4udAo+ntJcQdfl
	n+cmG5pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vaB-00000000qCc-3H3j;
	Tue, 24 Mar 2026 06:49:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4va8-00000000qBv-1WSJ
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 06:49:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 867C66732A; Tue, 24 Mar 2026 07:49:37 +0100 (CET)
Date: Tue, 24 Mar 2026 07:49:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: song@kernel.org, yukuai@fnnas.com, linan122@huawei.com,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>
Subject: Re: [PATCH 2/2] nvme-multipath: enable PCI P2PDMA for multipath
 devices
Message-ID: <20260324064937.GB1409@lst.de>
References: <20260323234416.46944-1-kch@nvidia.com> <20260323234416.46944-3-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323234416.46944-3-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_234940_548421_DD8AA861 
X-CRM114-Status: GOOD (  16.57  )
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

On Mon, Mar 23, 2026 at 04:44:16PM -0700, Chaitanya Kulkarni wrote:
> NVMe multipath does not expose BLK_FEAT_PCI_P2PDMA on the head disk
> even when the underlying controller supports it.
> 
> Set BLK_FEAT_PCI_P2PDMA in nvme_mpath_alloc_disk() when the controller
> advertises P2PDMA support via ctrl->ops->supports_pci_p2pdma.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Kiran Kumar Modukuri <kmodukuri@nvidia.com>

This signoff chain is wrong - you are both author and patch submitter,
so other signoffs should not appear.

Otherwise looks good:

> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index ba00f0b72b85..c49fca43ef19 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -737,6 +737,9 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>  		BLK_FEAT_POLL | BLK_FEAT_ATOMIC_WRITES;
>  	if (head->ids.csi == NVME_CSI_ZNS)
>  		lim.features |= BLK_FEAT_ZONED;
> +	if (ctrl->ops && ctrl->ops->supports_pci_p2pdma &&
> +	    ctrl->ops->supports_pci_p2pdma(ctrl))
> +		lim.features |= BLK_FEAT_PCI_P2PDMA;

This assumes all controllers support P2P, but we allow matching
over different transports.  So you'll need to do the same scheme
as for MD RAID that checks that every member supports P2P.


