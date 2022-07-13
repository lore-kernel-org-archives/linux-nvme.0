Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A53EC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 10:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FD8BDK4X+ZzmmlH6OtSYYvImmuY1w3N7LKxwjYpBnvQ=; b=AQkOcqm8yD5/rmcO40cYN2Nefl
	XVlSx10ni2a1FRFnfnfn0VoY3YesWNvAHvKpUwHCADDukQdlBwM7e9goviK1hb/UGM/FxH++QeHxA
	/mvXDvo2LaPpHJ4UxR5sUaI+FIQROoJ8o4dI3bNi8VodORc4Rdnr5s74XkWn5Y7c/JEBg9ttPugd2
	v0iCSEEO7tPB55TX4y76a8Vda0H2hTim3Q77XnkGm5Lc89N+ntWZozKx7xfW8RM2fhyYRcup/XmhU
	0cy4Ra4FkwPWIgKjV27+LeD692fvp+RGjXDoGYtdSdpsMzTa7Q+RWIJWi72EIOtgDaKLbi4h35hbE
	nVpXY/Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBZMZ-002cxv-S3; Wed, 13 Jul 2022 10:12:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBZMW-002co3-QA
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 10:12:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7CBD167373; Wed, 13 Jul 2022 12:12:35 +0200 (CEST)
Date: Wed, 13 Jul 2022 12:12:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	kbusch@kernel.org, axboe@kernel.dk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	asml.silence@gmail.com, joshiiitr@gmail.com, anuj20.g@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH for-next 4/4] nvme-multipath: add multipathing for
 uring-passthrough commands
Message-ID: <20220713101235.GA27815@lst.de>
References: <20220711110155.649153-1-joshi.k@samsung.com> <CGME20220711110827epcas5p3fd81f142f55ca3048abc38a9ef0d0089@epcas5p3.samsung.com> <20220711110155.649153-5-joshi.k@samsung.com> <20220712065250.GA6574@lst.de> <436c8875-5a99-4328-80ac-6a5aef7f16f4@grimberg.me> <20220713053633.GA13135@lst.de> <24f0a3e6-aa53-8c69-71b7-d66289a63eae@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24f0a3e6-aa53-8c69-71b7-d66289a63eae@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_031257_033444_63BDF749 
X-CRM114-Status: GOOD (  15.97  )
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

On Wed, Jul 13, 2022 at 11:04:31AM +0300, Sagi Grimberg wrote:
> Maybe the solution is to just not expose a /dev/ng for the mpath device
> node, but only for bottom namespaces. Then it would be completely
> equivalent to scsi-generic devices.
>
> It just creates an unexpected mix of semantics of best-effort
> multipathing with just path selection, but no requeue/failover...

Which is exactly the same semanics as SG_IO on the dm-mpath nodes.

> If the user needs to do the retry, discover and understand namespace
> paths, ANA states, controller states, etc. Why does the user need a
> mpath chardev at all?

The user needs to do that for all kinds of other resons anyway,
as we don't do any retries for passthrough at all.

