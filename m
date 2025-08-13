Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AFBCA0EC4
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 07:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n5vHg+yfkowJdV/pIjALchhDpJpI60PaEjA+wL86jNs=; b=U/LM6GF9VyxQ+wF3bldrwGSHw1
	uz8ZxvH3MobHPUKs8wLINjhzQkJ9XNQZRy940h5hESOGvqdct2i+SORI5F46WRpHStVxOcPAsQWZF
	7WNtXSkvn7EN6fVxrh2C/XahOXl+nSf5alT5+fYBvWRFajS/GUlnMQYS5Nowvd+QQYM1YFRbtTxeh
	O6avC5nMcq0JhwdOUeNmpbqFOysJqupWHrYtpR2KTtUyA9nGmy5Bu5QdT+WsawlCw/Eqn/GkjoCIX
	oPLLTp0jxnBniHsr1H3NNsXN2eoAgzOX/6VTr2kqAdexQDN/Z832Yptbyi04OomiEx999cUzqYdCc
	6v1w32WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um66T-0000000CxKk-3z1v;
	Wed, 13 Aug 2025 07:40:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um5L0-0000000CqGh-3XLZ
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 06:51:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9992668AA6; Wed, 13 Aug 2025 08:51:50 +0200 (CEST)
Date: Wed, 13 Aug 2025 08:51:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv6 7/8] nvme-pci: create common sgl unmapping helper
Message-ID: <20250813065150.GA12473@lst.de>
References: <20250812135210.4172178-1-kbusch@meta.com> <20250812135210.4172178-8-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812135210.4172178-8-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_235155_028190_A7ABD31D 
X-CRM114-Status: GOOD (  11.90  )
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

On Tue, Aug 12, 2025 at 06:52:09AM -0700, Keith Busch wrote:
> +static void nvme_free_sgls(struct request *req)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	struct nvme_sgl_desc *sg_list = iod->descriptors[0];
> +	struct nvme_sgl_desc *sge = &iod->cmd.common.dptr.sgl;
> +
> +	__nvme_free_sgls(req, sge, sg_list);

No real need for the local variables for sg_list and sge.

And I'd just kill this function and rename __nvme_free_sgls to
nvme_free_sgls.  But if you think that's just noise right now I'd
be happy to do a clean up pass later.

Reviewed-by: Christoph Hellwig <hch@lst.de>


