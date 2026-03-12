Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFF9FED2CA
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2026 04:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=758/p5Z34UQmptq6xYubsfLhB0GE/5cKHWc56wNdOsE=; b=AJ+BYRMJlwePO5TiY2A4/RR74u
	roBu3vRfX5JX924b2ibv8PM2ejZySWqWXjoV4QRvTeNPB8y2AfCFGoMqm59Joi1hcw7inmWhRj6mA
	MlZiYDl2DJBe2AQ2ykJF74A9vDTuhehZY9MabFhjSbx/6opZinIZebwoVsySPpskCpgy68KO6o9rm
	4/2alfFA89yvOei1p7gmDE4uBj2LgRdKU01eGJvoVnnjTdQahBSaZ6MfVR08BEovwR7aaBuQeejlv
	1C8q5yKkmenHJ8lBfnoqUjVv9jPxYPFtqPPlAjXOlOOcEkUINMPwK7sbMCrUsYjbWs3AWivz7Z70k
	8DALd6TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0XNM-0000000DDqo-2gIi;
	Thu, 12 Mar 2026 04:10:20 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0XNK-0000000DDqR-0fCp
	for linux-nvme@lists.infradead.org;
	Thu, 12 Mar 2026 04:10:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 72BDF43975;
	Thu, 12 Mar 2026 04:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1805CC4CEF7;
	Thu, 12 Mar 2026 04:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773288617;
	bh=klMD8MEKBgp6c8CXd8OfwH3hoRILlV4Mv16Y1Vg2yGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IbTP6lbYxoiQviq00T/TZN8mPq9jEu2IoxfFYf1lII/KBI9Pk3ZwvDUsobCGt6RaL
	 Gt9wL8OrAYJUC4je0EuoiNPM6499g5l4hjEFJIAHr0Nk3UrXXWW8bB1hgSMNalAwh4
	 tlk41CfmP08JRPjuGJzVmb7ro9e0XOgcSKDxR7/hQNVWc1qj5wq2OPrjW6F5U5uamr
	 lcY9NU5JVrmwj18RyV6ls8+TS75YY3mvvvOx5Be/J4JIrTGc1s1fSbtopT8S4j1iyb
	 0wk+G8hy/eOfxS3YFg+hWgqH/4/BTKzG8ab8zh6V0nBV2fsXDbr3TpogQHVrJFqnqM
	 VZ/vA0RtWTBbg==
Date: Wed, 11 Mar 2026 21:09:18 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2] nvme-auth: Hash DH shared secret to create session key
Message-ID: <20260312040918.GB2359@sol>
References: <20260311012116.2504291-1-cleech@redhat.com>
 <20260311231643.2672061-1-cleech@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311231643.2672061-1-cleech@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260311_211018_252836_A3CD38B2 
X-CRM114-Status: GOOD (  21.80  )
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

On Wed, Mar 11, 2026 at 04:16:43PM -0700, Chris Leech wrote:
> The NVMe Base Specification 8.3.5.5.9 states that the session key Ks
> shall be computed from the ephemeral DH key by applying the hash
> function selected by the HashID parameter.
> 
> The current implementation stores the raw DH shared secret as the
> session key without hashing it. This causes redundant hash operations:
> 
> 1. Augmented challenge computation (section 8.3.5.5.4) requires
>    Ca = HMAC(H(g^xy mod p), C). The code compensates by hashing the
>    unhashed session key in nvme_auth_augmented_challenge() to produce
>    the correct result.
> 
> 2. PSK generation (section 8.3.5.5.9) requires PSK = HMAC(Ks, C1 || C2)
>    where Ks should already be H(g^xy mod p). As the DH shared secret
>    is always larger than the HMAC block size, HMAC internally hashes
>    it before use, accidentally producing the correct result.
> 
> When using secure channel concatenation with bidirectional
> authentication, this results in hashing the DH value three times: twice
> for augmented challenge calculations and once during PSK generation.
> 
> Fix this by:
> - Modifying nvme_auth_gen_shared_secret() to hash the DH shared secret
>   once after computation: Ks = H(g^xy mod p)
> - Removing the hash operation from nvme_auth_augmented_challenge()
>   as the session key is now already hashed
> - Updating session key buffer size from DH key size to hash output size
> - Adding specification references in comments
> 
> This avoid storing the raw DH shared secret and reduces the number of
> hash operations from three to one when using secure channel
> concatenation.
> 
> Signed-off-by: Chris Leech <cleech@redhat.com>
> ---
> v2: 
> - Renamed nvme_auth_gen_session_key() arguments from ctrl_key to
>   public_key, as it is the peers public DH key and this code is also
>   used on the target/controller side when the peer is the host.
> - Changed argument validation from erroring on sess_key_len < hash_len
>   to sess_key_len != hash_len to be more precise in calling requirements
> 
> created on the nvme-7.1 branch
> this depends on Eric Biggers "nvme-auth use crypto library" patches 
> from <20260302075959.338638-1-ebiggers@kernel.org>
> 
>  drivers/nvme/common/auth.c | 88 ++++++++++++++++++++++++++++++--------
>  drivers/nvme/host/auth.c   | 13 +++---
>  drivers/nvme/target/auth.c | 15 +++---
>  include/linux/nvme-auth.h  |  6 +--
>  4 files changed, 92 insertions(+), 36 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

