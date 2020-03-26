Return-Path: <SRS0=sW0/=5L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87144C43331
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 18:32:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E1172070A
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 18:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u3SI/L5H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1dkhvtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1172070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BX1+sQmI+PpZ00xy/DHMJLPW5Lsn4miFy5VQKJGBt1A=; b=u3SI/L5HNvaRty
	JdhaQz3DaCluCB0QzXqwaEgM2Jb7+PpgW/pAok2NyvnH0jx3q/lA/RI6W4hvfyM4m6FaCYnwCdcEF
	flFVNEsvZodwHWSy7FcYm7cVl1uy2xhRoo2p59KzRRMqS1OX9uz3m22bq0jr5UnOriti1Ad/80+W2
	jBgYq9PG7zR/5/QrM+4tSqG/R6qyuVaF3B5a/5oyJybyQDEfi/S/FcsitZjKl+CJKSaUtklBfE/TE
	SV7c6OljLcq8k6nDnzbC+15VDsyfoBuYHtm78SivryamnNWHIaoBpnHekg0+W+LabKr8S/k1nF+xj
	LY/QhEckumx3hTIJI6FQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHXIV-0000lf-FL; Thu, 26 Mar 2020 18:32:07 +0000
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHXIR-0000lB-Vf
 for linux-nvme@lists.infradead.org; Thu, 26 Mar 2020 18:32:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585247522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jzicgUBoLjfdaD8wgouwFuiwKfyI8RLjyqr/hx3xpQQ=;
 b=B1dkhvtIVU9fLyP/U2b5dJjuSQ5sOZI3T6gnSkH4rt/sDJc+AQLlE9aO8oIther1WNU8+w
 MYFIEkZf+RFSPMIIzIdg/d5mKvXTdBu5ZEHVloScDaw2Nn/JYNIs/Ubgt4ru+pgmj4mReU
 58ywujHPVMOqMrtEPO/AYcK69o/NZTQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-DUsr_YisNv6F1fiEGpwmRw-1; Thu, 26 Mar 2020 14:29:59 -0400
X-MC-Unique: DUsr_YisNv6F1fiEGpwmRw-1
Received: by mail-qv1-f69.google.com with SMTP id s7so5494505qvl.21
 for <linux-nvme@lists.infradead.org>; Thu, 26 Mar 2020 11:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jzicgUBoLjfdaD8wgouwFuiwKfyI8RLjyqr/hx3xpQQ=;
 b=VtWg2Aa+CDzc5HM2MtzzulYSOl6FH+/WEnBUgrdNpZM4L6KZziOmDWdyY63LcNKmoD
 CSkSgxDI9G+yogffnECQRw2et1tgmh+2DGtiKzh1I5Vyj4sycGBSZVrFYVDaoCJxbPWH
 iWc+RhV4pigPHcsMyFr3C5WekF8ZoEGwf8AHeMFhjUW4sz8Yg6oqLaAf1w8IIfkTAILS
 Gj5NWfSym5DdqUEHZy16k8b5CRO2rHJWOHDSzOSbnAGkPomFDMuGv6/XBiKRtgztRi0o
 noh5NhcpA2MkvZbEzXVxr+C7dtdzCuciOZp0E6a1qFy/g4MwoKDJb3x8ygDrnw9KZEn1
 IWcQ==
X-Gm-Message-State: ANhLgQ35WIV95N3UlSayE63yRGUoxZKOA4om1RrZXBPGmpl2CXmP5WMr
 4EEk5ZLx1RM8X/X9uAOoPSjio216tD1Nqr5IsgwZ1dArK5MzlTKyTmDgasGBmxO9qpehjo/jgLw
 PR+VxnQLZGwLhejbRB0wd1Sg/cwo=
X-Received: by 2002:aed:37c4:: with SMTP id j62mr9714764qtb.279.1585247398342; 
 Thu, 26 Mar 2020 11:29:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvDz1sYDn0EreLqFQ+rJA1SZoV41dE7xjIGXxOgbWNJY34FbbBT4oSmpWI8WuBh9sZafau88g==
X-Received: by 2002:aed:37c4:: with SMTP id j62mr9714713qtb.279.1585247397742; 
 Thu, 26 Mar 2020 11:29:57 -0700 (PDT)
Received: from loberhel7laptop ([2600:6c64:4e80:f1:4a17:2cf9:6a8a:f150])
 by smtp.gmail.com with ESMTPSA id j50sm2149868qta.42.2020.03.26.11.29.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 26 Mar 2020 11:29:57 -0700 (PDT)
