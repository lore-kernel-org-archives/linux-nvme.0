Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1670C28D13
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Aug 2022 06:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ccyPbbB/rxP2rktStiuuaMEyIb7XodiJAcyVwOLa3HE=; b=P3Mn7EcjaNHDU9OVcjgbieOFg5
	WEZgtE5ZVJumkUvaLuLJcns7PzWl8BhBpLV5jCvBwPeY+dRIpcpw15ijpwbwU7sROm7J7ro8NvlUx
	FN/8/R/8G6u2S6vXNa9k247prTEORsP+G1TL658MKnQNOm+Y4+i8TB6Pr2TTiwVHIOZVSJH0Iy1sV
	vSl/WuFG4eWCro+Tn3UnFQBxiltOjra4jCgRqhlXi1ihe8FuDOqwqy13oGMPNdUp8npB7HK1a2mdd
	l0ZPmGOQGtpoioDN+5P4uLTCnPj5j5J64k6NmDvQhqzomvSAOvNf6l/wLsn23uo3tJyRge8f27fhi
	kk+Fy2/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ0si-005Odz-Tz; Mon, 22 Aug 2022 06:25:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ0sd-005ObD-N7
	for linux-nvme@lists.infradead.org; Mon, 22 Aug 2022 06:25:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7509967373; Mon, 22 Aug 2022 08:25:37 +0200 (CEST)
Date: Mon, 22 Aug 2022 08:25:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 14/19] nvme-rdma: Fix error check for ib_dma_map_sg
Message-ID: <20220822062537.GA21455@lst.de>
References: <20220819060801.10443-1-jinpu.wang@ionos.com> <20220819060801.10443-15-jinpu.wang@ionos.com> <20220821055745.GA26064@lst.de> <CAMGffEkhQd6oGgg+m9AUkquYnkufyrt1ptEkg5LG_HE_7s-Vsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEkhQd6oGgg+m9AUkquYnkufyrt1ptEkg5LG_HE_7s-Vsw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220821_232548_319673_90AAA022 
X-CRM114-Status: GOOD (  18.43  )
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

On Mon, Aug 22, 2022 at 07:12:23AM +0200, Jinpu Wang wrote:
> On Sun, Aug 21, 2022 at 7:57 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Please don't send me just two random patches out of a series, as I
> > have no way to review them.  If the patches are independent, send them
> > independently and if they depend on common prep work send the entire
> > series to everyone.
> Hi Christoph,
> 
> As mentioned in the cover letter, the bugfixes are all independent,
> for each of the drivers.

I still haven't seen the cover letter as it was never sent to me.
But if patches are independent please send a series per subsystem
as that makes that very clear.

