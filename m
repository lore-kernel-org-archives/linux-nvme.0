Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB3ECA1012
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 02:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TBwh1TSYPc3XjuO9wPalk0DyJKlPWGgfkbRcqoWukzQ=; b=ms895CTy3TkjLonUilkeI3baSJ
	0QhBm/MABVc1+Ielnq5oOjEoREk4M6aK8Z+mFCbCDiEH7CXIvp6oRdjArHl6PEK1m9uo9GWwe3t6w
	EHfIC/dzYSczvwARDa5BUdrvRP02Lxy6993FwG85keyvcB7DB0MlnE4bSGDoO+uzUJcf0lvcHlMpq
	1/FLfZwAatxH+XutV52HafyN8Lj/fSS1R743CWpZ1/IWH+E/34g6SitdXh+oi4USUQGS9Pc+MiDbu
	J1rLIQXH19DssV2TZJUpT8j4SXGIQJx7Ut/oisp/Jd77784kenp+m9WDvMV6gZMaqczIh1mb1cSPr
	qahj8PEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuM6N-0000000G5Mc-08Kk;
	Fri, 05 Sep 2025 02:22:59 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuJ08-0000000F1qD-3IFq
	for linux-nvme@lists.infradead.org;
	Thu, 04 Sep 2025 23:04:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 35FA460195;
	Thu,  4 Sep 2025 23:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A936CC4CEF0;
	Thu,  4 Sep 2025 23:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757027059;
	bh=zrXuS2AaZYUIMaOpsXZ4Dcr3h5lVKRI2xmwpqH0EZqs=;
	h=Date:From:To:Cc:Subject:From;
	b=UXnZ2BElpmOyUkYeoIyoka2o5bva25ro79l2iO7gl8CtSHDyFYmfOWcaEKBdj6LPv
	 A2Y2STIKZmhNIeooDe+SGaHZ20GGLEVToGDz6C0HuOx/k49Pd3re0i7MknClvCuiQs
	 tPJFEF+bfraDGMK4cb55WU2zIxMpqg41sS4uuiHrRTMFREkhgqbiZUABC6XjtHjMjc
	 8qcP12jMK4HQQPK+RZfdXmsgcPe+iSyoPF1IYQmH/bCeu+wpA9SS1mtATziOvrG2EJ
	 B69JgqVEmB1vPm+xgbVAgSJ6VZnORcfsl9dLlVDlZQVQXWFeU8qOkiibZmlqz6RkrK
	 1ZKKInrdq5eKg==
Date: Thu, 4 Sep 2025 17:04:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for 6.17
Message-ID: <aLoa8Wt-yN_rSS45@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The following changes since commit 95a7c5000956f939b86d8b00b8e6b8345f4a9b65:

  bcache: change maintainer's email address (2025-08-28 10:05:37 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.17-2025-09-04

for you to fetch changes up to 7ac3c2889bc060c3f67cf44df0dbb093a835c176:

  nvme: fix PI insert on write (2025-09-02 12:21:42 -0700)

----------------------------------------------------------------
nvme fixes for 6.17

 - Fix protection information ref tag for device side gen/strip
   (Christoph)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: fix PI insert on write

 drivers/nvme/host/core.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