Message-ID: <62fefed0e5d459563dfd3e0e027ceef529dce803.camel@redhat.com>
Subject: Re: [PATCH v4 1/1] nvmet-rdma: use SRQ per completion vector
From: Laurence Oberman <loberman@redhat.com>
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org, 
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Date: Thu, 26 Mar 2020 14:29:51 -0400
In-Reply-To: <20200326181512.58053-1-maxg@mellanox.com>
References: <20200326181512.58053-1-maxg@mellanox.com>
X-Mailer: Evolution 3.28.5 (3.28.5-5.el7)
Mime-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200326_113204_173195_2CB56817 
X-CRM114-Status: GOOD (  26.04  )
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
Cc: shlomin@mellanox.com, jgg@mellanox.com, bvanassche@acm.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 2020-03-26 at 20:15 +0200, Max Gurtovoy wrote:
> In order to save resource allocation and utilize the completion
> locality in a better way (compared to SRQ per device that exist
> today),
> allocate Shared Receive Queues (SRQs) per completion vector.
> Associate
> each created QP/CQ with an appropriate SRQ according to the queue
> index.
> This association will reduce the lock contention in the fast path
> (compared to SRQ per device solution) and increase the locality in
> memory buffers. Add new module parameter for SRQ size to adjust it
> according to the expected load. User should make sure the size is >=
> 256
> to avoid lack of resources. Also reduce the debug level of "last WQE
> reached" event that is raised when a QP is using SRQ during
> destruction
> process to relief the log.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> ---
> 
> changes from V3:
>  - remove redundent NULL assingment (Sagi)
>  - reduce log level for last wqe reached event
> changes from V1 + V2:
>  - removed SRQ pool
>  - removed SRP target implementation
> 
> ---
>  drivers/nvme/target/rdma.c | 176 ++++++++++++++++++++++++++++++++++-
> ----------
>  1 file changed, 134 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 9e1b8c6..dc8a969 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -34,6 +34,8 @@
>  /* Assume mpsmin == device_page_size == 4KB */
>  #define NVMET_RDMA_MAX_MDTS			8
>  
> +struct nvmet_rdma_srq;
> +
>  struct nvmet_rdma_cmd {
>  	struct ib_sge		sge[NVMET_RDMA_MAX_INLINE_SGE + 1];
>  	struct ib_cqe		cqe;
> @@ -41,6 +43,7 @@ struct nvmet_rdma_cmd {
>  	struct scatterlist	inline_sg[NVMET_RDMA_MAX_INLINE_SGE];
>  	struct nvme_command     *nvme_cmd;
>  	struct nvmet_rdma_queue	*queue;
> +	struct nvmet_rdma_srq   *nsrq;
>  };
>  
>  enum {
> @@ -82,6 +85,7 @@ struct nvmet_rdma_queue {
>  	struct ib_cq		*cq;
>  	atomic_t		sq_wr_avail;
>  	struct nvmet_rdma_device *dev;
> +	struct nvmet_rdma_srq   *nsrq;
>  	spinlock_t		state_lock;
>  	enum nvmet_rdma_queue_state state;
>  	struct nvmet_cq		nvme_cq;
> @@ -99,17 +103,24 @@ struct nvmet_rdma_queue {
>  
>  	int			idx;
>  	int			host_qid;
> +	int			comp_vector;
>  	int			recv_queue_size;
>  	int			send_queue_size;
>  
>  	struct list_head	queue_list;
>  };
>  
> +struct nvmet_rdma_srq {
> +	struct ib_srq            *srq;
> +	struct nvmet_rdma_cmd    *cmds;
> +	struct nvmet_rdma_device *ndev;
> +};
> +
>  struct nvmet_rdma_device {
>  	struct ib_device	*device;
>  	struct ib_pd		*pd;
> -	struct ib_srq		*srq;
> -	struct nvmet_rdma_cmd	*srq_cmds;
> +	struct nvmet_rdma_srq	**srqs;
> +	int			srq_count;
>  	size_t			srq_size;
>  	struct kref		ref;
>  	struct list_head	entry;
> @@ -121,6 +132,16 @@ struct nvmet_rdma_device {
>  module_param_named(use_srq, nvmet_rdma_use_srq, bool, 0444);
>  MODULE_PARM_DESC(use_srq, "Use shared receive queue.");
>  
> +static int srq_size_set(const char *val, const struct kernel_param
> *kp);
> +static const struct kernel_param_ops srq_size_ops = {
> +	.set = srq_size_set,
> +	.get = param_get_int,
> +};
> +
> +static int nvmet_rdma_srq_size = 1024;
> +module_param_cb(srq_size, &srq_size_ops, &nvmet_rdma_srq_size,
> 0644);
> +MODULE_PARM_DESC(srq_size, "set Shared Receive Queue (SRQ) size,
> should >= 256 (default: 1024)");
> +
>  static DEFINE_IDA(nvmet_rdma_queue_ida);
>  static LIST_HEAD(nvmet_rdma_queue_list);
>  static DEFINE_MUTEX(nvmet_rdma_queue_mutex);
> @@ -141,6 +162,17 @@ static int nvmet_rdma_alloc_rsp(struct
> nvmet_rdma_device *ndev,
>  
>  static const struct nvmet_fabrics_ops nvmet_rdma_ops;
>  
> +static int srq_size_set(const char *val, const struct kernel_param
> *kp)
> +{
> +	int n = 0, ret;
> +
> +	ret = kstrtoint(val, 10, &n);
> +	if (ret != 0 || n < 256)
> +		return -EINVAL;
> +
> +	return param_set_int(val, kp);
> +}
> +
>  static int num_pages(int len)
>  {
>  	return 1 + (((len - 1) & PAGE_MASK) >> PAGE_SHIFT);
> @@ -464,8 +496,8 @@ static int nvmet_rdma_post_recv(struct
> nvmet_rdma_device *ndev,
>  		cmd->sge[0].addr, cmd->sge[0].length,
>  		DMA_FROM_DEVICE);
>  
> -	if (ndev->srq)
> -		ret = ib_post_srq_recv(ndev->srq, &cmd->wr, NULL);
> +	if (cmd->nsrq)
> +		ret = ib_post_srq_recv(cmd->nsrq->srq, &cmd->wr, NULL);
>  	else
>  		ret = ib_post_recv(cmd->queue->cm_id->qp, &cmd->wr,
> NULL);
>  
> @@ -843,23 +875,40 @@ static void nvmet_rdma_recv_done(struct ib_cq
> *cq, struct ib_wc *wc)
>  	nvmet_rdma_handle_command(queue, rsp);
>  }
>  
> -static void nvmet_rdma_destroy_srq(struct nvmet_rdma_device *ndev)
> +static void nvmet_rdma_destroy_srq(struct nvmet_rdma_srq *nsrq)
> +{
> +	nvmet_rdma_free_cmds(nsrq->ndev, nsrq->cmds, nsrq->ndev-
> >srq_size,
> +			     false);
> +	ib_destroy_srq(nsrq->srq);
> +
> +	kfree(nsrq);
> +}
> +
> +static void nvmet_rdma_destroy_srqs(struct nvmet_rdma_device *ndev)
>  {
> -	if (!ndev->srq)
> +	int i;
> +
> +	if (!ndev->srqs)
>  		return;
>  
> -	nvmet_rdma_free_cmds(ndev, ndev->srq_cmds, ndev->srq_size,
> false);
> -	ib_destroy_srq(ndev->srq);
> +	for (i = 0; i < ndev->srq_count; i++)
> +		nvmet_rdma_destroy_srq(ndev->srqs[i]);
> +
> +	kfree(ndev->srqs);
>  }
>  
> -static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
> +static struct nvmet_rdma_srq *
> +nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
>  {
>  	struct ib_srq_init_attr srq_attr = { NULL, };
> +	size_t srq_size = ndev->srq_size;
> +	struct nvmet_rdma_srq *nsrq;
>  	struct ib_srq *srq;
> -	size_t srq_size;
>  	int ret, i;
>  
> -	srq_size = 4095;	/* XXX: tune */
> +	nsrq = kzalloc(sizeof(*nsrq), GFP_KERNEL);
> +	if (!nsrq)
> +		return ERR_PTR(-ENOMEM);
>  
>  	srq_attr.attr.max_wr = srq_size;
>  	srq_attr.attr.max_sge = 1 + ndev->inline_page_count;
> @@ -867,35 +916,71 @@ static int nvmet_rdma_init_srq(struct
> nvmet_rdma_device *ndev)
>  	srq_attr.srq_type = IB_SRQT_BASIC;
>  	srq = ib_create_srq(ndev->pd, &srq_attr);
>  	if (IS_ERR(srq)) {
> -		/*
> -		 * If SRQs aren't supported we just go ahead and use
> normal
> -		 * non-shared receive queues.
> -		 */
> -		pr_info("SRQ requested but not supported.\n");
> -		return 0;
> +		ret = PTR_ERR(srq);
> +		goto out_free;
>  	}
>  
> -	ndev->srq_cmds = nvmet_rdma_alloc_cmds(ndev, srq_size, false);
> -	if (IS_ERR(ndev->srq_cmds)) {
> -		ret = PTR_ERR(ndev->srq_cmds);
> +	nsrq->cmds = nvmet_rdma_alloc_cmds(ndev, srq_size, false);
> +	if (IS_ERR(nsrq->cmds)) {
> +		ret = PTR_ERR(nsrq->cmds);
>  		goto out_destroy_srq;
>  	}
>  
> -	ndev->srq = srq;
> -	ndev->srq_size = srq_size;
> +	nsrq->srq = srq;
> +	nsrq->ndev = ndev;
>  
>  	for (i = 0; i < srq_size; i++) {
> -		ret = nvmet_rdma_post_recv(ndev, &ndev->srq_cmds[i]);
> +		nsrq->cmds[i].nsrq = nsrq;
> +		ret = nvmet_rdma_post_recv(ndev, &nsrq->cmds[i]);
>  		if (ret)
>  			goto out_free_cmds;
>  	}
>  
> -	return 0;
> +	return nsrq;
>  
>  out_free_cmds:
> -	nvmet_rdma_free_cmds(ndev, ndev->srq_cmds, ndev->srq_size,
> false);
> +	nvmet_rdma_free_cmds(ndev, nsrq->cmds, srq_size, false);
>  out_destroy_srq:
>  	ib_destroy_srq(srq);
> +out_free:
> +	kfree(nsrq);
> +	return ERR_PTR(ret);
> +}
> +
> +static int nvmet_rdma_init_srqs(struct nvmet_rdma_device *ndev)
> +{
> +	int i, ret;
> +
> +	if (!ndev->device->attrs.max_srq_wr || !ndev->device-
> >attrs.max_srq) {
> +		/*
> +		 * If SRQs aren't supported we just go ahead and use
> normal
> +		 * non-shared receive queues.
> +		 */
> +		pr_info("SRQ requested but not supported.\n");
> +		return 0;
> +	}
> +
> +	ndev->srq_size = min(ndev->device->attrs.max_srq_wr,
> +			     nvmet_rdma_srq_size);
> +	ndev->srq_count = min(ndev->device->num_comp_vectors,
> +			      ndev->device->attrs.max_srq);
> +
> +	ndev->srqs = kcalloc(ndev->srq_count, sizeof(*ndev->srqs),
> GFP_KERNEL);
> +	if (!ndev->srqs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < ndev->srq_count; i++) {
> +		ndev->srqs[i] = nvmet_rdma_init_srq(ndev);
> +		if (IS_ERR(ndev->srqs[i]))
> +			goto err_srq;
> +	}
> +
> +	return 0;
> +
> +err_srq:
> +	while (--i >= 0)
> +		nvmet_rdma_destroy_srq(ndev->srqs[i]);
> +	kfree(ndev->srqs);
>  	return ret;
>  }
>  
> @@ -908,7 +993,7 @@ static void nvmet_rdma_free_dev(struct kref *ref)
>  	list_del(&ndev->entry);
>  	mutex_unlock(&device_list_mutex);
>  
> -	nvmet_rdma_destroy_srq(ndev);
> +	nvmet_rdma_destroy_srqs(ndev);
>  	ib_dealloc_pd(ndev->pd);
>  
>  	kfree(ndev);
> @@ -954,7 +1039,7 @@ static void nvmet_rdma_free_dev(struct kref
> *ref)
>  		goto out_free_dev;
>  
>  	if (nvmet_rdma_use_srq) {
> -		ret = nvmet_rdma_init_srq(ndev);
> +		ret = nvmet_rdma_init_srqs(ndev);
>  		if (ret)
>  			goto out_free_pd;
>  	}
> @@ -978,14 +1063,7 @@ static int nvmet_rdma_create_queue_ib(struct
> nvmet_rdma_queue *queue)
>  {
>  	struct ib_qp_init_attr qp_attr;
>  	struct nvmet_rdma_device *ndev = queue->dev;
> -	int comp_vector, nr_cqe, ret, i, factor;
> -
> -	/*
> -	 * Spread the io queues across completion vectors,
> -	 * but still keep all admin queues on vector 0.
> -	 */
> -	comp_vector = !queue->host_qid ? 0 :
> -		queue->idx % ndev->device->num_comp_vectors;
> +	int nr_cqe, ret, i, factor;
>  
>  	/*
>  	 * Reserve CQ slots for RECV + RDMA_READ/RDMA_WRITE +
> RDMA_SEND.
> @@ -993,7 +1071,7 @@ static int nvmet_rdma_create_queue_ib(struct
> nvmet_rdma_queue *queue)
>  	nr_cqe = queue->recv_queue_size + 2 * queue->send_queue_size;
>  
>  	queue->cq = ib_alloc_cq(ndev->device, queue,
> -			nr_cqe + 1, comp_vector,
> +			nr_cqe + 1, queue->comp_vector,
>  			IB_POLL_WORKQUEUE);
>  	if (IS_ERR(queue->cq)) {
>  		ret = PTR_ERR(queue->cq);
> @@ -1017,8 +1095,8 @@ static int nvmet_rdma_create_queue_ib(struct
> nvmet_rdma_queue *queue)
>  	qp_attr.cap.max_send_sge = max(ndev->device->attrs.max_sge_rd,
>  					ndev->device-
> >attrs.max_send_sge);
>  
> -	if (ndev->srq) {
> -		qp_attr.srq = ndev->srq;
> +	if (queue->nsrq) {
> +		qp_attr.srq = queue->nsrq->srq;
>  	} else {
>  		/* +1 for drain */
>  		qp_attr.cap.max_recv_wr = 1 + queue->recv_queue_size;
> @@ -1037,7 +1115,7 @@ static int nvmet_rdma_create_queue_ib(struct
> nvmet_rdma_queue *queue)
>  		 __func__, queue->cq->cqe, qp_attr.cap.max_send_sge,
>  		 qp_attr.cap.max_send_wr, queue->cm_id);
>  
> -	if (!ndev->srq) {
> +	if (!queue->nsrq) {
>  		for (i = 0; i < queue->recv_queue_size; i++) {
>  			queue->cmds[i].queue = queue;
>  			ret = nvmet_rdma_post_recv(ndev, &queue-
> >cmds[i]);
> @@ -1073,7 +1151,7 @@ static void nvmet_rdma_free_queue(struct
> nvmet_rdma_queue *queue)
>  	nvmet_sq_destroy(&queue->nvme_sq);
>  
>  	nvmet_rdma_destroy_queue_ib(queue);
> -	if (!queue->dev->srq) {
> +	if (!queue->nsrq) {
>  		nvmet_rdma_free_cmds(queue->dev, queue->cmds,
>  				queue->recv_queue_size,
>  				!queue->host_qid);
> @@ -1185,13 +1263,23 @@ static int nvmet_rdma_cm_reject(struct
> rdma_cm_id *cm_id,
>  		goto out_destroy_sq;
>  	}
>  
> +	/*
> +	 * Spread the io queues across completion vectors,
> +	 * but still keep all admin queues on vector 0.
> +	 */
> +	queue->comp_vector = !queue->host_qid ? 0 :
> +		queue->idx % ndev->device->num_comp_vectors;
> +
> +
>  	ret = nvmet_rdma_alloc_rsps(queue);
>  	if (ret) {
>  		ret = NVME_RDMA_CM_NO_RSC;
>  		goto out_ida_remove;
>  	}
>  
> -	if (!ndev->srq) {
> +	if (ndev->srqs) {
> +		queue->nsrq = ndev->srqs[queue->comp_vector % ndev-
> >srq_count];
> +	} else {
>  		queue->cmds = nvmet_rdma_alloc_cmds(ndev,
>  				queue->recv_queue_size,
>  				!queue->host_qid);
> @@ -1212,7 +1300,7 @@ static int nvmet_rdma_cm_reject(struct
> rdma_cm_id *cm_id,
>  	return queue;
>  
>  out_free_cmds:
> -	if (!ndev->srq) {
> +	if (!queue->nsrq) {
>  		nvmet_rdma_free_cmds(queue->dev, queue->cmds,
>  				queue->recv_queue_size,
>  				!queue->host_qid);
> @@ -1238,6 +1326,10 @@ static void nvmet_rdma_qp_event(struct
> ib_event *event, void *priv)
>  	case IB_EVENT_COMM_EST:
>  		rdma_notify(queue->cm_id, event->event);
>  		break;
> +	case IB_EVENT_QP_LAST_WQE_REACHED:
> +		pr_debug("received last WQE reached event for
> queue=0x%p\n",
> +			 queue);
> +		break;
>  	default:
>  		pr_err("received IB QP event: %s (%d)\n",
>  		       ib_event_msg(event->event), event->event);

Max 
I will test this.
Is this against latest 5.6


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
