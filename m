Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739F1F45A0A
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2026 20:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hj/6kZv4cvoQbf5Mx+JVH6QMFwdCRNlWzx2glCpqtqo=; b=zxt24aJhx6fwTSK78e7M+ctNdQ
	JiUTxv6FiS1rVGKEWWKIxlAcm+b+wGxFT/c27uahRsb13LdYM7+A46kFEt9gCcPa1NmxjwV+XOPFN
	Vo6FI/I+jtTJqINlU1NRdMsoW0bFRaqFX+GVmf1uC6XQy4/aRUZDEAvbVd8qfxyjzttdJPy8RvDyG
	UMqx74Guep5EhkvFCAPmIp0RiXvDQZmawfn/81fogA5EjiHL/QUndxfjUhUFqjW3+UbiKoco65IIx
	CfBCQi4XJJ705ksbptRG3VfMepWHdBq0M/43AS7Cu21DPQiSb7YDDB3fVis6ximxQM+6D5lwA8qfM
	EGZOPC1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBIPw-0000000Clg7-3SWF;
	Fri, 10 Apr 2026 20:25:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBIPt-0000000Clfg-0gEe
	for linux-nvme@lists.infradead.org;
	Fri, 10 Apr 2026 20:25:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775852722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hj/6kZv4cvoQbf5Mx+JVH6QMFwdCRNlWzx2glCpqtqo=;
	b=goo1PiZe0KVI+6eTAEZso/DLXmEf9zAxSxkOJcw/WZuAOlhIkqX5yZAZwEqXZqgX81bVJY
	NXkh1A48HH2No3nHlkbbvsFMibKl8DqNWemUG7C1IssYCXsKgb/U8AaFVt6YFeR7fR8R8I
	0tvr4yk6GOxrlv2jZVo3LnaJRS1wXdk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-W1Mvb6cMOo-p56SOivuO6w-1; Fri,
 10 Apr 2026 16:25:15 -0400
X-MC-Unique: W1Mvb6cMOo-p56SOivuO6w-1
X-Mimecast-MFC-AGG-ID: W1Mvb6cMOo-p56SOivuO6w_1775852714
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76E6B19560B2;
	Fri, 10 Apr 2026 20:25:13 +0000 (UTC)
Received: from cleech-thinkpadt14sgen2i.rmtusor.csb (unknown [10.2.16.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8CA2819560AB;
	Fri, 10 Apr 2026 20:25:10 +0000 (UTC)
Date: Fri, 10 Apr 2026 13:25:09 -0700
From: Chris Leech <cleech@redhat.com>
To: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2] nvme-auth: Hash DH shared secret to create session key
Message-ID: <20260410-726e26301894f650e93e3eac@redhat.com>
References: <20260311012116.2504291-1-cleech@redhat.com>
 <20260311231643.2672061-1-cleech@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20260311231643.2672061-1-cleech@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kSAotnZG0xQ2-6RbOmbDwgGd085Q1my5LG9e8gKYvAI_1775852714
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260410_132525_271858_352416F6 
X-CRM114-Status: GOOD (  22.34  )
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

Bump, can we consider merging this?

Thanks,
- Chris

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


