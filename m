Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBA0C3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 14:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ASfkjhx9KdFTa+bzG8zGNewGt4CwlTbAimp1urjO6Rk=; b=35N3zap0EqxOlx3Haa/TpHz0hO
	fMnINdlsZPvX82J6IUf/e08533d91TuEItpPXA4lvn1ZuWtIgRXratrVTmFKtIkIs8bg3QsW0Wvx6
	Nu5rANC094iqH6eZ4YcyFfyw8kUdP3/5Kp5udh0+UOHMALWhHBtUCl59D8yHzdjDsC45zTqISujjz
	EfKuNb7TipA2aAbXnEpQrKEqYi98OTXkNFs/sO4nmFNseCUDOEZe9Kx9SziY2ksRxGagSMBfwNEZH
	6hePNaWe868njHun/7ybURaPWUlJfqjJ5vYogutkcq2EeeBAa+Wq8p/OpxohZ0KwIE3hiZ6Wm8xT5
	emOA9kTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Lyp-000000099O3-3UDA;
	Thu, 03 Apr 2025 14:55:43 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Lym-000000099N7-26LW
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 14:55:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DF462A43576;
	Thu,  3 Apr 2025 14:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5F8C4CEE3;
	Thu,  3 Apr 2025 14:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743692139;
	bh=/+qfTXZmdCfvURwjOdlXOqTKDGZIL/6rtVburjnRnF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2g03hZpjK8zaNUvU3fi+/hjxxYxyrNqXV4zEe3TmvLg0rqfqDUOGbty8d3qpQUfB
	 AKvO6ZfgvpgrYh8g+vf3+UVkNtn+hyFa1YJXpHax60iLbZRmx6AGjA90T84N0ULudJ
	 leqv+qPnLCT2xfQfzC5jj4J9q41K00M/E3MULcVAjrRnllOR0sOXigmipJDVDTvLN1
	 BCGTQ6W5AnZR45M5ubOgORb0D9A5TbaP1UOyctE3vAs7eoL1TkfTYwVJSp7tr8waEi
	 qt+MVYrrS46NH5CNscPuQT5HcGLx3ocXwWKuPU+b4X7xVaVvCZlC1du2/LNd01xoz0
	 0Z4CPvCZgUt9A==
Date: Thu, 3 Apr 2025 08:55:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: re-read ANA log page after ns scan completes
Message-ID: <Z-6haRYmf7PMn3vW@kbusch-mbp>
References: <20250403071930.52154-1-hare@kernel.org>
 <20250403071930.52154-3-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403071930.52154-3-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_075540_601083_1F2C633F 
X-CRM114-Status: GOOD (  18.03  )
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

On Thu, Apr 03, 2025 at 09:19:30AM +0200, Hannes Reinecke wrote:
> When scanning for new namespaces we might have missed an ANA AEN,
> so we should always re-read the ANA log page after scanning to ensure
> we don't miss updates there.

Worst case we might check a log page that hasn't changed. Rescans should
be rare, so I guess it's fine. But I'm not sure why scanning might cause
an ANA AEN to be missed. ?
 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  drivers/nvme/host/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 70f9c2d2b113..6197de34c3c8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4296,6 +4296,11 @@ static void nvme_scan_work(struct work_struct *work)
>  	/* Requeue if we have missed AENs */
>  	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
>  		nvme_queue_scan(ctrl);
> +#if CONFIG_NVME_MULTIPATH
> +	else
> +		/* Re-read the ANA log page to not miss updates */
> +		queue_work(nvme_wq, &ctrl->ana_work);
> +#endif

