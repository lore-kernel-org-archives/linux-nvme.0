Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5A860A2603
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EzMcSsD0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=EzMcSsD0la/oQVF8I/Y5On3Nk/
	WvDXtZvxEMssXdTwb3CQb0TtHSYI9Rg5u3BarH4PUrVecpacsydkk/fbfuYZlsmy4zFZ2mXb/ezYT
	d3jgC7dPfKHVH7BCPHlcXmnRe8umGqOH4J96MnoFhy9bfzx8NG+P49tngvGwd7tdyztU8mGJkEBMW
	Ihdy+/MBkuYyCT2uBKOEokwcKGsKT+9Zsh/fcUTuRdpPuR888P4zM5B70k+S7PHfdIAoCSuNwNecI
	SSDAqQFkroynMH+viFyRGKUY3mp7R37uf0lyIcuWV2BdE+1Ra2EURrtZJL0sBgrneA7r5NuiTLhgL
	VXTHdZ+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4sI-00000007EYZ-3EHS;
	Wed, 28 Oct 2026 14:43:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4sG-00000007EXG-1GA0
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 14:43:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5CB2268BFE; Wed, 28 Oct 2026 15:43:28 +0100 (CET)
Date: Wed, 28 Oct 2026 15:43:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: martin.nvme.dev@gmail.com
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Martin Belanger <martin.belanger@dell.com>
Subject: Re: [PATCH v2 1/2] nvme-tcp: start error recovery when read_sock
 fails
Message-ID: <20261028144328.GA14099@lst.de>
References: <20261027-nvme-tcp-ctrlrec-fixes-v2-0-9656395ebcf2@gmail.com> <20261027-nvme-tcp-ctrlrec-fixes-v2-1-9656395ebcf2@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-nvme-tcp-ctrlrec-fixes-v2-1-9656395ebcf2@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_074332_481156_E5AE465E 
X-CRM114-Status: UNSURE (   9.93  )
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

