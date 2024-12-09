Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8102CE77180
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 23:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hnYryxs5fAFAEeNlJ/22fquHamymjdpDvKQADj8yK+k=; b=xHQhsyzyH6b6cWsaqWZP7KDAOL
	kamC2GvWcXW+JYDpsGz1P9HNLQyj7z38vrf5RcWXQIXCs8+4r6yKn69jkxoKFdBg9rHVFIFkB20z+
	fgAlvrimjRwBNIYQijzwC65GInCi7smZjqejWs93mEFfBLAOTBjZMP7gdciGno7sMQH7XF8IVduyT
	II8MkRNaekDp/zrgVF28jSGlpGigIvM95pQLyAXsJcbEqi47seBuhq8KUa2RR9HYwRInNIrKbAHiW
	UMlMOOQimK+jVuZL04Zq44Nn1WS3pHCiR4O3109N8QMhi5sWNu2wENqIygtrzfUF3BdxcX/g0/O/m
	8do2qRGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKnDm-00000009aAD-3vwe;
	Mon, 09 Dec 2024 23:31:22 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKnDl-00000009aA1-02vI
	for linux-nvme@bombadil.infradead.org;
	Mon, 09 Dec 2024 23:31:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=hnYryxs5fAFAEeNlJ/22fquHamymjdpDvKQADj8yK+k=; b=dpnRolIAhWJAxtAgvTts6JqV0x
	0Xn709vr5TWG4JYGpD+UA41WayzULhAiKkL9s13N/kBcYYtzF+mJ9GEqGuRzmdcxIxLXEx/fudB6O
	i4vID4WHc+whH9Tx2SzTdhqlOPZ/wRAm+YZDaby2YdFx/q09MuSAjoLZ2ZZEdPfx8OykViN87fMJy
	HeXRDdkmIHyLxnSaq+6kBN0vmzR5XvSHc8NIqhPeqggAsioGb9qWyZYKzvS7kilnU4zVXkT4elpMa
	HN2FIeHIQXZNuIIFQwvroG+gb+A1WWq0s4TnXFACj1QclXjfZrIRxSPXam2RZdRaov3TLIiR72NqP
	gZiUg44w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKnDh-00000005Nat-1gls;
	Mon, 09 Dec 2024 23:31:17 +0000
Date: Mon, 9 Dec 2024 23:31:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Nitesh Shetty <nj.shetty@samsung.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Javier Gonzalez <javier.gonz@samsung.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"joshi.k@samsung.com" <joshi.k@samsung.com>
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <Z1d9xfBwp0e8jxf4@casper.infradead.org>
References: <a7ebd158-692c-494c-8cc0-a82f9adf4db0@acm.org>
 <20241112135233.2iwgwe443rnuivyb@ubuntu>
 <yq1ed38roc9.fsf@ca-mkp.ca.oracle.com>
 <9d61a62f-6d95-4588-bcd8-de4433a9c1bb@acm.org>
 <yq1plmhv3ah.fsf@ca-mkp.ca.oracle.com>
 <8ef1ec5b-4b39-46db-a4ed-abf88cbba2cd@acm.org>
 <yq1jzcov5am.fsf@ca-mkp.ca.oracle.com>
 <CGME20241205081138epcas5p2a47090e70c3cf19e562f63cd9fc495d1@epcas5p2.samsung.com>
 <20241205080342.7gccjmyqydt2hb7z@ubuntu>
 <c639f90f-bdd1-4808-aeb7-e9b667822413@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c639f90f-bdd1-4808-aeb7-e9b667822413@acm.org>
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

On Mon, Dec 09, 2024 at 02:13:40PM -0800, Bart Van Assche wrote:
> On 12/5/24 12:03 AM, Nitesh Shetty wrote:
> > But where do we store the read sector info before sending write.
> > I see 2 approaches here,
> > 1. Should it be part of a payload along with write ?
> >      We did something similar in previous series which was not liked
> >      by Christoph and Bart.
> > 2. Or driver should store it as part of an internal list inside
> > namespace/ctrl data structure ?
> >      As Bart pointed out, here we might need to send one more fail
> >      request later if copy_write fails to land in same driver.
> 
> Hi Nitesh,
> 
> Consider the following example: dm-linear is used to concatenate two
> block devices. An NVMe device (LBA 0..999) and a SCSI device (LBA
> 1000..1999). Suppose that a copy operation is submitted to the dm-linear
> device to copy LBAs 1..998 to LBAs 2..1998. If the copy operation is

Sorry, I don't think that's a valid operation -- 1998 - 2 = 1996 and 998
- 1 is 997, so these ranges are of different lengths.

I presume you're trying to construct an operation which is entirely
reading within the first device, and then is going to write across both
devices.  So let's say you want to read 1-900 and write to 501-1400.

> submitted as two separate operations (REQ_OP_COPY_SRC and
> REQ_OP_COPY_DST) then the NVMe device will receive the REQ_OP_COPY_SRC
> operation and the SCSI device will receive the REQ_OP_COPY_DST
> operation. The NVMe and SCSI device drivers should fail the copy operations
> after a timeout because they only received half of the copy
> operation.

... no?  The SRC operation succeeds, but then the DM driver gets the DST
operation and sees that it crosses the boundary and fails the DST op.
Then the pair of ops can be retried using an in-memory buffer.

I'm not quite clear on the atomicity; whether there could be an initial
copy of 500-900 to 1000-1400 and then a remap of 1-499 to 501-999.

