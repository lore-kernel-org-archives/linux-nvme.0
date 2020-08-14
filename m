Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD892C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:53:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782C920708
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tqggCpJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782C920708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0OZI84gMSzUas3s5B0+DnFT08fMV8v1EbgIQUJH7gEQ=; b=tqggCpJ+Du2bI/ie2EQxHTccQ
	lRfcduAfbCF6BV0XMIl0l8Exvd8TPLSZ2UKIbjD2ihm26qxK1S4rADxGbnfN7ZpJUa7GFXhNJIb+j
	184ofItM5jJzRtKYZ4Pq8NsddXPBjtEGBHyR/fYwdiIid2chKhhFk/ZdrLwHRyGDgQZm/mSsbfknM
	S/jU2e4aiP+cVZyxQnI/LM1WEHwUwsXWilljcRdNcDc3ccZi6g5t3Fd7Y5WPCx+3sYyKeNxV4bidm
	408DP/h3A8WufbSFldqtXFIeYNaW24Cz8ynugVF5eQK8itJIOfBMCHkjLNm2aJs9z8DwrDucsojoY
	cRdUsNs+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6Tb4-0006eu-Dz; Fri, 14 Aug 2020 06:53:50 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6Tb2-0006e2-Cm
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 06:53:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CAF1968CEE; Fri, 14 Aug 2020 08:53:46 +0200 (CEST)
Date: Fri, 14 Aug 2020 08:53:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 8/8] nvme-rdma: fix reset hang if controller died in
 the middle of a reset
Message-ID: <20200814065346.GE1719@lst.de>
References: <20200806191127.592062-1-sagi@grimberg.me>
 <20200806191127.592062-9-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200806191127.592062-9-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_025348_575586_579D8571 
X-CRM114-Status: GOOD (  22.57  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 06, 2020 at 12:11:27PM -0700, Sagi Grimberg wrote:
> If the controller becomes unresponsive in the middle of a reset, we
> will hang because we are waiting for the freeze to complete, but that
> cannot happen since we have commands that are inflight holding the
> q_usage_counter, and we can't blindly fail requests that times out.
> 
> So give a timeout and if we cannot wait for queue freeze before
> unfreezing, fail and have the error handling take care how to
> proceed (either schedule a reconnect of remove the controller).
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/rdma.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 30b401fcc06a..4ca53b864636 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -976,7 +976,13 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
>  
>  	if (!new) {
>  		nvme_start_queues(&ctrl->ctrl);
> -		nvme_wait_freeze(&ctrl->ctrl);
> +		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
> +			/* if we timed out waiting for freeze we are
> +			 * likely stuck, fail just to be safe
> +			 */

			/*
			 * If we timed out waiting for freeze we are likely to
			 * be stuck.  Fail the controller initialization just
			 * to be safe.
			 */

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
