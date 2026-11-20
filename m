Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C160A3828
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vgVD3gCM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=vgVD3gCMaS8iJ95vGo/NDlazmN
	9T3rgMDFSjcRmoJZQsR0BmEdtLktDsmN098yK3cXDw4LKBaIyz3u5YHz3Nu0Ggov9CGjbPlDngj6A
	l7cWwZD4axiP4Nxhv4+dwsyLppKnfsx8uvCjVcE3BggyJq4VQ1YrNgJJfP9fxxrjDAsJdAS9PusuV
	iXrCwyRMEfh2tQ4eftYker+Lhva5Ec5O8KIJD/+j1kO+FG3Vx2152LquTJcGPsp0CM6HDr/zzFgnb
	irsNnQoZROKUZTAmKgZE2yn+sfM8bzrBpun1TpIRBqBSTJ4GJ5TYf7zgCaR96+6IGe2ynfTPfDzIW
	jVkE6RsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSQu-0000000FhXa-3N0P;
	Fri, 20 Nov 2026 17:29:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSQe-0000000FhV4-3rUk
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 17:29:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A621F68AFE; Fri, 20 Nov 2026 18:29:37 +0100 (CET)
Date: Fri, 20 Nov 2026 18:29:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Martin George <martinus.gpy@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, hare@kernel.org
Subject: Re: [PATCH 2/2] nvme-fabrics: use kfree_sensitive() for the old
 DH-HMAC-CHAP secret
Message-ID: <20261120172937.GD1055@lst.de>
References: <20261116100244.7824-1-marting@netapp.com> <20261116100244.7824-3-marting@netapp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116100244.7824-3-marting@netapp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_092941_291431_E1C94085 
X-CRM114-Status: UNSURE (   8.85  )
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


