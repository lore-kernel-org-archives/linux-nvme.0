Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53487606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eVi4Te8I
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fvStweklcOE1DclpC6n8jN7hDVl5Y9Y6Z9fd9V8u5X0=; b=eVi4Te8IcQLu4R3afsAmsFphjT
	sSK8RiU15PamTIkTHvIUqt5KfIU9h7HGXjrfStCD8oobR6i1h1+T2i23bG7RptzbaSFhjxFVe1DIx
	mTUnkUPpQj90VhEtX2hRu6AuYzArXWX8h2Ucxq0pcZxD4XR4xzycKkO65InJjX3ddGpQiAHNrB2sE
	11bo8RF1q8J0SfzttloCWxsHhWzyk3lsdbd3QX50TmQphNF7zNXM8e6VnIj9vB0FIilhobbmNt+4+
	adVt9zsRNNer86ZdUJaB67Bfn/H9/uLn5WsDaWWWxLRvnsr4hYdyY/Y+U9XSKrTRjK+eEeeNnb7bZ
	sq65Y7Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRBZL-00000007FdV-1fjD;
	Wed, 11 Nov 2026 16:53:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRBZI-00000007Fd8-2nFa
	for linux-nvme@lists.infradead.org;
	Wed, 11 Nov 2026 16:53:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 652EA68D17; Wed, 11 Nov 2026 17:52:59 +0100 (CET)
Date: Wed, 11 Nov 2026 17:52:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvmet: Handle a NULL admin queue in
 nvmet_queue_tls_keyid()
Message-ID: <20261111165258.GA18780@lst.de>
References: <20261029034306.3626274-1-kanie@linux.alibaba.com> <20261029121552.GC24375@lst.de> <6d28ec32-b6af-425c-9cbc-ac1172baf979@linux.alibaba.com> <ae3b49ac-5eb8-45a3-8f3d-9710873ecfbb@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae3b49ac-5eb8-45a3-8f3d-9710873ecfbb@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_085304_857104_8DA25375 
X-CRM114-Status: GOOD (  10.99  )
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

On Mon, Nov 09, 2026 at 10:35:35AM +0800, Guixin Liu wrote:
> Hi Christoph,
>   Any feedback?

I was waiting for a formal patch.  The change looks reasonable.

