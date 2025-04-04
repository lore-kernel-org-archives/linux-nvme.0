Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528EBC3601B
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Apr 2025 06:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z1XaAZ6bCPBOdAtHH3TDJ8GwVdgnxEkd5gyQnUbJRUA=; b=Q7uXlFvXv0rDqbflDBHougNH0U
	ny6Lz1jJYPoGt6cBBCK8+G3erLt8gn2xYy1hfTxOoztO1Fe7alK57QxWVbMidFwofzNJ+QL4XIthV
	2Irut9iLYILNZ0vcrCmOc1/ZHssy/LZaKnAlfKfeGGKKlxouIGhymsCGV0sih6AlSPUUuNeI/mnFQ
	JUO1bjMPWHulCr9wAieHbdv3pCq06uVQmG5Cub08l0q8zPjnQ2+aJbW7NVVn0t9L1r12J5GzRVknh
	RLRKj+S7ifhqUCSPEpwkv4kA8Uc897//8Ls4FTUBM7KxQ7LcaW3ScRSWxSW2bTOflxU5iAQImlf3j
	8bE2kjKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0aUQ-0000000AsKl-3ncB;
	Fri, 04 Apr 2025 06:25:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0aUP-0000000AsJh-0GEY
	for linux-nvme@lists.infradead.org;
	Fri, 04 Apr 2025 06:25:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 999D268C4E; Fri,  4 Apr 2025 08:25:10 +0200 (CEST)
Date: Fri, 4 Apr 2025 08:25:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH 1/2] nvmet: make 'readonly' setting configurable
Message-ID: <20250404062510.GC31468@lst.de>
References: <20250403144747.43043-1-hare@kernel.org> <20250403144747.43043-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403144747.43043-2-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_232517_241147_31C07320 
X-CRM114-Status: GOOD (  13.52  )
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

On Thu, Apr 03, 2025 at 04:47:46PM +0200, Hannes Reinecke wrote:
> The namespace already has a 'readonly' setting, which is controlled
> by the 'write protect' feature.
> This patch introduces a namespace
> configfs attribute 'readonly' to make it settable by the admin.

Please describe the spec feature this corresponds to, and why setting
the NSATTR CWP flag without a formal write protect is fine.  From
looking at the language in the spec it probably is, but that really
needs to go into a commit log.


