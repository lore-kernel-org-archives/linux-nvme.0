Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305F1CD4F26
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 06:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m5C5GfdX00Qjjz4jMmdy+P+tUl2oNiWnEGW8eGBROoI=; b=AARgu6tIAhlz2XqcdLwN4JScwt
	gKqHpOwZlqEorEYGhw4YdZaujd7JcLCqn2wxI1Pz2M93oDb6RxHfvXHk7Pr+AlvfBVehgUzBrSkZP
	Y6izlRgwvPRvnPvsGh1nItpogKpHW/s7G3480RLs3aOTdkBTpRxf9nW3ss+rVAmPFRMIxOZk5Aa/r
	/taFfvoS1aW9quixd1V3KeiPZq6ilikgfHOasZTgg6S6lhzxB+jISE3H7Wgxu1ayGxD/ZB6s2h5h4
	93OqPC3UvjqBRfeH6Bj5U/M55Hqsy4CXyMONmUxPWZ23isLkAj069TDsUajX/mqflCgULr6m4wFKe
	F0SSMCAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0MP-0000000AcfM-3RzI;
	Fri, 26 Jun 2026 06:48:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0MN-0000000AceJ-2YIK
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 06:48:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C8C5968B05; Fri, 26 Jun 2026 08:48:16 +0200 (CEST)
Date: Fri, 26 Jun 2026 08:48:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com
Subject: Re: [PATCHv2 12/17] nvme: add Clang context annotations for
 nvme_queue::cq_poll_lock
Message-ID: <20260626064816.GB11106@lst.de>
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-13-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614131541.2017845-13-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_234819_796931_E5304A44 
X-CRM114-Status: GOOD (  14.18  )
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

On Sun, Jun 14, 2026 at 06:45:27PM +0530, Nilay Shroff wrote:
> nvme_queue::cqes, nvme_queue::cq_head, and nvme_queue::cq_phase are
> protected by nvme_queue::cq_poll_lock. Annotate these fields with
> __guarded_by(&cq_poll_lock) and annotate helpers accessing them with
> __must_hold(&cq_poll_lock) so that Clang's context analysis can
> validate the locking requirements.
> 
> IRQ-based queues do not use cq_poll_lock and instead rely on interrupt
> serialization. Annotate nvme_irq() and nvme_irq_check() with
> __context_unsafe() to suppress the corresponding context analysis
> warnings.
> 
> nvme_poll() invokes nvme_cqe_pending() as a lockless fast-path check
> before acquiring cq_poll_lock. This check is intentionally kept outside
> the lock because nvme_poll() may be called repeatedly in a tight polling
> loop until completions are found. The result is only advisory, as the
> completion queue is subsequently revalidated under cq_poll_lock by
> nvme_poll_cq(). Suppress the corresponding context analysis warning by
> annotating the lockless invocation of nvme_cqe_pending() with
> context_unsafe().

I'm not sure the annotation really buys us anything in this form,
as it makes bold claims about a guard and then ignores it for the
most common case.


