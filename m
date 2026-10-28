Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0424B606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fAdp31yc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2vyzf5A0er+7Hmo3+ITcOo7uz8WQpnBD1+/0/G+EeGY=; b=fAdp31yc2Zaqba3exSQZ9kuhlL
	KWOsjHQNuIS8wshdc+NIDtEoDqEb9dDiZ2wxbthduMxdB1ZHxo9lK7WY2s6Xu1h9g3nbI0IOWbAjU
	Fl8kKzIVDNFbTj1L2RrCoIy75hakq8DdIoGBPcUhpXcG93/lH3SAydPIyY0gvqWsPI/hjWuVibQ1t
	PdB/CskV8hSiHR0r5h/lfvfRm/fsuSFMNaR8BQKT1Z662PdJR04pVjmHWblwCZuSQwh9NQsgdnn+F
	ePyP2Qa6SG+0mczW+F7GUz626U31NBtRnRjfMzqsU+B9h/XkSwCPBthrVfP9geo6tnZjNaUlIOkaV
	kurRFYdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM566-00000007HAj-31kw;
	Wed, 28 Oct 2026 14:57:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM564-00000007H94-0rvD
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 14:57:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F0B8E68AFE; Wed, 28 Oct 2026 15:57:43 +0100 (CET)
Date: Wed, 28 Oct 2026 15:57:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-tcp: wait for in-flight TLS handshake callback
Message-ID: <20261028145743.GB15112@lst.de>
References: <20261022071934.3818224-1-thnkslprpt@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022071934.3818224-1-thnkslprpt@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_075748_395294_CFB0E564 
X-CRM114-Status: GOOD (  13.49  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 10:19:34AM +0300, Avi Weiss wrote:
> When nvme_tcp_start_tls() times out or is interrupted,
> tls_handshake_cancel() can return false after handshake_complete()
> marks the request completed, but before nvme_tcp_tls_done()
> finishes. Error cleanup can then release the queue while the
> callback still accesses it.
> 
> Wait for queue->tls_complete when cancellation loses, before
> continuing cleanup. Preserve the original timeout or signal error.

Plase take a look at the Sashiko complaint:

https://sashiko.dev/#/patchset/20261022071934.3818224-1-thnkslprpt%40gmail.com

it looks valid from a quick glance.


