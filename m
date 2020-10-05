Return-Path: <SRS0=0roG=DM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78831C4363A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 17:39:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C8DB207EA
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 17:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MyJn0AL5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ssu+65g1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8DB207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IJjsDw9FW+7WnQEJNt5AnO9IurUq6xSrJGill6OzRG8=; b=MyJn0AL5F/BdbheB/lmSDz0yu
	5kl3CWSZ+dfOFr2S4A2TNSrQ7Nr7CsYx/S9QBeIcPxzctH3biL2OpLTgsJlIOC9dCIq+6iPJJLse8
	v+B4yuUiHfupYD++FUUS4VK0qDwhrJ79VyxJQg8JIKgvj4sEmOgODJNznMCfsG/FVGTswwbNQJKdv
	WxQLqrVOcgYzKLeQGt/tRqZ7v/RasmhME6wfiKeV5AhJENEbRiw7dc9pfNhZ74Krmawfejac0WUKh
	Xrf/p6WaPId/d3yNu/26vhC/rU0eziAdPOlQ5Vzr+b+vfwTY5vaknQeM7NNup1nuvrm7GNy0kMiMP
	lNuzfs9Dg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPURq-0008EK-Re; Mon, 05 Oct 2020 17:38:54 +0000
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPURi-00088k-PA
 for linux-nvme@lists.infradead.org; Mon, 05 Oct 2020 17:38:48 +0000
Received: by mail-pj1-x1044.google.com with SMTP id x2so220891pjk.0
 for <linux-nvme@lists.infradead.org>; Mon, 05 Oct 2020 10:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to;
 bh=0E/VlnfaaA3mNNRlahbSvsVU717D3p/Ia0n8/rkFl2k=;
 b=Ssu+65g1FSZ+WQ1a13B8Th4u+Ue6vdEe2WYatJfZu67HG4aR99BAlXdFNuVpQhJyCI
 4S69/+iGptUoaqLdgmgbSspOgMLhuXOtgs+/cHteNJGyUDibk7XQMgP6GMK/JxzTpgVJ
 xuFualGuTJ/tBIpemYFvMuw910uY2bUuYNsxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=0E/VlnfaaA3mNNRlahbSvsVU717D3p/Ia0n8/rkFl2k=;
 b=Eg5q/OxRwz7BAI/Pt9OdBCVa2IUSqFOAOBRk4X7vhVa9Ejpv5IAWd/4vJY6sijo4ll
 +6+ASO0ZDmYVzwvMLIpUuEzNVo0nOQs3PJY6xeon7lMdCHoM4v5c2ae/4LvU0ifDcfu8
 fLiBGZW/JgOhScRULLr52IiSxpnIzi3h9g2FrUPWDfa6mlalXeKld9V5/jukumkoZPYn
 RGriidaYwFEyX2h5scsrulykCW9+IxmXoXtcLkBttW3w2kUl0hZGH6Eo9dnht/gx27W0
 R7FatV8TP89Tfp0Z7KxumulC0jFkkF5eSzTBxaHhqNxzK1OAJfxLEPTDP5y98sRoWAxW
 Ffkw==
X-Gm-Message-State: AOAM530cQifXI/lcXmG3RJkPYuLEx9umsYHxSjegCHr+up/iwSnItDPs
 Iuuwkxk8CXjNQvuMPqEMmsSTY6X/xbFypMiXr/RnJQWh12shZy3zgaIebfm//YptWkxdVMlNKCl
 2J09sYVVBsNVJMQ6zEWmrgi3tb4nAEYyfE/okDDOSxngAJIPdVYU9T5/r42TXTL/MsWtWUtcK05
 4JHmfykg7L
X-Google-Smtp-Source: ABdhPJzhioPk5TrhpowLtH7Wyrg8/R21VXBLiD/V+rAnvqCJAZTYrbWdLcY0RxZwJdgXMggU9R7NAA==
X-Received: by 2002:a17:90a:1690:: with SMTP id
 o16mr538876pja.148.1601919523956; 
 Mon, 05 Oct 2020 10:38:43 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id q5sm239267pgh.16.2020.10.05.10.38.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 10:38:43 -0700 (PDT)
