Return-Path: <SRS0=6u0/=ES=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F738C56202
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 08:23:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 631E720825
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 08:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BBW6TvMw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tfC8GY6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631E720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kq40XUXDxPvBzsCoMlFJwKuM0jCUo9lkq2p9UUZ8FfA=; b=BBW6TvMw+67tEp5h6acJaBcco7
	c4Xjkp2U6N4XPO5p85QEJbDBXQV9AEoQ5qzOGaA6dv9lTKt/yso5bpHEGZ7v3ZOqMcsJWmcXa0cih
	1lwgIYF3OMg/MfmwJVNyZ3BDl6FQkIRcH6WXptZQ8CUpNgSM+oG9L/4u7alX3DCck5yv9ktSgtN6v
	f7zGVbbgpETav2cL5kbLykRSbY0mKgAbTeWXwZwdlo44ZWx2pimBN6O1DAFF+RxKFYBQp4VAsKaY0
	/7iiQHgCP7inNvsQVACHduTYYzCtF3lk7yAVwmdmpgVF4ul66/wo0Nqh072hstIMj97T/8z7PeUSM
	LbZwi1wg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kd7t1-0004qH-5a; Thu, 12 Nov 2020 08:23:19 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kd7sv-0004ov-Rj
 for linux-nvme@lists.infradead.org; Thu, 12 Nov 2020 08:23:15 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0AC83U3p193617; Thu, 12 Nov 2020 03:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=TDhSzs5RWDN7s0fOYRUkavz2KWlMhWKoqBn2ndAIeOY=;
 b=tfC8GY6hcxxeRcOaKN9ppbZtMz1pzx+Fn++7dmLFMPsOeH0WKxQn0sJwUWeek2MFvR3Z
 ywghY4EN9JDo78g23818GlWF49y7vE5/rvZvpfNI7mCzxUmwJ9NsaYkIq5vp5uTRDhav
 PRTnPF+pxDEEV69vND1wydbI4whquuOzhP0eXABlOZO8278JKYXegRPj/MNpwqzsnjab
 34IrvoYwTfPM4SP0NfKwMBLD9wwgfxcMTxsBtTla0DEPHDiIzEGaRd7C+ZZUHv5ANxWB
 GPxuF0N5aWuECA2+fGtLXHaT5qJ4Rf6IX9Y6EtPwfNYXsPit2qgDYT7oywnWW4VohNQN /w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34rnpaj2n6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2020 03:23:07 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AC8Mr0j000510;
 Thu, 12 Nov 2020 08:23:05 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma03ams.nl.ibm.com with ESMTP id 34nk78nern-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2020 08:23:05 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 0AC8N3e354001926
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Nov 2020 08:23:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5447A5204F;
 Thu, 12 Nov 2020 08:23:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 14C8552054;
 Thu, 12 Nov 2020 08:23:03 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme-pci: don't allocate unused I/O queues
Date: Thu, 12 Nov 2020 09:23:02 +0100
Message-Id: <20201112082302.82441-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201112082302.82441-1-schnelle@linux.ibm.com>
References: <20201112082302.82441-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-12_02:2020-11-10,
 2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 suspectscore=1 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120045
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201112_032314_286477_E509644E 
X-CRM114-Status: GOOD (  23.75  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

currently the NVME_QUIRK_SHARED_TAGS quirk for Apple devices is handled
during the assignment of nr_io_queues in nvme_setup_io_queues().
This however means that for these devices nvme_max_io_queues() will
actually not return the supported maximum which is confusing and
unexpected and also means that in nvme_probe() we are allocating
for I/O queues that will never be used.
Fix this by moving the quirk handling into nvme_max_io_queues().

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b56250b83bdf..0f8cea5b30eb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2089,6 +2089,12 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
 
 static unsigned int nvme_max_io_queues(struct nvme_dev *dev)
 {
+	/*
+	 * If tags are shared with admin queue (Apple bug), then
+	 * make sure we only use one IO queue.
+	 */
+	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
+		return 1;
 	return num_possible_cpus() + dev->nr_write_queues + dev->nr_poll_queues;
 }
 
@@ -2107,15 +2113,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	dev->nr_write_queues = write_queues;
 	dev->nr_poll_queues = poll_queues;
 
-	/*
-	 * If tags are shared with admin queue (Apple bug), then
-	 * make sure we only use one IO queue.
-	 */
-	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
-		nr_io_queues = 1;
-	else
-		nr_io_queues = dev->nr_allocated_queues - 1;
-
+	nr_io_queues = dev->nr_allocated_queues - 1;
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
 		return result;
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
