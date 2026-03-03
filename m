Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412B7EDEBF5
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 22:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pl2zG4pI79B5FV4b1qWY7o+8Dm13AOeYPsXsZmBVTMc=; b=41so4Yw40DPPZ79HDaumcWx4Id
	cJY2Kq235WbcKipAx9+ivOqzWC1c5yNnFTnM6RRgYpqBXjGCQUYAStYuKQOfFzrrbwaQ/z6ccQCEo
	V80XfNh53Mm01v65jq5D025gQWtubHsDQpFl/FpAgVhjXGMGCIY+Aup47adDFs1GF2oSlZPXYI035
	CGywD2TG64R4EYz/mxDN79uJnMbsf8yAlAxWLj5nct94gHcYjS9Fsy8sUGqXQY3v8FMGATJAmDIYP
	PGXYcTNwsQbwzOk68XUGFqasRkLnK1+5HPANRQhxhcRb5PGrCquuV6DieVg6XiqKhwV8sPpDMNH0h
	isvsb03A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxYXD-0000000G3X0-3qgC;
	Tue, 03 Mar 2026 22:48:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxYXB-0000000G3Wa-2yAb
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 22:48:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772578088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pl2zG4pI79B5FV4b1qWY7o+8Dm13AOeYPsXsZmBVTMc=;
	b=H7TVK/8GBTk7a8u2gaW3JKgA/BI45wxvXs7BUvpT0IKNVxHAFyd4kWhZ5EqcLxaenKlwRZ
	1wvjjzLVnOYW81wPATtkSzJes9vQzZ52j5MaKj05RUlizsZCh7ymJi1y6gShQ4cA7JFl1Y
	mV0uj7elj30Iiu3YSsZqyV4YcEPfW8Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-RgNbitvyOf-TNuzEwPefWA-1; Tue,
 03 Mar 2026 17:48:04 -0500
X-MC-Unique: RgNbitvyOf-TNuzEwPefWA-1
X-Mimecast-MFC-AGG-ID: RgNbitvyOf-TNuzEwPefWA_1772578082
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48965180034D;
	Tue,  3 Mar 2026 22:48:01 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.2.16.250])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9194718005A7;
	Tue,  3 Mar 2026 22:47:57 +0000 (UTC)
Date: Tue, 3 Mar 2026 14:47:56 -0800
From: Chris Leech <cleech@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 04/21] nvme-auth: common: add KUnit tests for TLS key
 derivation
Message-ID: <20260303-slush-hydrated-8b1929ec6a30@redhat.com>
References: <20260302075959.338638-1-ebiggers@kernel.org>
 <20260302075959.338638-5-ebiggers@kernel.org>
 <1de7ef59-4236-4372-81f6-60d5a4f1e253@suse.de>
 <20260303002649.GE20209@quark>
MIME-Version: 1.0
In-Reply-To: <20260303002649.GE20209@quark>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 0J9RIjIGHNGoah6gj2ERqnE6d76IL5mRPRjUaRi7Lo8_1772578082
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_144809_823972_6D620D66 
X-CRM114-Status: GOOD (  17.67  )
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

On Mon, Mar 02, 2026 at 04:26:49PM -0800, Eric Biggers wrote:
> On Mon, Mar 02, 2026 at 11:04:43AM +0100, Hannes Reinecke wrote:
> > Which discrepancies do you see between the specified algorithm
> > and the implementation?
> 
> I'm looking at the latest NVM Express Base Specification, v2.3.
> 
> First, there's the following:
> 
>     The host computes KS as the hash of the ephemeral DH key resulting
>     from the combination of the random value y selected by the host with
>     the DH exponential (i.e., gx mod p) received from the controller
>     (i.e., KS = H((gx mod p)y mod p) = H(gxy mod p)).
> 
> The actual code skips that step when deriving the PSK, and just
> considers the DH value directly to be "KS" and uses it directly as an
> HMAC key.  That is something that should never be done.  DH values are
> not uniformly distributed and must not be used directly as keys.

I'm doing some testing with a patch to immediatly hash the DH value
after the kpp request is complete, fixing nvme_auth_generate_psk(),
while removing the hashing step from nvme_auth_augmented_challenge().
That only allows the use of KS as the raw DH output is not saved.

But, I think things are saved by DH values always being larger than the
HMAC block size and therefor hashed within hmac_shaXXX_preparekey().
Maybe more lucky than correct, but the same result.

- Chris