Subject: Re: [PATCH 5/7] nvme-fc: use feature flag for virtual LLDD
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200922121501.32851-1-hare@suse.de>
 <20200922121501.32851-6-hare@suse.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <0dc3926c-fd72-8c6d-68c4-c9f231503943@broadcom.com>
Date: Mon, 5 Oct 2020 10:38:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200922121501.32851-6-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_133846_853663_377FAAD9 
X-CRM114-Status: GOOD (  28.96  )
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>
Content-Type: multipart/mixed; boundary="===============6355746521218243534=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============6355746521218243534==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000038c86705b0eff44c"

--00000000000038c86705b0eff44c
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US

On 9/22/2020 5:14 AM, Hannes Reinecke wrote:
> Virtual LLDDs like fcloop don't need to do DMA, but still
> might want to expose a device. So add a new feature flag
> to mark these LLDDs instead of relying on a non-existing
> struct device.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/fc.c         | 93 +++++++++++++++++++++++-------------------
>   drivers/nvme/target/fcloop.c   |  2 +
>   include/linux/nvme-fc-driver.h | 10 +++++
>   3 files changed, 64 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index e8ef42b9d50c..d30ea7a39183 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -237,6 +237,11 @@ static void __nvme_fc_delete_hw_queue(struct nvme_fc_ctrl *,
>   static void nvme_fc_handle_ls_rqst_work(struct work_struct *work);
>   
>   
> +static bool nvme_fc_lport_is_physical(struct nvme_fc_lport *lport)
> +{
> +	return !(lport->ops->port_features & NVME_FCPORTFEAT_VIRTUAL_DMA);
> +}
> +
>   static void
>   nvme_fc_free_lport(struct kref *ref)
>   {
> @@ -427,7 +432,7 @@ nvme_fc_register_localport(struct nvme_fc_port_info *pinfo,
>   	list_add_tail(&newrec->port_list, &nvme_fc_lport_list);
>   	spin_unlock_irqrestore(&nvme_fc_lock, flags);
>   
> -	if (dev)
> +	if (nvme_fc_lport_is_physical(newrec))
>   		dma_set_seg_boundary(dev, template->dma_boundary);
>   
>   	*portptr = &newrec->localport;
> @@ -953,40 +958,44 @@ EXPORT_SYMBOL_GPL(nvme_fc_set_remoteport_devloss);
>    */
>   
>   static inline dma_addr_t
> -fc_dma_map_single(struct device *dev, void *ptr, size_t size,
> +fc_dma_map_single(struct nvme_fc_lport *lport, void *ptr, size_t size,
>   		enum dma_data_direction dir)
>   {
> -	return dev ? dma_map_single(dev, ptr, size, dir) : (dma_addr_t)0L;
> +	if (nvme_fc_lport_is_physical(lport))
> +		return dma_map_single(lport->dev, ptr, size, dir);
> +	return (dma_addr_t)0L;
>   }
>   
>   static inline int
> -fc_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
> +fc_dma_mapping_error(struct nvme_fc_lport *lport, dma_addr_t dma_addr)
>   {
> -	return dev ? dma_mapping_error(dev, dma_addr) : 0;
> +	if (nvme_fc_lport_is_physical(lport))
> +		return dma_mapping_error(lport->dev, dma_addr);
> +	return 0;
>   }
>   
>   static inline void
> -fc_dma_unmap_single(struct device *dev, dma_addr_t addr, size_t size,
> +fc_dma_unmap_single(struct nvme_fc_lport *lport, dma_addr_t addr, size_t size,
>   	enum dma_data_direction dir)
>   {
> -	if (dev)
> -		dma_unmap_single(dev, addr, size, dir);
> +	if (nvme_fc_lport_is_physical(lport))
> +		dma_unmap_single(lport->dev, addr, size, dir);
>   }
>   
>   static inline void
> -fc_dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
> -		enum dma_data_direction dir)
> +fc_dma_sync_single_for_cpu(struct nvme_fc_lport *lport, dma_addr_t addr,
> +	size_t size, enum dma_data_direction dir)
>   {
> -	if (dev)
> -		dma_sync_single_for_cpu(dev, addr, size, dir);
> +	if (nvme_fc_lport_is_physical(lport))
> +		dma_sync_single_for_cpu(lport->dev, addr, size, dir);
>   }
>   
>   static inline void
> -fc_dma_sync_single_for_device(struct device *dev, dma_addr_t addr, size_t size,
> -		enum dma_data_direction dir)
> +fc_dma_sync_single_for_device(struct nvme_fc_lport *lport, dma_addr_t addr,
> +	size_t size, enum dma_data_direction dir)
>   {
> -	if (dev)
> -		dma_sync_single_for_device(dev, addr, size, dir);
> +	if (nvme_fc_lport_is_physical(lport))
> +		dma_sync_single_for_device(lport->dev, addr, size, dir);
>   }
>   
>   /* pseudo dma_map_sg call */
> @@ -1008,18 +1017,20 @@ fc_map_sg(struct scatterlist *sg, int nents)
>   }
>   
>   static inline int
> -fc_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> +fc_dma_map_sg(struct nvme_fc_lport *lport, struct scatterlist *sg, int nents,
>   		enum dma_data_direction dir)
>   {
> -	return dev ? dma_map_sg(dev, sg, nents, dir) : fc_map_sg(sg, nents);
> +	if (nvme_fc_lport_is_physical(lport))
> +		return dma_map_sg(lport->dev, sg, nents, dir);
> +	return fc_map_sg(sg, nents);
>   }
>   
>   static inline void
> -fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
> +fc_dma_unmap_sg(struct nvme_fc_lport *lport, struct scatterlist *sg, int nents,
>   		enum dma_data_direction dir)
>   {
> -	if (dev)
> -		dma_unmap_sg(dev, sg, nents, dir);
> +	if (nvme_fc_lport_is_physical(lport))
> +		dma_unmap_sg(lport->dev, sg, nents, dir);
>   }
>   
>   /* *********************** FC-NVME LS Handling **************************** */
> @@ -1049,7 +1060,7 @@ __nvme_fc_finish_ls_req(struct nvmefc_ls_req_op *lsop)
>   
>   	spin_unlock_irqrestore(&rport->lock, flags);
>   
> -	fc_dma_unmap_single(rport->dev, lsreq->rqstdma,
> +	fc_dma_unmap_single(rport->lport, lsreq->rqstdma,
>   				  (lsreq->rqstlen + lsreq->rsplen),
>   				  DMA_BIDIRECTIONAL);
>   
> @@ -1077,10 +1088,10 @@ __nvme_fc_send_ls_req(struct nvme_fc_rport *rport,
>   	INIT_LIST_HEAD(&lsop->lsreq_list);
>   	init_completion(&lsop->ls_done);
>   
> -	lsreq->rqstdma = fc_dma_map_single(rport->dev, lsreq->rqstaddr,
> +	lsreq->rqstdma = fc_dma_map_single(rport->lport, lsreq->rqstaddr,
>   				  lsreq->rqstlen + lsreq->rsplen,
>   				  DMA_BIDIRECTIONAL);
> -	if (fc_dma_mapping_error(rport->dev, lsreq->rqstdma)) {
> +	if (fc_dma_mapping_error(rport->lport, lsreq->rqstdma)) {
>   		ret = -EFAULT;
>   		goto out_putrport;
>   	}
> @@ -1107,7 +1118,7 @@ __nvme_fc_send_ls_req(struct nvme_fc_rport *rport,
>   	lsop->req_queued = false;
>   	list_del(&lsop->lsreq_list);
>   	spin_unlock_irqrestore(&rport->lock, flags);
> -	fc_dma_unmap_single(rport->dev, lsreq->rqstdma,
> +	fc_dma_unmap_single(rport->lport, lsreq->rqstdma,
>   				  (lsreq->rqstlen + lsreq->rsplen),
>   				  DMA_BIDIRECTIONAL);
>   out_putrport:
> @@ -1465,9 +1476,9 @@ nvme_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
>   	list_del(&lsop->lsrcv_list);
>   	spin_unlock_irqrestore(&rport->lock, flags);
>   
> -	fc_dma_sync_single_for_cpu(lport->dev, lsop->rspdma,
> +	fc_dma_sync_single_for_cpu(lport, lsop->rspdma,
>   				sizeof(*lsop->rspbuf), DMA_TO_DEVICE);
> -	fc_dma_unmap_single(lport->dev, lsop->rspdma,
> +	fc_dma_unmap_single(lport, lsop->rspdma,
>   			sizeof(*lsop->rspbuf), DMA_TO_DEVICE);
>   
>   	kfree(lsop);
> @@ -1483,7 +1494,7 @@ nvme_fc_xmt_ls_rsp(struct nvmefc_ls_rcv_op *lsop)
>   	struct fcnvme_ls_rqst_w0 *w0 = &lsop->rqstbuf->w0;
>   	int ret;
>   
> -	fc_dma_sync_single_for_device(lport->dev, lsop->rspdma,
> +	fc_dma_sync_single_for_device(lport, lsop->rspdma,
>   				  sizeof(*lsop->rspbuf), DMA_TO_DEVICE);
>   
>   	ret = lport->ops->xmt_ls_rsp(&lport->localport, &rport->remoteport,
> @@ -1761,10 +1772,10 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
>   	lsop->rqstbuf = (union nvmefc_ls_requests *)&lsop[1];
>   	lsop->rspbuf = (union nvmefc_ls_responses *)&lsop->rqstbuf[1];
>   
> -	lsop->rspdma = fc_dma_map_single(lport->dev, lsop->rspbuf,
> +	lsop->rspdma = fc_dma_map_single(lport, lsop->rspbuf,
>   					sizeof(*lsop->rspbuf),
>   					DMA_TO_DEVICE);
> -	if (fc_dma_mapping_error(lport->dev, lsop->rspdma)) {
> +	if (fc_dma_mapping_error(lport, lsop->rspdma)) {
>   		dev_info(lport->dev,
>   			"RCV %s LS failed: DMA mapping failure\n",
>   			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
> @@ -1793,7 +1804,7 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
>   	return 0;
>   
>   out_unmap:
> -	fc_dma_unmap_single(lport->dev, lsop->rspdma,
> +	fc_dma_unmap_single(lport, lsop->rspdma,
>   			sizeof(*lsop->rspbuf), DMA_TO_DEVICE);
>   out_free:
>   	kfree(lsop);
> @@ -1810,9 +1821,9 @@ static void
>   __nvme_fc_exit_request(struct nvme_fc_ctrl *ctrl,
>   		struct nvme_fc_fcp_op *op)
>   {
> -	fc_dma_unmap_single(ctrl->lport->dev, op->fcp_req.rspdma,
> +	fc_dma_unmap_single(ctrl->lport, op->fcp_req.rspdma,
>   				sizeof(op->rsp_iu), DMA_FROM_DEVICE);
> -	fc_dma_unmap_single(ctrl->lport->dev, op->fcp_req.cmddma,
> +	fc_dma_unmap_single(ctrl->lport, op->fcp_req.cmddma,
>   				sizeof(op->cmd_iu), DMA_TO_DEVICE);
>   
>   	atomic_set(&op->state, FCPOP_STATE_UNINIT);
> @@ -1936,7 +1947,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>   
>   	opstate = atomic_xchg(&op->state, FCPOP_STATE_COMPLETE);
>   
> -	fc_dma_sync_single_for_cpu(ctrl->lport->dev, op->fcp_req.rspdma,
> +	fc_dma_sync_single_for_cpu(ctrl->lport, op->fcp_req.rspdma,
>   				sizeof(op->rsp_iu), DMA_FROM_DEVICE);
>   
>   	if (opstate == FCPOP_STATE_ABORTED)
> @@ -2073,19 +2084,19 @@ __nvme_fc_init_request(struct nvme_fc_ctrl *ctrl,
>   	else
>   		cmdiu->rsv_cat = fccmnd_set_cat_admin(0);
>   
> -	op->fcp_req.cmddma = fc_dma_map_single(ctrl->lport->dev,
> +	op->fcp_req.cmddma = fc_dma_map_single(ctrl->lport,
>   				&op->cmd_iu, sizeof(op->cmd_iu), DMA_TO_DEVICE);
> -	if (fc_dma_mapping_error(ctrl->lport->dev, op->fcp_req.cmddma)) {
> +	if (fc_dma_mapping_error(ctrl->lport, op->fcp_req.cmddma)) {
>   		dev_err(ctrl->dev,
>   			"FCP Op failed - cmdiu dma mapping failed.\n");
>   		ret = -EFAULT;
>   		goto out_on_error;
>   	}
>   
> -	op->fcp_req.rspdma = fc_dma_map_single(ctrl->lport->dev,
> +	op->fcp_req.rspdma = fc_dma_map_single(ctrl->lport,
>   				&op->rsp_iu, sizeof(op->rsp_iu),
>   				DMA_FROM_DEVICE);
> -	if (fc_dma_mapping_error(ctrl->lport->dev, op->fcp_req.rspdma)) {
> +	if (fc_dma_mapping_error(ctrl->lport, op->fcp_req.rspdma)) {
>   		dev_err(ctrl->dev,
>   			"FCP Op failed - rspiu dma mapping failed.\n");
>   		ret = -EFAULT;
> @@ -2485,7 +2496,7 @@ nvme_fc_map_data(struct nvme_fc_ctrl *ctrl, struct request *rq,
>   
>   	op->nents = blk_rq_map_sg(rq->q, rq, freq->sg_table.sgl);
>   	WARN_ON(op->nents > blk_rq_nr_phys_segments(rq));
> -	freq->sg_cnt = fc_dma_map_sg(ctrl->lport->dev, freq->sg_table.sgl,
> +	freq->sg_cnt = fc_dma_map_sg(ctrl->lport, freq->sg_table.sgl,
>   				op->nents, rq_dma_dir(rq));
>   	if (unlikely(freq->sg_cnt <= 0)) {
>   		sg_free_table_chained(&freq->sg_table, NVME_INLINE_SG_CNT);
> @@ -2508,7 +2519,7 @@ nvme_fc_unmap_data(struct nvme_fc_ctrl *ctrl, struct request *rq,
>   	if (!freq->sg_cnt)
>   		return;
>   
> -	fc_dma_unmap_sg(ctrl->lport->dev, freq->sg_table.sgl, op->nents,
> +	fc_dma_unmap_sg(ctrl->lport, freq->sg_table.sgl, op->nents,
>   			rq_dma_dir(rq));
>   
>   	sg_free_table_chained(&freq->sg_table, NVME_INLINE_SG_CNT);
> @@ -2609,7 +2620,7 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
>   		}
>   	}
>   
> -	fc_dma_sync_single_for_device(ctrl->lport->dev, op->fcp_req.cmddma,
> +	fc_dma_sync_single_for_device(ctrl->lport, op->fcp_req.cmddma,
>   				  sizeof(op->cmd_iu), DMA_TO_DEVICE);
>   
>   	atomic_set(&op->state, FCPOP_STATE_ACTIVE);
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 2ccb941efb21..7dab98545979 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -1026,6 +1026,8 @@ static struct nvme_fc_port_template fctemplate = {
>   	.remote_priv_sz		= sizeof(struct fcloop_rport),
>   	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
>   	.fcprqst_priv_sz	= sizeof(struct fcloop_ini_fcpreq),
> +	/* optional features */
> +	.port_features		= NVME_FCPORTFEAT_VIRTUAL_DMA,
>   };
>   
>   static struct nvmet_fc_target_template tgttemplate = {
> diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
> index 675c7ef6df17..17cf967484b2 100644
> --- a/include/linux/nvme-fc-driver.h
> +++ b/include/linux/nvme-fc-driver.h
> @@ -334,6 +334,11 @@ struct nvme_fc_remote_port {
>   	enum nvme_fc_obj_state port_state;
>   } __aligned(sizeof(u64));	/* alignment for other things alloc'd with */
>   
> +/* Port Features (Bit fields) LLDD supports */
> +enum {
> +	NVME_FCPORTFEAT_VIRTUAL_DMA = (1 << 0),
> +		/* Bit 0: Virtual LLDD with no DMA support */
> +};
>   
>   /**
>    * struct nvme_fc_port_template - structure containing static entrypoints and
> @@ -470,6 +475,8 @@ struct nvme_fc_remote_port {
>    *       memory area solely for the of the LLDD and its location is
>    *       specified by the fcp_request->private pointer.
>    *       Value is Mandatory. Allowed to be zero.
> + *
> + * @port_features: Optional feature for the LLDD
>    */
>   struct nvme_fc_port_template {
>   	/* initiator-based functions */
> @@ -508,6 +515,9 @@ struct nvme_fc_port_template {
>   	u32	remote_priv_sz;
>   	u32	lsrqst_priv_sz;
>   	u32	fcprqst_priv_sz;
> +
> +	/* Optional port features */
> +	u32	port_features;
>   };
>   
>   

OK.

Reviewed-by: James Smart <james.smart@broadcom.com>


-- james

--00000000000038c86705b0eff44c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
AanDaJF6fE9TEzbfn5AWgVgHkbqS3VY3Gq05xkLhRugDQ60IGwT29K1B+wGfcujKSaalhQIDAQAB
o4IBzzCCAcswDgYDVR0PAQH/BAQDAgWgMIGeBggrBgEFBQcBAQSBkTCBjjBNBggrBgEFBQcwAoZB
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NwZXJzb25hbHNpZ24yc2hhMmcz
b2NzcC5jcnQwPQYIKwYBBQUHMAGGMWh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9nc3BlcnNv
bmFsc2lnbjJzaGEyZzMwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwRAYDVR0fBD0w
OzA5oDegNYYzaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc3BlcnNvbmFsc2lnbjJzaGEyZzMu
Y3JsMCMGA1UdEQQcMBqBGGphbWVzLnNtYXJ0QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQUUXCHNA1n5KXj
CXL1nHkJ8oKX5wYwDQYJKoZIhvcNAQELBQADggEBAGQDKmIdULu06w+bE15XZJOwlarihiP2PHos
/4bNU3NRgy/tCQbTpJJr3L7LU9ldcPam9qQsErGZKmb5ypUjVdmS5n5M7KN42mnfLs/p7+lOOY5q
ZwPZfsjYiUuaCWDGMvVpuBgJtdADOE1v24vgyyLZjtCbvSUzsgKKda3/Z/iwLFCRrIogixS1L6Vg
2JU2wwirL0Sy5S1DREQmTMAuHL+M9Qwbl+uh/AprkVqaSYuvUzWFwBVgafOl2XgGdn8r6ubxSZhX
9SybOi1fAXGcISX8GzOd85ygu/3dFqvMyCBpNke4vdweIll52KZIMyWji3y2PKJYfgqO+bxo7BAa
ROYxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMCDH5i
rbJ+nCPBux48wjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgiaoyWzyrG84vIHbK
GhYoMf6/mE1MvRNfvizQ8UiG+z4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjAxMDA1MTczODQ0WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAA8Z0L/LKeChYh9NySHZyM0ZkJP/BicvK4Xp
qME92d0FsPjxit+9s2ct1Ej4aSvZ63ogIidokrRUdqtST4aAUMdZDCSmBqic9StO3dcCW/dnbgR5
v93jimnfg01YIhSmPrhemDr+maVjQvfY3YIDlTblpbYw6aSkBDycRM5t36fMiFUotUl18XPHT2/5
52I2DkVovmXks+JJTJnZ8JyeMHOlBjr0+dNEZMkHaIqul56SF85zXlVt44PBGPdi7xdSwbrcEKad
Rn2SbcqOookWyIIzF9P8mSEmNSYOwtm8NpXUoxkcHgnYqXZgJ46qbKCiWMF54hb9QVFMtXaxjo4s
dGc=
--00000000000038c86705b0eff44c--


--===============6355746521218243534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============6355746521218243534==--

