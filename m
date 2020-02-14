Return-Path: <SRS0=f2Gy=4C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8124EC3B1A1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 17:09:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B9420637
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 17:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mmywJFAg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULHb4OUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B9420637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PTuK98wipgqhyNlOOUauu+TlgoXunfM1OAp3r4sezio=; b=mmywJFAgC3ZRG5
	NyfZTimq/SWyeJIILyJxvXPoB3eLcGWHkq/7am6fRnR7C2hjXL/orLitnSQVeebRj7LxYQfqiDlOC
	fnYR8Cx70pLaAL7ZW9ZKFva+Vp95oGnwsO7mgHymk8MRTHUp2SBGLEp+eDU5ef42fQKv+VHRQ+HmC
	a4DxlDnmXmmkwAVA/WfobX9Bk/69dWVKijxdvyyDUquyzqI48uIxPs+vXipzGYHdRVsWi6Ceqs5Cy
	ziHRy/pa5c0D0C6Z+V8XYlIP2h8AXecP/UcKBGAGJ7x3xldEn7+7dxY0OtM7pczsykcDfDKOpNoAJ
	j2c8e/xuGxfX4KjRwdNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2eTJ-0006sQ-HZ; Fri, 14 Feb 2020 17:09:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2eTG-0006rR-Sr
 for linux-nvme@lists.infradead.org; Fri, 14 Feb 2020 17:09:44 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A2A0C20637;
 Fri, 14 Feb 2020 17:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581700182;
 bh=srd0BQSrMSs7+ZJomvRod1Lalp2jyenYJHQL3h3jt6Y=;
 h=Date:From:To:Cc:Subject:From;
 b=ULHb4OUWYUZtvnn8g+Eav4TavW+eG0dHDLhOQc+Hnr5TEdzlg2Dx9lfu8z37WDeyZ
 IOw8y0SuGDDbqfg8Ue7SWplFAOZQNw1WV28gGpPCrvBwqeCC0ltgtdJ1yRMfQr05Jb
 3vj9min6AUBZDLj7kt6T2K65UAF+KwgBE4tmwKSM=
Date: Sat, 15 Feb 2020 02:09:39 +0900
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme for 5.6-rc
Message-ID: <20200214170939.GB10757@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200214_090942_957354_E0CA9A6D 
X-CRM114-Status: UNSURE (   8.85  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-nvme@lists.infradead.org, hch@lst.de, Chaitanya.Kulkarni@wdc.com,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.6-rc

for you to fetch changes up to 4c8337a0b7bb7fe7ffd75a7be2aa40804442cf16:

  nvme: fix the parameter order for nvme_get_log in nvme_get_fw_slot_info (2020-02-14 23:24:23 +0900)

----------------------------------------------------------------
Anton Eidelman (1):
      nvme/tcp: fix bug on double requeue when send fails

Keith Busch (1):
      nvme/pci: move cqe check after device shutdown

Nigel Kirkland (1):
      nvme: prevent warning triggered by nvme_stop_keep_alive

Yi Zhang (1):
      nvme: fix the parameter order for nvme_get_log in nvme_get_fw_slot_info

 drivers/nvme/host/core.c | 12 ++++++------
 drivers/nvme/host/pci.c  | 23 ++++++++++++++++++-----
 drivers/nvme/host/rdma.c |  2 +-
 drivers/nvme/host/tcp.c  |  9 +++++++--
 4 files changed, 32 insertions(+), 14 deletions(-)


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
