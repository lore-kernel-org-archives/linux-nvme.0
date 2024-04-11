Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AE9C4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Apr 2024 19:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PcZdbAxSEwXG3C61TyMUijUHCCvRVt8slQPN1FDjo1k=; b=LqyTZ9YfC+gRQt2cwdt/TMUo+Q
	npMRvVegcV0g7rvMCkfl02Lrc2MiFp3prQ9vTUQ2ocFndwpk6k0FdCsQpCm9oPA6NjHZnsPR6l6aR
	NkQxusDZY/fhzDFm8J+GQZnjC6c4/6ewbqfkK7cHNSALI8fiSOv3EHzjsB2ChJtqUh5BC7B3y2iDO
	oLQ+KjUt0LsdIm0+Y6AOdlGB2jKEmqDxnaF9RrteG3jAaPXo3El3pGx8RcBI1YNvECRbBXSZ/+xPr
	8vXNqUTbQGSgV27BAOCBu3IHXKob/Gfw0m24ZR4W70A4uLQc+btidXGEX6JOgphlUH3ekdGiTeio/
	1VFKQK3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruzlv-0000000Dp2v-2VCK;
	Thu, 11 Apr 2024 19:07:43 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruzls-0000000Dp2X-0ZEf;
	Thu, 11 Apr 2024 19:07:40 +0000
Date: Thu, 11 Apr 2024 12:07:40 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <Zhg0_Pvlh9zy4zzG@bombadil.infradead.org>
References: <20240326133813.3224593-1-john.g.garry@oracle.com>
 <ZgOXb_oZjsUU12YL@casper.infradead.org>
 <c4c0dad5-41a4-44b4-8f40-2a250571180b@oracle.com>
 <Zg7Z4aJtn3SxY5w1@casper.infradead.org>
 <f3c1d321-0dfc-466f-9f6a-fe2f0513d944@oracle.com>
 <ZhQud1NbO4aMt0MH@bombadil.infradead.org>
 <b0789a97-7dcf-48aa-9980-8525942dabfa@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0789a97-7dcf-48aa-9980-8525942dabfa@oracle.com>
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

On Wed, Apr 10, 2024 at 09:34:36AM +0100, John Garry wrote:
> On 08/04/2024 18:50, Luis Chamberlain wrote:
> > I agree that when you don't set the sector size to 16k you are not forcing the
> > filesystem to use 16k IOs, the metadata can still be 4k. But when you
> > use a 16k sector size, the 16k IOs should be respected by the
> > filesystem.
> > 
> > Do we break BIOs to below a min order if the sector size is also set to
> > 16k?  I haven't seen that and its unclear when or how that could happen.
> 
> AFAICS, the only guarantee is to not split below LBS.

It would be odd to split a BIO given a inode requirement size spelled
out, but indeed I don't recall verifying this gaurantee.

> > At least for NVMe we don't need to yell to a device to inform it we want
> > a 16k IO issued to it to be atomic, if we read that it has the
> > capability for it, it just does it. The IO verificaiton can be done with
> > blkalgn [0].
> > 
> > Does SCSI*require*  an 16k atomic prep work, or can it be done implicitly?
> > Does it need WRITE_ATOMIC_16?
> 
> physical block size is what we can implicitly write atomically.

Yes, and also on flash to avoid read modify writes.

> So if you
> have a 4K PBS and 512B LBS, then WRITE_ATOMIC_16 would be required to write
> 16KB atomically.

Ugh. Why does SCSI requires a special command for this?

Now we know what would be needed to bump the physical block size, it is
certainly a different feature, however I think it would be good to
evaluate that world too. For NVMe we don't have such special write
requirements.

I put together this kludge with the last patches series of LBS + the
bdev cache aops stuff (which as I said before needs an alternative
solution) and just the scsi atomics topology + physical block size
change to easily experiment to see what would break:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20240408-lbs-scsi-kludge

Using a larger sector size works but it does not use the special scsi
atomic write.

> > > To me, O_ATOMIC would be required for buffered atomic writes IO, as we want
> > > a fixed-sized IO, so that would mean no mixing of atomic and non-atomic IO.
> > Would using the same min and max order for the inode work instead?
> 
> Maybe, I would need to check further.

I'd be happy to help review too.

  Luis

