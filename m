Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0A9ECD983
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 15:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0DK8PbYldTJNIjUD5gCiOhOK4TyHGrHgUUkh9YkW42A=; b=ATpn4bpdhbN6pQvxQOyqW+pY01
	syjgklR7yPABK54q/76vjSmIrc7+GnSaBR00QrHjr3AnMfnzq3mpYNyIVO0GgywkxzTfh3d7fFaMc
	UNBnlkHd5gu2bFhO780a+5VF2aKK2OrLG1ujeZg/A+dd95Y9n4EAZOepUd06xAn8W+yXneq7onWM1
	vauQRSQM3A/gXkH1NI/Cz/Fm8wy3kWbvgMWGCZacSNWeS6c/csxj119qAg/jieuIcF0WcGzXV5ny3
	wvbtbkbFqKyYIRZZvzgT774ZHZOL6xJeuh2XfwYTpGmR9SQJr2Be9RZPYnUXqJ/R1YCOuliyrix3V
	kbYpE8FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo1Qz-0000000A9Kk-35Za;
	Thu, 05 Feb 2026 15:38:21 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo1Qx-0000000A9KE-2chk
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 15:38:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5ABFF409D5;
	Thu,  5 Feb 2026 15:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F43C4CEF7;
	Thu,  5 Feb 2026 15:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770305896;
	bh=eKw0GNbhSGb/7NUvqnc3TTcO+szFvMEBMwtXRZijx5g=;
	h=Date:From:To:Cc:Subject:From;
	b=UFZ+hMvOXmCVZFuq9l08xSEeWSysgRsFJH5ylOjemNgRWllGsvfgQkBxrwunt/2Yd
	 CcnAKJYaNQi4FLcXk3+gOPP5IUIKifQKpz5AduJn4yXWvFSTUVtUHNooaCivfH3AJN
	 rE25yeyky9J0CnxL6A75JszyXJwJW+Bb2wkT07c6Ke7ESEBNvqsulqFlQAhTAjvUhd
	 tC5g8Gxynwk6qOz/eme2gpaqbFI85gU7LcnkmWxFbE0nxNyn7W1g51RqL6VP2FT4i3
	 Q6QUnTfUbD2LgQo/5wke3ahZcMsqi3ScxksV5GAluOHQ4dwNn+uqIrX4EfAdgfb/VQ
	 eXWMJ0XcvD5Uw==
Date: Thu, 5 Feb 2026 08:38:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, linux-block@vger.kernel.org
Subject: [GIT PULL] nvme fixes for 6.19, final
Message-ID: <aYS5ZlwruxpNCdTL@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_073819_771300_1AF188DA 
X-CRM114-Status: UNSURE (   7.61  )
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

Hi Jens,

Some late fixes for nvme that should go in this release. One for a pci
regression that causes a kernel panic during certain dma conditions. The
other fixes a vulnerability in the tcp target.

The following changes since commit 4da7c5c3ec34d839bba6e035c3d05c447a2f9d4f:

  bcache: fix I/O accounting leak in detached_dev_do_request (2026-01-28 19:06:55 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.19-2026-02-05

for you to fetch changes up to 52a0a98549344ca20ad81a4176d68d28e3c05a5c:

  nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec (2026-02-05 07:29:10 -0800)

----------------------------------------------------------------
nvme fixes for Linux 6.19

 - Fix NULL pointer access setting up dma mappings (Keith)
 - Fix invalid memory access from malformed TCP PDU (YunJe)

----------------------------------------------------------------
Keith Busch (1):
      nvme-pci: handle changing device dma map requirements

YunJe Shin (1):
      nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec

 drivers/nvme/host/pci.c   | 45 ++++++++++++++++++++++++++++++---------------
 drivers/nvme/target/tcp.c | 17 +++++++++++++++++
 2 files changed, 47 insertions(+), 15 deletions(-)

