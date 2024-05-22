Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4266C25B78
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 17:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3kLP/eRm5NzkD4rKYEdapCBaAwnNIa71MaZFuVShTf4=; b=4qIK7bAq1UzImqvV2zIg7DXagG
	2P2g8lo0ELseXTHyB7ZpbF1qBJEm9d1sRuiciPc8Zf4/85fpJbhqi+kaO6GgOGtFZEyMlZQMSL3SZ
	Vq8d3T1v0BCcCA3ImgQudkJ16RX/bmGurv7AciHQV2gG86mY0sMfWvrovDSGdO+U8C/M6e5jC5SpS
	7EvrzkFoUP/mnp+qRzR0gZw6oNCBatbYO6zux5s9GfYey/M9jdO7586nDiWjCa2Uez+92EXUELG2w
	acYQf86MTpe1QKGeBClE+1Ux+yOPHPMqxVc9Y7Umhgk8/v7t2/waWt1SvBEBuokWAmxSn8KYCQnSX
	CakpYi7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9pow-00000003euc-3LJG;
	Wed, 22 May 2024 17:32:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9pot-00000003eu4-0tzV
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 17:32:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8CFAA62ACE;
	Wed, 22 May 2024 17:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8139DC2BBFC;
	Wed, 22 May 2024 17:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716399126;
	bh=I+AChwZfVTk45NPTsJRvNFZS+ouhd83TRXjEA8ib4gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aFGm248Z9VYQr4F0y8aSFiKQ2z3YMHuCWAiL02RBAa5m58/t6fsXhu3J5zQ6NsEDF
	 R/FmZJznQf09LdE0vzQBO1VdvsRFuPIoQSse2Vq8wPBqc0D2r9ZvgzVkOg/nr4VDaf
	 GW+EMCZI4hiGXWO8ZQfxSu49IUBbvrANXIhrf14WROFY64oesTph1DrsCsEQ0s8TKf
	 h8W861CjY03eVLCpBcVnmU3v4VKdUiN53qKhQhodQKvAc6pq6Di//6o496WOnuJzGU
	 nsTTj+HaIm9GQnThV1nd/wVxsERACqj+gRsMIquh6fzZM7ZAO979Js42MBs91/8k5Y
	 pl+cnDmYHgXCQ==
Date: Wed, 22 May 2024 11:32:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <Zk4sEpypKqeU67dg@kbusch-mbp.dhcp.thefacebook.com>
References: <20240522165406.702362-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522165406.702362-1-jmeneghi@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_103207_601048_0F956981 
X-CRM114-Status: GOOD (  13.15  )
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

On Wed, May 22, 2024 at 12:54:06PM -0400, John Meneghini wrote:
> From: "Ewan D. Milne" <emilne@redhat.com>
> 
> The round-robin path selector is inefficient in cases where there is a
> difference in latency between paths.  In the presence of one or more
> high latency paths the round-robin selector continues to use the high
> latency path equally. This results in a bias towards the highest latency
> path and can cause a significant decrease in overall performance as IOs
> pile on the highest latency path. This problem is acute with NVMe-oF
> controllers.
> 
> The queue-depth policy instead sends I/O requests down the path with the
> least amount of requests in its request queue. Paths with lower latency
> will clear requests more quickly and have less requests in their queues
> compared to higher latency paths. The goal of this path selector is to
> make more use of lower latency paths which will bring down overall IO
> latency and increase throughput and performance.

I'm okay with this as-is, though I don't think you need either
atomic_set() calls.

Christoph, Sagi, 6.10 merge window is still open and this has been
iterating long before that. Any objection?

