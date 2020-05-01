Return-Path: <SRS0=VrRv=6P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5757C47253
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 12:54:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95479208D6
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 12:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iOQ39lOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95479208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IVjQ11iucGBLtbns5OuPgIwI5T5MZq/TDRCJ6FohRDM=; b=iOQ39lObYmvL80
	dGXZW0rNqmsMPJdn8Ir21gxUWoOMBubF74iwvZZE9anHzWfNX2esV2GIMePYUuZqDf/fDFPZ4Krn1
	esG/J/H6i0u5F4VX1coDfdFmhPSA01u2sxGFc9ZeZEzDI8zqobypn1Hr5WdEARJ5AovSvUxatsMh0
	m4bq4yNhM7g6IdBC4qtOM2Ks6w1VwYAeBLi9tJPKetSDy5eDPUkPpQX7HO3O+b75pQgYkTB41QBPB
	ePjFmjGzJ80rz/EHkR6MbgsWfKE242YaTP+NuXWt4s0UoNonip1Ts2fOVoM6SuMFpWvA51gsOzT6A
	Q///fbVFNJDJs4J60N1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUVBR-0004dR-Pu; Fri, 01 May 2020 12:54:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUVBP-0004d6-8U
 for linux-nvme@lists.infradead.org; Fri, 01 May 2020 12:54:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 94A3068BFE; Fri,  1 May 2020 14:54:20 +0200 (CEST)
Date: Fri, 1 May 2020 14:54:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/3] nvme-pci: remove cached shadow doorbell offsets
Message-ID: <20200501125420.GB5197@lst.de>
References: <20200427235243.2268765-1-kbusch@kernel.org>
 <20200427235243.2268765-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200427235243.2268765-2-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200501_055423_448245_CE64794E 
X-CRM114-Status: GOOD (  11.14  )
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

This doesn't actually apply.  Some comments below anyway:

> +static bool nvme_dbbuf_update_sq(struct nvme_queue *nvmeq)
> +{
> +	struct nvme_dev *dev = nvmeq->dev;
>  
> +	if (!dev->dbbuf_dbs)
> +		return true;

I'd rather have this check in the caller.  That makes it both more
obvious to read, and avoids a function call for the fast path.

> +static bool nvme_dbbuf_update_cq(struct nvme_queue *nvmeq)
> +{
> +	struct nvme_dev *dev = nvmeq->dev;
> +
> +	if (!dev->dbbuf_dbs)
> +		return true;

Same here.

>  static inline void nvme_write_sq_db(struct nvme_queue *nvmeq)
>  {
> +	if (nvme_dbbuf_update_sq(nvmeq))
>  		writel(nvmeq->sq_tail, nvmeq->q_db);
>  }

It might be worth to just open code this in the two callers, even
if the additional check I suggested above.

>  
> @@ -918,11 +918,8 @@ static inline bool nvme_cqe_pending(struct nvme_queue *nvmeq)
>  
>  static inline void nvme_ring_cq_doorbell(struct nvme_queue *nvmeq)
>  {
> +	if (nvme_dbbuf_update_cq(nvmeq))
> +		writel(nvmeq->cq_head, nvmeq->q_db + nvmeq->dev->db_stride);

Same here for the only caller.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
