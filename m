Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09C5D69117
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2024 15:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UGdCCtpzYMoZt+cnbvj3jjo99vR7jmoU4PQ+GIun+OU=; b=HqEMQX0u+tHH+F9MgqCaBSOrhX
	zxF9CKiguDm+6ZhP6kZFpXAv10iJUP94dGT0imV+OvLihjxoXBzB1YmZ+lc3KDDqalLCNDPgIScyw
	cve916PoeuFHIGHZdTpsYY+6Tz9H7qLPLOE817K5SLgiIJywZ12ThHMT9KF786kdKJ/ymTEQKDEui
	OF+FDhVJJC2f9+oHLStyVjbzW3vnN5iJpIrvXQSX2OXwcHG2K7BDWyK+AeoLWEmida9xiM0moXsMA
	24gcnA0YF/YFI1PMysquwyg4WzFi5vw/UOzh3kRGjQOocMoMEsg+yEpo8/IvpBmGKvQimUFhIfpyQ
	gnlBujQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGgQ4-0000000FtCV-04iB;
	Thu, 28 Nov 2024 15:27:04 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGgKV-0000000Fs4i-3V47
	for linux-nvme@lists.infradead.org;
	Thu, 28 Nov 2024 15:21:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 39AABA43AC4;
	Thu, 28 Nov 2024 15:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C136C4CECE;
	Thu, 28 Nov 2024 15:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732807278;
	bh=/nSe3ZP6/cW6ZZ443hUUzhIFmIVs0MMT0pZaG0rgKu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lmnj3M7doVBuYQ8q8gw9XIER9vFoguEqjNoFujC1M9rhe81JiCtiS9YueIRKzisa+
	 +1GnX+9fEztBfGD8dYyOxjG6nErXDlWPaCh+B1TLNqOEQOEJKBVtIw6zVKxqNcludc
	 wZ95bKfK/4UNA1hRNXHtrej0lrEJLbXwkV4C7inyxxwPVfBh8iLUUh7/FkxJCasdwh
	 SNLxTOuB3kfmumLRjOpcieXC0l8nvZZ/6lX7dDjrlpGoUNm+coGeUoKwZS7oirEAZq
	 E6bbVzsCIhBbjdFx4alBWtNqzM/vqSe+DXshajJobxUY5adSz6iziHUiYZQ9ABGikl
	 fBMxvS+aX2yAg==
Date: Thu, 28 Nov 2024 08:21:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Javier Gonzalez <javier.gonz@samsung.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"joshi.k@samsung.com" <joshi.k@samsung.com>
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <Z0iKbPttERXaiexO@kbusch-mbp>
References: <d7b7a759dd9a45a7845e95e693ec29d7@CAMSVWEXC02.scsc.local>
 <2b5a365a-215a-48de-acb1-b846a4f24680@acm.org>
 <20241111093154.zbsp42gfiv2enb5a@ArmHalley.local>
 <a7ebd158-692c-494c-8cc0-a82f9adf4db0@acm.org>
 <20241112135233.2iwgwe443rnuivyb@ubuntu>
 <yq1ed38roc9.fsf@ca-mkp.ca.oracle.com>
 <9d61a62f-6d95-4588-bcd8-de4433a9c1bb@acm.org>
 <yq1plmhv3ah.fsf@ca-mkp.ca.oracle.com>
 <8ef1ec5b-4b39-46db-a4ed-abf88cbba2cd@acm.org>
 <yq1jzcov5am.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1jzcov5am.fsf@ca-mkp.ca.oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_072119_938822_7419406B 
X-CRM114-Status: GOOD (  17.71  )
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

On Wed, Nov 27, 2024 at 03:14:09PM -0500, Martin K. Petersen wrote:
> 
> Bart,
> 
> > Submitting a copy operation as two bios or two requests means that
> > there is a risk that one of the two operations never reaches the block
> > driver at the bottom of the storage stack and hence that a deadlock
> > occurs. I prefer not to introduce any mechanisms that can cause a
> > deadlock.
> 
> How do you copy a block range without offload? You perform a READ to
> read the data into memory. And once the READ completes, you do a WRITE
> of the data to the new location.
> 
> Token-based copy offload works exactly the same way. You do a POPULATE
> TOKEN which is identical to a READ except you get a cookie instead of
> the actual data. And then once you have the cookie, you perform a WRITE
> USING TOKEN to perform the write operation. Semantically, it's exactly
> the same as a normal copy except for the lack of data movement. That's
> the whole point!

I think of copy a little differently. When you do a normal write
command, the host provides the controller a vector of sources and
lengths. A copy command is like a write command, but the sources are
just logical block addresses instead of memory addresses.

Whatever solution happens, it would be a real shame if it doesn't allow
vectored LBAs. The token based source bio doesn't seem to extend to
that.

