Return-Path: <SRS0=px+9=5B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7D4C0044D
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Mar 2020 17:48:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ECE220674
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Mar 2020 17:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PyRGr31f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOG8tOnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECE220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pjxZYIqu7EeJfNeyQqgzc0MQ1vGHfWDT+xQSICGXeVw=; b=PyRGr31fYcHB/A
	8qDpEKHRWxYlOMbxPBXiVHd4g+7VwXRGly7GJPDPxC2rYR6jZExvnThAgHH0FdXeff1XQrcOXJXbO
	a5ZVVNxULMiPhzaGupLQb6w3kytH6vSS3R3RrGLdCu6/4lRpMzTQ1vPSNsHDKLuc+hX/o9WqpL5G8
	onON7oXT+7MxOOkJ64MuJ+3tqM5XrqfnBh4DX4+Amc2Cyva6LopTqOFbgH9tzdjj58FkoVPsG7rZu
	sV8g5H5SwlMU3hsvZzHaaf24FcFIMMGnRIj3mzsH/Le71Jiqiw79w21RZ6WFNDfTYomAzUrbn1/L/
	lHxNoCbTz0S3LsxllZEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jDtqi-0006Jf-RR; Mon, 16 Mar 2020 17:48:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jDtqg-0006JA-F6
 for linux-nvme@lists.infradead.org; Mon, 16 Mar 2020 17:48:23 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5BD0E2051A;
 Mon, 16 Mar 2020 17:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584380901;
 bh=D737BLVS9kUBO93MPiLOCR+CONdPt5LgjVuNQFhCxSE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OOG8tOnu/uDaE22RAYrYVkz1uuVkdNk8D5q3+AxUygBvkzQB7sAfGvD6lGfFuzWup
 0PoeqCSOYFZczoM8T13H+fDFkhbpF5bAVl1bqJCztlB2norKAixt5UlfcMfsNtBelS
 BHOZmUHQcwxto79HHEmU+bVhBlucb+TvaeXDW9xQ=
Date: Mon, 16 Mar 2020 10:48:19 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme/fc: use real sqsize as argument when connecting
 queues
Message-ID: <20200316174819.GB1069991@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200313124808.39320-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200313124808.39320-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200316_104822_520773_33C432E8 
X-CRM114-Status: GOOD (  14.91  )
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
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <keith.busch@wdc.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Mar 13, 2020 at 01:48:08PM +0100, Hannes Reinecke wrote:
> When creating queues we should be passing in the real sqsize number,
> and not increasing it by one just so that the function has to
> substract it again.

Kind of makes me wonder: why are we even passing the sq size as a
parameter at all? The 'ctrl' parameter provides the same thing.

Anyway, this looks correct to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/fc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 0cbc4a703359..f76325a47578 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1211,7 +1211,7 @@ nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
>  				sizeof(struct fcnvme_lsdesc_cr_assoc_cmd));
>  
>  	assoc_rqst->assoc_cmd.ersp_ratio = cpu_to_be16(ersp_ratio);
> -	assoc_rqst->assoc_cmd.sqsize = cpu_to_be16(qsize - 1);
> +	assoc_rqst->assoc_cmd.sqsize = cpu_to_be16(qsize);
>  	/* Linux supports only Dynamic controllers */
>  	assoc_rqst->assoc_cmd.cntlid = cpu_to_be16(0xffff);
>  	uuid_copy(&assoc_rqst->assoc_cmd.hostid, &ctrl->ctrl.opts->host->id);
> @@ -1326,7 +1326,7 @@ nvme_fc_connect_queue(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
>  				sizeof(struct fcnvme_lsdesc_cr_conn_cmd));
>  	conn_rqst->connect_cmd.ersp_ratio = cpu_to_be16(ersp_ratio);
>  	conn_rqst->connect_cmd.qid  = cpu_to_be16(queue->qnum);
> -	conn_rqst->connect_cmd.sqsize = cpu_to_be16(qsize - 1);
> +	conn_rqst->connect_cmd.sqsize = cpu_to_be16(qsize);
>  
>  	lsop->queue = queue;
>  	lsreq->rqstaddr = conn_rqst;
> @@ -2484,11 +2484,11 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
>  		goto out_free_tag_set;
>  	}
>  
> -	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> +	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize);
>  	if (ret)
>  		goto out_cleanup_blk_queue;
>  
> -	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> +	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize);
>  	if (ret)
>  		goto out_delete_hw_queues;
>  
> @@ -2539,11 +2539,11 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>  	if (ctrl->ctrl.queue_count == 1)
>  		return 0;
>  
> -	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> +	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize);
>  	if (ret)
>  		goto out_free_io_queues;
>  
> -	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> +	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize);
>  	if (ret)
>  		goto out_delete_hw_queues;
>  
> -- 
> 2.16.4

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
