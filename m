Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5123DC32772
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Aug 2022 10:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=luIncdN4Xs0/S1pPktHEcbVCfvwuJAGRaiPlDpqB9Rw=; b=YHJVYw43EUG/dPlA/7K4FizDGz
	Yt1jTjT25cp1/crRDPt06GOozk5BdAeJRAu9gINZC/aETj8DK3bvRK2dZ4jJ/2X9VrV5pMGk9DKtB
	omNUcztfgnNkqDaukHEjQ+9g2Z05ucvbvIsnq+HykJuAkS6r3lhKuRNOPNi9Dl6f8pxzq1OrC/lks
	5rVIxtCJw9ieddNkz8zA/aYBprP/3qdqreg+6T03GtsJTqwX1EPky4mtSPa5qjTg+OPs7sLClFonf
	jIuL+hbb5Iq/wBUHibrR/upMvCzpZkYpDL+iExjG7UC81ok7Tn1oUVzSHU2DJmD8rg4DKI7fIQfo8
	AO7+3uwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOzQt-005u60-Ou; Fri, 19 Aug 2022 10:40:55 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOzQp-005tjb-Ps
	for linux-nvme@lists.infradead.org; Fri, 19 Aug 2022 10:40:53 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220819104038epoutp026c6e033da145ad508a85386a7a7bcf2e~MuODvZTZl1796617966epoutp02N
	for <linux-nvme@lists.infradead.org>; Fri, 19 Aug 2022 10:40:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220819104038epoutp026c6e033da145ad508a85386a7a7bcf2e~MuODvZTZl1796617966epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1660905638;
	bh=luIncdN4Xs0/S1pPktHEcbVCfvwuJAGRaiPlDpqB9Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQlSvyQLaENZqa1UzVFVG2YTbM7p+k6Ndg1opl2OReyA5Xe+BuYUHN8CkzCKtbqER
	 ID3dgfd/5j0tBtLqJSz6ebm5HJIc23aBnOnVsn6SZORoQA6XuaOwUOVzIP5pjdWnoi
	 ubWcWgdbvo5SR5QIso7rBfstKNaGgPOPLmvlmspU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20220819104038epcas5p394a9a6345e766d02cb41514c87f13a59~MuODdweyj1255012550epcas5p3_;
	Fri, 19 Aug 2022 10:40:38 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4M8JF03yxjz4x9Pw; Fri, 19 Aug
	2022 10:40:36 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0E.63.49150.4A86FF26; Fri, 19 Aug 2022 19:40:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20220819104036epcas5p2bb4d9b2cccbdfcdb460e085abe7fd1a8~MuOBVSWKC3086930869epcas5p2y;
	Fri, 19 Aug 2022 10:40:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220819104036epsmtrp1782211f8f9e4e8aae82d93c33472bf4f~MuOBUVhuW1513515135epsmtrp1B;
	Fri, 19 Aug 2022 10:40:36 +0000 (GMT)
X-AuditID: b6c32a4b-37dff7000000bffe-ca-62ff68a4bec6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	58.85.08802.3A86FF26; Fri, 19 Aug 2022 19:40:35 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220819104034epsmtip134ff85bbc9da877d52a3fdac6d6bab82~MuN-cbf4l0468404684epsmtip15;
	Fri, 19 Aug 2022 10:40:34 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, ming.lei@redhat.com, gost.dev@samsung.com, Anuj
	Gupta <anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH for-next 1/4] io_uring: introduce io_uring_cmd_import_fixed
