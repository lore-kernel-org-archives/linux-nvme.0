Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CDA606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FbuFBPp2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=FbuFBPp25XJV84/XtO5Usd6y9B
	dvZLY2zNVZ4W93r6h3sGWsHbcH97L9Ce1ajTM/QhBNQ0ChpPXJkyziYQCPWidmWZlxKqHXcMPTM7a
	fJ2NPfVnGCBLFUv/cO/kSI7saG0ea7fiTQ8VOvCerl0XJAhR4WiMZSm/xNx1NzX2yDvIZYNu9r8aI
	pyeAOHiVcrIPLWedYYS39FFVowpVzv8waTv0tiMGdxjVT4lXu0eQj7o0Udy5RtMZi4XBSi7jkOff/
	byQMmsbDXGkiIQGcUR2QfaEZ/MFNmU5i6pqgERP1RzFjXU59f+3OMyxRO9wPdEOfvD0bPkETpoIMv
	QnenoQwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4z7-00000007Fz2-0vR7;
	Wed, 28 Oct 2026 14:50:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4z3-00000007FxL-2wZu
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 14:50:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BAF0F68E0B; Wed, 28 Oct 2026 15:50:29 +0100 (CET)
Date: Wed, 28 Oct 2026 15:50:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: bestswngs@gmail.com
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, xmei5@asu.edu,
	stable@vger.kernel.org, co+e015e82956da641b@bugs.sh
Subject: Re: [PATCH nvme] nvmet-rdma: reject short connection requests
Message-ID: <20261028145027.GB14583@lst.de>
References: <20261016172336.286341-3-bestswngs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016172336.286341-3-bestswngs@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_075033_890209_0D05636C 
X-CRM114-Status: UNSURE (   8.44  )
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


