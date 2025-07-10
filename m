Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2BCC83F1F
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jul 2025 08:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O9WeySlRbc3wZx6zdedqICU2SpXRUg0XLBcSSAMBVLQ=; b=fDT+/mEmLUuJprqqpSQvgRRn69
	h2lUdpBcRAqDH/FQVXpruIz6qlUWHAem4W/X+4slt03FElWhwez9Vh9eywlughtccIisuTPP+apTY
	Xy4SVklkaJVGD9i+5KSq61Yf2I7KnaN8lPC2KMON8GFdKhsqhxrWpMcbxlTYAUomQwTQhR2GOEYY1
	N/Eepjl1UfqchdNawnNtZxxt9IMy/ZPquMZk3MlUsXzjIA8OOnvS3JEavolzqwo8GVQYkOpABMJeK
	xT+fW3uR3yvi/qcsTzARprDVqLYgKfAuS8NTqTLTbPn47FjCh2iMENo3nQBlXuuLa3IKAj3t35sqt
	80WzjuPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZmSl-0000000B8va-22gW;
	Thu, 10 Jul 2025 08:17:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZlXb-0000000Ayv5-1u5q
	for linux-nvme@lists.infradead.org;
	Thu, 10 Jul 2025 07:18:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E941768CFE; Thu, 10 Jul 2025 09:17:41 +0200 (CEST)
Date: Thu, 10 Jul 2025 09:17:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <20250710071741.GA5273@lst.de>
References: <20250707141834.GA30198@lst.de> <ee663f87-0dbd-4685-a462-27da217dd259@linux.ibm.com> <aG7fArgdSWIjXcp9@kbusch-mbp> <27a01d31-0432-4340-9f45-1595f66f0500@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27a01d31-0432-4340-9f45-1595f66f0500@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250710_001759_638307_D0F20554 
X-CRM114-Status: GOOD (  12.04  )
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

On Thu, Jul 10, 2025 at 10:37:19AM +0530, Nilay Shroff wrote:
> So in this case, it's actually the opposite of what one might assume:
> Users of namespaces with 4KB LBA format would see the best possible atomic write
> performance, while those using 512-byte LBA format may observe sub-optimal 
> performance, since the maximum atomic write size scales down with smaller LBAs.

The problem is that we need to deal with the worst case and not the
best case.  And NVMe royally messed up there.


