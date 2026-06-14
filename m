Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7623CD98D2
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jun 2026 13:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=if1FgO06pHuHnvHl63IDp5UR2P7rjOUU9fqwNIMifeg=; b=Om2RqNk4SwXaOJtxdE7CpNsMZk
	aZgAb/oPrTm27qO8WHMa8pSriPWqLvuPSi2ey2Sat7OrwffEfxQbIViA11aUBs7qqzasmL3Ms20Ff
	LKfs4B7SEQMx6zxy7w0wvLbWkX0XBwf6+NIAUKrXnJiy6WD4w+t30VYLZmca1I7Rybeb9FEhxDnhO
	TNimPUzATQYOlb0gAUZ+loR34a3dq+6bPPu6VUrv6Y4JM2sxnLtaYzn1vuhUmg9EnkkMKVA9YmDZp
	Sxpebi5zt66ZAUs+H2HQzTv49D3ol4RAov9vAAkm25VsH4bK62nsZZT/hkHLqJsRfkFf8mDJf31iv
	WIXq4mqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhd-0000000D11x-2MgR;
	Sun, 14 Jun 2026 13:16:41 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkha-0000000D0xX-24v3
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jun 2026 13:16:39 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ECmC6i3483791;
	Sun, 14 Jun 2026 13:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=if1FgO06pHuHnvHl6
	3IDp5UR2P7rjOUU9fqwNIMifeg=; b=CsHtGqVj6/xpEbbtC7Qxe3BUhmvSuNhma
	U/Mvf54C9IepznLiO9MSZUGF7kqUz7h3xh4gDVv9Wddb21m3l7abwFh5ZLaZdrw0
	oJpnKds/YYA/pxDenmBNW+H9KhtMnrOwkySfE2X2kA/3/75sVOSxR6tGVjrR291O
	gziaRdsEBxXQrdbTdn+z7suMhwGS25d9BbSwBVpEEE8TrC7XbrGko48dqsPOXtiI
	LaxN1l5Jb60hW5lMyArO6jMUpXiv3HkauFevtCh71kXrkvCIV689n/QcxBBWFM10
	/5ujvSLpBJcubsvHlvGswWTkrf5X059vKjCkuHA3guefFkig0OMQw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wkumjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ED4Zfp008918;
	Sun, 14 Jun 2026 13:16:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhpstgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EDGFZq27591224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 13:16:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5611120043;
	Sun, 14 Jun 2026 13:16:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FA8B20040;
	Sun, 14 Jun 2026 13:16:12 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.80.1])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Jun 2026 13:16:12 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 08/17] nvme: add Clang context annotations for nvme_ctrl::ana_lock
Date: Sun, 14 Jun 2026 18:45:23 +0530
Message-ID: <20260614131541.2017845-9-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614131541.2017845-1-nilay@linux.ibm.com>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX12MCL/sqG7AP
 Sq/AFZPSUMzPDGs/sABE7mjyPYuj+NJjn3l8PMNFab8Ivgfr8KbcYqpWIHxJtm2R3usyNBjm1Uy
 LYHCdbvPqOQz1aY7D/7eEmXVkYtsr8U=
X-Proofpoint-GUID: RMqsagEG_j-CgGdDJfq24VyS0PGIQZ15
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a2ea9a4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=dKw57NzDpq4Cn0Z9zg4A:9
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX6aqQsYTrHZFs
 /z68uvKsx/w2Qki/HMqaTgwr8GLWvhBIcpIqDT9oPpMXLEtueZJxlTRoGaKtH+3PHC6Pm3Smv4H
 nzlXCA6K4StqHQ2XIbtLsfsSRLgh3tU2WH8wPTTNUz5rPHN61uzlD0wgj0ilVMK5aAuSTuDP1UD
 pAnTBgxK3cGA8UgxluoVUjb5SBeGL7UTEupqMXWx8l7rIWxuYz8PFqo4eT0hI9LQfZ9FVA+Mt5S
 EiC7/7C2Gp1D0yZLQMyw19gsO3HGHhOe/RlaxO46Ensbj+0oG8gD3lszWWtqZTYBk8O1fyUyCia
 ckfsOHPLPwsmg1fYNzHHCvf+LjTNowF7BxWfubm8Q7WV35yHH609Mv4KRp91wRqphjd74Fix/Q5
 ncLaOJxPErFjYTEtKDqa1R2GXARwm9l0q8WtDBkwodIjwH6feM3VDNHF+1TAhtuojlnJzeo48pM
 jT6BxarkW2YEVBblStA==
X-Proofpoint-ORIG-GUID: fCaDPZcf9hEFE2uRfipy-ZxH7GlHtYl_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606140130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_061638_539737_900F8C86 
X-CRM114-Status: GOOD (  10.47  )
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

nvme_parse_ana_log() accesses ANA state protected by ctrl->ana_lock and
therefore requires callers to hold the lock.

Annotate nvme_parse_ana_log() with __must_hold(&ctrl->ana_lock) so that
Clang's lock context analysis can verify the locking requirement at
compile time.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e816d88ffeee..4eb050671f32 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -818,6 +818,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 		int (*cb)(struct nvme_ctrl *ctrl, struct nvme_ana_group_desc *,
 			void *))
+		__must_hold(&ctrl->ana_lock)
 {
 	void *base = ctrl->ana_log_buf;
 	size_t offset = sizeof(struct nvme_ana_rsp_hdr);
-- 
2.53.0


