Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A840AE77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 06:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z4Ih4U3YJVg3foluHKq8Pgl6RxyNn5OymCfihRfU01g=; b=k3Ndx6+UnBYyUfoQDPLNBhd3dX
	I0Y+BnvUULGYxG6t4l49hQkO6yQRdTw8dnUk1MPIKHCZ1VvzCaQPv4M/MCs2QHjY0I5p7vXKO4cry
	5+1DjY8uGUcl2oDsSVsRA43Nu5VDms0MBlqpeuH3RnJ2M8x14jG0BSghqGzxOkP95H+a5pPhWDFQa
	5YLb1H/iYWYsMqWoJn35mKJIVwd1KD5AiPtMbvWtnfvSZaEU9ixFQp4PQOiA6kacVhqAe6pPXUCCS
	ai1OAIkj4xMtgAB5EGIR1FHI2lt7BhELxjQPZr/3CA3Z/opzB8srO9qZIWcfT19t/oa4xTV0SdWqZ
	wHh0jvhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV2vU-00000003cgC-37FW;
	Tue, 07 Jan 2025 06:18:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV2vS-00000003cfT-30pa
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 06:18:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7141167373; Tue,  7 Jan 2025 07:18:42 +0100 (CET)
Date: Tue, 7 Jan 2025 07:18:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 1/3] block: Fix sysfs queue freeze and limits lock order
Message-ID: <20250107061842.GA14021@lst.de>
References: <20250104132522.247376-1-dlemoal@kernel.org> <20250104132522.247376-2-dlemoal@kernel.org> <Z3tOn4C5i096owJc@fedora> <20250106082902.GC18408@lst.de> <Z3u7Twc4UPWvlfJJ@fedora> <20250106152931.GC27431@lst.de> <Z3x5F3_GIkD4sxl7@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3x5F3_GIkD4sxl7@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_221850_897766_E175D99C 
X-CRM114-Status: GOOD (  14.47  )
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

On Tue, Jan 07, 2025 at 08:45:11AM +0800, Ming Lei wrote:
> > No, we had various bug reports due to it, including racing with other
> > updates.  Let's stop trying to take shortcuts that will byte us again
> > later and sort this out properly.
> 
> Can you share the bug reports? I am curious how it happen.

Try to search old scsi and nvme list reports for trouble, one case
with the discard limits, the other about the max sectors.


