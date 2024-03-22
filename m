Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE82C47DD9
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 16:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=py4RBnYlB73nYf+Ly0Jj6y6nDCqbGz37Egdx4QrNN5w=; b=NP/D5ezwJdqMYifwA/pcEMD6hX
	F9cmKzRxhf9Vu5m7Pzexr47gXHvcAKkWCfD8owfhkrUtfJpBAW3qw0yRvcM6oqeOwjYZ2G5yu3gKP
	0UQ2VRKf0Ar+EWfjhM3b6Fykl1mlig/onPBesTb+US9VktTvcRZZaDbMKRKvd53qqrgY0nRyTaV3V
	FZfN0ZwVpsp3qhokUdoOYhtUKGB9nNHjoDcXo7xWZkNBoQXLiHbmBu7f/sNwE5XsYMexLK7Vmyqup
	JLqolCEa+K/C3TCHgfbLHiGgV+MiyFptZYNbPKFOSnXQGaZNemX09TnnlGShvLJoks2l/+4NpOMRV
	FYQfYlkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnhfE-00000007wOE-0TDH;
	Fri, 22 Mar 2024 16:22:40 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnhfB-00000007wMq-39Px
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 16:22:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id DE9B9CE17D2;
	Fri, 22 Mar 2024 16:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7424C433F1;
	Fri, 22 Mar 2024 16:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711124553;
	bh=fWck2OVjIP7VfsRdSHuK79EaY918Xc991uksMKsY3s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJwVeHZcvyS/gHfG7+04Tn8uzQLMwDL4KymQWLi52vtZHgalF7SiZ1UWOX3RDwKXI
	 dPm3F+E9UszYqbk34wvgNd0XXq9QJsF8XMydUE/1oupmKUJD4rU1843UgmnCJ5Ieht
	 juQDppZYIcRQ8qtqcfu91j5GFM6/f9trHI15e/hxSfZ77S8H14PBBUGQkuER3o+BzL
	 xo4w9suPI8B9E1jYAg8PenfIx9ZUQBesR9OZmMaPJ5s+F1R2oJmERncsbxWJfm9j0W
	 XiMf8B/1cDWT4LT3GzPopJLYNVQqe71J6TKXCFZwx7LFvYywMMI63q8ByVEYwcKDma
	 oSPSdcQ9bXvKA==
Date: Fri, 22 Mar 2024 10:22:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH] nvme-multipath: don't inherit LBA-related fields for the
 multipath node
Message-ID: <Zf2wRtNqNU2qTpHE@kbusch-mbp>
References: <20240321210819.1246749-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321210819.1246749-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_092238_140580_ACAEB3FA 
X-CRM114-Status: GOOD (  14.05  )
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

On Fri, Mar 22, 2024 at 07:08:19AM +1000, Christoph Hellwig wrote:
> Linux 6.9 made the nvme multipath nodes not properly pick up changes when
> the LBA size goes smaller after an nvme format.  This is because we now
> try to inherit the queue settings for the multipath node entirely from
> the individual paths.  That is the right thing to do for I/O size
> limitations, which make up most of the queue limits, but it is wrong for
> changes to the namespace configuration, where we do want to pick up the
> new format, which will eventually show up on all paths once they are
> re-queried.
> 
> Fix this by not inheriting the block size and related fields and always
> for updating them.
> 
> Fixes: 8f03cfa117e0 ("nvme: don't use nvme_update_disk_info for the multipath disk")

Applied to nvme-6.9. This just missed yesterday's pull, but at least
it's queued up for the next one.

