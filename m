Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFFBC2BA1A
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jun 2024 05:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l2UHhwc1bFr1k9rxdFwuTqAzED8a5KSscuBnedF5K+A=; b=3juy3+Fa0NiXVJRFI4nFjnXvWo
	FivDQshmFum9Y7TiHnBQQP/btIvuDp2h2y3bZHmF2Punr2bju6Bzy+iBnACplNGJsjo4lFtCDJwPt
	JrGn7hLuIB49BMNSQOId04bj6wf5+LMgyeO5G14mUxx+BNR6FrtY15Bgd61mHcZiBEhhs+ay3CUOg
	W97oeNh7T/U19q7hWzE+44f8bhwruysX+4SiYPXwe18aSsdNbGzn69vb3SU5plD6YpFYj1eAbitjI
	ehCUSQo/UlFXar6rnUMBCFz3QeqvNff17Ma3p1R+8x67QyIiL0eAviATg9M/xHvDSoalAAca1PDKD
	pbqOOWHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJRfV-0000000Dgoy-2RQI;
	Tue, 18 Jun 2024 05:46:09 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJHWS-0000000CGsD-2a7f
	for linux-nvme@lists.infradead.org;
	Mon, 17 Jun 2024 18:56:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 65728CE1235;
	Mon, 17 Jun 2024 18:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D93C2BD10;
	Mon, 17 Jun 2024 18:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718650565;
	bh=g7rkmBq2pe99Z9GXbL+NVIJ/TMOoi7Iw0Lv6xVkToJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q2++ArIah/012FcoT7zryRSne2YU6H2RPdG7iBKuyfQrmxZbyv8Lx4xKP1XbxfRi4
	 P9yShjbbBNPd5Z+pIYeIP1Db5YS3Pve2dMGtJ9MQbacqJtlAi1nHOUDKGST7luNl4S
	 VT18yi6V9xiXWwuA1BAw5GJ4ydADTYRJMgezFx/borqv2g1Db4c7nv8jdEQcKkhy3o
	 woEvNwsvdZ7EbXMnP814TsTEFIfxu95enQlEl1cSSv74R1Y4gUneBRc9DPkS12+urf
	 6Erloj4I/sy3l2ecNNL80cFuj7jcXnVSsypQZ5zSuGonuDfO67EpStjz+LnqYx4GrU
	 aGcp51DpIckgg==
Date: Mon, 17 Jun 2024 12:56:01 -0600
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
	hare@suse.de, Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v8 05/10] block: Add core atomic write support
Message-ID: <ZnCGwYomCC9kKIBY@kbusch-mbp.dhcp.thefacebook.com>
References: <20240610104329.3555488-1-john.g.garry@oracle.com>
 <20240610104329.3555488-6-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610104329.3555488-6-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_115608_858327_941851FC 
X-CRM114-Status: GOOD (  13.35  )
X-Mailman-Approved-At: Mon, 17 Jun 2024 22:43:56 -0700
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

On Mon, Jun 10, 2024 at 10:43:24AM +0000, John Garry wrote:
> +static void blk_validate_atomic_write_limits(struct queue_limits *lim)
> +{
> +	unsigned int boundary_sectors_hw;
> +
> +	if (!lim->atomic_write_hw_max)
> +		goto unsupported;
> +
> +	boundary_sectors_hw = lim->atomic_write_hw_boundary >> SECTOR_SHIFT;
> +
> +	if (boundary_sectors_hw) {
> +		/* It doesn't make sense to allow different non-zero values */
> +		if (lim->chunk_sectors &&
> +		    lim->chunk_sectors != boundary_sectors_hw)
> +			goto unsupported;

I'm not sure I follow why these two need to be the same. I can see
checking for 'chunk_sectors % boundary_sectors_hw == 0', but am I
missing something else?

The reason I ask, zone block devices redefine the "chunk_sectors" to
mean the zone size, and I'm pretty sure the typical zone size is much
larger than the any common atomic write size.

