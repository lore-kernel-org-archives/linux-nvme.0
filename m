Return-Path: <SRS0=Cnjr=HR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE58C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 17:02:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 655EA64DC3
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 17:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655EA64DC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8MLEr3UhEOexFRn/3hQGAFjArVXLhh0zkQrTZy1bBwU=; b=TUL1Pou6Dl5skucxTwxlw5Hiu
	rO3bAfhgvvY9WFNYBZQk9qHu/im3jW2vxopZPeLP+Ox1psZZ/xxhhEuHPYtJHYc9MyxcUGq9+c6qq
	YYoB9iMAj7HehRehmKqNnliNbcsye6kiuzwSZJpZUdegKec6DJk6ggnff26Hs9I9Rawv5QDdl9UT9
	GLdTXBKukN03XDI8XfM3f0favBLdbyN/ICzCMdUmu2yQRtV5flwuZIBvnSboIktrcSgkyGq3VMg+E
	FvNtqfDo8RpnjjWzu+FlDZh2i82GEd1ksQ9Qg4v1a5uiz8XBjc9gdSk6WrDfXiUJsnADUSn7WU0Vo
	4hA9s/NGA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBhGi-0004Ry-9s; Mon, 15 Feb 2021 17:02:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBhGf-0004RB-Lb
 for linux-nvme@lists.infradead.org; Mon, 15 Feb 2021 17:02:38 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A60C361493;
 Mon, 15 Feb 2021 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613408556;
 bh=sVzo63uMXbKBsRipiU46S3L0ZSJ21JAR8qSvhVl6T88=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kQ7Ni/fHotgZ+A76lTA7aIR5UliuaTZlV0KpWJ5ilM9TUZnBzTtDcLCge6PqxgvJB
 hfhA/FoJqBdbLoEN/mg1KtkMkkcUItrCmI2xCwvObV2zOWCFP7cFqtwgJO7TH6O3vf
 BfY5XKxSjylddCmFWpRsKCJ3LuGXH3aTWYLhPyy+lg9KfYIJQgUTDkhf2G4B88vi4K
 47U/Pf3o6UajG1am+I3wVN9JV0+0DWtis7BbWT/k1tGPcc7MeDXtOBXMLp7U8g43Z+
 b+JpMJAlO5xF3wlNTlIo4DSJjE+RPh2AHPmQGNLDp8Rp+wD0swAyu31GeIRlw3OcVY
 n2KuvMar49dJw==
Date: Mon, 15 Feb 2021 09:02:33 -0800
From: Keith Busch <kbusch@kernel.org>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH] nvme: introduce passthrough ioctl for multipath
Message-ID: <20210215170233.GA2707454@dhcp-10-100-145-180.wdc.com>
References: <20210214110126.24023-1-minwoo.im.dev@gmail.com>
 <20210214110126.24023-2-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210214110126.24023-2-minwoo.im.dev@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210215_120237_799544_2E05EC33 
X-CRM114-Status: GOOD (  13.92  )
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

On Sun, Feb 14, 2021 at 08:01:25PM +0900, Minwoo Im wrote:
> We don't allow NVME_IOCTL_IO_CMD ioctl in case that a controller has
> multiple namespaces attached.  Also, I/O request to the controller
> character device has not been recommended and deprecated because we have
> block device to I/O with where the multipath consideration is taken.
> 
> Once kernel decided a path to I/O for a namespace based on the I/O
> policy of a NVMe subsystem, userspace is not allowed to choose a path to
> I/O.  If a path is broken(inaccessible state in ANA), then it will not
> try to I/O to that path.
> 
> This patch introduced NVME_IOCTL_MPATH_IO command for controller
> device(e.g., /dev/nvme0) to support multipath I/O passthrough for
> userspace.  Regardless driver's path decision, userspace can target a
> namespace to I/O.  In this case, `cmd.nsid` will be used to find out the
> namespace instance target which is hidden(e.g., nvmeXcYnZ).

IO commands are not allowed through the character handle with the
existing ioctls. A new ioctl doesn't make it okay. If it was okay, then
we could just remove the limitation in the current ones.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
