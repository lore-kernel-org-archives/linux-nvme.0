Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4848EC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 17:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P9omg3kbyNV6KO4Xi9/PVFzp8/bAHAr1649EeWBi8ss=; b=MvtZQYBb3zcBsbPgusDR0JE1x4
	HRaeKdFQdU0hBWXwmNr0KEjSJHrGTP89nG3+nc6LGTFi7GhYoLrqH2bZMXRmOtAFOyIKYHTrPAujc
	nhitVGSJtX8rVFGr5VsrNzXGu0bk7sG885EgPskx6K3R5SctO9WcgybBUUowg5iwNZPVRYc6mDgGA
	m6hNZWuaIdFgw+PsCNDs6iqFqCBkzzeqI+5aC3gDXzfkWFf/x5cTRBHmD9T4/z1d3O9KXdQMnwylQ
	o1ov+bnHGUkiQ7k8JuZmVNwzDK2i7kAdJnrC0+XfEbeEpMrqMcLVs0luiCnbZr4lcQBCq1Br0Rgc8
	eVAA8LMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHSCf-0000000DdcJ-10EB;
	Wed, 12 Jun 2024 17:56:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHSCb-0000000DdbN-49vK
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 17:56:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5FC00614ED;
	Wed, 12 Jun 2024 17:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC1DC116B1;
	Wed, 12 Jun 2024 17:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718214965;
	bh=0d3+8+g7aWZezvgdfFmThFuo2jtRpJQdl8ZLC5g3Y7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVz/WX+KRiZiPVK3fU9zJaZupB95U7vjI6X8lE5M6glMUw4C9NOgQVuBAAc+8X+eJ
	 7Fnc6ixmEcwJXeV2tLGSd+Fuf1qKaLgMBHW4tuVqyqz7yk2jRvtwEoqmZV8mNOmN83
	 XbsytBvSQ/wFpNVrUPo7mRCNQvleGb5/Dzw1sFbWzWHZgegln9gqFWB8zTYSr2Ybmh
	 7r8XHXIZbvbXfI6yacWM4O6P57dHRnrWzEEMHf1kiW3uLTqd0tBcr8hGfBQp7Tr4OA
	 g1FvX1jVjzmB1fjumPgmEkAEmAxpq4OXKZjAt1YN81tLkGHEi/D9UQNdzmox8Lg/Mq
	 +AXpo37/J2COQ==
Date: Wed, 12 Jun 2024 11:56:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: always initialize cqe.result
Message-ID: <ZmnhMkqt7xch_4e-@kbusch-mbp.dhcp.thefacebook.com>
References: <20240612-nvmet-always-init-v1-1-0c0fd94461f0@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612-nvmet-always-init-v1-1-0c0fd94461f0@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_105606_286281_3D1D43CF 
X-CRM114-Status: GOOD (  10.38  )
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

On Wed, Jun 12, 2024 at 04:11:59PM +0200, Daniel Wagner wrote:
> The spec doesn't mandate that the first two double words (aka results)
> for the command queue entry need to be set to 0 when they are not
> used (not specified). Though, the target implemention returns 0 for TCP
> and FC but not for RDMA.
> 
> Let's make RDMA behave the same and thus explicitly initializing the
> result field. This prevents leaking any data from the stack.

Thanks, applied to nvme-6.10.

