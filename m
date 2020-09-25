Return-Path: <SRS0=ggB5=DC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7830C4727E
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2020 01:28:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA14C2083B
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2020 01:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PBF4Gtwa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2UiWXKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA14C2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PAK70jDJ5Wqb28cs+j2BjBt1vviLOJ9ZSoM+6prUFG8=; b=PBF4GtwaIEmEFh8VFwa61zk8ek
	0yMdujhT4DrGUZy+Cej23Or1cWoA7Uij3xJjkFWEaCR8KNcbZPVZPTCJme/zsZeUhP75CfrQCbcoC
	oWAKdvFvHm1c9UJhMDSHEGzj20yV3iAEuZCmtR5VStMceswAtFfxbJPFjDMvYBldtOmf31pLrjjX3
	iFoPJLKHE11MLziZKVQTsxZS+ylhfPmQYzoKKL1cev2V0cP8Zp35HtgPGUqHJosarEcSvJ2F1ASxU
	ENqxfXuAO2uyi4ywCYe6tTYcOzZD3AL92fbbU6amBsH84FNpyYowMtdH5N0eW/63F5T/oJ5Sblc8G
	akX25pWA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLcXW-0002C1-8a; Fri, 25 Sep 2020 01:28:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLcXS-0002Av-CJ
 for linux-nvme@lists.infradead.org; Fri, 25 Sep 2020 01:28:43 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2035320809;
 Fri, 25 Sep 2020 01:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600997319;
 bh=5VtJpDdYtCwZlRfMorsUAUPg+YDyujpIPaxXRnHMyk0=;
 h=From:To:Cc:Subject:Date:From;
 b=Z2UiWXKbQbJSc+yQpun/bDs5/NcjuHWRe9tkKiqGMHZlsgMmsEUVHZxP6nyGaRwqz
 fjBNTwUMIAfvc8HUBkRAqwFCDi5wsmzqbHq4zMENphEqDoacUDrKEuMFizuRcaTQgN
 L1kdPkolCTr9I1Rz5/vbo/g1Q2F2v5seKk7SWI6E=
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Subject: [PATCHv4 0/3] zoned block device specific errors
Date: Thu, 24 Sep 2020 18:28:35 -0700
Message-Id: <20200925012838.4043473-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200924_212842_491678_E18D662A 
X-CRM114-Status: UNSURE (   9.15  )
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
