Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D1DC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 17:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J2xrEqi2zZiFTAUMwzC61fFfmL42aGO0gDHUFUZOJsI=; b=GyQtSzX2Ue72aJzg5EZwBsoUf1
	MQG55TCGxJGl850duxaiPq/rxlW0iw46AErj4JnDsQWZuKlJ179LEr4WSr/2SwBbVe+gbKFq+jAH8
	h3twP5Lm1XX+6CuuUxhZ1Rh5HjBrj+4zYmKfp0pESvRBSBqqU33d/R7NgW9HoMLkOXFZQd1ljcbby
	2OhH5MjKWFVQ6RIVfS9mYaUpkWkqlmpRN2l8iFlRdag/7/kceU89mkLJaglpZQ4wCzNl5z97jJuvw
	WNEBUeaThSMhLuMAarPvdGTXD4CMW00xwsYD/JQ09pdQM2z8bCQdOf9b0Mm4KhZI0MGNKtpXCFcK6
	P1JE16KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD8PS-00GhCT-57; Thu, 27 Jan 2022 17:18:10 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD8PM-00GhBR-0h
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 17:18:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2B599B81366;
 Thu, 27 Jan 2022 17:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FF7C340E4;
 Thu, 27 Jan 2022 17:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643303881;
 bh=+2Mo0YGB7fDZ+E4s9fMi6i/zLrfypNOu2W4bQGEnMb8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q1PSHJVJYIojlDmKCWvadIdxU1iWun6Nyhy69ZCEqwOeTA94lzTsz5GcP61l2dxkD
 WnRB195S+vYNkpVF8jk68Xou14wYXeu/q87q6askaI0O1Du0teofejdrCmoqy8VEyv
 OVCe6Kr4pHscub7+zmacO43nKuY7NbEDv20ckWH6LbSl/nFVSxGs2l2Z+B5Y7XFSzV
 9r1EVeW/ylCxm3/1bbCC6NCXL4N0tBJOVl1GLIcugeaMc/YGLXGK1AdMQj/uHNBwHr
 1l2yekBUY9UUT3clblncc7kGkpGaGF+ZiNx5fA1+jxS8iXbakkpw8vS2G7gxSURDz/
 ekvgezUnSADxQ==
Date: Thu, 27 Jan 2022 09:17:58 -0800
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] nvme: Do not reject dynamic controller cntlid
Message-ID: <20220127171758.GB2266713@dhcp-10-100-145-180.wdc.com>
References: <20220127133648.8201-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127133648.8201-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_091804_244661_083159F2 
X-CRM114-Status: GOOD (  14.08  )
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

On Thu, Jan 27, 2022 at 02:36:48PM +0100, Daniel Wagner wrote:
> index dd18861f77c0..918abb54771c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2701,7 +2701,7 @@ static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
>  		if (nvme_state_terminal(tmp))
>  			continue;
>  
> -		if (tmp->cntlid == ctrl->cntlid) {
> +		if (!nvme_ctrl_dynamic(tmp) && tmp->cntlid == ctrl->cntlid) {
>  			dev_err(ctrl->device,
>  				"Duplicate cntlid %u with %s, subsys %s, rejecting\n",
>  				ctrl->cntlid, dev_name(tmp->device),
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a162f6c6da6e..ed75245263f5 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -539,6 +539,11 @@ static inline struct request *nvme_cid_to_rq(struct blk_mq_tags *tags,
>  	return blk_mq_tag_to_rq(tags, nvme_tag_from_cid(command_id));
>  }
>  
> +static inline bool nvme_ctrl_dynamic(struct nvme_ctrl *ctrl)
> +{
> +	return ctrl->cntlid == 0xffff;
> +}

It's probably safe to assume 0xffff is dynamic, but spec suggests we
check ID_CTRL.FCATT bit 0.

