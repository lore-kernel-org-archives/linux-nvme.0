Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE82C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jun 2022 20:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/AoFdluhF2czs8dvlXSuREPByuhGsHBb6q128LYMYJc=; b=bIQb0Xa9uCpVJGNuvMUw8GlXjo
	w0tjW1fKcoKutcaMA+1Fw4lVz1iv4vfykSttdpi8mQQnMolDagMGgps8fMkm/Umo8h3jviQIBtYR/
	1m3fBJ3mulkgvFdEEDzd/7N8tT6Cw9O3OrhlSfTGB6B0uc6SWarrKZkyMykSKPqOVADF/J8z/bYaJ
	ZxM/M9h7ywwQ6H2OA158xaMPq4gdFZRgPJOoSKD3EAnqtU/IYMFNaslDWGqR9ZABBwE94YGtWXa3i
	1DnGX86l6JYfWPKvb6clKF9D3yrbIWsdKj30smIBXjQnkYi3sckwqMVwZkH0cs2d721n5QX4dgexB
	Js0HkCqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7111-001TcI-SC; Thu, 30 Jun 2022 20:43:55 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7100-001T34-An
	for linux-nvme@lists.infradead.org; Thu, 30 Jun 2022 20:42:54 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UGL9RJ032574
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 13:42:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/AoFdluhF2czs8dvlXSuREPByuhGsHBb6q128LYMYJc=;
 b=ibi9lGKOhhtzZuPtZnGVhjlC3gBRXS/vuGDNFHnQJAEFNLNO0ZRFldY12pIPxbk7qzpc
 /FCKuZeW6yBWzPg29oGTYovrN/0fpOCZ79vMWF4zLGDwrtBWQuI1E5TXn76gvzGoRMTX
 0U7sjL1gJERRd13Kx+m48IDgJKd6OyizVko= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h12ug6g05-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 13:42:51 -0700
Received: from twshared25478.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:50 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id E1C3E5932DC0; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 08/12] block: add bio number of vecs helper for partials
Date: Thu, 30 Jun 2022 13:42:08 -0700
Message-ID: <20220630204212.1265638-9-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Kv43ED-MgGAVqrSdHkW_m2lHsMmp_Eor
X-Proofpoint-ORIG-GUID: Kv43ED-MgGAVqrSdHkW_m2lHsMmp_Eor
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_14,2022-06-28_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_134252_449088_7C66301E 
X-CRM114-Status: GOOD (  15.01  )
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

From: Keith Busch <kbusch@kernel.org>

Bit buckets get their own vector, so need to allocate enough to hold
both the preregistered bvecs and the bit buckets.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/bio.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 992ee987f273..ded38accf009 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -452,6 +452,17 @@ static inline int bio_iov_vecs_to_alloc(struct iov_i=
ter *iter, int max_segs)
 	return iov_iter_npages(iter, max_segs);
 }
=20
+static inline int bio_iov_vecs_to_alloc_partial(struct iov_iter *iter,
+						int max_segs, bool trunc,
+						bool skip)
+{
+	if (skip || trunc)
+		return min(iov_iter_npages(iter, max_segs) + skip + trunc,
+			   max_segs);
+	else
+		return bio_iov_vecs_to_alloc(iter, max_segs);
+}
+
 struct request_queue;
=20
 extern int submit_bio_wait(struct bio *bio);
--=20
2.30.2


