Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63E4606A321
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 05:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TYuHTM7N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=O6Ks90UOzjrAcrR9Y56o/keqAZb9C70ipG1oPffIQ5k=; b=TYuHTM7NRtfqy+zMmhGaADqqHQ
	CxWpiBsSntZyMjETHPKRU0sNz64gMgNHNovYZflWtytJurZc4YA9sU5JboqIaplNHZbSVTUm/TtRF
	Cg6MQ/NdfolGF1Yecd1Hd58ip8KkrlQzeObek8UEGZ//ehamSs5lCwWZD4VXLDL6j/LG34iwMqBkU
	OBd8BXVY8c3e7xkWiA0NBF4yQIsSiNcKCYLxi0eWp+HHmCS3p49TEE0bT1wtTRGSepaqwQthYDALR
	STpD6t4Vq0Tc8Yb3HItCF9XhrT1Y6ia2/mAS/G7af8SyKiHZL2L8kr8QAUKgq6VsDgFzXOUqDdR6m
	0k1f1lkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW5eC-00000008TKs-1meZ;
	Wed, 25 Nov 2026 05:34:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW5e8-00000008TKP-22cs
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 05:34:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C6BCD68AFE; Wed, 25 Nov 2026 06:34:16 +0100 (CET)
Date: Wed, 25 Nov 2026 06:34:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>,
	kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, jgg@ziepe.ca,
	leon@kernel.org, asml.silence@gmail.com, joshi.k@samsung.com,
	anuj1072538@gmail.com, linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org
Subject: Re: [RFC 4/4] nvme-rdma: support dma-buf backed requests
Message-ID: <20261125053416.GB20407@lst.de>
References: <20261118103327.1788667-1-anuj20.g@samsung.com> <CGME20261118103457epcas5p17770752b910960b84cc259d007120965@epcas5p1.samsung.com> <20261118103327.1788667-5-anuj20.g@samsung.com> <20261121003730.GB14598@lst.de> <20261123111040.7b2q7fe2xd6k6777@green245.gost>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123111040.7b2q7fe2xd6k6777@green245.gost>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_213421_978859_019F6ADA 
X-CRM114-Status: GOOD (  14.26  )
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

On Mon, Nov 23, 2026 at 04:46:55PM +0530, Nitesh Shetty wrote:
> On 21/11/26 01:37AM, Christoph Hellwig wrote:
>> How does this work with rxe/siw or non-PCIe based HCAs?
>>
> rxe/swi do not provide a DMA device, so registration fails with
> -EOPNOTSUPP (patch 3).
>
> For hardware HCAs, the dma-buf is attached to the DMA device of the
> ib_device. Nothing in the mapping path is PCI specific, and if P2P is
> not possible for non-PCI device, we expect the exporter's
> pci_p2pdma_distance() check to take care of it. We do not have access to
> non-PCI HCA setup, so that path is untested.

Ok.  Can you add comments?


