Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15329C43465
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 23:19:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D37D20838
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 23:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uEGj+Is1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uc7H8rbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D37D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5Cs6hmfifQtHjjWjti0VvQPMLaczm97WojHwG1ZWy+0=; b=uEGj+Is1BhmlpLA6O7NW4iyTye
	bEyGfqtocjfV4iC7bSQfTz3/aqtKTjEWDJ0lzbd2W7HozefBXsTkfWmz33RhQ5YFFTcUoxaTVeVU5
	RJGkzAYSP0W5wxfxD+ZDEBxdBuNKN93IY3ZuKC9jCq5q7rZkPTXH/oY3C5CYmsOapOom+rjdYYQBl
	Q0ohnfwvnMEVIw2DOzrLb8cyJ344ZuUvrqLDT3VXJuClbHVNQBMiK7xjQAPrqi+y1H3jmp7lQviMG
	Nq3anUKw4tRo6s2OgXo2rfJWIevMLmzd/ly3y/QSJZyCbANqoMpRbvhShj/B5iiQrOFzGI/UT7/zB
	4bG+vGmQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJ3B2-0008S1-Pv; Thu, 17 Sep 2020 23:18:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJ3Ay-0008PP-63
 for linux-nvme@lists.infradead.org; Thu, 17 Sep 2020 23:18:53 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 525CE20838;
 Thu, 17 Sep 2020 23:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600384728;
 bh=o6h0uQcYxT8hDqeNxh4o4wx37bxZ8o2tWkPFDlaL3Zg=;
 h=From:To:Cc:Subject:Date:From;
 b=Uc7H8rbAxkFA478xseYdETekhlX/hB2v82QZ4iNoLiXGkRD11mrqAaabA2QiKquuY
 8VwmF3jiTF6zasq2aqtiK2ORXVhES/zwYqzg7b/ebE+E0TeKoaSiderK9l9+WVx5nk
 YYC6vVoWY9YnPfiXa2bLzF/W5nmmI4QgV64adKtk=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 linux-block@vger.kernel.org
Subject: [PATCHv3 0/4] zoned block device specific errors
Date: Thu, 17 Sep 2020 16:18:37 -0700
Message-Id: <20200917231841.4029747-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_191852_450125_3437D2B3 
X-CRM114-Status: UNSURE (   9.31  )
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
Cc: axboe@kernel.dk, Keith Busch <kbusch@kernel.org>,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Zone block devices may have some limits that require special handling.
This series provides a way for drivers to notify of these conditions.

v2->v3:

  Split status for max open vs max active errors (Christoph)

  Include scsi use for the new status (Damien)

  Update documentation for the new status inline with the request_queue
  properties they relate to

Damien Le Moal (2):
  scsi: update additional sense codes list
  scsi: handle zone resources errors

Keith Busch (2):
  block: add zone specific block statuses
  nvme: translate zone resource errors

 Documentation/block/queue-sysfs.rst |  8 +++++
 block/blk-core.c                    |  4 +++
 drivers/nvme/host/core.c            |  4 +++
 drivers/scsi/scsi_lib.c             |  9 +++++
 drivers/scsi/sense_codes.h          | 54 ++++++++++++++++++++++++++++-
 include/linux/blk_types.h           | 18 ++++++++++
 6 files changed, 96 insertions(+), 1 deletion(-)

-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
