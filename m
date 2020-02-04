Return-Path: <SRS0=ej39=3Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EB6C35247
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2020 15:42:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75CEC2082E
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2020 15:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l+5+DVD6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDF1etBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75CEC2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j1N8UePRGQurebsnrSlma9hk12Yng54BhM1ANZHu3oY=; b=l+5+DVD6aU3Zki
	4pEkPk1/tkUGaRGvadvtse+dkJmLf+h9cKuFONmfrs9cMVQteJuu5RK2gCyH91b1V5FpITbvOHVnn
	ks+rIDCeMRpBU3EmPml35Mqc9yJU0M1NLwk0DuXhqbqstmmWqdMTMrmYs/MiYqaXO+Od5e46uAm2n
	2H7BFRUrl9M6T4/R5sC0DUXQ49atwCjceL7VZBih0fwnfunbrJeA57Pfyqcf80TA8AtTv9tNvpCt6
	L8jmzXSlYULQCOGXK526z5FTu9wG8MShUv4HYe7wBxAuGTKZHRwW0yG3G0gnI574vw8VO3A3NNEud
	xCIAQ7SCOENSnthAWy/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iz0L9-0001bB-48; Tue, 04 Feb 2020 15:42:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iz0L6-0001aL-Pv
 for linux-nvme@lists.infradead.org; Tue, 04 Feb 2020 15:42:14 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6310720674;
 Tue,  4 Feb 2020 15:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580830928;
 bh=BjJC7k92nscSHgX3QEP5TLsEjNIcUbWPSbm8tJPQCms=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=vDF1etBtRok8p/4+IjEevyVwRJwKpsalx/+GC/Bk2GJ74irf9F6c/odDItuYwXFMI
 1I3YruT5lJl36VvIxUcSqTsUyYzKlMoTqc2uwQEE2UmAQT5DIJPCOT2Xv03TzC57KJ
 RRVAxNfhvxGZP2J/g+wn4CSC7JHif4ES6SMGAnDA=
Date: Wed, 5 Feb 2020 00:42:00 +0900
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk, tj@kernel.org, hch@lst.de, bvanassche@acm.org,
 minwoo.im.dev@gmail.com, tglx@linutronix.de, ming.lei@redhat.com,
 edmund.nadolski@intel.com, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 0/4] Add support Weighted Round Robin for blkcg and nvme
Message-ID: <20200204154200.GA5831@redsun51.ssa.fujisawa.hgst.com>
References: <cover.1580786525.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1580786525.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200204_074212_878842_94E455D1 
X-CRM114-Status: GOOD (  14.16  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 04, 2020 at 11:30:45AM +0800, Weiping Zhang wrote:
> This series try to add Weighted Round Robin for block cgroup and nvme
> driver. When multiple containers share a single nvme device, we want
> to protect IO critical container from not be interfernced by other
> containers. We add blkio.wrr interface to user to control their IO
> priority. The blkio.wrr accept five level priorities, which contains
> "urgent", "high", "medium", "low" and "none", the "none" is used for
> disable WRR for this cgroup.

The NVMe protocol really doesn't define WRR to be a mechanism to mitigate
interference, though. It defines credits among the weighted queues
only for command fetching, and an urgent strict priority class that
starves the rest. It has nothing to do with how the controller should
prioritize completion of those commands, even if it may be reasonable to
assume influencing when the command is fetched should affect its
completion.

On the "weighted" strict priority, there's nothing separating "high"
from "low" other than the name: the "set features" credit assignment
can invert which queues have higher command fetch rates such that the
"low" is favoured over the "high".

There's no protection against the "urgent" class starving others: normal
IO will timeout and trigger repeated controller resets, while polled IO
will consume 100% of CPU cycles without making any progress if we make
this type of queue available without any additional code to ensure the
host behaves..

On the driver implementation, the number of module parameters being
added here is problematic. We already have 2 special classes of queues,
and defining this at the module level is considered too coarse when
the system has different devices on opposite ends of the capability
spectrum. For example, users want polled queues for the fast devices,
and none for the slower tier. We just don't have a good mechanism to
define per-controller resources, and more queue classes will make this
problem worse.

On the blk-mq side, this implementation doesn't work with the IO
schedulers. If one is in use, requests may be reordered such that a
request on your high-priority hctx may be dispatched later than more
recent ones associated with lower priority. I don't think that's what
you'd want to happen, so priority should be considered with schedulers
too.

But really, though, NVMe's WRR is too heavy weight and difficult to use.
The techincal work group can come up with something better, but it looks
like they've lost interest in TPAR 4011 (no discussion in 2 years, afaics).

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
