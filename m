Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49949CFC61B
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 08:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vqK4dlOdC70g4835YLrYpbPenNZ+/BX3oMa5xzU3XGY=; b=Bu77ghigLeO9rfdtkvb5EhWF90
	G73g0/2hfbvJr1M9Fr9+MML2AYSuaCbcJ+ffE+q0MuqdihgiynMW0CxtHxVg0b9qGvr+Yh5b8FQHN
	t0jvWcbOySvQlua10MX8GNY9nov0isu7XsDjA1AO7jGC1WTq7xMkP0jXdruSTQNeit/OlOtwcyhKN
	kNPp5+9Y1k+HrqbyozxTpr1DZMbQ06a3klXDlU63w6TrorgYw3aN0H1TmIFQdF83Y6hJ22Ma0pGut
	an2Utk+u30Z6E5Ema9sUD7u6rgaS/G3zXZnQfyHWG/jSfxvl9owZVzD6Nc+xY6jMARWxsIEvZOr2p
	l5a1r0Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szAoC-0000000FfEL-4Au6;
	Fri, 11 Oct 2024 08:15:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szAo9-0000000FfDm-3vKa
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 08:15:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F084227AB3; Fri, 11 Oct 2024 10:15:30 +0200 (CEST)
Date: Fri, 11 Oct 2024 10:15:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: kbusch@kernel.org, hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, wangyugui@e16-tech.com,
	martin.petersen@oracle.com, hare@suse.de,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 2/3 v2] nvme: add rotational support
Message-ID: <20241011081530.GB3337@lst.de>
References: <20241010123951.1226105-1-m@bjorling.me> <20241010123951.1226105-3-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010123951.1226105-3-m@bjorling.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_011534_135341_0F45002B 
X-CRM114-Status: GOOD (  11.32  )
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

On Thu, Oct 10, 2024 at 02:39:50PM +0200, Matias Bjørling wrote:
> From: Wang Yugui <wangyugui@e16-tech.com>
> 
> Rotational devices, such as hard-drives, can be detected using
> the rotational bit in the namespace independent identify namespace
> data structure. Make the bit visible to the block layer through the
> rotational queue setting.
> 
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> Reviewed-by: Matias Bjørling <matias.bjorling@wdc.com>

If you pass this on, this should be a Signed-off-by.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> larlar

?


