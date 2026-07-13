Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA68C44507
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4XHor9izBOOlUDLjoNdz/TnnxIkQ3jXlqq+bxvGr4rY=; b=hr77ycs237o4g81mfKOb9A+bLZ
	FI4HgoNXAnOkW5cVdc13kJLPFx9pCdN+pv50SJl8DivuuBfmQf9WKQj47dENNh8U8oScfv13Rc8SQ
	AOmLoZyMAxfGPr2tx5mQ6CwCQEqYvLBsYXr12f+YZk6Qv0LIwH/2/xiijLRrOib4QooTpTeacGN4I
	DYLFsgGX+tVdVJSAnPJuZIjYQhcxFzCSJkHegkkknM/TOEQkKpUBpnzsqYTNTnn40R5zKEcdZ9fDe
	1yABThxddVyd1vKqw0hjz2/RQG85XM99APcHOcBrNpfTiFD6kp37pxeNxMHA2AD26U6BkG5cvnYEZ
	Ct12xdaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFFu-000000094WK-3yfq;
	Mon, 13 Jul 2026 11:55:26 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFFq-000000094SY-48Rn
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:55:25 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D7vG2d006621;
	Mon, 13 Jul 2026 11:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4XHor9izBOOlUDLjo
	Ndz/TnnxIkQ3jXlqq+bxvGr4rY=; b=P+fEsukSOZuzV47EWn/iT8GrziJDh5OJ1
	Pxr3J0READQnSPf+EJxNs95MpOnZPReppOpAJIiu/FeyWbjxVgcvZeasMtQtUCT1
	xoIz1FC7bs2KvJQQRe813FUdmGI73hzXQ4UplzDtnjMSICN3yvGRnRZYmznnanZ8
	61Uon7UypkCM+F+9W98A515JhETAb2KduiR1/JN4u/pyO57iz+U8evUrzgr3Li3z
	KUJeSurgNlVD1IHuZ+dRDVrSdKG0vmYN3d/hLxxZKdGdhUnrtsxsjqLYRJaAtYg2
	Hofv6D/TIEEiVK8VqbU2B8TP0iQRbkc2aWp40vPwY8vMiNvwLdA9A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv330xwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBnafc006899;
	Mon, 13 Jul 2026 11:55:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05pwnwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBtAWl59703564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:55:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 312F32004B;
	Mon, 13 Jul 2026 11:55:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56D8F20040;
	Mon, 13 Jul 2026 11:55:08 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:55:08 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 06/20] nvme: remove redundant initialization of nvme_ns_head::requeue_list
Date: Mon, 13 Jul 2026 17:24:07 +0530
Message-ID: <20260713115444.465704-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX1mML+Tjfq3dz
 rx4/1thipcypaXZUtaOqs41T0MEKKgyU2kMn9HII/QNqtZ2zycQ6YMzeFp00Df10fTJylf8D523
 6OfPmNfds4hK1wQGkAtyWqm2CTLuseE=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a54d223 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=f4kkqRrmUjAs7RFRYyoA:9
X-Proofpoint-GUID: eBMgaTt6QXbHzmHZu3KLeyNOYoArPYcy
X-Proofpoint-ORIG-GUID: atZms1Efk_FHcqYkI53EyofSvEMN1MWG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX226aIKlRUPpo
 GjKrLdsxN4Ip9XfH6vOYHy6V75zYnotIcorQ0IXuSkXwIZnpXz1Xpl+SPWTS4jPCupZIXXMZA3R
 KdMiEAwbvOhBswLDA7zVrvRoUgypBOn78PlEDRyQNrMXSdBNyjISpRu4mBw/GsOrYKGgmREewIZ
 GdMyEdos1XOIrEd39inQ3auAyoQZBZ5t2PEtFdROms6CGWbzSiFeA55PaQLGJdA/u0lOdoJfK+B
 zhVfo3RqPfqDjjC6NBbodY0pLAflWMhGHrRuIFI8uxtyVK5Ta/vvo8YJj8+7TN8XqXzQ+s2j8tB
 zL/1JH6p+sSX8HcCGBsFm1KhrFd9TqJCoXwwVRqmhtEiGLWVdqoTd4IbN0XrP3mE6iDeySr8eBj
 Qsrtys3jK90PoY41odtKCukUK7+GcWbewUZQgnTujK1p+zr/qVCtw77OiEcv3slBiQWuuPCiWZa
 GF20u4PL0+jIyg+xtYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_045523_052730_FFD157E8 
X-CRM114-Status: GOOD (  12.76  )
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

bio_list_init() is a no-op for zero-initialized objects. Remove the
redundant initialization of nvme_ns_head::requeue_list from
nvme_mpath_alloc_disk().

Besides simplifying the code, this also avoids a false positive from
Clang's context analysis once nvme_ns_head::requeue_list is annotated
with __guarded_by(&requeue_lock).

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index fd2c2a5b1e33..282cd8abd0b7 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -734,7 +734,6 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	struct queue_limits lim;
 
 	mutex_init(&head->lock);
-	bio_list_init(&head->requeue_list);
 	spin_lock_init(&head->requeue_lock);
 	INIT_WORK(&head->requeue_work, nvme_requeue_work);
 	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
-- 
2.53.0


