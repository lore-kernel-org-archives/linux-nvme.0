Return-Path: <SRS0=dBpD=HS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DEEC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 17:58:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEDFD64E08
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 17:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDFD64E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yRGEBgDf0LvUW/grOLOrvUB+ZT+IgvRzyXmUOHjy+AA=; b=DSAkQILoD57OT/1eD5B13M6y9
	xu+6PdBEqkmyqBQ9M/GpZxMn4WFnRL9l4rMSPNXtuXDYqlGaOpQhPcLOY+2uXbD9EgbqdEpI90d5r
	vxkaQT7torB2HBjnFi61Rfyi4nvEQi7ybJBDngcmKuA4IwhVAEmADNpTah0SpmJTcsR6iG0MbOSwN
	cSawOMoEyV9+M1fgmifCe0UbE2W45gG5ERdscxRop5aLmSbDIiDqyp/jqSspfJaDzoQfY2ShNd1Kx
	+uod3YZBXPjK9wK4zxDEIDJWwp5Xp6M+tYtD+GFkktjzPfI+0WhzevT24UsBF3Efkhu7P/fGV5CLW
	D4PlPw4oQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lC4bJ-0003iK-Iy; Tue, 16 Feb 2021 17:57:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lC4bH-0003hr-5B
 for linux-nvme@lists.infradead.org; Tue, 16 Feb 2021 17:57:27 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5263E64E08;
 Tue, 16 Feb 2021 17:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613498246;
 bh=ZGL6S+PEuOVL2+Q2ycW+xwsR7E7EX/tF6Peg4VISIss=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NNZ1cY1HrcUDp1O7+YOj6i/XU5zUkDyM7XGENWynyw1z+RpkWHwX8mHkYpeS2yXGI
 U/0oxcnu0AEuJUN8tHsMFRNzhruCOYr60G1j2VO3L6KDTpUrByOEcM81RBazBjtZFv
 me7a05xx0zum1USVRVNS5uu6PFqGAlXsClEOTnQy0ttLOWPP71iUxyUv9qA5HslkGw
 LvJ/5XuUYRQfkrWn4yllhwtWZefie9erVMjlNc13bpxRMTqcCTsdyy2lOP6iU26IqK
 jZfRjRtbhTY+9X0DgA19dZ/fbDO46PDfvIPhLahAAYvtItDdzT2zh1bsk0KE9lXTDS
 GWUUbc0FI+LEA==
Date: Tue, 16 Feb 2021 09:57:22 -0800
From: Keith Busch <kbusch@kernel.org>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH] nvme: introduce passthrough ioctl for multipath
Message-ID: <20210216175722.GC2708768@dhcp-10-100-145-180.wdc.com>
References: <20210214110126.24023-1-minwoo.im.dev@gmail.com>
 <20210214110126.24023-2-minwoo.im.dev@gmail.com>
 <20210215170233.GA2707454@dhcp-10-100-145-180.wdc.com>
 <20210216095147.GA2601@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210216095147.GA2601@localhost.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_125727_268702_657D46E1 
X-CRM114-Status: GOOD (  22.09  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 16, 2021 at 06:51:47PM +0900, Minwoo Im wrote:
> On 21-02-15 09:02:33, Keith Busch wrote:
> > On Sun, Feb 14, 2021 at 08:01:25PM +0900, Minwoo Im wrote:
> > > We don't allow NVME_IOCTL_IO_CMD ioctl in case that a controller has
> > > multiple namespaces attached.  Also, I/O request to the controller
> > > character device has not been recommended and deprecated because we have
> > > block device to I/O with where the multipath consideration is taken.
> > > 
> > > Once kernel decided a path to I/O for a namespace based on the I/O
> > > policy of a NVMe subsystem, userspace is not allowed to choose a path to
> > > I/O.  If a path is broken(inaccessible state in ANA), then it will not
> > > try to I/O to that path.
> > > 
> > > This patch introduced NVME_IOCTL_MPATH_IO command for controller
> > > device(e.g., /dev/nvme0) to support multipath I/O passthrough for
> > > userspace.  Regardless driver's path decision, userspace can target a
> > > namespace to I/O.  In this case, `cmd.nsid` will be used to find out the
> > > namespace instance target which is hidden(e.g., nvmeXcYnZ).
> > 
> > IO commands are not allowed through the character handle with the
> > existing ioctls. A new ioctl doesn't make it okay. If it was okay, then
> > we could just remove the limitation in the current ones.
> 
> Thanks for your feedback, Keith.  If you don't mind, may I ask why it's
> been entirely unsafe and deprecated in the exsiting
> ioctl(NVME_IOCTL_IO_CMD)?  I've seen a patch bfd8947194b2 ("nvme: fixes
> for NVME_IOCTL_IO_CMD on the char device), but have no idea why it's
> been really depreacted :)

A container could read data from namespaces assigned to a different
container.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
