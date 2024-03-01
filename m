Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D028C5478C
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Mar 2024 13:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=gsC5Fta1uqfNAYCC7roMGEQEGb
	uGFs/T7U1tFUvv6XXJYWD6a4mx2QuR22PLWwtCoy5lMWIK1MAEXBRA+DTCk10GG1S976dQyXz9XuY
	oS5qg9M391VAhnir2ooppCz9mtjJmHxrnQU7wxEibhSuWP3U49q2fTNOuZxltf7URmQqxJWVkCdEk
	PZb0uv0AvKOIma2e9M1/KUSpjCBzyfcwTrHsYNmsx+Dlqz5nJfffVc16tlfI82i+E2lOLdn9Raxta
	nrIzR60/Fw2cOVFAzCoIJFdDHHesXhmGbd74O65LS/kL/NQcwNVGbyJiCH8eXgeV6gTNNdgoaMJxP
	HvXzNrIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg33T-00000000VzT-3bUe;
	Fri, 01 Mar 2024 13:36:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg2hR-00000000LKa-1BEa
	for linux-nvme@lists.infradead.org;
	Fri, 01 Mar 2024 13:13:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9B85568CFE; Fri,  1 Mar 2024 14:13:14 +0100 (CET)
Date: Fri, 1 Mar 2024 14:13:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/4] nvmet: lock config semaphore when accessing
 DH-HMAC-CHAP key
Message-ID: <20240301131314.GB3586@lst.de>
References: <20240301112823.132570-1-hare@kernel.org> <20240301112823.132570-3-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301112823.132570-3-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240301_051317_487180_9934EA47 
X-CRM114-Status: GOOD (  10.29  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


