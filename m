Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CC5C27C4F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 13:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k2H5kMSGXAcXtZKV+rbK+tIg7d2r+evwWQcLbezoGwA=; b=D8cMvSogLBrRB3SdzgpWwCcyZv
	auEjUuAlrKg6aqAPegXvjv9lAqKHoCqzscYHN0BYhOJEZJ4JjUoqUMMDYXn/J3dJSBn51wFQpOi9W
	88aGQbvMpWM/iPa1ifElu8sx8DkZ/MqvlccBICt6RjRlLbZd5nKzzJENGPAeSJ7X+f2//mee6jxEu
	eAjRXZ5THyOZlzUvE5DgZiwmX0d21C14sIdMFpS8Yo14l+Q+YDGlhMozN3gmfAh7bt65DA7oQ1p5U
	3kaw5uL3KTj3iMjPm7EAMV2h0wQ1+AHsFw3Gxlm9tgf/iHzv1Z2eoY0/mv1pSEWTS+x6vMGYF3mmM
	V+0jBwOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHk4N-0000000Gc2d-0bX1;
	Thu, 13 Jun 2024 13:00:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHk4J-0000000Gc27-1ZBb
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jun 2024 13:00:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8811D61A8E;
	Thu, 13 Jun 2024 13:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB77C2BBFC;
	Thu, 13 Jun 2024 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718283642;
	bh=J+FOEDQ8EizaWwa5B+nADOYSJHbx/xeNUz9hDlllVAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qggwRUULEqiXxuZ7j5UvKifzy33DHtdZrKO56gBNXhQgLtA73AndYpzFdFKPtgajQ
	 eZ2FrWkaHiyu1CdoFUoJoAYYrvE/N2+CUEp/qa3f0Af+VlZQyOvYOKG67D0tjcqo0x
	 3EW1/WldLUz1c60Qlz/5z2q1SN7/pTXJ3oF6Xdw9Bd3BKzB0X/HP6kxPWzRVlb+7z4
	 9mbcbdJWED1dzELNE6rA9JFZltzNE25ja+CDOS0rLms/EmFDwbgjCb9OqLuY02UOac
	 Ml+wL3j/PPtPYrIAHbcgznafOfDKP/T+JvE6NY0UA7S9SC3cj2JEtsBYFk0OTfG0WS
	 sRAQ05C8tc5Xg==
Date: Thu, 13 Jun 2024 07:00:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, sagi@grimberg.me,
	paulmck@kernel.org, davidgow@google.com, akpm@linux-foundation.org,
	venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <ZmrteDHF_HlWHFth@kbusch-mbp>
References: <20240612155135.3060667-1-kbusch@meta.com>
 <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
 <20240613081016.GA21500@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613081016.GA21500@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_060043_514435_AF37471D 
X-CRM114-Status: GOOD (  15.53  )
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

On Thu, Jun 13, 2024 at 10:10:16AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 13, 2024 at 10:26:11AM +0530, Nilay Shroff wrote:
> > I am wondering whether we really need the _rcu version of list_cut here?
> > I think that @head could point to an _rcu protected list and that's true 
> > for this patch. So there might be concurrent readers accessing @head using
> > _rcu list-traversal primitives, such as list_for_each_entry_rcu().
> 
> Yes, I can't see how this works for a RCU lists without very careful
> memory ordering.
> 
> Btw, another thing - the old vs new list ordering is reversed vs
> list_splice*, which is a bit confusing (as are the parameter names
> both for list_splice* and this new helper).  Can you switch them
> around to match?

The parameters follow the existing conventions from list_cut_back and
list_cut_position. Those functions cut off from the head to the "entry",
and this one cuts off the "entry" to the tail instead.

