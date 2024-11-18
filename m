Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B7AD591A7
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 17:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JVVSFwGvKqsjNvSQj8HeHG8wczEDDM7dA+HovjDtI1E=; b=Kkav9ZxWkUlkhSVDjHPPyicm+U
	ziPmgpAA6Kq8a1EGcgTloZm7qp8OUMBCHeM+KeYLwHnlLVxVUgkl5Gd1zNfWqZDYtSaDAEO5cbK6R
	25TvgpmBZ0acDy7H7cpRAR87hCgd4MGeKebubX+gRliGTJJoNw0Ps5MVrVmtQX8w3xfW8pjafRwl1
	6YcVwFot5wWaGXHgUGBLcOQ51afwv2nqvDSMwZo1JE6FVwAOB7KN1pb7916H+gf9TPtF7uS8iblDN
	EJO0wBxhkb9IxST1R4ibEaoxaL+EgM5l/4e8bi6NxBnUsgRA7A+eYcaWJnbu9KgSmwc7a39AIDiyT
	AEHzzXXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tD5A1-0000000A9cz-19nu;
	Mon, 18 Nov 2024 17:03:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tD59y-0000000A9cH-3SD3
	for linux-nvme@lists.infradead.org;
	Mon, 18 Nov 2024 17:03:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6053068D12; Mon, 18 Nov 2024 18:03:29 +0100 (CET)
Date: Mon, 18 Nov 2024 18:03:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>,
	axboe@kernel.dk, kbusch@kernel.org, martin.petersen@oracle.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
Message-ID: <20241118170329.GA14956@lst.de>
References: <20241114104517.51726-1-anuj20.g@samsung.com> <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com> <20241114104517.51726-7-anuj20.g@samsung.com> <c622ee8c-82f0-44d4-99da-91357af7ecac@gmail.com> <b61e1bfb-a410-4f5f-949d-a56f2d5f7791@gmail.com> <20241118125029.GB27505@lst.de> <2a98aa33-121b-46ed-b4ae-e4049179819a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a98aa33-121b-46ed-b4ae-e4049179819a@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_090335_009432_6B2C600C 
X-CRM114-Status: GOOD (  21.69  )
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

On Mon, Nov 18, 2024 at 04:59:22PM +0000, Pavel Begunkov wrote:
>>
>> Can we please stop overdesigning the f**k out of this?  Really,
>
> Please stop it, it doesn't add weight to your argument. The design
> requirement has never changed, at least not during this patchset
> iterations.

That's what you think because you are overdesigning the hell out of
it.  And at least for me that rings every single alarm bell about
horrible interface design.

>> either we're fine using the space in the extended SQE, or
>> we're fine using a separate opcode, or if we really have to just
>> make it uring_cmd.  But stop making thing being extensible for
>> the sake of being extensible.
>
> It's asked to be extendible because there is a good chance it'll need to
> be extended, and no, I'm not suggesting anyone to implement the entire
> thing, only PI bits is fine.

Extensibility as in having reserved fields that can be checked for
is one thing.  "Extensibility" by adding indirections over indirections
without a concrete use case is another thing.  And we're deep into the
latter phase now.

> And no, it doesn't have to be "this or that" while there are other
> options suggested for consideration. And the problem with the SQE128
> option is not even about SQE128 but how it's placed inside, i.e.
> at a fixed spot.
>
> Do we have technical arguments against the direction in the last
> suggestion?

Yes.  It adds completely pointless indirections and variable offsets.
How do you expect people to actually use that sanely without
introducing bugs left right and center?

I really don't get why you want to make an I/O fast path as complicated
as possible.

