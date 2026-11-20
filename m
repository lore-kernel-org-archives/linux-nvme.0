Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E9D606A336
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RsEo83rM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XPIu5x3uqDSf1Kw0x16maCUBjgEEEdDwdENGm22dr0s=; b=RsEo83rMQ9uU05bCrH84toEH8h
	9ES37muSBruFjrL3nehJfSZmoFcETGpUWnDx9MKa6Yn/nKXZ8auPjTGYAdiuevhdAZQW4yw8G3jhg
	WjlvPhjxIgXF8aF24ss9Om4ekopfXNeMA1ogJsNVg+VRj1dnZaCZsiaNjiBPwudOohuWpvRjxu5Ml
	C84iErHZvCNvrW0AuhBnBV5PI9FdbA/c5UrxU0ZYmQ0QChh+VRz4P7q2eNICgXQxQysTpyOz2gddv
	ImTOtikbQ9D86k8zvbtaaYcE/5Fv0Hms5tFijuCLUjF1770QRc2uVuZj3GfmYuHyyEEaWEutmhvi4
	vQxamtxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSdo-0000000Fl63-2uu0;
	Fri, 20 Nov 2026 17:43:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSdd-0000000Fl1Q-15MB
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 17:43:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0CE096732A; Fri, 20 Nov 2026 18:43:00 +0100 (CET)
Date: Fri, 20 Nov 2026 18:43:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Changyul Lee <lcy8047@gmail.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Stephen Bates <sbates@raithlin.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: look up the P2P device under rcu_read_lock()
Message-ID: <20261120174300.GA1408@lst.de>
References: <20261116022558.560013-1-lcy8047@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116022558.560013-1-lcy8047@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_094305_579523_4703B982 
X-CRM114-Status: GOOD (  12.26  )
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

>  static struct pci_dev *nvmet_req_find_p2p_dev(struct nvmet_req *req)
>  {
> +	struct pci_dev *p2p_dev;
> +
>  	if (!IS_ENABLED(CONFIG_PCI_P2PDMA) ||
>  	    !req->sq->ctrl || !req->sq->qid || !req->ns)
>  		return NULL;
> -	return radix_tree_lookup(&req->sq->ctrl->p2p_ns_map, req->ns->nsid);
> +
> +	rcu_read_lock();
> +	p2p_dev = radix_tree_lookup(&req->sq->ctrl->p2p_ns_map, req->ns->nsid);
> +	rcu_read_unlock();
> +
> +	return p2p_dev;

Not sure what the RCU section is supposed to protect here.  If we
don't get a reference the result can be stale as soon as we're outside
the critical section.  So IFF this is a real bug, it isn't fixed as
easily.


