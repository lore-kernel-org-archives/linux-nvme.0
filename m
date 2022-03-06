Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC4CC433F5
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Mar 2022 18:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4rKg0Jcv7igIuP2xiRmBBXXX5sljFWry7Hm5DB5a0a4=; b=rNGYEoGiR+4z+cSoLqdlJcUwwx
	CFwvj/F+tAlffm2nAywZZp88mys9Ta4DwQOo3KPHVNHzpOia70gmKEaCHJ4KrcvLa1Jqklu9NTXE9
	w8WIHKLAeqCNNJ7oxKC/oJTnsPfnKgdcDcwMZC+q/wrbyxS/vlxlCvm/0qM+YIkwbsx6Kxo359FWh
	PsJ5E+y2bmeJ+bGi2gKO/craqHKTB1pewP4KPk4OwByEj+0k6ZEHnrBr4HV4MLHQvQBAPZa2/ItZe
	c2CwnOzi2frVRSIBlhaSEEsI1T/oWhfr4bWiqvVMkfY3cMao0yRfzAf9JmwunuLB7i7rF1vbZacwC
	eVrNFIgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nQvC8-00F8yj-NY; Sun, 06 Mar 2022 18:01:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nQvC5-00F8xa-G0
 for linux-nvme@lists.infradead.org; Sun, 06 Mar 2022 18:01:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6D52368AA6; Sun,  6 Mar 2022 19:01:15 +0100 (CET)
Date: Sun, 6 Mar 2022 19:01:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
 sagi@grimberg.me, kbusch@kernel.org, song@kernel.org,
 linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint
Message-ID: <20220306180115.GA8777@lst.de>
References: <20220304175556.407719-1-hch@lst.de>
 <20220304175556.407719-2-hch@lst.de>
 <20220304221255.GL3927073@dread.disaster.area>
 <20220305051929.GA24696@lst.de>
 <20220305214056.GO3927073@dread.disaster.area>
 <2241127c-c600-529a-ae41-30cbcc6b281d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2241127c-c600-529a-ae41-30cbcc6b281d@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220306_100121_708542_F16E9585 
X-CRM114-Status: GOOD (  12.26  )
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

On Sun, Mar 06, 2022 at 10:11:46AM -0700, Jens Axboe wrote:
> Yes, I think we should kill it. If we retain the inode hint, the f2fs
> doesn't need a any changes. And it should be safe to make the per-file
> fcntl hints return EINVAL, which they would on older kernels anyway.
> Untested, but something like the below.

I've sent this off to the testing farm this morning, but EINVAL might
be even better:

http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/more-hint-removal

