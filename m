Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645B0CED278
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 14:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=s/lymXYoCV742fut5rNz1QdRGMwe+LLRB8FhDplNi34=; b=C4XOdWhu9LA7IFfhhlttsn6pp7
	8MrFvdMGRKdTaL2LYMCMvzueDRvNzWV+pe6zpJ2yjsAZc8bGjsSZNRtwuNsvEeJn5PJIi1PwGTyQf
	bE/w/m39LTU/tap8VO5ii9pe4Kldub7z4NjdcAM128Gvp3kkH3uabQ9nutrPpSDlFgMBao22DhtGL
	WZib8ak+W9n0LVXWcmZ459yV5dfzmH+MK7qdcK0+TG1McaUHsXtCBes3tn7ayUXGotnD48PucSP9O
	KERHQNHDiIw6dwzMYdy91w3zhLA2iwQBhz4aXIMfB4fBDUBLq7MQii1ZdjsWi8l8YoWCWBCmAG6vw
	B6pcPNtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syBgG-00000006HHo-23I6;
	Tue, 08 Oct 2024 14:59:20 +0000
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syBcT-00000006GR3-3wa0
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 14:55:28 +0000
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 02024138039A;
	Tue,  8 Oct 2024 10:55:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 08 Oct 2024 10:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1728399321; x=1728485721; bh=s/
	lymXYoCV742fut5rNz1QdRGMwe+LLRB8FhDplNi34=; b=JVU5R0lkKv4f13g/Sz
	RGl3h9EkgbQk1nfZ155I1Sgv1x5HpD9msMhkOjubfYf0/gZG/tW40L7Dzl8oVUQH
	/SnzhZbvE9PAoVRWyI0Q7dryZsNLzKSBKPbdx8ek0fWI75DwcDAEH2YbmOiqHQRb
	Euq1evAttlT/2Bo6ZIbLVbkGgvT4ct5IhktsP5t0xPKkoNLliLh1elUFE2OBtCiT
	6E/qW/fHeIhbMny2OVXiU6LotTACtnQ5R2I6gCyjgDl69Nmsu8AF1Pv4qjTP3LHT
	N7C2R+kZ/ZjJl06yl4l8EzchvPkhhgyAk4zv2qWM86mcfqnTa+uVxWGH1eO5Tqn9
	SblQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1728399321; x=1728485721; bh=s/lymXYoCV742
	fut5rNz1QdRGMwe+LLRB8FhDplNi34=; b=mKRnuW+uEpbNkYDIK23CLu9PItby3
	1vWzvpIBtygGsZSOTReMScbdI8hZCtGVKfa11QndljNUqxRThUg+TQDpNdmz+85S
	mC3LDpP24dahey9N3pGNForHobzK+BP0zD3xDDapTNSW1rnCx/e/8yc50dOhzpkB
	xgOqqWQiNRKBdCuUglLt2JsSITF+lxAYxXDB+ePGziWx66UKjeOrYRo0/pXPqOHC
	9TsT0jg6NuCpHhfAmLCp4UQGfMbwbGciMjV6oVZatckfjFPBigOhhW877duQWlrv
	yyodiaHvRFJUpnQRIFLdfwCk57CbsFvkWaZuVCT2ji8ydh7nB+qLH1s1g==
X-ME-Sender: <xms:2UcFZzQo14R-qk98LZwhAe_IC_XEYSDmAcZ11LyY9UDZr_EN4_CoQQ>
    <xme:2UcFZ0zyoE3cyaxwVKcnib_HuAFsf5naV_RjH9yXmr12HPPDo4fUWR03CNytKFeC3
    kGKO7zk1DdtSVz0D_s>
X-ME-Received: <xmr:2UcFZ43Kp-Q3TXNSZFmqp71nz-F0arODMYbjS5vpprBEfxVVzphwlLafgv78X9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffogggtgfesthekredtredtjeenucfhrhhomhepofgrthhirghsuceujhpprhhlihhn
    ghcuoehmsegsjhhorhhlihhnghdrmhgvqeenucggtffrrghtthgvrhhnpedugeffkeehge
    ehvdfgfeelvddugeffgeeuudelfeekvedtfeejgfduhfdtveefudenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsegsjhhorhhlihhnghdrmh
    gvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehk
    sghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgthheslhhsthdruggvpd
    hrtghpthhtohepughlvghmohgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggr
    shhsvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnvhhmvgeslh
    hishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgslhho
    tghksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrthhirghsrdgs
    jhhorhhlihhnghesfigutgdrtghomh
X-ME-Proxy: <xmx:2UcFZzBYS2DP7xV_zRjZ9-Q1XvdbCb6jBRorYfVE1H_l7FlYvx0ftA>
    <xmx:2UcFZ8hw09kA2A4Aua9-mwgSFD55KD1mdNQ0vEahy4N7IoTL1JT0uw>
    <xmx:2UcFZ3pRoZ-mHlX8K6Xbp_2IApF_Kf1ixjLlYb9UX6UGzv0Dn79Okw>
    <xmx:2UcFZ3je-EGBIFCB6804HHLQjJGrMLxf4lNEey0rTsbOypzj7rAGNA>
    <xmx:2UcFZ1Vwwj086ME2qaOkAcynZJ_7gCpDd8ZGPgO6TKdHPu21TqLXDd2x>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 10:55:20 -0400 (EDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: kbusch@kernel.org,
	hch@lst.de,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Subject: [PATCH 0/2] nvme: add rotational support
Date: Tue,  8 Oct 2024 16:55:01 +0200
Message-ID: <20241008145503.987195-1-m@bjorling.me>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_075526_828466_530BDC67 
X-CRM114-Status: UNSURE (   6.39  )
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

From: Matias Bjørling <matias.bjorling@wdc.com>

Enable support for NVMe devices that identifies as rotational.

Thanks to Keith, Damien, and Niklas for their feedback on the patchset.

Matias Bjørling (2):
  nvme: make independent ns identify default
  nvme: add rotational support

 drivers/nvme/host/core.c | 12 ++++++++----
 include/linux/nvme.h     |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.46.0


