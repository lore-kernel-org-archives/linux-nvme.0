Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B17C2BA4C
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jan 2022 18:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GvIijcpQrAJtC66zlnojOb1jhWohKQ+LJJxU7J0/Zlg=; b=dtslI8CbwzVI/N68Y+7iR7zDWX
	LcxgM3i8LftEH8a9sNkff0ofNzecLFNsS0qFXfDtcnimtTdLoJpveIwWD4Sj9G5ij7Wd92wX/XONv
	gi0htuBfd2L5RIvNll6yIcGXTJ8nSoSguthi4nbEiQcsuIgzq3LJYQwGx1/TEZ6Kl/v3EiOIJVZKj
	c9IkM9G1LC2G8KIhZQ60FsK+aBVFYgPFMxqQU0ETlq6OsuM6Ms5wFZd2M4I6agFBqhAqd50o0G8vp
	Bvc35n/Z8l2XzrISl2HT0hpM7N3JoRUd/SHuHUPfxoLVU6eBeLJGTivPCFP1zMDLoG+TWliKdiJda
	NmpmJIlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCn7E-00DIlP-2q; Wed, 26 Jan 2022 18:33:56 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCn7A-00DIkm-88
 for linux-nvme@lists.infradead.org; Wed, 26 Jan 2022 18:33:53 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QINe3w007704; 
 Wed, 26 Jan 2022 18:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=GvIijcpQrAJtC66zlnojOb1jhWohKQ+LJJxU7J0/Zlg=;
 b=AksPOHFLEd5e0fOWc2SQwZ+JWlSOCj3+Fp9PMR5h3q83/o9SjZjxvKkNhgE6FBMOmFCg
 3EhOG1N3bDKIVRp7P2vdQwuPwGtVn2WtWfTOaIJ8oigJnbgvOBrBoWRGvpjKWXjcOTeC
 mJvmn/u781f5Gbl6+VOyk2yM3KDRrXhy3Gadto+LOD5XfRBv7WYpN+Xns/IR7sr1g5K/
 s884YxAzcPe/dDUwCHRVCaSfz11byMFEVhfQQD3kdEo9mMFjBNWF0Tt7OoN1QDhl7VU5
 N+hMcbZ8FnF0gkfjHLIt95ws+ecnfcNy2Wf8FmK0PmGJy8qzzE+hevg0IIDg7otHV5BZ zQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dswh9q8vg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jan 2022 18:33:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QIROul147747;
 Wed, 26 Jan 2022 18:33:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by aserp3030.oracle.com with ESMTP id 3dr7yj9b7b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jan 2022 18:33:44 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20QIXi0h170622;
 Wed, 26 Jan 2022 18:33:44 GMT
Received: from dhcp-10-159-150-213.vpn.oracle.com
 (dhcp-10-159-150-213.vpn.oracle.com [10.159.150.213])
 by aserp3030.oracle.com with ESMTP id 3dr7yj9b6p-1;
 Wed, 26 Jan 2022 18:33:44 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [PATCH V5 0/1] nvme: Add verbose error logging
Date: Wed, 26 Jan 2022 10:33:12 -0800
Message-Id: <20220126183313.85877-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RJM63lXYpRqnc3ceNreK0CvH-McRHnA0
X-Proofpoint-GUID: RJM63lXYpRqnc3ceNreK0CvH-McRHnA0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220126_103352_342366_4B0299D9 
X-CRM114-Status: GOOD (  18.69  )
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

V5:
- Change nvme_ops[] and nvme_admin_ops[] to a sparse array where the opcode is used as an index into the array.
- Various other nits.

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


