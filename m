Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2B6606A329
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ku4RR4XC;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=El2cdMbT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jrtokQE/RgxkkYzzF49cdR+5C0s6jUzSVCuRBLTOprI=; b=Ku4RR4XCvhY0IlbtLIEhmNBBWF
	pn3pCKURVpmzcsKTB2mGBk3C/pjgggMxR4sadyeCARr+tg6qslCDMbRxmARjeB0X51U52STi/0LkI
	EZSpALBgUJB7dklhQiTDAKgnENPgNz6YlY9O+yLEmU7fvI5nSnlfvq3YyyZ5XHxOFRxeAATqHyghT
	txc6rCcu9KW+YMnaeQEjiF6z/8Asd2ZBM4jir2Zzuhi3Cx/Msp6wrv4JwrrdY8yp89FT/BqYLFyn1
	v3IP1HP0k7r7xwhgNgmgpHFN/29W4T0tEO64w6GiPkHLpWLn7PJIWAD72kc8MFWRMb6LVIBOC2fUJ
	wt17NKHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOcCq-00000005fny-0dKm;
	Wed, 04 Nov 2026 14:43:16 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOcCo-00000005fne-34Yh
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 14:43:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 314F260A58;
	Wed,  4 Nov 2026 14:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 634411F000C1;
	Wed,  4 Nov 2026 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793803393;
	bh=jrtokQE/RgxkkYzzF49cdR+5C0s6jUzSVCuRBLTOprI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=El2cdMbT9/Ycg08xrNK1h/3RGRI6E2bIZujS+lh5VKjo631kbMKpWQQVdn7QoJ2Y0
	 TPYardS7GvwoDTTPMVamG4mWjbV0G9qDnW3VCnDCcHY9LRvdfQ70AUif/h9Jf7W8KR
	 qxoHixYDs9Lriqk0kmSBkxZ/OMs6ndP1LJokWOCb7+R/ThbParGMsbbwixuyths59w
	 uyuX4WADQ8187FQRsexCeUjQfK65Xn6qtBJH9rKXcvUYlXj+G1pG5q0Y8JLDnbUT+j
	 gUT5iVsVK149iijFJeaWrRGnjzNbTG9t4G9EIg8v5R7yySvLo1TxPjF7GKUx/H8guT
	 fdePnMrirXG4A==
Date: Wed, 4 Nov 2026 16:43:09 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org, stable@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Hannes Reinecke <hare@kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH v2 02/11] nvme-keyring: Add a missing key_put() call
 to nvme_tls_key_lookup()
Message-ID: <autEfTlEWj_OrtB5@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-3-jarkko@kernel.org>
 <20261103053303.GA1382@lst.de>
 <aunTlxXbRJ6ZP63h@kernel.org>
 <20261104090440.GA30968@lst.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104090440.GA30968@lst.de>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 10:04:40AM +0100, Christoph Hellwig wrote:
> On Tue, Nov 03, 2026 at 02:29:11PM +0200, Jarkko Sakkinen wrote:
> > And essentially what I would want is key_type_dead not to exist.
> > 
> > This version is based on module pinning, and  thus not having that
> > key_put() would keep key type module alive in that case. However, it
> > turned out this approach will not fly as AF_RXRPC and DNS resolver will
> > hit the wall given e.g., the remote pinnings.
> > 
> > The approach I'm going for next is to have a type registry instead,
> > which is independent of the module system (to put story really short).
> > I think I'm doing this with right process as this really needs a few
> > trials in order to find patterns that stick.
> 
> So what's the plan here.  Should we merge this standalone as a fix,
> or are you trying to get an entire series in?
> 
> If it's useful as a standalone fix, please resend it standalone.

I'll send this as a standalone patch.

Br, Jarkko

