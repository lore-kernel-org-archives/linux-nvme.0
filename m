Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080BDC43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 16:31:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C4520721
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 16:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XTCYZMN/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsVGV+vy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C4520721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d/8YJS6Wa29jJ45PNQvQn9NnZ1lunMibgT7C1CDcD0s=; b=XTCYZMN/IamcI7
	LK4hPQVl3klMYjO/RTgylppS4P7Z94cqv+bJwuOVvIBb+Ky+S4y0kClKhoCtThf4jJ3KqzDka2rLC
	eLPxl057VJHmbmerX9ClXxNmD991yFM3tGTjdDKTRJSngTSg/RdETZrtxNuksHPSrCjgN0PO+3Zyc
	fm1fwVfbhqKGa3d0F+8QjyUvx+stx/L2qOH3/yZZt8L3yohWg7ZCE6iMdJlpnrMr+ST60rKceJ42m
	1pfjTpW55dgtMldA2Jc+4UGoyx2z7a1pCVA0rxJDH3Es4ecw2ohVGTCb0nVy4XAGBrh/5KmFggSWy
	VcCVd02pmjY12rZ2WcfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jK2kX-0004Fl-84; Thu, 02 Apr 2020 16:31:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jK2kU-0004Ez-TT
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 16:31:24 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D6FDF20721;
 Thu,  2 Apr 2020 16:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585845082;
 bh=CkYBqaz1lihK0zLoPwqZ1ZQQF2QWTkkJN02m2yhL93o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dsVGV+vyafjRJf70t8ZNiQxnra9N+g/wlKATrwALt7GCtTKwqj+Cw9xSRcHLo8HJ4
 jvZtVG/KLMlt888eKTgbqLsSoLO12jMMn1fHk4KTAPjjG+6H9/WxA6ViqxqKtVU0YX
 8VvRIVUHN4c92FHNd6o+2sZI9A/JyuGjEpvZioC0=
Date: Fri, 3 Apr 2020 01:31:15 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: fix deadlock caused by ana update wrong locking
Message-ID: <20200402163115.GA3977@redsun51.ssa.fujisawa.hgst.com>
References: <20200402161813.16244-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200402161813.16244-1-sagi@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_093122_972174_A6623CA2 
X-CRM114-Status: GOOD (  19.36  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 02, 2020 at 09:18:13AM -0700, Sagi Grimberg wrote:
> The deadlock combines 4 flows in parallel:
> - ns scanning (triggered from reconnect)
> - request timeout
> - ANA update (triggered from reconnect)
> - I/O coming into the mpath device
> 
> (1) ns scanning triggers disk revalidation -> update disk info ->
>     freeze queue -> but blocked, due to (2)
> 
> (2) timeout handler reference the g_usage_counter - > but blocks in
>     the transport .timeout() handler, due to (3)
> 
> (3) the transport timeout handler (indirectly) calls nvme_stop_queue() ->
>     which takes the (down_read) namespaces_rwsem - > but blocks, due to (4)
> 
> (4) ANA update takes the (down_write) namespaces_rwsem -> calls
>     nvme_mpath_set_live() -> which synchronize the ns_head srcu
>     (see commit 504db087aacc) -> but blocks, due to (5)
> 
> (5) I/O came into nvme_mpath_make_request -> took srcu_read_lock ->
>     direct_make_request > blk_queue_enter -> but blocked, due to (1)
> 
> ==> the request queue is under freeze -> deadlock.
> 
> The fix is making ANA update take a read lock as the namespaces list
> is not manipulated, it is just the ns and ns->head (which is protected
> with the ns->head lock.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Patch looks good to me,

Reviewed-by: Keith Busch <kbusch@kernel.org>

I think this could be a stable candidate, so may want to include a fixes
tag:

  Fixes: 0d0b660f214dc ("nvme: add ANA support")

> ---
>  drivers/nvme/host/multipath.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 61bf87592570..54603bd3e02d 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -510,7 +510,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
>  	if (!nr_nsids)
>  		return 0;
>  
> -	down_write(&ctrl->namespaces_rwsem);
> +	down_read(&ctrl->namespaces_rwsem);
>  	list_for_each_entry(ns, &ctrl->namespaces, list) {
>  		unsigned nsid = le32_to_cpu(desc->nsids[n]);
>  
> @@ -521,7 +521,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
>  		if (++n == nr_nsids)
>  			break;
>  	}
> -	up_write(&ctrl->namespaces_rwsem);
> +	up_read(&ctrl->namespaces_rwsem);
>  	return 0;
>  }

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
