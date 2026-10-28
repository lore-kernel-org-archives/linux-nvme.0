Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62EA606A31F
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oB6BDhnj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vBgTVzHQFe2aPdSObqg1SHyV3sVR7n01PtlNLIgPSR0=; b=oB6BDhnjTh861/1IEA5z10u/9H
	be4yVaah2PH4sQzHqpk3wBMbpcECIM9CHXAfd5cynYG3iuXtQ16C3VRs3uEie73Q+PeI5KUJ8WmQm
	w99jcgm2z7h4URJphbMQoHd4ibeKE8fUs32RAjH2wfxvfLL5l4BxXQZk58kZaxJfzWvrf10pmhN/X
	+cnvQbOLTYQD/XYFz2f82YhNM0k13K8ud/n0+iDTDo2YoV44dzNz8v4YNsIWlM64NkK1XBGdIns4+
	M6xlDwoS6jTgy6efpuT4W90V1sjaQhqKUEGeAUdSh8mxguz+SgYOrdtfegAi6xeh31J512UVNd2Or
	Hu+aifVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4v7-00000007F6m-1E6b;
	Wed, 28 Oct 2026 14:46:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4v4-00000007F4p-1nth
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 14:46:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9BB0668D0F; Wed, 28 Oct 2026 15:46:17 +0100 (CET)
Date: Wed, 28 Oct 2026 15:46:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Qing Zhang <diasyzhangqing@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: protect nvmet_ports_list with nvmet_config_sem
Message-ID: <20261028144615.GA14239@lst.de>
References: <179275538809.275862.8334230595898232727@tencent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179275538809.275862.8334230595898232727@tencent.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_074626_615083_897F2271 
X-CRM114-Status: UNSURE (   9.74  )
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Btw, I had some old patches here:

https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/cap-analysis

to add clang lock context analysis (still called capability analysis
back then to nvmet) to annotate and verify the locking scheme.  It
would be great if someone could take on that work.


