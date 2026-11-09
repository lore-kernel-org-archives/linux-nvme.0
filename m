Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B2F60A2600
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=k81LwTJn;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZqAl6R7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=m5LEnitf0NsC5/6QeyQtKq334rR4116vS1F0Rg1A9Fc=; b=k81LwTJnxzP9iOvB06XdsCdscw
	At0vE9pWdPleG1bdh4DEL6k0YUX0/Z5/J9i3yYPhh4gs5rnmHvv5Lf0o1i7Bjg7uNYk6ClgDh9+Vq
	wwdimkipDmFfWYONdbywjO0CIYdUPxNv7oDli3SylN9bz9ylAMQDwJ9aPEN4PcVZEw2RhJzX9Xm54
	7Ul7d2UqvNhKb/rEN4gBOPRcOAkDzxo7QtDxrYRRXuhP3Y/hDQ7LWKY7WlNF04Qiz6yhmt9QMVOGZ
	EPPgRpHOZIaCTUPeX8yulfUO9GMxuzHM+RcsF38JqyoDAMvRi56jcI5q4DDz2Hw6xKdqe3AfwuBKD
	KcxlV8Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQVlu-00000001d2o-0nJE;
	Mon, 09 Nov 2026 20:15:18 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQVlp-00000001d25-3HeU
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 20:15:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F10DE61CF2;
	Mon,  9 Nov 2026 20:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C021F008A1;
	Mon,  9 Nov 2026 20:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794255312;
	bh=m5LEnitf0NsC5/6QeyQtKq334rR4116vS1F0Rg1A9Fc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JZqAl6R79VDXGf9UEa9vZmBFCZTNB8A0zjI+biAjse3R305KJMu9lTvZODNTHPj+u
	 uFCSFBlb2kQ5NG4GuMNCadtCO2lLyRx78Y06tLGVowFWxw1ciinDhHur4YExWLaqL5
	 nHIR/4tHurE+RU2uxK3SghCylVukVi0Z85MVHLHedoyhuLFceEMMickueh/CvQjBoO
	 1UDiUSYwJuY+M/Q/bb7txq96o4pcT7Vo5Lb1GNRdNTtJ8SbrGpTMMmOpPtv0yXrNWT
	 +9jMtg9mB9C9UtrUmrWhMH6wc9Ma9C3nd74g1OnKJve5ODrqTPLQeACB592UTEtsfj
	 EoB4IwD5pMGIg==
Message-ID: <sashiko-outbox-205559@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/23] nvmet: fix nvmet_ns::bdev access using
 nvmet_subsys::lock
To: "Nilay Shroff" <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261109033102.982191-27-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
 <20261109033102.982191-27-nilay@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 20:15:12 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] nvmet: use-after-free in nvmet_for_each_enabled_ns() [1]
--

commit c1fe0968cd1483b32634bdd9e21897a686ef88f2
Author: Nilay Shroff <nilay@linux.ibm.com>

nvmet: fix nvmet_ns::bdev access using nvmet_subsys::lock

This commit acquires ctrl->subsys->lock in nvmet_get_smart_log_all() while
iterating over enabled namespaces and reading ns->bdev statistics, and adds
an __assume_ctx_lock() annotation for the clang context analyzer.

> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
> index 2d4e21b3ee7d1..517f8cc784734 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -289,7 +289,15 @@ static u16 nvmet_get_smart_log_all(struct nvmet_req =
*req,
>  	unsigned long idx;
> =20
>  	ctrl =3D req->sq->ctrl;
> +	mutex_lock(&ctrl->subsys->lock);
>  	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {

[Severity: Critical]
This problem wasn't introduced by this patch, but can the remaining
unlocked nvmet_for_each_enabled_ns() loops [1] in
nvmet_format_ana_group(), nvmet_execute_identify_endgrp_list(),
nvmet_execute_identify_nslist(), and nvmet_set_feat_resv_notif_mask()
still hit a use-after-free on ns when racing with namespace removal?

nvmet_for_each_enabled_ns() expands to xa_for_each_marked(), which drops
rcu_read_lock() before yielding each entry to the caller:

drivers/nvme/target/admin-cmd.c:nvmet_execute_identify_nslist() {
    ...
	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
		if (ns->nsid <=3D min_nsid)
			continue;
    ...
}

Because those callers hold neither subsys->lock nor rcu_read_lock() across
the loop body, synchronize_rcu() in nvmet_ns_disable() does not wait for
them before nvmet_ns_free() frees ns:

CPU0                                  CPU1
nvmet_execute_identify_nslist()
  nvmet_for_each_enabled_ns()
    xa_for_each_marked()
      // drops rcu_read_lock()
                                      nvmet_ns_free()
                                        nvmet_ns_disable()
                                          synchronize_rcu()
                                        kfree(ns)
    if (ns->nsid <=3D min_nsid)  <-- use-after-free

Holding rcu_read_lock() (or ctrl->subsys->lock) around those loops would
prevent ns from being freed mid-iteration.

[1] https://sashiko.dev/#/bug/linux-dd6d8d28-fcd8-41b8-9469-54cca852794f

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109033102.9821=
91-25-nilay@linux.ibm.com?part=3D2

