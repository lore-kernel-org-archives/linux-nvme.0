Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A437EC282DE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 08:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YL+/3m+l/GL5S/Uqr5I5AYrVA6IhsdzT9a2U2LGJZb8=; b=rTn3hX/OawiU5Km5DwH6pxvq3m
	HwaBlyfYYnbGoXS6YIpU7B+75J+oWXT5rkNHXGGMQs+sfJu302FHrOdkx0CfYzGhPJrHIJ9EKnjop
	67+Ydw7k+hMX3xWrRGFmU1wSvfkZejpaOZrzl5rakfCG9nWFn7oD+HdbcqN3XsX/zcoi3NWKgU5gT
	86n7CxlAFuthrx30XmhEuO9P1QtwUWlvABW69THOS6Zdsmszym+3m4vo9k5oblSR3eIeBgVzHvrgt
	jupRPPe+I9WEAjFxPdnsNSG9glIlFwyBIgnA8b0Nw2U13T1zwzXrKkGnKYjfL4I5QrXZLloKkHivt
	oFf7ZPEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsddu-0000000AVT0-041U;
	Thu, 13 Mar 2025 08:10:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsddr-0000000AVSN-1ooy
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 08:10:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3F09568AA6; Thu, 13 Mar 2025 09:10:05 +0100 (CET)
Date: Thu, 13 Mar 2025 09:10:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: pci-epf: Remove nvmet_pci_epf_[un]map_queue()
Message-ID: <20250313081004.GA12988@lst.de>
References: <20250313075814.1442096-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313075814.1442096-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_011011_612848_A449559A 
X-CRM114-Status: GOOD (  12.69  )
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

On Thu, Mar 13, 2025 at 04:58:14PM +0900, Damien Le Moal wrote:
> The functions nvmet_pci_epf_map_queue() and nvmet_pci_epf_unmap_queue()
> are called respectively only from nvmet_pci_epf_create_cq() and
> nvmet_pci_epf_delete_cq(). Remove these functions and open-code them in
> their call site.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
> 
> Note: this goes on top of the patch "nvmet: pci-epf: Keep completion
> queues mapped". I can squash these 2 patches together if preferred.

Yes, I think just squashing them would be best.


