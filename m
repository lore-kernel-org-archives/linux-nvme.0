Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB60606A337
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Uviktj7E
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tcFCvk5dy/5nZvQXEyJVg4b960/R9SgdjtGuBESCiW4=; b=Uviktj7EW+SNo9pInI4pOGPh5q
	uYQeuvwxD6PxSQSuV7QaDdGQuqk3YiP999/fwI4enW2f1Cn61SZJiKXPcV/kTuGPOQkNT3cs7NkB0
	RdcXDTR7rVQpwFlTLlcLIIvomHbblE/8GgsglHOWASYpk0lV+jjqPkBbnpV7Wa4ZlwQcIg0M8AuQf
	XmmGws9wDJi3KWjgoR6dcbg09fg5tSkenskxgNVbcMX7GX2iVRPM+7X/oXw7WdL9FKgdlcsPL43tb
	57L9Rjoibs9s38KekvGnfmLPioJ8/uZ9q/hL9shgnAS8vkrRKkaLx8kMRxyOJ8p2SIvgDZtoqM0pJ
	Cz02DYMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOWvJ-00000004pPK-16VN;
	Wed, 04 Nov 2026 09:04:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOWvF-00000004pOO-10l4
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 09:04:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E2B4E68BEB; Wed,  4 Nov 2026 10:04:40 +0100 (CET)
Date: Wed, 4 Nov 2026 10:04:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, David Howells <dhowells@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Hannes Reinecke <hare@kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH v2 02/11] nvme-keyring: Add a missing key_put()
 call to nvme_tls_key_lookup()
Message-ID: <20261104090440.GA30968@lst.de>
References: <20261103030226.2685251-1-jarkko@kernel.org> <20261103030226.2685251-3-jarkko@kernel.org> <20261103053303.GA1382@lst.de> <aunTlxXbRJ6ZP63h@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aunTlxXbRJ6ZP63h@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_010446_207528_7DCB6EA0 
X-CRM114-Status: GOOD (  17.52  )
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

On Tue, Nov 03, 2026 at 02:29:11PM +0200, Jarkko Sakkinen wrote:
> And essentially what I would want is key_type_dead not to exist.
> 
> This version is based on module pinning, and  thus not having that
> key_put() would keep key type module alive in that case. However, it
> turned out this approach will not fly as AF_RXRPC and DNS resolver will
> hit the wall given e.g., the remote pinnings.
> 
> The approach I'm going for next is to have a type registry instead,
> which is independent of the module system (to put story really short).
> I think I'm doing this with right process as this really needs a few
> trials in order to find patterns that stick.

So what's the plan here.  Should we merge this standalone as a fix,
or are you trying to get an entire series in?

If it's useful as a standalone fix, please resend it standalone.

