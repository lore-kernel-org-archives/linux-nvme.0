Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4672EC04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 18:31:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D781161413
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 18:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D781161413
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0mrqr6pKanoZLpCUATUe6mXXHzQUk8WxVknvt/oNRI8=; b=kBC0iimrq4ukCJ
	Zp/yXKf2bKJ0Oek7xnobh+aWSQUbZo/BCId2UNMTER2/Vfh5n6z1CO9EcdbLfVRBLA2Gk3MNbE2CM
	9PuvULG5iDhzRK4kpP70NVhoTco6HpCXXS6a7QzYrs3h5+rIVQO7VQLE6WtNOdoBrG01jrX6+Yp7w
	5W7YE84SwuF5eF6ZbU0xjXRDj2CE9x8Q1A+6+gZTvbmRuE9rWSMjQNW+tFOnqTxEQrpPIyWU0U65W
	k5gnLx5edVL2CFozb3e5l68UTdJcTnHq5fo/WYj05wpxZYNLBfbXpLCj+E9wA92IuQ+X9Oft8URMN
	Kb3PFvV/9B2TvtRWIy7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llFMd-001T8N-2r; Mon, 24 May 2021 18:31:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ll5Zf-000lLU-Iy
 for linux-nvme@lists.infradead.org; Mon, 24 May 2021 08:04:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AAB8667373; Mon, 24 May 2021 10:04:28 +0200 (CEST)
Date: Mon, 24 May 2021 10:04:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org,
 Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv3 4/4] nvme: use return value from blk_execute_rq()
Message-ID: <20210524080428.GA24488@lst.de>
References: <20210521202145.3674904-1-kbusch@kernel.org>
 <20210521202145.3674904-5-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210521202145.3674904-5-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210524_010431_795079_B2825280 
X-CRM114-Status: GOOD (  16.38  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +/*
> + * Return values:
> + * 0:  success
> + * >0: nvme controller's cqe status response
> + * <0: kernel error in lieu of controller response
> + */

For better reading flow I'd reformat this as:

/*
 * Return value:
 *   0:	success
 * > 0:	nvme controller's cqe status response
 * < 0: kernel error in lieu of controller response
 */

> +static int nvme_passthrough_status(struct request *rq, blk_status_t status)
> +{
> +	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
> +		return -EINTR;
> +	else if (nvme_req(rq)->status)
> +		return nvme_req(rq)->status;
> +	return blk_status_to_errno(status);
> +}

I find this a little odd disconnected from the actual execure call.
What about a helper like this instead:

static int nvme_execute_rq(struct gendisk *disk, struct request *rq,
		bool at_head)
{
	blk_status_t status;

	status = blk_execute_rq(disk, req, at_head);
	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
		return -EINTR;
	if (nvme_req(rq)->status)
		return nvme_req(rq)->status;
	return blk_status_to_errno(status);
}

> -	nvme_execute_passthru_rq(rq);
> +	status = nvme_execute_passthru_rq(rq);
>  
> -	status = nvme_req(rq)->status;
>  	if (status == NVME_SC_SUCCESS &&
>  	    req->cmd->common.opcode == nvme_admin_identify) {
>  		switch (req->cmd->identify.cns) {
> @@ -168,7 +167,8 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
>  			nvmet_passthru_override_id_ns(req);
>  			break;
>  		}
> -	}
> +	} else if (status < 0)
> +		status = NVME_SC_INTERNAL;

Don't we need a better translation here?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
