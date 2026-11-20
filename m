Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C7E60A2612
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rIDWFkW9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=rIDWFkW9IATMJmtj2hXrM7CLnP
	rWCl7iYKDsQh3URyi8AvNqm3LUsn6fpAnuDArI+FDhFBQTnH1ACF5szvm15x7Cas/NnbCKz/lF6vU
	bduCoM0REEvi6AYQpMHWW17L8OqG0jYim+G/WNTF22zYwEOz6/t21uYW9KRuKrna8Xkvm8eNOCuIW
	SoxH6uJz6B/PwxG4WPBYvnjC30kDcX5R935lsK6uDZFo78xbPYGe4Bdy7hiwOobmdi56K9tJZpzOR
	MkaBPICITxA7TJaxqKc4fTvMAEQDstzY36wW6KPT4nhRJGu1lRP/6DyIJbgQhAQyjoZz9FuZ5uPr3
	P9NBnZ4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSQR-0000000FhRZ-2D57;
	Fri, 20 Nov 2026 17:29:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSQN-0000000FhQa-1I54
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 17:29:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 081F06732A; Fri, 20 Nov 2026 18:29:20 +0100 (CET)
Date: Fri, 20 Nov 2026 18:29:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Martin George <martinus.gpy@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, hare@kernel.org
Subject: Re: [PATCH 1/2] nvme-sysfs: use kfree_sensitive() for DH-HMAC-CHAP
 secrets
Message-ID: <20261120172919.GC1055@lst.de>
References: <20261116100244.7824-1-marting@netapp.com> <20261116100244.7824-2-marting@netapp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116100244.7824-2-marting@netapp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_092924_668548_D8582350 
X-CRM114-Status: UNSURE (   8.77  )
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


