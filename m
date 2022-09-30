Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4974C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 06:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WITDi33ml99AN+RGdGVtg2lKafCL3RqyWwE1SQoSUh4=; b=MtxFHUCKFX+0Q/Gh/qxC6POAL4
	ftwXqm7MkpskXAoWSFGKsX5oyjlKIHw0+lcUlR71JvgeoF6f4UwmLuqFWPphQ5MXB6jmf++4HSlGb
	ERiktTZSunVFu6r8xi8lZb2J4xsLeWD6rqVYsLJMcBktotV7m1xr6akbJJR1oB17y40PMrusIA1lH
	TaI55FeSki28BrbtRVXaGan/CORQv+9LIEe+2vQzwplbSzrIHqO2DpRpotOsl7OtWEmpADcJKxAti
	dkLPTDV8u7lKB11CXxViOxUzKsCEQg1vEBKwkRcJ1fdhjhkoGsrSqkkk9wptiNZPsk+OF2VE3mUMf
	4VtCrdyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe9kY-007a0K-OW; Fri, 30 Sep 2022 06:43:54 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe9kW-007ZxL-8h
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 06:43:53 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220930064349epoutp030b96872638bcd2e4a119f139228a8005~ZkFRo_cvA2785727857epoutp03F
	for <linux-nvme@lists.infradead.org>; Fri, 30 Sep 2022 06:43:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220930064349epoutp030b96872638bcd2e4a119f139228a8005~ZkFRo_cvA2785727857epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664520229;
	bh=WITDi33ml99AN+RGdGVtg2lKafCL3RqyWwE1SQoSUh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y3fCFxajJ7LCZMpzJmJUpwj7PdCggnnGqnVUk1DIMgxWly9VHc9ROpolURY/iIJFK
	 nchtI7UXb8jw0v7Msr/qYjGKuroQ5b5Wf+H9h7V1OTfwYvcjVjgriS6HtpfQpBw7S0
	 SFYdgzzpuQt7iyXAv/8T+uHxdcOZWwPHpPZA51qQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20220930064348epcas5p1eafe37e427728f0cad44d70610bfb76c~ZkFQ2XQ0m1245912459epcas5p1J;
	Fri, 30 Sep 2022 06:43:48 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Mf10J3dZxz4x9QF; Fri, 30 Sep
	2022 06:43:44 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3B.C1.56352.F1096336; Fri, 30 Sep 2022 15:43:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20220930063818epcas5p4e321f0efa5a53759ea19eb8f1c63deef~ZkAdQ7OlH2578525785epcas5p4Q;
	Fri, 30 Sep 2022 06:38:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220930063818epsmtrp2a492bfbec5c70d3905530c31b54b44aa~ZkAdQGGWy2225522255epsmtrp2G;
	Fri, 30 Sep 2022 06:38:18 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-5b-6336901f972d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	40.69.14392.ADE86336; Fri, 30 Sep 2022 15:38:18 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220930063816epsmtip20492c0efc41135e268a92438ef82aefc~ZkAb3nZUD1763417634epsmtip2E;
	Fri, 30 Sep 2022 06:38:16 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH for-next v12 05/12] nvme: Use blk_rq_map_user_io helper
