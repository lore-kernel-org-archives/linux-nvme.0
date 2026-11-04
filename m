Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD027606A326
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PSkXnere;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBBqnkMJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nUB3f0u/OAhwBngmBxLo2s/x0auuF9zUa4v/an2QD/Q=; b=PSkXneremn3Wj0M3kCn0e3Dm5b
	m7f6lO6Vc1rGgKPVTKoMMmf5d6l+8g1TrA8mm1CgQQz7IMaZda9ylU+D9w6r34kVvjL3v46rCBHT5
	uRWZh50wPFGb0Br3s5L58A/Eue20FZIzv2qjFksjmGI883Hkt8TiU5MUV8ctFf+g2wyFNYFkw1SOD
	bmBczWD3nN9nHVT9eV42HvGiqzqTJw0D1OHOPdUZD8FqqQOykGDwkwam0wlhi9zZbmvLa9FejA0N5
	Fth+1okTYieTZ7Z2lObQS2wOIWRFindxgu0kXXzKcEItU6UONRPR2TZBaophiPyzqmBCDHFZ7boiC
	aCXSZ5aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOcDF-00000005fs6-1ZP9;
	Wed, 04 Nov 2026 14:43:41 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOcDD-00000005frq-3sA0
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 14:43:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 5F91060A87;
	Wed,  4 Nov 2026 14:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 931151F000C1;
	Wed,  4 Nov 2026 14:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793803419;
	bh=nUB3f0u/OAhwBngmBxLo2s/x0auuF9zUa4v/an2QD/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lBBqnkMJGfU/RX/i1wy6Mgf11gEeRIwGdYrVz3E84VPrWCz5y9Ym6yDDe+YEA5XIZ
	 Fcrrt0e97l90jSNqEGEQUcVgPkJIwlko5sxtFu7wfxdKU4EzusiAfuPYuDEz/9NEru
	 ort8wMMMVvPaqrqGvw5+dKtzSD6VEZsG4QGhYTNqVbWYzE4FG0TG3jcym354tAa0gl
	 uszgK0DFwtJPsNudSqxKuH/IYYmuPYnxKWNoEcdffg7WeFSWhvfsS5q+IaVDodpXW4
	 +b/wGXuBqHdrAQsxY6zX222R5ce6bWmlqZOL4TRZeFTXoDU1zneSD4gmIFONXbJcEf
	 g4syZZlvnAlLA==
Date: Wed, 4 Nov 2026 16:43:35 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org, stable@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
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
Message-ID: <autEl7wvRjt2hgVD@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-3-jarkko@kernel.org>
 <73883d88-b772-4c5a-8f1f-6b12c4501bb5@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73883d88-b772-4c5a-8f1f-6b12c4501bb5@suse.de>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 08:45:11AM +0100, Hannes Reinecke wrote:
> On 11/3/26 4:02 AM, Jarkko Sakkinen wrote:
> > Call key_put() before returning -EKEYREVOKED, as the reference count gets
> > incremented by key_lookup().
> > 
> > Cc: stable@vger.kernel.org # v6.12+
> > Fixes: 5bc46b49c828 ("nvme-tcp: check for invalidated or revoked key")
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >   drivers/nvme/common/keyring.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> > index 32d16c53133b..87cb51e1f5a7 100644
> > --- a/drivers/nvme/common/keyring.c
> > +++ b/drivers/nvme/common/keyring.c
> > @@ -35,6 +35,7 @@ struct key *nvme_tls_key_lookup(key_serial_t key_id)
> >   	}
> >   	if (nvme_tls_psk_revoked(key)) {
> >   		pr_err("key id %08x revoked\n", key_id);
> > +		key_put(key);
> >   		return ERR_PTR(-EKEYREVOKED);
> >   	}
> >   	return key;
> 
> Reviewed-by: Hannes Reinecke <hare@kernel.org>

Thank you.

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

Br, Jarkko

