Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF36CC4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Dec 2022 20:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j/661ETT7jvXZ2YUrlW9YzygRkEAgddfmDyMMprNc44=; b=FlUlA5GNf4Oj6ryhYY+eF2Sabm
	kk5Yau8gom3/CAQfuMBedHOMsZiJdnoFaR1MRbL2Yj9fJgxkw7xbihG99CJXzrbBrDCnjOKNrjMTc
	+4igZbEvYiBbj2PlMjmE2j1fP5hRCFcJyVJUOcsYiH4RKr+FGKWaENmkmuZJ4rIO0lnB046foRBGc
	Z9eUU2iCmY5wI+2T5a79t+hm3txhlkX4amTg0qtDVagrAgpeKui9xGYjTAThkJblEOSnE3KAYk2VV
	qRAd/0y4TXddr1bNAWhvndp9pQCGJRN+l5A5/wGQS7u+Qsxcrfp7RohcFuM6VVFJmWPiBFxV0FkTb
	FyuEMP3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3N6E-00ACY0-Sn; Thu, 08 Dec 2022 20:02:30 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3N68-00ACVT-G4
	for linux-nvme@bombadil.infradead.org; Thu, 08 Dec 2022 20:02:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=j/661ETT7jvXZ2YUrlW9YzygRkEAgddfmDyMMprNc44=; b=nxLf4cAhEoBid8iykXBDVaVzoE
	V3J6KRKK8OcKs+nM+YpiSidOTJRdpKfVOQ7cx/UVBaqH7+kjW9L4CeJPhyILxXcxHrKHxpOOFyyHu
	W4mEKspnv1q4lAX47QWMxy9my3xssP63wPi0nGNMwfUaVZKhlFBk+/Gtvp8QYdYtnFdAtH13tHRXN
	lIJyUuQ/TxM9XJ5LbkZMXsAEW7h8VDNLsnGY3x+8LNxKfOXN3aKoNBWw5WBtLdXTPwJ5Lb0JRduzc
	8Me2W7mdNbQkJAXq+BUTRkkPHK/rVB6y5YUve3LM7ua8BsCMwnjcDVy3c4r0Wd+XWJfIJ5cvICPjA
	dlYCUmaA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3N69-007HEG-5p; Thu, 08 Dec 2022 20:02:25 +0000
Date: Thu, 8 Dec 2022 20:02:25 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk, djwong@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	Johannes.Thumshirn@wdc.com, bvanassche@acm.org,
	dongli.zhang@oracle.com, jefflexu@linux.alibaba.com,
	josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, jack@suse.com,
	tytso@mit.edu, adilger.kernel@dilger.ca, jlayton@kernel.org,
	idryomov@gmail.com, danil.kipnis@cloud.ionos.com,
	ebiggers@google.com, jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Message-ID: <Y5JC0Q3dOLS1g70/@casper.infradead.org>
References: <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com>
 <4F15C752-AE73-4F10-B5DD-C37353782111@javigon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4F15C752-AE73-4F10-B5DD-C37353782111@javigon.com>
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

On Sat, Dec 03, 2022 at 07:19:17AM +0300, Javier González wrote:
> > On 2 Dec 2022, at 17.58, Keith Busch <kbusch@kernel.org> wrote:
> > As long as the protocols don't provide proof-of-work, trying this
> > doesn't really prove anything with respect to this concern.
> 
> Is this something we should bring to NVMe? Seems like the main disagreement can be addressed there. 
> 
> I will check internally if there is any existing proof-of-work that we are missing. 

I think the right thing for NVMe to standardise is a new command, HASH.

It should be quite similar to the READ command, at least for command
Dwords 10-15.  Need to specify the hash algorithm to use somewhere
(maybe it's a per-namespace setting, maybe a per-command setting).
The ctte will have to decide which hash algos are permitted / required
(it probably makes sense to permit even some quite weak hashes as we're
not necessarily looking to have cryptographic security).

While there may be ways to make use of this command for its obvious usage
(ie actually producing a hash and communicating that to somebody else),
its real purpose is for the drive to read the data from storage and prove
it's still there without transferring it to the host, as discussed in
this thread.

