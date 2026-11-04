Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646CA606A336
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uU1wE1or;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2V0hpRr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FStOBzoT+fPx22zxEE6lOvFUI3PzKHiME65DxeWev/Y=; b=uU1wE1orCrJyqQ+buA5KHxZi2i
	zcU6HlrIbftJC0GIAhdzWiLqqq2GwuAwxnMXZvw5pWVzK5Osx0aFhUGM6Z3h0qBQAGGEYzcG9vUqE
	cR3M0+o9i3BJAMzf92dJdf0qmmIb5Qdewx8HIEKgvepbwM2zZfgvvH8BXMq/Kz27x5XP1frHAWAaY
	hsMyVoUkpbx6iBVincl4NFMP1X9duJZmmYvhbZMc9vI+UpG0OmAC9CZC5TNqFv8TllQRGUfw/Pb5i
	xbxdJ6gn5f5CIxQ3WbD+aNxWzlR+/OKlNkxNCKSNeLsis9+iJhcgV4M/MC94QQ1KPE/LJeEtV88vQ
	7Hrp+xzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdIR-00000005qkq-1uHQ;
	Wed, 04 Nov 2026 15:53:07 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdIQ-00000005qkZ-48tN
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 15:53:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 857F14327F;
	Wed,  4 Nov 2026 15:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B255A1F00A02;
	Wed,  4 Nov 2026 15:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807586;
	bh=FStOBzoT+fPx22zxEE6lOvFUI3PzKHiME65DxeWev/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K2V0hpRrmm7i6ABIxWoPqb0KDMhWoNNejnX1hcJ05fxTueW8buN+YI91B8DCi2bpE
	 nCeNmXWCXsQRWK/yAjWc66xc9Pdn61deqD56TFmSL8vnb3GIbFS0RFb0xkdxhEpfgn
	 8r94T/eKtMsOKRad1lRfZCxz0eZJFrHFsBEAr7/cfc/hUwWH3uuBsRA38Pt/Deljkg
	 ySDcTDQhk9PPGs/wHL2HpClGtNepPhPGlQmBjKevFwhMk6mDDpssRz2rZWt9uUQG6E
	 m1SucgRRfzqdrMFPrBxjgsy5VMMB8+/j3QSiVGILa6JhTJ91WABl3vgDIuEDorRNlA
	 JtfJVFzCKGkVQ==
Date: Wed, 4 Nov 2026 08:53:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, David Howells <dhowells@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <autU4LYsgtOy-Ywj@kbusch-mbp>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-3-jarkko@kernel.org>
 <20261103053303.GA1382@lst.de>
 <aunTlxXbRJ6ZP63h@kernel.org>
 <20261104090440.GA30968@lst.de>
 <autEfTlEWj_OrtB5@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <autEfTlEWj_OrtB5@kernel.org>
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

On Wed, Nov 04, 2026 at 04:43:09PM +0200, Jarkko Sakkinen wrote:
> On Wed, Nov 04, 2026 at 10:04:40AM +0100, Christoph Hellwig wrote:
> > On Tue, Nov 03, 2026 at 02:29:11PM +0200, Jarkko Sakkinen wrote:
> > > And essentially what I would want is key_type_dead not to exist.
> > > 
> > > This version is based on module pinning, and  thus not having that
> > > key_put() would keep key type module alive in that case. However, it
> > > turned out this approach will not fly as AF_RXRPC and DNS resolver will
> > > hit the wall given e.g., the remote pinnings.
> > > 
> > > The approach I'm going for next is to have a type registry instead,
> > > which is independent of the module system (to put story really short).
> > > I think I'm doing this with right process as this really needs a few
> > > trials in order to find patterns that stick.
> > 
> > So what's the plan here.  Should we merge this standalone as a fix,
> > or are you trying to get an entire series in?
> > 
> > If it's useful as a standalone fix, please resend it standalone.
> 
> I'll send this as a standalone patch.

I can just apply it as-is unless you plan to make any change from what
was submitted. Just future reference that the intention wasn't clear
when a series' recipients are split up this way.

