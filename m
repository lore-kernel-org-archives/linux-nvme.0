Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5219C25B78
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 14:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=agw+ZS3duK4qb+JB4Hu2zw16lJngPPaq2wP17CrIxG4=; b=hEceBUnhXJlvhz9oObmybSJRra
	dcWs0UIFFu65LenDj57x7D/c5usJQTqXmmbsAWpCikzm8zsFa+vBHj95x9x3S/M/RxYkIg67/EA6s
	QSe7Y0DyIj1BX5dek+nzBz0r9BWj8ZcXFANzCODOc98TnG9TZU+b2VYbI9tyPCO69OMS6SAhz7gsN
	xts2X1ASyJM/szWYvadIxe7tNtuJz/HhXbE4VqysW0cSWxkhJ9ub52qHWOEAVRJaThuZm337N7vVE
	/1glBJzPu3DyyRuyHpIzl4Anxh2zLBDdMb7R4Q5dKzHELg9DzYW/6zXb453f9n3jOXuDcm2EriK8Y
	DA2Xm9LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9mnO-00000003BJ1-2m8P;
	Wed, 22 May 2024 14:18:22 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9mnL-00000003BGR-1BC4
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 14:18:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 49A6DCE092F;
	Wed, 22 May 2024 14:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E773C2BBFC;
	Wed, 22 May 2024 14:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716387492;
	bh=KxVjT8Jm483e0ijnlVH56hgBRj2u4MIk0YLNS5R7QGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTZeP62Z+IG/daPyJYnqD0/fmOOVHbR5il6dz61wh48GYm6tLF10ihO54+ZOUOL5u
	 9vkjK+7DMOflnTUqmhiZhMqAOpFpY4R8QR490sbA0fLfvmYo1L5dFFDlrP1GP9S03W
	 GSDJ5tovG2nHakmkFIf6VvUw5Up6Sq9aK4X7ijNYp7xv3GjulUgFDVbYDoq3G/lHoR
	 +Sk6uRYuT4a69h9XqCX/hD4v5t2G1esb3hnsWhgJOwF5M8+bWQg9zOWwmnQYXALpjL
	 KK+a5vwxQDdR/rV5dFV/S7CjrOjYaZ2vHfO4Zx4kfyVjFmEHpqVixi0QSV5zZ7lny/
	 5w/z3ZmTHXc3A==
Date: Wed, 22 May 2024 08:18:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, jmeneghi@redhat.com
Subject: Re: [PATCH] nvme-multipath: fix io accounting on failover
Message-ID: <Zk3-okfn-8WIf2I8@kbusch-mbp.dhcp.thefacebook.com>
References: <20240521180712.2423165-1-kbusch@meta.com>
 <6e01032f-c90e-4f7e-9339-d2782fd60e3f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e01032f-c90e-4f7e-9339-d2782fd60e3f@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_071819_790249_E6A67C31 
X-CRM114-Status: GOOD (  15.94  )
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

On Wed, May 22, 2024 at 06:32:11PM +0530, Nilay Shroff wrote:
> 
> 
> On 5/21/24 23:37, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > There are io stats accounting that needs to be handled, so don't call
> > blk_mq_end_request() directly. Use the existing nvme_end_req() helper
> > that already handles everything.
> > 
> The changes look good however I have a question about why do we retry an IO
> when that IO is cancelled? For instance, when a multipath IO request is cancelled 
> (from nvme_cancel_request()) we re-queue the bio in nvme_failover_req().
> Similarly, for non-multipath request, we do retry request in nvme_retry_req()
> until retries for a request are maxed out by nvme_max_retries. So wouldn't it be 
> appropriate to drop the cancelled request instead of retrying? 
> 
> However, I do understand retrying a request on a different path when we got the 
> request completion status specifying the path related error.

A cancelled request just means the host thinks the target failed to
produce a response. It doesn't mean the host stopped caring about the
command; the host still wants it to succeed, but determined corrective
action is needed to reclaim and resubmit the command.

