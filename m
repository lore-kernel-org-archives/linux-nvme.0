Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435B4C54E5D
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Mar 2024 01:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=msH99KHnrGGRnCg7x/xKd8C4oxm+N2Q+gzl5ZkadI78=; b=IpD33KnSDUCq2AyxDILRQhi7Gw
	W32qnNZV8VXcrIwGwxK+Nn4GHtZy8UEmRlbuNJHpAjJRUXHkM9PrC9kiB+pG6OpyP/+VRE8Sd4hfZ
	QG8tjPsv/v3klXc8n9IKjl6x9Xwn4Wr0Lm6+AEnilQSTpJ4CkH6C2Ah/lvTUXX3MWvwioj4gn1cXm
	PEpta1b0YR/w0Scj2RhF2WbK9OxXr4oblSmsk+NnvwQ8NHGt1vMEJXzPxlGhr48/sLsd2tGhSdkKP
	J82m2N91j2fkTGWxg9wQeB31Pf3KPbdC23Z0iKkayVN7gT3ulVH+yi0UIecLjG+7l9czf7lCL1CDD
	xZAW6dBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkDK9-00000008PLq-3YRn;
	Wed, 13 Mar 2024 01:22:29 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkDK5-00000008PIf-1B49
	for linux-nvme@lists.infradead.org;
	Wed, 13 Mar 2024 01:22:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 978A861351;
	Wed, 13 Mar 2024 01:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AAFC433F1;
	Wed, 13 Mar 2024 01:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710292944;
	bh=JlmuhNeUDrHfxxJ1OWk+7v8iRRq4ZgLmMbMW8wQDwGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RgjPCThQBRw8D1yCqIGRLyzTEY0qtxOVaN23a52vZpgnpW9cQgYp+02mKnNcV94zO
	 InJNw3M4fZL688D0Y1Em0+it2SU0Ky+kUayWvy/XYLVW6EIL9ZNL9GKiOLdYAVItHe
	 orztd9HGwO0U5c95EeEC5Wm+gq1hl4d6nqOjEkOTfyZ+11+yi1Sqp6uexNPcyRwoyY
	 Yuo2AAEubMIxeyjSWrsqNiLp9EEBLJCWnKxjgYtjsWbUbUW0znRvuN9kz56xwLWfAM
	 /mDdkwos+OZbRHBvmHLU9ELNNvfD/DfwZFRrs1qcPEURJWxT+a4OaFY2rfVH2iLeCP
	 uOM2dUqiyCgjg==
Date: Tue, 12 Mar 2024 19:22:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Chandan Babu R <chandanbabu@kernel.org>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] block: move discard checks into the ioctl handler
Message-ID: <ZfD_zdhQpctxbGeg@kbusch-mbp>
References: <20240312144532.1044427-1-hch@lst.de>
 <20240312144532.1044427-2-hch@lst.de>
 <ZfDTZpuumZSn6oPp@kbusch-mbp.mynextlight.net>
 <20240312223131.GA8115@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312223131.GA8115@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_182225_497256_0C9FB53C 
X-CRM114-Status: GOOD (  15.39  )
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

On Tue, Mar 12, 2024 at 11:31:31PM +0100, Christoph Hellwig wrote:
> On Tue, Mar 12, 2024 at 04:12:54PM -0600, Keith Busch wrote:
> > > +	if (!nr_sects)
> > >  		return -EINVAL;
> > > +	if ((sector | nr_sects) & bs_mask)
> > >  		return -EINVAL;
> > > -
> > >  	if (start + len > bdev_nr_bytes(bdev))
> > >  		return -EINVAL;
> > 
> > Maybe you want to shift lower bytes out of consideration, but it is
> > different, right? For example, if I call this ioctl with start=5 and
> > len=555, it would return EINVAL, but your change would let it succeed
> > the same as if start=0, len=512.
> 
> We did the same before, just down in __blkdev_issue_discard instead of
> in the ioctl handler.

Here's an example program demonstrating the difference:

discard-test.c:
---
#include <stdio.h>
#include <stdint.h>
#include <fcntl.h>
#include <linux/fs.h>
#include <sys/ioctl.h>

int main(int argc, char **argv)
{
	uint64_t range[2];
	int fd;

	if (argc < 2)
	        return -1;

	fd = open(argv[1], O_RDWR);
	if (fd < 0)
	        return fd;

	range[0] = 5;
	range[1] = 555;
	ioctl(fd, BLKDISCARD, &range);
	perror("BLKDISCARD");

	return 0;
}
--

Before:

 # ./discard-test /dev/nvme0n1
 BLKDISCARD: Invalid argument

After:

 # ./discard-test /dev/nvme0n1
 BLKDISCARD: Success

