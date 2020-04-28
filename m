Return-Path: <SRS0=qSsZ=6M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D2DC83000
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 07:08:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66AF4206A5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 07:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C/HoR0o0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AF4206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SEeaCyOJtmruW+xNJyeJ5iShbz9fq9Sw1xm37MJyItI=; b=C/HoR0o0TUte+z
	bSXdeDGg58KEmHPg6whE5OJMj5sVZxUW+KNfMw9uXNc6bE+AnCaT8kAMjpea/rvW+8sYuhgwjz66F
	XFchtnBpYOn8C7nfkJI46v9ymJs7mhWYRcud+Fr4nl82LRLAGyVyaewDis2C53vhz7JlnYJKq128J
	c5eeWKMoPAHNApekZ8wXftb5YVQ2umMzZ/b0bFhxpMV5Zk4HkQvZJL2MgZpwITF5XquY+N/BaO0L5
	DDDUBTXiK2WKnn3KULCPD5AMGhgu5Sqit9M+Ul4URjqV4sCnjeOSYkuI2G8pkQ84LQsyZstsPF30I
	1uyoLm/oObFxpoZCSrtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTKMT-0003cM-3Z; Tue, 28 Apr 2020 07:08:57 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTKMQ-0003bu-MC
 for linux-nvme@lists.infradead.org; Tue, 28 Apr 2020 07:08:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7117368CEC; Tue, 28 Apr 2020 09:08:48 +0200 (CEST)
Date: Tue, 28 Apr 2020 09:08:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-pci: remove volatile cqes
Message-ID: <20200428070848.GD18754@lst.de>
References: <20200427191446.2195863-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200427191446.2195863-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200428_000854_872909_84F24870 
X-CRM114-Status: GOOD (  14.36  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Apr 27, 2020 at 12:14:46PM -0700, Keith Busch wrote:
> The completion queue entry is not volatile once the phase is confirmed.
> Remove the volaitle keywords and check the phase using the appropriate
> READ_ONCE() accessor, allowing the compiler to optimize the remaining
> completion path.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/pci.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8ebcf40f04fe..cf386c84588b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -166,7 +166,7 @@ struct nvme_queue {
>  	void *sq_cmds;
>  	 /* only used for poll queues: */
>  	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
> -	volatile struct nvme_completion *cqes;
> +	struct nvme_completion *cqes;
>  	dma_addr_t sq_dma_addr;
>  	dma_addr_t cq_dma_addr;
>  	u32 __iomem *q_db;
> @@ -908,8 +908,9 @@ static void nvme_pci_complete_rq(struct request *req)
>  /* We read the CQE phase first to check if the rest of the entry is valid */
>  static inline bool nvme_cqe_pending(struct nvme_queue *nvmeq)
>  {
> -	return (le16_to_cpu(nvmeq->cqes[nvmeq->cq_head].status) & 1) ==
> -			nvmeq->cq_phase;
> +	return (le16_to_cpu(
> +			READ_ONCE(nvmeq->cqes[nvmeq->cq_head].status)) & 1) ==
> +				nvmeq->cq_phase;

Despite the sound logic this just visually looks horrible.  How about:

static inline bool nvme_cqe_pending(struct nvme_queue *nvmeq)
{
	struct nvme_completion *hcqe = &nvmeq->cqes[nvmeq->cq_head];

	return (le16_to_cpu(READ_ONCE(hcqe->status)) & 1) == nvmeq->cq_phase;
}

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
