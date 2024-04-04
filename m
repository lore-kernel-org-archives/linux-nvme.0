Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F8CCD1292
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 15:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xH5MKPW/3I3H1VifRR14SxPI094CByCOoz/r9H6Zj9o=; b=WqPf/ZQ8+k4XlvUcLANFizWhwl
	+f3rCgCxhwgqujpMFJRX88AFCwtdOA4aUsv4yiMFPnki0w72ODX468oiN6zxEGy7KeD6XnNKx2SqY
	xL/O90xsnhBxwDO6fDk07DPeD2Vg5516w3DyWIqYzV/Zn42B2ho6Uk9VP9vzf9ZfAo4wTMoV2A/1Z
	6+vSDw3U5TFWhNogwXo1hncob+AkA3coxhSTM/0OktjptgJfGOPMmjVbLzYdqZWckyfw2jUqpWzZI
	XGeVaIeImDLmxQGAFpjRom1CmgFH5dmvWTgPdUcDjITvH4EMeUONTD0aA6LN+87RewMjxNLizX6d5
	CUEjxYJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsPU0-00000003MDr-14fM;
	Thu, 04 Apr 2024 15:58:32 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsPTx-00000003MD1-2BF3
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 15:58:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6EE1BCE32F4;
	Thu,  4 Apr 2024 15:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639DAC433C7;
	Thu,  4 Apr 2024 15:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712246306;
	bh=wPQPEB2RzXD2hXUyTdPaHg2ibCZ3ouToQiruEuzvQSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BycSus+yDyyG74z+gLVFXW4KgJrUV/JVzRTXQkX0Pqw4EWirUtVfaXu1MtXFyoIJs
	 iYJSiI6N3djPGtleGlzZG0ElLcRXDW5ZwPSbtNzx53UbyIqDVXJ++DUI9yhrKbmwTA
	 N6UTpI+bYt2Le3dhwg/iZrfMdkTCHOE06MtXGsAbP9B0bMqefORvAll5hYKSafICSr
	 59ZTcK2Aav/7m6IM8+HLlzFRl7sr58y4NQRMnkhSoELfMxon1Td95yRY/Rux5AY0z4
	 8ejXDWVgbsbxHimVMhVkaXttvaK7YHHPXIPzD2msqD7/1f4uGaM8ZjASywmLs3BmI1
	 qm/xf7cjgBiHw==
Date: Thu, 4 Apr 2024 09:58:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH] nvme: don't create a multipath node for zero capacity
 devices
Message-ID: <Zg7OIDOZkwzaK4J0@kbusch-mbp.dhcp.thefacebook.com>
References: <20240403124717.931577-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403124717.931577-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_085829_778094_76AF0B65 
X-CRM114-Status: UNSURE (   8.73  )
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

On Wed, Apr 03, 2024 at 02:47:17PM +0200, Christoph Hellwig wrote:
> Apparently there are nvme controllers around that report namespaces
> in the namespace list which have zero capacity.  Return -ENXIO instead
> of -ENODEV from nvme_update_ns_info_block so we don't create a hidden
> multipath node for these namespaces but entirely ignore them.

Thanks, applied to nvme-6.9.

