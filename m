Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75C2C021AA
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wvmLtIbLnj8RGCmUxgW5ctgPfw/pu9XolF0132paXEk=; b=aa3TeFiWTQ2ujlkahltOjwGg8A
	5XqBannoI5umGTNPVzN+DGxzcvqdYMElSVwsnmDAhQLUYK/UaWJ50yFxv5/QlIISEh+IIdOHJuN49
	HIRe6MQFF2L4BPfEg1Cydcfk64MmbCp4tmR9FYYi8EZkgObMkQjnj8X9DXtit+4vfO8h1GOvxdlyv
	9hOVFAjLM6uWVLspKE7NTGPfhJJHhSInJVphMMHU69D+d82ctxLqgp+31dmnkzJudbRIn0Q01Kw+7
	5Gti+p1n3OBrLT4NhAMGSwtZxuklu3wFH6cGQ9s72pDfoPynDdeDYEq1X6AKnx7ky8ULwEKdXCztm
	ik0zhPLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPlb-00000008nwm-0hA6;
	Tue, 18 Feb 2025 15:44:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPk6-00000008nhD-2iP7;
	Tue, 18 Feb 2025 15:42:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8CD8E5C5ECA;
	Tue, 18 Feb 2025 15:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2946C4CEE2;
	Tue, 18 Feb 2025 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893357;
	bh=h88y8D02Qk/TX7WCvgXx2cIrrke/kfsKJ5iGeFmkiFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GCGvDAbJHnQxYFlugyZvoMME9inSa/4xrTnP1H/lioBrVzj1bhxN1+/SU8ucSM67Q
	 IfV2auMMAeE/fEKvGu7t8BLa0T/hvrCm1iFOnc2ZguAOychjmKJKsKKH853g37JGLi
	 2AvACw8zqcYNdUam96RBxkuYGCEjEd8SuHqxqTFmP8t5sB1WaVWWhYfTrLG2UWS7nM
	 +gvXuPqxg6+utgTptUkSyogTiRbcuTu0spNTUFFd7pdghrBlfZN+wGXDoz1WWe3YOx
	 Fagu77v9509AAzUwPJYclDu60bjSYeIKqvI/ejNw5Af2sdrsY3QCMwKzpkyDOuyRfB
	 AQdlLwfqjFBOw==
Date: Tue, 18 Feb 2025 08:42:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Philipp Zabel <p.zabel@pengutronix.de>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v2 0/2] apple-nvme: bug fixes
Message-ID: <Z7SqahA-tuz386FN@kbusch-mbp>
References: <20250213-nvme-fixes-v2-0-a20032d13e38@rosenzweig.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-nvme-fixes-v2-0-a20032d13e38@rosenzweig.io>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_074238_738597_04703AF6 
X-CRM114-Status: UNSURE (   9.38  )
X-CRM114-Notice: Please train this message.
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

On Thu, Feb 13, 2025 at 11:12:57AM -0500, Alyssa Rosenzweig wrote:
> This small series fixes two unrelated issues with the Apple NVMe driver.
> 
> * fix NVMe on certain combinations of firmware + machine
> * fix a power domain leak

Thanks, applied to nvme-6.14.

