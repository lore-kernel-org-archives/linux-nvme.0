Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B383AD374AE
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 15:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hVc8DqEHLbWRqDHNiWoDPciAloHuOsKMKw0EjosLgpA=; b=i4B4OYYx1vXKO1Sf16DtwAqII7
	/QeRoMEaXPqmpl2A9cdA6VIGBUgLvp1C7Cq3zKHmSDZIPMmBUwEo+mPjIlMX5gc5YCRtziO1gcdo+
	jkj/X/rRR3gJwRnT2LcIBBsV2u/Ss7k3JdaI19WGyWwJbrRWhrp+VkWZ4I788dLUk0clT3lKqaiED
	9hhaBXLPxhZZombmOicFglf9MfsbBUdSrwW4A6Dp5CL4W8c3KYehP0Xc4IS4ts4ynMBAKV557Wlln
	w3WjyaU5qUT+CMd5zVeczGQvVMTIN2yzE7xN9joQ7+9eG8ApCfyRnR20xFXF9KSMcGa2HM5zq7E0Z
	8LXjcJ/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1SsS-0000000FNUM-3B2c;
	Thu, 17 Oct 2024 15:57:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Sg7-0000000FLKD-3FtK
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 15:44:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CF1355C5882;
	Thu, 17 Oct 2024 15:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC1EC4CEC3;
	Thu, 17 Oct 2024 15:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729179883;
	bh=YyMF8CAbGHfi2Sw0wRiqwANy0JpymXK7ZZYD+DPBNbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uGtOCC0KZ+nQG3KRlBLvL3qkiKVlc9OuxDmzeY/a0qZE1JclZl0IvwCA7qJx1bePC
	 J+ICr6c0I5o4mWgMbRUDPMezx9EHk7I0I1VJIClLE1pySihpdyWuHoKH1rPGUIjEnJ
	 rRNeb269IyZtZEvF1uaNvjtBRoEhjzXSs9Muo2HfP6swFWuzSOrAAkXIWgOz8lFlFm
	 UxsKN2UtuWSUZUwbH6WREbBggDHkXWKHPmJ5GlQpc9ta5szoU88MMOwrCUxx1Td7CU
	 UxsbMHQKBgsY3Gmf+Sw07HFzvaGBDMZOV8w8WX6yy6KiAE+uz60bnhgU8wKueSmQPy
	 xEw2/sh6hsewA==
Date: Thu, 17 Oct 2024 09:44:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hare@suse.de,
	sagi@grimberg.me, martin.petersen@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, bvanassche@acm.org,
	asml.silence@gmail.com, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <ZxEw5-l6DtlXCQRO@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com>
 <20241015055006.GA18759@lst.de>
 <8be869a7-c858-459a-a34b-063bc81ce358@samsung.com>
 <20241017152336.GA25327@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017152336.GA25327@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_084443_880337_A58158F5 
X-CRM114-Status: GOOD (  13.13  )
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

On Thu, Oct 17, 2024 at 05:23:37PM +0200, Christoph Hellwig wrote:
> If you want to do useful stream separation you need to write data
> sequentially into the stream.  Now with streams or FDP that does not
> actually imply sequentially in LBA space, but if you want the file
> system to not actually deal with fragmentation from hell, and be
> easily track what is grouped together you really want it sequentially
> in the LBA space as well.  In other words, any kind of write placement
> needs to be intimately tied to the file system block allocator.

I'm replying just to make sure I understand what you're saying:

If we send per IO hints on a file, we could have interleaved hot and
cold pages at various offsets of that file, so the filesystem needs an
efficient way to allocate extents and track these so that it doesn't
interleave these in LBA space. I think that makes sense.

We can add a fop_flags and block/fops.c can be the first one to turn it
on since that LBA access is entirely user driven.

