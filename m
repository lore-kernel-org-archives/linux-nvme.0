Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5553E606A321
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FlT6ahP/;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nnZRt9Hy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=D4fw1hE5QtFZHGtmAjpd1Tbv4npGzMwBWOPniq9dSOY=; b=FlT6ahP/uWjVwImeW7MTYv6x1M
	2u1DeG+zP+HSHJ+nsJotB4v2DQsPzbr7Zo4v3Sql8eHu1vFuO8sGbzJB82vC1wGrL5zxy9feXEU7m
	fVw+V1W5LJBedjx6MAQ/jdlNfbFhiVjOTy6U7iZt35lallpI9MTsnYi/0jkvt5oCWJuZQBGGbOAR0
	qfG1vtOe6y7Q+Yje6zMrOSnEcnQr97sKCFwCfBjhfGaTCXp8ue0IY59w/K7zI6z33cU+Mxa0hy3AI
	EQgKy9gFVgem7UeoDm0EHutmuGBdSAnh4tSt+yDGWqvylAu/+HD3GPvSVZhpsEq/sNRHdpO8Wbmbw
	RdJA6N8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWE8Z-0000000ABbo-1dUj;
	Wed, 25 Nov 2026 14:38:19 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWE8X-0000000ABbh-1Au4
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 14:38:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6611561B72;
	Wed, 25 Nov 2026 14:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942B81F000CA;
	Wed, 25 Nov 2026 14:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795617496;
	bh=D4fw1hE5QtFZHGtmAjpd1Tbv4npGzMwBWOPniq9dSOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nnZRt9Hyav2IMZDbAVkPUxXOsDg1xnWtD//zCUD8WA1QQXCS2+iwA3I86/2Wnhc9Z
	 elErjpjVeE9NnVYhRSr567d5OQIeBGgtkDKzPzNrKMBRbuxnwfa9QsVzBnHITJjKRG
	 FJDBFs5+P5PdsT3C8H+V6gI95v3d6JWko6TpaZrs=
Date: Wed, 25 Nov 2026 14:48:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bin Luo <luob87709@gmail.com>
Cc: linux-nvme@lists.infradead.org, nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com
Subject: Re: [PATCH] nvmet-fc: hold queue reference while freeing FCP IOD
Message-ID: <2026112534-customer-strep-466e@gregkh>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
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

That's not a valid tag.

And no empty line between Fixes: and your signed-off-by.

thanks,

greg k-h

