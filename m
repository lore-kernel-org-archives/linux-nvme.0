Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F7DCDB482
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 15:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cPQFYRIHU2n6BXrsJ6duiQ+AL5Lo2AwHu/Lf9m6YWPE=; b=QTfNsj1jDc2LM9q3J8X9C12iqU
	FxRUKdr2DwMHpcKfqhTJaHfgNQqaNJqcMkOdOWO6M+vvVO6qRbLzzQYKHBBIMQFHIQTOK2t3x3k+Z
	QfSQk7af9tdW9afDo2eUkx6Lc/ne2UnrLBdHFHUdc56eGpbYvHPNOLb0Za0yeSz2hx74kIR6hGNq0
	C0zH8cAlQCXdUijL7gSN9NmIb/isyJDdxKXrLiZKs/0RYXWFgI90SL+mdipi83VvhCyfX1Xxo+lzP
	KtyeAbQ36MlK1r16iFL0YMdc0Gw5uSzU8cFpMRBwNsyBTGmxqdwQHET4jRcMGJmSF7mxfFYAPkOLM
	/J9fcO4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrKNp-003iTi-2F;
	Fri, 13 Oct 2023 15:47:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrKNm-003iSs-10
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 15:47:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AEF3B6732A; Fri, 13 Oct 2023 17:47:08 +0200 (CEST)
Date: Fri, 13 Oct 2023 17:47:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	vincentfu@gmail.com, ankit.kumar@samsung.com, joshiiitr@gmail.com,
	stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
Message-ID: <20231013154708.GA17455@lst.de>
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com> <20231013051458.39987-1-joshi.k@samsung.com> <20231013052612.GA6423@lst.de> <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com> <ZSlL-6Oa5J9duahR@kbusch-mbp> <3438f3b8-f7d4-f0bd-44ef-7efb09ed6151@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3438f3b8-f7d4-f0bd-44ef-7efb09ed6151@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231013_084722_523626_BD753A71 
X-CRM114-Status: GOOD (  14.17  )
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

On Fri, Oct 13, 2023 at 08:41:54PM +0530, Kanchan Joshi wrote:
> It seems we will have two limitations with this approach - (i) sgl for 
> the external metadata buffer, and (ii) using sgl for data-transfer will 
> reduce the speed of passthrough io, perhaps more than what can happen 
> using the checks. And if we make the sgl opt-in, that means leaving the 
> hole for the case when this was not chosen.

The main limitation is that the device needs to support SGLs, and
we need to as well (we currently don't for metadata).  But for any
non-stupid workload SGLs should be at least as fast if not faster
with modern hardware.  But I see no way out.

Now can we please get a patch to disable the unprivileged passthrough
ASAP to fix this probably exploitable hole?  Or should I write one?

