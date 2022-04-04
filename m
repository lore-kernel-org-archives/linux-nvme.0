Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8839C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 16:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:Mime-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y6KHhDh8XVbITNKpPkBdfRMqiixqEimY4/vwsj86fOY=; b=fq+Rh6SJ2OQUdFtAbvufZLZFdb
	qZ3peg5Qc/nqVYc+OE0+lwd4tctJSHmK/Gtt1FOMhmyBnzc3UMLcPnbgx5SAUwE9eJaoDpTaJGso7
	LU1xf/aKorf831A4mZOsPmpO5Rr7kXR6xi02zsNqh65V+DsedkLcpKZfpKlrx0CUiTG/Ha+biOP+2
	GtJN27rQ2Afiv8JIiElIzalXacOLUx3jEdzBYxAznxfeabT3QHQ1tHzw1UhTZtD0teY9ApIyRVxD+
	pOU3WNtBuLbxdtFOE701bgmkoLGaoME+kSP8W/RD3l6lS0hQfq4U/FVETCWtYgbnJSgCTYAkGxq9E
	aZD3I9/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbPEJ-00Fimk-He; Mon, 04 Apr 2022 16:06:59 +0000
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbPBM-00Fh6f-EW; Mon, 04 Apr 2022 16:03:58 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 833493202095;
 Mon,  4 Apr 2022 12:03:49 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute2.internal (MEProxy); Mon, 04 Apr 2022 12:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm1; bh=Y6KHhDh8XVbITNKpPkBdfRMqiixqEi
 mY4/vwsj86fOY=; b=Wtpvwzu9NelImDQlw+nG7GantCLueWJRosM6qGR2PtbZiN
 XbVKQ23pDtKfWOVOSNGB4CoP4M9TwjGuV2sb+VRA+TEIpczs/odES+yA0EW6gxRe
 3SR9p/F4L5CeX0yMtQYO5TxxWX0L69gztC+OaEQ6mIyAwdDpYwhrBHx1DThd9UJJ
 c5VAWqnJNX50IAc3UOyk1rk5rfDnhnUypProCJL7Gx1OuGTOA+w9ODbqrLVrUFB4
 RPmFTkL8W6/c6ggtQvwX4kiEdfUKTnmcDJFW2mv/yAU2p+VeLhEx3uAkjpce8FLJ
 iH+maBYgBCyvYZ+e7exFwAYbrTbUpydBKUrGNJsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Y6KHhDh8XVbITNKpP
 kBdfRMqiixqEimY4/vwsj86fOY=; b=k8uYT3/KIGaYjbi3384GuWSMawdmLMMGN
 eQZzj5VIP0HsjkKU9kEXOckaeGlmXLigB+ZvSPoOtUduzaoxgEvqBP+veI+Q+4Br
 3rZ6svyRpy1gHJOi/cI+HjQblGTaj3J1Dlim1FT5AWGH0aQsvKrVAbO0LiLfKpLP
 eWFY+HKd95YUsmooHA6h6UrUh3xJ0/w6/Or5t+X2cuimR5kltaZzyNFfrm3KUO84
 kVGRs2rRtBM3nP1dptQJda3gTEBZJs6Duo7HmR6yLldNpmWiOQ//mqTlJiTdeVjR
 BNsd6dP27wkhMaNbTnK65THDUXCOSYGx+MpnIY09NudPqpY8ErHbQ==
X-ME-Sender: <xms:5BZLYrB0oVJ_AdOhl7MT6nrFvkfMW_RlXzByJuDmXqcyQ8ychIzVrg>
 <xme:5BZLYhjryrcYA1Eouncutb2VbkL4KxL_SOikEWMe8c8P5IY-0qVracCqxSwr8RUfP
 p_crC2GZvPmpyRT6Qo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejvddgledvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
 feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:5BZLYmkBHhLTBnEtix5ByuVEMab4gE2T1jt6AdMcN81BwXQaqBpfGQ>
 <xmx:5BZLYtxbukuoYftzS7EwAPtDtQHMfx7nJPg9aZq0MdsI07v5dqdL9g>
 <xmx:5BZLYgSJ9F99zjKbe4bUYU0cSkk5aRGteqYtigjMjygVG_Tlo9r87A>
 <xmx:5RZLYlJkX2yDbzm3X31BJFrmxiMMjjHySRlCWZqkyMDI8OOhZUpvEw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 73F2827407D4; Mon,  4 Apr 2022 12:03:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <cc74471b-8077-4c52-8607-eb7d2ecccd7a@www.fastmail.com>
In-Reply-To: <20220404155924.GA9764@lst.de>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-7-sven@svenpeter.dev> <20220324061620.GA12330@lst.de>
 <18f3a7e6-16d1-2037-90e7-1c0b1b2fbb1c@marcan.st>
 <20220404155924.GA9764@lst.de>
Date: Mon, 04 Apr 2022 18:03:28 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "hch@lst.de" <hch@lst.de>, "Hector Martin" <marcan@marcan.st>
Cc: "Keith Busch" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Rob Herring" <robh+dt@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
 "Marc Zyngier" <maz@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_090356_731162_7BD822F7 
X-CRM114-Status: GOOD (  12.87  )
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



On Mon, Apr 4, 2022, at 17:59, Christoph Hellwig wrote:
> On Tue, Apr 05, 2022 at 12:57:33AM +0900, Hector Martin wrote:
>> The kernel hard limit is 100-character lines, not 80-character lines.
>> Maintainers for existing drivers are certainly free to stick to 80 chars
>> if they like it that way, but I don't see why we should still be
>> enforcing that for new code. See bdc48fa11e46.
>
> Because 100 is completely utterly unreadable if is not for individual
> lines like strings, and that is actually how Linus stated it in CodingStyle.
>
> Your code as-is is completely unreadable and will not go into
> drivers/nvme/ in that form.

fwiw, I wrote that code and I just forgot to check the line length
after some last minute changes again.
It's already been reduced to 80 chars in my local tree.


Sven

