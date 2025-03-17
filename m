Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504B0C282EC
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Mar 2025 18:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=coZ1cGJujs8pbYgKV4LzaGv6BeePaoCtUKC2Vs36dr8=; b=Pi05N/ssKGUqdIKcslJTSrnW2g
	hVsHnEodUKWxh/uIMFEYHLUO0qA4ridPXIMkS4Y5yk/5+36sVh1TLpwTTtnoIjnSOqlHHM+LfzR49
	MDqKK4TozUx//bzq64IrHb8ERVMQhjW078Y9ryt7GbpAXH4se+k6L5QMyVyWpqYY44pnleo3CpJHy
	8SwKZxFBf0jZ0m+UPgVwqtrW056spmYgz5jZmfl8xjCG40oF3dsp0ZM3os4BfDrK0wTyUWqexjkke
	C+ngcGdM8O8WWq2DIDYdYrMTE8KVe5PXZ7yoNCqXP+mOAlumbW7bWjrx/10+IPF3BmBzRd6PuZxZy
	QPlwyZFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuEv2-00000003e3h-21yc;
	Mon, 17 Mar 2025 18:10:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuElB-00000003cdB-3knt
	for linux-nvme@lists.infradead.org;
	Mon, 17 Mar 2025 18:00:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5702D5C566A;
	Mon, 17 Mar 2025 17:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5675DC4CEEE;
	Mon, 17 Mar 2025 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742234420;
	bh=EcZtPtzu8REfqQJkX/KH4pfuoWeHznxmJu2fk/3OhFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nlETLpx5ZVazICSyF9/NwKMTg8lm727346FXmrTN6KuzEIkSArgRID9HyJ5kBVvLF
	 ifSwTwRgZ5qCZ6l1Y8gaFFtJ4dPpE4ljdB41Lav4BAieuULEH/+akvy0Hs4nAHdlza
	 P5uaJSSRUqIHYuuIYbKKzYxIkRFJ659TWxHy9rAqkWMghnh0rqOJt6HAXVr6Py03bK
	 osOQkDj9tN2WI/VxQGrbidg9vNre08b5aTtBJqm/EYN7cT34BcL6ZbIFaJiXeBDwZy
	 JoP91JtEOr5TYSK5YJwY10XQCqulIwNbHcUIU//5BSatX1jzOdD5d0O5pyfwU42HiT
	 4/uTlrqqruduQ==
Date: Mon, 17 Mar 2025 12:00:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, loberman@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH 2/4] nvme-multipath: add the NVME_MULTIPATH_PARAM config
 option
Message-ID: <Z9hjMtuyd6Y0FJPy@kbusch-mbp.dhcp.thefacebook.com>
References: <20250228032541.369804-1-jmeneghi@redhat.com>
 <20250228032541.369804-3-jmeneghi@redhat.com>
 <20250305143353.GB18526@lst.de>
 <03e7cc64-fafd-405e-a07a-4bc6d0e1d743@redhat.com>
 <20250312051958.GA11824@lst.de>
 <cd731f6e-c0e0-4ea7-9012-5860b0be2920@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd731f6e-c0e0-4ea7-9012-5860b0be2920@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250317_110021_976455_E9E7606D 
X-CRM114-Status: GOOD (  16.10  )
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

On Thu, Mar 13, 2025 at 05:46:25PM -0400, John Meneghini wrote:
> Our RHEL customers do this all of the time to enable DMMP with their NVMe devices. This has caused tremendous
> confusion and turmoil with our RHEL customers who keep on turning nvme-multipath off even when we ship
> RHEL with nvme-multipath on and we tell them turning it off is not supported.
> 
> I finally decided that there is no good way to control this situation w/out removing the
> core.nvme_multipath parameter while CONFIG_NVME_MULTIPATH is enabled.
> 
> This patch enables distros like RHEL simply config out the parameter w/out impacting all of the people out
> there who currently want and use the run time switch when CONFIG_NVME_MULTIPATH is enabled.
> 
> Please let me know what I need to do to make these patches less confusing and get them accepted upstream.

It'd be one thing if it was just me lamenting the loss of the parameter,
but Hannes has customers with a very real and obvious use case for it,
even if Christoph hasn't encountered many (or any?) devices that fall
into that trap. So, from my perspective, I really think pcie hotplug
handling needs to be sorted out before we can just force these to
subscribe to the native mulitpath virtual device hierarchy.

In the meantime, I know RHEL has done out of tree patches for many
reasons, so it shouldn't be a big deal to change the module_param type
from "bool" to "bool_enable_only" in your kernel releases.

