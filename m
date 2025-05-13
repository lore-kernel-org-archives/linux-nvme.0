Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5C2C3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 07:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wOLyvpaEvnx21vkFFUJdAYt5isYnHZGJ0eK2gd33a8E=; b=e2gyxzd6QkQm+gF2x+DCRUlGcb
	JiaHRxxFkwXfuXHkUGgIRo+svsZ2nVTjQYV9XbOk4ohutlUh9j32hb+YxrqqZ88215zyZBQXM99Iy
	Xd7F9qfiLkUVZhEFwLX296RxxJ3RgudKqGdrns6E2uJYJDMirTC7KEVwePr7/+8gfXNgIgofmlzO8
	+CqKfCbzV9HjU9W6Cf8iTx4kBbQ70TJFjZ9EQpoa6r8vbPXhstPU9xazEdrfyHVpTtyaNQN+Z9M+3
	u/DDWR1h9EeqX6BR4saq3oD2ZHwOr7jDaeOMqnNQmCqaY14L2kfD3BI+cwRWPxHfd2t63tj/JA9od
	/EUI0Dxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEkFG-0000000BeAu-2z5p;
	Tue, 13 May 2025 07:40:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEkEM-0000000Bdye-0pSB
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 07:39:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 018A767373; Tue, 13 May 2025 09:39:08 +0200 (CEST)
Date: Tue, 13 May 2025 09:39:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/7] nvme-pci: don't try to use SGLs for metadata on
 the admin queue
Message-ID: <20250513073908.GB2521@lst.de>
References: <20250513070025.830930-1-hch@lst.de> <20250513070025.830930-2-hch@lst.de> <20250513072842.GH22843@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513072842.GH22843@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_003914_381023_40B2A6EE 
X-CRM114-Status: GOOD (  14.99  )
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

On Tue, May 13, 2025 at 10:28:42AM +0300, Leon Romanovsky wrote:
> > -	if (nvme_pci_metadata_use_sgls(dev, req))
> > +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> > +
> > +	if ((iod->cmd.common.flags & NVME_CMD_SGL_METABUF) &&
> 
> Won't it be more future error proof to check for NVME_CMD_SGL_ALL?

No really, as this is used to decide to call into the routine that
sets NVME_CMD_SGL_METASEG.


