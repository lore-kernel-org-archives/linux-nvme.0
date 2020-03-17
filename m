Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1CCC10F29
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 12:53:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD59205ED
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 12:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iLxkLonp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD59205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NKasvokgpoia60SxOmgirdR3jFOANVEoQxbRdpUVNxI=; b=iLxkLonpnZyoj1
	DyzE7uYIYOf08GtkQxmerPqMXu+4oxeZDkIL6Nix+4Gunbi+VJmg32Mnw1PPrYHnDloK2Yd0H7JMB
	eIVcRzJ6/omK8OXfT/LsYK+2idXHqGiOKnGWICHkdxy88EY11koHU3/bHO83c0La78u71rLBgZvZZ
	Y+x01MyZqYOXEUjHm6AkOnSovyEDLEYrACGCxvU3qnIGwgbPnXP8zdulSOy1qNMS90wSDCwrqkyr9
	R3KfU8NbRucC19LPC2I6ikPCWFfubFUcE74zyMqjuWv7/WjT997wxpu/eRP9dKI4/KXY3mGYvCXI1
	I9ikCGfKr8nRDA5zIdVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEBiT-00019X-P4; Tue, 17 Mar 2020 12:53:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEBiQ-000183-OD
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 12:53:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3DE9868BFE; Tue, 17 Mar 2020 13:53:00 +0100 (CET)
Date: Tue, 17 Mar 2020 13:52:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Israel Rukshin <israelr@mellanox.com>
Subject: Re: [PATCH 1/4] nvme-rdma: Fix warning at nvme_rdma_setup_ctrl
Message-ID: <20200317125259.GE12316@lst.de>
References: <1583938849-5787-1-git-send-email-israelr@mellanox.com>
 <1583938849-5787-2-git-send-email-israelr@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1583938849-5787-2-git-send-email-israelr@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_055302_937057_3C937282 
X-CRM114-Status: GOOD (  15.14  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>, Sagi Grimberg <sagi@grimberg.me>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 11, 2020 at 05:00:46PM +0200, Israel Rukshin wrote:
> The transition to LIVE state should not fail in case of a new controller.
> Moving to DELETING state before nvme_rdma_create_ctrl() takes a refcount
> on the controller may leads to controller use after free.
> 
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>  drivers/nvme/host/rdma.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index d6022fa..57f9031 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1084,8 +1084,12 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
>  
>  	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
>  	if (!changed) {
> -		/* state change failure is ok if we're in DELETING state */
> -		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING);
> +		/*
> +		 * state change failure is ok if we're in DELETING state,
> +		 * unless we're during creation of a new controller to
> +		 * avoid use after free (ctrl refcount is not taken yet).
> +		 */
> +		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING || new);

Please split this into two WARN_ON_ONCE so that the trace shows which
condition triggered.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