Date: Fri, 19 Aug 2022 16:00:18 +0530
Message-Id: <20220819103021.240340-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819103021.240340-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmlu6SjP9JBjPey1g0TfjLbLH6bj+b
	xc0DO5ksVq4+ymTxrvUci8XR/2/ZLCYdusZosfeWtsX8ZU/ZLQ5NbmZy4PK4fLbUY9OqTjaP
	zUvqPXbfbGDzeL/vKptH35ZVjB6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
	6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
	KTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM548iqy4Dx/RevaDqYGxkm8XYycHBICJhL3lyxk
	7WLk4hAS2M0oceNcCwuE84lRYsGdiUwgVUICnxkltl7Nhum4enopK0R8F6PE5mYniAagmtuz
	pgB1c3CwCWhKXJhcClIjImAksf/TSbANzAIXGCVONn1lBqkRFvCWWPtYE6SGRUBVYv3epSwg
	Nq+ApcS2fWeYIHbJS8y89J0dxOYUsJKYtfQqG0SNoMTJmU/A6pmBapq3zmYGmS8h0MohcXbp
	ZVaIZheJwx8XsUHYwhKvjm9hh7ClJF72t0HZyRKXZp6DWlYi8XjPQSjbXqL1VD/YncxAv6zf
	pQ+xi0+i9/cTJpCwhACvREebEES1osS9SU+htopLPJyxBMr2kOj+c4QdEjy9jBKLf1xgncAo
	PwvJC7OQvDALYdsCRuZVjJKpBcW56anFpgXGeanl8FhNzs/dxAhOoFreOxgfPfigd4iRiYPx
	EKMEB7OSCO+NO3+ShHhTEiurUovy44tKc1KLDzGaAsN4IrOUaHI+MIXnlcQbmlgamJiZmZlY
	GpsZKonzel3dlCQkkJ5YkpqdmlqQWgTTx8TBKdXAJBL/wPnS7NfxczS/KO55MZnngO/1qbGC
	qfsfm05X/9v3am5pr5aXtYL75cy+a73W3iYHV1hN/LVhw6FTjOd8b1nJN3gZhL1TDy86ecdY
	y//oHl0RduPY8jUnVjJq8rz+XJDVvtmh2zNCj1tp2UOV2ZI8Wndfhz1bcaPyVJxp6M0Ly/Vt
	NwZoh2Y3pbreUOqU0L1c3Hg73v1J0FyRqVpyUvlhm2Qlp3/Ke7F6zl2ju/Ml7NIF7aKmGHS8
	P2PX6bpffGOEvsiRSfZx7zpXXs5x+b+kslt95yWuVf3b+hjqEx19vxmc3iNzc2bSUV3nFU9i
	79mq2OQv88xVU5/u6R0otWleAMP+FctUlp5a8uahEktxRqKhFnNRcSIAs/ff4ikEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsWy7bCSnO6SjP9JBkflLZom/GW2WH23n83i
	5oGdTBYrVx9lsnjXeo7F4uj/t2wWkw5dY7TYe0vbYv6yp+wWhyY3MzlweVw+W+qxaVUnm8fm
	JfUeu282sHm833eVzaNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgynryKLDjPX9G6toOpgXES
	bxcjJ4eEgInE1dNLWbsYuTiEBHYwShx5fokZIiEu0XztBzuELSyx8t9zdoiij4wSB3dOAerg
	4GAT0JS4MLkUpEZEwExi6eE1LCA2s8ANRoltE/JBSoQFvCXWPtYECbMIqEqs37sUrIRXwFJi
	274zTBDj5SVmXvoOtopTwEpi1tKrbCC2EFDNr78dTBD1ghInZz6BGi8v0bx1NvMERoFZSFKz
	kKQWMDKtYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIDn0trR2Me1Z90DvEyMTBeIhR
	goNZSYT3xp0/SUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFw
	SjUweemfl7mxZ4niQ/GZHyPVbgUduFrEfU/uoc/80KKQC9panwTlGpd+t6r3evk5MSxDwute
	QDODzH+WPdeaRDXM5qa5v1z8L3jKnAtsxol12/hOX93dcKha9tb5H+dnbtNYpeK3Vfzr4u0n
	mTf07ZdxtH8oHTZvV8+SmprMTXJzmp68NnjWd2djq2lX3aW7aXH3M6VqLvq3y7eJ7nA7rav3
	S9ltq7uFluyj0s9f3fsm3+rZsIbbI17vzcmDs0r3N9j+sLFZWNKrnarRuuSddmPBlGyX63Fh
	zD9mHVopVnfcZ3f4JRP5TptIxgNN0t4Cb1v3Hl08NTNK3FvZ5Ldz4m7DuprVZ1qWsKv+FfMr
	6VqgxFKckWioxVxUnAgA1ciFCuwCAAA=
X-CMS-MailID: 20220819104036epcas5p2bb4d9b2cccbdfcdb460e085abe7fd1a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220819104036epcas5p2bb4d9b2cccbdfcdb460e085abe7fd1a8
References: <20220819103021.240340-1-joshi.k@samsung.com>
	<CGME20220819104036epcas5p2bb4d9b2cccbdfcdb460e085abe7fd1a8@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220819_034052_383286_EA62FA0B 
X-CRM114-Status: GOOD (  13.84  )
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

From: Anuj Gupta <anuj20.g@samsung.com>

This is a new helper that callers can use to obtain a bvec iterator for
the previously mapped buffer. This is preparatory work to enable
fixed-buffer support for io_uring_cmd.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 include/linux/io_uring.h |  7 +++++++
 io_uring/uring_cmd.c     | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 58676c0a398f..60aba10468fc 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -32,6 +32,8 @@ struct io_uring_cmd {
 };
 
 #if defined(CONFIG_IO_URING)
+int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
+		struct iov_iter *iter, void *ioucmd)
 void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret, ssize_t res2);
 void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
 			void (*task_work_cb)(struct io_uring_cmd *));
@@ -59,6 +61,11 @@ static inline void io_uring_free(struct task_struct *tsk)
 		__io_uring_free(tsk);
 }
 #else
+int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
+		struct iov_iter *iter, void *ioucmd)
+{
+	return -1;
+}
 static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
 		ssize_t ret2)
 {
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 8900856fa588..ff65cc8ab6cc 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -121,3 +121,13 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 
 	return IOU_ISSUE_SKIP_COMPLETE;
 }
+
+int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len,
+		int rw, struct iov_iter *iter, void *ioucmd)
+{
+	struct io_kiocb *req = container_of(ioucmd, struct io_kiocb, uring_cmd);
+	struct io_mapped_ubuf *imu = req->imu;
+
+	return io_import_fixed(rw, iter, imu, ubuf, len);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
-- 
2.25.1


