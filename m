Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112B3606A331
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Hkpvafw7;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Xd3hF27R
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Hkpvafw7fxa+k9Pdpty3MUTItp
	aovbFgrUko3bxA9ZnYQVfkRWT8qYn30rSZ03ZDz67cXsnH1lM28Q0fmnxzKICS8+/4ny88zqhtSPC
	cHtXGj+GpmMqsWTau53X2CcnRLtYU6we6YIvSIa1KZzM8NsK1tRhM90S8Ikdx2zDz3wItwJ8F4Rvb
	1hAsrZr+mk/3J8gH3Imag17kVyZ1DxIEV5fO/yZ6dUlu6PIDt47HNzcLk6uD2jDmseOS4vm5waRtm
	Gkv8EtOurBYADBftbVxMjVvC2/zk753tiGdNHlINAIUUECyUSQE4b/uBxRnmRe68X5bKSFUf1w7D3
	m+xKZWuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSo0-0000000FnsL-2AG0;
	Fri, 20 Nov 2026 17:53:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSnD-0000000FnLw-1vqa
	for linux-nvme@bombadil.infradead.org;
	Fri, 20 Nov 2026 17:53:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Xd3hF27RMU2TpaTXhXuMZGNVHW
	fvQ7F72aSRdxT16KgwC7Vc3FTAG8BXtCdrY6vls9yoB6co9MBreRakJPazxsYHsV6a7OBEX0/wOAx
	+6Z3+1puMFYIdS4xzDWRdrFQtBN9BzkNuSYdRsAr/SF/X72bqCo129k6i3qZA9O5BqHn66Y6W4ycn
	KP45alZ7ogFTi7totDN+j42SPEw5pvCy2htc/XgIyH6Bb8eU72rJjxXls7/6yd6iaaoBsXVdkcJQh
	rXmJjGhzMqKUSk0vpp3hnMK92rENmDqmaN32yLzhqPLQGX3Dd9hHFEHaSW7dUXX8gNBr9TdnK5MgG
	NhyfI56g==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSn9-0000000128Q-47Bn
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 17:52:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1E8806732A; Fri, 20 Nov 2026 18:52:52 +0100 (CET)
Date: Fri, 20 Nov 2026 18:52:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] nvme: bound the reservation report retry loop
Message-ID: <20261120175252.GE1484@lst.de>
References: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn> <202611150127588115YPbE0vZGI-FTHIHXJTI5@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202611150127588115YPbE0vZGI-FTHIHXJTI5@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_175255_929733_0F3F38A7 
X-CRM114-Status: UNSURE (   9.69  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -0.0 (/)
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


