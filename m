Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A3CEB64DD
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 16:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wFIa02dSxe4HWO9N2KF/2yXsSSwzjA6pJazaULHxG1Y=; b=yyqRV/rHgfR80ns7cP13VDxC/S
	1nj9l1iF4sf238GtZoiNqtS0nNIRiQ56jQEd4Zf+smJMYw0W8jEXv7HdEh2KDaEN2ixNnSQT+fJcf
	q9jhgxLx63dqgV3zq/3bRV/9tR+tuXnyL3dRLpT7S9cy2GqAnHuz4Q+vz5ANhoXJNKC5YRAm8p4K2
	soYWlZ8+JMxls1bGfDBN+enFlabPHMgObHStQ8p6vv9co16mCVoPIzEBOA2FbFAO4rqHbedySh6Mi
	kw+jw6kkCiXMeWCoUEZMcDlTczYcGuASps8raUs7ewCSZ/qmLttyCP+YMoBEWv72y3kQrSpza1hNw
	CjWw5kGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJcTB-000UUq-36;
	Wed, 12 Jul 2023 16:13:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJcT9-000USx-0M
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 16:13:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DF40B67373; Wed, 12 Jul 2023 18:13:27 +0200 (CEST)
Date: Wed, 12 Jul 2023 18:13:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv2] nvme: ensure disabling pairs with unquiesce
Message-ID: <20230712161327.GB28835@lst.de>
References: <20230712154004.360561-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712154004.360561-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_091335_292122_F7FBAAEF 
X-CRM114-Status: GOOD (  18.02  )
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

On Wed, Jul 12, 2023 at 08:40:04AM -0700, Keith Busch wrote:
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1298,9 +1298,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
>  	 */
>  	if (nvme_should_reset(dev, csts)) {
>  		nvme_warn_reset(dev, csts);
> -		nvme_dev_disable(dev, false);
> -		nvme_reset_ctrl(&dev->ctrl);
> -		return BLK_EH_DONE;
> +		goto disable;
>  	}
>  
>  	/*
> @@ -1351,10 +1349,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
>  			 "I/O %d QID %d timeout, reset controller\n",
>  			 req->tag, nvmeq->qid);
>  		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> -		nvme_dev_disable(dev, false);
> -		nvme_reset_ctrl(&dev->ctrl);
> -
> -		return BLK_EH_DONE;
> +		goto disable;
>  	}
>  
>  	if (atomic_dec_return(&dev->ctrl.abort_limit) < 0) {
> @@ -1391,6 +1386,15 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
>  	 * as the device then is in a faulty state.
>  	 */
>  	return BLK_EH_RESET_TIMER;
> +
> +disable:
> +	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
> +		return BLK_EH_DONE;
> +
> +	nvme_dev_disable(dev, false);
> +	if (nvme_try_sched_reset(&dev->ctrl))
> +		nvme_unquiesce_io_queues(&dev->ctrl);
> +	return BLK_EH_DONE;

Just curious, do you remember why we do an explicitnvme_dev_disable
here instead of relying on the one at the beginning of
nvme_dev_disable?  This isn't new, and the patch should not be blocked
on it, but it looks very odd to me an we'll need to either document
it or kill it eventually..

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

