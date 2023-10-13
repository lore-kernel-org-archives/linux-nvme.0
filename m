Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5654ACDB47E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 04:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gzwo1MUC6n6AnbCJw2XUlm2Ib6xmaNxF62ofrPSS2fc=; b=2mVZsXBZ4Pmw0zZX85Th8UK/91
	ZbZSGHSNhl+7AoIyYFRGVUHT8vlo0hrPYsfUTSES7ClLbmDgGID1PQuIu2pN8LxUp2pa+SXMtNndg
	GeRnS5P4eoiKUePWq85WJ1sKXZCTswv/adyt8LoQy0TcfWTlzOJ29RGV7msrWD/ne83TUiR7xGE9J
	56rK4eL/e4r/mNaDtTzbo/1KnEc9jGp9dGFGr3cjZAuV8E0YaT/F73RRn6qnkPdxaCu2B0MZWN20J
	bv/SsQ6CDsdSUDrweivTsvqMgVZUcu6Z6YGN+3o6nW2JWJPLKVjfmHpRVYcEUojDLa+0JzhYbHFcV
	2arfC66Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qr9wE-002SyZ-1c;
	Fri, 13 Oct 2023 04:38:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qr9wB-002SyA-1A
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 04:38:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E048D67373; Fri, 13 Oct 2023 06:38:06 +0200 (CEST)
Date: Fri, 13 Oct 2023 06:38:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	vincentfu@gmail.com, ankit.kumar@samsung.com, cpgs@samsung.com,
	stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Message-ID: <20231013043806.GA5797@lst.de>
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com> <1891546521.01696823881551.JavaMail.epsvc@epcpadp4> <20231010074634.GA6514@lst.de> <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com> <20231011050254.GA32444@lst.de> <ZSbVuuE8YxgwpqM8@kbusch-mbp.dhcp.thefacebook.com> <20231012043652.GA1368@lst.de> <ZSgRWrcw1FFw3XRJ@kbusch-mbp.dhcp.thefacebook.com> <CA+1E3r+gEPQgaieuwNXuXSDp5LHCQpUa8KFc80za4L9e88bUhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3r+gEPQgaieuwNXuXSDp5LHCQpUa8KFc80za4L9e88bUhg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_213811_540891_9F42A02A 
X-CRM114-Status: GOOD (  15.38  )
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

On Fri, Oct 13, 2023 at 07:49:19AM +0530, Kanchan Joshi wrote:
> > precedent to start doing it.
> In my mind, this was about dealing with the specific case when the
> kernel memory is being used for device DMA.
> We have just two cases: (i) separate meta buffer, and (ii) bounce
> buffer for data (+metadata).
> I had not planned sanity checks for user inputs for anything beyond that.
> As opposed to being preventive (in all cases), it was about failing
> only when we are certain that DMA will take place and it will corrupt
> kernel memory.
> 
> In the long-term, it may be possible for the path to do away with
> memory copies. The checks can disappear with that.

As soon as the user buffer is unaligned we need to bounce buffer,
including for the data buffer.

