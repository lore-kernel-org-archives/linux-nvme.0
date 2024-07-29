Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F59C3DA61
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jul 2024 14:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RSdXWX5XdLIldaTJ9QGMNSP6bCbqttNJ6Oyf/MIp57M=; b=LQBMISZPIjMMjc9LyQb1MGdj7/
	/P2XAcg8HJwqYNTZX1RznexkxrGXN3eoUSazwsoFBNYvwhN7DEL7DGf5FQw5QN3JZ20Lo7H0B1MdD
	2wMmBhWupzZi0PMi/gBRfgILB5GmK4DsxD+QmKODCc/hqmiO5jprcMcsWMljecJ6C6MPhLckEF19a
	lLWFWdaC5VFZ2S8VV/eZc6MAqV1CaJpbZ48HHSgojphR2FdlmkXdTyowV4A6xUvWuDmPo62BSFVe2
	ZbKpIyCEp/qfxsia+SMhvLvfqeBZQvpAC5LaIp3H8owJta5aVdicP102X9A/QqRmK1pIMyI3BMloF
	3aU4OUfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYRaY-0000000BhTY-368A;
	Mon, 29 Jul 2024 14:43:02 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYRSB-0000000BdWC-030A
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jul 2024 14:34:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8ECC1CE0B25;
	Mon, 29 Jul 2024 14:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48076C32786;
	Mon, 29 Jul 2024 14:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722263658;
	bh=RSdXWX5XdLIldaTJ9QGMNSP6bCbqttNJ6Oyf/MIp57M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ngLZhHjWsGUpNiuc9Ysl0ckZVMUcNM5gayessFjp7RpbsZjVdZdv33jYWDRzyTpLM
	 fZaXxRX9NU6xBFPQNhPCWMN4gv1b1mjoUZjHqnT3vDKRldau/ebUmJr+4kebLSDqtp
	 SCLgwdJQfiROq56v27ouqhTWVANyV8iY0tBkc42e9KkZdHtvjfPsM64RP57ijoumHL
	 Oz2sjP9lcTooZ9SQvzCc3EsIt8+5WM/Mtz+33miN0a8ehAOsxtRqnvTHyWRrSsTk98
	 G9nF8dAaRphejdh5QKlRDHNO5GXe4rmEHRSBtd6h+jpqtyLe6vT1cZcKpq1378SZzd
	 a5ceFZfgjquUg==
Date: Mon, 29 Jul 2024 08:34:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: remove unused parameter
Message-ID: <ZqeoZzb8RAvLXi7d@kbusch-mbp>
References: <CGME20240729063922epcas5p35577196a5bb929f1fdf60306987d134d@epcas5p3.samsung.com>
 <20240729063133.198682-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729063133.198682-1-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240729_073423_245764_ADD8FC71 
X-CRM114-Status: UNSURE (   5.98  )
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

Thanks, applied to nvme-6.11.

