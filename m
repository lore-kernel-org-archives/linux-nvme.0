Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24229C3ABC0
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 05:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gw/Lev8QNB6/NJ5X0LDeteqdBHvkM+P+V7uJOr3t19E=; b=F8LDCcdLnIBfAshxdZKFKOuA4b
	G6znsj+syhUiddGiEdLNjLSEeRkgYvWctDDqWXgSnfsMz0u2nUoVlGGzYhAmf6q4pSaD3XfQvAOWj
	copkNeKU02ENf10jDgW58th8YX0uUXBNgNUGYS2iZb75xIFgIlQfx7lVxHyGwvIgSksNwnSa44xqB
	Pc3yZ1ERXwgjyIj4A9aZTHGfzkUYpPl2uOJnEkoD2R5pBvQWVTcoOoDGOd6tMSym/0+iSEMFiAZx2
	EiBF8FMJq+FRXbgq6QsMR5YJwEDj02FcJxBkufVoQAxrgCrR8Zd+GJXJJuy6g8Roc3Vr+TPFN6oBk
	VzQLt5RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCtsd-0000000HNQt-3xnr;
	Thu, 08 May 2025 05:33:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCtsb-0000000HNPq-3NVL
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 05:33:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4390C68AFE; Thu,  8 May 2025 07:33:04 +0200 (CEST)
Date: Thu, 8 May 2025 07:33:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
	jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
	gjoyce@ibm.com
Subject: Re: [RFC PATCHv3 1/3] nvme-multipath: introduce delayed removal of
 the multipath head node
Message-ID: <20250508053303.GA27661@lst.de>
References: <20250504175051.2208162-1-nilay@linux.ibm.com> <20250504175051.2208162-2-nilay@linux.ibm.com> <dd7330a2-6499-4af7-af3a-489ab86d2b5f@suse.de> <20250507065050.GA31543@lst.de> <6fa58716-8995-43b9-b01e-3bbcf2cc6b2f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fa58716-8995-43b9-b01e-3bbcf2cc6b2f@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_223309_981985_2C29EBEA 
X-CRM114-Status: GOOD (  12.05  )
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

On Thu, May 08, 2025 at 01:26:16AM +0530, Nilay Shroff wrote:
> That's a possible approach; however, the challenge arises when the head node
> points to multiple namespace paths, each associated with different fabric 
> controllers.

That's generally a good point.  Especially PCIe vs fabrics will be
fun to test.  We really need a PCI loop device for nvmet to be able
to test it.

> As we know, max_reconnects is a per-controller attribute. So, if only one of
> the fabric controllers has max_reconnects set to a non-zero value, but others
> do not, how do we decide whether to implicitly disable head->delayed_removal_secs?

Well, as soon as something in the subsystems can't reconnect we want to
delay the removal, right?


