Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E932C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 19:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3POVyV8aRjFUAlpXTuOJtmruQs7mHFmgOGoO6QAnIms=; b=twB4Lmf/ycfBxCS84AIAdXP/gZ
	KwFpUi92ehHKe5IenQBmQVfNjEeY6le6OeNoEyc5rSrzLi33Voxte11MNIBEcZrXpMtza77Dq0ie+
	847KkVKsXkJVHt/3kzn7sDGMjk64c4C0qzDe3AABGd7Y26Cez0CNzB1CnxUB8eVUsZIUogiIVClbt
	Nb2W3NY2JSJ0V2J2slK2QQjNzFzRgbbiG5WscPfKdd8p5lYJYuKKcmdQ0LM30YXWrPnJxY2Zo/Mtr
	ARVnczqzQK4dpVhyK6jmqN8pcM3UdJeqQxYH2ZSRBmoq+fv2H8O8ht5tl2F6SsMdpSkXmjthFmnSA
	j3Zl1fxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nC4pf-004pXW-Dd; Mon, 24 Jan 2022 19:16:51 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nC4S0-004dxS-NV
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 18:52:26 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20OI4oJ1022850; 
 Mon, 24 Jan 2022 18:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=3POVyV8aRjFUAlpXTuOJtmruQs7mHFmgOGoO6QAnIms=;
 b=KC9Rb1Q9peoCzZ/6O351KD9XuwncsZKMLM5ypBJCKFzAeM6YLODcPeypascXyoFWpzI4
 HD15lJpM6skl56dwse7oR3O9zVrvbzaEB8k0aazgGgvwCqdMpvFw8U8Q/QRrH3k8J9np
 zO4VfWOko4SJ4/jTJMwz0AbAUW4PTFEg24e3izjqNx6y8iqfUATxcAP0Hn4Fk3OjJqqW
 tpuI/ihDDAkFoiwDTYR6yV/lYzeiOfNk9QrBuOoAXb29ep3zEwWLYFwspqUQE6iKRVNU
 0vaP15u5/DCyD5xNreoarDdGEl2XLPDXgxu4j0Rfp8j3fhzm3sykZ7fpi6OFOGpomj1O 2w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dsvmj952y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Jan 2022 18:52:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20OIkNaK071347;
 Mon, 24 Jan 2022 18:52:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3020.oracle.com with ESMTP id 3drbcm5arx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Jan 2022 18:52:15 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20OIqF3Y098320;
 Mon, 24 Jan 2022 18:52:15 GMT
Received: from dhcp-10-159-240-182.vpn.oracle.com
 (dhcp-10-159-240-182.vpn.oracle.com [10.159.240.182])
 by userp3020.oracle.com with ESMTP id 3drbcm5ar1-1;
 Mon, 24 Jan 2022 18:52:15 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [PATCH V4 0/1] nvme: Add verbose error logging
Date: Mon, 24 Jan 2022 10:51:43 -0800
Message-Id: <20220124185144.53810-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Es9ttUY2-SzGFWCVUxEEDxZVHD6llzS2
X-Proofpoint-ORIG-GUID: Es9ttUY2-SzGFWCVUxEEDxZVHD6llzS2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_105224_940637_20F941B2 
X-CRM114-Status: GOOD (  18.26  )
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

V4:
- Adding logging for admin commands.
- Display NVMe Command Opcode value rather than generic block opcode.
- Various other nits.

V3:
- Don't populate nvme_errors[] array with NULL strings. 

V2:
- Change nvme_errors[] to a sparse array where the status is used as an index into the array.

- Change pr_err() to pr_err_ratelimited().

- By enabling CONFIG_NVME_VERBOSE_ERRORS, the verbose status error is displayed.  If it is not
enabled, then a message will still be displayed, but without the verbose status.

- Remove call to nvme_error_status() when determining whether to call nvme_error_log().  Speeds
up the fast path just a bit.


This patch improves logging for NVMe errors.  Currently, we only get a
a vague idea as to why commands fail since only the block layer status
is captured on error. This patch allows us to see why a command was failed
by the controller. This is very useful when debugging problems in the field.

An example of an improved logged error:

[  183.333734] nvme0n1: Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR

[  227.767945] nvme0: Activate Firmware(0x10), Invalid Field in Command (sct 0x0 / sc 0x2) DNR


Alan Adamson (1):
  nvme: Add verbose error logging

 drivers/nvme/host/Kconfig  |   8 ++
 drivers/nvme/host/Makefile |   2 +-
 drivers/nvme/host/core.c   |   3 +
 drivers/nvme/host/errors.c | 230 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h   |   2 +
 include/linux/nvme.h       |   1 +
 6 files changed, 245 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/host/errors.c

-- 
2.27.0


