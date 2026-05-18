Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82674CD343F
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 21:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B+rmSHdIPdeug5qRLJRDMAIugwCK3bIGeOPxEOwXk9o=; b=MTtZNPnEKaEiJfejP5Z69oMQe/
	UfV8kOkoM1k6YQjvHQUfQCc1bLzo38H4tSKev9fH2VgL9+tZaaFyLNjAF/iis1T3mivqAfQlYZb8y
	KQu/6yCh9gARdtNcURACLIWk+G6hColY2+HQ9o7mYPDz8MR7SbFJfv3gRxKIc0sFUF0qVA49a1rXx
	LLaVvm2Dobzyz7IRHerlNjDhj/0lxNspIOAl0F9rhXNIq6CY8EIx9jEybRgLflB5OzHKNKISFMpYY
	5Uyw7FmSbZnpfRBAJFZk6uGuDsy7+NWwzFVKDQ5JtS33FupVSCetrI9eDQHN+9SFGduAs1llUecqj
	LqwXuPPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP5sd-0000000H2bW-3MAy;
	Mon, 18 May 2026 21:52:07 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP5sa-0000000H2ax-4Art
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 21:52:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 66F4E4353A;
	Mon, 18 May 2026 21:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18B6C2BCB7;
	Mon, 18 May 2026 21:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779141124;
	bh=B+rmSHdIPdeug5qRLJRDMAIugwCK3bIGeOPxEOwXk9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vkjf8FmfZnGE3WYJOznYFtF73/GemvAXzS/awb4nmgxtd8qk4yUmQG1mePeh+5tD8
	 9JczKUSxAcjrIiyxnMDm8y8OoJ3Dgfov+Cq8bDplIvixCIAAHdCcxWL0Y1gTZ5CRkS
	 qHZ2NskAgx4kqMOpLiVZZ0zAj0+4vU/cro6TyayaK9FEP5oHmC3W9BaPNhu7/zvsJT
	 JP+EWgCP9cCZ9G1MCPykXNCcc748Cg2dHTFzjCbUExPA6dS9MsnQvnLnFZNNKc7DOr
	 PySbklQl7ESdb2fvQkSi7xfmnij4+Z9TA4obcCLeT5flgyjMyKRWbE4wsR2HRZd58s
	 yPFpOmF3NE2LA==
Date: Mon, 18 May 2026 15:52:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Message-ID: <aguKAgkCUOVL2pVk@kbusch-mbp>
References: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
 <agtnJb5a5uIqH-65@kbusch-mbp>
 <MW5PR19MB5484B015B6B1D739D8C5CA2FFD032@MW5PR19MB5484.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR19MB5484B015B6B1D739D8C5CA2FFD032@MW5PR19MB5484.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_145205_055429_C8EFD168 
X-CRM114-Status: GOOD (  16.94  )
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

On Mon, May 18, 2026 at 08:59:09PM +0000, Achkinazi, Igor wrote:
> - submit_bio_noacct_nocheck is block-internal and not exported, so using it
> from NVMe would require a block-layer API change just for this.

That is not a valid reason to not do this. We often export and unexport
APIs as needs evolve. I'm not saying you have to use this API, but I'm
just not yet seeing why we shouldn't.

> - it bypasses more checks than I see we need here (throttling, RO, crypto,
> op-type), I prefer bypassing only the EOD check.

I do not think we need any of those on the hidden device either. The
stacked limits should have caught any problems or handled any policy on
the first pass.

Though I am aware of certain limit checks that go through here are not
done under the queue's entered reference count so there's some racy
things possible, but that's a pre-existing issue and doing
submit_bio_noacct a 2nd time doesn't help.

> - BIO_REMAPPED propagates to split clones, so it covers all resubmissions,
> not just the initial one.

Submitting split clones already uses submit_bio_noacct_nocheck() so the
BIO_REMAPPED flag doesn't come into play there either.

And BIO_REMAPPED applies to when the bio's bd_part is a partition. The
multipath layer overrides the block device with the part0 of the path,
so there is no partition (and we may not have been dealing with a
partition in first place), so this patch is introducing a new implicit
expectation on what this flag means. Consider a real failover going
through the requeue_list using the submit_bio_noacct() again. If you've
already set BIO_REMAPPED, then it skips the checks, but that could have
happened across a controller format change that modified all the limits,
so you probably want the eod checks to happen again on this scenario.
Your suggestion would skip it because you're using BIO_REMAPPED as a
proxy to skip "eod" checks.

