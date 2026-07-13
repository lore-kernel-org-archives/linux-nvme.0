Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FBBC44508
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EQ/135VJVeLMIERaYABh/o2+dfGg4dSPAPpzTXu39NQ=; b=CF3EgkvwhS0cCIDwpjt6wiqU8k
	7YycHLqKbSvuWnGXRV5/fWeQMcqi0/doAS0JN9WP1/C1ntk7FS6bYnYe4dzwIEBwXlnJh7YtOKa+K
	KZGjMOE7YI7RyDaBebLQuyzW4gQy517/UmnGMngIL9YB92Qkkp/huOKEJpIiEQEaEEwSyAtsKsVZr
	Eqm4Dd4mFxtp6cy+NsyZPA/MFORt72CJwOpYEDinOvFXrBvZdWNX+ukk8lYh9f1+t9bnpDA1VsqCD
	lFlj1iWJ4DH9kkfXr+Wen/rFHgM+7bgpTAjOTGtCwOMs+bAgr2sdERLmYzYMqBzejZodihBApObZu
	goSNur/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFG2-000000094f1-3I51;
	Mon, 13 Jul 2026 11:55:34 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFFz-000000094ak-10IQ
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:55:33 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6g1Me1668752;
	Mon, 13 Jul 2026 11:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EQ/135VJVeLMIERaY
	ABh/o2+dfGg4dSPAPpzTXu39NQ=; b=Dyc8sZRyjagT6lzYgSW+mLAnF6oCrHNGY
	6w90WWH/TesZ0nAJVEI4DLBureVAjNyM24IJEW4eC7BYVE02xXItosLU62fTTn0c
	ZuddgmdFZ1f7N6KsfLmV7QQL0AH7KiT8AeyIb9DZkmS0VBqcHkifF6i0uOYiW2sl
	PJWz1MF3pEQRjie/xWoGuBCA0lGGxKkQzBsplo6j03uDpNCSi41PNGt0eTccqrgP
	3/PaQlV4iSrYKWR40uSBisIq0Rc1JfrsYgyO51IiWbv8z03Jl0LRTvrhDCEbFQKi
	K44VxmYNwABrFZChoSiW4bIfFJ8AdYV5g9JjX/ws/r5U3dTrAAcDQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwg1v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBne8U023628;
	Mon, 13 Jul 2026 11:55:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nh5cwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBtGtw53084494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:55:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C13942004B;
	Mon, 13 Jul 2026 11:55:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D360820040;
	Mon, 13 Jul 2026 11:55:14 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:55:14 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 09/20] nvme: add context annotations for nvme_dev::shutdown_lock
Date: Mon, 13 Jul 2026 17:24:10 +0530
Message-ID: <20260713115444.465704-10-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: -bDJKtEYH7jhlvQoOvVR9afX5Ovy0TU6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX6rY1xGePzThg
 dWTcW2RkQHN89nx9zkzc/TFqG0mOjDExfCaAeaIMgJ4NKQx2u50D+jvMvFQlpFxvQyTS0Sjm3Bs
 0l9JlX6s6gz1tSxTV0lcaGEVii2vchcS0dvM1sgXliJe9/i7Dh35s4gzGw2Ox6Hqhd5g6zPCREO
 +0j4WPKN8HMIBQNdTLFwXAccPV6U8SWM5z9PwuW8X5Xn6K+1nwoBFZ9/wISsQoEyCo3EBmC6rIA
 1l3dPrXxkFw5W5SgSXULhq0V1ommMOzgl0DjkU1tzgrf814a7QKpGMJogsbHRiaFZHYbcedEiTn
 /1WRdhv81Y9PBQm7Br1gCrLLk6NMf2deqlnw++V5gLp3W4AAn6aCQ2wW22g6xxOwloLqknqudL+
 q+mS8xuBb/bb9wH/1NreVNdyeK/BODqi/soV0vozImdOYfJl/zPHhYPPv4U07Z+EoW5KSvgtbnW
 2N671hItcHt9OOje/XQ==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a54d229 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=lhRNW2dt6MhivXYX8oYA:9
X-Proofpoint-ORIG-GUID: 6TE3Oq3gb6sx4VSQJ4AceaN3kVA6jf12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfXzqoiGb2xp89K
 HDjnYxlRP/QnXdyJ8UrqZ0BCaWsX/5jb1y1BsXUcA4VhX002upLpZGW2LgCb729sgeOdSce5s0C
 Ma5Tk20nrzeuzDzIiTWJgmcO+7SX8Io=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_045531_394913_E620A0F7 
X-CRM114-Status: GOOD (  15.22  )
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

nvme_setup_io_queues_trylock() conditionally acquires dev->shutdown_lock
using mutex_trylock(). The function returns 0 when the lock is
successfully acquired and a negative error code otherwise.

Annotate the function with __cond_acquires(0, &dev->shutdown_lock) so
that Clang's lock context analysis can track the lock state based on
the return value and verify correct lock usage at call sites.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 69932d640b53..7954417d1252 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2199,6 +2199,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
  * Try getting shutdown_lock while setting up IO queues.
  */
 static int nvme_setup_io_queues_trylock(struct nvme_dev *dev)
+	__cond_acquires(0, &dev->shutdown_lock)
 {
 	/*
 	 * Give up if the lock is being held by nvme_dev_disable.
-- 
2.53.0


