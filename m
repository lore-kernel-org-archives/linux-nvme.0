Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D7060A262E
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nqTMqmDp;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLfLLM3v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=W7jvFEheGOj4Xuu1UcXrw24Qefpih5MBmqYKpSsX/nE=; b=nqTMqmDpq2eRdFLwUhbpcQkL1J
	Yi3CzcdqEkiILFwqoC1db1R3ZFWKW1i/1r1DCAr+aZbGlS9QTHoNO30PaKtFJ99bDFWqYAmZgI9L+
	9kdxW2EeugY13t1VqX5ggL0fbakqEek5nJEQohA72zNOIfc4TJ4GAbf2vl34NSNvvdb/WAu2It9vh
	UIoU+YuyhUcug0hwonF0POiYgUtj2Ulq1jClsy5RA2w/I7IhfTjZ11osoQeOONgd/yV9Eh8Dw48Ot
	cjf2q6eprjPSCeoRUXAQxuxeBPOTUfF4RIT1L1EfCcB75vRppV/Iq2urfKYEj0S8zJaWj9VLsBOj6
	BinWZIFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLjfQ-00000005Ikt-2NgD;
	Tue, 27 Oct 2026 16:04:52 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLjfP-00000005IkE-3aVR
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 16:04:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3ECFB439CE;
	Tue, 27 Oct 2026 16:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F151F031E1;
	Tue, 27 Oct 2026 16:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793117091;
	bh=W7jvFEheGOj4Xuu1UcXrw24Qefpih5MBmqYKpSsX/nE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CLfLLM3vhKpvaWfy2FTOk/U1y/xOL97lR72BSxQdSH2a2RQj6/13N6iwNRc+5UvrM
	 K06tkuvXv511KSTdNWUngI5DrPbJn0y13jOTgf09BUFlQKwYgitx/5fmfaZyC0yZp3
	 /kd4d5DG8FvmUxrkM8WpAhthzynjQSxqTPWlCKrFnzYcc+5AVjXFrYWSqMVOKckrzf
	 kgRcYBGaZzW4XhmZX65nXHN+ZA8DbU4sRKMIDp1+n42NlV731d1ORjQnWujjLDjPFC
	 oBtCW1rL8nKA5aLJYtxwf7jydVvmToJ3plDikac8qhmBl1xSo355wEjrFb3rClY9zB
	 KGlWAU78BYIcQ==
Date: Tue, 27 Oct 2026 10:04:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, hare@kernel.org, sgogte@purestorage.com,
	wagi@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix request PDU size when header digest is
 enabled
Message-ID: <auDLmzKWOZNBNpOR@kbusch-mbp>
References: <20261026184621.29276-1-christian.aurichzm@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026184621.29276-1-christian.aurichzm@gmail.com>
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 03:46:21PM -0300, Christian Aurich Zanettini Martins wrote:
> @@ -566,7 +566,7 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
>  	struct nvme_tcp_cmd_pdu *pdu;
>  	int queue_idx = (set == &ctrl->tag_set) ? hctx_idx + 1 : 0;
>  	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
> -	u8 hdgst = nvme_tcp_hdgst_len(queue);
> +	u8 hdgst = ctrl->ctrl.opts->hdr_digest ? NVME_TCP_DIGEST_LENGTH : 0;

I think everything this function needs should be initialized prior to
this function being called.

>  	mutex_lock(&queue->pf_cache_lock);

See where mutex_init is called for this queue's pf_cache_lock. Can you
move the queue's hdr_digest setting to that location instead?

