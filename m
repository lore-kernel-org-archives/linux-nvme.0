Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE754606A333
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lU9H59+R
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RpUaUKW/sfINCkSjW1+0rD0rYF650qeXKPQDaI/L+L4=; b=lU9H59+RUtfdk6XRZOd2ar0mOK
	Y7LFYJUca63qCjkklm0/pBSaMcUPZNOK2AcVqN6A7DkD4ZeLZMqbbHgqIPeCOHRgikK/NxhTuB+3+
	uBF5q6R2gfUcGy+w+eJrm4rNjIhrTw/fjcD0uo9izAKHxmjSjwKDxAmE/PaB5bXaaCPK9HFMXsK4e
	7JcON9GFqvjE8DYhOoy76N0YwafgHJCbGi3YZYHMAqfVdf/txspiUaUmY6YsbYXuAri4D+hvTup4D
	Eqjl3KD3UJkme9gQvfBgFiYeyKS67kxnYgC9bwAKlCmeWJkDhLN+zvFEHXk+8BVMcLQLzU1RvZMaW
	FcrEp1pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWV3y-0000000CQKw-14Gr;
	Thu, 26 Nov 2026 08:42:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWV3v-0000000CQJf-0CVE
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 08:42:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 53E5068B05; Thu, 26 Nov 2026 09:42:30 +0100 (CET)
Date: Thu, 26 Nov 2026 09:42:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bin Luo <luob87709@gmail.com>
Cc: linux-nvme@lists.infradead.org, nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] nvmet-fc: put queue ref after FCP IOD cleanup
Message-ID: <20261126084230.GA7543@lst.de>
References: <20261125115444.783-1-luob87709@gmail.com> <20261126051624.601-1-luob87709@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126051624.601-1-luob87709@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_004239_232592_C3378890 
X-CRM114-Status: UNSURE (   9.69  )
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

In the future, please send new or revised patches separated and not
as a reply in a thread, though.


