Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20253C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Mar 2022 13:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sVyyoetXaxNtSF0yH2Uaw3qxDAccKlQrzLOeEGnFjlg=; b=icaoboEYJO/BUpzCiYid8c1QlW
	3nuVjYKVn9DBn5Y1HCFYwEePsIs/VsfGikGFOtJedNsT4Kg89PWscogR0QYqKXZayAZUxPxvXCH2e
	qEbnKsKi9wAQ4IhuliDpLDHo6HxkK5jPmFTQoZIFf3bpy+JnkX16DBoIWoKWH40BixlVMSXK2osoP
	TYbZ573rCWGtfFu2XS3YVvHG0xtKLPOmHJYd/OazL/jJGSvD5WW6RzcXZ8qnI5gpMQuiVnsT68gDy
	mrlnZWY717eAI+hTMGnpJQvAsJx7jFTMeOBXMm5vZajFc1o0b5s59XC3489laVxPNb6r/uOL6z+dH
	yswYvdGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nZXvd-00FwHF-UO; Wed, 30 Mar 2022 13:00:02 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZXvY-00FwBS-5K
 for linux-nvme@lists.infradead.org; Wed, 30 Mar 2022 12:59:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9CE4A68AA6; Wed, 30 Mar 2022 14:59:47 +0200 (CEST)
Date: Wed, 30 Mar 2022 14:59:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20220330125947.GA1938@lst.de>
References: <20220308152105.309618-18-joshi.k@samsung.com>
 <20220310083652.GF26614@lst.de>
 <CA+1E3rLaQstG8LWUyJrbK5Qz+AnNpOnAyoK-7H5foFm67BJeFA@mail.gmail.com>
 <20220310141945.GA890@lst.de>
 <CA+1E3rL3Q2noHW-cD20SZyo9EqbzjF54F6TgZoUMMuZGkhkqnw@mail.gmail.com>
 <20220311062710.GA17232@lst.de>
 <CA+1E3rLGwHFbdbSTJBfWrw6RLErwcT2zPxGmmWbcLUj2y=16Qg@mail.gmail.com>
 <20220324063218.GC12660@lst.de> <20220325133921.GA13818@test-zns>
 <CA+1E3rJW-NyOtnn2B5CbSusEs46X4O3Qzb_RGtoR1x_aXZfXsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rJW-NyOtnn2B5CbSusEs46X4O3Qzb_RGtoR1x_aXZfXsw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220330_055956_404174_AF55BDA3 
X-CRM114-Status: GOOD (  12.45  )
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

On Mon, Mar 28, 2022 at 10:14:13AM +0530, Kanchan Joshi wrote:
> Thinking a bit more on "(b) big-sqe + big-cqe". Will that also require
> a new ioctl (other than NVME_IOCTL_IO64_CMD) in nvme? Because
> semantics will be slightly different (i.e. not updating the result
> inside the passthrough command but sending it out-of-band to
> io_uring). Or am I just overthinking it.

Again, there should be absolutely no coupling between ioctls and
io_uring async cmds.  The only thing trying to reuse structures or
constants does is to create a lot of confusion.

