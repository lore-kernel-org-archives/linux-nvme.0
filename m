Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3C5606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=S7FgBJK9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5iXV8NBcJ8X39M+gzTAHQURWm85H90v6o7m3A4PpoDM=; b=S7FgBJK98hgoPlTGBAfJHydGTM
	2zPJbA2mXgJKTX0vN296EeS34LqqaO8qrNG4CWBaonqThL/jLbM3Oht4CaRJ7pJR7FsxQsZXBQTjg
	hE2FI5foX8cUSSShGor4+uxdcTUOuHScB2P/Wm2qMK6JDRvA+rkX77NGqhDQTYei9zP/DHrGWLr0h
	ZZ9L6dpgW5fdJ95Uq6OA8XpesYDQQdlebN/Qgugm6QcaM9fRINbWIc6Fqi9rA1J2p7iUeJThrRcrc
	ee9yEv9CZ9GJ7BWVXZz1Hy3Xn4XNZtmW6xOly9TdfqPVGO4DTaVGSfYt3Wb5hngB+JFMF9SS5f9rO
	9lI871Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHIp-0000000BxSo-2mhx;
	Fri, 06 Nov 2026 10:36:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHIl-0000000BxR9-3y2n
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 10:36:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C80768BEB; Fri,  6 Nov 2026 11:36:04 +0100 (CET)
Date: Fri, 6 Nov 2026 11:36:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/9] nvme-pci: remove write-only NVMEQ_DELETE_ERROR
 flag
Message-ID: <20261106103604.GE5453@lst.de>
References: <20261106022736.3582824-1-kanie@linux.alibaba.com> <20261106022736.3582824-2-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106022736.3582824-2-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_023608_132962_7DEDBDF2 
X-CRM114-Status: GOOD (  13.46  )
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

On Fri, Nov 06, 2026 at 10:27:28AM +0800, Guixin Liu wrote:
> Commit fa46c6fb5d61b ("nvme/pci: move cqe check after device shutdown")
> removed the only reader of the NVMEQ_DELETE_ERROR flag, but left the
> flag and its two writes behind. Without a reader the flag carries no
> state, and nvme_del_cq_end() degenerates to a plain wrapper around
> nvme_del_queue_end(), which the SQ deletion path already uses directly.
> 
> Remove the flag, its writes, and the now redundant wrapper.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

