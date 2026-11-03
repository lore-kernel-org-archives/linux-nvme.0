Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3A4606A336
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cLhJIHJ1;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FuOZFi7g
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DUyYtY0/ODWml+wjlW+GZawiWsZztBIYKliIpArIvIM=; b=cLhJIHJ1wOkX3OS1P41PJG3fE7
	Y3nrbUn072seoeBKISnjzLDMFRiLGYbwFEkMurnfOVvAAjrYbowhkRpwsQZCZpeFzsKS3VzJ7qmJm
	vt4zxc06p9oCTb1i2CbcSnGyxet1WNUtCAxT9mu12ISblBaTf8H/glk+g7a7CJFd6E9hKrtEOF1C3
	cPkxyEA2Z4+xVPlEsu4la8MmJgIWdk5T72X6L0P3BfSGdby4RyB0Qq/1Xs3tb8L0FMuYNcgv0ecKc
	m3RML8sWVIwi7Ij9JlSDIZDCzX6fvVgBiFGORPnEcDX3nPQ0AfZAooNxq1d/sVV0jCoUVzM8UqKJd
	vK/cMLUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xODde-00000002Nne-0pV2;
	Tue, 03 Nov 2026 12:29:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xODdc-00000002NnM-11hr
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 12:29:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 9EB476020A;
	Tue,  3 Nov 2026 12:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CB9EF1F00919;
	Tue,  3 Nov 2026 12:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793708955;
	bh=DUyYtY0/ODWml+wjlW+GZawiWsZztBIYKliIpArIvIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FuOZFi7gvZM9i0KCFVY+MbFRT83CKlZXVW1c/zMGlL01IeFLhKm9ANExZwHgYnGjH
	 lDzdtIeko4Y+RR89YJAlRc7qMht6BVg5czhNrji69ZV/F0S0bQWE5SUtPKF9R85N7/
	 6yljfx0vSxi3pU4beygEoFcEPlG/XJkIJm5NpSbl/9qO8mIzB3hCQvJEssQ3MRL42m
	 KSpfAm0oTxTEn9+oLbZbzpJYHiN1B0dapz8GJdlcK33EuWU1z1OO1kR+nzeHGllk4c
	 4wGyl55Pdx/qkprc27S8bORd228J8HwQtRwdMkcFbPeG3mmY/HVQi4U4X6ZbzZ/Z58
	 6zGmpJtfDd+yQ==
Date: Tue, 3 Nov 2026 14:29:11 +0200
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
Message-ID: <aunTlxXbRJ6ZP63h@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-3-jarkko@kernel.org>
 <20261103053303.GA1382@lst.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103053303.GA1382@lst.de>
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

On Tue, Nov 03, 2026 at 06:33:03AM +0100, Christoph Hellwig wrote:
> On Tue, Nov 03, 2026 at 05:02:07AM +0200, Jarkko Sakkinen wrote:
> > Call key_put() before returning -EKEYREVOKED, as the reference count gets
> > incremented by key_lookup().
> 
> Looks good, but I only got this one patch out of a 11 patch series,
> so without the full context it's hard to fully review it.

I can it is just I rather do it on request because some people complain
when doing what you asked :-) Regardless, the bug is independent of any
patch set changes.

I'll summarize the context below (ignore or read).

I tried to tackle: https://lore.kernel.org/lkml/20261101221519.GB2689@quark/

And essentially what I would want is key_type_dead not to exist.

This version is based on module pinning, and  thus not having that
key_put() would keep key type module alive in that case. However, it
turned out this approach will not fly as AF_RXRPC and DNS resolver will
hit the wall given e.g., the remote pinnings.

The approach I'm going for next is to have a type registry instead,
which is independent of the module system (to put story really short).
I think I'm doing this with right process as this really needs a few
trials in order to find patterns that stick.

Br, Jarkko

