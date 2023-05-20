Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD81CC77B7A
	for <linux-nvme@archiver.kernel.org>; Sat, 20 May 2023 04:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fgyO6ABBabQz05V/bFEnHHOqWYN1C0Gzpdw+0q7AG0I=; b=HZ3szqYmV0lt/+9Xi/KsTLpN5C
	p7rRtZK0O4X8NQHtKwkHGLTbaABaB0t6j3wczigshwjQv8OoTmlZKd4ZO7V71GuaRxo9aCbD7wcYI
	DePHAW8PN1nA3JaOVw9XzLZK5l2x/wDHPdp13ra5H580cHV46XzDRhfW20cPbjt9BktA50HUHlknI
	C/eSRc4xsOKIfeAPLr653AH6YoftnX23sdKGCGNJwOZCi8nKCNzunE2vtLFGqxDOSQvLgqK+0z3pf
	9sKPhwwSHLMmf6o11dJjTfkglB2U+eZSCFJ6KKbHeNWUncedbW/rzMfyk86Kf9UTiGTT7AuAATVa3
	uP0QDmrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0EKZ-000gt3-2f;
	Sat, 20 May 2023 04:36:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0EKX-000gsW-1Z
	for linux-nvme@lists.infradead.org;
	Sat, 20 May 2023 04:36:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2187068CFE; Sat, 20 May 2023 06:36:30 +0200 (CEST)
Date: Sat, 20 May 2023 06:36:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 3/3] nvme: improve handling of long keep alives
Message-ID: <20230520043629.GF31780@lst.de>
References: <20230518183311.3224326-1-ushankar@purestorage.com> <20230518183311.3224326-4-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230518183311.3224326-4-ushankar@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230519_213633_679888_0BA55C9C 
X-CRM114-Status: GOOD (  24.97  )
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

On Thu, May 18, 2023 at 12:33:11PM -0600, Uday Shankar wrote:
> Upon keep alive completion, nvme_keep_alive_work is scheduled with the
> same delay every time. If keep alive commands are completing slowly,
> this may cause a keep alive timeout. The following trace illustrates the
> issue, taking KATO = 8 and TBKAS off for simplicity:
> 
> 1. t = 0: run nvme_keep_alive_work, send keep alive
> 2. t = ε: keep alive reaches controller, controller restarts its keep
>           alive timer
> 3. t = 4: host receives keep alive completion, schedules
>           nvme_keep_alive_work with delay 4
> 4. t = 8: run nvme_keep_alive_work, send keep alive
> 
> Here, a keep alive having RTT of 4 causes a delay of at least 8 - ε
> between the controller receiving successive keep alives. With ε small,
> the controller is likely to detect a keep alive timeout.
> 
> Fix this by calculating the RTT of the keep alive command, and adjusting
> the scheduling delay of the next keep alive work accordingly.
> 
> Reported-by: Costa Sapuntzakis <costa@purestorage.com>
> Reported-by: Randy Jennings <randyj@purestorage.com>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/core.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a31c04b5f849..ce07218fc6eb 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1172,10 +1172,15 @@ EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, NVME_TARGET_PASSTHRU);
>   * frequency, as one command completion can postpone sending a keep alive
>   * command by up to twice the delay between runs.
>   */
> +static unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
> +{
> +	return (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) ?
> +		(ctrl->kato * HZ / 4) : (ctrl->kato * HZ / 2);
> +}

Please add this separate helper in patch 1 already instead of moving
things around.  Preferably in the style I mentioned there.

>  static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
>  {
> -	unsigned long delay = (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) ?
> -		ctrl->kato * HZ / 4 : ctrl->kato * HZ / 2;
> +	unsigned long delay = nvme_keep_alive_work_period(ctrl);
>  	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);

.. and with this helper we don't really need the local variable here.

> +	/* Subtract off the keepalive RTT so nvme_keep_alive_work runs
> +	 * at the desired frequency. */

The kernel comment style is:

	/*
	 * Subtract off the keepalive RTT so nvme_keep_alive_work runs
	 * at the desired frequency.
	 */

