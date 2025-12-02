Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB5ACFD2F6
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 05:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T+4ltKBtUWtSbY6mQ51ZU2s8ZlHrWFB9NI1/jnWVjiE=; b=FbNirb+JUMyEyGvCxPzengIUpW
	7RNGBudS/n8EQWCXTvtupvs+rLxjTu2qASDXX3Lws0hExo0xpcu8Sl3i3XwRwtEdSFyFGzX2nfeFy
	FGE6iGs3AzIlYLUcUcJptVjCGly7dNigNnnQPtBQ/UJg/Bh6kNiORcMBd0INUYrqmVlK/er68leI0
	S2r9hBMmJGbxISUUrI/CFY1JeMW1A2jizRRDD5T5dOLeCSRJvSkl4rFOHiF09+0qMIbbgfsYMhPnY
	HQk7hq4M4/GPMet4ECwxRtY1myVx5RRFiTQSqA7W1SvSgeZuCzR9DIFycCVouRvtxAabjOeO5bp4F
	eo89EDNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQJO3-00000004rjh-3dNo;
	Tue, 02 Dec 2025 05:57:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQJO1-00000004rjF-1hUB
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 05:57:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8ABD968AA6; Tue,  2 Dec 2025 06:57:13 +0100 (CET)
Date: Tue, 2 Dec 2025 06:57:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Eugene Korenevsky <ekorenevsky@aliyun.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme: nvme_identify_ns_descs: prevent oob
Message-ID: <20251202055713.GB15852@lst.de>
References: <aS3v2_VcV8IwsT6g@localhost.localdomain> <aS4yhAhZYjvHOqtD@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS4yhAhZYjvHOqtD@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_215717_583889_04812E7B 
X-CRM114-Status: GOOD (  13.93  )
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

On Mon, Dec 01, 2025 at 05:27:48PM -0700, Keith Busch wrote:
> I don't want bikeshed this, but I thought this looked better as a
> for-loop. You can just modify the continuing condition instead of
> changing the loop type to do-while.

The reason I went for the while in my whiteboard coding is that it
would allow for keeping len local inside the loop, which I like
in general.  The actual patch doesn't do this anyway, and I don't
care too strongly, so I'm fine with the somewhat more natural for
loop as well.

