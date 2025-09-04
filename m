Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FA8CA1015
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Sep 2025 20:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UDpuUr1sALfm0Ll8n8w95sKyRkbsu5Cc04GeRUss+iE=; b=Nj3aZegK1wEOsT1JpbV5iipmmV
	sKYrrjRwKKEJK/DGqgOQyoYLklU8J6a2KoTGahqifT88IFN/gABAULpHu/iRMsWpVi3usyB85SP6p
	AHtIMty6COO8GqkmIYbMq5lgI2bZggebyGZ8eKVtkSnpar6L9ceWqW5xYCjyOd5qDZTbvJIY53EBn
	SRzhxo/C6StJ8lGpwra0nYezkbRwmlwcq0jT2N7kDHTeevtb9HCptg7FRq+6lY4Lv5zXy3lFW6yBJ
	O4+cZnEsjDq1wghYZuN7RyAxoX/mtdQGryGUUnZj42P6oONDfGsDntE7Vy50AaFVQpTYuHslR5/eO
	FwOZEXKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuGby-0000000EGYx-0DBa;
	Thu, 04 Sep 2025 20:31:14 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuECR-0000000DPKo-2IVP
	for linux-nvme@lists.infradead.org;
	Thu, 04 Sep 2025 17:56:45 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849SJiS000698;
	Thu, 4 Sep 2025 17:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=UDpuUr1sALfm0Ll8n8w95sKyRkbs
	u5Cc04GeRUss+iE=; b=mcIi1ypakyK7gGhh1k3+7oqBF7cbx4ZvZD2n7Pk6tnl9
	gUWHQydnvSKcKlGk+IesU/RekBjVt5iCClXeEDqe9HzLSXOApd75fEPAER3ekXr8
	7JnwwLGjME12oblAvKyn697J+ZDzempec8VsBFfSQOt+U7PXukDdxTwD5pUfOYB8
	DdvUI4kunuvYR3QdbwNETZk5/P+1bI0F8EFa3piRFVGikBt0NrSvIeySZt0M0ArF
	p0uQczeKE+P0vI/rosm7rAUJw1/dM1KzAaHEcvSUO58KIv+aXfYAmvvACfd1Kp2g
	Nm8XXInLkzsBBatmBC8UXpH9zkM+4vGyNxOss82UBA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshf7htk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 17:56:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 584ElmMT019910;
	Thu, 4 Sep 2025 17:56:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vbmue043-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 17:56:37 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 584HuZXG44433854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 17:56:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64EBD2004F;
	Thu,  4 Sep 2025 17:56:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 588B220040;
	Thu,  4 Sep 2025 17:56:33 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.24.25])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Sep 2025 17:56:33 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.de, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCHv3 0/4] nvme-cli: enhance the visibility of multipath using show-topology command
Date: Thu,  4 Sep 2025 23:26:17 +0530
Message-ID: <20250904175631.1183723-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OGSkZ4f8upHkZ0bnZ3Z7Et5j5EfPQdHu
X-Authority-Analysis: v=2.4 cv=do3bC0g4 c=1 sm=1 tr=0 ts=68b9d2d6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=oV6sAyDJqP4IIcuWZn0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: OGSkZ4f8upHkZ0bnZ3Z7Et5j5EfPQdHu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDA0MCBTYWx0ZWRfX0LYRSW/zUV1V
 QJewoQSVfqT7QqrmZ/G1sE98jbAFY3fcB6N2a+KxSI57t+GwrXruIAjnua7Nswnc2dkJFd3x9GC
 02Rm1U/nbe7iQwtKq+63I3apNXxgrW/l0yzUpMUN8FC3l3Vk5qe/82QlOORL6HQEwBCc0OfKB2L
 EN94iHtvPe8VH3R8pfu0seivDG7B8BF1MFa2g/bT3d7lb8XnZF6wFT+rit0UAliyWnaCx+lYIpM
 e4GcX0l5PXIldV+DkpNbEleiR26rXmpuRyzn6d64WXXBmyCm8Z1E7DSr+QnOXlMF4MWIXYbURC5
 YCEXjIV2IqtLVAQUmLcuy0y7+jrOkMymh9XJhdZVYYn0+xM6ItGv2tXZFi0WRLpMTws7H4O4dQ0
 hjPP9zHq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020040
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250904_105644_058154_FDC267A3 
X-CRM114-Status: GOOD (  19.23  )
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

Hi,

There has been recent work to improve the visibility of NVMe multipath
configurations. The native NVMe multipath kernel driver supports three
I/O path selection policies: numa, round-robin, and queue-depth. However,
until now, users have had no insight into which path is selected by the
multipath logic for forwarding I/O.

To address this, an RFC was proposed [1] and has since been merged into
the Linux kernel as of v6.15. Following that, libnvme was extended to
discover multiple paths to a shared NVMe namespace [2]. This patchset
builds on those efforts to improve userspace observability of multipath
configurations via nvme-cli.

This patchset contains four patches:
The first patch in the series fixes a <device> filter option using which
we could be able to filter the output of nvme show-topology command.

The second patch in the series enhances the nvme show-topology command to
display multipath configuration, including all discovered paths to a
namespace, along with details such as ANA state, NUMA nodes, and queue
depth. The show-topology "--ranking" option is extended with a new sub-
option: multipath.

The third patch in the series adds common table APIs for printing nvme cli
command output in tabular format.  With these APIs, developers no longer
need to pre-calculate column or row widths. The output is consistently
aligned and easy to read.

The fourth patch adds support for printing show-topology in tabular form
leveraging the introduced table APIs to produce well-aligned, easy-to-read
output.

As usual, any feedback/sugegstion is most welcome!

Thanks!

Changes from v2:
  - For iopolicy=numa, print NUMA nodes and exclude queue-depth.
    Similarly, for iopolicy=queue-depth, print queue-depth but exclude
    NUMA nodes. And for iopolicy=round-robin, exclude printing
    both NUMA nodes and queue-depth. (Hannes Reinecke, Daniel
    Wagner)
Link to v2: https://lore.kernel.org/all/20250812125614.164445-1-nilay@linux.ibm.com/

Changes from v1:
  - Added the third patch in the series that implements the common table
    APIs for printing nvme cli command output in tabular format
    (Daniel Wagner)
  - Added the fourth patch in the series which adds the support for
    printing show-topology in tabular form (Daniel Wagner)
Link to v1: https://lore.kernel.org/all/20250704135001.292763-1-nilay@linux.ibm.com/

Nilay Shroff (4):
  nvme: support <device> option in show-topology command
  nvme: extend show-topology command to add support for multipath
  nvme: add common APIs for printing tabular format output
  nvme: add support for printing show-topology in tabular form

 nvme-print-binary.c |   1 +
 nvme-print-json.c   |  36 ++++-
 nvme-print-stdout.c | 312 +++++++++++++++++++++++++++++++++++++++++-
 nvme-print.c        |   9 +-
 nvme-print.h        |   3 +
 nvme.c              |  29 +++-
 nvme.h              |   2 +
 util/meson.build    |   3 +-
 util/table.c        | 320 ++++++++++++++++++++++++++++++++++++++++++++
 util/table.h        | 149 +++++++++++++++++++++
 10 files changed, 849 insertions(+), 15 deletions(-)
 create mode 100644 util/table.c
 create mode 100644 util/table.h

-- 
2.51.0


