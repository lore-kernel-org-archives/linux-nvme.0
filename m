Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A9BC47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 04:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=H8WTJ8NBmRpbZtf94nTTt/tZUYzTLnihYXaoQXGtdRA=; b=wQiTzuQwwOH3IocylZtx6gMVdP
	92AcNIPDiOJ1PwCd2rVL17T6GN+V11EOCmK6RiPnnU6Rj28ebf4Jtz6MipnY7jFv1HmJ3R6z+FD4U
	8CBrjqeXhdIbw4sHHAoEWWn9vYuj2TG3mzis0SXcR4+wJnDOMLqWIRXWTP5cr67ar4TAabFSFvDq0
	Isk0m7lk9dDB0xX59PqCXIfj0lP29I4FVRfI+tWC15I/6T97LGthWCo15kVV6P30veEeOLIcY+/Ek
	I/eNAta3RUd46xxENNanLTUdWdb4zYlCHqpPHrkXri6pcOYTD8NNNvskdThAW1MrsyXAX9WkauwuN
	WZsrHMiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUJJZ-0000000BED4-2M0B;
	Mon, 29 Jan 2024 04:32:09 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUJJY-0000000BECu-1FUi
	for linux-nvme@bombadil.infradead.org;
	Mon, 29 Jan 2024 04:32:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=H8WTJ8NBmRpbZtf94nTTt/tZUYzTLnihYXaoQXGtdRA=; b=WLe6nUl3NiNOhbZzoHeryOF0bU
	P5+xpXLngxxGVebSFsePFiFuI/Tje4zs+Zsk0N8ZJB99kB7M5AanK0s0NzdnlE8eRw+vuYTO7UKYw
	GuYzR0j2zpvVPfRPNwSJ1JNVPTbd4KlXaXcLyUpbS/AMy938NTCRo8+GPJ0oE76c4XVH6RPNdXt+I
	FaQFBumBWxrEMciRiP6PwVK8WLIHygrOro+u9TQHSSK0waUD4WD+doKz2NHNFX8a9pmVRw7vlEcW3
	CE1Deh9g/lgotxHlH9x9TsKC402E2Ze1tzLTttiJTWI+L055MOwTe4bpnXfM80IRGtNESiLNW5uVB
	t24sKqEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUJJT-00000005VPu-4AB6;
	Mon, 29 Jan 2024 04:32:04 +0000
Date: Mon, 29 Jan 2024 04:32:03 +0000
From: Matthew Wilcox <willy@infradead.org>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Reclaiming & documenting page flags
Message-ID: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Our documentation of the current page flags is ... not great.  I think
I can improve it for the page cache side of things; I understand the
meanings of locked, writeback, uptodate, dirty, head, waiters, slab,
mlocked, mappedtodisk, error, hwpoison, readahead, anon_exclusive,
has_hwpoisoned, hugetlb and large_remappable.

Where I'm a lot more shaky is the meaning of the more "real MM" flags,
like active, referenced, lru, workingset, reserved, reclaim, swapbacked,
unevictable, young, idle, swapcache, isolated, and reported.

Perhaps we could have an MM session where we try to explain slowly and
carefully to each other what all these flags actually mean, talk about
what combinations of them make sense, how we might eliminate some of
them to make more space in the flags word, and what all this looks like
in a memdesc world.

And maybe we can get some documentation written about it!  Not trying
to nerd snipe Jon into attending this session, but if he did ...

[thanks to Amir for reminding me that I meant to propose this topic]

