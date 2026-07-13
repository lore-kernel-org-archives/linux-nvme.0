Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3814EC44507
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vaatYQhQiYTzBO2/iUmWVXdWlKHkVWN0eT8ZSjsZSnQ=; b=LqxDxBFaTPybi/w9HDxBfupXhJ
	joCHFv4JNs0N1ZlxOgfEeuEDBMrvMFdOvpCqmFKLOGa+HBn6bBRzr1414V4f+oPKp57NIsSl3pzHv
	17p42m+vK4ICcmmIQ0wIkD6E8tgRZJW/9xILdt8d9xrDdOMXtr/HUIc/s7uMdokCElj7ky5/swu7z
	GAzE621gIADinbweSsqwt6pmd9ckFg3Wc6nG7ls4w7yOaRVuanAA1l8+LGxXyKsMwzb85RwDWw11Q
	oclwF9SiUu9qhm99JHOI7nMN1UcGB5kwUP5NJlmhwnGyBKg67ia/o8qTCW9p7PDsg4sva3v7caGP9
	21OI4Dcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFGW-000000095Tu-2qMQ;
	Mon, 13 Jul 2026 11:56:04 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFGV-000000095Ry-3hGn
	for linux-nvme@bombadil.infradead.org;
	Mon, 13 Jul 2026 11:56:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=vaatYQhQiYTzBO2/iUmWVXdWlKHkVWN0eT8ZSjsZSnQ=; b=Amfb23zB+ZLhSDjndcx6ayFa1y
	D8uH1o2e9LI9IedDgY/p+kExURhBcIc3+RJ2Gepj+rJMCM7z4RALuCUyODgJNd1kcDbsqofZ+JvzE
	9GRiUJ9HaIcRmoAqnM/QWc9PFYKGIY145dyhH6J9P+AK0avRXVfXFkA7MosT48jQj24yu4zMtkj7N
	TvSvsikmozgBmC2kcsgGKNc5OBS+EHs7YyTyD0RR+Ry8nTl8U2272TlfViulX3CiOi295ymg2FWQj
	0gCfGRzrGy4LGxT5Lb7yt5BEIqQTqE+xst/Ct4+QLycwZ0jyhPzmg5aQOhgI9se6SaKAvpgM8nt1Y
	1onNepqg==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wjFGS-0000000BZg6-3J8T
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:56:02 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6fZaJ1740154;
	Mon, 13 Jul 2026 11:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vaatYQhQiYTzBO2/i
	UmWVXdWlKHkVWN0eT8ZSjsZSnQ=; b=UxQwISe45BMRA+GSGPl9HaZ766mdA96Au
	eMHp8MJFrep74/BMv57lO01Of6NCZeGbZMvr5lMw2Ilkj2qwJQo46yCCs8xxPG7Z
	jTTzd5nDgSUG/V+hywPaxMaIiJ/eJYMJsP2P9cYspYBXhgFNNyxW4f45wuREnTiZ
	O7xw+VpM10IbNZNOZ5alIy2GI69iNRXsCZO+oLnDB24L3vThxbor036M4cvNuV4l
	jbfqqn4pAlRImi3pWMC3PIDCSBPt5y8nsHomypsrMFkRu/bWegYt+agsLaH7q54m
	vpC4DoZeV+G/J3g2d/XqEJtvPL3LcZQNEY13jbaabfLYu53hsvjvw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegt0fcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBndBF006908;
	Mon, 13 Jul 2026 11:55:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05pwnxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBtcYP47514058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:55:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 374642004D;
	Mon, 13 Jul 2026 11:55:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C99320040;
	Mon, 13 Jul 2026 11:55:36 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:55:36 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 19/20] nvme: fix context analysis warning in tcp.c
Date: Mon, 13 Jul 2026 17:24:20 +0530
Message-ID: <20260713115444.465704-20-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 5huRcoF49ZqK5X3EUtzri1tUt_1iqIQc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX7Sg9UXy/viWi
 QWUE0mfcOkC9t0KfONDUBxmRAfi5Is9B76VL0tzS4EHdDD/WW4gAY6iJtRskjUgKGzjbxBrJXCd
 1rc9onVNFErt8YN49cB0agDzRD2aXuQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX28dWUO6HUTzY
 FDp99Zl7yUuPK2fIbYmfbNPkt17wnPRug6c+96OdVihyaoWhncyB/h4K41k9NELB6RLTK0y5Azq
 /GoF5Tv2n58e9ij3AyZSEtLWdwRL9NepLRwAHWnUumMrBuBOToW+f06aMQf/v2XrMgfA42K6Tn6
 1Fv/B9l37td+zoj9JZYlzp9mPd1CcWmL7Vy2PjGYojXBjoGugk7q5QROKurKpO7LYXuWTXXMjAT
 2yQ1fL8s3DarzhA5HKFhNi2rlmQfztVvu0kzaJFjTr2gnloRw7nVeTHfPfOUrTVvaawKtBjUbfF
 iM48gS9KqWLD2A2siEEJbAs5S+3XPx+Uf4LRjffGrXr5DpkRyuIX8thsaNemwX/IEVOIeqG5XjX
 6/Rgpq65PR43D6LnF0IZCnCdFEFBYiskGNWabBoKX7BRSfmw4GUB7tgURT4wdlLUAznOMpUC2jZ
 tJ35MS7/lni73DdYa4A==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a54d23f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=OaIR7dClPEixnHXHKS4A:9
X-Proofpoint-GUID: 4c6DzjkBMwTU4BPciZB4eg-N2GgKeGMJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_125601_178756_059CA548 
X-CRM114-Status: GOOD (  15.90  )
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


