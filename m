Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B460C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 06:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8hpldEiv7E0ISduQzcywW6z+soQWFatLXs4NKmpdyCo=; b=h++IMsfQnEkVTt6pW2I7hfAcgC
	Uff+SjTjbF/rX2uSV/eLNDaW2u9ltijNzDUkbBpBW8P+vxDK51U03gFZgWilZFsmZTPPklp8/YOnE
	87mCrTVShigFx7uJSjyzfVJYzSW4eEbKva+kdTr9MTrv7uoWsrEL9lMW4ZSAzGqc0hq86/Q08jtt5
	eU5TyjvUWLVqUTj8MunVAcGFGTZqhahF66fX3mcZMrvYBWCxmd7b+pK6oeEcHYHqxhnaA8U8NlCq8
	FtXMP+vXdhyjXyFBCHaTW8Bd+X0p1KzBhQWzWxIKZBesl6xB3HP8qhIl5ixVMj0KEPT1TxkzxgQAm
	wN7ZUfPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXH1E-00FqUO-BH; Thu, 24 Mar 2022 06:32:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXH1B-00FqSw-Bu
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 06:32:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9AC0068B05; Thu, 24 Mar 2022 07:32:18 +0100 (CET)
Date: Thu, 24 Mar 2022 07:32:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com,
 Pankaj Raghav <pankydev8@gmail.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
Message-ID: <20220324063218.GC12660@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152729epcas5p17e82d59c68076eb46b5ef658619d65e3@epcas5p1.samsung.com>
 <20220308152105.309618-18-joshi.k@samsung.com>
 <20220310083652.GF26614@lst.de>
 <CA+1E3rLaQstG8LWUyJrbK5Qz+AnNpOnAyoK-7H5foFm67BJeFA@mail.gmail.com>
 <20220310141945.GA890@lst.de>
 <CA+1E3rL3Q2noHW-cD20SZyo9EqbzjF54F6TgZoUMMuZGkhkqnw@mail.gmail.com>
 <20220311062710.GA17232@lst.de>
 <CA+1E3rLGwHFbdbSTJBfWrw6RLErwcT2zPxGmmWbcLUj2y=16Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rLGwHFbdbSTJBfWrw6RLErwcT2zPxGmmWbcLUj2y=16Qg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_233221_593096_6C14BF89 
X-CRM114-Status: GOOD (  20.44  )
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

On Tue, Mar 22, 2022 at 10:40:27PM +0530, Kanchan Joshi wrote:
> On Fri, Mar 11, 2022 at 11:57 AM Christoph Hellwig <hch@lst.de> wrote:
> > > And that's because this ioctl requires additional "__u64 result;" to
> > > be updated within "struct nvme_passthru_cmd64".
> > > To update that during completion, we need, at the least, the result
> > > field to be a pointer "__u64 result_ptr" inside the struct
> > > nvme_passthru_cmd64.
> > > Do you see that is possible without adding a new passthru ioctl in nvme?
> >
> > We don't need a new passthrough ioctl in nvme.
> Right. Maybe it is easier for applications if they get to use the same
> ioctl opcode/structure that they know well already.

I disagree.  Reusing the same opcode and/or structure for something
fundamentally different creates major confusion.  Don't do it.

> >From all that we discussed, maybe the path forward could be this:
> - inline-cmd/big-sqe is useful if paired with big-cqe. Drop big-sqe
> for now if we cannot go the big-cqe route.
> - use only indirect-cmd as this requires nothing special, just regular
> sqe and cqe. We can support all passthru commands with a lot less
> code. No new ioctl in nvme, so same semantics. For common commands
> (i.e. read/write) we can still avoid updating the result (put_user
> cost will go).
> 
> Please suggest if we should approach this any differently in v2.

Personally I think larger SQEs and CQEs are the only sensible interface
here.  Everything else just fails like a horrible hack I would not want
to support in NVMe.

