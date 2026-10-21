Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC82F606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ALANzXlg;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ntcLL67D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dQkMQtrYlohUdfpg8lbIStksMCRKnqn5TqyhsBWs7Ug=; b=ALANzXlgvgyJaLmcuz4N3Qv3Pn
	YwWQE48cZejb+DBx9j0PfWe4bUGr7fSFEFNPThcHPXR2og202a3LIFJWFF0nkBDKyeTW2HdW3U+Ks
	rhvXfAUyT8dmFkcDn/8WuPkmmQBUFThghgZEecjaFjYcMBCbPv1GDx1O3uEyDQIAQV9VIGibnmbKB
	/OmcBLG+9vEFE3/S5x0R37sFqpHJpx5hVlXFvfS3s59SounpGe90UfJoWAYBn02JrRnQof3Xj109H
	UZ5k9WQGxGtmkR13N3mPZkT+rDhzKA1WpivrCrQVpItYid6aFOk9Yxl52OA5hd5HKm5x/hgalSt8S
	lQ2sXZ9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJdPZ-0000000CsZV-26ll;
	Wed, 21 Oct 2026 20:59:49 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJdPY-0000000CsZA-38on
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 20:59:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5A60143CAE;
	Wed, 21 Oct 2026 20:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF0D1F000C1;
	Wed, 21 Oct 2026 20:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792616388;
	bh=dQkMQtrYlohUdfpg8lbIStksMCRKnqn5TqyhsBWs7Ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ntcLL67DA3ZiXOfMJVyz8TH5b6lcoTMWYE4+WyyBxQODcU6/u+/n9YoxsMJLl9Sic
	 P/A8NuUUjjYG0tibijD1UX11MX7yoxu/pN8//Vk9JUehodQo6EdNs9+3VtISmctStf
	 WB6r0152ZKLHQEB25IaLMvqQo99zyjkgjcEGJPvS1C64OQKj77EGkavJXIdzFKMtZA
	 KQi01Fw7QUTml6hz2US14hj4zII4jPC0zXTj62ITNVEwR8idKDiuxlbEcXRIQ2enVT
	 lcNFA4mDR1IWWXuE99sNtnL54YNRLl1fi3Q+mpUiJ/oONoWbjJWtv9u62ERVtjlJip
	 Za6TUygbkIINA==
Date: Wed, 21 Oct 2026 14:59:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yu Zhang <yuz08559@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] nvmet: take subsys->lock while force-reconnecting in
 nvmet_subsys_attr_qid_max_store()
Message-ID: <atknwrTGQ6GqNksl@kbusch-mbp>
References: <20261014054727.53183-1-yuz08559@gmail.com>
 <20261020025047.88297-1-yuz08559@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020025047.88297-1-yuz08559@gmail.com>
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 12:50:47PM +1000, Yu Zhang wrote:
> nvmet_subsys_attr_qid_max_store() sets subsys->max_qid and then walks
> subsys->ctrls to force every controller to reconnect, but it holds only
> nvmet_config_sem (for write).  subsys->ctrls is protected by subsys->lock:
> nvmet_alloc_ctrl() adds an entry under subsys->lock, and nvmet_ctrl_free()
> removes it under subsys->lock with list_del() + kfree() (not kfree_rcu).
> The free path takes no nvmet_config_sem, so the two locks are independent.
> 
> A controller teardown (host disconnect, keep-alive timeout or fatal error
> -> nvmet_sq_destroy() -> nvmet_ctrl_put() -> nvmet_ctrl_free()) can
> therefore list_del() an entry while qid_max_store() is iterating the list,
> corrupting the walk.

Thanks, applied to nvme-7.4.

