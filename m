Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65128C28B28
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 06:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Bx3pIYXX9VJOswSXbgYJ7Dd7I6g7GHz53G2Ve7Ei9k=; b=f7I0tDfhY9s+Dd87qZpfubhP6h
	jimVf2RvueVGIsIRFGJQxYRG/QmQcsojen3xGDGLwN9UMX6VaHz0BrI7mZzYh44EgDWhVWurXY7Ec
	wTMKEuOq02nxJCWQqGhN5ytv3mMlmdxRzEHLfbTIW+YA0yLJuQhzwTMAz+/LygL0Y8GK9PJdO0GmS
	FcGQBc8xZZrNX2CeDPIQpWfsaB8SHoaC6ZYUKNe5k2aGnfjvRA4wc6dKxdI+1rf2tMiGzWxZyuEyq
	DbCAW7zYZnon3zsBlil/XFyhx2Ql4E5XHShRzAeg2fg/RrHB7oIkhz1SMQjWZCc4HD4wqAZw0op9Q
	oTx9F46g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsc7B-0000000ADwW-3uMY;
	Thu, 13 Mar 2025 06:32:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsc7A-0000000ADvd-11TB
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 06:32:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E067D68D07; Thu, 13 Mar 2025 07:32:16 +0100 (CET)
Date: Thu, 13 Mar 2025 07:32:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: pci-epf: Keep completion queues mapped
Message-ID: <20250313063216.GB9840@lst.de>
References: <20250313011206.1410530-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313011206.1410530-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_233220_445069_9A77BA7A 
X-CRM114-Status: GOOD (  13.39  )
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

On Thu, Mar 13, 2025 at 10:12:06AM +0900, Damien Le Moal wrote:
> Instead of mapping and unmapping the completion queues memory to the
> host PCI address space whenever nvmet_pci_epf_cq_work() is called, map
> a completion queue to the host PCI address space when the completion
> queue is created with nvmet_pci_epf_create_cq() and unmap it when the
> completion queue is deleted with nvmet_pci_epf_delete_cq().

Yeah, that sounds much more sensible..

> +
> +static inline void nvmet_pci_epf_unmap_queue(struct nvmet_pci_epf_ctrl *ctrl,
> +					     struct nvmet_pci_epf_queue *queue)
> +{
> +	nvmet_pci_epf_mem_unmap(ctrl->nvme_epf, &queue->pci_map);
> +}

Is there much of a point in having this wrapper?

With or without it the change looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

