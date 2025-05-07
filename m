Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F5DC3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iu2jrnQMujDLLVkfnvcAsGfZaqWoyb8jEJNFUEeM25g=; b=4LYrQvkZu+dWDoauk5dJF+Flh9
	U6oB9gM9qnUfR0Wy/0HoqzuulOFrAxHVrji4dQ+mX9kmn/yUu0igWLhP/4UW2/qG73S1TFGZn71oj
	kuGCef+PF1EClBhGv820wP0zqHxvDss3erz7+S6qeYL/74ZBmsoynf81dKlXmouTd5CNreqPYny1T
	Xq+/LNsxa4ME2xFeZzZGiNenQTIr1Z3YXLXyV8wy2rG+th+NAXy8FWksOEBlN9I2g0o9Wi5WEOqsp
	xmdlJ5rOmpooyDjNzynAyP1rKbJ7sAqlJAkY4A/NTjXpg9zwHSSx28jow78sx2AUtr0u36l3voYgH
	TB/1ROTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZyp-0000000EhXr-1ax9;
	Wed, 07 May 2025 08:18:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZ44-0000000EUpa-37ZB
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:19:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A8B4D68B05; Wed,  7 May 2025 09:19:32 +0200 (CEST)
Date: Wed, 7 May 2025 09:19:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 00/12] nvme-auth: switch to use the kernel keyring
Message-ID: <20250507071932.GA1839@lst.de>
References: <20250425094927.102656-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425094927.102656-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_001936_919414_99182535 
X-CRM114-Status: GOOD (  10.46  )
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

Can you create documentation on how to actually use the keyring
interface?  As I just got into the TLS the complete lack of documentation
there left me a bit stunned and I'd rather avoid that for new interfaces.


