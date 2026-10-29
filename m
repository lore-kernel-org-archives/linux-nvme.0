Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88C9606A31E
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Rgb+U+UY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=i3fiR/sAc3MoSh1uvdBFwJ3whZ8RDFm7WQNOOBsAd4U=; b=Rgb+U+UYk0dCuHEkTu9o3p3jMj
	jU8vypY5ONMlY5gf+1iarvl//eqzoDxuoc4oONRefbjaBUR3Wy/f1QWBLPWQQGn5JCApIeLQy8xvB
	uL59sx4BC2BRTBr+d0B+pUjuitVM8pg12c2+Wlj6omcSoJT5KMz1qpWI7rsPkpBK5Kv15bnZ9Xs6m
	OKU9LiagG7Mw4ia6IQ0W9HwEJeW141w6vgcXqm8GJvQiSOarzGyZpERzru3lxYFBv1zJ1Dwz3RWP+
	8biPMDGHSiGZMhHYSbLvsq5YN59a2xV1Rjx14hY3uz0kdsM1BefoYGjChvQQb6Rc9DAr2IoNMGLVb
	iWFbyseQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMP7y-000000098X2-1PpB;
	Thu, 29 Oct 2026 12:21:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMP7v-000000098WZ-1jhQ
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 12:21:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6EF7468BEB; Thu, 29 Oct 2026 13:20:58 +0100 (CET)
Date: Thu, 29 Oct 2026 13:20:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kyle Bader <kbader@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
	Kyle Bader <kbader@ibm.com>, Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Tushar Gohad <tushar.gohad@intel.com>, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: only fail dma-buf bios that need block layer PI
Message-ID: <20261029122058.GA24811@lst.de>
References: <20261028181412.1919506-1-kbader@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028181412.1919506-1-kbader@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_052103_607003_307DC5F5 
X-CRM114-Status: GOOD (  15.83  )
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
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 06:14:12PM +0000, Kyle Bader wrote:
> From: Kyle Bader <kbader@ibm.com>
> 
> Any dma-buf I/O to a device with a PI checksum fails today.
> blkdev_init_dma_buf_io_ctx() returns -EOPNOTSUPP at registration, and
> blk_mq_submit_bio() fails each dma-buf bio with BLK_STS_NOTSUPP. The
> checks prevent a crash: bi_dmabuf_map shares a union with bi_io_vec,
> and bio_integrity_generate() and bio_integrity_verify() walk bi_io_vec
> to compute the guards over the data.

Please cut down the commit log to the essentials.  It's basicallyr
currently all P2P I/O to devices advertizing integrity data is rejected,
but it should only reject those walking the bio_vecs.

