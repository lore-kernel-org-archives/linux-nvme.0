Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC1AC19F2B
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jul 2022 14:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5SNFZDR+eWusS3z03Ow61rpeVh77tuH21FVeXb1bMds=; b=e03nxdNdVTX6DDEICkdt2ZoDvy
	R0nkIhvnZ9flrrq42mwXlvb+a4EhRpeQl0B80yOHSiBkEI8jE4ZmqOhoVAzhoLnTxPOxxQZDuyqYU
	jJqLNZ7AcQJ7qVD9qNIUNHMeCP7HeumxaI6Kt6z8VQc0QTlO6YjFTjvTAFPS9wOZMko3+n9q7v5Dc
	Dan+eIvC99KA1UAAEB7wZeDtJv61YZKKaGnLX5gRUbyz2FJyzO2C7jcUarrC/nV6cqwrZMOjaMO4e
	74hDa6VTbiq9xja2yezNGaiH3/fDnSSL/V0rJJCyeteNOfTqjm+qRiUwZDZEO9zffc5r0gLsst1Qh
	DOIQ+iKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHQwP-005V2X-DJ; Fri, 29 Jul 2022 14:26:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHQwM-005V0d-Ef
	for linux-nvme@lists.infradead.org; Fri, 29 Jul 2022 14:26:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8205068AA6; Fri, 29 Jul 2022 16:26:05 +0200 (CEST)
Date: Fri, 29 Jul 2022 16:26:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	sagi@grimberg.me, kbusch@kernel.org, axboe@kernel.dk
Subject: Re: [PATCH 0/3] improve nvme quiesce time for large amount of
 namespaces
Message-ID: <20220729142605.GA395@lst.de>
References: <20220729073948.32696-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729073948.32696-1-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220729_072610_658782_7CD54E6E 
X-CRM114-Status: UNSURE (   8.78  )
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

Why can't we have a per-tagset quiesce flag and just wait for the
one?  That also really nicely supports the problem with changes in
the namespace list during that time.

