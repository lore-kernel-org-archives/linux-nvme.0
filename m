Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DBCC61DA7
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jan 2023 16:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=St7IrS1mX9F0RKDBGEEFoebKrWt9ulX8fBNwRg7efIc=; b=RqUD7uQ26YbE8WRbr9vFarHsiT
	VBeojFUo8ScxRUscW+S43QqDjhL6jF4jdAmVIndjv0i4sELMZdxrdcTTPJnfFUMk6psL0z/HXTP5n
	AMrx3j0FIkMl18shh0JYhHdVOFPeo/Ck9UKJgy9W+a6FiKNzq7dAz8+h+t+7bbGGQJ0BjnREsBHGa
	vRCnyKMMcdN8hKjn6h8AkaYrxAJlHdW4V4Kt8rdeuApvzuXjm46o6ia8n+Irbfqg0TDR7WqDRf/Ne
	HeRvICsTFfO98wTc0DqGnLFAS84s5FHhSFSPrRLrhdbHQYvbZhmPeO4A0FLjX5DClqELZ++DM7V9u
	s0Fa6SDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pL5Sg-00BsKr-G7; Thu, 26 Jan 2023 16:50:54 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pL5Iq-00BpKi-QZ
	for linux-nvme@bombadil.infradead.org; Thu, 26 Jan 2023 16:40:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=St7IrS1mX9F0RKDBGEEFoebKrWt9ulX8fBNwRg7efIc=; b=Eg3hNBdDGz6MmWSRYZAiHki/eE
	lqofbPItG5HE7VLsezYljzQ1GYuqfgr/xpQ/G5btMaRZLA1Y9KXs4WlRInUMGu6QuUVLsxPqcszh7
	wkBxk+VAdUw26ftVTdoTBVoM48/XpwfRXNr6x9+1o+vpVQJCz+xENydh9aHYrOg7LGO/Bn+uCk+kZ
	9VP6oYuzy2VNB4n5jugCQ4H3LhlJltty78aGk0qxW71KhXi/ax2RJvjjXI9+VoHsJR2k4KYIwb3hj
	B+FIyRAUbWBFqdShQ7cCSoed4oUCdWJ9MtkfMBoVCRSN8nIyT+TP1u+FCs8pf7fyfchlVGPNxcCbn
	2W3TJ5EA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pL5In-006uHI-SO; Thu, 26 Jan 2023 16:40:41 +0000
Date: Thu, 26 Jan 2023 16:40:41 +0000
From: Matthew Wilcox <willy@infradead.org>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <Y9KtCc+4n5uANB2f@casper.infradead.org>
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

I'd like to do another session on how the struct page dismemberment
is going and what remains to be done.  Given how widely struct page is
used, I think there will be interest from more than just MM, so I'd
suggest a plenary session.

If I were hosting this session today, topics would include:

Splitting out users:

 - slab (done!)
 - netmem (in progress)
 - hugetlb (in akpm)
 - tail pages (in akpm)
 - page tables
 - ZONE_DEVICE

Users that really should have their own types:

 - zsmalloc
 - bootmem
 - percpu
 - buddy
 - vmalloc

Converting filesystems to folios:

 - XFS (done)
 - AFS (done)
 - NFS (in progress)
 - ext4 (in progress)
 - f2fs (in progress)
 - ... others?

Unresolved challenges:

 - mapcount
 - AnonExclusive
 - Splitting anon & file folios apart
 - Removing PG_error & PG_private

This will probably all change before May.

I'd like to nominate Vishal Moola & Sidhartha Kumar as invitees based on
their work to convert various functions from pages to folios.

