Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950E7C3ABC9
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iZ4o8iD4YkXqfIM6qHkNyai2MeSKE0hCHA722uHvVuM=; b=KNwk5VhoRI7m6N/0C65vdzVUmk
	kj1HW4LlsF+2vHPghytxTwg/oiVu7DfJp6ZLSfTpN6fHUxws7L2ugkTbeJpMo5oS5ddGjeP7uWfYP
	73FKAVejAt1Aif82UZ4X+1JVaq+jPHWjmjVsG2qLeM6fwCnmlJi2t5nRtDtyD2iFgQO3iDv3fza9N
	4gC3/omUDfArlvnc0CQhAU10fP29qjQUNDXmGbFSjlrIS0h6FxvDxpaFlC8UdPdnFd6PqYLvLeE0c
	gGJEsm9PoBQ2QTdutJx38xWdfdusGG1pn9i3etgCoX807WDc5NPwdpxxETsmCaxuZmacLgI6JlNU8
	MZpiL+BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZyq-0000000EhZ6-4BB0;
	Wed, 07 May 2025 08:18:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZ7X-0000000EVhx-1RsJ
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:23:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1A1C668B05; Wed,  7 May 2025 09:23:07 +0200 (CEST)
Date: Wed, 7 May 2025 09:23:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 12/12] nvme: Unify Kconfig settings
Message-ID: <20250507072306.GB1839@lst.de>
References: <20250425094927.102656-1-hare@kernel.org> <20250425094927.102656-13-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425094927.102656-13-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_002311_521860_EAFDB4B5 
X-CRM114-Status: GOOD (  13.26  )
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

On Fri, Apr 25, 2025 at 11:49:27AM +0200, Hannes Reinecke wrote:
> As authentication now requires the keyring to be present streamline the
> Kconfig setting to always select the same symbols for both host and target.

This fails to apply with the select tcp fixes from Alistair.

But I also totally fail to understand the commit message.  Either
some library code is needed and we need to select it, or it is not
and we don't need it.  Being uniform should not matter.

So when respinning this please explain what is fixed, and split it into
separate host vs target patches.


