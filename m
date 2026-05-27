Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A1CCD6E41
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 13:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cHvFkbIWWZWiCauhLWtQ0+gUm7NKWE5ClM1AchcZmTI=; b=zwYC/lSV4XB2/HhKaY/+QJjWoU
	us6EWbiIr94f1dB97RDa6QydDEFUcB8JBlIjZSHMcamBCzF9BRFfVIcQxzybO9X4xiU7VQJITJD5L
	RFp79yeX+MpEVHrbNvc6GriQA2v7Si4ACRHt4VHSm7W5gRyLGcYp7QwwhNdZuvAOstU+ThLDCJtgG
	4PONIrg9MSoEmbCmgBxEFScx5JiFMgxih2pOojVNXW4yuBcGCe1sI8V9j6jeaT6OljVYE2VGWEXC9
	qbG+qodbZRwu9mulRuy9Z7zN/fuCW/Fow+d2pJdbobMC11jIU+iPgQX50yQrXguALT/uX6fGA3V8g
	eyfgXH7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSE87-00000004AgC-35jH;
	Wed, 27 May 2026 13:17:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSE85-00000004AfY-183q
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 13:17:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 87F3F68B05; Wed, 27 May 2026 15:16:57 +0200 (CEST)
Date: Wed, 27 May 2026 15:16:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, nilay@linux.ibm.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] nvme: add support multipath passthrough iostats
Message-ID: <20260527131657.GB10351@lst.de>
References: <20260526153921.2402015-1-kbusch@meta.com> <20260526153921.2402015-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526153921.2402015-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_061701_452987_26504C35 
X-CRM114-Status: GOOD (  12.48  )
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

On Tue, May 26, 2026 at 08:39:21AM -0700, Keith Busch wrote:
> +	struct nvme_ns *ns = q->queuedata;
>  	struct request *req;
>  
> +	if (ns && nvme_ns_head_multipath(ns->head))
> +		rq_flags |= REQ_NVME_MPATH;

I just wanted to come with reasons why it this is wrong, but it actually
seems already - we only have a ns for multipath nodes if multipathing
is enabled.  Maybe throw a little comment in on that?

Otherwise looks good.

