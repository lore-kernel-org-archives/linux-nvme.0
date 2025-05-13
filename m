Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B43AC3ABC9
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 07:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YiZgXLxZdbmrma23CM2pd1PtNDdXf148TT5hq+OX7tM=; b=vZ/jeCviXoJItN41wsgId3aDoJ
	NCEQt6HCLTjYWcattASLiNrLZW9SlPTXtwCdhyuQaXYwerg2NBpsr6ZvaFXZurKxLM7pnenpzWhYc
	0e3My6o48sLPDd+LRWq3i24SjGmojsG/ouOBC6L+HBh213J4DDtmruzNnHZojmInttDIe8gQGmIZn
	nb8whVxDvko3BPk6mMZKb+HvWctHWDrrIsoFbesi4WBHkUmx+ce7Htmsf+nkf3Etv16zHJ/52jiaB
	idcSB3Rd6rnXGDtwnQpzZ/rSzAgL3dWYR50xOZVmR1H8lG4/pxE8zQjaN84FvrWPo21Bbaq1UVeBU
	JwwCeSKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEkOw-0000000BgeW-0JDi;
	Tue, 13 May 2025 07:50:10 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEkKH-0000000BfOW-0PUc
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 07:45:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 85D4B60010;
	Tue, 13 May 2025 07:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A18CC4CEE4;
	Tue, 13 May 2025 07:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747122320;
	bh=zFFou1nSjEZdPEx5kgVt+IU0Q+nsFOIngkEPYFZO0bE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cELoUH2Ze+N/pW9p8ObOWH8epdHf1PovCaTj7GLYUOe0ufRiX+d8PvmIklyIb3ON2
	 0j6C+N4Wp8u5St88AFavLpcM3tfpJ38m2f5kvfsEvqcRqHkfHMKcPxbWlNvt9HQKQk
	 DZcbw8Kbn8QvdT0j9NQwQfS9MnGX5YNYkGoKmFh8T+LxWF6um/GFP4BlpMXa+aDbp8
	 ScZaJdU8H+Yqfbms37YokSuZXYe38jkztzLuZsIP9tKW8McJ0zCgTbhk3T3DXfk9fh
	 l18m39tuYfR6tItO4ymvJc3aa8aCVGzJllzHu2ogqyuGLeMx5u0LF4C7B5+0s1VzAx
	 6Hp+xdTRsCO6w==
Date: Tue, 13 May 2025 10:45:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/7] nvme-pci: don't try to use SGLs for metadata on the
 admin queue
Message-ID: <20250513074515.GK22843@unreal>
References: <20250513070025.830930-1-hch@lst.de>
 <20250513070025.830930-2-hch@lst.de>
 <20250513072842.GH22843@unreal>
 <20250513073908.GB2521@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513073908.GB2521@lst.de>
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

On Tue, May 13, 2025 at 09:39:08AM +0200, Christoph Hellwig wrote:
> On Tue, May 13, 2025 at 10:28:42AM +0300, Leon Romanovsky wrote:
> > > -	if (nvme_pci_metadata_use_sgls(dev, req))
> > > +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> > > +
> > > +	if ((iod->cmd.common.flags & NVME_CMD_SGL_METABUF) &&
> > 
> > Won't it be more future error proof to check for NVME_CMD_SGL_ALL?
> 
> No really, as this is used to decide to call into the routine that
> sets NVME_CMD_SGL_METASEG.

I see same NVME_CMD_SGL_ALL check in target code.

  1642 u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
  1643 {

<...>

  1656         /* For PCI controllers, admin commands shall not use SGL. */
  1657         if (nvmet_is_pci_ctrl(req->sq->ctrl) && !req->sq->qid &&
  1658             cmd->common.flags & NVME_CMD_SGL_ALL)
  1659                 return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;

Thanks

