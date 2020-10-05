Return-Path: <SRS0=0roG=DM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC45C47095
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 17:37:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA721207BC
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 17:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vtwktinS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Us4JaYL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA721207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eB4cRWrrz0XdU3kwuowl8oaQjb5wL0xsF03hbp+e2ew=; b=vtwktinSfK2QHuoAHV+5NyCv8
	fCCRniNddSlPrHGIZ6ayckbSNffiGeE8NaSInXF7RwNEITPcQiY460Lpz3xYgAQnXW4kX14ZsAufe
	h7bsvwVlF3KB1h0JvUMeTyn9JKFNC8HBy9yY4655hRb00hlPb2BPFDMsGgItJBGbuGI288SyejVjv
	q+WRM+ivPyvXWA0HzsaRDMFhUvL1L8ENL0jpcfYGqPrJa6u6vaQSD5WSY/jDQ30r9GR6WjpRHhB8K
	GgDF0ciLuLH0NFK+iCi5wq0a1VT4Zq3jkmCmMkOv74wBpbdFKOQVthvBLaTicf8S92IUpKg55G5SV
	AefLRaayg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPUQK-0007aQ-Gg; Mon, 05 Oct 2020 17:37:20 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPUQH-0007ZF-9M
 for linux-nvme@lists.infradead.org; Mon, 05 Oct 2020 17:37:18 +0000
Received: by mail-pf1-x441.google.com with SMTP id d6so7396785pfn.9
 for <linux-nvme@lists.infradead.org>; Mon, 05 Oct 2020 10:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to;
 bh=e/9DkT+zKBd5/mhd4Hg8cACFgBQad92BgwaApFx3B8c=;
 b=Us4JaYL/Hk2k/GBQvLuJhpPgF54lO04AxQBVOSz4Aaglm3evhc/mgn47//K0Msx3Dk
 SwjAlavhGeao4RpWSHhPoD1rOhxcJ+97K7SunEzWrCCrQnAcs010hbIIbjdxWVMOl6nM
 q1iAWd5VxRQ4Ue0PgYOtTGtuR4IbJj77cnb/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=e/9DkT+zKBd5/mhd4Hg8cACFgBQad92BgwaApFx3B8c=;
 b=dkG/Xz7KWMmN/uGc7SZoCdb/pEkbyV+ouveBRho6d7cW+nMCNyv8FspK9tQo4Fk8gG
 MOnmfCpL5bY6MDZgY0wxVQFu2NA62b6HbiVDGBsrXxWdxX4hgfaByxPymhPLvy+YtHzb
 VB6Kd75zDS575sMCk+fi/yBeay7AnKs50FpWTWnHzkwj8kEjMrqODgeHmNACk29/FuFL
 NOBzMfUL8K1xBSrqrM8A4fbZc3nDhsCDWmQg1aigMOLc/BogeC7p92Pa18yJHtp6aD7Q
 43kcPxQyiLZYw2LD3fF4e69ZtfplVDbLKFUvdMq1f2+UB4wWG4LDiFXefPsEUzkwxfAa
 C31w==
X-Gm-Message-State: AOAM532GCr+J7jp/LYFipFXP5Mkz3wsQ2rZv7JVSBx1+sVlGenPPXYnL
 wlY5+D23Ex5amL1ZyP5yWQkLPBEj8o1ktjQC55oWklYJsR1qbMhocq6pzKfC8ujUUT5gM9LOJmP
 kOTCRbwVOj6eFXRT2No3rmwkH27ozqyJYYL6hpeSeIJBZEWPMsImQnCdxeZmkmC3XS+W8frVT6w
 znDFAtYqmG
X-Google-Smtp-Source: ABdhPJwHOVJMYQ6C9KEV5hb16UXKAfilF4eQFUHoMx2G+AQ7PHrTf9lDzhNi2DQUM4k/nNTPeriLiw==
X-Received: by 2002:aa7:94a4:0:b029:151:d786:d5c2 with SMTP id
 a4-20020aa794a40000b0290151d786d5c2mr927560pfl.50.1601919434180; 
 Mon, 05 Oct 2020 10:37:14 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id u27sm221866pgm.60.2020.10.05.10.37.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 10:37:13 -0700 (PDT)
