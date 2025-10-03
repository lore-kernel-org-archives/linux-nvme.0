Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15D2CAC5B0
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Oct 2025 10:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9nSTmj0IkP9awpR6vA75UpOXrzjQnpVciZKslfNqfvY=; b=Hmd4VvhRaan6BaGYeK7lpYhO8Y
	gnRAC7E3UTHTLjBr3cQEjyGmsQp0pnzdNsdV49JpUZDgd3Aq4/q0I0v7rFcSh9jlyZ/TZsRSjaN6+
	OomHS+6w9i7RbkYvgBNPUk4NK3KRo3+x/r0QmAU8eVJhzPejDVWVsH/okZhPpLD7wrILHKTW6qBHT
	U2LbI+zuf0tZw5a5AbTUEW3xOYGt/9LmJTMOHS/bjHwsigYt2z0rV57X3kcWiY9w4Etm5Vm7ina3p
	2Y7zzj1KudY0nGqni4exsQWmZ2WsDCwiFCePX0FRv4MmJ2HUy/KPx5nrvCv55ACbH7ehyGghdl525
	MpLoFpCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4co9-0000000C1IH-1dco;
	Fri, 03 Oct 2025 10:14:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4co7-0000000C1Hp-3Hw7
	for linux-nvme@lists.infradead.org;
	Fri, 03 Oct 2025 10:14:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 202AC227AAC; Fri,  3 Oct 2025 12:14:32 +0200 (CEST)
Date: Fri, 3 Oct 2025 12:14:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>
Cc: Christoph Hellwig <hch@lst.de>, Maurizio Lombardi <mlombard@redhat.com>,
	kbusch@kernel.org, sagi@grimberg.me, hare@suse.de,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH RFC 1/1] nvme-core: register namespaces in order during
 async scan
Message-ID: <20251003101431.GB15826@lst.de>
References: <20250804114355.30212-1-mlombard@redhat.com> <20250804114355.30212-2-mlombard@redhat.com> <20250922173033.GA13802@lst.de> <DD2LKQ2V9VGA.1IBIWFZRKRZPU@bsdbackstore.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD2LKQ2V9VGA.1IBIWFZRKRZPU@bsdbackstore.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251003_031435_961100_4DB177E4 
X-CRM114-Status: GOOD (  14.20  )
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

On Fri, Sep 26, 2025 at 10:43:16AM +0200, Maurizio Lombardi wrote:
> On Mon Sep 22, 2025 at 7:30 PM CEST, Christoph Hellwig wrote:
> > This idea looks fine to me, but I hate duplicating the logic
> > from SCSI here.  Any chance you could try to factor the logic
> > into a common helper?
> 
> Ok, let's try. What do you think about something like this?
> I am not good with function names so I am open to suggestions:

This looks reasonable to me.


