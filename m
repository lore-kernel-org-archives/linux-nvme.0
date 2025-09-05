Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97444CA1013
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Sep 2025 00:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=31SiBJbfjJQlxtrKlMB5RmTjjlxDwEImi8Y+uTIc3N8=; b=VoAZJrZ1wjVIK5gFLWXCnkPOYl
	BJ+qnKrb1JNvbnPOWS3STIjL8mh/gMBBygPQlkJnAVdTmJcFxURpfIYxmg+8nd+gak0lj4gg5Mlr6
	SW0pqOZkX3I4cEJEicBOT9w6KqhaCNWavzxCe5bzZe0qk0JvKEqm8p8M/9hgXjpMctuoZBgi8k4Bu
	JTTfFn2WZA8fPA1vULfHy3KLPCq3Xl7/WQakiVS3c2vVo+NaFVilA7tHL/zuxucKZKkRuXto9YuvK
	I9zSnaKfDd3hWCjnvBkJUWyyI1E5op2LtYwB2tVe365YH27UHS50aEiRxf+G0WLVhmel40+Eo/zpy
	mdT5GW5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uugYp-00000005XZR-2D8p;
	Sat, 06 Sep 2025 00:13:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uueJC-00000004qve-2JBS
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 21:49:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A1BB6601AA;
	Fri,  5 Sep 2025 21:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EA6C4CEF1;
	Fri,  5 Sep 2025 21:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757108965;
	bh=8rqxU2P26RfovZdy3bMvysD1ArZ5IT9wXUXD021PhVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A257DYfjQbLn8wfTw8C2eXsFdJ6qMxlepGDijsenuTfCBmMh+6lBfrHvwZhFiKoet
	 FqcwvCM7JXkR0HGZOM6Aao38PM6VlrBe4UN18BU4qRWseDYFZw0KxPNlIk3fuvqVPn
	 GpttiZeEn7P7zGRh/o6rVYIARhBkyzecDY1NHCpFul4g4fFsbHrI4GQwTRjikAS/bl
	 IfM7s4g+6WtpbKjLpKtp/ULW8dYbcU2w2jpy9Gunkb317iEvocwhp5MZ0hXk7duIHW
	 DyvRSY2vNLBvu1hpd//2Xc/AfUimSUAm/z5Rz6wAVYT1T9ZfzjvvVYqRmYt6Ufj58z
	 36mit388J8cIw==
Date: Fri, 5 Sep 2025 15:49:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	cassel@kernel.org, dlemoal@kernel.org, kamaljit.singh1@wdc.com
Subject: Re: [PATCH v1 1/1] nvme-core: exclude ioccsz/iorcsz checks for admin
 ctrlr
Message-ID: <aLta40FO1Ud6TZ4T@kbusch-mbp>
References: <20250905211002.1937414-1-kamaljit.singh@opensource.wdc.com>
 <20250905211002.1937414-2-kamaljit.singh@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905211002.1937414-2-kamaljit.singh@opensource.wdc.com>
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

On Fri, Sep 05, 2025 at 02:10:01PM -0700, Kamaljit Singh wrote:
> An administrative controller does not support I/O queues, hence it
> should exclude existing checks for IOCCSZ/IORCSZ.
> 
> Signed-off-by: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
> ---
>  drivers/nvme/host/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d67545bd7abb..ac72bae800a9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3491,14 +3491,14 @@ static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ct
>  		return -EINVAL;
>  	}
>  
> -	if (!nvme_discovery_ctrl(ctrl) && ctrl->ioccsz < 4) {
> +	if (!nvmf_discovery_ctrl(ctrl) && !nvme_admin_ctrl(ctrl) && ctrl->ioccsz < 4) {
>  		dev_err(ctrl->device,
>  			"I/O queue command capsule supported size %d < 4\n",
>  			ctrl->ioccsz);
>  		return -EINVAL;
>  	}
>  
> -	if (!nvme_discovery_ctrl(ctrl) && ctrl->iorcsz < 1) {
> +	if (!nvmf_discovery_ctrl(ctrl) && !nvme_admin_ctrl(ctrl) && ctrl->iorcsz < 1) {

Excessive line length over 80 chars.

Perhaps, though, we should have a helper to indicate IO controllers
rather than chaining conditions for everything that isn't one.

