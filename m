Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3111ED5AE6B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 06:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mKExwiz3Kej75aTKS00be/SyLEzfA6BCCu26g5ACXrQ=; b=dkfg82Wr/wBRSBiK6l/c7IDeqX
	uZyD4fIi77XBWVS7+5uJ1y9HosQcypV4O8nvTJlnl8ekVzkNRS0A9BxfG1JV1OTm6Aj7QZMzPckEV
	8QuckiyhoQ2gNYci8SA7j4QvHYsgV5QLlVCr669hsofI/EQSInYO/ImKU3mtYEJFCX9vA2/PirDbH
	j9TWocxCs7eg3Y9Y4VGADTAEfWAKqhSz64dnb++ufgnspdvutLm9gi+GR1Au0n7MDmTqYhgqnf5ud
	0S4nVO6Vyy4lioucx9JPyJ13oQGoBS4/sDvQnjdCyfx4hEKEFkF+19+K11EP+v0pdRBuLvSSkVksS
	BAXkDSAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8wFR-00000005sMq-2lKm;
	Thu, 07 Nov 2024 06:44:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8wAj-00000005rog-13oG
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 06:39:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 92BA3227A87; Thu,  7 Nov 2024 07:39:07 +0100 (CET)
Date: Thu, 7 Nov 2024 07:39:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme-multipath: introduce service-time iopolicy
Message-ID: <20241107063907.GA3353@lst.de>
References: <20241107063249.101179-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107063249.101179-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_223913_455206_DFA0F8C7 
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

On Thu, Nov 07, 2024 at 02:32:49PM +0800, Guixin Liu wrote:
> The service-time policy can dispatch I/O to the path with the lowest
> total amount of currently processed I/O, ensuring that new I/O can be
> sent to less-loaded paths when some paths are overloaded, thereby
> achieving lower latency.

What is the exact use case for this?  The commit log is unfortunately
very sparse.  All these little policies add up, and we have absolutely
no documentation on them :(


