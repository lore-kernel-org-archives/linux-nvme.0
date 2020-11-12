Return-Path: <SRS0=6u0/=ES=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E9FC56201
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 08:23:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE44020870
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 08:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fdHwI2S/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j6apinlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE44020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MfN24vVLTGZhquims2XyU9kyYUBSz5jPiX01ClyNp+8=; b=fdHwI2S/I6U1PK7fInrZPOeDRc
	X+8h3ZmoPw7CWI48apJonN/9XPUhHISibgeq48FGtkYRyFwgkIsyNn3B1iS6XVX55S66ZY0VfMhdg
	199R38fiyk79N/JU3sALN+kc85wyiWQyTt2YAdYWeGh60cQ4XWXBVIzkD/sjvhGL/iNDND8QpIhwK
	fjRpI/POn3y7o7l/F7W/k73jyR9mZ8xbyMubhsgGUivU9y4l8TN3O/Zq6U5jxsvq7e/OBj7G0kYlG
	C5W7km8HYDL5t98LonakLf9Oq1VgDA9u7sg2kV22IbTY+Nbu+3QtVIbWOe4mu4Eh/vISwoHXSv4uQ
	CC2lSI0g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kd7tP-0004ub-Hz; Thu, 12 Nov 2020 08:23:43 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kd7tL-0004tX-FY
 for linux-nvme@lists.infradead.org; Thu, 12 Nov 2020 08:23:40 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0AC8293x177316; Thu, 12 Nov 2020 03:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject : date : message-id; s=pp1;
 bh=BOefgtfDxCCP0iW0ZFVr08Iqc8h0WhLGvV4gIHw/bnE=;
 b=j6apinlh6HdiB8g7dXA88jZXc0wYwu7ttKzgle62yd5sR5eke5MFB1H+6HuW/Z0zyG90
 1kS1yvEyrAsIb/sRhlxF/NZgyf9KjMBSoh9ihcvZvqDxa7xQdLGRx46NLe6B+5gw0i9t
 G4eSi3Ipk7MEwr6Ppw6QVSbFpQp0/d7ePOoIsYkdyhA/BG+fc84wScp93W5MKpY8lm8g
 5DjO4ZMD4zJUOK+RaTaBuoYydlbpPl0EwlgtNvxF2pZQAQqnOJrJOVE1Qey+SiPJlcKy
 HjEZhrKbE5g0iHYowRQ3Smy/MRYVQjZStIawEgOO8AtnYaujKkgZ3yaOyF8azKxFqpN9 QA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34rg32dpyp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2020 03:23:07 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AC8M0Ea006062;
 Thu, 12 Nov 2020 08:23:05 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma02fra.de.ibm.com with ESMTP id 34nk782rxs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2020 08:23:05 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 0AC8N2oo51380632
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Nov 2020 08:23:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B83735204F;
 Thu, 12 Nov 2020 08:23:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6D91C52051;
 Thu, 12 Nov 2020 08:23:02 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvme-pic: improve max I/O queue handling
Date: Thu, 12 Nov 2020 09:23:00 +0100
Message-Id: <20201112082302.82441-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-12_02:2020-11-10,
 2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 suspectscore=1 mlxscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120045
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201112_032339_665864_73A8A3D7 
X-CRM114-Status: GOOD (  21.14  )
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

Hi,

while searching for a bug around zPCI + NVMe IRQ handling on a distro
kernel, I got confused around handling of the maximum number
of I/O queues in the NVMe driver.
I think I groked it in the end but would like to propose the following
improvements, that said I'm quite new to this code.
I tested both patches on s390x (with a debug config) and x86_64 so
with both data center and consumer NVMes.
For the second patch, since I don't own a device with the quirk, I tried
always returning 1 from nvme_max_io_queues() and confirmed that on my
Evo 970 Pro this resulted in about half the performance in a fio test
but did not otherwise break things. I couldn't find a reason why
allocating only the I/O queues we actually use would be problematic in
the code either but I might have missed something of course.

Best regards,
Niklas Schnelle

Niklas Schnelle (2):
  nvme-pci: drop min() from nr_io_queues assignment
  nvme-pci: don't allocate unused I/O queues

 drivers/nvme/host/pci.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
