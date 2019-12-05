Return-Path: <SRS0=qSen=Z3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91AAC43603
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2019 20:31:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A98A924670
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2019 20:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BdLxuu9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98A924670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Z6RGPsCSMSF5OkkR2kZmAMpTbop6JOnfSBZYMAtGvOI=; b=BdLxuu9gjukCCvfBNDkp5PSwR
	EV3Vyg2vth8cFhRUE0VkEJBONx2OJ5rquoKmGiY7EZEKlrM+nOezm8KeoiaxnYpDJ0ruvk4Crl5I+
	n+SjxP4wUXkN0gMgZNJE5ymhCZN0EL/VX0eQEX2LpNCu50CNMbki7u9zWit54ps2dIzGcmYCSTvyH
	wtuFvl/ehGKwh28BW+09LzcEjSmRcrpzfV/LxR16LHMkXztBXXVn4xCskHVKnNcHRefmh3CboygBd
	a0jm8Qzlk/KDX8fJOmezaJeuBx232B/8ZaYi0YZaPk3Oh/dTlyUuyNIR0TVRdcedQHCIjhw1B3RsE
	iSSHrQeqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1icxmZ-0003Z2-H3; Thu, 05 Dec 2019 20:31:27 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icxmW-0003YO-T8
 for linux-nvme@lists.infradead.org; Thu, 05 Dec 2019 20:31:26 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Dec 2019 12:31:22 -0800
X-IronPort-AV: E=Sophos;i="5.69,282,1571727600"; d="scan'208";a="201889449"
Received: from edmundna-mobl.amr.corp.intel.com (HELO [10.252.139.183])
 ([10.252.139.183])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 05 Dec 2019 12:31:21 -0800
Subject: Re: [PATCH] nvme/pci: Remove last_sq_tail
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me
References: <20191205200825.27651-1-kbusch@kernel.org>
From: "Nadolski, Edmund" <edmund.nadolski@intel.com>
Message-ID: <149bb39b-e8ab-36a5-f319-18ef5e3567b6@intel.com>
Date: Thu, 5 Dec 2019 13:31:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205200825.27651-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191205_123124_951174_F36455F0 
X-CRM114-Status: GOOD (  15.55  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/5/2019 1:08 PM, Keith Busch wrote:
> We don't allocate enough tags to wrap the submission queue. Remove
> tracking for this condition.

Can we ensure that this presumption won't change?

> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/pci.c | 20 ++++----------------
>   1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 0590640ba62c..3acd1b4d7735 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -174,7 +174,6 @@ struct nvme_queue {
>   	u16 q_depth;
>   	u16 cq_vector;
>   	u16 sq_tail;
> -	u16 last_sq_tail;
>   	u16 cq_head;
>   	u16 qid;
>   	u8 cq_phase;
> @@ -462,21 +461,11 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
>   /*
>    * Write sq tail if we are asked to, or if the next command would wrap.

Comment needs to be updated.

Ed

>    */
> -static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
> +static inline void nvme_write_sq_db(struct nvme_queue *nvmeq)
>   {
> -	if (!write_sq) {
> -		u16 next_tail = nvmeq->sq_tail + 1;
> -
> -		if (next_tail == nvmeq->q_depth)
> -			next_tail = 0;
> -		if (next_tail != nvmeq->last_sq_tail)
> -			return;
> -	}
> -
>   	if (nvme_dbbuf_update_and_check_event(nvmeq->sq_tail,
>   			nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
>   		writel(nvmeq->sq_tail, nvmeq->q_db);
> -	nvmeq->last_sq_tail = nvmeq->sq_tail;
>   }
>   
>   /**
> @@ -493,7 +482,8 @@ static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
>   	       cmd, sizeof(*cmd));
>   	if (++nvmeq->sq_tail == nvmeq->q_depth)
>   		nvmeq->sq_tail = 0;
> -	nvme_write_sq_db(nvmeq, write_sq);
> +	if (write_sq)
> +		nvme_write_sq_db(nvmeq);
>   	spin_unlock(&nvmeq->sq_lock);
>   }
>   
> @@ -502,8 +492,7 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
>   	struct nvme_queue *nvmeq = hctx->driver_data;
>   
>   	spin_lock(&nvmeq->sq_lock);
> -	if (nvmeq->sq_tail != nvmeq->last_sq_tail)
> -		nvme_write_sq_db(nvmeq, true);
> +	nvme_write_sq_db(nvmeq);
>   	spin_unlock(&nvmeq->sq_lock);
>   }
>   
> @@ -1511,7 +1500,6 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
>   	struct nvme_dev *dev = nvmeq->dev;
>   
>   	nvmeq->sq_tail = 0;
> -	nvmeq->last_sq_tail = 0;
>   	nvmeq->cq_head = 0;
>   	nvmeq->cq_phase = 1;
>   	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
> 


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
