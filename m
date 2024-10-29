Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B63CD3A661
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MP50a44+ueO0aC4rIQLqKtQTBF9t99DFYtZgIZQhxyM=; b=RCgh5K5/LBlKK24FS3P/b02vo/
	XWBTiylPSBd/mDEV8VkNWePTJ8abYq5MIaXiBwDZS+LWHyxu6SgKnzn3v0WzYjNu1iSzuTL2U3QBl
	JW0Gd2uu2/Gwo5heuxbzjBa2K/lzcB9v5AuUTpe52vmDsMgq+Eu4n3+HEcWUIeicUdWlqBUR/fate
	thtTWr6OhrFcK4712uC91ME0RDOUCB+fJsUNWya08NMANnNpQ5iKKZ2Ilo0B4EVMJ1k7Rw5peeEXN
	2i0lqT1mtY9Tf9OBPHRglLI59+s+cx/SH9M/XnGeCNdVzkkV9Wz4OEbBOOFVqRxQyZ2FsBMMwBlw0
	nOoXmLVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5oW1-0000000F0nj-49dp;
	Tue, 29 Oct 2024 15:52:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5oHK-0000000Ewxe-2e9L
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 15:37:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 260AC227AAD; Tue, 29 Oct 2024 16:37:03 +0100 (CET)
Date: Tue, 29 Oct 2024 16:37:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <20241029153702.GA27545@lst.de>
References: <20241029151922.459139-1-kbusch@meta.com> <20241029151922.459139-10-kbusch@meta.com> <20241029152654.GC26431@lst.de> <ZyEAb-zgvBlzZiaQ@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyEAb-zgvBlzZiaQ@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_083706_832378_184DE0D8 
X-CRM114-Status: GOOD (  12.52  )
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

On Tue, Oct 29, 2024 at 09:34:07AM -0600, Keith Busch wrote:
> So then don't use it that way? I still don't know what change you're
> expecting to happen with this feedback. What do you want the kernel to
> do differently here?

Same as before:  don't expose them as write streams, because they
aren't.  A big mess in this series going back to the versions before
your involvement is that they somehow want to tie up the temperature
hints with the stream separation, which just ends up very messy.

