Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A9FD70E1D
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 06:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G4AQOiUCfcvnV1HlhJKEsIvflh/08g9Hy5mI013gTQk=; b=jxpPaaAttH5aewN/3AHuRWhmKW
	nMu1rVb/45hhXpBr31HWFABoOp90aEI8VosXzT36Ptsbov9wmG1ZlSSRl+C5j/r9sdw1AHBrygUY8
	W9tdvh29qFKwBOeTuaBqGWqU3Td8iovJhcF25HA7XvOdBxyeTAAQiQBf466c9ZQXYS0YbRhYijnt1
	4Y1DBPesyNGL45GRJ7WE1gg3bn2oVdCW4A319wsCQ+A/kvhweYiqOnMoplybIypCldRzCfNNpN7dw
	HUJhXJ1pwt91925pgGCb4FU+CgkuK8x2tV2ZVDO37Z6Rer9pcDd58o0K3lb0yiyLHmm1jTWZymCmD
	8KBEUwjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGuM8-0000000Gzcx-0Exc;
	Fri, 29 Nov 2024 06:19:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGuM4-0000000Gzb6-3I7f
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 06:19:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 29B9D68D1C; Fri, 29 Nov 2024 07:19:42 +0100 (CET)
Date: Fri, 29 Nov 2024 07:19:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Javier Gonzalez <javier.gonz@samsung.com>,
	Matthew Wilcox <willy@infradead.org>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"joshi.k@samsung.com" <joshi.k@samsung.com>
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <20241129061941.GA2545@lst.de>
References: <a7ebd158-692c-494c-8cc0-a82f9adf4db0@acm.org> <20241112135233.2iwgwe443rnuivyb@ubuntu> <yq1ed38roc9.fsf@ca-mkp.ca.oracle.com> <9d61a62f-6d95-4588-bcd8-de4433a9c1bb@acm.org> <yq1plmhv3ah.fsf@ca-mkp.ca.oracle.com> <8ef1ec5b-4b39-46db-a4ed-abf88cbba2cd@acm.org> <yq1jzcov5am.fsf@ca-mkp.ca.oracle.com> <7835e7e2-2209-4727-ad74-57db09e4530f@acm.org> <yq1ed2wupli.fsf@ca-mkp.ca.oracle.com> <9e9ca761-6356-4a97-a314-d08bd5ea0916@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e9ca761-6356-4a97-a314-d08bd5ea0916@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_221952_973450_DA4B9057 
X-CRM114-Status: GOOD (  17.76  )
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

On Thu, Nov 28, 2024 at 05:51:52PM +0900, Damien Le Moal wrote:
> > Maybe. But you'll have a hard time convincing me to add any kind of
> > state machine or bio matching magic to the SCSI stack when the simplest
> > solution is to treat copying like a read followed by a write. There is
> > no concurrency, no kernel state, no dependency between two commands, nor
> > two scsi_disk/scsi_device object lifetimes to manage.
> 
> And that also would allow supporting a fake copy offload with regular
> read/write BIOs very easily, I think. So all block devices can be
> presented as supporting "copy offload". That is nice for FSes.

Just as when that showed up in one of the last copy offload series
I'm still very critical of a stateless copy offload emulation.  The
reason for that is that a host based copy helper needs scratch space
to read into, and doing these large allocation on every copy puts a
lot of pressure onto the allocator.  Allocating the buffer once at
mount time and the just cycling through it is generally a lot more
efficient.


