Return-Path: <SRS0=hrUZ=HW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAC7C433E0
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 15:50:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95BE364E15
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 15:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BE364E15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BDxH0O1tcfFvCwjWjGwQ1G8qBjZ5Nj2UTal7WLGo1Bc=; b=sed0HlSIGXkyO/Ji0GFlGXV7g
	vVq3pVRLivWAEMeghB7eTUclwt1B6tuOrbE2dQT8A8Hbxlz5WfyiIS2XwNpTserC0uv8QwC1ZPOJF
	9SpQcfwshNqQqG4iSDr8IoWdun44svvQX83fxD7CjU5OARCSP8353fkbN2DNrJdsEZdiQgssMi+sq
	HPuCklnwQd/Fd45RIpf1/fTouZP60WMzEi7EBJv7t19RIWlWrBwgJG3lLZp4TKK8n7BVHaMq2bGJU
	3Dpqk8Vzs9tRe2w2tkH0HgpQvjNDxzuHt6EJ1MhmbZzGersAEW/B9xHDtUssGK5I8yVFllg9RU+i1
	Ql4XhQNcA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDUWk-0008D8-6r; Sat, 20 Feb 2021 15:50:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDUWh-0008Ch-Ll
 for linux-nvme@lists.infradead.org; Sat, 20 Feb 2021 15:50:36 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 761B264E15;
 Sat, 20 Feb 2021 15:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613836234;
 bh=BwL1Uy3qSNR+pQfG0jVHLKzLElJ5ZmU9MCvB6O1o7Yk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KUR6nqdkNgNcyZAtoXqw3+fFkH0yx7YOYwMRml+w5D1pzTCHBZXeW3ei3FgQe/0M7
 v4WqNRhTXHHke7lDvQ9wkB9JixFxvG6jWtJHpLhEidz+85o+B6jAcy5lH5z8jYrhyr
 C2OzBqtrCK5vTP+Ilum0UyyHarJAZLE1tH6+ep/CPbsI4GUfW5ADcEN+3GUGf6CmYg
 4Vx2+GTI+ID9Z2eEx0kXOvvMBCWSBhKi1+ODyKXRPhBlQbM0s8AuI50vRch43+TGs/
 m9ByvEQ1Ar1dFPKTaH5eot0YMR+2bHI2tNfBA23D+Ibw3Dv1ispjleBX2mG3hTdCpK
 XAZRgXnNCjBbw==
Date: Sun, 21 Feb 2021 00:50:27 +0900
From: Keith Busch <kbusch@kernel.org>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH] nvme: add support namespace management to sysfs
Message-ID: <20210220155027.GB4105@redsun51.ssa.fujisawa.hgst.com>
References: <20210220154004.242622-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210220154004.242622-1-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210220_105035_815759_B502B342 
X-CRM114-Status: GOOD (  15.69  )
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

On Sun, Feb 21, 2021 at 12:40:04AM +0900, Minwoo Im wrote:
> Namespaces are generally managed by scan_work.  If admin needs to attach
> namespace to controller, admin command like `nvme-cli` should be issued
> with rescanning controller.
> 
> If admin issues a Namespace Attachment command with detach option to a
> namespace through IOCTL, kernel is not aware of it.  In this case, block
> device for the namespace becomes meaningless, but still shown in the
> kernel space as maintained.  After the rescanning the controller
> manually, namespace node will be removed from the driver and user-space
> will not be able to I/O to the namespace.
> 
> Add support for namespace management (attach/detach) to sysfs of
> controller instance to make it easy to attach/detach namespaces with
> kernel-aware rather than non-kernel-aware passthru via IOCTL.  Also, it
> provides closer relationship between the device and kernel for the
> namespace perspective (tightly coupled).

Nak. The kernel should be aware of the altered namespace inventory via
Command Effects Log or Namespace Notify AER. If the controller doesn't
support either of these, then the user gets to do a manual rescan, which
is not difficult task either.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
