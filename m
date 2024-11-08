Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5140CD64065
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 16:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n6TG5sWodVzy+9LY+HkD51j09bh/h2UugCg3FpvnmJ0=; b=Sd3XiD7yo8dDII1G1b9cQ9LjtA
	MOjbLsBQlvdU9UCNQ4nQnl9Btez73Oy1ZD4h0qySJzN3HzQe6zGjzLX88DVuo1HqqsY1iBw9mf9hz
	eyzvCv35Snj7fbnvMzzSxXddULO9Miq1KPSP57Zg9kUSbbguIobXhoIhO+d4hAbx+FhsWf4pkNP8r
	BTtRDcr3vSZxl63rL1nnH8Co25Tjip7t7o93NBvZOI+CIM3HLhee6SdxeEu5tDfeY9Max++LUNtf6
	4xiASgSxESrAITd/Zd2z472Zqhka3nRz9PDvqkiKCSyKp69lhrRmxZxe5RMUXIRFDrNdcaXPH9i/K
	LPGN2uiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Rvw-0000000BEt7-1k1n;
	Fri, 08 Nov 2024 16:34:05 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9ReI-0000000BAaU-0k6z
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 16:15:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D709B5C105D;
	Fri,  8 Nov 2024 16:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9DBC4CECD;
	Fri,  8 Nov 2024 16:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731082549;
	bh=Ns0KmvO4abh5G6jxdTCCHy8/YGOrOWNMi7Z2ZXtHUKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KUm45SWq4cpDobMNHHK2DFEwn9YQcByJf9BGdO1ravP6ufXMRE6afzYxEJwbLzsFh
	 LsfCpedH/QWKoKP5VVv4fi014yaZdpe/tHo8QPaTGNjWRHOAiFFXHqeT5Ygja5V/cE
	 MjLYz30bZU6eQcvMquf7+pHMcyaz0WM3ry5+MmHAUwf585KcjUSYlEBcBX2OOo8CdA
	 a9MzWxuHnGpZz0LQgzSyFI0+/Pr9vBZpsYnh84/k8XKiW8JUaWF5yp+uG4qNsDhOUj
	 FxCsR4HfJJ52K0nT5Qy3AnFy57fEIMAY3MOZIgsEOByjIEc7i5gWvAbxumaq8nDg0Q
	 bKqVJdwKeplGw==
Date: Fri, 8 Nov 2024 09:15:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	m@bjorling.me, matias.bjorling@wdc.com, kch@nvidia.com,
	kanie@linux.alibaba.com
Subject: Re: [PATCHv4 13/13] nvmet: report ns's vwc not present
Message-ID: <Zy45M1HRz8cKLPxf@kbusch-mbp>
References: <20241107193849.995554-1-kbusch@meta.com>
 <20241107193849.995554-14-kbusch@meta.com>
 <20241108142743.GG6694@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108142743.GG6694@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_081550_280589_6CD5FDE6 
X-CRM114-Status: GOOD (  13.21  )
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

On Fri, Nov 08, 2024 at 03:27:43PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 07, 2024 at 11:38:48AM -0800, Keith Busch wrote:
> > diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> > index 516af7b419189..f688d7fdf7d67 100644
> > --- a/drivers/nvme/target/admin-cmd.c
> > +++ b/drivers/nvme/target/admin-cmd.c
> > @@ -915,6 +915,9 @@ static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
> >  		id->nsattr |= NVME_NS_ATTR_RO;
> >  	if (req->ns->bdev && !bdev_nonrot(req->ns->bdev))
> >  		id->nsfeat |= NVME_NS_ROTATIONAL;
> > +	if ((req->ns->file && !req->ns->buffered_io) ||
> 
> I don't think this check is correct.  Direct I/O still requires cache
> flushes for durability.

Oh, right. Would it be sufficient to check the file's block device for
write caching?

	if ((req->ns->file && !req->ns->buffered_io &&
		bdev_write_cache(file_inode(req->ns->file)->i_sb->s_bdev))

