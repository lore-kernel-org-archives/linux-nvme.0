Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2AAD16261
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 13:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4DEYUTcQwFLqCeLZ2DzH9lYrtkEYv7RGZGQFdHkF8BU=; b=ijeY8nWEpr2/1+gP7pitvF0iE2
	Gi1a3dhg0UOnMI3CbxxbFRlLyxPArSpxawG5EzgeV9q7NFtBUTeM3TC+gaVg9P4yYUvIGbFeH4X8R
	vCUEWRJM0KoEasu6nGA+Rums0mBgEOQeG86/n3briCB+JUhbNKbxPy0en2jQeHvccO2j3+jsz22W+
	bwIDc9nYsE5BlCJP6y5NA1JOHYF0g6yIyAmwN3gws9YZnD84qdN7oB7vvzTiTBoYqhRANSjJSWP5r
	MmP8MeIxTDc2TZpCKvZco1qpXMRAysUronuwF9h/+GnlNcVhFjD+SKRPrE8XxmOhRtS87xTnCAV0V
	GBBmY93w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0L8o-00000005Hfl-1raR;
	Mon, 14 Oct 2024 13:29:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0JbF-00000004zMD-1WUm
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 11:50:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 885C6227AA8; Mon, 14 Oct 2024 13:50:52 +0200 (CEST)
Date: Mon, 14 Oct 2024 13:50:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Javier Gonzalez <javier.gonz@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>, "hare@suse.de" <hare@suse.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jack@suse.cz" <jack@suse.cz>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"bcrl@kvack.org" <bcrl@kvack.org>,
	"dhowells@redhat.com" <dhowells@redhat.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"asml.silence@gmail.com" <asml.silence@gmail.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-aio@kvack.org" <linux-aio@kvack.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>,
	"vishak.g@samsung.com" <vishak.g@samsung.com>
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241014115052.GA32302@lst.de>
References: <CGME20241010070738eucas1p2057209e5f669f37ca586ad4a619289ed@eucas1p2.samsung.com> <20241010070736.de32zgad4qmfohhe@ArmHalley.local> <20241010091333.GB9287@lst.de> <20241010115914.eokdnq2cmcvwoeis@ArmHalley.local> <20241011090224.GC4039@lst.de> <5e9f7f1c-48fd-477f-b4ba-c94e6b50b56f@kernel.dk> <20241014062125.GA21033@lst.de> <34d3ad68068f4f87bf0a61ea8fb8f217@CAMSVWEXC02.scsc.local> <20241014074708.GA22575@lst.de> <9e3792eebf7f427db7c466374972fb99@CAMSVWEXC02.scsc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e3792eebf7f427db7c466374972fb99@CAMSVWEXC02.scsc.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_045057_571926_B62C5C48 
X-CRM114-Status: GOOD (  27.11  )
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

On Mon, Oct 14, 2024 at 09:08:24AM +0000, Javier Gonzalez wrote:

[can you fix your mailer please, no full quotes, and especially not
quotes of the mail headers]

> > What do you gain from that?  NVMe does not understand data temperatures,
> > so why make up that claim?  
> 
> I expressed this a couple of times in this thread. It is no problem to
> map temperatures to a protocol that does not understand the semantics.

And I've agreed every time with you.  But the important point is that we
must not do it in the driver where all context is lost.

> > Especially as it directly undermindes any file system work to actually make use of it.
> 
> I do not think it does. If a FS wants to use the temperatures, then they
> would be able to leverage FDP besides SCSI.

What do you mean with that?  This is a bit too much whitepaper vocabularly.

We have code in XFS that can make use of the temperature hint.  But to
make them work it actually needs to do real stream separation on the
device.  I.e. the file system consumes the temperature hints.


> And if we come up with a better interface later on, we can make the changes then.
> I really do not see the issue. If we were adding a temperature abstraction now, I would agree with
> You that we would need to cover the use-case you mention for FSs from the beginning, but this
> Is already here. Seems like a fair compromise to support current users.

Again, I think the temperature hints at the syscall level aren't all
bad.  There's definitively a few things I'd like to do better in hindsight,
but that's not the point.  The problem is trying to turn them into
stream separation all the way down in the driver, which is fundamentally
broken.

>   - How do we convince VFS folks to give us more space for hints at this point?

What space from VFS folks do you need for hints?  And why does it
matter?


