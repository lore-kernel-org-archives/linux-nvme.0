Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C422C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 15:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ror5jpKvnBeoTVJlMIHZkXCUWDwuNdZgowR+xALiX+I=; b=38KJcVGgp26qpDkmWabIzmfP/a
	WCWywmiYIR79XrTJ6c8w8/JiOb5PJtFsvMw1L+2/u5+U91thozDQxrm8AcPMOk6lkXP+GI5/sg667
	Y5n17kwvXi7NtjbXtwgYvpqTh89DB3fAN2m6THlK+V1IIXzOxk1ygqBib55shS5R7/BcDPTMSkKo5
	38zHYMkPn7cT2q6NKjyhUiENarG+i6cdUPnV5awuhAQF3VNYF+HZDDpWn0xHf/2iu9OV00UvAmdvh
	0SiNfBN6bw51X+RJuvyLei12Az9w0D5+39uSveEdmocuJnzbNJulYWDOay00kuYCZrnhDlk7mLpLs
	cjmnPLnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDRPE-00FJHC-2U;
	Wed, 13 Dec 2023 15:44:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDRPC-00FJGo-0h
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 15:44:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3036768B05; Wed, 13 Dec 2023 16:44:09 +0100 (CET)
Date: Wed, 13 Dec 2023 16:44:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20231213154409.GA7724@lst.de>
References: <20231212110844.19698-1-john.g.garry@oracle.com> <20231212163246.GA24594@lst.de> <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_074414_541275_E1BBA198 
X-CRM114-Status: GOOD (  34.35  )
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

On Wed, Dec 13, 2023 at 09:32:06AM +0000, John Garry wrote:
>>> - How to make API extensible for when we have no HW support? In that case,
>>>    we would prob not have to follow rule of power-of-2 length et al.
>>>    As a possible solution, maybe we can say that atomic writes are
>>>    supported for the file via statx, but not set unit_min and max values,
>>>    and this means that writes need to be just FS block aligned there.
>> I don't think the power of two length is much of a problem to be
>> honest, and if we every want to lift it we can still do that easily
>> by adding a new flag or limit.
>
> ok, but it would be nice to have some idea on what that flag or limit 
> change would be.

That would require a concrete use case.  The simples thing for a file
system that can or does log I/O it would simply be a flag waving all
the alignment and size requirements.

>> I suspect we need an on-disk flag that forces allocations to be
>> aligned to the atomic write limit, in some ways similar how the
>> XFS rt flag works.  You'd need to set it on an empty file, and all
>> allocations after that are guaranteed to be properly aligned.
>
> Hmmm... so how is this different to the XFS forcealign feature?

Maybe not much.  But that's not what it is about - we need a common
API for this and not some XFS internal flag.  So if this is something
we could support in ext4 as well that would be a good step.  And for
btrfs you'd probably want to support something like it in nocow mode
if people care enough, or always support atomics and write out of
place.

> For XFS, I thought that your idea was to always CoW new extents for 
> misaligned extents or writes which spanned multiple extents.

Well, that is useful for two things:

 - atomic writes on hardware that does not support it
 - atomic writes for bufferd I/O
 - supporting other sizes / alignments than the strict power of
   two above.

> Right, so we should limit atomic write queue limits to max_hw_sectors. But 
> people can still tweak max_sectors, and I am inclined to say that 
> atomic_write_unit_max et al should be (dynamically) limited to max_sectors 
> also.

Allowing people to tweak it seems to be asking for trouble.

>> have that silly limit.  For NVMe that would require SGL support
>> (and some driver changes I've been wanting to make for long where
>> we always use SGLs for transfers larger than a single PRP if supported)
>
> If we could avoid dealing with a virt boundary, then that would be nice.
>
> Are there any patches yet for the change to always use SGLs for transfers 
> larger than a single PRP?

No.

> On a related topic, I am not sure about how - or if we even should - 
> enforce iovec PAGE-alignment or length; rather, the user could just be 
> advised that iovecs must be PAGE-aligned and min PAGE length to achieve 
> atomic_write_unit_max.

Anything that just advices the user an it not clear cut and results in
an error is data loss waiting to happen.  Even more so if it differs
from device to device.

