Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34662C04FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 20:22:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F245E613EA
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 20:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F245E613EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w8yMP1hrb0Ty6dSyFBdpUMbOx7YolQsc5erhDVt2u2g=; b=SRfsS7/O5e6wIYXSrZVlfqo/e8
	RDTbKofomHpDoripE/IcQ2snKUaGzPm7an35orSwWTZxs8VhsjgWb09ASLPHEKgm3RC4EQ62/oGJl
	yic4e8KHnsmSfQXBw54Tw4+eDCqQulgWAYp5Be4gIwYGITGB9V2ZlICi+B70sD4iweCeFxJA2AtEV
	x6zcxelxKKRDpIXRCS2FMSOghH3vfxCPAIEUB6Ft5yB/hNgFR+OYotLeYLudlrZ+Qds+rAjtHQC3E
	z5UO84cv2X4FBKlkxSnVHHaa1d3H4KRg2Y/nYo+eD4858sDeDpozf3gLAXjdz8LzbdJc9Cy3SJgkQ
	EOEHfyYA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkBef-0011PE-Tz; Fri, 21 May 2021 20:21:58 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkBeY-0011NO-5R
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 20:21:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=UzKqJ6gg/YUpFYvDMJtzoexE7pKkNNlMYrc6TrQEZxc=; b=bnvSNgoDbq9OyUuHIxNbM/SqBo
 eV3NrrbYSoLSuJdM/wQH2mkvK6OHx0Tr2+woLcbjXwvj1P7qxMBB9N/RwCrstielF/a7erdFSC7dB
 lcUqxJnPo2sYwZC6gZUKWTM3BtrGlOAdT2a66vznTVwskSTmSG5fMGUlUqyaGgJl1zucNM4sddwsY
 iBKPb1BqBaaQonL8q+dqqfMNfQAdRS6a1aZZ63zgCPft4pUTeF9hhT/FyeJfgdkvOeE/8BqNNoERu
 pEcMSGhTr89KDj0orGwwqcsUDnp1LasYLwKcG/X940XUAo1HCVHqi2eatteXXDBhXvdTavvb49/t4
 xErUKLVA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkBeV-00HPNS-L8
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 20:21:48 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 852AF61353;
 Fri, 21 May 2021 20:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621628507;
 bh=dj7b7UED/cGSL8qPn+mHfw/ztN0y5qUqhQg/dbjoKy4=;
 h=From:To:Cc:Subject:Date:From;
 b=YbBpGDHjUF5NLQNDqckEbTottmvcHaNrr2gpP7uu6uhjggh/x/IYaUFVHJg22wfrr
 q/0QdR07I+XLVvMO/JFwej75VPY1yllTeZq+O9iFXIdKRiSjq8Vn7+8hwuKP+CPlgw
 Pu13FidKZQJeFkoxi7VwNEsQLiimQg8kuTlnkV2SYZaiYs6Kq+shy7JCcrbuheaRPe
 JG7QE/yNB+z6cC6wzFSzTAliNAp9NY169kYFOUzBp499l3zKA8GrO+h7Ie0wYnNcYx
 XbdXYvLed47c5x1477j/O6n19BK0FtwII2znhC6SdGImpEt8NiX8roIsKpN4uULuvX
 ppF8RjSfZj0KQ==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org
Cc: Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>, Ming Lei <ming.lei@redhat.com>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/4] block and nvme passthrough error handling
Date: Fri, 21 May 2021 13:21:41 -0700
Message-Id: <20210521202145.3674904-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_132147_726102_6C82E757 
X-CRM114-Status: UNSURE (   7.98  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This series gets blk_execute_rq() to process polled requests and return
queueing errors so the caller may know if their request wasn't
dispatched.

Changes since v2:

  Dropped patch 5 (ioctl polling flag) since there is currently no real
  use case.

  Move blk_execute_rq's poll handling to a small helper function
  (patch 1)

  Return blk_status_t instead of errno (patch 3)

  Removed "extern" header declaration, and named the parameters (patch 3)

  Initialize nvme status to 0 (patch 4)

  Add helper function for blk_status_t to nvme passthrough return code
  (patch 4)

Keith Busch (4):
  block: support polling through blk_execute_rq
  nvme: use blk_execute_rq() for passthrough commands
  block: return errors from blk_execute_rq()
  nvme: use return value from blk_execute_rq()

 block/blk-exec.c               | 25 ++++++++++++--
 drivers/nvme/host/core.c       | 63 ++++++++++++++--------------------
 drivers/nvme/host/fabrics.c    | 13 ++++---
 drivers/nvme/host/fabrics.h    |  2 +-
 drivers/nvme/host/fc.c         |  2 +-
 drivers/nvme/host/ioctl.c      |  6 +---
 drivers/nvme/host/nvme.h       |  4 +--
 drivers/nvme/host/rdma.c       |  3 +-
 drivers/nvme/host/tcp.c        |  2 +-
 drivers/nvme/target/loop.c     |  2 +-
 drivers/nvme/target/passthru.c |  8 ++---
 include/linux/blkdev.h         |  4 ++-
 12 files changed, 69 insertions(+), 65 deletions(-)

-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
