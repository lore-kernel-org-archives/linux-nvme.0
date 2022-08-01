Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D7AC00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 14:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2B0sZtA/MMEozpzgtHuQo5vwo1PlhOW04Ox/V9sV6xA=; b=2qEgJ/jvSvP5/DKAwhKFQp6gYD
	fxCOJMp5tFQkC+Lo/MmGqdmdrufPk7j234D65acrsfYFNXXCjaBTNiZxpH0EKVf8H+/rm+HrTP60S
	GMQeq0uDqYYItwM9aBBzf8F+zh7A+t1yodj0WL6AkF0EvbqDNG+cFMGcgXwNmEremZamRtWTcoB9a
	3QoCWQCQRdjmY8r3T9bDu+ueJGrpEOA4zMi7UulUThOyaUkJ0ZA7luPDdsX+Jdv3+kUAwDWFiIAlS
	H7rfob4cw4lZiKQHaGD1xKd6rwvCF4DgjxP7t0plq8CG9scWtpntpELLzbNuFy2CgHzdOfvPGv4gQ
	y3EU2Khw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIWTm-0075Xl-2V; Mon, 01 Aug 2022 14:33:10 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIWTj-0075WD-3t
	for linux-nvme@lists.infradead.org; Mon, 01 Aug 2022 14:33:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 97FAE61360;
	Mon,  1 Aug 2022 14:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AF3C433C1;
	Mon,  1 Aug 2022 14:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659364385;
	bh=IGCn/EQ+jghbBWU+9+CBVYN+/AjNgXvHzi9hD/hOwso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugTTHuQdBoUB4wJq8dMNPp31ovyN1jcNDEloqYcL5r9vZ0zWYyp6Og3atdmz3LByE
	 6xGX+YWuuZrwWLnbwDD7nEPtReL/S8/TfrnRstfVv7WP9lB5htXNPKwCJRkha7xOrH
	 mNdxDjDEXj/6Mh2xgs5RWIDeYZg/48ZHT5PzBOVkQNsMJ8yzEk8l8PG18C8iuBaTPb
	 ODyTX8eQ5jfRtdHphrNVJ+HjqYaHxnb0tn2QSK4rF/cmjqispQk+4OhG8qxK9gDV3l
	 c5OGGUB1uHOrOqdboqgCzWC8x4XWmi7RrPMgjKkdRq4r2AIS5ySfWrWr7hI9G8CVt9
	 vqJM4rjex/i1A==
Date: Mon, 1 Aug 2022 08:33:01 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvme-pci: fix race between pci reset and nvme probe
Message-ID: <YufkHXoUrw7jRLuT@kbusch-mbp>
References: <20220801125753.1434024-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801125753.1434024-1-ming.lei@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_073307_238737_7AF8A9A9 
X-CRM114-Status: GOOD (  27.24  )
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

On Mon, Aug 01, 2022 at 08:57:53PM +0800, Ming Lei wrote:
> After nvme_probe() returns, device lock is released, and PCI reset
> handler may come, meantime reset work is just scheduled and should
> be in-progress.
> 
> When nvme_reset_prepare() is run, all NSs may not be allocated yet
> and each NS's request queue won't be frozen by nvme_dev_disable().
> 
> But when nvme_reset_done() is called for resetting controller, all
> NSs may have been scanned successfully, and nvme_wait_freeze() is
> called on un-frozen request queues, then wait forever.
> 
> Fix the issue by holding device lock for resetting from nvme probe.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Link: https://lore.kernel.org/linux-block/CAHj4cs--KPTAGP=jj+7KMe=arDv=HeGeOgs1T8vbusyk=EjXow@mail.gmail.com/#r
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/nvme/host/pci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 4232192e10dd..d49b1a082983 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3075,9 +3075,14 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>  static void nvme_async_probe(void *data, async_cookie_t cookie)
>  {
>  	struct nvme_dev *dev = data;
> +	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  
> +	pci_dev_lock(pdev);
> +	nvme_reset_ctrl(&dev->ctrl);
>  	flush_work(&dev->ctrl.reset_work);
>  	flush_work(&dev->ctrl.scan_work);
> +	pci_dev_unlock(pdev);
> +
>  	nvme_put_ctrl(&dev->ctrl);
>  }

When low on memory, async_schedule() falls back to calling the requested
function directly, so this would deadlock on taking the pci_dev_lock() the
second time within the probe context.

If it is successfully scheduled asynchronously, holding the lock blocks a hot
removal, which might be the only thing that can unblock the nvme reset_work
from forward progress.

If you are encountering a nvme_reset_prepare() condition during scanning, that
might indicate a failure to communicate with the end device. The scan work may
need the error handling to unblock it.

> @@ -3154,7 +3159,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
>  
> -	nvme_reset_ctrl(&dev->ctrl);
>  	async_schedule(nvme_async_probe, dev);
>  
>  	return 0;
> -- 
> 2.31.1
> 

