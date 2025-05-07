Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63ABC3ABC5
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0ZbtL2DKY9hU/jxEFdAoIjVTX2SMfqaBlmjIf23ltYU=; b=ZzuH0iG/EjZgZ2nT1zTmSiZQXE
	UVWbO3T34D4HUVTFpJGeephs/xRR3gC8CD3xstzd/QiG1XtqYrEnVfMmTeZBhpKX7pJZNFzV0XVmU
	Ri03xN2TPHnGJLMCDV4h2zuUdoqnwuAcpsL/k6peheEIofOPOBiEypSQTVmBQgUNcq8q853QJQqyB
	lU4gK12gUnwG+ehl5V41JVqhafsDPBf1wi6WdsCl01InfHaD8dWhtLRrULXYCnwJ1EvUwiAPTOjaM
	y7XviAF7/zCsSls034lr3CB3o20LkcYxuGChROmmIx7V4OxwjxegXIahIEHHgkG5C+BMV9Wc5Yqur
	7l6l6pKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaEb-0000000Eky6-30Jl;
	Wed, 07 May 2025 08:34:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZJl-0000000EYYX-0ShN
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:35:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DA44D68B05; Wed,  7 May 2025 09:35:44 +0200 (CEST)
Date: Wed, 7 May 2025 09:35:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 02/12] nvme-auth: use SHASH_DESC_ON_STACK
Message-ID: <20250507073544.GA3070@lst.de>
References: <20250425094927.102656-1-hare@kernel.org> <20250425094927.102656-3-hare@kernel.org> <20250507072819.GA2665@lst.de> <9ed19121-0fc3-475f-9a09-68b506b1dadd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ed19121-0fc3-475f-9a09-68b506b1dadd@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_003549_287263_F49E8279 
X-CRM114-Status: GOOD (  10.57  )
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

On Wed, May 07, 2025 at 09:29:41AM +0200, Hannes Reinecke wrote:
>> Can you send these two as standalone patches for ASAP inclusion,
>> please?  They look nice and unrelated to the rest of the series.
>>
> Why,

Because it's nice to be able to queue up obvious simplifications and
speedups ASAP while features tend to go through longer review cycles.



