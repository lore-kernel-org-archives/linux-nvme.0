Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B35C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 17:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yVKnnx3nGv58XIhohmD8YC/9XWjcPJxStsuvrouzqJI=; b=zlDzq1EVRk9ByaBVwibBAyqRhz
	DP71MzLpFLH6qApzZdmU92ZJFgbLcBdgeKip37qIGTmudYeETDbbnJUvZShHUbnlNQXLFDb2ZFb3c
	jl4oaidjxSoz3S89wII4fHxWAoV0/sJecGMFxk27EQtOn0MZQMgd1mf7ngXMxjdT/cTrFHXJ1lSWb
	94Zl8Vsyh+hOYyO7PGzlD9IAa6eCm9InTqHII0IEz7ovtcfs8RoJWCshE41y2ImCfXS8mjBhhWjoE
	phe7Oak2cH4Et/gpjRPUY+OL3IWbTK1m//wAqamES05yhdAEWTz0OladLOea/IKBTM36n/1zN7PuQ
	BAgGhnuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whsIR-000000036RZ-2QG3;
	Thu, 09 Jul 2026 17:12:23 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whsIQ-000000036RO-1Dce
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 17:12:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9279061381;
	Thu,  9 Jul 2026 17:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54A81F000E9;
	Thu,  9 Jul 2026 17:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783617141;
	bh=yVKnnx3nGv58XIhohmD8YC/9XWjcPJxStsuvrouzqJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BoGb97ciJaZgsXgFQWDVKLL4Um1ulGHe//Z5odlSuM0x/7ulMjGxyvoFx+TLP8VSU
	 rgwjbVRCv8PuL+BOazMW0hvYYUhBcrALvU2SPDS+htSamomYfnVPs8zXyhOhtTOUWX
	 5f/er/rtLn3i9dmz2ohGI+IBC4Nld0WrERh70fjb5I9FjCc5hW831wVdjWYGVgBrJ5
	 bjVzdEV+8cO80grzQTjqb+WBlkVvRbYbRac/azRC8ZB7OduRCjyl/mHhfdHm9xhY7z
	 OhiXiUd4KTHCi2V+2SMlvWZenTtL3tA1JPM+9AOM6JytfI3jr2YVVTMfvB7xZbO72F
	 ZMH+pRPCWuBsA==
Date: Thu, 9 Jul 2026 11:12:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.com>, Daniel Wagner <dwagner@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org, xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v2 0/2] nvmet: add namespace-level debugfs for
 reservation state
Message-ID: <ak_Wc7aHCnZtLLPD@kbusch-mbp>
References: <20260707121114.2273629-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707121114.2273629-1-kanie@linux.alibaba.com>
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

On Tue, Jul 07, 2026 at 08:11:12PM +0800, Guixin Liu wrote:
> This series adds debugfs support for inspecting NVMe target reservation
> (PR) state at the namespace level.

Thanks, applied to nvme-7.3.

