Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C45CDB46F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RD9O0+7ug5nR++dAQ65BwecpxZ0gpLqPOcWVl9k6BpI=; b=fKjYfq89ioUGkSnh3s//hO78YP
	+nvQCLvTlpJI6r+RW28n4BOJyIczVIwLB1+D8t7HGn/sZnmhrtExdFRcnDT9gGVhfM4ltZSJLWUCM
	wsZqUw/e6K4niEYr0Qo+ryUNhu1Pv/3+vOD1iJqG8Uymfa8mbz13U+YMonTEHFyxENQodATWf9jDB
	OelFaJ/Ae+R0EJM46j2QqD4CdbFbxI6cTr30ENR2JvYKthzAAvwCTjaH96JsHaqUEhfalMhTOMTxd
	URoTjS/Je7P9vgTQ2MOZLTW7d3rQwWjEZ2GjX7f6vSrz5+VKO3y61DSjEOBTEL5UNFLoooTZzAdjl
	tzO5Z2fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbg4s-000000056fb-3EWH;
	Mon, 22 Jun 2026 14:56:46 +0000
Received: from smtp.missinglinkelectronics.com ([162.55.135.183])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbg4q-000000056fG-1uua
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 14:56:45 +0000
Received: from ubuntu-server (ppp-88-217-75-1.dynamic.mnet-online.de [88.217.75.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: david)
	by smtp.missinglinkelectronics.com (Postfix) with ESMTPSA id 5F4BE202AB;
	Mon, 22 Jun 2026 16:56:42 +0200 (CEST)
Date: Mon, 22 Jun 2026 16:56:22 +0200
From: David Epping <david.epping@missinglinkelectronics.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leon@kernel.org>,
	Joachim Foerster <joachim.foerster@missinglinkelectronics.com>
Subject: Re: [PATCH RFC] nvme-ioctl: propagate PRP1 from ioctl to admin cmd
Message-ID: <ajlNFpz5977PzLvb@ubuntu-server>
References: <ajlDjpjK_clMrnwx@ubuntu-server>
 <ajlIPlEv_zBfTMVG@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajlIPlEv_zBfTMVG@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_075644_668597_58E2F909 
X-CRM114-Status: GOOD (  12.95  )
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

On Mon, Jun 22, 2026 at 08:35:42AM -0600, Keith Busch wrote:
> On Mon, Jun 22, 2026 at 04:15:42PM +0200, David Epping wrote:
> > @@ -306,6 +306,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> >  	c.common.nsid = cpu_to_le32(cmd.nsid);
> >  	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
> >  	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
> > +	c.common.dptr.prp1 = cpu_to_le64(cmd.addr);
> 
> This is not correct: the user space virtual address isn't the device
> DMA'able address. The driver already handles mapping the user address to
> kernel space, then to dma, then sets the PRP accordingly.

To clarify, the ioctl struct addr field is not filled with a memory buffer
address by the userspace, but a PCIe mapped BAR address plus offset.
It is obtained by the userspace application operating the FPGA vfio device
by reading from PCI config space via VFIO_PCI_CONFIG_REGION_INDEX.
So it is the address Linux assigned to that BAR (plus offset).

