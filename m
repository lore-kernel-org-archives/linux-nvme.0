Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0605606A338
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IzcFA+XP;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=CIke0rTK;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GIjx7BHk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0+uA4PndobshceYzh1zPc4LHerhLziaflUMw6tKPR14=; b=IzcFA+XPd232sf
	I16KMUs1fPiS2DN4Ie9h70uOHlBt7bYg/XK8eKdke7rKR33tQwHMpNBsnqvRWouz6VXHPxDo0jrHS
	Fql2crgLfL7miut1d+WbcJi3nflsplhZzqMDuiMm9ZmeQ0+OycoVE8YA6hizuHCWwHKJIzZ2JJnL/
	MwL8AtlHhuwV7B95bE6ksdMZCdFP7tC4p15i9dzQA/1rcpVtBiCUAVnYWDKXudcGIats2U8bjEfrb
	J1hd9RFgoX7JkUDFlCeRlM5QASkJYx9moIHNJfJQRGXVi/zPOsTcYUxkHYv70j3ZJvfIt1B/nzgQT
	TrHQEvVPHZJFuLhMmjTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG86-0000000HDYU-0VBr;
	Mon, 09 Nov 2026 03:33:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG85-0000000HDXE-1Hut
	for linux-nvme@bombadil.infradead.org;
	Mon, 09 Nov 2026 03:33:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=0+uA4PndobshceYzh1zPc4LHerhLziaflUMw6tKPR14=; b=CIke0rTKATxElA7XyMlc0inFWa
	lZ5AbCLtxMqr7EvD944XwCdkIH2/gPx0KXVflHW0nZEBcudtbrsbWPXNBbJQ8c7xURHlFXKAM0fEs
	sr+gSKb8omM/NpZyTDsHQRCVwIKWD8jxR6ZDbCPi7hOCY5b5CV21rURq/LlP8K6YaExjuT2BQgJdJ
	/N1ZQE+8grFQi73hBpcQOCXFYSSPVY0rreI1pKJK39EIDI5jPDP+XuNt3XeWxtf0T3w+ePfla02E6
	+2j9BuaF1LR4LrgqM38WxA1GscrLDUr3Kjg+jQe9SEEDmgs3qIBHMzYnhj+/sUy9y9oLczlu9rcI5
	/HqMGFVA==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG7z-00000006Fez-3sjn
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:33:08 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90iFQ11887814;
	Mon, 9 Nov 2026 03:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0+uA4PndobshceYzh
	1zPc4LHerhLziaflUMw6tKPR14=; b=GIjx7BHkpU8Zp7fv7UnyJII7oIa8Lve8E
	imIuc2AnZIsy5KcxgucbLPA43wAdo0WHzoYP7kdGUqApcn+l3150w1u515N7FlAq
	SItF9gT6VuNjfXBupuILi6iWcEmx1HWqd3PNKSR/U/8vSl9hfzAbyyGntQQ2SCyk
	tbxD6EMdu30A1cGdlzp7Dzf5GvnuJzeN/vXOW8ii1Q4oCov+JogkboyWtoUt7MLc
	EcVvuk6ZLwWrlOjya0N1isSzJHL/1IirLDySmrikSvjSkBAk0AkZkvY4LJcfKkP0
	wgotH368aA0DiaYuzqglB7Yjj4itLzuGyQhr1/imylqpSCd3zHrtw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkaxrs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93JsWW3580588;
	Mon, 9 Nov 2026 03:32:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hteapwp8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93Wm5n19792500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:32:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAF2720043;
	Mon,  9 Nov 2026 03:32:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAFE720040;
	Mon,  9 Nov 2026 03:32:42 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:32:42 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 13/23] nvmet: add context annotation for nvmet_ns::buffered_io
