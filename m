Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B79FE77188
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 16:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6QMBa762GTUa3dem0yDYjkLLEbDtHmHWVFp9KpERB50=; b=c6rJjPlNjvP3/M/NmoUi8LmB/j
	1s8fk27qzp8hJM+ZqndwqtxNFQbkhl1YLsw5a57cn6zMWp109kyrFNSwZbeDmmNom9HQ5K0kjupKT
	oVfsN0vQsR4V6ZcfW4C1CRVtU5sNFQNNKqC/XWJ5ev7mFKShAGWuGunf+ReDWLu/j6rdoOc4bEARy
	ZmStUwl6+1e7sQ1d8QWUg2QHogLjvgeOt+nKHETsYhduVKkPJ9stohGKf10Vm9wk75mm21qJzVR71
	T6ArwcNPyacyfrFN+6geswCtw/i3Jtr9L6fNAMWCQ6bpz8IwfLZx7EcYXnIoYwXtJlF/SARG4vbHG
	l0rcp4+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVZ0F-00000009CG9-1Uhy;
	Wed, 08 Jan 2025 16:33:55 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVZ0D-00000009CEu-1fdO
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 16:33:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7AF0C5C4D69;
	Wed,  8 Jan 2025 16:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72C8C4CEDD;
	Wed,  8 Jan 2025 16:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736354031;
	bh=KaRQXQ4B5Tuxsxer6kznfKUePfs6oG6NI2zxhJzX4wM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c2hstfDr1LfQgz2aucHCs4EBfPC5X4VJYmL7XUiRa1llh5AX+IjtroeTQLVxBXq1M
	 G5bL7yk7zMnXJ74vDM2prMa2fSiB5k/tL5cIFpWjzjd+mFvCcditbaspSxn/Lc9++l
	 pbyx4WcfNk824lJ+NuvOeXvXHIE4nn6o3JSrjtIz9GdAULaDOI0Vc7vbE5ZkOCauaZ
	 +BSTmPnewrk5xPSRBCHoOw/Zx9Bo8ajKtP6htUj76cCCNOEdSH1clxHvixrR5XcFGj
	 i8c2nSegL4fO0vy5zQO29kduR/Sv8+E9We0gkbVKhVgjrw3O5DT5gDDF+WguqW/81G
	 5ss9eXCAqPAQg==
Date: Wed, 8 Jan 2025 09:33:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH 09/10] nvmet-tcp: support secure channel concatenation
Message-ID: <Z36o7IqZnwkuckwF@kbusch-mbp>
References: <20241203110238.128630-1-hare@kernel.org>
 <20241203110238.128630-11-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203110238.128630-11-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_083353_476798_3A4AF5A9 
X-CRM114-Status: GOOD (  11.27  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 03, 2024 at 12:02:37PM +0100, Hannes Reinecke wrote:
> Evaluate the SC_C flag during DH-CHAP-HMAC negotiation and insert
> the generated PSK once negotiation has finished.

...

> @@ -251,7 +267,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
>  
>  	uuid_copy(&ctrl->hostid, &d->hostid);
>  
> -	dhchap_status = nvmet_setup_auth(ctrl);
> +	dhchap_status = nvmet_setup_auth(ctrl, req);
>  	if (dhchap_status) {
>  		pr_err("Failed to setup authentication, dhchap status %u\n",
>  		       dhchap_status);
> @@ -269,12 +285,13 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
>  		goto out;
>  	}

This one had some merge conflicts after applying the pci endpoint
series from Damien. I tried to resolve it, the result is here:

  https://git.infradead.org/?p=nvme.git;a=commitdiff;h=11cb42c0f4f4450b325e38c8f0f7d77f5e1a0eb0

The main conflict was from moving the nvmet_setup_auth() call from
nvmet_execute_admin_connect() to nvmet_alloc_ctrl().

