Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E276CED270
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 06:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GIVNeHK2KrIhHcVsb1JU70OL1LSfnh4xAgXwOBfQ0r4=; b=xIsWtuNPmEF5XbEiLfGKVH6psV
	NkYPRi1mHr/3rXu2hbsL8DXp/cppcxErcZ6Pllybovem4RHKRFF8iojHxQFhVrMC7elwxMA2FTRXI
	86B9pnHEvFHNdQ7XapqwolAIHkagQqe91r3i0jAIutpOJqRqGzh9KKlfVGED+Bcq7zbkAZUGfYfRN
	ztPYckxZ5iq5AMqGQxhD0kQeixJ4Lf7hXVi9LcqrHzLWiPGbgoHD6tP2ezxdqCZHBCN6NMDiM/MXy
	JHgZTFdJrZ6/6j6bgIzgGOBivXbf7tWZIBDGuIHvCujlSoceKP2tcExtcv3tyA9/LoHsP3QrpiW0p
	F4AcRTQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy3v9-00000004gRk-0N47;
	Tue, 08 Oct 2024 06:42:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy3tQ-00000004gCD-3NSG
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 06:40:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7006C227A88; Tue,  8 Oct 2024 08:40:20 +0200 (CEST)
Date: Tue, 8 Oct 2024 08:40:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/3] nvme-multipath: skip failed paths during partition
 scan
Message-ID: <20241008064020.GB22424@lst.de>
References: <20241007100134.21104-1-hare@kernel.org> <20241007100134.21104-4-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007100134.21104-4-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_234025_008324_7F55CD60 
X-CRM114-Status: GOOD (  23.54  )
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

On Mon, Oct 07, 2024 at 12:01:34PM +0200, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> When an I/O error is encountered during scanning (ie when the
> scan_lock is held) we should avoid using this path until scanning
> is finished to avoid deadlocks with device_add_disk().
> So set a new flag NVME_NS_SCAN_FAILED if a failover happened during
> scanning, and skip this path in nvme_available_paths().
> Then we can check if that bit is set after device_add_disk() returned,
> and remove the disk again if no available paths are found.
> That allows the device to be recreated via the 'rescan' sysfs attribute
> once no I/O errors occur anymore.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  drivers/nvme/host/multipath.c | 26 ++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h      |  1 +
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index f03ef983a75f..4113d38606a4 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -102,6 +102,13 @@ void nvme_failover_req(struct request *req)
>  		queue_work(nvme_wq, &ns->ctrl->ana_work);
>  	}
>  
> +	/*
> +	 * Do not use this path during scanning
> +	 * to avoid deadlocks in device_add_disk()
> +	 */
> +	if (mutex_is_locked(&ns->ctrl->scan_lock))
> +		set_bit(NVME_NS_SCAN_FAILED, &ns->flags);

Err, no.  mutex_is_locked is never a valid way to detect the calling
context - obviously someone else could also be holding it.


