Return-Path: <SRS0=6u0/=ES=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE18C2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 08:23:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD28820825
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 08:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bsv/CK6f";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kd6V0k0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD28820825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SFZCXsyqZSI29TRMNylnAAwhGRiFwSMYA0HRkZ/0fCQ=; b=Bsv/CK6fkL2xZry45oJ0hjN8+k
	j2MxJNVaO5i9yFQKyiDPfTjc08PdO48dKrNLe2PZU2sLQ2ZiIfmJtWETY9clbGa3nKxAjC06v+2mL
	KPKOLD7eZn/6PsFOpHhf7HSaf6/sYnzPQJi6DO31H65LvkqlM23/5Z+ELqRDZNTfZkK7wcWuKDwei
	a4GJUJAlHhsOA/BW9KSYuCXAaFr8XW1ISONkKvDK1lyuCW0ymKZW6RDwCQ8K5EMX8XS2NlHx8bDWw
	Z8ZwADwkVFUeYH2kNMbskLg/O0nAl/UkBtWzzryXBELKwi06id1z+biwvPAOm72fXtR+XPqFUzRap
	facYOmpA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kd7sy-0004pt-PF; Thu, 12 Nov 2020 08:23:16 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kd7sv-0004ow-R1
 for linux-nvme@lists.infradead.org; Thu, 12 Nov 2020 08:23:15 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0AC83U3g193582; Thu, 12 Nov 2020 03:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=EJ8jWsKubf/i/O2OipMlFg3r4/MfebuU8bTeplatuPw=;
 b=Kd6V0k0wgx3jgKo+0cHd4f+2W738lg59GGp9FD79CNfXmyNt97LKKooZMufG19bjZ0Pb
 pbJtiA/2jZZLWI19i9XGTg8IO/UF7JQSadAhIdB3vXG6m23vE4uhX9jpWrPR74eZVfm/
 ynpL8RrSOmemgViC4qdluwh9zaqt649RyS8Vzh/53ot6vI3npzZBt4TdkRqP7EG9jCaV
 +WYXwJs0PoaKeHsnuUDpoLVyHpPcVFQtS2iUpXi5uUvgIBkjvFtWYcm3SrezclL++fCg
 kXzrSugH45NGm6jwZEAZK5J06iSsjJgXVz8iyscqWTVV8xHDW/i/cGPxECj2syvgZ8fJ OQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34rnpaj2n3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2020 03:23:07 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AC8DhI2023505;
 Thu, 12 Nov 2020 08:23:05 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma05fra.de.ibm.com with ESMTP id 34nk78asd0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2020 08:23:05 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 0AC8N3N954001922
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Nov 2020 08:23:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1006852052;
 Thu, 12 Nov 2020 08:23:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BB3035205F;
 Thu, 12 Nov 2020 08:23:02 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme-pci: drop min() from nr_io_queues assignment
Date: Thu, 12 Nov 2020 09:23:01 +0100
Message-Id: <20201112082302.82441-2-schnelle@linux.ibm.com>
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
 impostorscore=0 phishscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120045
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201112_032314_283249_40944550 
X-CRM114-Status: GOOD (  22.98  )
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

in nvme_setup_io_queues() the number of I/O queues is set to either 1 in
case of a quirky Apple device or to the min of nvme_max_io_queues() or
dev->nr_allocated_queues - 1.
This is unnecessarily complicated as dev->nr_allocated_queues is only
assigned once and is nvme_max_io_queues() + 1.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0578ff253c47..b56250b83bdf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2114,8 +2114,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
 		nr_io_queues = 1;
 	else
-		nr_io_queues = min(nvme_max_io_queues(dev),
-				   dev->nr_allocated_queues - 1);
+		nr_io_queues = dev->nr_allocated_queues - 1;
 
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
