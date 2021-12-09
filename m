Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07ECFC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Dec 2021 17:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1MafWULVnkuEdgdJqFn9THaMlymuUmOZ+1r0JUoqBd8=; b=dv27rshnz+ZLdrhrUQ1SiRybJ6
	1MnyOQ30Okd0GxF8W3XLmcHGp/shIoTX9WB8kRWOxC2TRZbOBFbdcNMMBh6VRtSaLJXbxlwICaK/0
	JMmvjS15QrEQJZ+GiL1XlZnTJM8cm+C78oqLym4LIljeoCM+MmkUvHW/72Cs2Nwgb2sJt8iiYqR13
	s28TTqh0lAZfSglPriQrI4ECoEnkPlwN1wkg6/tMZp7e8OohUP5xEMK192ePs+ZN/55KC/qdND8kU
	9+7UjjEpLHszzHyJJu2bxg/F/uji7QPw8CzK4blXVntBslyST/2m6ptCKtx7f2lxGBy3cHFpqcYBx
	cDk8B6Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mvNI2-00Gz3c-Hh; Thu, 09 Dec 2021 17:33:06 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvNHu-00Gz17-7q
 for linux-nvme@lists.infradead.org; Thu, 09 Dec 2021 17:32:59 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9Gduhl006476; 
 Thu, 9 Dec 2021 17:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=1MafWULVnkuEdgdJqFn9THaMlymuUmOZ+1r0JUoqBd8=;
 b=OEDqRmbNopu/4Hew0EMQ28jj5tKXo8UTiA7n3IkCW+H6g0tZ1C3i+keaaJVNkwRq/rrU
 f0z5iRXK+YFkzmPcWLj3zxug8dN5GNPA7are6icPykRtdRveyodDFCZbsszQOkiVAxnA
 l1rI7SbimrB+m89WtQTaJySaiM4uhXhS78IPmQRT8IFaZui4BlJJacbJlNc3/SrOq+rK
 bYMqs1yT8a0Z2Y9X/8kKhlmYphviasqWZGNeb+JQvQjPiXcV9x2Jy/4hYZKJfKZj2G7N
 awiJVFY7mx/yfMzfmuc4t7hEHaNRJkq6tLh9i2k8wm0lPUK3VQalrO5TBlzMNGFj6nHo zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ctua7kn8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Dec 2021 17:32:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B9HBHUU136576;
 Thu, 9 Dec 2021 17:32:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3030.oracle.com with ESMTP id 3cqwf2ghfk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Dec 2021 17:32:45 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1B9HWibb019763;
 Thu, 9 Dec 2021 17:32:44 GMT
Received: from dhcp-10-159-149-161.vpn.oracle.com
 (dhcp-10-159-149-161.vpn.oracle.com [10.159.149.161])
 by userp3030.oracle.com with ESMTP id 3cqwf2gheg-1;
 Thu, 09 Dec 2021 17:32:44 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [PATCH 0/1] nvme: Add verbose error logging
Date: Thu,  9 Dec 2021 09:32:12 -0800
Message-Id: <20211209173213.14249-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vhtNm-hOtkfQwybfL2Xv6LKZwryD3LRT
X-Proofpoint-GUID: vhtNm-hOtkfQwybfL2Xv6LKZwryD3LRT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211209_093258_326267_CDF85E4D 
X-CRM114-Status: GOOD (  13.55  )
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


This patch improves logging for NVMe errors.  Currently, we only get a
a vague idea as to why commands fail since only the block layer status
is captured on error. This patch allows us to see why a command was failed
by the controller. This is very useful when debugging problems in the field.

An example of an imnproved logged error:

[ 4652.812867] nvme0n1: Read @ LBA 1536, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR 

Alan Adamson (1):
  nvme: Add verbose error logging

 drivers/nvme/host/Kconfig  |   8 ++
 drivers/nvme/host/Makefile |   1 +
 drivers/nvme/host/core.c   |   4 +
 drivers/nvme/host/errors.c | 176 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h   |   6 ++
 include/linux/nvme.h       |   1 +
 6 files changed, 196 insertions(+)
 create mode 100644 drivers/nvme/host/errors.c

-- 
2.27.0


