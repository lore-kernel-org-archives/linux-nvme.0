Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B22C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 16:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lyj7vNY+fMTR1j9SctsHADD8o7aEvwyERfhvNztd4y8=; b=mnFG/pyRIvKakP3O2NIxtGd6Px
	gbL0o3iVSRdaClaIL6vvaSFQHln/N101Mek+DH2le11qdOXY6adYknAGOtvtUqevNUkETbTW3iq6R
	f4keDupOgPQ6sYU+vJWv6zqg8svWqfTF8EyiVZV8DbcuDM41yDD/IrTEVmOp7ITfB9kW6Y7Ruu4fZ
	+2LhPMIO9TBZLNtIOiKCTdM41DVXp1xlGhl6VkLaXFR/eiYFv3zCVAByXtu+MHvKLTs5pF3J1DInX
	nF6AcQ5Kq7VqJoyJpyOMomTkPjBi7bFZ56pxIU6Isafk0nje9/EpyXUx0lBK367E33/I3oRzG66J4
	EI+VOceQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmeNu-00Grpx-QI; Thu, 05 May 2022 16:31:22 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmeNr-00Grn2-DY
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 16:31:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 9E6F9CE2CB9;
 Thu,  5 May 2022 16:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF1EC385A4;
 Thu,  5 May 2022 16:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651768273;
 bh=PE1yWyyJvKmdS6H2jCB/fUMek93PICDm7sQFKq9psWU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CbrlKol/FylTi3U7sgrRvbd2v8iQXCIOHhWCWLNSEzuTvW3fTflr+2KSjTQIjSzOT
 DsM5zmfUMrAif7cIyj02UnhTbz5So0Cj+wUaLK5gEDB9xJRrTf0fL/W9n1TFoaG7tb
 5qAZ+Ehtp6a/kvUaOZ2iSwwQmMLLCHA/lsN91b/rcgE9nF/08us8CJ9WnIxQkEKkkW
 FXngNl3mqs6hPP1IFNerPHbYViNcjhfbrDLG6GqoVy5XySdqWzn4hyFpSPP28YSanK
 cLIKnYYp8NrI9NP2qIhi45Hptc3GH4BBxaDuWVYo6IIZui1wmW7bggg8k2S1WsRyK2
 oZLZVSsuBf7kQ==
Date: Thu, 5 May 2022 10:31:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: set dma alignment to 3
Message-ID: <YnP7zVFiD2j5t1bv@kbusch-mbp>
References: <20220504184325.1439476-1-kbusch@fb.com>
 <20220505134533.GA13926@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505134533.GA13926@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_093119_684461_CD9E3142 
X-CRM114-Status: GOOD (  18.59  )
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

On Thu, May 05, 2022 at 03:45:34PM +0200, Christoph Hellwig wrote:
> On Wed, May 04, 2022 at 11:43:25AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The nvme specification only requires qword alignment for segment
> > descriptors, and the driver already guarantees that. The spec has always
> > allowed user data to be dword aligned, which is what the queue's
> > attribute is for, so relax the alignment requirement to that value.
> > 
> > While we could allow byte alignment for some controllers when using
> > SGLs, we still need to support PRP, and that only allows dword.
> 
> Can't we just turn it go up to eleven? ;-)

Excellent idea! Best I can do is a binary 11 :p

