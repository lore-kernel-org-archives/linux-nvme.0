Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210D3E69186
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 18:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xpo2jSbfwbr085Snd3Nd1DbuPpKtWjz4UxD/r1shEfM=; b=AQl8zchvlCoGY2WBP+pKIyyUvU
	3RSrDBE7y8uPDtpmVpGKg0h6f39wX6F1L8bkLk4RuB6GOrABdtccGQa1go3yA0F3gT4IcHIWACozq
	NEmooYSor2jCmNVhpJcTHUyPBHMm/qEu04qkeAYGSejcmeJ4mQBNfQ5eFG9PpTcs+o5y/AbdHVvr1
	7neijPz6ZxjFj8gmUKlVsVJwWwYIulT/l/NlPXFxyGE21dtqSDyRkiTM7y3cB4/plixE8nAlBHUCe
	eYRfZayetOZ98V45+A6jLTmzEAgQubhoJeLBny2BZvJUUSuURYq4uFecl2UhgAQN2YDlWynpwFqFQ
	4i/3u2dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEYBQ-0000000358N-43zv;
	Fri, 22 Nov 2024 18:15:08 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEYBO-0000000357u-2cuD
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 18:15:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1FD9BA417F3;
	Fri, 22 Nov 2024 18:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC044C4CECE;
	Fri, 22 Nov 2024 18:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732299305;
	bh=K0CAlhnJ5SZfILytcXhLCNfvd1kiKa3mksTYctF5DE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLBqbsxyAsBozEY8O1PWN4ym/UHU8cK5JAxpV3v8Q4Hyap7GqsEViY36EVLCvDMwD
	 ah0/RZdPNMy86QYKRNQJOILfYwUEAF7CYJdiV8eOgPtqUcHITw2gerJ/5vOJARHu7G
	 rfF6K3RkqXomdfrvy++wrWkLIJCU8GTD4En2f0UGTYsJk08u7/S+kbwGIwL7PAjE2K
	 wrpxyIAOqkzIP+Fm2+5tRL7pvngd8RwNSGlzta2Uz/NQhnT51F0aL+ruxZLlk1i/Kj
	 rFrSNqsWJEO59tCX0+UE51tcGxY05tDND176fe2zBKiosYLDAsGX1jAD+He+aHv/Q0
	 51a1Tsc5abQQA==
Date: Fri, 22 Nov 2024 11:15:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Bryan Gurney <bgurney@redhat.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, axboe@kernel.dk, mpe@ellerman.id.au,
	naveen@kernel.org, maddy@linux.ibm.com, kernel@xen0n.name,
	bmarzins@redhat.com
Subject: Re: [PATCH 1/1] nvme: always enable multipath
Message-ID: <Z0DKJWjtrpuy8j_V@kbusch-mbp.dhcp.thefacebook.com>
References: <20241121220321.40616-1-bgurney@redhat.com>
 <20241122120925.GA25817@lst.de>
 <Z0ClxgBJG_YBF-Ql@kbusch-mbp.dhcp.thefacebook.com>
 <a6902168-0a8e-43ff-afef-b100f75d266c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6902168-0a8e-43ff-afef-b100f75d266c@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_101506_732438_D69145AF 
X-CRM114-Status: GOOD (  24.70  )
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

On Fri, Nov 22, 2024 at 12:49:32PM -0500, John Meneghini wrote:
> On 11/22/24 10:39, Keith Busch wrote:
> > On Fri, Nov 22, 2024 at 01:09:25PM +0100, Christoph Hellwig wrote:
> So you're saying you want to keep CONFIG_NVME_MULTIPATH and simply remove
> the modparam nvme_core.multipath? (I know I said we were going to do that
> but that's before Bryan and I started testing his changes with blktests. I
> think we can fix that.)
> 
> The problem with this solution is: when you build a kernel with
> CONFIG_NVME_MULTIPATH=n you get exactly the same thing as
> CONFIG_NVME_MULTIPATH=y with nvme_core.multipath=n. You get a separate
> /dev/nvmeNN entry for every namespace/controller path, minus the multipath.c
> code.
> 
> So, I don't see the point. If you really want to stop supporting user space
> multi-path solutions like DMMP with nvme we need to stop creating multiple
> dev entries for multi-path controllers, no matter what.
> 
> Note that this multi-pathing stuff is a part of the confusion in UDEV, like
> I spoke about at ALPPS this year. One reason why the /dev/disk/by-path
> symlinks are so broken is because the kernel has at least three different
> ways to configure multi-pathing support for nvme devices.
> 
> We've been saying we're going to do this since since v5.18.
> 
> So how do we want to do this?
> 
> -
> -		if (!multipath) {
> -			dev_warn(ctrl->device,
> -				"Found shared namespace %d, but multipathing not supported.\n",
> -				info->nsid);
> -			dev_warn_once(ctrl->device,
> -				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
> -		}

If you want to change the driver to prevent exposing subsequent
namepsace path block devices when multipath is not enabled, that is
probably fine.

