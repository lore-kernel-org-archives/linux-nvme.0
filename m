Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BC8C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 14:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Zc/j1kzg45ZO6xFQhvgxG/Y13VKxiwjDNgb2fmfG14=; b=rQdZ5YBhyIOg7lUEjdhOdjixJf
	OGr0qYWbFK//6X6DrEk/tgiHwCwwc87JdbYCFRFCiOsoNY5aW/s1+ksxZsI3i5tEo9FxWPQqnYPej
	FvIzLg+bq0psr87ltP/ITL/9pMFhvL3O/mXnX7KWuBndxVuvoXVirzCaYVvB3Sy/TLVhHrQqQeLc/
	7Ct8qD3gwJzIJSgI01N45y6XVmejuNBOGjjl6gqjGLvz6o2kmmN+O6FLdxWSGKMS34biSg31g0/xi
	dfZk05CwlMms0R/Ytn8Jn3am/b0BfPHiQiL3jKILbygZ/AJmgn/4AhUR10EOkvtN4c76pLo0Rc+lQ
	Xl1fIhBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBzUx-00F14i-8B; Thu, 14 Jul 2022 14:07:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBzUu-00F12E-Je
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 14:07:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8AFFE62103;
	Thu, 14 Jul 2022 14:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE06AC34114;
	Thu, 14 Jul 2022 14:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657807639;
	bh=ZfA51XV5AmWz21qR7tT+06ucaJi1XGmqshmw1OJsTTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M7/3shNv6XFt8AS67w4IXje18HECdLs/zOuZsfbbKynTehZU8jWsqfzX2WJ+NY0SZ
	 zcaDYdyOArQg3TfiaWLBk97KV/CNAcJTolmlWTMhYrCXAZwWTjGi0tWKlGfRbQ5/fz
	 6pbyYR7RzxS25SC9b+ygof/ByhlbtuxSsEz+w2zx1QJkNwW6URcuSl8yehBUVPyeQ+
	 nCXm+ghAYxZPYWTzsJIEeraRCVYm+eGCBRw2J6SetzVhfs9UmyaIpVHwpOIEp84JKS
	 4o6QJSt5x2F1XAJZRnj3lBbTTvEkJVPhRieA1M1KUeMAcjeO6xypAwls6n87i6Iz9W
	 t1PmUl7wCulRQ==
Date: Thu, 14 Jul 2022 08:07:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: shadow doorbell on admin queue
Message-ID: <YtAjEzTmdrmaY9hw@kbusch-mbp.dhcp.thefacebook.com>
References: <Ys/Y8N0y1lpMwyZH@apples>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys/Y8N0y1lpMwyZH@apples>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_070720_724123_0C3CE29E 
X-CRM114-Status: GOOD (  21.19  )
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

On Thu, Jul 14, 2022 at 10:50:56AM +0200, Klaus Jensen wrote:
> Hi,
> 
> Jinhao, our QEMU GSoC intern is working on nvme performance improvements
> and while implementing shadow doorbells an interesting issue came up.
> 
> The spec states that when enabling shadow doorbells, it is for all
> queues (including the admin queue). However, the kernel will currently
> not update the shadow doorbell for the admin queue, which causes trouble
> if the device expects it to.
> 
> The kernel is not the only driver doing this - SPDK doesn't update it
> either[1]. At least one virtual target implementing shadow doorbells
> (SPDK's vfio-user target) jumped on the band-wagon and simply expects
> the driver to not update it. In QEMU, Keith came up with a hack to
> update the shadow doorbell from the device side, allowing both compliant
> and non-compliant drivers to work. Just fixing it on the driver side is
> a problem, because it will break targets that expects the non-compliant
> behavior (i.e. always expecting mmio on the admin queue).
> 
> Question is if the kernel even wants to do anything about this at all? I
> kinda already know the answer here - "spec is screwed up", but I wanted
> to raise the issue here for feedback prior to potentially starting a
> process with the NVMe TWG to sort out there.

The driver has been this way forever, so either (a) no one was actually using
this feature, or (b) every target implementing shadow doorbells has the same
non-spec implementation. Either way, we can't very well change it now, and it
looks like shadows can't reliably be used on a live queue anyway. I think you'd
have to refine this feature with the TWG.

