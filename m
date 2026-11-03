Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C73606A324
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 05:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KqRaUXkV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=KqRaUXkV9/aPQuisUUM5BJk4G2
	X3AC4Wjc1cDXPCLEw5P9/ftO70pP/EmkLKiG3BSKzHR0bVP7yzgFraLI3KSC/CDLRGcBZTI+TOqTA
	hXvJp6MH8OWIoYYixGjsTUuiShIhEoaRtqdibR8ZZAmfCTP04Pb95P5BdQ/j5PCIYUBB1yy2/ckWq
	ocGk6IJcHvgPCzsP9e2PEFOW6ZU+iUjQUiXAI1t+3X4xa1hVARah1qfpseoKOVUYvX7m6+BK4+twR
	a5hoGqpnmIM+vxwTz9XFnMHjKZ1S9Z31jstP0ameSOnzQmzrlQFX5W62/xVWpayxj/3yMaRPK1M+a
	Mjt0suOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7Ab-000000018oF-0RHe;
	Tue, 03 Nov 2026 05:34:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7AX-000000018nw-08Fy
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 05:34:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AA2D668AFE; Tue,  3 Nov 2026 06:34:45 +0100 (CET)
Date: Tue, 3 Nov 2026 06:34:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: James Fantin-Hardesty <james.fantin-hardesty@seagate.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: fix arbitration burst field mask
Message-ID: <20261103053445.GC1382@lst.de>
References: <20261030191853.1777683-1-james.fantin-hardesty@seagate.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030191853.1777683-1-james.fantin-hardesty@seagate.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_213449_236245_DAD9CC35 
X-CRM114-Status: UNSURE (   9.86  )
X-CRM114-Notice: Please train this message.
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


