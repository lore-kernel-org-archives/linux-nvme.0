Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C1BC36010
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Apr 2025 06:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YMekKnDz8VRuzqvaKAyBnnPgfuWjDhU9TPX8jpgBIG0=; b=I5i44YBaG5LGm7y2vkrpj1mIDO
	L8z8AU/lsQ33QCwuaS7kqFZX6kuq/u8g87E0juJ4YGbkXpkmE5NPs6AleKxE+bZBsSqz24hJeOFLT
	RNitpqsKtG19Z6dSWFE7gi8pB4pfPVIJBXs3a/B8a9SiTmTZM381lXjK+SpLJmma0eevSOYCUpyK0
	TVusKwKFm7CfU/egdkawbkXo89nrMeOTLrR4KpAfhIK5LktFbVXueyszOgRgeK/aEWdhHRj28DxAZ
	iy6uJtgwMYUiPoCAJIk1dTSYgKD1700qgrTACjEqogJGMzzGy1RvWDmNdJxkgj0AxIq8NgPjvqIUa
	eP8pcl/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0aQp-0000000Arcn-0mWE;
	Fri, 04 Apr 2025 06:21:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0aQl-0000000Arbl-49Mk
	for linux-nvme@lists.infradead.org;
	Fri, 04 Apr 2025 06:21:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 62E8A68B05; Fri,  4 Apr 2025 08:21:26 +0200 (CEST)
Date: Fri, 4 Apr 2025 08:21:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH 1/2] nvmet: make 'readonly' setting configurable
Message-ID: <20250404062126.GB31468@lst.de>
References: <20250403144747.43043-1-hare@kernel.org> <20250403144747.43043-2-hare@kernel.org> <Z-6s9_rE-qAmhn8w@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-6s9_rE-qAmhn8w@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_232132_169651_C999C1A6 
X-CRM114-Status: GOOD (  15.93  )
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

On Thu, Apr 03, 2025 at 09:44:55AM -0600, Keith Busch wrote:
> > +	mutex_lock(&ns->subsys->lock);
> > +	if (ns->enabled) {
> > +		pr_err("the ns:%d is already enabled.\n", ns->nsid);
> > +		mutex_unlock(&ns->subsys->lock);
> > +		return -EINVAL;
> > +	}
> > +	ns->readonly = val;
> > +	mutex_unlock(&ns->subsys->lock);
> 
> Not sure how people feel about the "cleanup" constructs. If we're okay
> using them in this driver, this is a simple use case for the guard to
> manage the mutex:
> 
> 	guard(mutex)(&ns->subsys->lock);
> 
> And then you don't need to worry about unlocking.

I really hate it with passion as the syntax is so butt ugly and has
no explicit unlock point.  Why couldn't folks at least do the simple
python thing:

	with (mutex(&ns->subsys->lock)) {
		if (ns->enabled) {
			pr_err("the ns:%d is already enabled.\n",
					ns->nsid);
			mutex_unlock(&ns->subsys->lock);
			return -EINVAL;
		}
		ns->readonly = val;
	}

> 
> > +	return count;
> > +}
---end quoted text---

