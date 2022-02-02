Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91591C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 00:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fBGpAoNVSEYfHKNNVN3Mqt8nsH3rQws3FsbkREedLyE=; b=XbokIJyCYuAdr9h4DJwIB6VDFI
	O5M/CTS3Nw3wc4B9kSgWHv+loVmOIDVMkZZv1r72KNF5OI7iFJ4b++2hhfz1dNgmclzaeVnLJO1R6
	O1h+vaZ/ZxOla4e8+prLvsRA3IaUWvpWxEYBkBSzkRQauIL9pYeE24fHmcFNGJwNWQvvI9HI8VmPY
	0g+PShlNkRUCLXyQsMdnVworqT3dOhBMPH4trpWkG9IQ1IzkJwHW6nggV68sHaw/7H3KbGnKhWEG9
	afJv1JLuKwWPaehjmcZTOhfdxlNtLEBXS0ZvQLioHUd68NUesi/Xifz1KuGjAZ1nQTfSPXh9KKH5/
	p22/1pSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nF3s4-00DuVN-Fk; Wed, 02 Feb 2022 00:51:40 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nF3s1-00DuUZ-8V
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 00:51:38 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21207SMQ022133; 
 Wed, 2 Feb 2022 00:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=fBGpAoNVSEYfHKNNVN3Mqt8nsH3rQws3FsbkREedLyE=;
 b=UchXRtalSbIrvOvuQnWHVGWz6SuhT9Oblj2Qfxp9vDp7ZVmshlCnP4RM7JruixHOf2HK
 AgRCvyg/B0CgLQlb8DW+7pk++PT8XKbyU9t18kS0JIXH2cge8nIVVlv/JoZCHwFjjuUh
 DWBqoEBppwhRRwgw7Yd3faHxb8eKa/6I00z7LmOy5d4uROOHJEAPv846l1kkpFzZIgxy
 vAfXdGXEBQyoFVqOJNYijKLxwlIfmKExxdmMjLiwt8ZnDIyP3J+n+qIm9AbsKUs+NIEq
 1Jp11coJOlOC8EM8ZF2Mh4IeRAdpjgLWhMxWk5dXz+2SqFr/YLVrFb3lGVz1siMU2Uvn ZA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2m364-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Feb 2022 00:51:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2120Ze4a189030;
 Wed, 2 Feb 2022 00:51:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3030.oracle.com with ESMTP id 3dvtq1fryj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Feb 2022 00:51:21 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2120pKxn039406;
 Wed, 2 Feb 2022 00:51:21 GMT
Received: from dhcp-10-65-137-115.vpn.oracle.com
 (dhcp-10-65-137-115.vpn.oracle.com [10.65.137.115])
 by userp3030.oracle.com with ESMTP id 3dvtq1fry9-1;
 Wed, 02 Feb 2022 00:51:20 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [PATCH V6 0/1] nvme: Add verbose error logging
Date: Tue,  1 Feb 2022 16:50:49 -0800
Message-Id: <20220202005050.69289-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2gR6-pmyb5TsHqhXnl3Wr62zTqSe5so8
X-Proofpoint-ORIG-GUID: 2gR6-pmyb5TsHqhXnl3Wr62zTqSe5so8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_165137_331040_FB5B22D7 
X-CRM114-Status: GOOD (  19.09  )
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

V6:
- Create helpers that are stubbed out if CONFIG_NVME_VERBOSE_ERRORS is not set.
- Couple more nits.

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
 drivers/nvme/host/core.c   |  41 ++++++++
 drivers/nvme/host/errors.c | 206 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h   |  20 ++++
 include/linux/nvme.h       |   1 +
 6 files changed, 277 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/host/errors.c

-- 
2.27.0


