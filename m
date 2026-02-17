Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42DEE9A03E
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Feb 2026 20:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=19W4bESQTthRROBQBDtN6msUOIDUGNQ3AA4N/fS7CoQ=; b=lcel5fJSnEpYIYmf+Dr1/+FLSs
	mwI2TpO1D+rB/1qrZYCrTXN+/yBjEoTQvg5cojr6JCxWV7RVRfXhfxV5F1/cIJAQi8RIzaJu39ISN
	/nwsf1dinGthLC/JeXFxSc/MEMzS/SOeNOAY0w9iv+mW4qMVdr60XeshPT/PTvHQz6rdyZgRE9lSK
	je3cQj6dZcVWrHzuug2NDCHPPbJrSJNGB1EW3UE7Futer6XZ8X1/DTF1BAu4MJJ2yakxGrIft0fAs
	RiQdznzHu94Ltbwu53EUml4o+kjHtJtvItdLShuwosAaOAAj6EBLDzMjqW4bfvMTPwCQkaFLcYjR1
	vfzrYjcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsRh8-00000008rgb-1svZ;
	Tue, 17 Feb 2026 20:29:18 +0000
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsRh5-00000008rgG-1mzS
	for linux-nvme@lists.infradead.org;
	Tue, 17 Feb 2026 20:29:16 +0000
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-2b6b0500e06so5311704eec.1
        for <linux-nvme@lists.infradead.org>; Tue, 17 Feb 2026 12:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771360154; x=1771964954; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=19W4bESQTthRROBQBDtN6msUOIDUGNQ3AA4N/fS7CoQ=;
        b=U2KxVpqU79mRFAkXeivM0w9Iiov7Bbu2NuWkKOsUfMT3LCG1q9DgrdRpils6/3m1xf
         sr1At+tEG9If7WcydE8O1810md/zDurtIHo/3mSGOhOxHgCEpCagxw17DlmHo+Rmv2ui
         l3JxdDFSqIuFCCYDpPFlWMZBhsixCPyhTQr/KAGx9Y2MR1zPD04C61QvIPpQpOcGYm3z
         H7Zco9Q7W83HSSHmNZTO7pTM83sQ70QW6eM2yHu9mG0rMwSKzXtF8ZH42EXwwnvcWs3m
         slNrMhqhLMaYhPAZRTkZbryr9Ufk1OPf+0gIdPOFFasWj/dY0TNrODqRbuYSUx5Wcav3
         vQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771360154; x=1771964954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19W4bESQTthRROBQBDtN6msUOIDUGNQ3AA4N/fS7CoQ=;
        b=XBiiMdUd8t1tMp5qwArNZBChKzYY5/KXXM57kIAxpucI8xgD5MQZTaRaOT28jFC8dc
         VUlVuGNwl9HtImht/kZ3c9OaSG2x9g7FOb8mTW945QXIw4zN4HrmD7JIkr6s4/h1e9cm
         eTo/kgMpwIuyJiTqqA0Rvu6f3d6N39Z0s5t4yRuVw+wIJqWFHka5yEjUjnbLpcTKZiFU
         HmIP8HuiGeFU9EkYcA6lCaQU58K+pCDKhIJRgM/cz4gg1DNVZlWfxAxQTbE6acxcPCjj
         ov1BKYqyr7VCZxFiYGnj8jREmVazn4MrkJW9mCuWS2jDBqlaQGHTOp1doqRyc7XJKRiU
         ZYMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMJvYsto9dCbNDe33Dn70U6ikylOJNIeEpHtykHYsYCwhEGUWRfL/TXNgOpfkpGbjxYbLSYFFA5xhT@lists.infradead.org
X-Gm-Message-State: AOJu0Ywedf4PK28A6sqR331a5ET/cg4UrtUVhb4jWSWPsa6jyojCWILo
	2w7+awyinOtvJEkSgITKn02fjDTFAtqqpmuJimU+b4GuCNoYSOOnuqfPGMflTnoChOc=
X-Gm-Gg: AZuq6aIECJT2TRf6MzFFjJBrpR5z7D+2h2/wRDhYfoNTb1jhSRUKLH6/UeniTMydEbS
	r2N9d3DLihxVks08yXsmQ+LRrwco+mo7VV1gp7sfe/UFG9BAir3OA5VTJUiV8/VuvyGBv46aoYW
	Fd+p3Cz5YLANwdHfHjk+9Xbd3ZS4lOVie5aKTrg9kA74SBdmqRb1Gd5TqIcYjJWnUwCBuFWqMrq
	2WpEN0LBVpox6UUWZ1rrJLkIeWudMi2laNjhhqkBTTqEQbp5VeXhauQ9o/sK4tuH9S1TBXp6O9R
	TIAxSoDiF9DqaaZ0ikLhTx5oW7d6j3JIT29nxoM6u8i2KQaC6/A5sMfCqv7DPTBntxET83t/nK2
	IF+GwBpYoCpFum1wykgeGqt/gUhEi91oAuy7Jht4R0fTmdQvWgfqQf/kET0cbpV1XwJOiv94EeZ
	7zT5kxwRUWcqFFJNgRC0jsmDvGSkcJ14fzKByNlB6cUWMmLObcMdInqA==
