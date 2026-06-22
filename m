Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FFECDB46F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 23:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HZYG4GXnmpO2G+igeeITSVnGZciIA1LOfnIU5Ypmugc=; b=vpn0b8DX1+dzYnjWsGTmSY+Rfk
	BDhjy2kjBAQ5tbsacnR1ODswfGxQWbxDKxytqJZaBndoazOzPIaz0JdhcoNcdVch80ZuBLtKrsqVe
	FK9JLIDGcD5pw+AvHsDEBobQwthLmQmhZrPBRb0yzlzPHc08/iUpv9BZhrhEzMoqCauhU/DrCuYRy
	tV0OHUvFpRrOdgKlfvpNsnOqFxmhzFA15L2KM/+zON5N1vJnGy79qf8sSi63aXxTZqaNzih8em34d
	vS5krnHOkNMi3wd7PNglNqFTOKPQr5fymC3uSyydoaTOa9HboX4AqsWzjUV2N4nNkssQ+QtTakz0v
	WCORGyQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wboH3-00000005TMb-3Zvd;
	Mon, 22 Jun 2026 23:41:53 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wboH2-00000005TMU-3wT7
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 23:41:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 67EEA404F0;
	Mon, 22 Jun 2026 23:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042691F000E9;
	Mon, 22 Jun 2026 23:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782171712;
	bh=HZYG4GXnmpO2G+igeeITSVnGZciIA1LOfnIU5Ypmugc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CqaFWUUr2UDEwA7SC4mQ5oUObXE1jS0+r0UMOZIVG8HQ/A0LKN97dlwmgJzQihkbe
	 pvS32tuy3MLbsrfxIHKY6VzrGzrNkNaG5DMQ7R8vfd6ZjzR28x9PDGRmzAUYUGoqZ3
	 ynDZS/yaV81rm2HeI3QhMm7tpUX0IlhKGC10GwMKFpvh+MzDVIHDapiP1vpeYRGPOt
	 VLpDPaRSwatOyAPX1Hmwc0hr94ZTxJdRdMdFBvXFNriNGa+ZZbGI8rZ1WvXQkYWkqp
	 vLzaEG+PkaIPhSoET+e/wHR+DK8uaPVBX9x5DfSRFBdFE/QzrYDgl1ENaa8LmvWLHj
	 FyxBqO5SVKtQw==
Date: Mon, 22 Jun 2026 17:41:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Steve Wise <larrystevenwise@gmail.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com
Subject: Re: [PATCH v2] nvme-rdma: pin device wrapper in remove_one
Message-ID: <ajnIPsEIdnCZ8WBm@kbusch-mbp>
References: <20260622232131.3718076-1-zzzccc427@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622232131.3718076-1-zzzccc427@gmail.com>
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

On Tue, Jun 23, 2026 at 07:21:31AM +0800, Cen Zhang wrote:
>  static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
>  {
>  	struct nvme_rdma_ctrl *ctrl;
> -	struct nvme_rdma_device *ndev;
> -	bool found = false;
> +	struct nvme_rdma_device *ndev = NULL;
> +	struct nvme_rdma_device *tmp;
>  
>  	mutex_lock(&device_list_mutex);
> -	list_for_each_entry(ndev, &device_list, entry) {
> -		if (ndev->dev == ib_device) {
> -			found = true;
> +	list_for_each_entry(tmp, &device_list, entry) {
> +		if (tmp->dev == ib_device && nvme_rdma_dev_get(tmp)) {
> +			ndev = tmp;
>  			break;

I don't see the point of altering this loop to use a tmp variable.
Please just submit the minimal patch diff that fixes the issue without
introducing unnecessary changes.

>  		}
>  	}
>  	mutex_unlock(&device_list_mutex);
>  
> -	if (!found)
> +	if (!ndev)
>  		return;
>  
>  	/* Delete all controllers using this device */
>  	mutex_lock(&nvme_rdma_ctrl_mutex);
>  	list_for_each_entry(ctrl, &nvme_rdma_ctrl_list, list) {
> -		if (ctrl->device->dev != ib_device)
> +		if (ctrl->device != ndev)
>  			continue;
>  		nvme_delete_ctrl(&ctrl->ctrl);
>  	}
>  	mutex_unlock(&nvme_rdma_ctrl_mutex);
>  
>  	flush_workqueue(nvme_delete_wq);
> +	nvme_rdma_dev_put(ndev);
>  }
>  
>  static struct ib_client nvme_rdma_ib_client = {

