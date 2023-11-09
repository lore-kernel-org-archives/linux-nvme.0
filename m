Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4144C4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Nov 2023 15:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/BNh6VJF2AIFwXWOX4IJA6gSXH9mmZtBDBpz22quQJQ=; b=uSIXcU3fH1q6Hk6Z1Og97eRikL
	w1V21P1vMycPZYI3ZCit4rYwFfmybCqGtG038bxDTJKgKGG8Kxc+SBsxokRi1wPrP6ZJC0VQU/2Hy
	pQMcIW6O13YP+nInkUrwE4mbCaELe07CwxjPQG5BqUNb9maOAZ9HOsNLVML4lMZ6yKfpOgVpfujkV
	daWjCV94ZQ2Ed1Thp3lMil4K93RUJrxVtdni4qLn+MY1IHHdT0nWfUugLSvOQQAeIduuxEhwvvvJC
	J0pueZUkX2Up8sYBJUDXZKPhBPrg7bPr6Td0fboBPeHnE9ckkkDBcaJm5RGLKdWS0QfXTK0Drt90f
	NgN28QYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r16vG-006aNR-2Q;
	Thu, 09 Nov 2023 15:26:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r16vD-006aMZ-0o
	for linux-nvme@lists.infradead.org;
	Thu, 09 Nov 2023 15:26:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 67A9F67373; Thu,  9 Nov 2023 16:26:15 +0100 (CET)
Date: Thu, 9 Nov 2023 16:26:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 17/21] fs: xfs: iomap atomic write support
Message-ID: <20231109152615.GB1521@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-18-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929102726.2985188-18-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231109_072619_429197_2F641AB0 
X-CRM114-Status: GOOD (  15.55  )
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

On Fri, Sep 29, 2023 at 10:27:22AM +0000, John Garry wrote:
> Ensure that when creating a mapping that we adhere to all the atomic
> write rules.
> 
> We check that the mapping covers the complete range of the write to ensure
> that we'll be just creating a single mapping.
> 
> Currently minimum granularity is the FS block size, but it should be
> possibly to support lower in future.

I really dislike how this forces aligned allocations.  Aligned
allocations are a nice optimization to offload some of the work
to the storage hard/firmware, but we need to support it in general.
And I think with out of place writes into the COW fork, and atomic
transactions to swap it in we can do that pretty easily.

That should also allow to get rid of the horrible forcealign mode,
as we can still try align if possible and just fall back to the
out of place writes.


