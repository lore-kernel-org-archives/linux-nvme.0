Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4166606A31B
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 02:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Jy85SxgH;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I0rKzCI3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=27jXmpkneleSo7kOzJR3MtAQFBQuvy9AzCtgRMVvB5c=; b=Jy85SxgH3Cp6ku0kngGkZhzjP7
	C0nfyMdJKSqjftZg9IqWRXqLpDfa5CpM1CRE0Ez2DRRVJojOj11ZHpW1PW6ixYZY3fMcG6csFec2t
	6HKePiHWs9WSEWwrrGzgcxqGLX9rUNwmYKFEqfVy7aJ4KqLLvyZTJEDNWyVa3HJnfow6N9dVlbSiv
	6J38pZS6l00YmnayK2+sZkkhtG6rmhO4ZExXqOHQoDOrXJBXHLs55L63L72hhD5uEeNDEx2MwdBTN
	mNGud4PUKEim4XHNO1tbxPhDNWWWM+ZUjvctvIGR0hJCxQC+ldIMf2lsjtZxH5gHpzvQd1uGfnfK8
	Cmt3JZAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9O4-0000000B2Qe-3Lx3;
	Fri, 06 Nov 2026 02:09:04 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9O2-0000000B2QJ-3noR
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 02:09:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 50F2160202;
	Fri,  6 Nov 2026 02:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03D51F0089F;
	Fri,  6 Nov 2026 02:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793930942;
	bh=27jXmpkneleSo7kOzJR3MtAQFBQuvy9AzCtgRMVvB5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I0rKzCI3OmQRZype67orby+iW4Sh+QA2sP8jaMZAaWxOghoEb99RlFHkN/J55gfC5
	 6GG6W+nuDmWFGudX0MRr/15hB5kDS+G4n1vrxdqKe+BmGAQxBDvAeKdqzKfhX0fpLp
	 qcdol3A5ngOZ+mQn6U3FmTaB3xZXDUeVR8srfyXkZagv1lWfZXFnjj3MrblACRbdnS
	 dxC/2zygcHe6qFU8rTKdRMu8NdEbN8ki8ZjsPXGnOFuigmuiYU9lGi75M7tTEpuim7
	 RJZJyf0KzEAXiNEUgcdLH4eyUyS19uNIXqVuixc+SHVHuYHkQmB0Se86wCJ4OjJav9
	 rvkfO6aNPJizA==
Message-ID: <sashiko-outbox-200577@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] nvme: reject a reconnect_delay of 0 through sysfs
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261106015842.3534898-2-kanie@linux.alibaba.com>
References: <20261106015842.3534898-1-kanie@linux.alibaba.com>
 <20261106015842.3534898-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 02:09:01 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] nvme: incorrect Fixes tag for nvme_ctrl_reconnect_delay_store() fix
--

commit b125e1489e83edb63c16621248dd345277c89cc1
Author: Guixin Liu <kanie@linux.alibaba.com>

nvme: reject a reconnect_delay of 0 through sysfs

This commit updates nvme_ctrl_reconnect_delay_store() in
drivers/nvme/host/sysfs.c to reject a reconnect_delay value of 0,
preventing a division by zero in nvme_ctrl_loss_tmo_store().

>     nvme: reject a reconnect_delay of 0 through sysfs
>    =20
>     nvme_ctrl_reconnect_delay_store() accepts any value the option parser
>     also accepts, except that it misses the lower bound: writing 0 is
>     rejected by nvmf_parse_options() but not by the sysfs attribute.
>     nvme_ctrl_loss_tmo_store() then divides by opts->reconnect_delay in
>     DIV_ROUND_UP(), so writing 0 followed by any ctrl_loss_tmo update
>     crashes the kernel with a division by zero.
>    =20
>     Reject 0 like the option parser does.
>    =20
>     Fixes: 42a45274c2258 ("nvme-fabrics: Allow ctrl loss timeout configur=
ation")
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

[Severity: Low]
Commit 42a45274c2258 ("nvme-fabrics: Allow ctrl loss timeout configuration")
only added ctrl_loss_tmo option parsing in nvmf_parse_options() in
drivers/nvme/host/fabrics.c, where a reconnect_delay <=3D 0 was already
rejected.

The sysfs store handlers nvme_ctrl_reconnect_delay_store() and
nvme_ctrl_loss_tmo_store() (later moved to drivers/nvme/host/sysfs.c in
commit 942e21c042e6) were introduced in commit 764075fdcb2f ("nvme: expose
reconnect_delay and ctrl_loss_tmo via sysfs").

Should the Fixes tag reference that commit instead:

  Fixes: 764075fdcb2f ("nvme: expose reconnect_delay and ctrl_loss_tmo via =
sysfs")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106015842.3534=
898-1-kanie@linux.alibaba.com?part=3D1

