Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0775AC41513
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jun 2024 06:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y/LHQyfPsOpepjixn2kmdpmr2s/nyPt3MW+LM7kv/vU=; b=dOX067GteGslK5MiOc7vXu3wci
	rZKzlAPInalRvN2cLj/cZChwj/EFooo6uB3L4r+bJxF3PnlPExpVTwuCaBVntTPA3OTOdkBroxW2I
	X2KWzrTt9dTDaM9omJK8BJmxLtyOD9ssW1pbzfpe44wpsU2uC+p4pWKTQ5quv+JuZEoZCzvJcyJHY
	x2shrRjVuif0MN2WVHvzXv3ce+O0f+V6dWH88UEcif4vj5U4wg+DITbhuxaCBOlMy3knmqrX5Q/xJ
	pVh3HCcpv1oS58b+pgMLmjwLZ9FTtZEl8eyzXURTR085gPdPU64SVk/fcSUoMwaRv09u1/s9qfARw
	ThJ4rxmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKXri-00000007zAp-1VLK;
	Fri, 21 Jun 2024 06:35:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKNk6-00000006VaY-2mJI
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jun 2024 19:46:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 18A0462294;
	Thu, 20 Jun 2024 19:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58F6C2BD10;
	Thu, 20 Jun 2024 19:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718912805;
	bh=NOXrZZ78IGZVhFJah42haGiQhcKtgPlchliubLibNbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iF7Jf0V6MxMlfrr5Rgpz7hsN47YbOthkjXFvJso/wh76d7mGGy7OuHpHvTuiSXzQx
	 dv//qW5Xxsd3CpYXOBgfZznlroKttBOwPJz3r47EHcsL5cF8eRuK5Tfcas30TmFyls
	 Tr1uUb5KjKCdnNO3zm0C254rZFe5QeK7ngeONnl5FwUln1Rwst9PvqjEIUxUfrZL+3
	 993k0ImdQ8LalafeFDgz8knEEnBOIMMFVeUvuJvGZSSFhb+80jqfB/o02kb959m/fm
	 N6rEEvbwS5SAkyii0YsbFb3yNNkDWCmwwMitjTkHXxIJKPomps4I11fbaW0rfb18Tj
	 6aCxakGyMlmAA==
Date: Thu, 20 Jun 2024 13:46:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
	djwong@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, willy@infradead.org, agk@redhat.com,
	snitzer@kernel.org, mpatocka@redhat.com, dm-devel@lists.linux.dev,
	hare@suse.de
Subject: Re: [Patch v9 07/10] block: Add fops atomic write support
Message-ID: <ZnSHIWVeMlpZ-OJb@kbusch-mbp.dhcp.thefacebook.com>
References: <20240620125359.2684798-1-john.g.garry@oracle.com>
 <20240620125359.2684798-8-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620125359.2684798-8-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_124646_763797_A108269C 
X-CRM114-Status: GOOD (  10.06  )
X-Mailman-Approved-At: Thu, 20 Jun 2024 23:35:15 -0700
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

On Thu, Jun 20, 2024 at 12:53:56PM +0000, John Garry wrote:
> Support atomic writes by submitting a single BIO with the REQ_ATOMIC set.
> 
> It must be ensured that the atomic write adheres to its rules, like
> naturally aligned offset, so call blkdev_dio_invalid() ->
> blkdev_atomic_write_valid() [with renaming blkdev_dio_unaligned() to
> blkdev_dio_invalid()] for this purpose. The BIO submission path currently
> checks for atomic writes which are too large, so no need to check here.
> 
> In blkdev_direct_IO(), if the nr_pages exceeds BIO_MAX_VECS, then we cannot
> produce a single BIO, so error in this case.
> 
> Finally set FMODE_CAN_ATOMIC_WRITE when the bdev can support atomic writes
> and the associated file flag is for O_DIRECT.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

