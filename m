Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0693E606A33E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 02:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LfONwfbB;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+/CMHYl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GNtMBA9P/YuD0CwM1enL+gQGAVdvi0+9oj8sCTa6uRI=; b=LfONwfbBb9RCry
	BK8U1ux95wqaQCjBssCQGhzZ5EB1D6zfUNK74vUhOMgmz7IiKYlR1aSgTr5yegPJmaBJCzci2/kne
	gkLlx10YjRReiZlGW9uCu7AfABFSoiJoDSbCr5YBi3+xhX0ymIjngyUNbfmxzNOxKfly4SByWFA/7
	CADRQDn+/xzATT2fx4Ao5b0SNZMXo4P2qEb2wv/2IBz4UuxmGAcOp+cPvCituDzlwbk3xB6UmF9Pz
	FINnJS5s8a1iOx8xgYvSISiAUrAPdKDgXK9pBgxfL2E4wflIIM5jtGzFPGyyXQ6aNXgpsKQQ6d/yc
	FsWvas4cgZI1ei8lKj9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRh6l-0000000BVA8-15im;
	Fri, 13 Nov 2026 02:33:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRh6j-0000000BV9S-0ZWU
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 02:33:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B6C7741878;
	Fri, 13 Nov 2026 02:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932CC1F000C5;
	Fri, 13 Nov 2026 02:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537220;
	bh=GNtMBA9P/YuD0CwM1enL+gQGAVdvi0+9oj8sCTa6uRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S+/CMHYleKCm0sYUi3Bz5giZ6mJMsTxdM5y8vgEZvOLzLx01wmAX1LXj7XZmsUIE7
	 ph9zXsCfpTXrPlkWM3zdcNuLb5mB3tO2yccNQeW43hcfHn2IjoALFOJUgIC/hdibKH
	 hq7P9cR+Q9Voolq1nvbB1aR8Vu8+R9t6y9rkynyXAbeSBKnoy1jQFchafY2Xf3Tatc
	 luGhxNb2zdDX3iuVt/xF07y5QYZoDH4GMfw43NBaWmjt9k6wRy0n6l1vEPcTZquOPU
	 KjbyrKVX6mEJoNHN3hpEE3Yg1bvIcO7O2x3I8BM8bJDV72QS4dFoy06YHoxKuCnDA3
	 utzmY6VaCQv6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	Martin Belanger <martin.nvme.dev@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Subject: Re: [PATCH 7.3.y] nvme-tcp: skip TLS control records while waiting for the ICResp
Date: Thu, 12 Nov 2026 21:33:20 -0500
Message-ID: <daily-reply-2026-11-12-4489291895@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111-icresp-stable-7-3-v1-1-c9157e951b3f@gmail.com>
References: <20261111-icresp-stable-7-3-v1-1-c9157e951b3f@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-11, Martin Belanger via B4 Relay wrote:
> [PATCH 7.3.y] nvme-tcp: skip TLS control records while waiting for the ICResp
> A peer may send a NewSessionTicket as soon as the handshake completes,
> ahead of the ICResp. nvme_tcp_init_connection() fails the connection on
> any record that is not application data, so such a target cannot be

Queued for 7.3, 6.18 and 6.12, thanks.


-- 
Thanks,
Sasha

