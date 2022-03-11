Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9034C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 06:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PsMErvKwsRPd5heS+kot0RuQXVXHKYyZQ0neMCDX2w8=; b=OCLhnIUNh7LOx2wB23lobSUtIj
	SXSAtigAuDC5M8t5ZPfWcpwHboHYS4DrtDHEFrj7eeDhsLE3FJ5PIFKLPT82hrM2wO34Jyhjt+Zad
	fDDwuPJvLFdO6bWELj+AXvK8DVOsky4LRBnlHQGRwmz8uLfIshZzOfLZ7IrJidF9+68aMVB9jLDBp
	00q7VDKCuzItpkwgTe2GSt4VFOomhJA/j26/dhd9GWT8NsTS8RcxmEyLO27/WsUw0JSpaKA/4d9Nm
	mQQMc9q8nEZ+MdRioROyjjKXYPvJfllM2/WWspZ0vtzYY1PftadlOUKMzq94V8koZDzHx1El6CZuB
	1UAssOgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSYkA-00FErA-Pt; Fri, 11 Mar 2022 06:27:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSYk8-00FEqk-4X
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 06:27:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3664F68AFE; Fri, 11 Mar 2022 07:27:11 +0100 (CET)
Date: Fri, 11 Mar 2022 07:27:10 +0100
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
Message-ID: <20220311062710.GA17232@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152729epcas5p17e82d59c68076eb46b5ef658619d65e3@epcas5p1.samsung.com>
 <20220308152105.309618-18-joshi.k@samsung.com>
 <20220310083652.GF26614@lst.de>
 <CA+1E3rLaQstG8LWUyJrbK5Qz+AnNpOnAyoK-7H5foFm67BJeFA@mail.gmail.com>
 <20220310141945.GA890@lst.de>
 <CA+1E3rL3Q2noHW-cD20SZyo9EqbzjF54F6TgZoUMMuZGkhkqnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rL3Q2noHW-cD20SZyo9EqbzjF54F6TgZoUMMuZGkhkqnw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_222716_353137_7BA2A1C9 
X-CRM114-Status: GOOD (  13.76  )
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

On Fri, Mar 11, 2022 at 12:13:24AM +0530, Kanchan Joshi wrote:
> Problem is, the inline facility does not go very well with this
> particular nvme-passthru ioctl (NVME_IOCTL_IO64_CMD).

And it doesn't have to, because there is absolutely no need to reuse
the existing structures!  Quite to the contrary, trying to reuse the
structure and opcode makes things confusing as hell.

> And that's because this ioctl requires additional "__u64 result;" to
> be updated within "struct nvme_passthru_cmd64".
> To update that during completion, we need, at the least, the result
> field to be a pointer "__u64 result_ptr" inside the struct
> nvme_passthru_cmd64.
> Do you see that is possible without adding a new passthru ioctl in nvme?

We don't need a new passthrough ioctl in nvme.  We need to decouple the
uring cmd properly.  And properly in this case means not to add a
result pointer, but to drop the result from the _input_ structure
entirely, and instead optionally support a larger CQ entry that contains
it, just like the first patch does for the SQ.

