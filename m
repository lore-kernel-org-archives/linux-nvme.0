Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0EBC5474A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Aug 2024 04:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=qt1UacJSBzhoOXCnnWERVtNfHq
	zyVgJafICB/zYD4UPevlqfJ0GCJOKx+t6eMnppibPA/95WqFOzVlKlmDauLUXCqIF+wHwbdAedClR
	sosxcQK30/T4QwU5JIiZ/dd1G0ullyGU6awUolEd16sS6kj2L8XuuFMPu9U409h5XT/N1x57cAW/D
	gLO3rWbx7royYAYimeqLkg4lMIdkYvkBfP3Bxi6MfqH4rG2r++DPJc7KjW5Js+SoaEvolu5KBlBTK
	TX3q+0M2n4BgtoD4BPiDg036sBNqSoO8Y6sdVOzBtF1wXqgMmXy74vcvKjba5l4U2MTHuDVLYso1t
	E/pfYYRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjAIr-0000000Dn8P-0Ail;
	Wed, 28 Aug 2024 04:29:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjAIn-0000000Dn7d-39a9
	for linux-nvme@lists.infradead.org;
	Wed, 28 Aug 2024 04:29:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DDF2C227A88; Wed, 28 Aug 2024 06:28:54 +0200 (CEST)
Date: Wed, 28 Aug 2024 06:28:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Puranjay Mohan <pjy@amazon.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	puranjay@kernel.org
Subject: Re: [PATCH v2] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
Message-ID: <20240828042854.GA30879@lst.de>
References: <20240827132327.1704-1-pjy@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827132327.1704-1-pjy@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_212901_940737_20D808BD 
X-CRM114-Status: GOOD (  10.20  )
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