Date: Fri, 30 Sep 2022 11:57:42 +0530
Message-Id: <20220930062749.152261-6-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220930062749.152261-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmuq78BLNkg4lH2C2aJvxltlh9t5/N
	4uaBnUwWK1cfZbJ413qOxWLSoWuMFntvaVvMX/aU3aL7+g42B06Py2dLPTat6mTz2Lyk3mP3
	zQY2j74tqxg9Pm+SC2CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xN
	tVVy8QnQdcvMATpJSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqX
	rpeXWmJlaGBgZApUmJCdcbF3JmPBMs6KT2dfszYwbmfvYuTgkBAwkfg4zbiLkYtDSGA3o8TW
	/3MYuxg5gZxPjBIH/1tC2N8YJea9ZQexQeqX3z7JCtGwl1FiactDRgjnM6NEy6mfzCBVbALq
	Ekeet4JNEhEwktj/CaKDWWATo8Sv68eYQFYLC7hLrNzhA1LDIqAqMXX3LlYQm1fASmL5sRls
	ENvkJWZe+g52KaeAtUTzohyIEkGJkzOfsIDYzEAlzVtnM4OMlxD4yy7xc9lkZoheF4ltU25D
	XS0s8er4FihbSuLzu71Q89Mlflx+ygRhF0g0H9vHCGHbS7Se6mcG2cssoCmxfpc+RFhWYuqp
	dUwQe/kken8/gWrlldgxD8ZWkmhfOQfKlpDYe64ByvaQ2Pf4JQskrPoYJVZ+W846gVFhFpJ/
	ZiH5ZxbC6gWMzKsYJVMLinPTU4tNC4zzUsvhUZycn7uJEZxGtbx3MD568EHvECMTB+MhRgkO
	ZiURXvEC02Qh3pTEyqrUovz4otKc1OJDjKbA8J7ILCWanA9M5Hkl8YYmlgYmZmZmJpbGZoZK
	4ryLZ2glCwmkJ5akZqemFqQWwfQxcXBKNTC5tVb9mHrIXjr0TFjDaqPAndvP3plt/KSb5aad
	ckFqzpff1aYcIXPUrLs6dhbKG9o8m8h1+cKitOdtUbd/7FWZJuo6+eHHqxt72hxfrJ5RuF5Q
	4dXqH5dOsOl1z167Sd2kTqTG/ojN+9feayfstJRt/SYRycNVUyPKV5/ol+CXsvZY5bxFShPs
	thyY4sHPcqDzvnlD1KSE52JN35r4J5t6+i/zzch9qHJz91vriqB98+bIzn8SuDr3/DHFDJbg
	jrb35VN3OFewH93U4rNvftTvRRxab2M551/4cNVOS0rDjV2X3edwT9ieXFEla34V/tZPBk7L
	y4NcDk4y0tU5kSu0xrbku8+51Pvbly5exqfEUpyRaKjFXFScCAA5K1imLAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSvO6tPrNkg5ubhS2aJvxltlh9t5/N
	4uaBnUwWK1cfZbJ413qOxWLSoWuMFntvaVvMX/aU3aL7+g42B06Py2dLPTat6mTz2Lyk3mP3
	zQY2j74tqxg9Pm+SC2CL4rJJSc3JLEst0rdL4Mq42DuTsWAZZ8Wns69ZGxi3s3cxcnJICJhI
	LL99krWLkYtDSGA3o8T/z9vYIBISEqdeLmOEsIUlVv57zg5R9JFR4vS55UwgCTYBdYkjz1vB
	ikQEzCSWHl7DAlLELLCDUWLds8VACQ4OYQF3iZU7fEBqWARUJabu3sUKYvMKWEksPzYDapm8
	xMxL39lByjkFrCWaF+WAhIWASj7vec8OUS4ocXLmExYQmxmovHnrbOYJjAKzkKRmIUktYGRa
	xSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHOxamjsYt6/6oHeIkYmD8RCjBAezkgiv
	eIFpshBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1M6U3z
	VuVuyAtQ8bW8mnX+mZIeV40Bd6yrnOyPxXKWZcExAk+fZF3eKBKUdPHfPZ5zx3942rCoLHpe
	F7meZ2dtyaIy8+mb7A+X6F/fHxO75+SFwG2Z307Ub7QXrQ9+t7wz+e68DdKiPRHTIuzqdj7e
	ZcpeffH+lMInzu1ss6LXFx0rPLIt8ef2zoI9olLLHMsExG3blC/oRsxMPnfQs02YMfDjiUvd
	ps+kpqU9V/2hx73/0vH4BVwZHuFxQVOSj56Wdp17XCy0PzpRdXEy7960b+JffJ+7bpghMOnM
	ZsN1r9kk/+SFrG2subS/7+fEifPmvf2g8+nJtqc7HM4or96bsYLLfepDDnv9nh0rLqfFKrEU
	ZyQaajEXFScCAD4LOrTlAgAA
X-CMS-MailID: 20220930063818epcas5p4e321f0efa5a53759ea19eb8f1c63deef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220930063818epcas5p4e321f0efa5a53759ea19eb8f1c63deef
References: <20220930062749.152261-1-anuj20.g@samsung.com>
	<CGME20220930063818epcas5p4e321f0efa5a53759ea19eb8f1c63deef@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_234352_674683_324150A6 
X-CRM114-Status: GOOD (  15.15  )
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

User blk_rq_map_user_io instead of duplicating the same code at
different places

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/nvme/host/ioctl.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 914b142b6f2b..3746a02a88ef 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -88,22 +88,8 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 	nvme_req(req)->flags |= NVME_REQ_USERCMD;
 
 	if (ubuffer && bufflen) {
-		if (!vec)
-			ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
-				GFP_KERNEL);
-		else {
-			struct iovec fast_iov[UIO_FASTIOV];
-			struct iovec *iov = fast_iov;
-			struct iov_iter iter;
-
-			ret = import_iovec(rq_data_dir(req), ubuffer, bufflen,
-					UIO_FASTIOV, &iov, &iter);
-			if (ret < 0)
-				goto out;
-			ret = blk_rq_map_user_iov(q, req, NULL, &iter,
-					GFP_KERNEL);
-			kfree(iov);
-		}
+		ret = blk_rq_map_user_io(req, NULL, ubuffer, bufflen,
+				GFP_KERNEL, vec, 0, 0, rq_data_dir(req));
 		if (ret)
 			goto out;
 		bio = req->bio;
-- 
2.25.1


