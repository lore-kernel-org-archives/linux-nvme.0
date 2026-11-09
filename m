Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01EA606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GosId2Dc;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MbKFX2PY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Gr4Qes8i2N6vKMFexBeMqPYsGeui0SgaN10GkNG24GY=; b=GosId2Dc/k1tIQqtYIdDwt87Rn
	Vs6DWWUAPlib4RRrwaRMSLEQ9Nwvn7XAP6JU1ovkgvolb9cv1qpXR4EV01QhZ/hMcMdScpvDdn8ua
	qpEeOvSzaqWv6xCvHpqLo1cn4mqw/l9QvKWlKjfYfOBmZX4tCEShC1VzD6CTVMO5DASAgNv1LoGYf
	U8lUZUGPF7YU4Ba7l2MmqIvWwLJ+uc4fDnSGJ35N7Xhu6sxnuKbBcH2bCfDl8fK1XxnRLsTg43AdA
	n/6k/3NgGwLYXW6vHItSMZOave1Ers78F6GLN3sOIfwIx20ato5hHM/kQDwI2ZRgz/lKDK46SzxxD
	JiLLESaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQStM-00000001Jbh-38ui;
	Mon, 09 Nov 2026 17:10:48 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQStI-00000001JbJ-1eiz
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 17:10:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 79B6C633A9;
	Mon,  9 Nov 2026 17:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDD61F0089F;
	Mon,  9 Nov 2026 17:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794244243;
	bh=Gr4Qes8i2N6vKMFexBeMqPYsGeui0SgaN10GkNG24GY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MbKFX2PYWQNPPxudpI/IGB91R5Y/5xr614f21AJeskKCzJGgFe6ZVbdN4BsyOQ2q1
	 BmwUOasByug8LqHyJzASxwwyc8bCwAvM+pJ2i66j35nUaR8gYvygzQFXRzM/AANABx
	 f/sG6J5VogZgE3IDdMWppp6uDqG8sWhNonvTdfbuGrL63oRmtkdSyPLyQ2dDupkMdo
	 dUlB0NlBDNKfI6bYir3hzLOyKCmEQzQQbJ2oXsxK9ViDNxvgHjmQ5kQ+GPlyeEBF/I
	 00Fqi67wJVtXHFYC8ZyQ5ONTVZPtaDsEwQlxd/BQclnG69WzJsp1YRWgNRa6vUTs6C
	 o7OYd9OGprZGQ==
Date: Mon, 9 Nov 2026 10:10:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/5] nvme-auth: fix data race on ctrl->transaction
Message-ID: <avH-kbnayBj-gyR1@kbusch-mbp>
References: <20261109022646.290792-1-kanie@linux.alibaba.com>
 <20261109022646.290792-4-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109022646.290792-4-kanie@linux.alibaba.com>
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

On Mon, Nov 09, 2026 at 10:26:44AM +0800, Guixin Liu wrote:
> The controller side only echoes the transaction id within a queue, so
> the race has no functional impact today, but the increment is still
> unsynchronized and KCSAN reports it. 

So it's not a bug with any user observable behavior; it's just
unexpected. It sounds like the "transaction" value doesn't need to be
unique across queues. If it doesn't need to be unique at the "ctrl"
scope, then I'm not seeing any benefit to imposing that rule on the
driver.

> -	chap->transaction = ctrl->transaction++;
> +	chap->transaction = (u16)atomic_inc_return(&ctrl->transaction);

Can we just change this to:

	chap->transaction++;

? And delete the value reset in nvme_auth_reset_dhchap? You can also
delete the "transaction" field from the nvme_ctrl struct.

