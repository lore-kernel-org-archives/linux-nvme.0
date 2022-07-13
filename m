Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E49FC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 15:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WgehCo4EWz54AyF2jDUuG0Xj0H/FjQtWvzeLouBbzy8=; b=QnDIytteai9W3kt0z5PLxohdqa
	FWf7Gl6fLoOtMjQjyVGy8K4TiKj4JFjbGl9dvDHNbAYz0XsapevPY0btSOaaWxeuFH4k5EmTL7VqA
	s2nC8QoY910KB/cyKUUsI7FoO/kbWCJnJbciuyeVl5Ju9gjo+QTtlgJ+yWbsD67K5XkK1VN1V0ICW
	th7ls057afmcNbZ5tWATcOXWVZkkI1hbO58ksotU0PCmeM9z2Yu/Xq4KFFfLzQRGqJP4WdEolvYL5
	pPYAFlMZwf1wE42wTIfFUhx9gslSQUDVybPnObOZhz0fjlqyZHUWlifRmYw1Td9semsPcLgR0bevC
	Dn3xvqFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBdrB-004px1-Iv; Wed, 13 Jul 2022 15:00:53 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBbJi-003RtH-Vg
	for linux-nvme@bombadil.infradead.org; Wed, 13 Jul 2022 12:18:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WgehCo4EWz54AyF2jDUuG0Xj0H/FjQtWvzeLouBbzy8=; b=hiFqFuAZ+D4oDZkdGrk3mNwzMD
	RIy2FWRD01ImOMohxZ8m+oSnAnrZugKZCrbRbuLAfgfm93CUmmSdIq/4hwbRAbDr0ukKJWTnGpHXR
	iQ1Tr4QcsDokLiSOoXImkKWeQz3d51T3UJX1Uhw8xWnu1KOCxOaCG3ndxI3FniFiEWESfF1YjfWv0
	xpqgBJ67IfhYi0ILfNdc7DxI3lJNsEeE75sm/g4LS9TGlCHw3D9nhrwHl1znFQNqekPD1rNs6qWMf
	+YTEq1Cvs1rFBavrhFCxNokpBT1AY4DDVYumygqVZ6vgUL/WHbSkJ6TWJqHGUr13Wu+sIJDCDql6d
	ZbukAvMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBbJU-008AhI-St; Wed, 13 Jul 2022 12:17:56 +0000
Date: Wed, 13 Jul 2022 13:17:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"agk@redhat.com" <agk@redhat.com>,
	"song@kernel.org" <song@kernel.org>,
	"djwong@kernel.org" <djwong@kernel.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"jejb@linux.ibm.com" <jejb@linux.ibm.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"javier@javigon.com" <javier@javigon.com>,
	"johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
	"jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"idryomov@gmail.com" <idryomov@gmail.com>,
	"danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
	"ebiggers@google.com" <ebiggers@google.com>,
	"jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Message-ID: <Ys639LsjBUGPNErd@casper.infradead.org>
References: <20220630091406.19624-1-kch@nvidia.com>
 <YsXJdXnXsMtaC8DJ@casper.infradead.org>
 <5ffe57d3-354c-eabe-ea38-9c4201c13970@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ffe57d3-354c-eabe-ea38-9c4201c13970@nvidia.com>
X-Mailman-Approved-At: Wed, 13 Jul 2022 08:00:42 -0700
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

On Wed, Jul 13, 2022 at 09:14:42AM +0000, Chaitanya Kulkarni wrote:
> On 7/6/22 10:42, Matthew Wilcox wrote:
> > On Thu, Jun 30, 2022 at 02:14:00AM -0700, Chaitanya Kulkarni wrote:
> >> This adds support for the REQ_OP_VERIFY. In this version we add
> > 
> > IMO, VERIFY is a useless command.  The history of storage is full of
> > devices which simply lie.  Since there's no way for the host to check if
> > the device did any work, cheap devices may simply implement it as a NOOP.
> 
> Thanks for sharing your feedback regarding cheap devices.
> 
> This falls outside of the scope of the work, as scope of this work is
> not to analyze different vendor implementations of the verify command.

The work is pointless.  As a customer, I can't ever use the VERIFY
command because I have no reason for trusting the outcome.  And there's
no way for a vendor to convince me that I should trust the result.

> > Even expensive devices where there's an ironclad legal contract between
> > the vendor and customer may have bugs that result in only some of the
> > bytes being VERIFYed.  We shouldn't support it.
> This is not true with enterprise SSDs, I've been involved with product
> qualification of the high end enterprise SSDs since 2012 including good
> old non-nvme devices with e.g. skd driver on linux/windows/vmware.

Oh, I'm sure there's good faith at the high end.  But bugs happen in
firmware, and everybody knows it.

> > Now, everything you say about its value (not consuming bus bandwidth)
> > is true, but the device should provide the host with proof-of-work.
> 
> Yes that seems to be missing but it is not a blocker in this work since
> protocol needs to provide this information.

There's no point in providing access to a feature when that feature is
not useful.

> We can update the respective specification to add a log page which
> shows proof of work for verify command e.g.
> A log page consist of the information such as :-
> 
> 1. How many LBAs were verified ? How long it took.
> 2. What kind of errors were detected ?
> 3. How many blocks were moved to safe location ?
> 4. How much data (LBAs) been moved successfully ?
> 5. How much data we lost permanently with uncorrectible errors?
> 6. What is the impact on the overall size of the storage, in
>     case of flash reduction in the over provisioning due to
>     uncorrectible errors.

That's not proof of work.  That's claim of work.

> > I'd suggest calculating some kind of checksum, even something like a
> > SHA-1 of the contents would be worth having.  It doesn't need to be
> > crypto-secure; just something the host can verify the device didn't spoof.
> 
> I did not understand exactly what you mean here.

The firmware needs to prove to me that it *did something*.  That it
actually read those bytes that it claims to have verified.  The simplest
way to do so is to calculate a hash over the blocks which were read
(maybe the host needs to provide a nonce as part of the VERIFY command
so the drive can't "remember" the checksum).

