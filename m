Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B05FC83F17
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 20:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BypLHT8P3y7WLcxpAqRf9nezS1MXJSKqpoWXatLi35Q=; b=co0qB22THnL69JGE4iOTpsBpSN
	ixk5JAfarU6HKs0qBf1/qXzCcFamxKMCmXq2RnRQCsSC+LKaAvdUlqGQLpogKx4FLFEQpF4kXWcZn
	b9Zs7qSv8+nDS7vBTLOjH/+9qB0V6dDMYnvWjhekE+CetYhCJg37uXnAJxuqahgaPmpbKmQuu1Ux3
	DrpWGe6CKDydXvzDE9LdiVSEWSbQIlniMni8YKSCx+gN1qLqyAyDezZan1yK0SDEoM9kOPAwmbB90
	S66X5W2sgzy0cMoO0zUb+HNrX9pDSHlOmFerO+9IWylqyPw+8ChXCj/DVSj5hc5D9HOroh368IEDt
	zAx+ivYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubmh8-00000006DJB-2iBg;
	Tue, 15 Jul 2025 20:56:10 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubmh5-00000006DIJ-3M75
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 20:56:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4402740C24;
	Tue, 15 Jul 2025 20:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC9BC4CEE3;
	Tue, 15 Jul 2025 20:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752612967;
	bh=BypLHT8P3y7WLcxpAqRf9nezS1MXJSKqpoWXatLi35Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gAgPb5sSG955z0OLvwZTks1uWTR0zFbzL+bgn37yNPO9OwCbjWyZenxB2NhU9PjEK
	 2nWUmDRao/DnjxwrGOKGCopYuqmXp5ayTa31AnSCS7eJDn5LQ4+uMFKCleJoWTT2S8
	 rXtFFVJQLFcf/k1KI7+rlsN6jNlj/774pp24ThYNdEjBonSXFG43QamgWrp9Gpe3sl
	 jlwU1bKkMxYBR2vx29ZCNEgaCZtfJ/2zgbJ/zTOUmlAOg3OtD3I5ytGaTSdYmjsFA2
	 8mtVnEu0K64YvnY5WsHSwP/3eV7MjGMPai0FcDwYWWWQOC85+m+9JVNVX3raJGWwcm
	 sYESA+iKvoLFA==
Date: Tue, 15 Jul 2025 14:56:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <aHbAZBf12kiEdXfH@kbusch-mbp>
References: <20250714131713.GA8742@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714131713.GA8742@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_135607_858198_87750B1A 
X-CRM114-Status: GOOD (  10.98  )
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

On Mon, Jul 14, 2025 at 03:17:13PM +0200, Christoph Hellwig wrote:
> Is is just me, or would it be a good idea to require an explicit
> opt-in to user hardware atomics?

IMO, if the block device's limits reports atomic capabilities, it's fair
game for any in kernel use. These are used outside of filesystems too,
like through raw block fops.

We've already settled on discarding problematic nvme attributes from
consideration. Is there something beyond that you've really found? If
so, maybe we should continue down the path of splitting more queue
limits into "hardware" and "user" values, and make filesystems subscribe
to the udev value where it defaults to "unsupported" for untrusted
devices.

