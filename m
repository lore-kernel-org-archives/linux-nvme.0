Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9202C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 12:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3leyfFHik+SMJzzH7ImcKaEF42mh0jQVQXXEh3mNnuk=; b=hz5jspwOu4p4lC0jhFQwVbCoh6
	OFdcSJimryBdPoDRfvY7RBf/D1Ov65/amFkZvhSpi9rIo/+6F8rd3lrhWSnA6jtDR9JTUY9PrH1Q+
	Plih+jyWlUQCZaXZqI0NNCASXjiTOsrVpac7VNJa1LI26Y7KAOEPHSD0L4VL9RnmRyXRw1tPq9cTO
	xakROtLbrb0U7tjMF3XAbkLJ0KhoorA0aobjAMU0a7Rar4Ddj2BOrEjWA0lpb+jBI+SIPIYj3uH3g
	lBOxjFlIljmo0dpy2SSOTKSlockTGGWXoEkz1r3RK0dojgZRpVYM/jkB0MbCtO2xR4q2tTGe6ln6r
	jJ9SAguw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weBOI-0000000EbrV-28cl;
	Mon, 29 Jun 2026 12:47:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weBOF-0000000EbqT-3DCM
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 12:47:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C08A468B05; Mon, 29 Jun 2026 14:47:03 +0200 (CEST)
Date: Mon, 29 Jun 2026 14:47:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, bvanassche@acm.org, elver@google.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCHv2 07/17] nvme: add Clang context annotations for
 nvme_subsystem::lock
Message-ID: <20260629124703.GB23417@lst.de>
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-8-nilay@linux.ibm.com> <20260626064335.GG10731@lst.de> <0f3add6e-4e2c-4656-ad82-e86e18f6fcb7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f3add6e-4e2c-4656-ad82-e86e18f6fcb7@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_054708_129466_83838D2B 
X-CRM114-Status: GOOD (  16.72  )
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

On Fri, Jun 26, 2026 at 08:09:52PM +0530, Nilay Shroff wrote:
>>
> yes correct, but this one is tricky as the list has to be inited
> with non-zero value. Another way to fix this is by adding
> context_unsafe wrapper around INIT_LIST_HEAD(). Again overuse of
> those unsafe wrappers hinders readability.
>
> Would it make sense to introduce a helper, e.g. INIT_LIST_HEAD_UNSAFE(),
> that simply wraps INIT_LIST_HEAD() with context_unsafe()? It would document
> that this should only be used in cases where the caller knows the object
> has not yet been published and therefore no concurrent access is possible,
> such as during object initialization.

I'll leave that to Marco and other core people, but I think this
would be a lot better than the current version.