Date: Mon,  9 Nov 2026 08:58:18 +0530
Message-ID: <20261109033102.982191-38-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af13ee4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=wyQYIfH3qne7WvDzmQEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX5I1dj4vvDRMs
 +6c35lZ8doA5tRfV7j9jN+OwJ/UhpkMHMHhchqe+uPieUigXDvbA7iHDyRDgqljL0+Kym4Mo542
 i/s7Jx12xdpU1DEN3HJNMOrhnZTPJWTxicYMvHwvbVWuIkBm2VxOXOF8y8vfRc034/T6PVaLVfw
 Z5XPJYgFVi5fcS8DcMBmqNx5GJNlF3z2yJsT+bSwBNs1OyDrPqYRTnJWyk9id9ZP89pkLOL3VhR
 ukvBvE36AH74Wv+JyWJSnZ2qUXYxxrJjPQr7SapJSQe4tTv/I8VZNPZuEnffG/WltcsVa6AwdFS
 2m2mYlrZhgXBUVHq7z/d4ddyJHUypTBIVvLtYOt/1pvEvcAkN3qoLWAXqBhB9xG9E53Xc56QdhZ
 1+oO61dF/1dhkRomsp2R2Fsd8nevuJ0CNHPjLEdHEN7yzXo3Z3Ms7L1OG60lYF/o+TvpZrfWUwD
 jjVb9oOufuhG/Ltdq6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX4D1DipooaFp6
 QkFb0yVsL3ZVovfoYcCitGWwKRDRovEEWDumf37YbEs8nQf4jgJjCaCUPz33lqdQGkMZXxC32uf
 lNaeypwpp5TBUh9A0lRX/OKnU0bSizE=
X-Proofpoint-ORIG-GUID: QapyauouZUFhUyqcm64UoLQZ2Sa49uYX
X-Proofpoint-GUID: cT_6LelhlbaIjB5CUlhxPwqbwGjVXXXx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_033306_376803_70EC90A2 
X-CRM114-Status: GOOD (  17.82  )
X-Spam-Score: -0.7 (/)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The nvmet_ns::buffered_io field is protected by nvmet_subsys::lock.
Annotate it with __guarded_by(&subsys->lock) so that the clang context
analyzer can validate accesses to this field.

Some accesses to nvmet_ns::buffered_io in the I/O hotpath do not require
holding nvmet_subsys::lock, as the namespace reference guarantees that
the namespace remains valid and the field is not modified while I/O is
in flight. However, the clang context analyzer cannot express this
access pattern directly.

Introduce nvmet_ns_buffered_io() as an inline helper annotated with
__context_unsafe() to allow these accesses without requiring the
subsystem lock. Convert the relevant accesses in the I/O hotpath and
request-processing paths to use this helper.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/io-cmd-file.c | 2 +-
 drivers/nvme/target/nvmet.h       | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 224b7423b780..295203f10c2e 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -239,7 +239,7 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 	} else
 		req->f.mpool_alloc = false;
 
-	if (req->ns->buffered_io) {
+	if (nvmet_ns_buffered_io(req->ns)) {
 		if (likely(!req->f.mpool_alloc) &&
 		    (nvmet_ns_file(req->ns)->f_mode & FMODE_NOWAIT) &&
 		    nvmet_file_execute_io(req, IOCB_NOWAIT))
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 3e18c36e83c8..572f495b06df 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -169,7 +169,8 @@ struct nvmet_ns {
 		__guarded_by(&subsys->lock);
 	u32			anagrpid;
 
-	bool			buffered_io;
+	bool			buffered_io
+		__guarded_by(&subsys->lock);
 	bool			enabled;
 #define NVMET_NS_IO_LIVE	0
 	unsigned long		flags;
@@ -214,6 +215,7 @@ NVMET_NS_ACCESSOR(u32, nsid)
 NVMET_NS_ACCESSOR(u32, blksize_shift)
 NVMET_NS_ACCESSOR(u8 *, nguid)
 NVMET_NS_ACCESSOR(uuid_t, uuid)
+NVMET_NS_ACCESSOR(bool, buffered_io)
 
 /*
  * These accessors use data_race() and READ_ONCE() to allow lockless access to
-- 
2.53.0


