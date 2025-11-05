Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150EECCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 22:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uJdt/LMPMrGua6Mjw9//F0eX0U3RB9Gp87cAvRP6pUA=; b=4aPFnjSgD1e1EQUZqtZI2ekMl5
	JWrDRW4OmwGT3NJuJgfwwgT37DY/hGQnxi9L2gGj5VUZVVOLt5UjrWyzQ3X5aokcQ1juls85EIh72
	CStijMD83GK75W7fZLAffV31kfwHqd1s/U9yUqKyuFahwvprxDc+mHErqLnxUqSWVRQg/9ajiBdMv
	qzC4i7wexpSDdupySqzs6Zpe9ZpQOFbxEPMJ2VT3pslsyLiaBfw3u6STPfTJzm8mAsQEWTP9IBfaf
	9sVd4Ad8SKoUNQKVeNaBCmClYvUAQA2nVGWcMxD32VbnB6eQqrqcJTaYMgGWhIl99eIVaisfT8OTK
	3d7EYlZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGm5k-0000000Ea0f-0zUs;
	Wed, 05 Nov 2025 22:35:00 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGm5h-0000000Ea0H-2Y5O
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 22:34:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 64B0C40A8D;
	Wed,  5 Nov 2025 22:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29D8C116D0;
	Wed,  5 Nov 2025 22:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762382096;
	bh=+KvcBexLhNCJzaNe4cnSB5F9hndlAwffyAt6F7BB6Ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nWHqbtztUYK/Pa++w/s2/R4igN5yNO4ohPBh4/CYrDE1cebWMDUvzhhrfKdskQRPE
	 qmk7Aon+8g6vSg+TalSgxHEYbUiniGQ32SPD+W7xLTFrFSAw2q8ahOjAadvRMwQ/0S
	 GprgEuUP+Q6vQZE6hpP76CIZsm5EN+dEbrReJpP/7nnxZXU/v0xWWmjernrQdZD15U
	 HvOwxt0Qet4VbUJdwBUv64QBwgyXqb1Lk6FvAZqGdfT/o4rfAh9Vi29TA9idxUxPUR
	 myB9VrLFYIet0zHGVyYTEYgu5VTclTI6c1bOyiBZB8raWaROP3w+5HZG+lHIRkvWtg
	 tehAPbNDSXQ7g==
Date: Wed, 5 Nov 2025 15:34:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ewan Milne <emilne@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, ming.lei@redhat.com, chaitanyak@nvidia.com,
	Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCH] nvme: fix admin request_queue lifetime
Message-ID: <aQvRDndEfTf3LMab@kbusch-mbp>
References: <20251104225939.3641605-1-kbusch@meta.com>
 <CAGtn9rnm-V4Ejm9kRkvV91XAO98XF7jv9Y7Kjr611BbffikkEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGtn9rnm-V4Ejm9kRkvV91XAO98XF7jv9Y7Kjr611BbffikkEg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_143457_668018_4A310BFC 
X-CRM114-Status: GOOD (  17.33  )
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

On Wed, Nov 05, 2025 at 04:31:13PM -0500, Ewan Milne wrote:
> On Tue, Nov 4, 2025 at 6:00 PM Keith Busch <kbusch@meta.com> wrote:
> >
> > From: Keith Busch <kbusch@kernel.org>
> >
> > The namespaces can access the controller's admin request_queue, and
> > stale references on the namespaces may exist. Ensure the request_queue
> > is active by moving the controller's 'put' after all references on the
> > controller have been released to ensure no one is trying to access the
> > request_queue. This fixes a reported use-after-free bug:
> >
> 
> OK, so I get that this fixes the use-after-free, and don't let my
> comments hold up
> acceptance of the patch.  But can you explain why this actually helps?
> nvme_alloc_admin_tag_set() allocates the admin_q as part of the admin tagset
> initiailization, and doesn't this change keep the lifetime of the
> admin_q past when
> the admin tagset is deallocated?  So where do we detect that?

We still call blk_mq_destroy_queue() prior to calling
blk_mq_free_tag_set(). The queue has exited the tagset and set to dying;
no one can "enter" the queue after that, so that tagset can be safely
freed even if people are holding references on that dying queue.

