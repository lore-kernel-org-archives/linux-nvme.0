Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE16F606A333
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=T+SRb+/J;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H3upLpGT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8bvMUN4Wk0BgGgF1RgcQrwazIY2aEPvQvSEkNPHOui0=; b=T+SRb+/JhD5sKikWzEo076qryz
	JhIAEetfIoVtK0I+rafxg/RlKV2wTgu7J0iw2MqaADc2bdKZZ/THUdoUwl4LOrr95jPn0v2R/Ef+G
	u1QtqZ8eDoCPKSc5sSkJTxLQjJwHAfOGlp/3kH2OaVNYxiwfMet8wTftx+R+K5fySfxHGoN0IRGZF
	4N/kjFbll0MmpM5bn4kC7cfIeoKhOO/6oiPJBBiw3V3OwQ5pn6qfSP/zli6MKOU9vuWhNMcxBZgmO
	CWBzRtsVsQOfNQAmim/5fPBweJU7SRQh5hPZBazC3CxVU63Yu+kNCjzWs3LwvqJzdTiefwv0O9wQz
	ufXzDC4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdxD-00000005zoC-0Bxm;
	Wed, 04 Nov 2026 16:35:15 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdxC-00000005zo3-12Pi
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 16:35:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8B2CB43E64;
	Wed,  4 Nov 2026 16:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD641F00919;
	Wed,  4 Nov 2026 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793810113;
	bh=8bvMUN4Wk0BgGgF1RgcQrwazIY2aEPvQvSEkNPHOui0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H3upLpGTA18T3EdPjgIqGURFX6ukYjVdk4P/01EFshF+ivtLq6qY+nk8M3sk4aLzX
	 RwE0YkeINt8rYueavFNh4X2mLUVn8+ivmbEw/uJO9w/YzViENqud/DUFDZeR+K7R1P
	 wkpSKRc2AkIPhOMpRoRXp52AtCwpEAh84KRCtdtv57fqIdLVNVX5M9H8Nu0oc48qFs
	 3ausvv+JRE2zdKjXBOzLhOoTiZLf8xFgz7PII8xS4EztgpfilaJPScx7V7z+Sd3wC4
	 23/b4UnjLbBkyZ0bDViGXjRdJMy6NPkJZcxKu7rp4pP9NhfSsN2XEDUwwOCPvNlND7
	 2QVWrBW8ijxbQ==
Date: Wed, 4 Nov 2026 09:35:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvmet: drop the extra RCU grace period in
 nvmet_ns_disable()
Message-ID: <autev0xlCzBMz7SC@kbusch-mbp>
References: <20261104-bug-nvmet-ns-disable-rcu-v2-1-b158a59318ad@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-bug-nvmet-ns-disable-rcu-v2-1-b158a59318ad@gmail.com>
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

On Wed, Nov 04, 2026 at 01:31:28AM -0500, Qiliang Yuan wrote:
> nvmet_ns_disable() kills the namespace's percpu ref, waits in
> synchronize_rcu() for anyone looking the namespace up under
> rcu_read_lock(), and then waits for the ref to drop to zero.
> 
> Killing a percpu ref that is still in percpu mode, as the namespace
> ref always is until then, switches it to atomic mode from an RCU
> callback, so the ref can't drop to zero before a grace period has
> passed since the kill. synchronize_rcu() thus adds a second grace
> period in a row, about 4 ms here, and disabling the namespaces of a
> subsystem one by one takes about 9 ms each.
> 
> Drop synchronize_rcu() and rely on the wait for the ref to cover the
> RCU readers as well.

Thanks, applied to nvme-7.4.

