Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6800FD006E
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 04:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qeEZTPqfro3/w/CrmpuzSWrFA/43j2CRMGQpF8dPHf8=; b=bjwNy/jLi8N0JkIEIVjFQxUs/R
	0vEZ3h2pIpVh5sKmEZC+e/2eyi8kmPE86/qm3L2OmExPFeVBVzlWeiiqlzTP6KCFGPgylAox+LRK4
	wxeuD/qxvgnvA0Unmg4lz3aPiKP64c+fjmAArHTxles48K4Z+ju6paDtThpgGamhXuq0R0QyipFWl
	olaHAfzYO59xpsbJPGuwOkMhVBc3veY82gmyekscB0o5TEAJF+R8LRQ0GCJJEkb8T62onvuqOPUo6
	4SMxIuoc/QsNUmdMOMesFze3f297jmXCa7sxUUAuK7+AsNYgzAky+5V2LWeMLiYVF0yFlkvMnkOmK
	IE+zyG8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxGzu-0000000EU3V-3kOe;
	Tue, 03 Mar 2026 04:04:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxGzr-0000000EU38-3gbD
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 04:04:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772510674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qeEZTPqfro3/w/CrmpuzSWrFA/43j2CRMGQpF8dPHf8=;
	b=bLMQUyU+juohwrjBD+M1ArZQY67GSURoyWG1HE5Tto86Z/tDeiD1nBh3ucQRvlHJ/5JX+7
	zzYmOii5RlIcfjwTi5O3v41+gImINYo3f8Q3I2TaP/2sD2QnKaR1h9V/acvnmbU15Mp8eY
	D95/W83uqmMOmXxvVWjWaoiqzFYzgxc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-Yvq0v46uMNOGtLk_xgdLbw-1; Mon,
 02 Mar 2026 23:04:30 -0500
X-MC-Unique: Yvq0v46uMNOGtLk_xgdLbw-1
X-Mimecast-MFC-AGG-ID: Yvq0v46uMNOGtLk_xgdLbw_1772510669
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45B5B1800464;
	Tue,  3 Mar 2026 04:04:27 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.2.16.250])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9FA3D1800370;
	Tue,  3 Mar 2026 04:04:23 +0000 (UTC)
Date: Mon, 2 Mar 2026 20:04:22 -0800
From: Chris Leech <cleech@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 00/21] nvme-auth: use crypto library for HMAC and hashing
Message-ID: <20260302-smuggler-reference-27b41ec7d6e2@redhat.com>
References: <20260302075959.338638-1-ebiggers@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260302075959.338638-1-ebiggers@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: hEasCNx7dbCfqxkl0wQwGzqE2VKs90Nbr8Z4Lk8mOJA_1772510669
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_200436_003926_FCDB08AC 
X-CRM114-Status: GOOD (  23.07  )
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

This series looks good to me.

Tested against the existing code for interoperability in
bi-directional authentication and TLS with auth generated PSKs.

Reviewed-by: Chris Leech <cleech@redhat.com>

On Sun, Mar 01, 2026 at 11:59:38PM -0800, Eric Biggers wrote:
> This series converts the implementation of NVMe in-band authentication
> to use the crypto library instead of crypto_shash for HMAC and hashing.
> 
> The result is simpler, faster, and more reliable.  Notably, it
> eliminates a lot of dynamic memory allocations, indirect calls, lookups
> in crypto_alg_list, and other API overhead.  It also uses the library's
> support for initializing HMAC contexts directly from a raw key, which is
> an optimization not accessible via crypto_shash.  Finally, a lot of the
> error handling code goes away, since the library functions just always
> succeed and return void.
> 
> The last patch removes crypto/hkdf.c, as it's no longer needed.
> 
> This series applies to v7.0-rc1 and is targeting the nvme tree.
> 
> I've tested the TLS key derivation using the KUnit test suite added in
> this series.  I don't know how to test the other parts, but it all
> should behave the same as before.
> 
> Eric Biggers (21):
>   nvme-auth: add NVME_AUTH_MAX_DIGEST_SIZE constant
>   nvme-auth: common: constify static data
>   nvme-auth: use proper argument types
>   nvme-auth: common: add KUnit tests for TLS key derivation
>   nvme-auth: rename nvme_auth_generate_key() to nvme_auth_parse_key()
>   nvme-auth: common: explicitly verify psk_len == hash_len
>   nvme-auth: common: add HMAC helper functions
>   nvme-auth: common: use crypto library in nvme_auth_transform_key()
>   nvme-auth: common: use crypto library in
>     nvme_auth_augmented_challenge()
>   nvme-auth: common: use crypto library in nvme_auth_generate_psk()
>   nvme-auth: common: use crypto library in nvme_auth_generate_digest()
>   nvme-auth: common: use crypto library in nvme_auth_derive_tls_psk()
>   nvme-auth: host: use crypto library in
>     nvme_auth_dhchap_setup_host_response()
>   nvme-auth: host: use crypto library in
>     nvme_auth_dhchap_setup_ctrl_response()
>   nvme-auth: host: remove allocation of crypto_shash
>   nvme-auth: target: remove obsolete crypto_has_shash() checks
>   nvme-auth: target: use crypto library in nvmet_auth_host_hash()
>   nvme-auth: target: use crypto library in nvmet_auth_ctrl_hash()
>   nvme-auth: common: remove nvme_auth_digest_name()
>   nvme-auth: common: remove selections of no-longer used crypto modules
>   crypto: remove HKDF library
> 
>  crypto/Kconfig                         |   6 -
>  crypto/Makefile                        |   1 -
>  crypto/hkdf.c                          | 573 ------------------------
>  drivers/nvme/common/.kunitconfig       |   6 +
>  drivers/nvme/common/Kconfig            |  14 +-
>  drivers/nvme/common/Makefile           |   2 +
>  drivers/nvme/common/auth.c             | 587 ++++++++++---------------
>  drivers/nvme/common/tests/auth_kunit.c | 175 ++++++++
>  drivers/nvme/host/auth.c               | 160 +++----
>  drivers/nvme/host/sysfs.c              |   4 +-
>  drivers/nvme/target/auth.c             | 198 +++------
>  drivers/nvme/target/configfs.c         |   3 -
>  drivers/nvme/target/fabrics-cmd-auth.c |   4 +-
>  drivers/nvme/target/nvmet.h            |   2 +-
>  include/crypto/hkdf.h                  |  20 -
>  include/linux/nvme-auth.h              |  41 +-
>  include/linux/nvme.h                   |   5 +
>  17 files changed, 571 insertions(+), 1230 deletions(-)
>  delete mode 100644 crypto/hkdf.c
>  create mode 100644 drivers/nvme/common/.kunitconfig
>  create mode 100644 drivers/nvme/common/tests/auth_kunit.c
>  delete mode 100644 include/crypto/hkdf.h
> 
> 
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> -- 
> 2.53.0
> 
> 


