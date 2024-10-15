Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D2ED1D88D
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 17:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kLUZSFH8OoI/8gWYTtGjulkjMEn8rNqluugVat37kew=; b=iCWj9Am2nAGIgDmgDM0m/Ix6Hg
	0a1wYSy80M2p8S8pzBVgW4EEQ4eXWggYwEqWYY60I07vASPq6dDRnP1BDzDnsb70YPWYWGYiNA/n8
	PCjXzuARWxh0JcTTGJ5EL0tK8+dLfR+KypFYTHMXuQx83v/S0ml+xkT12Q5QkA2E4lMzE+Q6QNv5v
	9QYyi5yiLBefSS3p7KC4pq2FUlF7Xj5rokQW181Lxh7BQsfIV/StJPH5QNEbovIrlOYL8ZocI4Cc+
	9RBxvkHn1Ne7gM53Ajk6KYSExve70PGCcPGZ10nIU7PQZGjyPwMuyKONJRlt3DBlLydzWdnbXKkaM
	ztjArmng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0lKW-000000091mr-0Qkk;
	Tue, 15 Oct 2024 17:27:32 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0lKS-000000091lD-2vYo
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 17:27:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7D6C85C565E;
	Tue, 15 Oct 2024 17:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06C4C4CEC6;
	Tue, 15 Oct 2024 17:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729013247;
	bh=hit9w2s2GvXN3KsRTRtrXepZt+oNdWvCOxbSL72RWaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WdogXZz1X0VthiUjKVahL4AgnG0ivG6jyS+YKpPknNthgakwVtM1MmCHAqe+p00DO
	 YC/88+H0h8czsTiiuCyntUCTADyooyhqSlKLTJLjs5R+RGU7ohOS/9ekhznu7i7rCm
	 RBiiOM4VIFMXVrk4aR5z/mD+N4ms503u+A844bT5WXDsrzPZ9Oveeb1npZwgaAYhG3
	 wwOPlq2/AqJt4JoIIgpp036nTUFaX2f7mnAgSZ3ie6FE7baQXja+XeItAJOnJFWlTa
	 8L9toTlIreMuNlAL3maRflJTxz9kWVKzeFKfLh1aXbX4iyevABxqk0mp8VGcwdH5S7
	 t3IRZ5YzY4Cwg==
Date: Tue, 15 Oct 2024 11:27:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvme-pci: fix race condition between reset and
 nvme_dev_disable()
Message-ID: <Zw6l_A742J3iCYLR@kbusch-mbp.dhcp.thefacebook.com>
References: <20241015112100.824193-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015112100.824193-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_102728_801547_696B4266 
X-CRM114-Status: GOOD (  11.57  )
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

On Tue, Oct 15, 2024 at 01:21:00PM +0200, Maurizio Lombardi wrote:
> -static void nvme_pci_update_nr_queues(struct nvme_dev *dev)
> +static bool nvme_pci_update_nr_queues(struct nvme_dev *dev)
>  {
>  	if (!dev->ctrl.tagset) {
>  		nvme_alloc_io_tag_set(&dev->ctrl, &dev->tagset, &nvme_mq_ops,
>  				nvme_pci_nr_maps(dev), sizeof(struct nvme_iod));
> -		return;
> +		return true;
> +	}
> +
> +	/* Give up if we are racing with nvme_dev_disable() */
> +	if (!mutex_trylock(&dev->shutdown_lock))
> +		return false;
> +
> +	/* Check if nvme_dev_disable() has been executed already */
> +	if (!dev->online_queues) {
> +		mutex_unlock(&dev->shutdown_lock);
> +		return false;
>  	}
>  
>  	blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
>  	/* free previously allocated queues that are no longer usable */
>  	nvme_free_queues(dev, dev->online_queues);
> +	mutex_unlock(&dev->shutdown_lock);

I believe mutex_unlock needs to be above blk_mq_update_nr_hw_queues().
That function needs all the queues to be frozen, so any older IO that
times out is going to need this lock in order to reclaim it.

