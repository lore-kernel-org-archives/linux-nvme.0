Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B37EA4FBB
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 13:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y56KfikU/sPIhAZ17QP4RjQzagilMWbyFB9S7vSDCdg=; b=flWEftGrr3fOylZvjUPTlnoEbU
	4O/cMtV57W9KGIiHb1116uEfPgCxdxRsVJMga8OW9GeWh59YGS/wiB0yn6LH/429RwpPOHkc/MjrG
	MGSx+Jv489k1ibzSwxWbMv7mRE+yJtBOTomnLl3cE5GMmpcdFU8vou81syHDh+kUG4iUS/bmKD7Va
	syJyvdg0G1V/ZkvVAhkkKj/H3kVtVW9Xl4/rUNedhxV/qNULivO8Yr1vJ1DMAPepApzkQFoqmCBRV
	+QeR1sFRTlacQDPkR6ju/JP71cb2IJCQeDm0VQ5XMXW5OyVJZhs5sVSam7Eg7SUgiLTHHTdb2QCmG
	ZFv1lpUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuVvR-00000000MEd-2j7y;
	Mon, 23 Feb 2026 13:24:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuVvK-00000000MDw-0oH4
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 13:24:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DABBE68AFE; Mon, 23 Feb 2026 14:24:20 +0100 (CET)
Date: Mon, 23 Feb 2026 14:24:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] nvme: add preferred I/O size fields to struct
 nvme_id_ns_nvm
Message-ID: <20260223132420.GA14767@lst.de>
References: <20260220032809.758089-1-csander@purestorage.com> <20260220032809.758089-2-csander@purestorage.com> <20260220160639.GB15071@lst.de> <CADUfDZq5xVsWyJuwi2=aWMqjqQDMzScp+sYXkp7YEq-pKz4EtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUfDZq5xVsWyJuwi2=aWMqjqQDMzScp+sYXkp7YEq-pKz4EtA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_052430_397434_F1E39A7E 
X-CRM114-Status: GOOD (  12.71  )
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

On Fri, Feb 20, 2026 at 06:55:25PM -0800, Caleb Sander Mateos wrote:
> Looks like static_assert() was added 3 years before struct nvme_id_ns_nvm :)
> Definitely agree it's good to assert on these struct sizes.
> 
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Assuming you meant "Reviewed-by". Let me know if you meant something else.

Yes, sorry.


