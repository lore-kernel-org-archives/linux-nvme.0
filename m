Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC0CD42BB5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 17:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YFqRV9QXE2OTl1gsLyEpL4Q5nY1jRig+q3JmXPNusDo=; b=cdN0I0XVcf+VhEEqBN97jsEwdC
	aNNXvhUjsvENWhpyrSfd8q1rZyP9OPdDjLC8EDwKSAV6cHWnBzEWiJj17Jr6nOBikWkAWq6KXeWko
	XdQA3yF+R7a+uwUrotAHVQDfKZUruxRXCjnishCDswS2PRfl/EIdtJyJl4n3xzfLQdfwFUUHNUFZL
	Zo4s1N6ZjB2W+bch38U9WKN1MNe0vWSUvGXwLug1ksme3eBS4h8P5Ut+B9alr8Im7aLgpmgImiiHH
	555C7nQb/Kl+bYkvdD2oMi9iQjYv2uRC5FeN/EL62wNBMNMqsKAe+p2nLYp/JKjFF+2LkYsbV1YX9
	CTE+Y5kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAuvY-00000004Pjt-2iE9;
	Tue, 12 Nov 2024 17:43:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAuXv-00000004KtM-3vUm
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 17:19:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8065268AFE; Tue, 12 Nov 2024 18:19:15 +0100 (CET)
Date: Tue, 12 Nov 2024 18:19:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, martin.petersen@oracle.com, asml.silence@gmail.com,
	javier.gonz@samsung.com
Subject: Re: [PATCHv11 0/9] write hints with nvme fdp and scsi streams
Message-ID: <20241112171914.GA21822@lst.de>
References: <20241108193629.3817619-1-kbusch@meta.com> <CGME20241111103051epcas5p341a23ed677f2dfd6bc6d4e5c4826327b@epcas5p3.samsung.com> <20241111102914.GA27870@lst.de> <7a2f6231-bb35-4438-ba50-3f9c4cc9789a@samsung.com> <20241112133439.GA4164@lst.de> <ZzNlaXZTn3Pjiofn@kbusch-mbp.dhcp.thefacebook.com> <20241112165054.GA19355@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112165054.GA19355@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_091920_150835_5FDEC98E 
X-CRM114-Status: GOOD (  18.56  )
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

On Tue, Nov 12, 2024 at 05:50:54PM +0100, Christoph Hellwig wrote:
> > so putting the filesystem in the way to force
> > streams look like zones is just a unnecessary layer of indirection
> > getting in the way.
> 
> Can you please stop this BS?  Even if a file system doesn't treat
> write streams like zones keeps LBA space and physical allocation units
> entirely separate (for which I see no good reason, but others might
> disagree) you still need the file system in control of the hardware
> resources.

And in case this wasn't clear enough.  Let's assume you want to write
a low write amp flash optimized file system similar to say the storage
layers of the all flash arrays of the last 10-15 years.

You really want to avoid device GC.  You'd better group your data to
the reclaim unit / erase block / insert name here.  So you need file
system control of the write streams, you need to know their size,
you need to be able to query how much your wrote after a power faіl.
Totally independent of how you organize your LBA space.  Mapping
it linearly might be the easier options without major downside, but
you could also allocate them randomly for that matter.

> 
---end quoted text---

