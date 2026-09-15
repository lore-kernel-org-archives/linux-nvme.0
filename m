Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9E5C88E77
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2026 19:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bYQEVYfX+WA08lNWpJpBmztpHDIbM99DdEJzT65B0Jc=; b=2QIBZHtmiaOV68TBpIc+u4M0f9
	a0JW/x1RzG1TCx7XGJWz9j6Vdp0xAvPXGuVXuE45Hp1X78q9OEZsXpMC/JNuCZRq7jwpUtyzdjrLJ
	/gxAyID2sm+lPlh+MwAs28ar7DQW3EeTb38S/lToWmv9AWCdhpK7lVCBT2P0+my3bn+u27/zTlO+x
	a4n8+2Q3F+L/rv5010Exzm7hcT2qWo+3y0vqHvjAMvqNPi3NLTqJ9pfXcw7Ao4pzXTFGNi4tYnFfF
	Gi90Z6TS7UTfVOOWwvDL/XfH3jgbL/0uYS0a9R0QlJt+1YWqfex8L1CQXIaUgixaRe/WaZ82UnaH6
	X/blpsfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6YbD-00000007qCa-0ArJ;
	Tue, 15 Sep 2026 19:13:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6YbC-00000007qCS-1h3X
	for linux-nvme@lists.infradead.org;
	Tue, 15 Sep 2026 19:13:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D8CF640125;
	Tue, 15 Sep 2026 19:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413E11F000FF;
	Tue, 15 Sep 2026 19:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789499625;
	bh=bYQEVYfX+WA08lNWpJpBmztpHDIbM99DdEJzT65B0Jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ExeGMHDrG7oJjLtFRdlLralz1AUlpkk8DQAtf6h9JbHgqyJ2exiiADP/O1EnbPPsg
	 fPG5ZJF6MKxdGenDoerjIvre3NO23YnGcpMDxgCC/BwxG6BTmniHvQWP3+LXCqYIIB
	 MVEZmzxojP3iFDBCTebU5uJF/E76UJ544Fk++oBsuuXPWaaY4qXv66P6IcEhTI6Isb
	 h4Y7LXC61AObtm71urTFCiFM69E2yy6dzmSSNlR1Qi0pWmy8gYZfIdIqpq8HjCyZ4l
	 0uc0PRe1/8FBHh/b6OIH1JMP9BunsUbrrtWAionJzZF5Q5zdRKf7P8y2iVoZ6tFKJr
	 iA9WgvA65Vh9A==
Date: Tue, 15 Sep 2026 13:13:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: hare@suse.de, hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
	kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/1] nvme-auth: constant-time DH-HMAC-CHAP response
 comparison
Message-ID: <aqmY5qqjghx4DFNM@kbusch-mbp>
References: <cover.nvme-auth-memneq.1781751816.git.liuxixin@kylinos.cn>
 <0001.nvme-auth-memneq.1781751816.git.liuxixin@kylinos.cn>
 <20260702141317.GA23046@lst.de>
 <df336dde-f70b-4ddf-b77d-b9b910d2c10e@suse.de>
 <reply-nvme-auth-memneq-ping.20260915.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <reply-nvme-auth-memneq-ping.20260915.liuxixin@kylinos.cn>
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

On Tue, Sep 15, 2026 at 11:30:00AM +0800, Xixin Liu wrote:
> Hi Keith,
> 
> Gentle ping: this v1 still has Reviewed-by from Christoph and Hannes, please apply when you have a chance.

Sorry, looks like I didn't send out the "applied" message to this patch.
This was applied a while ago for 7.2:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=3a6d89836ab09d53f4c32c57588689a378ce4363

