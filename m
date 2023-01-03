Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939BAC3DA7D
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jan 2023 20:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5HKjkaCDWTxJ2ZSpLB1t5GCxUa69y3dlrc7HL0Krd3E=; b=LatLd8DRf6xMwnwcIrj4SSwbCq
	B1tPUHCMeglWE+E/wBpGoKURmfnTt2Oj4j/CkCBvRLi/JNhGC1cM08dYy6onr0UelWIxYfh7+N0rC
	eMuCnOI2M6Sj4XwqjxWL7R7+8URq6KZIVlKKEHAxcS5AK7M/3hpIOO4oWJ+VJzXdCYODCt1ZMgWIv
	jz88bell2w2E4D0G4D5dUte3ah+0wHN7yAUf0I2AwNKVmZFBPfuWwcGpQZzZezGGV0ymbNQtFtws9
	XiGt7Jo63URbhvsj5+O3B56wLSDIQxABmekxJjqQPNgqg7AXt8U5zgKRf5KiatN6KiT3SYG0gCN+l
	5C8p3a9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCnSj-004d1o-BG; Tue, 03 Jan 2023 20:00:41 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCkQG-0033tp-6i
	for linux-nvme@lists.infradead.org; Tue, 03 Jan 2023 16:45:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 731606147A;
	Tue,  3 Jan 2023 16:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6259AC433F0;
	Tue,  3 Jan 2023 16:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672764351;
	bh=1vdMMNpejnZ5jZ3YE/7JRh8HEouk94oxAG3PB5o2MWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eXjsmcxfbxFnI1FMUosFhzfU7Aqfkdz7TdQVGMVwY6mHV2+ybfnyibuldgLrnQ4rl
	 AFPOLWBkOWDeyvQ91BwtloEJe8TJV1N+VLlZUkS4Fl61YpAJkdA1yBYcyDyxbP+QAy
	 Nn3LS4VTFDfL0iIVz8VyiRAcqJYErGr2bB/dPpEZVtyDkLO/0S4F5sg1G4NCq0CdQ4
	 xdaYNT/42r8As9jzp+jo7inEb+CGiX2wiAmSXatoVDIEHtZuWTQP2PiVCVpdQFwPPe
	 qsJIGL1+nFOMqVTglOExqLal3i9bMutOUjyE3uLmNBNdU3GDOvr1pkx32Y1D9t+xz9
	 IGF822YnqgOaw==
Date: Tue, 3 Jan 2023 09:45:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@fb.com>, Hugh Dickins <hughd@google.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/4] nvme-pci: update sqsize when adjusting the queue
 depth
Message-ID: <Y7RbvL59oRvO73P0@kbusch-mbp.dhcp.thefacebook.com>
References: <20221225103234.226794-1-hch@lst.de>
 <20221225103234.226794-3-hch@lst.de>
 <f0d3c027-d793-8266-7c69-30a85f884b23@grimberg.me>
 <20221228161050.GA849@lst.de>
 <c1f876cb-5004-c91e-398c-83fb007bb697@grimberg.me>
 <Y63BjxIJykWWTzOP@kbusch-mbp.dhcp.thefacebook.com>
 <bffad1f9-f379-b5f4-8d37-304edd2ba38c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bffad1f9-f379-b5f4-8d37-304edd2ba38c@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_084556_465188_7644043E 
X-CRM114-Status: GOOD (  27.33  )
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

On Mon, Jan 02, 2023 at 11:39:35AM +0200, Sagi Grimberg wrote:
> 
> > > > > But if you want to patches 1+2 to be taken before 3+4, I'd make sqsize
> > > > > to be a 0's based value of q_depth after we subtract one entry for queue
> > > > > wraparound. So others would not get affected from patches 1+2. Then in
> > > > > one batch make all assignments to sqsize 1's based like in patch 3 and
> > > > > change nvme_alloc_io_tagset at the same time.
> > > > 
> > > > 1 doe not make any difference in the 0s based vs not values,
> > > > they just reduce the queue size by 1 intentionally.
> > > 
> > > Not sure who is they here...
> > > 
> > > Anyways, I guess we'll have to wait and see if someone happens to care
> > > if his/hers effective queuing is reduced by 1 all of a sudden...
> > 
> > All nvme transports require the host driver leave one queue entry unused.
> > The driver was not spec compliant prior to patches 1 and 2. I'm not sure
> > if that "queue full" definition makes sense for fabrics lacking a shared
> > ring, but the spec says we have to work that way.
> 
> fabrics already reserves one entry for a connect cmd, so effectively it
> was reserving a slot already...

nvmf_connect_io_queue() sets the cmd.connect.sqsize to ctrl->sqsize, so
doing a +1 on that value for the tagset is definitely not right. A spec
complaint target should have been halting and setting CSTS.CFS if we
actually used all tags.

