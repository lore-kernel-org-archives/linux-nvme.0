Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383A1606A329
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 06:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3Se0hi8L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NWkiYw5MaVfSNZ/WLNkgNxYVJhTyRVVYrGOU/hNKSOk=; b=3Se0hi8L/1dR3VbPKBXymxqklz
	45o4+qEpKwcL4mQqiw1b2EhRVNdstvPpkvHnc9ncX9EBVanaCVH9yq3vEV6aw+LoxePgmWNV5C2B+
	Exq5cRaDwnlPI3joGNlZXWU7beZ/q2UD69BSwTWn2AakdtFqY+Ki3AFG+iCnNzw/jgJ++YTc3Uo7f
	32XmpfCMJ/fUkDEbMyQkNGn4doeR/xZ17+SNb1oX7KbQKuUazYdcyAz09RoGSygastQIKKzPFrmZ2
	7OuCrJtIzxP54leXxmD5aXQdo0lKTU6j9ZY7VcW7PKRaICb+80IiA8u31Hd2RKoCee3v05sGZffKX
	PrTzsDNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7fW-00000001BMv-3kwG;
	Tue, 03 Nov 2026 06:06:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7fQ-00000001BKd-2Aa7
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 06:06:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5633268AFE; Tue,  3 Nov 2026 07:06:40 +0100 (CET)
Date: Tue, 3 Nov 2026 07:06:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	Chris Mason <mason@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 11/19] nvmet-rdma: treat a failed connect as a
 disconnect
Message-ID: <20261103060640.GG1862@lst.de>
References: <20261029155252.2332266-1-kbusch@meta.com> <20261029155252.2332266-12-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029155252.2332266-12-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_220647_596974_1D94F1BD 
X-CRM114-Status: GOOD (  13.55  )
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

On Thu, Oct 29, 2026 at 08:52:44AM -0700, Keith Busch wrote:
> +	/*
> +	 * The peer decides when these events arrive: a REJ is also delivered
> +	 * for a connection that is established, or that we are disconnecting.
> +	 * Whoever takes the queue off the list queues release_work, once.
> +	 */
> +	nvmet_rdma_queue_disconnect(queue);

Very odd wording, I think this needs a surperivising human in the room..


