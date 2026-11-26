Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5654F606A321
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SOjHYxIE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=q88t0pq6+j4JIPvfIujcA+ilbIuTMcI5I1ysuWFv2AM=; b=SOjHYxIEx2IlQ224p+94QIew7r
	zbECB7J04SsCDZRvbRUMgTixDuP+d5Jy/bIVBshKfafYbONjSeGt8bP67U/bIWwu6T0imQ636kUgM
	GRHJAUeVL81gcKwODH/AxQTDUfEkPhC4fJ+Tl7xFLVBdLzwlYjK1Q4ArGMASVAUT3UEcpdABvorVl
	PrNIVMVwY9wHbpWTF59Dxa/+aH0b1aGodK4jMKI/4+6skbI2yNET9mcPPJ3r1iaAm/tKiUpChQvR8
	kdY5eAWXFme6iARSHUe5/is0pw0wve0BAJW4vv5LlMqGZzvjjhAsmgKmHZ2umCUW/tIS74Kv5M2PH
	TISf+9ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWVHM-0000000CSYP-01IM;
	Thu, 26 Nov 2026 08:56:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWVHF-0000000CSVx-2GWE
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 08:56:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C678F68C4E; Thu, 26 Nov 2026 09:56:20 +0100 (CET)
Date: Thu, 26 Nov 2026 09:56:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: use correct network namespace to resolve
 addresses
Message-ID: <20261126085620.GA7904@lst.de>
References: <20261125142033.4889-1-hare@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125142033.4889-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_005625_730155_D16EB3EA 
X-CRM114-Status: GOOD (  10.88  )
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

Can you also look into the Sashiko complaint about __dev_get_by_name?


