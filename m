Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BA9606A31D
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vguz6ZOP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=q5VnxomoF1wwdUUX+topRNCAwwXCug5S276p5bOI98s=; b=vguz6ZOPcLjfcC7wfIlQwQuu0s
	w0zldPVy+y7evuGRSZjqQqihTbLtMUH+EduCLChcsXz/QpGjrGdDKGYKPh3uL/t/p5lNPdmF4YEjM
	q0udIit7FV4JxJGJrYe+I0irbpJgkj/PP36FfxYaGfl84RpfRwPruo7mvxJcpCP0Sy1l8A5FlJL4d
	hyMTrVuarx7OZwlsMGv6B3C0uePAqHBHTkcB1izsX5+sGctgcYx4TU8GThCQnbq7NbyTkhKCozMgL
	UUwEmgpk2AD9eIVKBG4Y9GCUEaaRbWQAZibIB3Wq3KZH8xdw2/iTSuWH+GdukCt/4+tt9Xdr1ouwp
	cPJHrCEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5hi-00000007Pop-067Q;
	Wed, 28 Oct 2026 15:36:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5hf-00000007Pn0-2DiW
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 15:36:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D2FA868BFE; Wed, 28 Oct 2026 16:36:35 +0100 (CET)
Date: Wed, 28 Oct 2026 16:36:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Martin George <martinus.gpy@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	kbusch@kernel.org, sagi@grimberg.me
Subject: Re: [PATCH] nvme: add nvme_is_disc_subsys() helper
Message-ID: <20261028153635.GB18772@lst.de>
References: <20261022073144.5239-1-marting@netapp.com> <20261028145818.GC15112@lst.de> <7652b5deb5e947f6dfc40f46e9e05db472183b8d.camel@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7652b5deb5e947f6dfc40f46e9e05db472183b8d.camel@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_083639_752367_4D4FFB08 
X-CRM114-Status: GOOD (  12.66  )
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

On Wed, Oct 28, 2026 at 09:04:03PM +0530, Martin George wrote:
> No bigger plans - it's just a small cleanup. Mainly two things:
> 
> - Consistency with the target, which already has something similar
> - It folds the open-coded discovery subtype checks into one self-
> documenting helper for current & future use.
> 
> So a minor net improvement rather than a prerequisite for anything.

Not sure a helper is more self-documenting than a field check.

I don't really care strongly, but this feels a bit like churn without
a real purpose to me.


