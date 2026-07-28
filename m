Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049E1C54F4C
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2026 04:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I/A4gn70325KUZJ/Rtihsf8rAlwmOGXRYvqzMnudxyM=; b=ek1QTIQh7QH4ief9gv98/noMWm
	4gSwOjaxYFXmZqGipTUgQOnNaY1Rz9ZIS1JGrpQCkYbwA2XmaUyiL1nFcAHkTrlMWZO9BWHDYeWme
	m/dSb7njlWVIv/fpzoQpft2ODdqgYv/Psvmja3RS1bWEhDcs3nhFHjDjR1ZLRPIJhd8NDAZUVb2sd
	1xpoADYFESqu31KUZr4mf316qO3rHrNXN8EUOPbSpx6ykv5mxvLd6D99lwIUQda6dV1tuHYEud/54
	RUnzujy0RJMe0sQuXE9gVvx4FdDZzxoVRTNc4S6S2D+M0D4MXHDoN5ucA5Cp2WiSvIMYD9xVmdaLS
	3aBDaVaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woZfs-00000004PBp-2BA3;
	Tue, 28 Jul 2026 04:44:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woZfp-00000004PBT-3olZ
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 04:44:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 37C5968AFE; Tue, 28 Jul 2026 06:44:09 +0200 (CEST)
Date: Tue, 28 Jul 2026 06:44:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: changfengnan <changfengnan@bytedance.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bvanassche@acm.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Jun Zeng <jun1.zeng@intel.com>,
	Gang Cao <gang.cao@intel.com>, Jun I Jin <jun.i.jin@intel.com>,
	Liang A Fang <liang.a.fang@intel.com>, Yong Hu <yong.hu@intel.com>,
	linux-kernel@vger.kernel.org, Guzebing <guzebing@bytedance.com>
Subject: Re: [RFC PATCH] nvme-pci: adaptively poll completions on busy
 queues
Message-ID: <20260728044409.GA20140@lst.de>
References: <20260723120556.58670-1-changfengnan@bytedance.com> <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.2c741811.b6d1.4c47.8747.ba7d54957ca3@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.2c741811.b6d1.4c47.8747.ba7d54957ca3@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_214414_124459_8430D90E 
X-CRM114-Status: GOOD (  12.44  )
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

On Tue, Jul 28, 2026 at 10:24:52AM +0800, changfengnan wrote:
> The patch showed 50 confirmed throughput improvements, with a median gain of 25.2%
> and a maximum gain of 63.0%. Only five cases showed confirmed regressions;

Can you drill down into the regression and figure out why they happen
and if we can mitigate them?  It would be nice if we could find a way
to avoid major regressions and enable the adaptive mode by default.


