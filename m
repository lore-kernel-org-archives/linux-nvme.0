Return-Path: <SRS0=X9H7=XW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F55C4360C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 21:37:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C82C62075D
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 21:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VeESX8Ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82C62075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E8BoJ4JRAci6WLEE5DRlra7m9Gl5sPGZJ7Vadc7nkAM=; b=VeESX8IhjtFSKz
	URUaa4Lq3i8QX/Qgfb/4JdY7XNlRgTZwwkgZwhmhyfWmsN1xTdLverRQbfcRbw9k0zhlkcBXOhSud
	Hfyl0uiDahZ5xeCF3v61l7GQW16AsddSP2bFNvLRmnWjG80mx5JbQAw/oOcRPQ6U1sec0SA7PsyTG
	kCxish2yt+R+mS4OTyJfpQGbXekKGfaZ6qLppdhyIYOn6zgsReB1xc87IeDgh2Dy43kZfSZVr+3M3
	RIsFyTUaPaKXwhOVvZ1lWmBIPN3ebB0DtR7nKt+F45lyGKiM+5m2yxOmjSoon/VfyfBWqpPdCKEY8
	oJnglNi71S49R+B1TqKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDxvS-0003Aj-QF; Fri, 27 Sep 2019 21:37:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDxvQ-0003AQ-Gw
 for linux-nvme@lists.infradead.org; Fri, 27 Sep 2019 21:37:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C358E68B05; Fri, 27 Sep 2019 23:37:13 +0200 (CEST)
Date: Fri, 27 Sep 2019 23:37:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org
Subject: Re: [PATCHv2 4/6] nvme: Introduce nvme_reset_continue
Message-ID: <20190927213713.GJ16819@lst.de>
References: <20190919213431.7864-1-kbusch@kernel.org>
 <20190919213431.7864-5-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190919213431.7864-5-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190927_143716_709477_31C95DCC 
X-CRM114-Status: GOOD (  16.51  )
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
Cc: James Smart <james.smart@broadcom.com>,
 Edmund Nadolski <edmund.nadolski@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 20, 2019 at 06:34:29AM +0900, kbusch@kernel.org wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> There are times we need to reset the controller in two parts where the
> initialization happens in a different context than the disabling. We need
> to be able to set the state to RESETTING first in order to prevent another
> reset from scheduling while performing a critical section that handles
> the disable part. Introduce a new helpwer function, nvme_reset_continue()
> that can be called from such contexts after they've set the controller
> state to RESETTING.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c | 12 ++++++++++--
>  drivers/nvme/host/nvme.h |  1 +
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e03b1765fc01..95b74d020506 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -117,14 +117,22 @@ static void nvme_queue_scan(struct nvme_ctrl *ctrl)
>  		queue_work(nvme_wq, &ctrl->scan_work);
>  }
>  
> -int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
> +int nvme_reset_continue(struct nvme_ctrl *ctrl)
>  {
> -	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +	if (ctrl->state != NVME_CTRL_RESETTING)
>  		return -EBUSY;
>  	if (!queue_work(nvme_reset_wq, &ctrl->reset_work))
>  		return -EBUSY;
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(nvme_reset_continue);
> +
> +int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
> +{
> +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +		return -EBUSY;
> +	return nvme_reset_continue(ctrl);
> +}
>  EXPORT_SYMBOL_GPL(nvme_reset_ctrl);

I'd prefer to still open code the queue_work in nvme_reset_ctrl.
It is one extra line but a little easier to read.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
