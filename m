Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFE6C3ABC5
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BbrKUsrpyLHJx7SEeoEoOpXE8/29QU5/k7wekfhth4Y=; b=kZ0Kv/W2ee6phvsjZ0QNS9nqzC
	+qgZYLtDCIBKauOT2bF1FUZnqyJCGUUFsVaS1TYeL1HgNAUumoBNWm/hoF4LT+JKlQwXsnJC1nqJ4
	7fBH9y12pzftns4vkUE53dYBlgrOk+pLmlPVdSPUkATaky5Dj59sYtTZPaz82K/Eg3hUtE6J9lfHq
	DAGmBhBDbuye5LWY3IM2tSt6T2fFHRox6EVssRKLWRTfFyPrUfEWbXR5zwGASSwrkVTWh0rXusKoq
	v1vF5RK4sJ6fn8PNeD7O6QqnFecUIgp8fXd0qM1fa2dnGC6gFjY7rAZebnA7o8tZ4Zsl2Jw83ugMg
	PZvtB+SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaEC-0000000EkZE-3wOB;
	Wed, 07 May 2025 08:34:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZCb-0000000EWv3-1uUO
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:28:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 339BB68BFE; Wed,  7 May 2025 09:28:20 +0200 (CEST)
Date: Wed, 7 May 2025 09:28:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 02/12] nvme-auth: use SHASH_DESC_ON_STACK
Message-ID: <20250507072819.GA2665@lst.de>
References: <20250425094927.102656-1-hare@kernel.org> <20250425094927.102656-3-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425094927.102656-3-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_002825_636983_138565E1 
X-CRM114-Status: GOOD (  10.41  )
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

On Fri, Apr 25, 2025 at 11:49:17AM +0200, Hannes Reinecke wrote:
> Use SHASH_DESC_ON_STACK to avoid explicit allocation.

Can you send these two as standalone patches for ASAP inclusion,
please?  They look nice and unrelated to the rest of the series.


