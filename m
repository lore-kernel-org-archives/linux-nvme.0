Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305C5C5B543
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jun 2025 08:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xG7ZqVClf2wGGOJG7OHcmDte0f2Jh23A/LCYVugj87o=; b=v8qA+gf8cPAU19T9hqzzhiO+YW
	wyMWfA/78AH0Kjo1Qn82S//es+EuPiVN8E4vnj+1zNWyT8PGkMIEWqG5uNAHeZx7YYnLeWmjw4e6q
	TR/2rvnvK5A1KDu9pXAhWsZL5r/vtV9GlvVWNt8ym8Qs5YwvViRLRuHm2wnF7I6S5ft9MT7eMLrbv
	MZ/z+eNCtrW62aaXQAkMPZLMy3gnwU54L92XUj6E5xM3ZWo+6RZsrf2mkjBgCRlA1X0Jb1mfiY9/F
	b/qgHhUI6o0iJVm6ObsBVwxAyDtjWoxxUgsDWUB4qH8KD8xQE74NE4VIrgINUClWpB0n+HEBPfAmi
	30nsfYdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMjXO-0000000Cu8L-02Fo;
	Wed, 04 Jun 2025 08:31:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMj7R-0000000CqBu-3r7j
	for linux-nvme@lists.infradead.org;
	Wed, 04 Jun 2025 08:05:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B02F368D12; Wed,  4 Jun 2025 10:04:57 +0200 (CEST)
Date: Wed, 4 Jun 2025 10:04:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Kamaljit Singh <kamaljit.singh1@wdc.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCHv4 0/3] nvme-tcp: fixup I/O stall on congested sockets
Message-ID: <20250604080457.GA15540@lst.de>
References: <20250528064535.135653-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528064535.135653-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250604_010506_098915_1A702B36 
X-CRM114-Status: UNSURE (   9.42  )
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

I've added patches 1 and 2 to nvme-6.16.


