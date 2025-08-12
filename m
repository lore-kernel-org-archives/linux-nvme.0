Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A22CA0EC4
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Aug 2025 17:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CFYBI4gRrJO5ERy8tHInAfqFjHDCwCATNnMQm/kpzvU=; b=Y6lUA0ouJbVVOvG2tVLXF6cqDs
	FOP4xIOoYkVlY9p46ZsqOEQnCw5iYYxU3UII3gpniaUNvtBzgN7cWwaZK/SJ/uo5DJl/W4lS3Girb
	JCz9pFjJmERz/waI1ZNaMXuPSyHgn96KJ8WLzXBjC7QwZ3M8d72UocqTh0rwyUy+eatfdFzQmgA7j
	J+DFyOj9BqLjG7waUz54R65EMo90LON8p4yTlSujSPqDGzK7JYfYjtRQlD4H43AYl+lw2BXL2adBf
	gFUztDjx7DfR+dAQbs1YDpV7PNqkGrdys2gZJfJnSMHYXjyP549jZP1NZLDn/H5zIYFkx0+Y50c6/
	cAXyBBqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulsqO-0000000BZpN-2OJk;
	Tue, 12 Aug 2025 17:31:28 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uloYD-0000000AqkO-2YFz
	for linux-nvme@lists.infradead.org;
	Tue, 12 Aug 2025 12:56:27 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAVujw015275;
	Tue, 12 Aug 2025 12:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=CFYBI4gRrJO5ERy8tHInAfqFjHDC
	wCATNnMQm/kpzvU=; b=GhmYBvIjjxkVgklnnGzhe9Xl6ghkxV1QD4DX58cZ3YKa
	G11J4LCK2tz8tx8z/tTfl/eOjq8+y6A4ASWk2qlqeqDyFc+Y8M6vyiQtnHEH0s9E
	QqQSBjcZ+Kd4I5UpBOIUbnc8VNPosYPEZcvbIKad313UnsX6qh0zXslWn8qtqBFb
	gVS7FS4k/stbuXT06yz54i7MKvdop/Anr8Evk3hU4gB62JDIpeBK00LvOkROSOjZ
	DXcP9B7ieRWBxTU+cCLcYUBlm10mBt7T+ThHiSslfuEnGyMxj5V1KWG8qwO6JviA
	oCf6VuI80Li8mCUzurNoinLXBHb8kG2YmCj3PxcQ5w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwud6h30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 12:56:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57C9vaQi020795;
	Tue, 12 Aug 2025 12:56:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ehnptebv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 12:56:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57CCuI8x54133106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 12:56:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB9A02004B;
	Tue, 12 Aug 2025 12:56:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 207E520040;
	Tue, 12 Aug 2025 12:56:16 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.161.148])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Aug 2025 12:56:15 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.de, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCHv2 0/4] nvme-cli: enhance the visibility of multipath using show-topology command
Date: Tue, 12 Aug 2025 18:26:01 +0530
Message-ID: <20250812125614.164445-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEyMyBTYWx0ZWRfX17hZvD0nBHLc
 us5jdoIplr0M6NpO6OaT+IOlLFvecYY1R+h0lH7pIqDXRAx77yjIp9ZuVCPZylDp9rMLZhfMQqV
 ppk80NeHE1kHcNUt1HunpH89UHFIVKeXOl1mXZkZdgDZkCZf1nRP+qEt6zDoci6qJmEXQpLaBpv
 i3Ggoi3Pf20txuMcHRus1mtCaUPBqHUAnr3255rZ2kbJEAbIy84rBHqMGQKJ0hVihnehqprmNQr
 pvOdtyudi/v9ltlzfyfRbevOzY+6gwVOIpyBlElD41TeLdpl3Gtp7680jNuJzumt4n6+0hh+qWU
 mdGfVp1F+Gi1wMK+F1soNJxbF1dwAj/PFtKmQmeuwEVzd4BD568Zp0MvjSkfBrhxjCezf8HsZ5w
 XeREVWVhvRPzxRj2/FPvoZaNYkPdtKR7VaLFxj7oGYQ8ytRu9OpJQAUv70mtVbJN+N2rpH5v
X-Authority-Analysis: v=2.4 cv=d/31yQjE c=1 sm=1 tr=0 ts=689b39f6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=FEwVTYbigu0WRK3eX-YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0QqIXsHwgws_FZWA0vz51ME-RsyTLBoJ
X-Proofpoint-ORIG-GUID: 0QqIXsHwgws_FZWA0vz51ME-RsyTLBoJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508120123
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_055625_649945_28D08A77 
X-CRM114-Status: GOOD (  19.16  )
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
 nvme-print-json.c   |  25 +++-
 nvme-print-stdout.c | 233 ++++++++++++++++++++++++++++++++++++-
 nvme-print.c        |   9 +-
 nvme-print.h        |   3 +
 nvme.c              |  29 ++++-
 nvme.h              |   2 +
 util/meson.build    |   3 +-
 util/table.c        | 278 ++++++++++++++++++++++++++++++++++++++++++++
 util/table.h        | 117 +++++++++++++++++++
 10 files changed, 685 insertions(+), 15 deletions(-)
 create mode 100644 util/table.c
 create mode 100644 util/table.h

-- 
2.50.1


