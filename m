Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A109CC3DA4A
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Aug 2024 18:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rmhVN4NwQ+mtCLacgBNPwca8Z/CeFR6L5+lfvndYXVo=; b=nJATgBHGuKnXstZFH444ivEr+9
	cRnqmhtpI8FXj5O2MTWQelH4SaZyQDFOGZYd+VnSJuo/qT7oEDi2An099uf5j99sw4gVXF0tnyib4
	QsY5DpJJ9aLs/oDXjIMjsy71ElgYV7/AL1mEuBnjRnmAwD6H8QCTIlcCH9jtjvCriHjeYCOc9oAaw
	2A5Dt0fC2b05WhNoyuoEi3iD685QZykC1Z1GxCQ08DRUi4rNFfv4SdSJtZ7hesHgJOAbE7/x/Gruz
	bDefwiTakfwcdgjwc5+PCBY3FcO51YFAnHcAk76GNtZ8akN8balV6M0AxMUloTgQi1nUR5LUoWk8c
	T27xgL8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sc7fx-00000009An5-1LT2;
	Thu, 08 Aug 2024 18:15:49 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sc7fu-00000009Amg-0Z5d
	for linux-nvme@lists.infradead.org;
	Thu, 08 Aug 2024 18:15:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E815761274;
	Thu,  8 Aug 2024 18:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FBDC32782;
	Thu,  8 Aug 2024 18:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723140944;
	bh=6V9ftXM91EZ9zjn2nu+L+goqUy5F3K7/tRPd6X7C/Aw=;
	h=Date:From:To:Cc:Subject:From;
	b=gL3vOIxj20chqDvu5ubZ+hH0LMIRH6GaQOhMpJ2OXSRJxjiZflRbxUDs/mOwZzHDZ
	 /wlcm4pvx93OtdISFn/hLXvm71eX1rD4BKLPKRX8jfVtkwJFlPpGPEt0i7lCOXGKgI
	 S4WRCsT5IXiZmIWgKrp0hcuG4TAwxbG2crt3d+kKVpdDqMJ44ULnpD9bPcP1zSXna+
	 PystUpqAAIzB/ZKqUrRTY3TEE0vz4BmKxKr+GP+XcShJmxl3Q+n76rKRn1g+V9fmnt
	 MmlbebxiO5d/ID516CfyLhvKe3KYIhpN/d+vMnF3BWq48K563vrCJXSHg8yhn2JE8J
	 CUUlH4ik0+hdg==
Date: Thu, 8 Aug 2024 11:15:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.11
Message-ID: <ZrULTldJ0zUbqorU@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240808_111546_263678_6D671ADF 
X-CRM114-Status: UNSURE (   6.03  )
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

The following changes since commit 01aa8c869d0cdaf603f42dc1d2302b164c25353a:

  blk-throttle: remove more latency dead-code (2024-07-27 10:33:25 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.11-2024-08-08

for you to fetch changes up to b4c1f33a5d59f577814d87704c45a745a35d8bd9:

  nvme: reorganize nvme_ns_head fields (2024-07-31 07:40:10 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.11

 - Cleanups and improved struct packing (Kanchan)

----------------------------------------------------------------
Kanchan Joshi (4):
      nvme: remove unused parameter
      nvme: remove a field from nvme_ns_head
      nvme: change data type of lba_shift
      nvme: reorganize nvme_ns_head fields

 drivers/nvme/host/core.c | 18 +++++++++---------
 drivers/nvme/host/nvme.h | 13 ++++++-------
 2 files changed, 15 insertions(+), 16 deletions(-)


