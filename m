Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306ECC3601E
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 08:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UMQwg6h1UTYES6zhDN2tIPgzOs1D12A4qRQFacRf5O4=; b=YkhFF0vwYiEV7qOpbUPaWe0j9I
	sHDw73S/rcgTftHuccPUhFrVejZtJZU87MIAfmQx4bR0hT2OVW4wA35dd5qaUxr6QWLlrhCTC2CIq
	DSi5pBRHqgJ7kFJr/KeMqHjtyzSaEav9QNGXFj0Ole28mG9QxwgGbTfFsLNdUP34Gldi1RCHQA+gW
	Ql1OR9ECFqdgoqLsPKTsa9AiiNCAz3x0RmKYQhiU7RZefR6h9SiNFhql407E0uEZZ9wIPZ0ZHuY2M
	H/lWHreHj7P9pJjSIBPglMIBJb7BjwmNSmisQcV4zHRKIWEiPaqFIJwnoFBuEGBI2xAhDP3vT1S7K
	h/OCGOLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2njF-00000009pyp-30y0;
	Thu, 10 Apr 2025 08:57:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2nQk-00000009mHE-1dcp
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 08:38:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 365A368B05; Thu, 10 Apr 2025 10:38:31 +0200 (CEST)
Date: Thu, 10 Apr 2025 10:38:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/3] nvmet: pci-epf: Always fully initialize completion
 entries
Message-ID: <20250410083830.GA2130@lst.de>
References: <20250408024733.690966-1-dlemoal@kernel.org> <20250408024733.690966-2-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408024733.690966-2-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_013838_569165_BE109A2C 
X-CRM114-Status: GOOD (  11.32  )
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

On Tue, Apr 08, 2025 at 11:47:31AM +0900, Damien Le Moal wrote:
> @@ -1763,6 +1763,8 @@ static void nvmet_pci_epf_cq_work(struct work_struct *work)
>  
>  		/* Post the IOD completion entry. */
>  		cqe = &iod->cqe;
> +		cqe->sq_id = cpu_to_le16(iod->sq->qid);
> +		cqe->command_id = iod->cmd.common.command_id;

This could use a comment explaining why we are doing this seemingly
duplicate work here.

Otherwise this looks good to me.

