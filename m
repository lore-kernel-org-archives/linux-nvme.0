Return-Path: <SRS0=/503=JU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039E8C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 22:06:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B767C613AB
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 22:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B767C613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FLHRlRH6K6eRDDsg2UGMEsLw6fi+IGDbPsHA02IpsTs=; b=kAwTQiRri8Z3aQT0L03pXaRiVx
	Xb936d9e6yCyZBfgUGE/rQ829vmPBvkBCc0CPLiRGgOjJMfx9GyWPVeJrkAVVnDzrA2VqshtsX385
	j9TfLiZcZLHvKnfqEOp6UJLE42hdUDfqVuCcXYAt1sDDdVQZL1kkPLASaAPlu+HK++GheD8NHTFNc
	hP/6rETsk4KZTGY8kFEcQmC24JKFrmT6MEapHgF+TIri8KhZaRxSQZ0Ye8Pe+Zl91kC+uXlzVJWam
	O8XUNn6NT8iy/nBQyMPuaG1uEok/Jy/auTmYpRGX4rHCD95yIqEI7FfICHI1Hnt35/D6LxtZx2xzP
	pAmgPY3w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1la3w7-002TDq-Bo; Fri, 23 Apr 2021 22:06:07 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1la3w3-002TDW-Rc
 for linux-nvme@desiato.infradead.org; Fri, 23 Apr 2021 22:06:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=mvyhOILEFU37QsQdvwREtMRiMkmN9e5YOHDldfs6Lcs=; b=HN2wTjtI30Bhtbsg5XcjuZuvsF
 Y569udneJ3TBzuzAcpDiT298fytn6Wp4qNA/BTfyishMuabOCMozmNZRHuiPnsoHP1wCCeVK8npzJ
 RZMpjmABwR/xjQldMX7wQtPQxURi7sXyj3DtzlGqjzWMGWNKmnQxmwAEGJb+iv8QIF3WHblQEXaMD
 7jQ9pYgnquDSVmw6Wcz+YmUMBlEGhZjDKl5/522OHe2O4N0yLyHvyrl7ilB/lB0I7x/QcflKJZ+uK
 S4Jq8u1mVK9gneZM63gpARw11GTuE4hqnqtgO3jZ3l1wLjvI5oEgGQRvtvLeUB0SxkfItdYlGriRW
 D1I3snlw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1la3w1-00Ej7p-E8
 for linux-nvme@lists.infradead.org; Fri, 23 Apr 2021 22:06:02 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E7ED61467;
 Fri, 23 Apr 2021 22:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619215561;
 bh=+EWqmc8YwD8d9cozTk6jy29faIJiC8bZ96N+cd5c9TQ=;
 h=From:To:Cc:Subject:Date:From;
 b=cUax5d3HL67Fv0R8h/6zbwIbDpPJz/S8k8IFUg0En+T15P06zp2WPa9uDzaQ1Ch01
 I7RQEVVlO5XJREn0ucyJLOZOFSQJVP3tFVbqIW0yurt+V1Bd0Ml0MkIZimOliHXrxE
 SOCLDFwhVXrVEWIkfo4hWGQ2UnJyVh2kH1zuNXFVaNdeE+tmS61bsZI5q0RqaE6Ull
 7rRIMduXbxUFgwB6BduByxIq1FF4XEYY/Vp8YahuWvUjow81LZTlEjOv5wIeaFHUGP
 83auax6U6Qbz9BZ6k64laXli6D9LM7N9H1+Q0W74rD9aggjyFhoMoM3/0bvvr0lD1V
 zj+0DtfOSKifQ==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org
Cc: Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/5] block and nvme passthrough error handling
Date: Fri, 23 Apr 2021 15:05:53 -0700
Message-Id: <20210423220558.40764-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210423_150601_511668_E0451F0D 
X-CRM114-Status: UNSURE (   8.27  )
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

v1 -> v2:

  Unify nvme's polled and non-polled requests by pushing that logic to
  the generic block layer.

  Include the ioctl and passthrough users for getting the error status
  from the passthrough execution.

  Added nvme patch allowing a user to specify a polled ioctl request.

Keith Busch (5):
  block: support polling through blk_execute_rq
  nvme: use blk_execute_rq() for passthrough commands
  block: return errors from blk_execute_rq()
  nvme: use return value from blk_execute_rq()
  nvme: allow user passthrough commands to poll

 block/blk-exec.c                | 18 ++++++++--
 drivers/nvme/host/core.c        | 62 ++++++++++++---------------------
 drivers/nvme/host/fabrics.c     | 13 ++++---
 drivers/nvme/host/fabrics.h     |  2 +-
 drivers/nvme/host/fc.c          |  2 +-
 drivers/nvme/host/ioctl.c       | 38 ++++++++++----------
 drivers/nvme/host/lightnvm.c    |  4 +--
 drivers/nvme/host/nvme.h        |  7 ++--
 drivers/nvme/host/pci.c         |  4 +--
 drivers/nvme/host/rdma.c        |  3 +-
 drivers/nvme/host/tcp.c         |  2 +-
 drivers/nvme/target/loop.c      |  2 +-
 drivers/nvme/target/passthru.c  | 10 +++---
 include/linux/blkdev.h          |  2 +-
 include/uapi/linux/nvme_ioctl.h |  4 +++
 15 files changed, 85 insertions(+), 88 deletions(-)

-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
