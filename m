Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1FB606A31D
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MvBuSQpO;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOwiNHS5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=daxyWzpOVfWRfZViUrFV7uS4tLt5pHBSbhanNbS1ZBo=; b=MvBuSQpOr5j1nnDvAbe/4sG3Vn
	4RftJFi+Qu4zDRnYwBxXI9OeO4/bNZORCLJ6TXouTuTMa7V4q6M5j9l2GVYjb4aNAdSd2G9ht4U/q
	txldL6oITLE7eghvgMlnyiftGpZiE2gZqlwItGIYxIA+w4yXiiPQADJlSL0Zk8RZX+GqQClV+GxVi
	+ToLaCciWZiXSwLxXDYvQqkl/j5BZIgMfJnUxP7pY/EsyGknso9/HkYBv2uOGxB34d8UF0ZgrEaj4
	VyJgbUosVvkOnnCCEuSvQqA8J9yLcg/oMtiRSHVCnZH33dujJYpZGRVEqLvNYxNvB17a7rMPrLJDj
	rd00kfTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5ua-00000007SnJ-3ezu;
	Wed, 28 Oct 2026 15:50:00 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5uY-00000007Smh-2q87
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 15:49:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CAC87600DA;
	Wed, 28 Oct 2026 15:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EA51F01825;
	Wed, 28 Oct 2026 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793202597;
	bh=daxyWzpOVfWRfZViUrFV7uS4tLt5pHBSbhanNbS1ZBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IOwiNHS51pEIRawSAgNu+9i7iUPijArGT+HElT1/GoGTN3k5EKed9fRdih693enNJ
	 WrxsAyjmchij8HugBrjqyA24xUymArta7XlN+y2hrEpstQQ491eL9fAQF4d1aJhjfh
	 YeOGAXaEm+O0NhZFA0pph11/hbzGC2zqnAHF8AkKxjZs7Mp6j9jGg16pA8ujghMLp+
	 dq9txC/qh+kZnjYiiFnmTYzSW91X/kjNi3v+hmc3Yv/i2+sJYRnxflYat3QpH1GJDV
	 E7dIvMMfcf2/LJz3f+9bI0E0UcVcBzuLuWuuhsVy3zt0Cblayv85whiMVs0d8Ul1Xi
	 JCsEVSgMWi2zA==
Date: Wed, 28 Oct 2026 09:49:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvmet: Free the old negotiation state when restarting
 authentication
Message-ID: <auIZozv9Sw0tA6wi@kbusch-mbp>
References: <20261028085551.918428-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028085551.918428-1-kanie@linux.alibaba.com>
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

On Wed, Oct 28, 2026 at 04:55:51PM +0800, Guixin Liu wrote:
> Restarting a DH-HMAC-CHAP negotiation with SEND(NEGOTIATE) resets
> sq->dhchap_step but does not release the previous c1/c2/skey, which
> are only freed in nvmet_auth_sq_free() at teardown.  The next
> CHALLENGE/REPLY exchange then overwrites those pointers with fresh
> allocations.
> 
> An unauthenticated host can repeat the negotiate message endlessly,
> leaking a few dozen bytes per round and slowly exhausting target
> memory.
> 
> Clear the old negotiation state with nvmet_auth_sq_free() before
> setting up the new one.  Also reset dhchap_skey_len to zero: if a DH
> session key was already established, a following round with dhvlen=0
> would otherwise pass a NULL skey with a stale non-zero length to the
> HMAC code and dereference it.

Thanks, applied to nvme-7.4.

