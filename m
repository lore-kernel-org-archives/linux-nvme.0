Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80276C77B78
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 14:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eqMTiAD5d3gf7COFgTjkN2gLnQ/ixKX7thrIvC9zkNY=; b=I3yRi4BZ8gn3MvOYikx/6irgeW
	AzOUCGFivGEUpCY+RtwrOl8easd1rJniR2zjmmMe/P4+BLtA7w2iQ+EU8srbLiZr7zWm7n6509kj8
	OebGC/V+/F3kaVnhKr/Y5n3o0f0Uz3i+hHbaCbSs2qDrC7I2bGQInfPh3Mq6G4EDuEyY1q64u9Uw3
	XhrJEyW9n4erB17rdT3pCEzK81PbWwIX7go1b0KCS8Cx8HsrWuqIL7q8ejoWtcmT1U8wuhLbeqKSm
	09SduvbNHpWQU/YZ4HnYHQH8Y/pV/zZJM8qQwJmCTte+lMW1WGIQB8ryrp1shSK+o4mlEDRqPyELH
	/NT5/9OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puDu4-004tAn-2F;
	Wed, 03 May 2023 14:56:24 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puDu1-004tAD-1Z
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 14:56:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4AE1F61A47;
	Wed,  3 May 2023 14:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35735C433EF;
	Wed,  3 May 2023 14:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683125779;
	bh=Vy372GcCCs6KdpZsx/Lg92u1BwYcidGMSRYXpp1G+40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cYmrQhjqnGkj0r3KMuY8Pih9ne4giNi+OVJzG+6PhmDms7W0/YvBLi9bW4CEK4ovm
	 orsWDTwdhmmKDo3rLYObmU1Hd9ZugS9xsHbqdv4Dq9LZQW9oQdnZbCoG3nyLsX4zA7
	 2FfVEk9ws81xQmA633vBcTa3Riu/2uWGOEpev+4OBNk4M82FoMufwGSgisFOQRaX/8
	 mcZ06vdHYTpNsz2rQF6vXW4Gg7O18E2V7kTr190ST/4eEFnjvm4BcpdN/zX9tQCLyi
	 R4S8adbxRWio8/QqBG3qDn3bZMEeeQjvE/bEZvojAeJg6bCkRK2tA0CAq55CemYjgy
	 NWnOWdqefWXUA==
Date: Wed, 3 May 2023 08:56:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, axboe@kernel.dk,
	xiaoguang.wang@linux.alibaba.com
Subject: Re: [RFC 3/3] nvme: create special request queue for cdev
Message-ID: <ZFJ2EP/vGOSb1TAN@kbusch-mbp.dhcp.thefacebook.com>
References: <20230501153306.537124-1-kbusch@meta.com>
 <20230501153306.537124-4-kbusch@meta.com>
 <20230503050457.GB19301@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503050457.GB19301@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_075621_583389_D186D1CC 
X-CRM114-Status: GOOD (  15.94  )
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

On Wed, May 03, 2023 at 07:04:57AM +0200, Christoph Hellwig wrote:
> On Mon, May 01, 2023 at 08:33:06AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The cdev only services passthrough commands which don't merge, track
> > stats, or need accounting. Give it a special request queue with all
> > these options cleared so that we're not adding overhead for it.
> 
> Why can't we always skip these for passthrough commands on any queue
> with a little bit of core code?

A special queue without a gendisk was a little easier to ensure
it's not subscribed to any rq_qos features, iolatency, wbt,
blkthrottle. We might be able to add more blk_rq_is_passthrough()
for things we want to skip and get the same benefit. I'll look into
it.

