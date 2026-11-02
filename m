Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E82606E021
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2026 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GnyN+/95;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXUBMKak
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2czTmQ24qitbkFxmuQ6dQz7mWzFCeQOh1YnpkBLFv6M=; b=GnyN+/952h/czaKnTVLBbirf1P
	glMhXilUZpgcENLM1Xf5iG9EPCEGtiN4kOwy1ycsQ3qtv+khrSUh92MKotJ+O4qPDqE338wdHj8uX
	gYTc02+DFmEYdoz1MK2aBTUy5KX4g3D4yHUG4dr6SjCavCjSd1wReyO5pvtcZ/mL2b4l6NY0aZuaP
	N8uj/sIdHKBUMwlThe66XiZPqeNq9GUMGNY0zjQgcuGXY9zYZrEG3Le5ryNfnmYQ3Zco1IsH2ci/n
	QhCZkpiJnyeo4eYQAx5FEZR5Md94GNBG7Qj5wIe8ItahsHnmlebFkMZUrj8exkaHfJr1Iq9qz/5Bv
	Fwe5aFxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNvpD-0000000HSND-3XD2;
	Mon, 02 Nov 2026 17:28:03 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNvpC-0000000HSMp-0bvd
	for linux-nvme@lists.infradead.org;
	Mon, 02 Nov 2026 17:28:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5FBC360A66;
	Mon,  2 Nov 2026 17:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E4F1F00A16;
	Mon,  2 Nov 2026 17:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793640481;
	bh=2czTmQ24qitbkFxmuQ6dQz7mWzFCeQOh1YnpkBLFv6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DXUBMKakKRJ6/Un0jfLbcBn8aEE8R9HKiP3gH7Pdm1yoqlBRZIJjW8ndCHhqY+ZSl
	 EAytoP9gyhtPB6kM4V3YmYWDKuj85FPfUcC4ySGhWKJMYPRbP39quCu/4ZKxPwTvlb
	 CZl8Apki+OJmgNI9UfiB8lr59rNjaE9mpu513+8vAVwDn2brzp7gzlW+EKArCCkeQG
	 wcaTKVquJnsuVI57w3vVGwZRbJ8mNPINzvkxY2o9f0Ukk917yqgOEGKtMsH+avLXyq
	 C5UsVDuWUFNB0ZRYorc4x1DbvUzs1ohi4kCB+a/q2i1pynkurulPOrR9LQPjD4erVE
	 LiXv7qTyAzDXw==
Date: Mon, 2 Nov 2026 10:27:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: daejun7.park@samsung.com
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Mike Christie <michael.christie@oracle.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme: unregister when pr_register() is given a zero new
 key
Message-ID: <aujIH1Kw8Ex6kYlX@kbusch-mbp>
References: <20261029-nvme-pr-unreg-v1-1-b4657ad4e98e@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-nvme-pr-unreg-v1-1-b4657ad4e98e@samsung.com>
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

On Thu, Oct 29, 2026 at 09:51:24AM +0900, Daejun Park via B4 Relay wrote:
> From: Daejun Park <daejun7.park@samsung.com>
> 
> The block layer PR API defines a zero new_key in pr_register() as
> unregistering old_key. nvme_pr_register() sends Replace Reservation
> Key with a zero NRKEY instead. The host stays registered with key 0,
> and its next registration with another key fails with Reservation
> Conflict.
> 
> The pNFS SCSI layout client unregisters this way at umount. A later
> mount cannot register and sends all I/O through the metadata server.
> 
> Send Unregister Reservation Key when new_key is zero.

Thanks, applied to nvme-7.4.

