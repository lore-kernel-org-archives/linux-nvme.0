Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FA0FED3C3
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 13:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7XA18sH1NdH+cJI1sf82V7NrsVygR4fn6aERoGSWlrk=; b=jL/mTeLlAlMBPkVBBWqn8UawMh
	F7fAFsHApJ685v+hhVOEfZm3L5XJQe9P7NRN8pYZEcZn8DSS/59QZm85Ef3BORsivlRvT1+w+ocWy
	ntxYnN1walOr10QsRrO7oTizXWbKZ3qa8MBba9bakjZWPwFxUA0Uf96bKhOLs2V6Kqug1cuMsEAjr
	m+caa+VTo5sAmfHFq7Hf+mPu/v7JorgGrdLOlEDW9TFZVoI3xI0hWPD2pv2YpZ4szCzaedeDwc+jt
	VxjAKUuRUFE6vs8bf1hNNvMOpCiLeOlixWT4fKFN3m0QLrmoT3KnoZ0srjdnNS1H1pV8NhI9XRdNC
	f4/WzWqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGGWJ-0000000DETN-1v9r;
	Fri, 24 Apr 2026 13:24:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGGWG-0000000DEPi-1dPb
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 13:24:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5D89168D05; Fri, 24 Apr 2026 15:24:23 +0200 (CEST)
Date: Fri, 24 Apr 2026 15:24:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joel Granados <joel.granados@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] nvme: Controller Data Queue (CDQ) support
Message-ID: <20260424132423.GA15833@lst.de>
References: <20260424-jag-cdq-lkml-v1-0-d773343a717c@kernel.org> <20260424130615.GW3611611@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424130615.GW3611611@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_062432_569709_B487D9BA 
X-CRM114-Status: GOOD (  16.70  )
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

On Fri, Apr 24, 2026 at 10:06:15AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 24, 2026 at 01:37:50PM +0200, Joel Granados wrote:
> 
> > There is however, no clear consensus on how NVMe Live Migration should
> > land in the Linux kernel. The 2022 discussion [1] explored a VFIO-based
> > approach but reached no conclusion, likely because the specification was
> > not yet mature.
> 
> Yes it was paused until the spec matures, then I expect it to go
> forward.

And it will happen in the nvme software working group.  Which should be
up an running if Samsung hadn't done everything in the power to torpedo
it.  Because of that I do not exact Samsung to have any major impact in
how this will be implemented in Linux.

Note that we also can't discuss any of this at LSF/MM in public, so
Joel side channel loading it onto the schedule should be removed as well.

