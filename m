Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3727CCF9EB
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 09:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qefwc/TSc6SG5Qrv0KnK8IjeZi2dn7kX/dQx3qhYI/U=; b=DHOZRbuC4zKVuc63n5d8Y2Qgdw
	fa45aP+N0ZgkuJ7B9o8x/6t1rP//G3KHTkgmygtob6i4r3N2x2lt9NdxnCjHqO+N6I0DZ7a0MTI7b
	56yzdXzHahfpOhQqdkPuVdo7Ljlfdb7RXLlCsoVXOlDwRjTQ5m4dTGCdM+oeCfnuu/OADDCyIw9N3
	nwsneClTC4IG2iePDGmhpD18IJvrXQ0Ky7XHOJTom3qqWrHb5r2k3oBXaNs099snDhrVrc5yVppO6
	V1JYp57jbpWgdo8RJpYaPBh22zgREYH8qh3rQQ3WQ5Ti9IQ2xu15yzFnLQqnGr5CrWWeOM4W4VQ/U
	P+ZT3ATg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE2xY-00000000bXN-0SHn;
	Wed, 29 Oct 2025 09:59:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE2xU-00000000bWs-4Aw9
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 09:59:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CC5EB227A88; Wed, 29 Oct 2025 10:59:07 +0100 (CET)
Date: Wed, 29 Oct 2025 10:59:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <wagi@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: drop bogus nid quirk for multipath devices which
 passed id test
Message-ID: <20251029095907.GA1652@lst.de>
References: <20251028-bogus-id-check-v1-1-c087a98b5466@kernel.org> <20251029074403.GA30412@lst.de> <bd91a6c1-cefc-43e2-8dd8-48b7ea241ded@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd91a6c1-cefc-43e2-8dd8-48b7ea241ded@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_025913_196832_BE12DBF4 
X-CRM114-Status: GOOD (  20.49  )
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

On Wed, Oct 29, 2025 at 10:45:57AM +0100, Daniel Wagner wrote:
> On Wed, Oct 29, 2025 at 08:44:03AM +0100, Christoph Hellwig wrote:
> > But more imporantly dropping the quirk for multipath devices is
> > fundamentally the wrong thing to do, as we really need proper IDs for
> > multipathing. So just add another entry for the Dell device using
> > the dell subvendor/subdevice id that does not have the quirk.
> 
> The problem it is not possible to distinguish between the two devices
> based on subvendor/subdevice ids. I've tried to find some way to keep
> those two devices apart, serial numbers but I don't think there is
> something usable. Thus the idea to rely our own sanity checks and
> enable the feature if these pass. 

The problem is that there is no such thing as a sanity check.  Otherwise
life would be easy.  But I really can't believe that Dell is incompetent
enough to not leave a mark of their OEM Firmware version anywhere.

