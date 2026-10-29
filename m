Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF36B60A3818
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cTy8sl1P;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+h5gi3j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Qx9Vxq+q1VH53YvroEAQ47lDP6bGDc9uPHBxf7J0T7o=; b=cTy8sl1P1nnvwz
	icg3bsdtXgJmWnqGoLu+I2dEdcj6pdwt94GjROiV0qCbv0knnQ+pZtpSgg91xx1KeWCS2nz0oz6bE
	gRe3hScDJuWg1f4lGcTAH7hZwf8/5762jrXlrl8HWCXQOgp3w+SZlVr3mY9Plmwhfxjifm8UkadPT
	6ljtLrC0ZlubMEtEZRNPU5HPgY/+7L9ROzPVeWb2u0qnUZIWrSa8nqnJFjNKy2wmlIr1tWlC+55h6
	fUPaH5npJoPgcuULlxIvi0pl5dGYMibQb3knbwvE3MpqyGc5wYAodTPn85qwHE44SUyIk+XkMX7uz
	kUR/gnH4e3kZAgLqNeyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMV6X-0000000A9T1-02Uu;
	Thu, 29 Oct 2026 18:44:01 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMV6V-0000000A9Rn-49oo
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 18:44:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1DD9C43FE9;
	Thu, 29 Oct 2026 18:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A9F1F01283;
	Thu, 29 Oct 2026 18:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299439;
	bh=Qx9Vxq+q1VH53YvroEAQ47lDP6bGDc9uPHBxf7J0T7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g+h5gi3jEK8BB5uAdKTMg8CQvNl6gCP/yYOLuc7kCqhiYS606tBFVtV4NHYt9RkEF
	 Pmus3xfxFpQDHtIcj5Fj752O1CDElhr0Sr2bb0sqr0MQqeueKKFq7E+mpOSnkHQMPT
	 LlbW3KPjfynlptaczW+rNeJ/Y8JFFC7y8mC0ePLjS70++cwT/kbZljgFu+B/nkcK0H
	 c5j/TLLwhH9U+/MD9itZaqOZ7SyB9IkuWgOYVGQdyhpglt074BwN+xpSyttxu52Cqv
	 m1sRIpFx0Hr5nW6oRprb0RB6PJC6Pb/ru+bPS9qAQ15w+MrnitG3cpmNg4ybCnl2AH
	 A9GFs4hZnrhLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Carpenter <error27@gmail.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 5.10.y] nvme-tcp: fix error codes in nvme_tcp_setup_ctrl()
Date: Thu, 29 Oct 2026 14:43:28 -0400
Message-ID: <2026-10-29-1-daily-reply-0021-nvme-tcp-setup-ctrl-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029031352.56096-1-kmehltretter@gmail.com>
References: <20261029031352.56096-1-kmehltretter@gmail.com>
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

> These error paths currently return success but they should return
> -EOPNOTSUPP.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha

