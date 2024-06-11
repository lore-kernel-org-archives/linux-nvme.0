Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E10C27C65
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 17:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fM9kmqNv6HYEcFettkFGiP5SSKrKkpmQb9dkPDv0LC8=; b=smGNZYwPCYB6uKALEJCXy6rXFS
	EEVAzS9WqwIiGf445ziSxpdvy63UCp+kW0eo1xrga2nSpqbeeeqc5ZOYzaKV4fQHnyUYTv9zl8nwi
	0ityj9Utc5YyrGX2gVbfG+1Mex7F403FgFOx+1S13MxrI3AtnFYqdeMrGLwa//csd6u6R290uh7w3
	NXMyTKND9EZutAr0jzuTnyRiaFrsbUOOF6bWxCy1B/PELpcaAsOo0YproIc3ZpRkcAJ8SS3afkwLC
	vvFnaTIaFaXniq/Te+zRRDEwr1i1Hw/PMJJXF97xv6Is6tdU7U33BwyaLwyhDm0wqs9kcMJGq96aF
	rOizTjnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH5Dn-00000009elD-2nt7;
	Tue, 11 Jun 2024 17:23:47 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH5Dk-00000009ekN-2Tjr
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 17:23:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A01AECE1712;
	Tue, 11 Jun 2024 17:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E8EC2BD10;
	Tue, 11 Jun 2024 17:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718126621;
	bh=yCAAL+k9DoPynPR+tH6ZSPC6rw4+MiOX/GQsLpF8lxM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XEB+/NsrE8V724cmb8hxT1FvXdOjfGerGNrt2/DYQtmc+OHeYXE8D5SlqgEZHDEcF
	 uODrXlmI6b7nSjEjl1lLDYny84I1Dhhs8utJJWJIyXRxvxZ9/gBrs7lYYiyC+fJ7g1
	 00r/wBAWj2i8jSA8geVhit/7oygk+ryALA8c+ZJCiBfc4XvI/BMguEbH+5vKZ/CpH/
	 rUnN5n2NKOTZEqZTvLnuBjCTE+0SS0uW+SafBBx4cluOQhYG4GTjb+OwpaSCrVZJq4
	 WlX7rYgt6OSciASb9OhoIwL5T4TQlkPlhLqAqT9kI1QTccY4p7LQHi/GUu4vTg37m1
	 quRC/+3xBrMJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7E685CE0991; Tue, 11 Jun 2024 10:23:41 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:23:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	rcu@vger.kernel.org
Subject: Re: [PATCH] nvme: fix namespace removal list
Message-ID: <25b3622f-81e4-403b-8d76-4f67fe8b001e@paulmck-laptop>
References: <20240611152055.2317197-1-kbusch@meta.com>
 <20240611163955.GA12787@lst.de>
 <f93a4963-f524-4ca3-9046-28bc65408721@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f93a4963-f524-4ca3-9046-28bc65408721@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_102344_855615_2832983C 
X-CRM114-Status: GOOD (  19.05  )
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
Reply-To: paulmck@kernel.org
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 11, 2024 at 10:40:13PM +0530, Nilay Shroff wrote:
> 
> 
> On 6/11/24 22:09, Christoph Hellwig wrote:
> > On Tue, Jun 11, 2024 at 08:20:55AM -0700, Keith Busch wrote:
> >>  	mutex_lock(&ctrl->namespaces_lock);
> >>  	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
> >> -		if (ns->head->ns_id > nsid)
> >> -			list_splice_init_rcu(&ns->list, &rm_list,
> >> -					     synchronize_rcu);
> >> +		if (ns->head->ns_id > nsid) {
> >> +			list_del_rcu(&ns->list);
> >> +			list_add_tail_rcu(&ns->list, &rm_list);
> >> +		}
> > 
> > Is this actually valid for a (S)RCU protected list?  If the entry gets
> > added to the new list before the grace period has completed, we could
> > trick a concurrent traversal into following the new list unless I'm
> > mistaken (although chances I'm mistaken on RCU corner cases aren't that
> > low..).
> > 
> > 
> I think we need synchronize_srcu() before we add deleted ns to rm_list.

After we delete it, but yes.

There will also be a window during which the element is not in either
list, but given the name "rm_list", I am guessing that this is OK.  ;-)

							Thanx, Paul

