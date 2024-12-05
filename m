Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D44E7716D
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2024 16:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qHbt6i7sIj9lEgVqMUqviAxxWrrLlv3dHEiQeqADFUE=; b=fFWfFfoJbyGcTs91huCV/UA8ik
	3OjhQldrC7ySzKQ9PnQIHKPHLM9JkKiCs7jf7pxYWrkkX6AssX3fDbbB1vx5wv1cqaX/vxgxY110z
	ZPMKj8YGAltMP1beRxGjaJkTYhnPZzhi2N6fKhuRKLbTdmAjPBXBoDs0JOEUZAxSkNHSBMrG2iXpT
	F0wnJ44a4o02OZYhOkDNdRGqmbORbYYfPEAcTRvqFeisFxdZ3IWa3gLIfWbxSBjPN962mJvgSbI8J
	i4tKNvGzi+tTHRIJrXYmH4RwNc28Iu3RxhhZSJ27O+hH/TXATOii6MlsFALLH6uDRPHc1Fm/Ajua8
	CPHXFa6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJEVd-0000000Giao-0V0S;
	Thu, 05 Dec 2024 16:15:21 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJEVZ-0000000GiZv-1KHY
	for linux-nvme@lists.infradead.org;
	Thu, 05 Dec 2024 16:15:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 60498A43E21;
	Thu,  5 Dec 2024 16:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C8AC4CED1;
	Thu,  5 Dec 2024 16:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733415316;
	bh=HF+1sMiMajnemMiLzX29jkgBLA1ZxMXE3AmNyQ5mEgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5T3zabhX9hfwgP7Ta5mjbt9F3RHeIgQP5RuAGithbW9YgR5E93VHkOVf/fuKzH5m
	 xAPik6JEaO14qY8IbE66LxVxztJzJGTvUb7duadJR5KfSY6+7vz03bf1pay5UE9JTK
	 WmLVmq8OP7Yw2H1ujR2y60mwW3IF2GZXGAzcen7Q75i8RWGwxE0fVbH/YtmBrr5jE9
	 y50MPntGScFfeA4RbrriDfmOLqBMg1wGWIXqqVt+elMxNhUsnhstYbo87XTPsZupaA
	 5i/oA4L4duGioiW8v4BelDetxfDg5hCkqNvoD7hVjPvvEw4cfr7MrMc9AXsNHza4O/
	 7mtdJ5tBi9TFQ==
Date: Thu, 5 Dec 2024 08:15:12 -0800
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Remove namespace when nvme_identify_ns_descs()
 failed
Message-ID: <Z1HRkKr5LhfvfLAs@kbusch-mbp.dhcp.thefacebook.com>
References: <20241129140608.115282-1-hare@kernel.org>
 <Z09Y30pUtAg0xwoR@kbusch-mbp>
 <4ba05af4-9464-4cdf-a306-60585793c46e@suse.de>
 <Z1CF2vn1_xkNIVAM@kbusch-mbp>
 <99025917-e201-4ec9-ba04-e979f61c411b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99025917-e201-4ec9-ba04-e979f61c411b@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_081517_414186_C0F2B7CD 
X-CRM114-Status: GOOD (  17.13  )
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

On Thu, Dec 05, 2024 at 01:30:39PM +0100, Hannes Reinecke wrote:
> On 12/4/24 17:39, Keith Busch wrote:
> > > 1) AEN triggers a rescan
> > > 2) List of active namespace is retrieved
> > > -> NSID A gets unmapped (or moved to another node in the cluster)
> > > 3) Scan of NSID A returns an error with DNR set.
> > > Without this patch we keep the namespace around, so eventually we'll
> > > trip over the 'non-matching UUID' check once the NSID is reused.
> > 
> > I'm still not sure that makes sense. The target shouldn't attach the new
> > namespace until the host acknowledges the removal of the older NSID via
> > the Namespace Change List log. Until the log is read, the inventory for
> > removed namespaces should be latched. Otherwise, timing might remove+add
> > a specific NSID before the host requests the NS Descriptor for the
> > racing removal, then it would just get the "non-matching UUID" issue
> > anyway.
> 
> But we read the Namespace Change List log in step 2)
> (Not that we're doing anything with it, but that's another story...)
> Hmm?

Indeed. So maybe we should just move the log page retrevial *after* we
scan the identify active namespace list processing?

