Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F7EC3ABC5
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NmUq7KlyxBxfvbU4Bl2Qh9vFNoeMzbCbdN6kRaLOa2g=; b=WgoJ7Sz14u+M1P5lyXiqsGaoSc
	DQFmoAyXjsIunfS5WhiPHrAy0hGlUHuOkqIK9a84h2zUCkvXygQweSyN8NTFp78513LG2NZuqd8KU
	/Y63ooFP3v2AU5CFpXmCccmf158kyP+9ZVhDcRTsGPYFL6nTFueeexjASLmQ5mEnLb4qm/hg7195L
	d74KDgIrGC5Fh4Kg0kkFrnJtWoPJNm/3IqBbfSJDPdPNB89/rTn9WYR3CJB7VK0FlrDPCmyUDOIDf
	Hd4IXUq6Uwcc8VzgywoY8OXbbyka9OZcrIYegDCAMeQ7kw9CyB7WCToPRnV/I5p4KyPe6b9S/i//B
	lT1a8kgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCa2h-0000000Eieo-3WLM;
	Wed, 07 May 2025 08:22:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZAb-0000000EWQl-0X7D
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:26:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C8B3868CFE; Wed,  7 May 2025 09:26:17 +0200 (CEST)
Date: Wed, 7 May 2025 09:26:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 07/12] nvme-auth: drop nvme_dhchap_key structure and
 unused functions
Message-ID: <20250507072616.GC2347@lst.de>
References: <20250425094927.102656-1-hare@kernel.org> <20250425094927.102656-8-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425094927.102656-8-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_002621_306767_D25C97FA 
X-CRM114-Status: GOOD (  11.51  )
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

On Fri, Apr 25, 2025 at 11:49:22AM +0200, Hannes Reinecke wrote:
> Drop the hand-crafted nvme_dhchap_key structure and the now unused
> functions.

This should go into the previous patch instead of just creating dead
code there.


