Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FF3C27C4F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 08:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MzZ+h9Adx5M/YlYjt1i4L1ue8DP3AspVMDNT/CPuOe4=; b=QgzLKqrnQ6vBijmn/nWb3aB+NV
	qqX+zQgLOsthwqE3ryXUmfP1O52Ax04MJkfhjXeeHRRNVDHIEko8L7Agr9ZeR9tXXz7mnUozgT8nr
	/Mu0d3VVVG6KhhSkkUjE3eiqd3793LJiAJN7MRUQTl5hQMUCic2anZ2SkLMwiewW2iHPu6zxeO0qf
	l6tx0/3Tz4gj3vEuChBGoCih51qiYVKMNBNv4mLAdCH+n7qpHPEClM8DbwP1CJ+0JesP29zJI22Ot
	+reqVNadd4POGyn2ySWW9dcFZrW1zB1VHG+NQmofKctnVm6NX808laK1XRcH56kCpTd4NHhLJjZ/J
	ESz1GPmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHfXO-0000000Fcxr-2Xoa;
	Thu, 13 Jun 2024 08:10:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHfXK-0000000FcxM-3kw8
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jun 2024 08:10:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E4E6268AFE; Thu, 13 Jun 2024 10:10:16 +0200 (CEST)
Date: Thu, 13 Jun 2024 10:10:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	hch@lst.de, sagi@grimberg.me, paulmck@kernel.org,
	davidgow@google.com, akpm@linux-foundation.org,
	venkat88@linux.vnet.ibm.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <20240613081016.GA21500@lst.de>
References: <20240612155135.3060667-1-kbusch@meta.com> <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_011023_177775_6B6F65AA 
X-CRM114-Status: GOOD (  12.68  )
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

On Thu, Jun 13, 2024 at 10:26:11AM +0530, Nilay Shroff wrote:
> I am wondering whether we really need the _rcu version of list_cut here?
> I think that @head could point to an _rcu protected list and that's true 
> for this patch. So there might be concurrent readers accessing @head using
> _rcu list-traversal primitives, such as list_for_each_entry_rcu().

Yes, I can't see how this works for a RCU lists without very careful
memory ordering.

Btw, another thing - the old vs new list ordering is reversed vs
list_splice*, which is a bit confusing (as are the parameter names
both for list_splice* and this new helper).  Can you switch them
around to match?


