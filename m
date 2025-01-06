Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD124E77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 07:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=A6QdbEHK5hlAEAyGGku5eD39FZ
	mwXvFHMBD+cyy7ZtTuqg3LpdFJzWXcpLQdlZEEM4eRnZf4keWx76C/Hyr5w5UC93sJwjK0I1XvKQL
	aC7Ee8VuZQqn04sh5ky3ajiTnVHLQcZ+ju3DTN4zO7KTYRqFc6VkAiCwZBQAa7Pj85lXTwVNC6/Vl
	eklmvue0GCkivjBod23AHhqpAbvscUS9Pixm/jGZrEd/shsGCqmbSbZVx1OpvNxNuUxUZmqn4+Y7i
	b9mlx9Tm3Ux2OWwN6E1L7NGPCqsxzCtRHokZmAgZm6qjk/2bc9aUBYWHmE3ZGYHk2baI3xzVabHoS
	2IxfELGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUhTQ-00000000OrW-18bb;
	Mon, 06 Jan 2025 07:24:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUhTN-00000000Opl-1hj5
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 07:24:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 851F468BFE; Mon,  6 Jan 2025 08:24:21 +0100 (CET)
Date: Mon, 6 Jan 2025 08:24:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2] nvme-tcp: Fix I/O queue cpu spreading for multiple
 controllers
Message-ID: <20250106072421.GA17197@lst.de>
References: <20250104212711.37779-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104212711.37779-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250105_232425_576521_440F7FD8 
X-CRM114-Status: GOOD (  10.84  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


