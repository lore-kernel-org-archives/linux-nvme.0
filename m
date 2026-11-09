Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F23606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TyR2Ajet;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTvYd4N7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xq+o40aZask4Mue4IsDrna98V6ydsvcAOAEmmxNt36Y=; b=TyR2AjetdD8SF8gSVkMO+HvL53
	brnqk2IUAqpIy+i3Scj+AVCKQ0uHSaTgsyRMKmfgnYCz0RwwfQKhBk6u8R94CCCNGM365k0vP/kNh
	7WCTFGKyZT/dcJiI18k8VIsyNgujdMD/Mlwmh/SM4QpZwaT5Vwn6/nQq2EbE4K/4ipjZIjbYVSOMY
	4JNREiP3RbNHKuqFZaixMCTsQ9Kw+j3le2+P8MAXgpJXYbixASpu5jSUMVI5468pKK29k/+z/woou
	bPhq6mZNwevM091G8f4Dw4cHy2QQdy8Z4VeBFdFi41krkG+Ym3hfvwwBBgUNqTPex0toWrLDNrNuC
	jz2TGwbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQTa7-00000001PwC-3uuO;
	Mon, 09 Nov 2026 17:54:59 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQTa5-00000001Pvq-43In
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 17:54:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1238A634D3;
	Mon,  9 Nov 2026 17:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779E21F0089F;
	Mon,  9 Nov 2026 17:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794246896;
	bh=xq+o40aZask4Mue4IsDrna98V6ydsvcAOAEmmxNt36Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JTvYd4N7ON0Z9yr+B04qBbDI+QtKgXeBb3bQ3Ct2Q3njGvb5Yr0eneZfqWTbC5Ya/
	 u5FH4KAjn1d/UH9D3Vx1XTazrF50CxbWK7Xx8FBpZvLaDtgS32p3H154vW0ZSuJzIt
	 Qx34mXpw1Ui8HspTpYGYxTdJdUQamogZ4fNUL3G4IvSAR8yQYZ/xhWBlSqNRwG+bHK
	 AV5UQFuELCms0R31szg2g04GhmgM+qnNIc6/YkLQUxNA/eKouO1ykJuEgW27z0JNFg
	 LmlWODNvGmxeXtXIfRUEGZ3RZmMpGMI14T+o0yPzl49C7CzgndW28avQXrVFN/r6+6
	 08ibic3Z1F8xA==
Date: Mon, 9 Nov 2026 10:54:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/5] nvme: reject a reconnect_delay of 0 through sysfs
Message-ID: <avII73yoEjhR0v3l@kbusch-mbp>
References: <20261109022646.290792-1-kanie@linux.alibaba.com>
 <20261109022646.290792-2-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109022646.290792-2-kanie@linux.alibaba.com>
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

On Mon, Nov 09, 2026 at 10:26:42AM +0800, Guixin Liu wrote:
> nvme_ctrl_reconnect_delay_store() accepts any value the option parser
> also accepts, except that it misses the lower bound: writing 0 is
> rejected by nvmf_parse_options() but not by the sysfs attribute.
> nvme_ctrl_loss_tmo_store() then divides by opts->reconnect_delay in
> DIV_ROUND_UP(), so writing 0 followed by any ctrl_loss_tmo update
> crashes the kernel with a division by zero.
> 
> Reject 0 like the option parser does.

There was another patch sent earlier with an identical fix posted here:

  https://lore.kernel.org/linux-nvme/20261105215807526OqR0Bg86VChvwhCEz5xGr@zte.com.cn/

I ended up applying the one that published first, but removed the
unnecessary code comments.

