Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5E5CFC266
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 05:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KEQh/wo0eem9EIRjWMt49gLuZ4ToAG+IeRjFJfJKxDo=; b=Y80YJBth/pkPF8iQDzoZ/sjF0A
	ndDhsM/R6IlPbUnzGlBRBYxkZNO0xnusydvutFhtpQyGURRyZaJXVSGlZ/ZQj70F5eBW4NSSiLS9I
	ivKO6Zh+k+IdKwT7Rego/tNHUiqo3ejgWNDJruNgt4wnBCHsvfqZJjfx/sSysoAkfQ6IK5MRYyf1N
	XwDz5YovDANUdT/hyJIoIx4tkYfnlKEtM/oamHuwimTp9L9npbeezwbACOjn1m0nYeG1iXeRuFI4G
	V0m5+xXwoIBpdKo2Sa3AWwOeC5E7Lc0Q7l1JTnDLBx4SU+trDxpmiOFiP85DJCEfgANsOxBEonCHf
	BjDMl7WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0a8T-000000076dr-2Jb5;
	Tue, 15 Oct 2024 05:30:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0a8P-000000076dO-3ERg
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 05:30:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7BC57227AA8; Tue, 15 Oct 2024 07:30:13 +0200 (CEST)
Date: Tue, 15 Oct 2024 07:30:13 +0200
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
Message-ID: <20241015053013.GA18580@lst.de>
References: <20241010091333.GB9287@lst.de> <20241010115914.eokdnq2cmcvwoeis@ArmHalley.local> <20241011090224.GC4039@lst.de> <5e9f7f1c-48fd-477f-b4ba-c94e6b50b56f@kernel.dk> <20241014062125.GA21033@lst.de> <34d3ad68068f4f87bf0a61ea8fb8f217@CAMSVWEXC02.scsc.local> <20241014074708.GA22575@lst.de> <9e3792eebf7f427db7c466374972fb99@CAMSVWEXC02.scsc.local> <20241014115052.GA32302@lst.de> <c0675721048d4b0a9a654e2e1669ad60@CAMSVWEXC02.scsc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0675721048d4b0a9a654e2e1669ad60@CAMSVWEXC02.scsc.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_223017_985296_ACCD5BBD 
X-CRM114-Status: GOOD (  27.13  )
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

On Tue, Oct 15, 2024 at 03:07:57AM +0000, Javier Gonzalez wrote:
> > On Mon, Oct 14, 2024 at 09:08:24AM +0000, Javier Gonzalez wrote:
> > > > Especially as it directly undermindes any file system work to actually make use
> > of it.
> > >
> > > I do not think it does. If a FS wants to use the temperatures, then they
> > > would be able to leverage FDP besides SCSI.
> > 
> > What do you mean with that?  This is a bit too much whitepaper vocabularly.
> > 
> > We have code in XFS that can make use of the temperature hint.  But to
> > make them work it actually needs to do real stream separation on the
> > device.  I.e. the file system consumes the temperature hints.
> 
> The device can guarantee the stream separation without knowing the temperature.

Of course.  But that's entirely not the point.

> > What space from VFS folks do you need for hints?  And why does it
> > matter?
> 
> We need space in the inode to store the hint ID.
> 
> Look, this feels like going in circles. All this gaslighting is what makes it difficult to 

I'm so fucking tired of this.  You are not even listening to my arguments
at all, even when explaing every detail to you again and again.  And then
you acuse me of "gaslighting". 

> push patches when you just do not like the feature. It is the 3rd time I propose you 
> a way forward and you simply cannot provide any specific technical feedback - in the 
> past email I posted several questions about the interface you seem to be talking 
> about and you explicitly omit that.

???

You are throwing random buzzwords and not even replying to all the
low level technical points.  If you think I missed something please
just ask again instead of this crap.

