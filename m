Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC00DD5C0DD
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 14:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4S1gVsesUVe2RiHWjUbjZdItBIhNYbPZqfWutYYt5d0=; b=PN9qOdlUHOTmPfYD0qTId2rA/r
	rGTpFW+C5qbhOP1JW1TDJkBzBK6H7N8yQYSzXPw0K2NN0uNUuxGyZ8/M9TSJO0QoFnBUgJn/IyCQt
	RH8RMp9j/naLKZDzM2VsFTu4C82+9Ars9hwTBf2bx4Z8lKxW0ydwc36uaFh5fbksY126xybvbRST9
	VEI5mqBccLyIjnNKyq2LEclNb72evTP3jiuLofWUeZSwMCyExJXnAVb0df+rZGcBgBVgFft82whmY
	l1bhruGQFcTzZ6x4kyVgAF0zL6GlT5eaNbDNN1TqgciyknqO49YUg7FsksVAFK6RNIWC18pCHnt7x
	Qd7zhNxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9QPw-0000000AvZ0-19Si;
	Fri, 08 Nov 2024 14:56:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9PpD-0000000ApEC-1Chr
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 14:19:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1458168AA6; Fri,  8 Nov 2024 15:18:53 +0100 (CET)
Date: Fri, 8 Nov 2024 15:18:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <20241108141852.GA6578@lst.de>
References: <20241029151922.459139-1-kbusch@meta.com> <20241105155014.GA7310@lst.de> <Zy0k06wK0ymPm4BV@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy0k06wK0ymPm4BV@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_061859_495850_7ED2C48E 
X-CRM114-Status: GOOD (  15.31  )
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

On Thu, Nov 07, 2024 at 01:36:35PM -0700, Keith Busch wrote:
> The zone block support all looks pretty neat, but I think you're making
> this harder than necessary to support streams. You don't need to treat
> these like a sequential write device. The controller side does its own
> garbage collection, so no need to duplicate the effort on the host. And
> it looks like the host side gc potentially merges multiple streams into
> a single gc stream, so that's probably not desirable.

We're not really duplicating much.  Writing sequential is pretty easy,
and tracking reclaim units separately means you need another tracking
data structure, and either that or the LBA one is always going to be
badly fragmented if they aren't the same.

