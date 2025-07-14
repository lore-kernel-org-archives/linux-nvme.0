Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AEDC83F21
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 13:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=czBUTEEl6Gw7IKindFaK1YcrN9r3/Sl2wLQw5Z+YuxA=; b=c9/8cOjktMCTVkkDiArbF3M68x
	YmkHHLaL794CnKqmFXD8667UG9FpR8423+gZ2ZFNZ/07tSt37kBvIhOSphRjKPMJvGwo8FlQIx/lg
	adfn4hoYIekGvVv6QxBTYMw+sSBGiPxAc1/pvOwYr54hIKRWJY8H2P/6g/WBndETwJyP2ZDs7sDiG
	Omx401yld+dgNjz+9g9u0kglRbqUP1FEm3p5M1zk9ycd4/xPiCgQbxbjGoix/ZK1fJaEf0qMHpV41
	qQH8GejBGkkaMoQVfA/Xc8DP/D6TVidV63MF8IrEX1RHE62Uv5LWBqwMDzsVXUynCBVJj7tT0d++4
	jloauteg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJfA-00000002NiO-3okB;
	Mon, 14 Jul 2025 13:56:12 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJZI-00000002MhE-43OO;
	Mon, 14 Jul 2025 13:50:08 +0000
Date: Mon, 14 Jul 2025 06:50:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <aHULEGt3d0niAz2e@infradead.org>
References: <20250714131713.GA8742@lst.de>
 <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com>
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

On Mon, Jul 14, 2025 at 02:39:54PM +0100, John Garry wrote:
> On 14/07/2025 14:17, Christoph Hellwig wrote:
> > Hi all,
> > 
> > I'm currently trying to sort out the nvme atomics limits mess, and
> > between that, the lack of a atomic write command in nvme, and the
> > overall degrading quality of cheap consumer nvme devices I'm starting
> > to free really uneasy about XFS using hardware atomics by default without
> > an explicit opt-in, as broken atomics implementations will lead to
> > really subtle data corruption.
> > 
> > Is is just me, or would it be a good idea to require an explicit
> > opt-in to user hardware atomics?
> 
> But isn't this just an NVMe issue? I would assume that we would look at such
> an option in the NVMe driver (to opt in when we are concerned about the
> implementation), and not the FS. SCSI is ok AFAIK.

SCSI is a better standard, and modulo USB devices doesn't have as much
of an issue with cheap consumer devices.

But form the file system POV we've spent the last decade or so hardening
file systems against hardware failures, so now suddenly using such a
high risk feature automatically feels a bit odd.


