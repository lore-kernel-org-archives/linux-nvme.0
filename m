Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C536606A338
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Bq/ZuDvl;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VUVqsqMW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Iwg1Zlh6Ve+tXDUlSQA2Op+Qd/hTm/8nQjHs3UTZzpg=; b=Bq/ZuDvlhE+dBjaBK64H8g5yDy
	2SfMY2zmL2aJAWJbK1hqtRYwUXZd4tUQqNBcn64ys4JZDOXjMoZc3DhOVu6U8qVuMEK8Ao3+NPMmT
	IurxuThFkm7cqrvNHJfRr/TE7kXvW1CKHzcU2Y5PEFaV/63gugxnifRdklF/6oRIjij586xGgBf5s
	3zlShho/6qkgeDl6W1Ji3vJQNk6OuL9KwadFW9jzERbF2mDGRheR5lAFRFkr9iq4/QM3JjO2+x8Ux
	ie8GuCAXb5EHxmn8LgJ3RkuqH+FlhUJtG9pLZTLJeEv4MJt9thYvIlOAzMgtosI+fr4LUvCCaZP7T
	HVy23BXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGYx-00000002zJQ-0cun;
	Tue, 03 Nov 2026 15:36:39 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGYu-00000002zJ5-3uga
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 15:36:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AE87D4053D;
	Tue,  3 Nov 2026 15:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493AC1F000C1;
	Tue,  3 Nov 2026 15:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793720196;
	bh=Iwg1Zlh6Ve+tXDUlSQA2Op+Qd/hTm/8nQjHs3UTZzpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VUVqsqMWwtEaBtBHu8g3D4rR+IxkprPQb56eYTVLmNu4NI9VXid040ldUrjpgwKkc
	 /661Zbwau62FdS8ErVGQKICxh1txlpOJ4Dke/obA4cW3cBNzICAHmZN3Qf7YnTVkxG
	 0+wXbPsIDVCdnKcznqHOLrQtqzORxrRhDTDh8V1BV1HEvR7J7UOEUenGeHZd420d6N
	 B4S1pZ3GkZV6NI+0oApZyBF3EDL63N/yZdCwiEaDTyW5uSH8qGfZt4zN55Oz6gUy+d
	 mRuxA5bLF1Bry7DM9WEmb8gA3J/frx8mDCX5/wRAxrLm0Mj9EebuI+2MAfxcDxak02
	 3bnP/I+9iQgag==
Date: Tue, 3 Nov 2026 08:36:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: =?iso-8859-1?B?Suly6W15?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvmet-auth: reject incomplete DHCHAP messages
Message-ID: <aun_gknBOPBjDbGu@kbusch-mbp>
References: <20261102132419.2306396-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261102132419.2306396-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

On Mon, Nov 02, 2026 at 01:24:19PM +0000, Jérémy Jean wrote:
> Commit c9359401036e ("nvmet-auth: reject undersized AUTH_SEND
> payloads") only ensures that AUTH_SEND has auth_type and auth_id
> before nvmet_execute_auth_send() starts parsing the payload, but the
> DHCHAP path reads t_id before it verifies message lengths. A two-byte
> DHCHAP NEGOTIATE payload can therefore still trigger an OOB read that
> KASAN reports as:
> 
>   BUG: KASAN: slab-out-of-bounds in nvmet_execute_auth_send
>   Read of size 2 at addr ffff8880030d8364
> 
> Require the payload to cover the minimum DHCHAP message length
> before parsing it.

Thanks, applied to nvme-7.4.

