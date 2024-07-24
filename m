Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0449BC3DA63
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jul 2024 14:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hCGD31+ybqf5XS1PHCQE1e3d3A/c3ANNM5JUQa356zo=; b=vJCLL7Achx/YOGox77o3u61aI0
	H7tiPbzVbQD7kHnuBXzPbToJCH41ajmDR73pQKrtTaR4mhmEqlV/QiIR1oi8BOr5s0vokj8maaqvA
	mmGAyUKmfR2LnwJxz4lEsXfNyBvXHY6qrLG4MRtsiR+77qF8zsYQXfLhfQITjqO21hPH8yh17Eqzr
	mPMphov4NKItE1ClHXOK0d19tgDgA8Oyq+3t5zNEZ6fZmtBzLb2eJKnTBvIcbyFz7YkGwOqkBiksQ
	uYBtGO07BZKuDqorOjpG8xPsTFtSAkh4yLWFlISoTu3dAY0OgqiYqpO3BsxGx0S9qGa2fMckMHwPC
	7axVGeaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWd7K-0000000FcdS-3BtI;
	Wed, 24 Jul 2024 14:37:22 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWd7H-0000000FccU-1PDy
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jul 2024 14:37:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B0AE2CE1170;
	Wed, 24 Jul 2024 14:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3248FC32781;
	Wed, 24 Jul 2024 14:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721831835;
	bh=f9NbRaYf4mOe5JnhsQCwMVaZ/ULetrLanffakhF7tg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ClwYGwD9r9e2IZMvmLXtHegca3QpripvdWGQvkZqq29w3U+FYDTeYtAIHqp4Qyyuq
	 OrWW6NcBIPbj90wQKxgZLKH0tUaF7W2O/OFZ+/s1aweG3K+0nriCX4Wy8oiw/1xrFK
	 rG5Gq6cSbCZBLXh3QqHhobuZbJ3m4rGohZI9T4JSQKIK7eH+fpQE59E9cJ9iG+VZzY
	 5mDKypwtJjq5FtNSQ2Tzv8aHviNwCc2513hsSQ7QYiqgCigUsT0thD5jC68nK/6ZFb
	 g0TyGbNC+zJIC3xPfO768mGYgdUNJqHVsqlZNFe7Q+TDHLJUL6D5G++YFqdZMmXt/X
	 /CRgxet9BCZog==
Date: Wed, 24 Jul 2024 08:37:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	axboe@fb.com, gjoyce@linux.ibm.com
Subject: Re: [PATCH RFC 0/1] Add visibility for native NVMe miltipath using
 debugfs
Message-ID: <ZqERmEICdLEvQ6aQ@kbusch-mbp>
References: <20240722093124.42581-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722093124.42581-1-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240724_073719_570915_90F62632 
X-CRM114-Status: GOOD (  11.20  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 22, 2024 at 03:01:08PM +0530, Nilay Shroff wrote:
> # cat /sys/kernel/debug/block/nvme1n1/multipath
> io-policy: queue-depth
> io-path:
> --------
> node  path          ctrl    qdepth      ana-state
> 2     nvme1c1n1     nvme1   1328        optimized
> 2     nvme1c3n1     nvme3   1324        optimized
> 3     nvme1c1n1     nvme1   1328        optimized
> 3     nvme1c3n1     nvme3   1324        optimized
> 
> The above output was captured while I/O was running and accessing 
> namespace nvme1n1. From the above output, we see that iopolicy is set to 
> "queue-depth". When we have I/O workload running on numa node 2, accessing
> namespace "nvme1n1", the I/O path nvme1c1n1/nvme1 has queue depth of 1328 
> and another I/O path nvme1c3n1/nvme3 has queue depth of 1324. Both paths 
> are optimized and seems that both paths are equally utilized for 
> forwarding I/O.

You can get the outstanding queue-depth from iostats too, and that
doesn't rely on queue-depth io policy. It does, however, require stats
are enabled, but that's probably a more reasonable given than an io
policy.

> The same could be said for workload running on numa 
> node 3.

The output for all numa nodes will be the same regardless of which node
a workload is running on (the accounting isn't per-node), so I'm not
sure outputting qdepth again for each node is useful.