X-Received: by 2002:a05:7300:d70b:b0:2b8:2910:dc9b with SMTP id 5a478bee46e88-2baba010c12mr6266426eec.3.1771360154154;
        Tue, 17 Feb 2026 12:29:14 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2bacb5439c6sm18838230eec.6.2026.02.17.12.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 12:29:13 -0800 (PST)
Date: Tue, 17 Feb 2026 12:29:12 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mlombard@bsdbackstore.eu
Subject: Re: [PATCH RFC 5/5] nvme: use per controller timeout waits over
 depending on global default
Message-ID: <20260217202912.GK3435530-mkhalfella@purestorage.com>
References: <20260212120951.79738-1-mlombard@redhat.com>
 <20260212120951.79738-6-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212120951.79738-6-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_122915_492862_99B48535 
X-CRM114-Status: GOOD (  19.70  )
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

On Thu 2026-02-12 13:09:51 +0100, Maurizio Lombardi wrote:
> Instead of passing NVME_IO_TIMEOUT as a parameter with every call to
> nvme_wait_freeze_timeout, use the controller's preferred timeout.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>

Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>

> ---
>  drivers/nvme/host/apple.c | 2 +-
>  drivers/nvme/host/core.c  | 5 +++--
>  drivers/nvme/host/nvme.h  | 2 +-
>  drivers/nvme/host/pci.c   | 2 +-
>  drivers/nvme/host/rdma.c  | 2 +-
>  drivers/nvme/host/tcp.c   | 2 +-
>  6 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index e9bb64e3ec9c..c29c1f45f73a 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -858,7 +858,7 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
>  	 * doing a safe shutdown.
>  	 */
>  	if (!dead && shutdown && freeze)
> -		nvme_wait_freeze_timeout(&anv->ctrl, NVME_IO_TIMEOUT);
> +		nvme_wait_freeze_timeout(&anv->ctrl);
>  
>  	nvme_quiesce_io_queues(&anv->ctrl);
>  
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index cc7d725bd6ff..c1b1a5d08838 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5215,16 +5215,17 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
>  }
>  EXPORT_SYMBOL_GPL(nvme_unfreeze);
>  
> -int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
> +int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl)
>  {
>  	struct nvme_ns *ns;
>  	int srcu_idx;
> +	unsigned long timeout = ctrl->io_timeout;

nit: Maybe move this to the top before ns?

>  
>  	srcu_idx = srcu_read_lock(&ctrl->srcu);
>  	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
>  				 srcu_read_lock_held(&ctrl->srcu)) {
>  		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
> -		if (timeout <= 0)
> +		if (!timeout)
>  			break;
>  	}
>  	srcu_read_unlock(&ctrl->srcu, srcu_idx);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index ef390a020d8d..c59228895bf0 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -840,7 +840,7 @@ void nvme_sync_queues(struct nvme_ctrl *ctrl);
>  void nvme_sync_io_queues(struct nvme_ctrl *ctrl);
>  void nvme_unfreeze(struct nvme_ctrl *ctrl);
>  void nvme_wait_freeze(struct nvme_ctrl *ctrl);
> -int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
> +int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl);
>  void nvme_start_freeze(struct nvme_ctrl *ctrl);
>  
>  static inline enum req_op nvme_req_op(struct nvme_command *cmd)
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 853cd57e4480..0bd533ddc07c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3096,7 +3096,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  		 * if doing a safe shutdown.
>  		 */
>  		if (!dead && shutdown)
> -			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
> +			nvme_wait_freeze_timeout(&dev->ctrl);
>  	}
>  
>  	nvme_quiesce_io_queues(&dev->ctrl);
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 35c0822edb2d..c8859367ffff 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -888,7 +888,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
>  	if (!new) {
>  		nvme_start_freeze(&ctrl->ctrl);
>  		nvme_unquiesce_io_queues(&ctrl->ctrl);
> -		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
> +		if (!nvme_wait_freeze_timeout(&ctrl->ctrl)) {
>  			/*
>  			 * If we timed out waiting for freeze we are likely to
>  			 * be stuck.  Fail the controller initialization just
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 69cb04406b47..0f78fa8f1cbc 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2193,7 +2193,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>  	if (!new) {
>  		nvme_start_freeze(ctrl);
>  		nvme_unquiesce_io_queues(ctrl);
> -		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
> +		if (!nvme_wait_freeze_timeout(ctrl)) {
>  			/*
>  			 * If we timed out waiting for freeze we are likely to
>  			 * be stuck.  Fail the controller initialization just
> -- 
> 2.53.0
> 
> 

