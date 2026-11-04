Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E1606A31B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4JVFo0rl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=4JVFo0rljPaon9FT3vd/bDDHLc
	aDFdNLB5ENgMSwrhz3RxLQNaEVeaMLVLdW22bOuxyI3SN3qXfTCU4T1TFkufU/Gu4sQ3F18zU3vUm
	Wjjeh7DInbkXE8DOoUO4hIXrYoR/BM0TKfjMKDf9eOa1OBsSqNU1CxrV3/Erj28W+7ot5Cyb5kifn
	WUDRJU1DSGkqwl+aDXlbqiJqjhdOuD9NQMmpTKuIZpaOiqPI9W1BiPw6NM1ATxtGTP2k1aFQH9+kV
	Tc1x++qx5FbYdYsUvJAZ7rFxiVMvAL+zBF9AuHUNCpxD4WPXPBSTqzhrxVjqPA/bGQPfmhJezSRs2
	+b7IJ8eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOVCz-00000004U5S-1rhQ;
	Wed, 04 Nov 2026 07:14:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOVCw-00000004U4l-2KIq
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 07:14:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5B7FF68C4E; Wed,  4 Nov 2026 08:14:46 +0100 (CET)
Date: Wed, 4 Nov 2026 08:14:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvmet: drop the extra RCU grace period in
 nvmet_ns_disable()
Message-ID: <20261104071445.GB28939@lst.de>
References: <20261104-bug-nvmet-ns-disable-rcu-v2-1-b158a59318ad@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-bug-nvmet-ns-disable-rcu-v2-1-b158a59318ad@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_231454_738759_F9B7DEB4 
X-CRM114-Status: GOOD (  10.00  )
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


