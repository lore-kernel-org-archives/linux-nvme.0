Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF3AC624D6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 13:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zWD2b549hAFNYPqazPnDEYkspaKD8JnBt70I7G7Oc9s=; b=uUabXaCPgWDbGPz2cPa7Cq7b4u
	ieHyW1f7X73lOork4cx5GXpaDhxxsqm/2BGPY3ph2qM/bIjzVCphfhIoner0o+T4/E9rYfX7Tre/V
	mwsWAOWaFMLX+4dwGN7sSN6hllTHyXvqv9qkAnaRNcjw5R9vLGLjAkNesUCtfQIS9NhOxJixviIOE
	PTGoxlKVzUO+eek7+jB3C3EE96w5Vs+JzZIdHLLXVRkTValTQcyvVy8k85g++X/Ozn2dmHDg5j6V2
	mFV66V5AJhUzcPqwizTwCjMKcfppeHjukAuKTBoLsUW5uUVScUaBv2JQykhGln/O3G9SltaEakDeF
	k2YcSDOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lD4-0000000EpjZ-2TwU;
	Wed, 02 Sep 2026 13:41:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lD2-0000000Epj4-2JO0
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 13:41:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3203C68BEB; Wed,  2 Sep 2026 15:40:57 +0200 (CEST)
Date: Wed, 2 Sep 2026 15:40:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/6] nvme: add nvme_crd_msecs helper
Message-ID: <20260902134056.GB21649@lst.de>
References: <20260823084903.193188-1-sagi@grimberg.me> <20260823084903.193188-3-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823084903.193188-3-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_064100_740304_7EA5DF01 
X-CRM114-Status: GOOD (  15.07  )
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

On Sun, Aug 23, 2026 at 11:48:58AM +0300, Sagi Grimberg wrote:
> Hide the details of extracting the crd value. We'll need it from other
> call-sites.

Even without users splitting it out really helps readability..

> +	/* The mask and shift result must be <= 3 */

While this is copied from the previous version I have no idea what it is
supposed to mean.


