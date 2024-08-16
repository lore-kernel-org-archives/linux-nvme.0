Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F3AC3DA4A
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Aug 2024 05:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nbcKkpTbCt2IdJO2rzEUm8Q+hLyzoollv//51oRLSJ0=; b=iMO9EvNtGGjOhHC1BBlP/Avsw4
	HKjbjOCHEhmeCxKT9jRoLxCO6OlmdtOjnZCigPy3UFnqp3mdTC2bB1yf4loPZor6Rnu3WnkcIEYSV
	4pZOWRHSKUhVHeWvef1NH3Cygo+XYpAlOmL8RY0b2yAYjyTfFZ4kU8G4ISwDZepF8QtQTln5XbC6t
	BdH/N3ZVZJexOwPKKwVeRMAFu8NQZA6n+O4lka6pD8rVuASRR0o9JyoG2fsnetopy2GzGqd4Lrutx
	RcerIGAyYmeOUTerH+0yhOJMnuUo4zE1kWAQgEpEqaDx9LMr1xVSSCkG2/RbcyYiYxSfYhNoOhGO1
	irXd4iSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sepiC-0000000Bs6q-2xoN;
	Fri, 16 Aug 2024 05:41:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sepi9-0000000Bs6R-3mHc
	for linux-nvme@lists.infradead.org;
	Fri, 16 Aug 2024 05:41:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AD483227A87; Fri, 16 Aug 2024 07:41:11 +0200 (CEST)
Date: Fri, 16 Aug 2024 07:41:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, axboe@fb.com, gjoyce@linux.ibm.com
Subject: Re: [PATCH] nvme: Remove unused parameter
Message-ID: <20240816054111.GA29113@lst.de>
References: <20240814135702.99402-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814135702.99402-1-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240815_224118_102081_CDBB7A10 
X-CRM114-Status: GOOD (  10.78  )
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

On Wed, Aug 14, 2024 at 07:26:50PM +0530, Nilay Shroff wrote:
> The "name" field in struct nvme_ctrl is unsued so removing it.
> This would help save 12 bytes of space for each nvme_ctrl instance
> created.

name is a structure member, not a parameter.

The code change itself look fine, though.


