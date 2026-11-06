Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C17606A334
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xQ7uqtCM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=xQ7uqtCMDYUyGbdcYuxVtoSG++
	sNAWrkvotCIHns0rijxZSKOiAzuJfLlvzuou5sO1XwmTvkpjAW4OPIh+EoA+9/qvTs5RBEe/XSBoY
	AGP+JLTvjP91FPWIFYApQ6mXfyVUvL9vb7CfH4gTOrx6+0nrQ/8gr7ZeavgpX+7AUGu0jv8WOEXo8
	IT8nXocw2jtkVDOLI8J9i5GRuzcmzPmtqw5T56hb7+AWFJ/T9C3yCTcxKzon4mWYcSgVj2UQ+8hpS
	WHRZ39MgXH/dJ5CT/kPEMj+pt7rejfY/Gs7XI3hkOLtJ1DhqMqTI/ZG4jll7GkFBkgwM/FKN3TLxG
	aTE9o3aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHFA-0000000Bwdw-23M7;
	Fri, 06 Nov 2026 10:32:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHF8-0000000Bwcq-04Fw
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 10:32:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3629668BFE; Fri,  6 Nov 2026 11:32:17 +0100 (CET)
Date: Fri, 6 Nov 2026 11:32:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yingjie Wang <1075151112@qq.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Marc Olson <marcolso@amazon.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: avoid wrapping admin_timeout and io_timeout
Message-ID: <20261106103216.GA5453@lst.de>
References: <tencent_1B8D08FB52E404EC3FE4933548D6CACB7305@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_1B8D08FB52E404EC3FE4933548D6CACB7305@qq.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_023222_200130_E9FA1850 
X-CRM114-Status: GOOD (  10.65  )
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


