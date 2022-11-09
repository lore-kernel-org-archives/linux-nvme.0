Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6E3C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 17:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d4fLwgzZTG1U86GHEEsQsLyKR8LF0DvBgqMhhAiDwsU=; b=kIM16txXa71IauH+bFKahMOxx0
	e9/zlK67m4uWj98CtoLk9x4c+qNEVxC8g8CjPHHA2eGpKACsAW5+6YiKGrBuRd01LK2iL+UCVyEKr
	+YIoD5bcxWj9zRS37TjXAlIelR8kCeSi5cljbR7PZJ22fkYx0l+RnnftgQVmKZGeBp9ESCYbTwNl3
	5EeMBsHnTv0mWuYuZlLtpyo9AZQsxZdLKXMpjqLQySbZRJ+4sd9KNcaOOB1QGY7ZPtHXpK3uv5p9P
	uv+7WD3lfjxBaP+uRHfWPQoZgb/nNQaBTANwaNK5JGy4OprFc5EC4vM7V3Jb+bKZQ/y1f/v/bZoXY
	aeIYSqsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osobe-00FOoq-3y; Wed, 09 Nov 2022 17:11:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osobN-00FOf9-Us; Wed, 09 Nov 2022 17:11:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2ECE561BF8;
	Wed,  9 Nov 2022 17:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0BDC433C1;
	Wed,  9 Nov 2022 17:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668013860;
	bh=Y/chigTvldaMfDzJBgq7bIq+lAfxioU20iM0wD7rkDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F7nkfAeZE73fdoiE25aprxMIVrfFKXC5d49uJApcdAtr2VERokWrLi/yINwUm87c5
	 DTRLYKArV+NOC+Eu5Ym2ZKZ1zUX09wbiAzquGgj4DhRweYr+Mf3cpv5jXPMhySL969
	 ZwQr60eA1O5L0CTFW8qXk/NTtYSgBW3+YXxImNtCPP8+AdK3TvP7bB9omv/6wm1Y3Z
	 DMYHz1cRBL8rCg8UBQT+y3F82Da9PpC0hnIIxdX0jzFHAjVEsV9IpzEP26UYzwngSO
	 +aFB3u2kjc92c3Wr1PZVWKNXMv/NxmCCVF4dfv23lUf2xUMyWUnjxIvnB6opd/Fr2m
	 ZTDVTKqpQV4NQ==
Date: Wed, 9 Nov 2022 10:10:57 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 12/12] nvme-pci: don't unbind the driver on reset failure
Message-ID: <Y2vfIS5jLXwAjV+s@kbusch-mbp.dhcp.thefacebook.com>
References: <20221108150252.2123727-1-hch@lst.de>
 <20221108150252.2123727-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108150252.2123727-13-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_091102_056296_240CE384 
X-CRM114-Status: GOOD (  13.75  )
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

On Tue, Nov 08, 2022 at 04:02:52PM +0100, Christoph Hellwig wrote:
> -static void nvme_remove_dead_ctrl_work(struct work_struct *work)
> -{
> -	struct nvme_dev *dev = container_of(work, struct nvme_dev, remove_work);
> -	struct pci_dev *pdev = to_pci_dev(dev->dev);
> -
> -	if (pci_get_drvdata(pdev))
> -		device_release_driver(&pdev->dev);
> -	nvme_put_ctrl(&dev->ctrl);
> +	/*
> +	 * Set state to deleting now to avoid blocking nvme_wait_reset(), which
> +	 * may be holding this pci_dev's device lock.
> +	 */
> +	dev_warn(dev->ctrl.device, "Disabling device after reset failure: %d\n",
> +		 result);
> +	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
> +	nvme_dev_disable(dev, false);

I think the shutdown can be set to 'true' now that you're not
immediately unbinding the controller. That will unblock any queued IO
that would have been flushed out during the unbind.