Subject: Re: [PATCH 4/7] nvmet-fc: use feature flag for virtual LLDD
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200922121501.32851-1-hare@suse.de>
 <20200922121501.32851-5-hare@suse.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <990c02ea-0b84-5301-0d0d-e75556df02b7@broadcom.com>
Date: Mon, 5 Oct 2020 10:37:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200922121501.32851-5-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_133717_344516_AC8D8957 
X-CRM114-Status: GOOD (  26.47  )
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
Content-Type: multipart/mixed; boundary="===============4071336743126489245=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============4071336743126489245==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e0aa9105b0efeec9"

--000000000000e0aa9105b0efeec9
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
>   drivers/nvme/target/fc.c       | 93 +++++++++++++++++++++++-------------------
>   drivers/nvme/target/fcloop.c   |  2 +-
>   include/linux/nvme-fc-driver.h |  2 +
>   3 files changed, 55 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 63f5deb3b68a..6f5784767d35 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -273,41 +273,50 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
>    * in the scatter list, setting all dma addresses to 0.
>    */
>   
> +static bool fc_lldd_is_virtual(struct nvmet_fc_tgtport *tgtport)
> +{
> +	return !!(tgtport->ops->target_features & NVMET_FCTGTFEAT_VIRTUAL_DMA);
> +}
> +
>   static inline dma_addr_t
> -fc_dma_map_single(struct device *dev, void *ptr, size_t size,
> +fc_dma_map_single(struct nvmet_fc_tgtport *tgtport, void *ptr, size_t size,
>   		enum dma_data_direction dir)
>   {
> -	return dev ? dma_map_single(dev, ptr, size, dir) : (dma_addr_t)0L;
> +	if (fc_lldd_is_virtual(tgtport))
> +		return (dma_addr_t)0L;
> +	return dma_map_single(tgtport->dev, ptr, size, dir);
>   }
>   
>   static inline int
> -fc_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
> +fc_dma_mapping_error(struct nvmet_fc_tgtport *tgtport, dma_addr_t dma_addr)
>   {
> -	return dev ? dma_mapping_error(dev, dma_addr) : 0;
> +	if (fc_lldd_is_virtual(tgtport))
> +		return 0;
> +	return dma_mapping_error(tgtport->dev, dma_addr);
>   }
>   
>   static inline void
> -fc_dma_unmap_single(struct device *dev, dma_addr_t addr, size_t size,
> -	enum dma_data_direction dir)
> +fc_dma_unmap_single(struct nvmet_fc_tgtport *tgtport, dma_addr_t addr,
> +	size_t size, enum dma_data_direction dir)
>   {
> -	if (dev)
> -		dma_unmap_single(dev, addr, size, dir);
> +	if (!fc_lldd_is_virtual(tgtport))
> +		dma_unmap_single(tgtport->dev, addr, size, dir);
>   }
>   
>   static inline void
> -fc_dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
> -		enum dma_data_direction dir)
> +fc_dma_sync_single_for_cpu(struct nvmet_fc_tgtport *tgtport, dma_addr_t addr,
> +	size_t size, enum dma_data_direction dir)
>   {
> -	if (dev)
> -		dma_sync_single_for_cpu(dev, addr, size, dir);
> +	if (!fc_lldd_is_virtual(tgtport))
> +		dma_sync_single_for_cpu(tgtport->dev, addr, size, dir);
>   }
>   
>   static inline void
> -fc_dma_sync_single_for_device(struct device *dev, dma_addr_t addr, size_t size,
> -		enum dma_data_direction dir)
> +fc_dma_sync_single_for_device(struct nvmet_fc_tgtport *tgtport, dma_addr_t addr,
> +	size_t size, enum dma_data_direction dir)
>   {
> -	if (dev)
> -		dma_sync_single_for_device(dev, addr, size, dir);
> +	if (!fc_lldd_is_virtual(tgtport))
> +		dma_sync_single_for_device(tgtport->dev, addr, size, dir);
>   }
>   
>   /* pseudo dma_map_sg call */
> @@ -329,18 +338,20 @@ fc_map_sg(struct scatterlist *sg, int nents)
>   }
>   
>   static inline int
> -fc_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> -		enum dma_data_direction dir)
> +fc_dma_map_sg(struct nvmet_fc_tgtport *tgtport, struct scatterlist *sg,
> +	int nents, enum dma_data_direction dir)
>   {
> -	return dev ? dma_map_sg(dev, sg, nents, dir) : fc_map_sg(sg, nents);
> +	if (fc_lldd_is_virtual(tgtport))
> +		return fc_map_sg(sg, nents);
> +	return dma_map_sg(tgtport->dev, sg, nents, dir);
>   }
>   
>   static inline void
> -fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
> -		enum dma_data_direction dir)
> +fc_dma_unmap_sg(struct nvmet_fc_tgtport *tgtport, struct scatterlist *sg,
> +	int nents, enum dma_data_direction dir)
>   {
> -	if (dev)
> -		dma_unmap_sg(dev, sg, nents, dir);
> +	if (!fc_lldd_is_virtual(tgtport))
> +		dma_unmap_sg(tgtport->dev, sg, nents, dir);
>   }
>   
>   
> @@ -368,7 +379,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
>   
>   	spin_unlock_irqrestore(&tgtport->lock, flags);
>   
> -	fc_dma_unmap_single(tgtport->dev, lsreq->rqstdma,
> +	fc_dma_unmap_single(tgtport, lsreq->rqstdma,
>   				  (lsreq->rqstlen + lsreq->rsplen),
>   				  DMA_BIDIRECTIONAL);
>   
> @@ -391,10 +402,10 @@ __nvmet_fc_send_ls_req(struct nvmet_fc_tgtport *tgtport,
>   	lsop->req_queued = false;
>   	INIT_LIST_HEAD(&lsop->lsreq_list);
>   
> -	lsreq->rqstdma = fc_dma_map_single(tgtport->dev, lsreq->rqstaddr,
> +	lsreq->rqstdma = fc_dma_map_single(tgtport, lsreq->rqstaddr,
>   				  lsreq->rqstlen + lsreq->rsplen,
>   				  DMA_BIDIRECTIONAL);
> -	if (fc_dma_mapping_error(tgtport->dev, lsreq->rqstdma))
> +	if (fc_dma_mapping_error(tgtport, lsreq->rqstdma))
>   		return -EFAULT;
>   
>   	lsreq->rspdma = lsreq->rqstdma + lsreq->rqstlen;
> @@ -420,7 +431,7 @@ __nvmet_fc_send_ls_req(struct nvmet_fc_tgtport *tgtport,
>   	lsop->req_queued = false;
>   	list_del(&lsop->lsreq_list);
>   	spin_unlock_irqrestore(&tgtport->lock, flags);
> -	fc_dma_unmap_single(tgtport->dev, lsreq->rqstdma,
> +	fc_dma_unmap_single(tgtport, lsreq->rqstdma,
>   				  (lsreq->rqstlen + lsreq->rsplen),
>   				  DMA_BIDIRECTIONAL);
>   	return ret;
> @@ -555,10 +566,10 @@ nvmet_fc_alloc_ls_iodlist(struct nvmet_fc_tgtport *tgtport)
>   
>   		iod->rspbuf = (union nvmefc_ls_responses *)&iod->rqstbuf[1];
>   
> -		iod->rspdma = fc_dma_map_single(tgtport->dev, iod->rspbuf,
> +		iod->rspdma = fc_dma_map_single(tgtport, iod->rspbuf,
>   						sizeof(*iod->rspbuf),
>   						DMA_TO_DEVICE);
> -		if (fc_dma_mapping_error(tgtport->dev, iod->rspdma))
> +		if (fc_dma_mapping_error(tgtport, iod->rspdma))
>   			goto out_fail;
>   	}
>   
> @@ -568,7 +579,7 @@ nvmet_fc_alloc_ls_iodlist(struct nvmet_fc_tgtport *tgtport)
>   	kfree(iod->rqstbuf);
>   	list_del(&iod->ls_rcv_list);
>   	for (iod--, i--; i >= 0; iod--, i--) {
> -		fc_dma_unmap_single(tgtport->dev, iod->rspdma,
> +		fc_dma_unmap_single(tgtport, iod->rspdma,
>   				sizeof(*iod->rspbuf), DMA_TO_DEVICE);
>   		kfree(iod->rqstbuf);
>   		list_del(&iod->ls_rcv_list);
> @@ -586,7 +597,7 @@ nvmet_fc_free_ls_iodlist(struct nvmet_fc_tgtport *tgtport)
>   	int i;
>   
>   	for (i = 0; i < NVMET_LS_CTX_COUNT; iod++, i++) {
> -		fc_dma_unmap_single(tgtport->dev,
> +		fc_dma_unmap_single(tgtport,
>   				iod->rspdma, sizeof(*iod->rspbuf),
>   				DMA_TO_DEVICE);
>   		kfree(iod->rqstbuf);
> @@ -640,12 +651,12 @@ nvmet_fc_prep_fcp_iodlist(struct nvmet_fc_tgtport *tgtport,
>   		list_add_tail(&fod->fcp_list, &queue->fod_list);
>   		spin_lock_init(&fod->flock);
>   
> -		fod->rspdma = fc_dma_map_single(tgtport->dev, &fod->rspiubuf,
> +		fod->rspdma = fc_dma_map_single(tgtport, &fod->rspiubuf,
>   					sizeof(fod->rspiubuf), DMA_TO_DEVICE);
> -		if (fc_dma_mapping_error(tgtport->dev, fod->rspdma)) {
> +		if (fc_dma_mapping_error(tgtport, fod->rspdma)) {
>   			list_del(&fod->fcp_list);
>   			for (fod--, i--; i >= 0; fod--, i--) {
> -				fc_dma_unmap_single(tgtport->dev, fod->rspdma,
> +				fc_dma_unmap_single(tgtport, fod->rspdma,
>   						sizeof(fod->rspiubuf),
>   						DMA_TO_DEVICE);
>   				fod->rspdma = 0L;
> @@ -666,7 +677,7 @@ nvmet_fc_destroy_fcp_iodlist(struct nvmet_fc_tgtport *tgtport,
>   
>   	for (i = 0; i < queue->sqsize; fod++, i++) {
>   		if (fod->rspdma)
> -			fc_dma_unmap_single(tgtport->dev, fod->rspdma,
> +			fc_dma_unmap_single(tgtport, fod->rspdma,
>   				sizeof(fod->rspiubuf), DMA_TO_DEVICE);
>   	}
>   }
> @@ -730,7 +741,7 @@ nvmet_fc_free_fcp_iod(struct nvmet_fc_tgt_queue *queue,
>   	struct nvmet_fc_defer_fcp_req *deferfcp;
>   	unsigned long flags;
>   
> -	fc_dma_sync_single_for_cpu(tgtport->dev, fod->rspdma,
> +	fc_dma_sync_single_for_cpu(tgtport, fod->rspdma,
>   				sizeof(fod->rspiubuf), DMA_TO_DEVICE);
>   
>   	fcpreq->nvmet_fc_private = NULL;
> @@ -1925,7 +1936,7 @@ nvmet_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
>   	struct nvmet_fc_ls_iod *iod = lsrsp->nvme_fc_private;
>   	struct nvmet_fc_tgtport *tgtport = iod->tgtport;
>   
> -	fc_dma_sync_single_for_cpu(tgtport->dev, iod->rspdma,
> +	fc_dma_sync_single_for_cpu(tgtport, iod->rspdma,
>   				sizeof(*iod->rspbuf), DMA_TO_DEVICE);
>   	nvmet_fc_free_ls_iod(tgtport, iod);
>   	nvmet_fc_tgtport_put(tgtport);
> @@ -1937,7 +1948,7 @@ nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
>   {
>   	int ret;
>   
> -	fc_dma_sync_single_for_device(tgtport->dev, iod->rspdma,
> +	fc_dma_sync_single_for_device(tgtport, iod->rspdma,
>   				  sizeof(*iod->rspbuf), DMA_TO_DEVICE);
>   
>   	ret = tgtport->ops->xmt_ls_rsp(&tgtport->fc_target_port, iod->lsrsp);
> @@ -2091,7 +2102,7 @@ nvmet_fc_alloc_tgt_pgs(struct nvmet_fc_fcp_iod *fod)
>   
>   	fod->data_sg = sg;
>   	fod->data_sg_cnt = nent;
> -	fod->data_sg_cnt = fc_dma_map_sg(fod->tgtport->dev, sg, nent,
> +	fod->data_sg_cnt = fc_dma_map_sg(fod->tgtport, sg, nent,
>   				((fod->io_dir == NVMET_FCP_WRITE) ?
>   					DMA_FROM_DEVICE : DMA_TO_DEVICE));
>   				/* note: write from initiator perspective */
> @@ -2109,7 +2120,7 @@ nvmet_fc_free_tgt_pgs(struct nvmet_fc_fcp_iod *fod)
>   	if (!fod->data_sg || !fod->data_sg_cnt)
>   		return;
>   
> -	fc_dma_unmap_sg(fod->tgtport->dev, fod->data_sg, fod->data_sg_cnt,
> +	fc_dma_unmap_sg(fod->tgtport, fod->data_sg, fod->data_sg_cnt,
>   				((fod->io_dir == NVMET_FCP_WRITE) ?
>   					DMA_FROM_DEVICE : DMA_TO_DEVICE));
>   	sgl_free(fod->data_sg);
> @@ -2193,7 +2204,7 @@ nvmet_fc_prep_fcp_rsp(struct nvmet_fc_tgtport *tgtport,
>   		fod->fcpreq->rsplen = sizeof(*ersp);
>   	}
>   
> -	fc_dma_sync_single_for_device(tgtport->dev, fod->rspdma,
> +	fc_dma_sync_single_for_device(tgtport, fod->rspdma,
>   				  sizeof(fod->rspiubuf), DMA_TO_DEVICE);
>   }
>   
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index e56f323fa7d4..2ccb941efb21 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -1043,7 +1043,7 @@ static struct nvmet_fc_target_template tgttemplate = {
>   	.max_dif_sgl_segments	= FCLOOP_SGL_SEGS,
>   	.dma_boundary		= FCLOOP_DMABOUND_4G,
>   	/* optional features */
> -	.target_features	= 0,
> +	.target_features	= NVMET_FCTGTFEAT_VIRTUAL_DMA,
>   	/* sizes of additional private data for data structures */
>   	.target_priv_sz		= sizeof(struct fcloop_tport),
>   	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
> diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
> index 2a38f2b477a5..675c7ef6df17 100644
> --- a/include/linux/nvme-fc-driver.h
> +++ b/include/linux/nvme-fc-driver.h
> @@ -707,6 +707,8 @@ enum {
>   		 * sequence in one LLDD operation. Errors during Data
>   		 * sequence transmit must not allow RSP sequence to be sent.
>   		 */
> +	NVMET_FCTGTFEAT_VIRTUAL_DMA = (1 << 1),
> +		/* Bit 1: Virtual LLDD with no DMA support */
>   };
>   
>   

Ok.

Reviewed-by: James Smart <james.smart@broadcom.com>


-- james

--000000000000e0aa9105b0efeec9
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
rbJ+nCPBux48wjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgn8u3YIzCJb/dyWX7
ae9fG4DnTKsY5XNWXFnFuH9f9nUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjAxMDA1MTczNzE0WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAF+Jb4CAWJkTA2JKXrMOYAyCUyuj8vED3UG0
hLtz+4TuGeJCgrgntaCRxpknOQtbawuZpK+TXJNlswpqSkTRmW5H3fBhXjTCjUX1yXJkhKw/Fr6/
xZ6ZIVTQRfEbWm4HKBMHwvpe4iikohRvzM6whUrfw+544Ee4cAtc1FksSl487UCNhbJWzXoyhm5D
9cA8VxjMrhxpBKpYC6W8kFGMluL4NhuGAGFR0fSCRQHLf3iv7SZye+U6dXt7/IAUsrqoq7ip64nE
QIUMpZj4CD6ir/YkH+V9OQ8OC5x/AAeXPN8zGuld7a3RZoIuJkU2uxbJSUpn+XyeZVZl+ZGIpJwu
EF4=
--000000000000e0aa9105b0efeec9--


--===============4071336743126489245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============4071336743126489245==--

