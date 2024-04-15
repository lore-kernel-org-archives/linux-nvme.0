Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1555C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Apr 2024 21:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oq3OSv09Zcq3l/SCWQSioSa37PYcwwKSz6uiDlE9w/E=; b=Q7alHMZ8Pa/C5jviRyE67Q+oBn
	CL5a1S8uCXGQxfHh+Ss6zBo6w5owxRcRSAz9nHe0lswsiPy1RiMhmCJVMTT7whlc8a67o8KQj9a/G
	lOFDKcI3OlydMliBNLlDUf8AXbAQK28MXsjETOqOCNOI1jpMwdVVHpXAJMiOJEWlFm8YOLRLvZNJO
	EoomSwyKz/RKncGp0qOQWOgX9oE0wJl9ypCwoksZRPQhny5eYhiO/h0LojzuBjDKLmvIGtiK0GOmm
	V6t+hNbYrLSmK8ZmSzjkL4jdVlVae45JnpLGo9tCe4j22nR1I7jm7e5s4jz1jMMDlShRaDbbrr/1+
	7lg346OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwTio-00000009wnB-1sgb;
	Mon, 15 Apr 2024 21:18:38 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwTin-00000009wmz-1gCp
	for linux-nvme@bombadil.infradead.org;
	Mon, 15 Apr 2024 21:18:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oq3OSv09Zcq3l/SCWQSioSa37PYcwwKSz6uiDlE9w/E=; b=k1gFawtalSNyx93OW2ft4AbbZm
	mL+127agePKR7DWE1EgzM8K2Sdu0btd1XQeD8Wzl2tmTNdgWmn92sRrCehFh8u/+qHAagyvQyrV+I
	wglcZ0HQmPiryp3ay1AfYi9TzgEYQTdT7rPBLPlWeJzkacLKZXrdbwV9HsWzpaSjGI3Si8Mpfr2S0
	0hiTTpWQOGyNpghwLESRQBYRaWfsk2cg6KJWgLE1zDszdu8yt8sfPIvBeNWyhWxqIe1CYWPFC33pc
	4OQTnxL2Sln3ZByHLOn89dz27uUzxYSHVKBEuo/ChmtRraFlSsjkqf650IGawzGSeX5oHG74Pa4Vl
	djp37vKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwTig-0000000GWYM-3AgF;
	Mon, 15 Apr 2024 21:18:30 +0000
Date: Mon, 15 Apr 2024 22:18:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com
Subject: Re: [PATCH v6 00/10] block atomic writes
Message-ID: <Zh2ZptLxnwa_jtSk@casper.infradead.org>
References: <20240326133813.3224593-1-john.g.garry@oracle.com>
 <ZgOXb_oZjsUU12YL@casper.infradead.org>
 <c4c0dad5-41a4-44b4-8f40-2a250571180b@oracle.com>
 <Zg7Z4aJtn3SxY5w1@casper.infradead.org>
 <f3c1d321-0dfc-466f-9f6a-fe2f0513d944@oracle.com>
 <ZhQud1NbO4aMt0MH@bombadil.infradead.org>
 <ZhYQANQATz82ytl1@casper.infradead.org>
 <ZhxBiLSHuW35aoLB@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhxBiLSHuW35aoLB@bombadil.infradead.org>
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

On Sun, Apr 14, 2024 at 01:50:16PM -0700, Luis Chamberlain wrote:
> On Wed, Apr 10, 2024 at 05:05:20AM +0100, Matthew Wilcox wrote:
> > Have you tried just using the buffer_head code?  I think you heard bad
> > advice at last LSFMM.  Since then I've landed a bunch of patches which
> > remove PAGE_SIZE assumptions throughout the buffer_head code, and while
> > I haven't tried it, it might work.  And it might be easier to make work
> > than adding more BH hacks to the iomap code.
> 
> I have considered it but the issue is that *may work* isn't good enough and
> without a test plan for buffer-heads on a real filesystem this may never
> suffice. Addressing a buffere-head iomap compat for the block device cache
> is less error prone here for now.

Is it really your position that testing the code I already wrote is
harder than writing and testing some entirely new code?  Surely the
tests are the same for both.

Besides, we aren't talking about a filesystem on top of the bdev here.
We're talking about accessing the bdev's page cache directly.

