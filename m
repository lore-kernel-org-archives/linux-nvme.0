Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D772C47073
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jan 2024 18:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Bisy52+4v+u+GwuKg5Tzrfw8JADYsFRUtOE99jsZPQ=; b=LXQSC9L31Oc6DTHYCJEZeQ1ID8
	vefqsFa4Y9IFWSj+xTHS0Zd/tyToSTQBIvhNmrH3dU1Twj+xx0l1o+Idyqz+MQ1HQhHEEwMtjqMrp
	36/4z/B2xOmQ8Fss6+KVRZn0ihRfFZRJxrDvHdb77S1sU+PapcNC1+3ERPvKCpp4bmM1wxonQ9ThR
	mxUadfXq8JWhoVVPB2SBnxGahqkrC9SGHqw6oZt0RpCa+9CpsjvZf/XsabWTgGLD+XeWR/DkGvZlN
	jajH0D+/yoJyrVpEwgXcBu7zbJTQ2j1c7XqGWq1PtDU5JG3P47p9cJKeVqr27I1OSXWat2fYBOQYy
	6iDUZtlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNdVG-00DUvv-2x;
	Wed, 10 Jan 2024 18:40:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNdVE-00DUub-24
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jan 2024 18:40:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 214E96169B;
	Wed, 10 Jan 2024 18:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCB3C433F1;
	Wed, 10 Jan 2024 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704912031;
	bh=1Bisy52+4v+u+GwuKg5Tzrfw8JADYsFRUtOE99jsZPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L6QA385JFf7m8iRGMu5ALTiAL/XVPYKPMviprK2QJZHYbktlYrV+nwLKQ/Cs0Hc7A
	 rBDwO2tSiUPsVmFysnIoNeW6CfAvy/1ZcqgvJD4oVJwGrP/4i9YB1VbLXRofhJPnmW
	 Sc/i2T65Cmmo4zidwHPfbpJQfuF3JQwn5q2v8JAoR/EqWAQoF+grcNsmQbIx/Fenz8
	 nOHBVBRLx++duafZnUBwortRsjkArIqJ9VbfCpO9/FNLmdyBOQZdNgLaDGMXeuODiZ
	 dsjCPHMdEARdX4uUWqi2PNKtPSe4aK+4Rzgpp5seXeZ2ytpovcxeIDpK+Mg9KXM8AY
	 0TUGgv/2L8Geg==
Date: Wed, 10 Jan 2024 11:40:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: William Butler <wab@google.com>
Cc: Pavel Emelyanov <xemul@openvz.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Inform controller of doorbell config before
 unquiescing IO queues
Message-ID: <ZZ7knJGSVx8hWvaW@kbusch-mbp>
References: <20240110182855.1833512-1-wab@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110182855.1833512-1-wab@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_104036_728499_9781471A 
X-CRM114-Status: GOOD (  10.47  )
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

On Wed, Jan 10, 2024 at 06:28:55PM +0000, William Butler wrote:
> During resets, if queues are unquiesced first, then the host can submit
> IOs to the controller using shadow doorbell logic but the controller
> won't be aware. This can lead to necessary MMIO doorbells from being
> not issued, causing requests to be delayed and timed-out.

Good catch. I guess we wouldn't normally expect any requests to be in
queue at this point, but plenty of reasons it could happen.

Applied to nvme-6.8 with a slightly updated title to match the local
conventions.

