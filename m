Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A02109B46D
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2026 14:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tPQb9Bl6vwC4ovKfBiZxYbnOCh+DWR8ZFo9BSEBbTrY=; b=L8B2dE8JkB9arl6pTEoY+Ibrsg
	FCFl+tGqCZa3WN4FdzFsZIy/jiWB6yN5cAMuX+KTUni4/xFZ7RXRnPSQqONlkI8dD7kz7BHS9+s52
	pcM6GfMn6k1YD6l0iQvuZxEhpt8lboWEZQ6rz5eHiRYhHFs8+ZIAGHGYLdeXBan08HYJZqGqDtzmA
	FnKp8CB5lDIgxChn3QvxLFx/gfD7DQfCM1qM99YnHM9gu4/ktoQKhaQa+vRHxGNhVqfB2TO7WQR8W
	TmBEVFCLgAomtDjxky8X+OWbI3cJopiJ2rQqdUrzH2vtW0pHcwd9EEC8mDc8N5iIBrEXApIppxh44
	cl26a+jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7ZpT-0000000D39O-2eyo;
	Tue, 31 Mar 2026 14:12:27 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7ZpQ-0000000D388-3fow
	for linux-nvme@lists.infradead.org;
	Tue, 31 Mar 2026 14:12:26 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V6q3BB3948870;
	Tue, 31 Mar 2026 14:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=tPQb9Bl6vwC4ovKfBiZxYbnOCh+DWR8ZFo9BSEBbT
	rY=; b=SsJQJulJDRrprN4qYFFf2Nj2eGDnhDhDNk/FbcxPc51HUHVGblU8QKWA/
	QXgYpWK8Ga3jBBmaP2hP69QSQ3+M9YU8gxvQV2WWl9I9tQ1qfLqvjhG5nXCh7ZrD
	7EIIuElaksyMU45xP1FdHUH8OQhAWpLj1ZqR5YkDb7qWv2r7/pKWPzh7gTz4pp8c
	4Ylbn11RocnXHNJcYFoDLwz8Mjb1dau2IFoMnM6CpSaYcoHjjFh8Zd76sw9EFsBf
	C6nPaNqCFwm9G/FQzfJhsBs3k+plCwmmAWafok7cUWEMUyvDHVUJ1KzuDigO4TAk
	X0j9ixFjnA57cCJxzaED1dBwAsgmQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcb858-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 14:12:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62VCcIZm031007;
	Tue, 31 Mar 2026 14:12:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjs87b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 14:12:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62VECIca39846234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 14:12:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 303F02004F;
	Tue, 31 Mar 2026 14:12:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEADC2004B;
	Tue, 31 Mar 2026 14:12:16 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.210.45])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 14:12:16 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, gjoyce@linux.ibm.com
Subject: [PATCH 0/2] extend nvme show-topology tabular output
Date: Tue, 31 Mar 2026 19:42:07 +0530
Message-ID: <20260331141215.3098243-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cbd646 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=zI66N97JznHEBc-yAfMA:9
X-Proofpoint-GUID: 7OU4elSX1ZIZVjkDt8i_lXkPuGmqDR0Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDEzNCBTYWx0ZWRfX8TVN4j7S+dXM
 uHrFA8eTLecFYWXw2tROUgL7WX5oKYV1SnMxHSm7RU+iMwrj3729w+A7Uej9hwALUSloqzqAhNV
 rhO4OAf10PFdBIOHKpg+ir9a/6G+vNEyUJdLFgCa9THWP/RJq8HO8MK4mHeDtYA73R1NEvRrtnl
 wY1Kq1am6Hy6QAzclV2P8R7KPzOthpMHnwUU5Azt4KK5A4Kva4o/phS5GClQRIvRXeaxPD7j3o0
 HMkp9GxEz1s73BLldd+LuBOsaLS4t/qlDh3q1lyNblnuZuugSeiRYAp/HHZpby0vR8V5OX8JuvN
 wjI0pwChw5rn86acxGUbAgxg0zZ+7oOZ6LG9NnMI+ZlFN4YazQQ1HTxFCaw/v/V0hHqjbOINn56
 NbGPOfdHmwJLXaUVSeO45S0JNnmniWgsMxXE37TmFFz6ONIuvbScib44Ng0cS0BGTd8wK/ErfWY
 lSyiPabLLXwqZqv1D+A==
X-Proofpoint-ORIG-GUID: 7OU4elSX1ZIZVjkDt8i_lXkPuGmqDR0Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310134
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_071225_035427_29603DAD 
X-CRM114-Status: GOOD (  13.30  )
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

This patchset extends the tabular output of the "nvme show-topology"
command.

Currently, the tabular output does not display controller information
if a controller has no associated namespaces or paths. However, it is
valid for a controller within a subsystem to have no namespaces or
paths attached.

In such cases, it is still useful to display controller information
such as the controller name, transport type, address, and state,
while leaving namespace and path-related fields (e.g., nsid, nshead,
anastate, nspath) empty.

This patchset is divided into two patches, first patch extends the output
for non-multipath subsystems while the second patch extends the output for 
multipath subsystems.

As usual, feedback/comments/suggestions are welcome!

Thanks!

Nilay Shroff (2):
  nvme-cli: extend show-topology tabular output for non-multipath subsys
  nvme-cli: extend show-topology tabular output for multipath subsys

 nvme-print-stdout.c | 256 +++++++++++++++++++++++++++++++-------------
 1 file changed, 181 insertions(+), 75 deletions(-)

-- 
2.53.0


