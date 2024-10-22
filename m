Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DD7D2CDE6
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 15:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yhP2sszgMEBk6Neb5zsQpUIK0pad7unGhUO3vhvS848=; b=VacrEgL0qEkhfhya7GJ9ph+Drv
	LAywsIlciabpBu1bOebWprUmRuTtVfuzVfpsxZOvnw9HJPxi53rjuW/rMKrIwiZQwXZD9aeDMqYr7
	nUIa9XFLf0xpZrY6bk8GCZE+PitZq6JGDayvLvUUTbI5rxNjeqfmQ67O2xu/77uVBtN/mddUfWFP7
	rlFY24I7Haho8u8YAtG8DeQEKnZaa8oCvqhdtTQ1jWx7W6uzbvnK5txAg9KB9qPndYf9eBg3vmn6g
	qqqHFexbH5VlbB8eo2r67lZtS7HJyosga2PSwlRprXkNfSRMmEZKlQRnbztFd84LtCT6V1Qd1Cpm+
	rMUtdypg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3HAS-0000000BJTx-43V3;
	Tue, 22 Oct 2024 15:51:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3HAQ-0000000BJTA-1hG0
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 15:51:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 951595C5C9B;
	Tue, 22 Oct 2024 15:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58066C4CEC3;
	Tue, 22 Oct 2024 15:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729612288;
	bh=TGHjo7ux9zVk06eBs97w3tERf69Lss5aal67kmZ/qvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAKEv18aNEbvsQBh5hFl8/aXagEFU4NGr4xRcRvMjxC/B1Oj5Sy3wjcH/0HeIuw8L
	 ixG6CcMItIKGkns2J5BUxItEJng76RDtNpgrXEK3rs/apDEOIpmJr7oDjVjr1oCORi
	 m+Dxqfn3X+pcNqvVmfhPoCVfPfK7+LLGUVRPBo1Lt6qSDNRi3SAabZ+xfQXHlya8Yb
	 mt0bImaaQL3RmQbQ2OMjDhNe1jtm8RsiSTZvsYca/S5CaIvWoETwu5w2oZ1sjpIp5h
	 9lT8KeDAgWjy2gnjnL/JIqE8UwUxxLcO9TTlZlxhZhY3kfDTCNuiqp7a1RxFt13Tjr
	 MYIKmhxrGtC4w==
Date: Tue, 22 Oct 2024 09:51:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Abhishek Bapat <abhishekbapat@google.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Prashant Malani <pmalani@google.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring
 namespaces
Message-ID: <ZxfJ_TfT7MMGWs4X@kbusch-mbp>
References: <20241016213108.549000-1-abhishekbapat@google.com>
 <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
 <CAL41Mv4_UjsD1ycpNU1xuQJdGWMf2L-SQYs=LupoM9BKurNXCg@mail.gmail.com>
 <Zxe8e2zS5dA61Jou@kbusch-mbp>
 <6b00d25e-fe6a-4552-9945-d6181af83137@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b00d25e-fe6a-4552-9945-d6181af83137@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_085130_506687_62DCA489 
X-CRM114-Status: GOOD (  18.49  )
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

On Tue, Oct 22, 2024 at 06:35:11PM +0300, Sagi Grimberg wrote:
> On 22/10/2024 17:53, Keith Busch wrote:
> > On Thu, Oct 17, 2024 at 02:32:18PM -0700, Abhishek Bapat wrote:
> > 
> > The request_queue is owned by the block layer, so that seems like an
> > okay place to export it, but attached to some other device's sysfs
> > directory instead of a gendisk.
> > 
> > I'm just suggesting this because it doesn't sound like this is an nvme
> > specific problem.
> 
> Won't it be confusing to find queue/ directory in controller nvmeX sysfs
> entry?

It's the attributes of the request queue associated with that
controller, so I think a queue/ directory under it makes sense. That's
how it looks for gendisks, so why not for disk-less queues?

Many queue attributes only make sense for gendisks, though, so maybe
need to tweak visibility if we decide to do it like this.

