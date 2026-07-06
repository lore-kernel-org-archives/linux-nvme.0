Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36D9C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 14:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vaatYQhQiYTzBO2/iUmWVXdWlKHkVWN0eT8ZSjsZSnQ=; b=L1PWh/NtEJ66H92SqTpPsC4NSr
	z+J5RxETbqcUwlmGBqWGphOD7SnqrARfMZ2X7RDQGbPzVU9Rrkr0sII5FEPBcCS5ZTxcgfemQYtzI
	kVBaPp7S181NsnpbbfqNq98r/myr9optmN3dLvT9fSpn3pi6goM53ruYF8Ho8oxwuIAcmz2aywsX9
	xupcvDthyXx9qMY9Vvi3nArFAfPzjyYN6Z37wSSHvABixGTy/c3E7JX4q2UNm9wp2O3ztHO2lnqyJ
	sXJsCr2G2M/MZ6dD8kXpTgb7F4KoGMa2OVcIfr7tsjBsA2FNXwlapfYGm5JegA7GJrGL+VeRLykdm
	m2wnXy7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7h-0000000Ciac-1Ime;
	Mon, 06 Jul 2026 14:16:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7e-0000000CiW0-3kHt
	for linux-nvme@bombadil.infradead.org;
	Mon, 06 Jul 2026 14:16:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=vaatYQhQiYTzBO2/iUmWVXdWlKHkVWN0eT8ZSjsZSnQ=; b=QAo7SckUINTB/QzHoPF6d1M60i
	CIHV+Y8K8/FMO3WbmdsjUsFHIl4NuaMmLwYRvXkRo0cN93fbIgzqckO1bRUThap+rIWMml9+SrWQe
	d7giiNLmRIGaxYIUSIXaMOoEnsFn5ShMY78wJA/FdO601cbfAcEMLQbTQ2xjctI5SKs8LOdiuXo5J
	yN2RyaVkvcXjRG9RBOZqWjtsDPiAsOWauX1czGoFIJIst1ucX4I7vtGRdVgAo6O04XArvsxnePjEn
	xOIEizCXaH6VqxXLLGTROIDO+crLCI25Nj1oI0v6lV7PIJ3EhCZA7tr7arP4YFO+P76FDscLkFMEb
	T1NHuK2w==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wgk7b-00000006dpU-2zBq
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 14:16:33 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIjgO4095230;
	Mon, 6 Jul 2026 14:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vaatYQhQiYTzBO2/i
	UmWVXdWlKHkVWN0eT8ZSjsZSnQ=; b=rTF5LfPisTmWFE10Sud9WT9QgicZxHZIi
	LaCpPJteiz1A1CveovJuEGu6uWdQcOwWNAGoaVWMquYd6UdS5WcpM28dVi8sfaT7
	2yd9YETapQgtyIzM/Y/9Pl1pdIQawzAQnoKvA1LasQsGq4PjvRxcQ6fLnvDVqRXr
	vjlmMX9VfvqCbON7LNJvA/ycEn2Ho+0HZe0WpgiKVI/Iv26QspfILPsKCKMkNor1
	4LcuwGKK3VJlGDAaq5U6MlQJHqmtWyXtVtArJ7dybJXznHnB/cynXfYbassWF+V+
	XiSo/uT5jl7OX0nUOKCTeRSUEwYUAqg9EE0TL57Ba0Kv+S8Ps96rw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4hsup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666E4diF015305;
	Mon, 6 Jul 2026 14:16:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfwpaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666EGIIA26346074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:16:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B36620043;
	Mon,  6 Jul 2026 14:16:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3804E20040;
	Mon,  6 Jul 2026 14:16:16 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 14:16:16 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 17/18] nvme: fix context analysis warning in tcp.c
Date: Mon,  6 Jul 2026 19:44:19 +0530
Message-ID: <20260706141452.3008233-18-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706141452.3008233-1-nilay@linux.ibm.com>
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: UibSa194OQV0JQAtMm75Pp2tRi_l2Cu-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfXzWkK3ejaE9Wm
 tEE6oViIZFRA7LfEZweSZ1H5MCxJT2+DTHH2MpbJ6Et+cmbhkesaQK2nSi2VQ9sO666qSf77ZWg
 7fX4dISL895TQn+Lh+jTZJAyM8V0xmgvjrFdXue5hWvz4q3LBBQCds+s863Zqvqe/zCp4msDp2z
 SV6RajNXZrHvemDl7dvbIpUNl9kWfxg0TbvzWXY9gvfuEQ2ExaMFemCp86PNGB05TNSfauDDJbY
 3CqboB9PZNrXi0WBAxjzvOPWvuxbx7774Gp9PzvLCyQi6/y7b0UPXZ968jQOzjY47kRDrxkt1Ie
 zW2lh+t1XRRoZPgWiLu8/dwwhV8dnlozM0vVo4bRDcDm9Mu5NBGzWXZnICt9XZOlEQGBrfIMIfT
 4Rj1InJO6ZQAL36ZMEVJgfYA9YA9Ewk2KsN3LM+zwmjuiQl9BszbXijBaaa7sJmqXqLN4Qkoc2Z
 OD/SFI/XeBnWl+hbbkw==
X-Proofpoint-ORIG-GUID: Cz2iLel90qiSwS4JnvNl7jZuFbStvQUA
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4bb8b7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=OaIR7dClPEixnHXHKS4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX1FStJhx2wEV4
 Mdswv34sMCv/WaSJWD5gtUsyICE6OLHWVNR85o1M9OVJx7+B7Ttjm5UkgyTCXJsRNKbNinULtRp
 sCmswiapJh0C/+cCiL90kBJlN5kUZ+M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_151632_233080_28AC3D4F 
X-CRM114-Status: GOOD (  16.16  )
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

After adding Clang context annotations, compiling tcp.c reports the
following warning while context analysis is enabled:

drivers/nvme/host/tcp.c:2572:24: warning: passing pointer to variable 'list' requires holding mutex 'nvme_tcp_ctrl_mutex'
	  [-Wthread-safety-pointer]
2572 |         if (list_empty(&ctrl->list))
     |                               ^

The above warning is triggered because ctrl->list is guarded with mutex
nvme_tcp_ctrl_mutex but when list_empty(&ctrl->list) is invoked it
doesn't acquire nvme_tcp_ctrl_mutex.

Replace list_empty() with list_empty_careful(), which is intended
for lockless inspection of list heads during teardown when no concurrent
list modifications are expected. This suppresses the corresponding
Clang context analysis warning while preserving the existing behavior.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8d2fbfc7cd8d..87d8067f3283 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2579,7 +2579,7 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 
-	if (list_empty(&ctrl->list))
+	if (list_empty_careful(&ctrl->list))
 		goto free_ctrl;
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
-- 
2.53.0


