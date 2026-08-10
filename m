Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10667C5AD55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 22:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5OgkjKgLC7++bkYR5GWeiHzX6pB/0gt4D0jZIGYexck=; b=mXT8kvUUHQfMhFH1gIUScmk42r
	iVjnIWeg9ZVBE/G15wUX2tEaZp40jznGVJjzVLz3DhXXlm8baEraSElOnGUVgueNh3ZQ8wbytv2/T
	DChEOlIKfAbES5u4bXLaFIcymZSmKS1WMY8w4QmPLAxg6EsNH/n48AT+K/8ijeMH0PT5YYNcwBDw0
	zC9RixaWNx2l4emVpFzvzPY6k8lOf4Fjrx/1xnRAhqGCIOOw7xVex47v62qJYmbjKy56BcMI5/qaY
	QwTD3DwiCs1+ghHaUMzBANCIg190oakYaRMCzxjlId8OIfsDdXlIOuO3qvUGvoQbJ344gcxMvqbd3
	EprXfUgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtYrk-0000000CzY5-408U;
	Mon, 10 Aug 2026 22:53:08 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtYrh-0000000CzXj-2V19
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 22:53:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AADE9600AA;
	Mon, 10 Aug 2026 22:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281FA1F000E9;
	Mon, 10 Aug 2026 22:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786402384;
	bh=5OgkjKgLC7++bkYR5GWeiHzX6pB/0gt4D0jZIGYexck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OKgx3lqn3OoBpScVmie8EeWIbLuL4hOPfEyenQ9mJG2vQIvJJn7YepEzwsBg10vm9
	 Aw2oUWf3ny3DWoJzr29QQh0S22UQDgoHpoGzGaEuwLDKaOq4aQM/xGHOwPCJrv6gs9
	 XVaDblIUx3vE2wCIZOnvzWZivHH7xvn3X/wBsPk/cgn6xIcIRqQ/5wlKvYaDZGSMnE
	 1owGIIfYS+WbW97e+k4fiQQSRZd3yy+z2FPu0fv68QoYtzSIWcGfLEUCvTwPEdXClr
	 WLpRo/PzFI6nrmj+qWAZ0n+LrCjIgIZdy9SYp4yf9jygMl/YceHMD13ksVDAYyEGbf
	 RKDf6ukFQxmmQ==
Date: Mon, 10 Aug 2026 16:53:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3] nvmet: pci-epf: fix use-after-free in
 nvmet_pci_epf_exec_iod_work()
Message-ID: <anpWThk0l_i0CpK4@kbusch-mbp>
References: <20260730061839.75338-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730061839.75338-1-shinichiro.kawasaki@wdc.com>
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

On Thu, Jul 30, 2026 at 03:18:39PM +0900, Shin'ichiro Kawasaki wrote:
> nvmet_pci_epf_exec_iod_work() submits an I/O command with req->execute()
> and then waits for the command to complete and transfers the data back
> to the host. This wait is not needed for commands that do not transfer
> data from the device to the host. To decide whether that wait is needed,
> it reads iod->data_len and iod->dma_dir after calling req->execute().

Thanks, applied to nvme-7.3.

