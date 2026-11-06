Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF85606A329
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=k6FVudxG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=k6FVudxGFlaBtjV6fv7bvVB8kW
	3bJyXTbvY8FdywlrsTAvBoNyafxfhgYD0sI/wJWQISn/LHq4bOf7jPnD9S7OcnqKAR5EikRFU86XD
	Rgogh10SG9XM/GtmHivG2bEv73rOz55w38JXwvYFz4L2/GYQhjr5tnQYTvoPoFOBtI9IFwC0dADFs
	LPFEz2in7neMQDF1oXcItc2ftjTGl8kLShA6g8QmkgiM311EYP4iPxQCkxIGnFNx1k/Us1zUK5rhA
	rDZMjrBhwCCUoPxIH1ugG5R+o8wNUwRfkp791UMdK5ADLBKJy1+3rvnRvAzoZNpz+R0Am+eNHgusK
	hPEdnETQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHZb-0000000C2jg-1iF7;
	Fri, 06 Nov 2026 10:53:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHZR-0000000C2f2-0Ykt
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 10:53:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A375068BEB; Fri,  6 Nov 2026 11:53:17 +0100 (CET)
Date: Fri, 6 Nov 2026 11:53:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chengyuan He <channinghey@gmail.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
	Chengyuan He <channing1ne@gmail.com>
Subject: Re: [PATCH] nvme-pci: add NO_NS_DESC_LIST quirk for SSSTC CL1 SSDs
Message-ID: <20261106105317.GA5905@lst.de>
References: <20261105134526.95382-1-channing1ne@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105134526.95382-1-channing1ne@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_025321_331434_A26434E0 
X-CRM114-Status: GOOD (  10.94  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


