Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3737EC4828F
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Feb 2024 10:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/HNW6CZgXXHsA80ADjLnhidXNGn3Kis5WgWYh/g8/iE=; b=yNjeW62snUQ97iGSHA7+F5R/WQ
	ghqBlOPytwHKI3HL4j0ibQbPAHfcEf5McPlZ6u8irhey0m2CLPCpi0PqsEOvzK12Rk4vK3d0KWlFL
	ZJ+ibjuRo64z+6CZOiplbjpyFtuPN9VzlqR19kjOVN2qygIMOboRwvD2zJbGbgZYhFzuQugYbyv9E
	EaInEBpZWUNBgJDmOQioDF5nduzqAfZo3FpslaCN1OfTATpEbUFej8/s98f4hjJKIt1AyF15DnEai
	sQf4f72dpTu96Xs653jP1kIfNJ7IYuOctRa/+Ig2PbLmz8eeyk20UiFpx2Fw0PCoElKLFfdP4RAJO
	FvCbZrKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWZue-00000000bnw-0mNN;
	Sun, 04 Feb 2024 10:39:48 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWZuc-00000000bnD-00yp
	for linux-nvme@lists.infradead.org;
	Sun, 04 Feb 2024 10:39:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 47F29CE0171;
	Sun,  4 Feb 2024 10:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182E9C433C7;
	Sun,  4 Feb 2024 10:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707043183;
	bh=iyoxJyYS1ovHgfgZClsPvcow6R3PPCC0we47Uz+xt0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0+vADoNlIEK5wCnNQUPTWplg8vqRoOQ4lErZPgwdFQHb6X028MomFpHeBXXxYqQW
	 ewbTxmEY40Ffr8SbpyQqvQCmf5eAb9Gbi2qIc0eqUyRdmKwkrS8K+EE12tFZpAgSDb
	 duK0oUTehJb7GDqCv+SeDW+buwKdH/1sxkFn49uTRHpkxRCJbWYINuL3Z3CeY/46GE
	 eANkCxw7ZyWaPDphTfuuQ6nme1uck+O3CAxa1n9lCCHqS2YFK309CEOXohK+ggkkZE
	 dtoZtoe8t+kA8hwH9jeFbG/l3ydjG65LLwk17sCIr5C9D1NAfZf7JwE8mtaSSU2pkO
	 qBHfhlIXCe33w==
Date: Sun, 4 Feb 2024 11:39:33 +0100
From: Mike Rapoport <rppt@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Reclaiming & documenting page flags
Message-ID: <Zb9pZTmyb0lPMQs8@kernel.org>
References: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240204_023946_323089_97EBDB9E 
X-CRM114-Status: GOOD (  17.86  )
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

On Mon, Jan 29, 2024 at 04:32:03AM +0000, Matthew Wilcox wrote:
> Our documentation of the current page flags is ... not great.  I think
> I can improve it for the page cache side of things; I understand the
> meanings of locked, writeback, uptodate, dirty, head, waiters, slab,
> mlocked, mappedtodisk, error, hwpoison, readahead, anon_exclusive,
> has_hwpoisoned, hugetlb and large_remappable.
> 
> Where I'm a lot more shaky is the meaning of the more "real MM" flags,
> like active, referenced, lru, workingset, reserved, reclaim, swapbacked,
> unevictable, young, idle, swapcache, isolated, and reported.
> 
> Perhaps we could have an MM session where we try to explain slowly and
> carefully to each other what all these flags actually mean, talk about
> what combinations of them make sense, how we might eliminate some of
> them to make more space in the flags word, and what all this looks like
> in a memdesc world.
> 
> And maybe we can get some documentation written about it!  Not trying
> to nerd snipe Jon into attending this session, but if he did ...

I suspect Jon will be there anyway, but not sure he'd be willing to do the
writing :)

I was going to propose the "mm docs" session again, but this one seems more
useful than talking yet again about how hard it is to get MM documentation
done.

And I can take on myself putting the explanations from this session into
writing.
 
> [thanks to Amir for reminding me that I meant to propose this topic]
> 

-- 
Sincerely yours,
Mike.

