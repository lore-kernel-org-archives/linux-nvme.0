Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D6F606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=stW4oEhv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=iTAj/l0Wsa0dWyHr2HUK0KSTuSgtFX39Oe4ZR01XU7Q=; b=stW4oEhvji0z5xqDci0t/G+HQC
	4OjXSQSug1r+VI5E6dt+vS4CcbBJCktB6GtxRmzwnMUoSM+plKoF8AKqzyZPKR9ZzzB7MqlqGXXIc
	30617KHX/fQCveTufTyHxkp7PAGFz+0OfR3EwSXA5Vt0/Q1708UWAu779pA2YKCwarA38dT4EZ0fx
	bRjK87zOoo/4FArOX8rbX3JZMfkXtnT1Hafq9wDn62lbDsTTJS8CLJiwYWplsUjNzzDMCXkQIbZB4
	4971p1TxiBWYvd/NdBJbizjWl28LjB0T1UBP7QxY8Y78e9vVKs70JI7eXr+1wnvpybZY4z0WKlWJ/
	VcsycK3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM6KX-00000007WYi-24Wx;
	Wed, 28 Oct 2026 16:16:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM6KV-00000007WXo-3PDl
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 16:16:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1A74B68C4E; Wed, 28 Oct 2026 17:16:40 +0100 (CET)
Date: Wed, 28 Oct 2026 17:16:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Erwan Velu <e.velu@criteo.com>, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-kernel@vger.kernel.org, Erwan Velu <erwanaliasr1@gmail.com>
Subject: Re: [PATCH] nvme: honor the volatile write cache enable state
Message-ID: <20261028161639.GA21871@lst.de>
References: <atJXYHJa4jkUWJmP@kbusch-mbp> <CAL2Jzuz1qFwLSA=iivp5qLCTL6-4rvKmvFzJbOQzjPu6j_7Y2A@mail.gmail.com> <atJeazM_rJ0uj3vt@kbusch-mbp> <CAL2Jzux8v6zCxfcdd=MY5n0zQMVSa-_8Lki9z-fz7bFShNf7vw@mail.gmail.com> <atJk_2FmzjUZYO_Z@kbusch-mbp> <f665dc3e-fc5c-4352-8e41-a46b7ae97946@criteo.com> <CAL2JzuwuZp0gg1D7wSn7cdgpnhotnuLP6YpPd-SrdVyqhkeiJw@mail.gmail.com> <atqZmctbU0siYmVX@kbusch-mbp> <7fec6534-9e57-4041-8699-72c5950c7e2a@criteo.com> <auId5RuBhMFGirJ1@kbusch-mbp>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auId5RuBhMFGirJ1@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_091648_007134_4B01F750 
X-CRM114-Status: GOOD (  13.76  )
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

On Wed, Oct 28, 2026 at 10:08:05AM -0600, Keith Busch wrote:
> > Considering the performance impact for these type of device,s would you be
> > open to a backport to stable once merged ?
> 
> Not sure when a performance improvement is stable worthy. I'm more
> concerned that doing this is going to expose corruption, but it's what
> the device is asking for, so fine to introduce it, but stable is
> questionable.

Same here.  We should not send these improvements to stable, but let
them soak in linux-next and mainline.


