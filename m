Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDB9C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 05:45:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D6D920786
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 05:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PqrnNLSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6D920786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1636yjmHoiIZ11h/rqgOw4Y0c2RjU6J7sCdZalWhdY4=; b=PqrnNLSImKcu+IQTwrhdv56wN
	H1quTRnK4AqQz/jyPIVz3VByC6K9DXFGYlpyH2SPVjT1xjkndkWYC+lFCETxg29PcnY0/lDUgmWX6
	yxhAo9GzGiOSbOjx6KWDYqP2DpyDSXvWM3K/xjCQ0khCJZZkVl44SkRb/V1rXvhHaqgLQZ7sWQ1cs
	uyg3763KnpciG62kJIRpEotJCVMYBaH8gwOf9zS+Y86BcaGXAi+FlsRe2icS0HVRhlar+jB4upFgm
	kLnwUcsJVOf1+DYDr9ANprrfiIY4glRAZogMpjlczmhtMCc+xZUoOO+P1zOV29KPCNGBZ+IO7nfj6
	3p52uqJyg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0etn-0007QP-BW; Wed, 29 Jul 2020 05:45:07 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0etk-0007Pt-Hj
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 05:45:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4647B68B05; Wed, 29 Jul 2020 07:45:00 +0200 (CEST)
Date: Wed, 29 Jul 2020 07:45:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-fabrics: allow to queue requests for live queues
Message-ID: <20200729054500.GA31113@lst.de>
References: <20200728053523.21657-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200728053523.21657-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_014504_751486_383DBEDE 
X-CRM114-Status: GOOD (  25.05  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Dropped from nvme-5.9 to wait to the discussion to finish as I want
to send a PR to Jens today..

On Mon, Jul 27, 2020 at 10:35:23PM -0700, Sagi Grimberg wrote:
> Right now we are failing requests based on the controller
> state (which is checked inline in nvmf_check_ready) however
> we should definitely accept requests if the queue is live.
> 
> When entering controller reset, we transition the controller
> into NVME_CTRL_RESETTING, and then return BLK_STS_RESOURCE for
> non-mpath requests (have blk_noretry_request set).
> 
> This is also the case for NVME_REQ_USER for some reason, but
> there shouldn't be any reason for us to reject this I/O in a
> controller reset.
> 
> In a non-mpath setup, this means that the requests will simply
> be requeued over and over forever not allowing the q_usage_counter
> to drop its final reference, causing controller reset to hang
> if running concurrently with heavy I/O.
> 
> While we are at it, remove the redundant NVME_CTRL_NEW case, which
> should never see any I/O as it must first transition to
> NVME_CTRL_CONNECTING.
> 
> Fixes: 35897b920c8a ("nvme-fabrics: fix and refine state checks in __nvmf_check_ready")
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/fabrics.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 4ec4829d6233..2e7838f42e36 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -564,21 +564,13 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
>  {
>  	struct nvme_request *req = nvme_req(rq);
>  
> -	/*
> -	 * If we are in some state of setup or teardown only allow
> -	 * internally generated commands.
> -	 */
> -	if (!blk_rq_is_passthrough(rq) || (req->flags & NVME_REQ_USERCMD))
> -		return false;
> -
>  	/*
>  	 * Only allow commands on a live queue, except for the connect command,
>  	 * which is require to set the queue live in the appropinquate states.
>  	 */
>  	switch (ctrl->state) {
> -	case NVME_CTRL_NEW:
>  	case NVME_CTRL_CONNECTING:
> -		if (nvme_is_fabrics(req->cmd) &&
> +		if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(req->cmd) &&
>  		    req->cmd->fabrics.fctype == nvme_fabrics_type_connect)
>  			return true;
>  		break;
> -- 
> 2.25.1
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
