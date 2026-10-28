Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5156606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OM1i31u5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7f/Q3Ubg6FLd/TGz1QjLEPKUZ62q3rotuIdvwu7p0cA=; b=OM1i31u5Hn1oizQmZguyxIWr7p
	+vwhxjWMq0wbRudnY3MzrBtCsGBmR2vxIaiKWEjue+Wpeq8zxsozcsJkQIj9XWljcu5Hj3fSKONNX
	hXA2/yWe2Ra54WOpZiXyA3WbRZthtR4AOR4SVmA8SAl0C6n4GdpVYMrXv8pF/So0vfKK2r9Ax78kO
	IBZg5P3KufK7MhvQYnrw3CXIToIrXza7yv3fS1dBy9h01jk1gNedNQg6+P0CwCIWSYVKfs1WAiZR2
	gaY4gj+OCfoDpl9qxCWBlFBJtj9jRgNYPx3FoPrlhjGVQpfAPiR81Q2vPxGoSGAITEuuq75iQ7Zyr
	Ml/tafwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM57y-00000007HOP-1mIt;
	Wed, 28 Oct 2026 14:59:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM57v-00000007HNm-2qvc
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 14:59:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B35268AFE; Wed, 28 Oct 2026 15:59:40 +0100 (CET)
Date: Wed, 28 Oct 2026 15:59:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v2 0/4] nvme: add nvmet zone report and FC
 regression tests
Message-ID: <20261028145939.GD15112@lst.de>
References: <20261022130927.3583166-1-parri.andrea@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022130927.3583166-1-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_075943_884543_7C234526 
X-CRM114-Status: UNSURE (   9.39  )
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
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Still not an expert at reviewing the actual blktests scripts,
but the test contents looks sane to me, thanks!


