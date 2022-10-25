Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EC9FA373E
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 18:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vPXClyTeMGX4Z/vTJCu2NApOLA9AIJJHyrKTG9TkEec=; b=ioFrEQGB4QHlE3V0UFvFRaJzaw
	RW2baJq5iKTVT+m8aUZWcAROUuYnl5NvD0ZhfAcqIqYR9EbKmJjZjfQqoMo7HR4QRnFsoDD99ca6v
	zPGNzyKpxO0KdDeTh9YGcXu2UKi3c7O2Kerdo0uNO195F0SbvGbDJ/ciqdXjy5HrlmeGjh0TtGvfb
	aBkZztnEM6GEkQ7dVJj6dO3NAUHCD7MdTQc3uE5XK2xI5IzoE0bKVPnkH2M5zrtLWEzWq2khqdblv
	asivqWcfNf/Cd+Wp0B8Sp4hjjGcD1umLEFhYlQtyGxCzg8XcQGQxEbTAB6b97JJ0aEnpqs33ClKsN
	hIi2zFHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onP3v-006jtx-Iw; Tue, 25 Oct 2022 18:54:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onP3K-006jVv-1o
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 18:53:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 91F7661AE1;
	Tue, 25 Oct 2022 18:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642C3C433D6;
	Tue, 25 Oct 2022 18:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666724007;
	bh=qXItz4lSkGiD7gbYePH9XLDF1DbJ3bgBrxUqFEb6QAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fziRdPhqJQ06KZ0kiP0MS1nP+VvYfrrK3tA+Jq9uxyTDyN6KptCBDwXFa/vBhIx7N
	 bz63Yugw2OmcNyfwl+eyNtbg0uRxL/ExRdmdjSBh94+rijLiKUNJfllsshoAozYDGZ
	 QIiRuupR3aMV+He1t7suNLfcfBaVgLCtYAtaF1NizClR//7NprqUrWQbBwHDcRtHV2
	 QWk0cgAkYCpPtxHSLfXO2JMPR1U3Cfxm/L9QRBhnloszp61LKgvyd1Oa85aHf+6Cef
	 8W6oADV6X8dBz1gH06UFNrK5+VfJAnQ2LwpMdIm3TwgLZ42LZiS3vNru5k0fqCGw+c
	 ovkOZyQEf5GpQ==
Date: Tue, 25 Oct 2022 12:53:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 10/17] nvme-pci: mark the namespaces dead earlier in
 nvme_remove
Message-ID: <Y1gwo69pYet8hzt1@kbusch-mbp.dhcp.thefacebook.com>
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025144020.260458-11-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_115330_195672_824D8E43 
X-CRM114-Status: GOOD (  23.35  )
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

On Tue, Oct 25, 2022 at 07:40:13AM -0700, Christoph Hellwig wrote:
> When we have a non-present controller there is no reason to wait in
> marking the namespaces dead, so do it ASAP.  Also remove the superflous
> call to nvme_start_queues as nvme_dev_disable already did that for us.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8ab54857cfd50..bef98f6e1396c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3244,25 +3244,19 @@ static void nvme_remove(struct pci_dev *pdev)
>  	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
>  	pci_set_drvdata(pdev, NULL);
>  
> +	/*
> +	 * Mark the namespaces dead as we can't flush the data, and disable the
> +	 * controller ASAP as we can't shut it down properly if it was surprise
> +	 * removed.
> +	 */
>  	if (!pci_device_is_present(pdev)) {
>  		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
> +		nvme_mark_namespaces_dead(&dev->ctrl);
>  		nvme_dev_disable(dev, true);
>  	}

Ah, this changes what I mentioned about 4. Flushing the scan_work prior
to nvme_mark_namespaces_dead() still looks the right thing to do, but I
think you have to do both after nvme_dev_disable().

