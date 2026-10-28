Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631BD606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MBxo4W2f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XzELPpJ1ayib3r2VXK6Z5tEaAOFC83OU92UVC904QU4=; b=MBxo4W2fNwZHlYYNlq3VcvUAZQ
	uZdQhACriETMLNHNvOdwDhXz+4zcr/jJPSXI+kvYKtp1assyeEgWWczri13V9lh8LRMwk9pNF3/aa
	S3/2JWOrErVjF0J0ht4QJqEdSMLl98yuXKj3orGwYnIT6rA/XqS8VzUABhHz+CMEnBQFc6ZHfZoGq
	KQWh70wxPUgPJNJMIvY0dEW+erjKcyu8gbvnYDZ2XTMf4JHShW0jv76R7IfyToofWgg6jFYqxu3KP
	4A9nuRsSo9Ao1XQNpQpxzSgI+qwUkzzN+luL5wSVa1mWUIgQ9eTdvhPMFBzGPOoLAKJpuAkbCZ9+t
	ix7IDUGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM56e-00000007HFE-3aIX;
	Wed, 28 Oct 2026 14:58:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM56c-00000007HEt-1eB6
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 14:58:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D0AA768AFE; Wed, 28 Oct 2026 15:58:18 +0100 (CET)
Date: Wed, 28 Oct 2026 15:58:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Martin George <martinus.gpy@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, Martin George <marting@netapp.com>
Subject: Re: [PATCH] nvme: add nvme_is_disc_subsys() helper
Message-ID: <20261028145818.GC15112@lst.de>
References: <20261022073144.5239-1-marting@netapp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022073144.5239-1-marting@netapp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_075822_601591_269ACEC5 
X-CRM114-Status: GOOD (  11.94  )
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

On Thu, Oct 22, 2026 at 01:01:44PM +0530, Martin George wrote:
> Mirror the target's nvmet_is_disc_subsys() with a host-side
> nvme_is_disc_subsys() helper, and use it for the open-coded
> subtype == NVME_NQN_DISC checks in the host code to help
> maintain consistency and improve code readability.
> 
> And while here, fix an error message to refer to the subsystem
> rather than the controller.

Not going to NAK it, but the helper feels a bit pointless to me.
Do you have any bigger plans with it?


