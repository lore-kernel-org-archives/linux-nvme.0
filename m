Return-Path: <SRS0=mQhi=PX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80236C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Nov 2021 17:36:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454B261168
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Nov 2021 17:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 454B261168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0ncTjk8q8mGMskQIfML9hDL7I34yY3dY42Zfvbi7AMQ=; b=tFB+mjf4OYz/VQSYPBzyPWRl33
	NmKm9qVjXTHC7lhoMMhOmk99oML0RbCAlnNb8+8AmN2o23s8SwKy7d59ij8e6l+xhVijEXlJVxbJI
	XlNEylJaE8dWeog1CSA6MbGMZl1nahtVb6rUMgN0ck/IvetHfDND3V8xmfSziQdexn0ZVYKjoNfzj
	P6EBQMXKT+yeVRQNIBjIOmFIT6UR0F+MKELL1BR2gETgOj1NMktFHQ8oYbnuPv0ZMNvyChlrn8+cp
	YkEdr8yJzp+G49rrcE8T0mRNNstr8wMw3wHT7V7p1aPUVyW8eDB236SV1i/MNytpqceQXs9ZmUaxV
	x8bPWPsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1migfS-009gfW-Lv; Thu, 04 Nov 2021 17:36:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1migbM-009fxi-QM
 for linux-nvme@lists.infradead.org; Thu, 04 Nov 2021 17:32:38 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51D5260EBC;
 Thu,  4 Nov 2021 17:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636047156;
 bh=olcBI4ItJW+ZApb9VTb2WM6OA4AiudQzwwdIT5YvDdE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JhMQy3W5g7qCDUiwWs1nl+6M7P3LZ/4qQP5Ud6eq5y4YMcR8asU5O10PEmPYFyRti
 CuUgL2xu0HPaFw3WxXNZfa5WIG7vg+uEeM2B1h1KbwOmhT7mIEqJxH6h7v2lhpbWq0
 RiifL7GcALWUnHkRw7tHI/3W9qe8aBXrPm/0+JsQYxzu8Xy/Ig6jVWcjI2BOxlOws1
 g3NsSD+5GqoyqUtHa6V4nP1fUEIpEo4zH0MbXJMvs6RLAn4czyFyAiQnw/pNPOu05Y
 3PBpu8mZnMCkX1JYlKwSlJal1ODYgR2TWQjnshLxbuvHIxcQtflrpl7shJIZO8Fw5y
 wwXGHnQF2e7+g==
Date: Thu, 4 Nov 2021 10:32:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "agk@redhat.com" <agk@redhat.com>,
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "song@kernel.org" <song@kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "javier@javigon.com" <javier@javigon.com>,
 "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
 "bvanassche@acm.org" <bvanassche@acm.org>,
 "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "osandov@fb.com" <osandov@fb.com>,
 "willy@infradead.org" <willy@infradead.org>,
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
Subject: Re: [RFC PATCH 0/8] block: add support for REQ_OP_VERIFY
Message-ID: <20211104173235.GI2237511@magnolia>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
 <20211104071439.GA21927@lst.de>
 <661bcadd-a030-4a72-81ae-ef15080f0241@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <661bcadd-a030-4a72-81ae-ef15080f0241@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211104_103236_926020_A69E59E6 
X-CRM114-Status: GOOD (  15.72  )
X-Mailman-Approved-At: Thu, 04 Nov 2021 10:36:49 -0700
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

On Thu, Nov 04, 2021 at 09:27:50AM +0000, Chaitanya Kulkarni wrote:
> On 11/4/2021 12:14 AM, Christoph Hellwig wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > What is the actual use case here?
> > 
> 
> One of the immediate use-case is to use this interface with XFS 
> scrubbing infrastructure [1] (by replacing any SCSI calls e.g. sg_io() 
> with BLKVERIFY ioctl() calls corresponding to REQ_OP_VERIFY) and 
> eventually allow and extend other file systems to use it for scrubbing.

FWIW it /would/ be a win to have a general blkdev ioctl to do this,
rather than shoving SCSI commands through /dev/sg, which (obviously)
doesn't work when dm and friends are in use.  I hadn't bothered to wire
up xfs_scrub to NVME COMPARE because none of my devices support it and
tbh I was holding out for this kind of interface anyway. ;)

I also wonder if it would be useful (since we're already having a
discussion elsewhere about data integrity syscalls for pmem) to be able
to call this sort of thing against files?  In which case we'd want
another preadv2 flag or something, and then plumb all that through the
vfs/iomap as needed?

--D

> [1] man xfs_scrub :-
> -x     Read all file data extents to look for disk errors.
>                xfs_scrub will issue O_DIRECT reads to the block device
>                directly.  If the block device is a SCSI disk, it will
>                instead issue READ VERIFY commands directly to the disk.
>                If media errors are found, the error report will include
>                the disk offset, in bytes.  If the media errors affect a
>                file, the report will also include the inode number and
>                file offset, in bytes.  These actions will confirm that
>                all file data blocks can be read from storage.
> 
> 

