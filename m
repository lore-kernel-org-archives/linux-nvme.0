Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992A5C9EC6B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jan 2026 11:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2vsIQrzC9Sn7jTIhDsf2FerTcOGdfIsq2IToDrjXJZM=; b=BnJOBKNB1AYwvgBxm6a830SvR/
	ssICHczBcsvPt+ETi95U5h0FK6gQ2Cu3a9cAuvZf+JKn71VEh/DUGQ5w1SeYLI8zdej1esGT3CTWL
	Q40iQLrMl62zxyP5AlWmW5QzW8LiOoDyW0A44t51KsE0XmYnc3SQMQwe2tzMpicjRT+wkFeefWUVL
	q6fJ5kdTMxfB4ouCm0rKYMpBSylQu17qHfDOtF3nEwhCb9bX2CRZfXySkj7/00/ntnYto8yx4N86/
	RBPZifZMJwuVya5ePPRJC9ueiDjrayC5O4xJIot9Mz0kxQwOAhK0w/73uaFPrN9gVhXwEqJ9hcxBu
	f5epufgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfFve-00000005E5f-2JAm;
	Mon, 12 Jan 2026 11:17:46 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfFvb-00000005E4e-30wq
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jan 2026 11:17:44 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60BNgh77019131;
	Mon, 12 Jan 2026 11:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=2vsIQrzC9Sn7jTIhDsf2FerTcOGd
	fIsq2IToDrjXJZM=; b=MrKTYCJz77C4t3y2MSoazw+tU2qUpNkvk+3TfK6cpj7g
	NOkvMxo59hP9UpfzbghpSx9n/FYOb9BF3ubC3oVbvELG5FMTG5SFNKdF/j2ZkD18
	1f3ZYFZ4ClcLe2WetVUKjOvHVUc57CoLB5ufCkdk8unEDokzu0Su4QX8mE3C2975
	r1nHJLDJCWIVcJ0EDrn7Ors2GD3PCP4H6HeMbPBbocsIPSRZi8T8mt42BUhIfDKQ
	2ZtBrGYeqiA58KMYwVcZ+WaDtI/BtNaIN/h8DVmaRCDP8YojdXRY0CF1+Sx/BDov
	zK/WPn/OkQiK8Me+FyayoAfA6UDnTQmX0Spq5npiRQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6dxhrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 11:17:38 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60CBGTjI003785;
	Mon, 12 Jan 2026 11:17:38 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6dxhrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 11:17:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60CAdq1h030153;
	Mon, 12 Jan 2026 11:17:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3ajdcay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 11:17:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60CBHZks28967454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 11:17:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 731152004B;
	Mon, 12 Jan 2026 11:17:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00A7420040;
	Mon, 12 Jan 2026 11:17:34 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.87.146.254])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Jan 2026 11:17:33 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: wagi@kernel.org, martinus.gpy@gmail.com
Subject: [PATCH 0/2] nvme-cli: limit printing iopolicy in subsystem header
Date: Mon, 12 Jan 2026 16:45:59 +0530
Message-ID: <20260112111731.1631091-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i2_uDjiue9SG41A9ZIayrRFSRyP0BMRU
X-Authority-Analysis: v=2.4 cv=LLxrgZW9 c=1 sm=1 tr=0 ts=6964d852 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vFXeijo3DdrOCUIoSicA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA5MCBTYWx0ZWRfX7MT67EMkYcBI
 egXxDuPKamfaHN+Yxh7BqKGIHimg4a+/0gbL105UnaRry7R2T/LdpZJ4KF7BfcDO/sXtxw1U7kC
 F6cBb7pUqkyD6gPym2efU8+Ee8yAcvEjlqE5ziJc/a29hSC0nLE9C0obaObH51nL1VF1rP8tQ5X
 Fu+Z+YLNZao/FWtVHuLcdiS46W+0m7wLxcGUgtmbtA+IeqSXwDrmtxWxCo8NTVQNitNik+XkkzZ
 B4cjB5xvmszKqBn8VBUfPm5UyDo5gRTeaLCzbSehNCgcHCggBcRNflTf0E39wBerfyFMF1ex9rt
 8UTKOkUdFvPFTEx5rwtF23euwNmxZY14eQoiDN3dk323uhzDY2OjHqF7vszKWzBBE0X+kZkgBL+
 eV/xDDMNYoCCoOF9oBxh0O94cSzxdGPfnhJlpX+GUj3//+ACeqLP0CH1J7t3wsxEIhh6BrTA1O0
 7dOX8rVygURqZr62ecQ==
X-Proofpoint-ORIG-GUID: 1J_FTU3WHveWedHSpstPcBcgckvQ91AK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601120090
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260112_031743_888308_7D146DC4 
X-CRM114-Status: GOOD (  18.30  )
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

The nvme-cli currently prints the iopolicy value in the subsystem header
for both the show-topology and list-subsys commands. This behavior was
introduced by commit d0b4c6cf0006 (“nvme: extend show-topology command
to add support for multipath”).

Printing the iopolicy value in the output of the show-topology command is
intentional and useful. The command also displays additional columns such
as Nodes or queue-depth, depending on the configured I/O policy. Including
the iopolicy in the header makes it easier to correlate the output with the
active policy and understand the resulting I/O path behavior.

However, the iopolicy value is not particularly relevant for the list-subsys
command. It currently appears there for non-verbose output because both
show-topology and list-subsys commands share a common helper function that
prints the subsystem header. As a result, the iopolicy field unintentionally
leaked into the list-subsys output.

In addition, while the iopolicy field is shown in the regular text output
of show-topology, it was missing from the JSON output format when show-topology
is executed in non-verbose mode. This patchset addresses both of these issues
and consists of two patches:
First patch avoids printing the iopolicy field in the list-subsys output
unless the command is invoked with the verbose flag.
Second patch adds the iopolicy field to the JSON output of the show-topology
command.

Thanks!

Nilay Shroff (2):
  nvme: avoid printing iopolicy in list-subsys output
  nvme: add iopolicy field in JSON output

 nvme-print-json.c   |  4 ++--
 nvme-print-stdout.c | 14 ++++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.52.0


