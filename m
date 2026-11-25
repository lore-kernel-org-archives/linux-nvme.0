Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A86D606A326
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=n4AZlb/3;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YwavEK9r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wAwmF4vyP9+f6V4h1RkZH2EjJPlSolKtz71WJTRBP+0=; b=n4AZlb/3LR5VFVVF17Hgx6Mp9J
	/GmWKEsVNhplK/Ps/JGOWlbLs+IJk9rLoZVGbYrhJUjPXRYjvFV+0X0BP4BtZAFmlGYp67I/FGsa4
	Tm52KCFci0FkYEgXwGT4/hDITBI3KpZ7TfnG41WexX57gQLWivW5poEkmzrV3PRHV/IRHi74c7lw2
	YGfMaQzrNqVTRgBdU6xUprLlH9ngGMKgmQB2c68GXMhyWIPqgBqn27epFrv9msYGJkWyIN2WdvOUY
	Fs+LyZm2vsE8L8Dtb9+TVfBQuvDnaOABq73+ZYNlnLZppjo8HZDeS1D2XzndcOT9ljLjrDm5RFy35
	LcHeZXLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWE8c-0000000ABco-2fyx;
	Wed, 25 Nov 2026 14:38:22 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWE8a-0000000ABbx-2bHG
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 14:38:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B1A3A61FDC;
	Wed, 25 Nov 2026 14:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686851F000CA;
	Wed, 25 Nov 2026 14:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795617498;
	bh=wAwmF4vyP9+f6V4h1RkZH2EjJPlSolKtz71WJTRBP+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YwavEK9r24DollA5wO92dyyEnnA7EJoJxPVm2KrqfkTYoCufp7Q22PJrid9VNZvUs
	 kixoL0cMBpfWaKiJltXOXgTkgSPpymnAWVyMwq41tHlyqKmmw+XhA48wFAt9w13hI3
	 Gb9GoYWG32zqQlcih6V6e8ypFU9eWotLHTG6+I1g=
Date: Wed, 25 Nov 2026 14:50:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bin Luo <luob87709@gmail.com>
Cc: linux-nvme@lists.infradead.org, nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com
Subject: Re: [PATCH] nvmet-fc: hold queue reference while freeing FCP IOD
Message-ID: <2026112504-hassle-disengage-47fa@gregkh>
References: <20261125115444.783-1-luob87709@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125115444.783-1-luob87709@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 07:54:44PM +0800, Bin Luo wrote:
> nvmet_fc_free_fcp_iod() drops the FOD's lookup reference before it locks
> queue->qlock and accesses the queue lists. Association teardown may already
> have dropped the owner reference, so this put can free the queue before
> completion accesses it.
> 
> Take a temporary queue reference before dropping the FOD reference. Hold it
> through queue/list accesses and deferred-work submission.
> Release it on both FOD-return and FOD-reuse paths. The deferred request's
> lookup reference stays with the recycled FOD.
> 
> Fixes: 619c62dcc62b ("nvmet-fc: correct ref counting error when deferred rcv used")
> 
> Tested: v7.4-rc1 KASAN_GENERIC x86_64 QEMU with a test-only owner-reference
> injection. Unfixed baseline reports UAF; both patched runs have no KASAN.
> Signed-off-by: Bin Luo <luob87709@gmail.com>
> ---
>  drivers/nvme/target/fc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 5d6c1c7..0b3a448 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -733,6 +733,9 @@ nvmet_fc_free_fcp_iod(struct nvmet_fc_tgt_queue *queue,
>  
>  	tgtport->ops->fcp_req_release(&tgtport->fc_target_port, fcpreq);
>  
> +	/* Hold queue across the FOD reference put and queue/list accesses. */
> +	kref_get(&queue->ref);

This feels wrong, what is going to drop this "early"?  Why do you have 2
references now?  And there's no real function to call for this to match
up with nvmet_fc_tgt_q_put()?

Shouldn't you just fix the logic to NOT touch the queue after it could
have been dropped instead?

thanks,

greg k-h

