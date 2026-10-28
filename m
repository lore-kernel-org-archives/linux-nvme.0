Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEC4606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3AvNIs0y;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZAO7Grzg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=U88fBYEUYN5OT/6TCcASr7FaH7yWjMN1mU3NJNh3hMs=; b=3AvNIs0ysKKOWCykcKL+qVn+nP
	Pe/WCxyDn7FF7ybutbMrW+zjeAVRKsQxfUo+zJzpgxK2aMPT2Na75OvlgtwmPQHjq5U3qFiFP7/hp
	0hpie43Ca17SLD+KX//1pjfqv6ySCgeaaGLG5pGD/GK5Aux+k6Je8KuTQdqFKbDLUmYyO4m5tKQo2
	EqHZIfw/iEEYovefRzf1GLVnyu3dvzbcwAHewAdqTgz1f+doZx/7ohtfmjeOBDYuEu82inZ7zIyeR
	TzTvtBG0i3EN7thbZu0ERo1d70uuJktA/Z2aGAAeg+95zTLo2xaP1G94sVi7qOO7Cgxp7OGfrwOip
	G9fR8EdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5eD-00000007P5T-1E4w;
	Wed, 28 Oct 2026 15:33:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5eB-00000007P4w-2zBQ
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 15:33:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 77E7B4379B;
	Wed, 28 Oct 2026 15:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64C31F01825;
	Wed, 28 Oct 2026 15:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793201583;
	bh=U88fBYEUYN5OT/6TCcASr7FaH7yWjMN1mU3NJNh3hMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZAO7GrzgGnJ8o4pOAB27C6V+0eq5cOgABgjosrfUGqN4+UWbdqpxIU2+7BxV0DPaQ
	 WG755PWCKcKHkcG/VoB6TmfBaWqyZCDDM5TlcN1L1gAtCcbWc8EPdvhAJ6rkEZY+JF
	 TelRh1mFJaORQqhSnFFZAavolnRBZ2KFcsOxX3h3Z6uwhQ6XArrM6ejJvDELIbjnok
	 VO4EF+hs8Tifo0VLqMZGiikDKt6BeJc5xHgWZn78BrjbMRU45eJ3Ep5l4sjqXKKQya
	 AejfMm4+MUMP06f9NU0iTRaruZhw3i2AucTWLpJbMQiOuzWsMh6doZ+kklE0sM0EH5
	 DBrsBHvEfZ+cw==
Date: Wed, 28 Oct 2026 09:33:01 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yingjie Wang <1075151112@qq.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, hare@suse.de, corbet@lwn.net,
	skhan@linuxfoundation.org, rdunlap@infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] nvme-tcp: validate TLS handshake timeout
 parameters
Message-ID: <auIVrTJVjWk8rvNc@kbusch-mbp>
References: <tencent_8B4F08A2DD4BB093ED7FAECFFD20272B3C07@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_8B4F08A2DD4BB093ED7FAECFFD20272B3C07@qq.com>
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

On Wed, Oct 28, 2026 at 07:57:18PM +0800, Yingjie Wang wrote:
> The NVMe/TCP host and target expose writable tls_handshake_timeout
> parameters as signed integers. Both paths multiply the value by
> MSEC_PER_SEC and HZ before converting the results to unsigned timeout
> types. Large positive and negative values can therefore give the
> handshake agent and the kernel different, unintended timeouts.
> 
> On an HZ=1000 kernel, setting the parameter to 2147484 overflows both
> multiplications. On the target, an accepted pending request can queue the
> timeout work on the next timer-wheel advance while the handshake agent
> was given about 24.9 days. On the host, schedule_timeout() can report a
> wrong timeout value with a stack dump and fail the handshake immediately.
> 
> Make each parameter unsigned and reject values that do not fit both the
> handshake agent's millisecond field and a safe jiffies delay. Read the
> parameter once per handshake so the two timeout mechanisms use the same
> value. Also keep the host completion-wait result in a long: a successful
> wait can return more than INT_MAX remaining jiffies for an accepted
> timeout.

Thanks, applied to nvme-7.4.

