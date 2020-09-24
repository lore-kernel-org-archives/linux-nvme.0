Return-Path: <SRS0=MLi/=DB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2C8C4363D
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 20:53:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC182221EB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 20:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V5q8V0uv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="daxcQ/vG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC182221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PAK70jDJ5Wqb28cs+j2BjBt1vviLOJ9ZSoM+6prUFG8=; b=V5q8V0uvtHbB5OmP/d4ssd5G2z
	ccY5f/A0MbNUdj2vfaSUjmcogudbs5IVn23A4px+VYjzpiDgswGyYtzqYInjiQaN33wfavFPPY41b
	gDVeEzeVjntVG1JZGvmiKjdGFaxYmCYDwdgqc3Gn6cZWUGTiEXSWDkGibbzZ3wzoWsVkQD4pxELbe
	Y0KyNSKDrsPIsdjbp3Mx+7Sej7mu+QVnnWWX+z8agvVe15hnqcM7xE2BNJa3nC2uZymABoymC4vc8
	4CCVTvlWmI4cBY1Hq+clpRT4oWtG2k0ay4NuBna1wJqeBqtLg6KqGjWYTWBP1/DcSDJvPFwBnVeKt
	Y8giG+Rg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLYFI-0002sM-6n; Thu, 24 Sep 2020 20:53:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLYFE-0002qL-LH
 for linux-nvme@lists.infradead.org; Thu, 24 Sep 2020 20:53:37 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 063112399A;
 Thu, 24 Sep 2020 20:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600980815;
 bh=5VtJpDdYtCwZlRfMorsUAUPg+YDyujpIPaxXRnHMyk0=;
 h=From:To:Cc:Subject:Date:From;
 b=daxcQ/vGVx9MCUGijrm4hmX+iKBonjPY15FIt/uGOh1wm90jRQKKGJYiyFx3dyuMM
 4VooFuArvyGQFZm7MOndPrZi+x9DBAJlvd8EkcmIA/kDqzv+BUqLMt/D1ho9hJZlq3
 HkM3V3ooptvquX+48unEw3k1OuJtcy40JnTu8Io8=
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Subject: [PATCHv4 0/3] zoned block device specific errors
Date: Thu, 24 Sep 2020 13:53:27 -0700
Message-Id: <20200924205330.4043232-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200924_165336_760762_58C20597 
X-CRM114-Status: UNSURE (   9.17  )
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
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Zone block devices may have some limits that require special handling.
This series provides a way for drivers to notify of these conditions.

v3 -> v4:

Added reviews/acks/sobs

Dropped unintended patch

Damien Le Moal (1):
  scsi: handle zone resources errors

Keith Busch (2):
  block: add zone specific block statuses
  nvme: translate zone resource errors

 Documentation/block/queue-sysfs.rst |  8 ++++++++
 block/blk-core.c                    |  4 ++++
 drivers/nvme/host/core.c            |  4 ++++
 drivers/scsi/scsi_lib.c             |  9 +++++++++
 include/linux/blk_types.h           | 18 ++++++++++++++++++
 5 files changed, 43 insertions(+)

-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
