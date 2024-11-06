Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C287D29FB8
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 08:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WNSQ4tLjLRxzc+G5hTh6H+xDmmC3doG84iLUMENWHg8=; b=mMMcwbEeuS+LDU79ERsn3hCWrI
	d3RxK3ob62q4HZMMEvlm7evnykoWE+6pywL4b06Ie8s83qfKG35XPBTyVIiKyOXYVqRxnNWsXLTdY
	IzH2iPmVf2kulQU2pJn2/ib7Ij6kX9FBvkFLQlj1GE0nzDPN43Cke5EhiCflLM2boCi2Xgdh+Um0Y
	UUimiIkXW4udmsKfh4LcvUx561rOI0UkH4AZliOQ2eZcJ+dFma3yh2uWGqPT1T04Rp66Udipc3Dmh
	tDsHBR2qV6leqtq670ZbP0mR2l7bylzwr8390mwN4FDfcmzdjYlSzoR/AyajjSPYWd2OC4lWVXmZf
	saQxTVJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8bJK-00000002GK0-1b9I;
	Wed, 06 Nov 2024 08:22:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8bJI-00000002GIu-00we
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 08:22:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5E38268AFE; Wed,  6 Nov 2024 09:22:33 +0100 (CET)
Date: Wed, 6 Nov 2024 09:22:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, m@bjorling.me, matias.bjorling@wdc.com,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 11/11] nvme: add rotational support
Message-ID: <20241106082232.GA3779@lst.de>
References: <20241105174904.3612888-1-kbusch@meta.com> <20241105174904.3612888-12-kbusch@meta.com> <9614c5af-7418-47b9-833e-388cdf1bdca4@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9614c5af-7418-47b9-833e-388cdf1bdca4@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_002240_210899_0900AB4F 
X-CRM114-Status: GOOD (  12.14  )
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

On Wed, Nov 06, 2024 at 03:57:06PM +0800, Guixin Liu wrote:
> May I pose a question, what does BLK_FEAT_ADD_RANDOM do?

Nothing.

> I see the scsi call add_disk_randomness() in scsi_end_request() if 
> request_queue has

Yes.

>
> BLK_FEAT_ADD_RANDOM flag, but I dont see any calls in the patchset.

I actually pointed that out last round and thought it got fixed,
should have noticed it wasn't this time around.  The flag really
should be dropped.


