Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC034C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 16:53:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9CF60F59
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 16:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B9CF60F59
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DXQb2ODWYVrBlSSfgo4I7dnAxsgs0cWJdRaLyANSOtA=; b=WJqinloKn4ur/e7ctDs7s/WUa6
	RXoJFXE8s+WplySNh5nAmkL3vdb3mn1oVhY7JhG/Izlx99VpaLxVljlk8vUFPKTYZJF4bEMaxt3Nq
	+aseioZfCQWOw+fUlj+Y4r3AdqY6atej1DOgR+33Pot7J5IPS3MYEA3YNtPb0KtWiS5ivTVtwUFYY
	iHRImLWnkyvS9COiwLZcmOqu1QWIfWddN2naBJsjWg6JXzupsH226XwB8zS7kQ+VYa7UqRgsGbypY
	3ok9alLH33m4U3IErx+GxOMmUTmn0MSt6FFKaoi0Rca3yctmMkN6NMdx6CUmbug5wUx33Qjh9ssxz
	bvBXQ8Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mb3z9-003ukV-Fy; Thu, 14 Oct 2021 16:53:39 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mb3z4-003uik-Py
 for linux-nvme@lists.infradead.org; Thu, 14 Oct 2021 16:53:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E9F4868B05; Thu, 14 Oct 2021 18:53:27 +0200 (CEST)
Date: Thu, 14 Oct 2021 18:53:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 John Levon <levon@movementarian.org>
Subject: Re: [PATCHv2 2/2] nvme-pci: remove cached shadow doorbell offsets
Message-ID: <20211014165327.GA4148@lst.de>
References: <20211014164543.1821327-1-kbusch@kernel.org>
 <20211014164543.1821327-3-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014164543.1821327-3-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211014_095335_027317_7131DAB1 
X-CRM114-Status: GOOD (  12.47  )
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

On Thu, Oct 14, 2021 at 09:45:43AM -0700, Keith Busch wrote:
> +static bool nvme_dbbuf_update_sq(struct nvme_queue *nvmeq)
> +{
> +	struct nvme_dev *dev = nvmeq->dev;
>  
> +	if (!dev->dbbuf_dbs)
> +		return true;
> +
> +	return nvme_dbbuf_update_and_check_event(nvmeq->sq_tail,
> +		&dev->dbbuf_dbs[sq_idx(nvmeq->qid, dev->db_stride)],
> +		&dev->dbbuf_eis[sq_idx(nvmeq->qid, dev->db_stride)]);
> +}
> +
> +static bool nvme_dbbuf_update_cq(struct nvme_queue *nvmeq)
> +{
> +	struct nvme_dev *dev = nvmeq->dev;
> +
> +	if (!dev->dbbuf_dbs)
> +		return true;
> +
> +	return nvme_dbbuf_update_and_check_event(nvmeq->cq_head,
> +		&dev->dbbuf_dbs[cq_idx(nvmeq->qid, dev->db_stride)],
> +		&dev->dbbuf_eis[cq_idx(nvmeq->qid, dev->db_stride)]);

This would look much cleaner with a local variable for the offset.

But otherwise it looks sensible to me.

