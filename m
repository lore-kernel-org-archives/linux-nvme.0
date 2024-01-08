Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758C8C47073
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jan 2024 16:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FE8osF/NDOXdGDQF8cEEfCJMUGYEzyNQXFKxaRlCi+8=; b=TiFeacOhfyPFDsGJmO2lsYYeqM
	OJa7+8vcDoICICBMAq8CQ9tnPez7H1nS1VB9bADyAlhvS0q/ocXyR2/kScq3TCRcV3ImJXowg8z/h
	g9JJZBUJwHma8CSiow9dmfQJ65aQiarSE2pS3zmoVZGmEylVV8dojBqGptizln3OQr5vWAxvt3PVX
	MKMbNdPBY+69o3HoFbgDQ5tjgKB+eONaYG+dd6qZ+nIbbLzg3o3S1nLryXwdeoSvqB2nIr2zpDa9g
	bjnlz50lMFQck2FU/2DmxnFXeHXrmWLD9Q2/BmORbUKJY5KoZiCgQvE+noDEo7QRy/rLz+gt95rCT
	KzUQdFlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMsJT-005biZ-2o;
	Mon, 08 Jan 2024 16:17:19 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMsJQ-005bg7-27
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jan 2024 16:17:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5FBACCE08CE;
	Mon,  8 Jan 2024 16:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27290C433C7;
	Mon,  8 Jan 2024 16:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704730632;
	bh=5hFDQzEnmfTwWcvAEsFICXlXOBTcxp+UA5dr5v3MMRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nlquSGDN/kTOpLTderuXHeoyTAFGO1cuIvp5ObNUG4qjp2zpGt5pk9XcapuY6uazE
	 BRrPiLpq3OCarIIBU5YLAfyOyAK5l7RSUb874EAtsFjDnyfuibG9K72ETZyzyyUxd/
	 kDc6wX9gORpXVziL7h9k5Me0ELjUjOoDlNahBvOvjPaw1MyXp0+jXN2KX4KAfS5S6m
	 0FoAV22J4sDFHY7LP0d0L2ye/HqLX3I7K7+HjiexndcGOInHhuDYC2oxwrjX/9XJfX
	 9pwXpI5FeNjQBAsBvO31RCFIDzg17OKbMAb4+axuwO1LJoC3nkbVV0OSBnKtSQivyg
	 DUDoEgKCxo8MA==
Date: Mon, 8 Jan 2024 09:17:10 -0700
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	chaitanyak@nvidia.com
Subject: Re: [PATCHv3] nvme-pci: enhance timeout kernel log
Message-ID: <ZZwgBgUGSQT23sPE@kbusch-mbp>
References: <20240105182020.2721350-1-kbusch@meta.com>
 <0ec0e324-8261-4e4c-9797-7b3154355305@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ec0e324-8261-4e4c-9797-7b3154355305@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_081716_877540_56BE1227 
X-CRM114-Status: UNSURE (   9.96  )
X-CRM114-Notice: Please train this message.
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

On Sun, Jan 07, 2024 at 02:26:54AM +0200, Max Gurtovoy wrote:
> On 05/01/2024 20:20, Keith Busch wrote:
> >   	 * returned to the driver, or if this is the admin queue.
> >   	 */
> > +	opcode = nvme_req(req)->cmd->common.opcode;
> >   	if (!nvmeq->qid || iod->aborted) {
> >   		dev_warn(dev->ctrl.device,
> > -			 "I/O %d QID %d timeout, reset controller\n",
> > -			 req->tag, nvmeq->qid);
> > +			 "I/O tag %d (%04x) opcode %s %x QID %d timeout, reset controller\n",
> 
> maybe:
> 
> "I/O tag %d (%04x) opcode %#x (%s) QID %d timeout, reset controller\n",
> 
> I'm sending patches to align rdma and tcp to print tag and cid as well.
> 
> otherwise looks good,
> 
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

Thanks for the suggestion. Applied to nvme-6.8.

