Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14D9606A335
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 22:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sGfpMT1u;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+7ylXEW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=W/pRLNrsz15lpOWQtGvs2p5w7AEgYY+eAZ+/hxAp9uM=; b=sGfpMT1uGz8crGEUqWcrkVcCkT
	illUih7nZ1+r0yxfWw2x8Y25LuKdSby9FQL9kY7Gp+tXExMbb6D+DBnYHZy66FIwM6bIEyyvgxQvY
	VpythZI3XSkN+hEe62JTC29PPTVN2EqEwZVM7hjubU2a7ihKKbBGcxUKHY5Q0uCsyyBRvI34SSPo4
	SbvGiBlJt3I/KSgnaxR9SRm6Ah6uoifruK0jw3Ki0swzLT+8MoWf4g+DDJ1jMANIwuZj4m1ZTjIll
	y1pOCmIxJdcMNOd+rgAoJ2E9nnY9LGerhvBkfcMZ6kqY0uCICoo57BgDmO2gvYNAn7R50bQhwGqYi
	vi/FsTjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLq39-00000005suF-3oIS;
	Tue, 27 Oct 2026 22:53:47 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLq38-00000005su7-3EXR
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 22:53:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 25C7A409FF;
	Tue, 27 Oct 2026 22:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C231F01825;
	Tue, 27 Oct 2026 22:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793141626;
	bh=W/pRLNrsz15lpOWQtGvs2p5w7AEgYY+eAZ+/hxAp9uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g+7ylXEWWUmwzrvainHKo+L+66ScH10XkZyFS6XA+4xsuTAfanMQFQin9PHZ7CuRj
	 aGrH+GjmJT8Rw1zlLlz6t8dfPYT0c5MMJt7cVO7oAjBBjMMroYYMFOnVG7Z4CRPT9k
	 6Fc+9y7GzjgZPjgP9uxGyqIIVCEsS9HQPftqywNiXpyp3yQTgn/94ai/J5h+uCAJgZ
	 OheDHKio1aRvyO+4/xlsvzeEJFql1ovUlVE6K8AwLR/4gWC5Zw5orfxZI01LfbS1oZ
	 KDlvVLtZAKkKrH6j261qkmL7hdxRoRK2B1AheNBlw5cvZUPv5XlQXQ84+5Kee+TfgJ
	 4smF1OwjI/b8g==
Date: Tue, 27 Oct 2026 16:53:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: martin.nvme.dev@gmail.com
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Martin Belanger <martin.belanger@dell.com>
Subject: Re: [PATCH v2 0/2] nvme-tcp: handle TLS control records at connect
 and on receive errors
Message-ID: <auEreAhSYCdGCWvt@kbusch-mbp>
References: <20261027-nvme-tcp-ctrlrec-fixes-v2-0-9656395ebcf2@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-nvme-tcp-ctrlrec-fixes-v2-0-9656395ebcf2@gmail.com>
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

On Tue, Oct 27, 2026 at 06:38:51AM -0400, Martin Belanger via B4 Relay wrote:
> A TLS 1.3 peer can send records that carry no application data, for
> example a NewSessionTicket right after the handshake. nvme-tcp does not
> handle them correctly. This series fixes two cases.
> 
> Patch 1: when read_sock() returns an error, nvme-tcp does not start
> error recovery. The queue stops receiving until a command times out.
> With a NewSessionTicket on a live queue, I/O stalls until the I/O
> timeout (30 seconds by default). With this patch, recovery starts at
> once. This also applies to plain TCP.
> 
> Patch 2: a NewSessionTicket that arrives before the ICResp fails the
> connection with "failed to receive icresp, error -104". A target that
> sends a ticket at once, such as an OpenSSL-based target, cannot be
> reached. With this patch, the ticket is discarded and the connection
> succeeds. An alert in place of the ICResp is now reported with its code,
> instead of as error -104.
> 
> These patches replace patch 1/2 of Hannes's "nvme,tls: minimal handling
> for TLS records":
> https://lore.kernel.org/all/20260922133708.84522-1-hare@kernel.org/

Thanks, applied to nvme-7.4.

