Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3361BC3ABCA
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 05:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4APg6yVz6kgCDi8Roxi56DKotyt2hsl1mO8Xu/bEAlI=; b=iwZ4seb9FKOj454ZfoLL9drgM6
	hVdhnDOdKt9JfEP2tm5xvI6NP95cvTvoQuyw8IkRobbBgeXZCJskeDuztvMkPI3b6cDxoyYWQQ9EZ
	cr2dfSnl7XL/D9A3xFtdRTVs4zVI3k9ELRcFXgIvJijtv5OTulrglMi4M7TJOkTiWLuE6hhVNmxSJ
	OgUVKbEDGaKn/DSRmVQgH8eyMpRPtx2xs8SDQy3kYLmgHlQjnuIMRv6pBPm2y7XN6C1MeBaN7xn2j
	mRjngoUeDZkJhMkjfaBIOtSwsuysCxxyFf5fKI1zCEBnbGmhfjGVSZDxhDM4ZwiochJDeZFM3HSzQ
	7gcSzyqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFxe-00000002UDN-266P;
	Fri, 09 May 2025 05:07:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFwX-00000002U9E-3aTv
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 05:06:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6BB5567373; Fri,  9 May 2025 07:06:38 +0200 (CEST)
Date: Fri, 9 May 2025 07:06:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 0/2] nvme-auth: use SHASH_DESC_ON_STACK
Message-ID: <20250509050638.GA29534@lst.de>
References: <20250507082818.46157-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507082818.46157-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_220642_030095_5FF830DB 
X-CRM114-Status: UNSURE (   9.12  )
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

Thanks,

applied to nvme-6.16.


