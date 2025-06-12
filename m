Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4BFC61CE8
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jun 2025 04:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t4w1OTOx6/WNjfbODfQ9nT0jB2BJfoLJMpcVdw+OUwM=; b=yB64x5nGZEtyp9ikn9BNTUwdIh
	86lyT5VYNTxQEpzlB1kcVlDW8ftkAs1ZD2jCiSgF14zkxNHIyNY2UR2kjVBQM5y2BZbo5LrMZerrn
	FfBrqEQyTVFEJJS4ReZM2BHJ5WMDBCcOL1DKXjS85wAB+mymKVEH2ZSGSiujDJEzIF5fLyR8xs550
	2p0mkaseLTj292rWNoScoj0ooOwPpV9TdiOSYaHfGh7i4Q3sxB8oCL+ggaaFH2Iid5mTL3RJuzKef
	4/rcboMfDlc14xMQlm+4HjF93rt2WU3OZxFVLGDLOlzSPu7FPFv7g8rqV/sByetSCIVo4aoUL6hO0
	VitjJPjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPa26-0000000CBHd-0jGF;
	Thu, 12 Jun 2025 04:59:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPa24-0000000CBGd-1fV3
	for linux-nvme@lists.infradead.org;
	Thu, 12 Jun 2025 04:59:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E322968D09; Thu, 12 Jun 2025 06:59:16 +0200 (CEST)
Date: Thu, 12 Jun 2025 06:59:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/9] nvme-pci: simplify nvme_pci_metadata_use_sgls
Message-ID: <20250612045916.GC12863@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-4-hch@lst.de> <aEn3TZO1nGnh3wvK@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEn3TZO1nGnh3wvK@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_215920_583554_EC3AF17D 
X-CRM114-Status: GOOD (  16.24  )
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

On Wed, Jun 11, 2025 at 03:38:22PM -0600, Keith Busch wrote:
> On Tue, Jun 10, 2025 at 07:06:41AM +0200, Christoph Hellwig wrote:
> > +static inline bool nvme_pci_metadata_use_sgls(struct request *req)
> >  {
> > -	if (!nvme_ctrl_meta_sgl_supported(&dev->ctrl))
> > -		return false;
> >  	return req->nr_integrity_segments > 1 ||
> >  		nvme_req(req)->flags & NVME_REQ_USERCMD;
> >  }
> 
> ...
> 
> 
> > @@ -981,7 +979,7 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req)
> >  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> >  
> >  	if ((iod->cmd.common.flags & NVME_CMD_SGL_METABUF) &&
> > -	    nvme_pci_metadata_use_sgls(dev, req))
> > +	    nvme_pci_metadata_use_sgls(req))
> >  		return nvme_pci_setup_meta_sgls(dev, req);
> >  	return nvme_pci_setup_meta_mptr(dev, req);
> >  }
> 
> Am I missing something here? This looks like it forces user commands to
> use metadata SGLs even if the controller doesn't support it.

Yeah, looks like I messed up something here.

