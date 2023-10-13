Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28437CDB47E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 05:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=qAK735OwvlOFR1NmmkpwefRYYKe/iqohxy5d0zb83vQ=; b=YiFwviwTbinr87AARIpNutVQ5C
	yTez23phtE9nwEsA4XmhE9ZCRQUrI+/0Xbt1HNeMbPA+aXl3F62VWZ7AI+dG5cxWi3vf9QnNGemBr
	tT+cOoB2EIjDknYuTSMrftdxS8SaQ564nkRNYl1ya04uERZbBXoru6Go7JPOj8ZCga5DfawxpRII7
	SrLY6huyz0qE16AOwgTn5h3IX7iYTMY77rMYynyBPFP2SSWjy3mhORGYcB9QEFOXb89o/ZaHgVWqq
	00Uz8qXcAd1KJRuhZz4Fk1J/9hAxd9v796llHMbNP9P7m8AIIXF+sW1QitqXuVM/aNJOWbavPaj7R
	vm62sgGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrAct-002Vih-0p;
	Fri, 13 Oct 2023 05:22:19 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrAcm-002Vhw-0l
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 05:22:15 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231013052159epoutp018e610d6ab3f72026ff81f245a133b18e~Nkzvhdel61978419784epoutp01D
	for <linux-nvme@lists.infradead.org>; Fri, 13 Oct 2023 05:21:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231013052159epoutp018e610d6ab3f72026ff81f245a133b18e~Nkzvhdel61978419784epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697174520;
	bh=qAK735OwvlOFR1NmmkpwefRYYKe/iqohxy5d0zb83vQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ZsbE1UzEPzkd9pz47Jl4+wGbTAje4qsRjdYEirozCx/G/fD3cHlpXT31K/YC6nTaT
	 ofh/YL9aLkgobqnr76j0nnRDWnakWp86hHOzcXQvdgPeS/d/ewnIsMrs+ZyVBKghh7
	 /ArznMDiuH98uPz04pBB8Kzx7JKDFREK6+l5vorM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231013052159epcas5p2845b42166569c379b9e0527fb36279f0~Nkzu1rCxI0177301773epcas5p2A;
	Fri, 13 Oct 2023 05:21:59 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4S6FHT3z8Rz4x9QG; Fri, 13 Oct
	2023 05:21:57 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	85.17.09949.5F3D8256; Fri, 13 Oct 2023 14:21:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c~NkzsyuFdN0125201252epcas5p3_;
	Fri, 13 Oct 2023 05:21:57 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231013052157epsmtrp209e17dee98e85eaa67d8ae91e4c13fb5~Nkzsx3-Oz0962409624epsmtrp2D;
	Fri, 13 Oct 2023 05:21:57 +0000 (GMT)
X-AuditID: b6c32a49-98bff700000026dd-d5-6528d3f5a10a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	46.98.08788.4F3D8256; Fri, 13 Oct 2023 14:21:56 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231013052155epsmtip2bd156f40dfe3223494264baa72beaf55~NkzrHFejm1638516385epsmtip2B;
	Fri, 13 Oct 2023 05:21:55 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, vincentfu@gmail.com,
	ankit.kumar@samsung.com, joshiiitr@gmail.com, Kanchan Joshi
	<joshi.k@samsung.com>, stable@vger.kernel.org, Vincent Fu
	<vincent.fu@samsung.com>
Subject: [PATCH v4] nvme: fix corruption for passthrough meta/data
Date: Fri, 13 Oct 2023 10:44:58 +0530
Message-Id: <20231013051458.39987-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmpu7XyxqpBhefSFqsufKb3WL13X42
	i5WrjzJZHP3/ls3i/NvDTBaTDl1jtJi/7Cm7xbrX71ksFmx8xGjxuLuD0WJDm6ADt8fOWXfZ
	Pc7f28jicflsqcemVZ1sHpuX1HvsvtnA5tG3ZRWjx+dNcgEcUdk2GamJKalFCql5yfkpmXnp
	tkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBnKimUJeaUAoUCEouLlfTtbIryS0tS
	FTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM7613mcp+KJTMWP5BvYGxp/K
	XYycHBICJhJfzpxj7GLk4hAS2M0o0f/6KhOE84lR4uW2CcwQzjdGiU/zOplgWtZvnAvVspdR
	4tHyrVDOZ0aJNe9BHA4ONgFNiQuTS0EaRARcJBr+vQGrYRY4yyjRvG8VWI2wgJPEot8iIDUs
	AqoSc/6sYwWxeQUsJJZs2MUOsUxeYual7+wQcUGJkzOfsIDYzEDx5q2zwa6TEGjlkPh46yNU
	g4vEwRnbmSFsYYlXx7dAxaUkPr/bywZhJ0tcmnkO6psSicd7DkLZ9hKtp/qZQW5jBrp//S59
	iF18Er2/nzCBhCUEeCU62oQgqhUl7k16ygphi0s8nLEEyvaQ2LH5NtiZQgKxEte6XjFOYJSb
	heSDWUg+mIWwbAEj8ypGydSC4tz01GLTAsO81HJ4XCbn525iBCdQLc8djHcffNA7xMjEwXiI
	UYKDWUmEd3acRqoQb0piZVVqUX58UWlOavEhRlNgsE5klhJNzgem8LySeEMTSwMTMzMzE0tj
	M0Mlcd7XrXNThATSE0tSs1NTC1KLYPqYODilGpi8Ajy6T85z8LNfnHuu00h7+fWap/o5TYdF
	MvvP2eY+yXBY+1rrw9evv7/K7mmNcZVzshGwPGBRq/CE4YK7zmuP69mHO7Xs3IOy/vNbPbPu
	kLzY3LTAsmVLp4AB87nSOytMp3+3ObAkWv3uBEGB90mRXjxfmZwfG29f5rIk5knlTh7DklW8
	5bL3Z5j25hxTUbXZqMvXcXbGReFP+fZBOUvk/zHHCU7eMFmQ23Wv3GyRHLOq179/OpRyOi37
	avx4y9xX7JMXFPzNyb50v+3kw9TUco6FEs2RPB5BLxtbhO/vs/hQeb+v0FpJcIr6vrdab24b
	2a1+XnviX+m3lz3FYQaBExebKl2N6y2v+KKRpcRSnJFoqMVcVJwIAJlzcl8pBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWy7bCSvO6XyxqpBl8fWVqsufKb3WL13X42
	i5WrjzJZHP3/ls3i/NvDTBaTDl1jtJi/7Cm7xbrX71ksFmx8xGjxuLuD0WJDm6ADt8fOWXfZ
	Pc7f28jicflsqcemVZ1sHpuX1HvsvtnA5tG3ZRWjx+dNcgEcUVw2Kak5mWWpRfp2CVwZ31rv
	sxR80amYsXwDewPjT+UuRk4OCQETifUb5zJ2MXJxCAnsZpToPrqVESIhLtF87Qc7hC0ssfLf
	c3aIoo+MEs//LQIq4uBgE9CUuDC5FKRGRMBLYt7sBSwgNcwClxklLs1cxQ5SIyzgJLHotwhI
	DYuAqsScP+tYQWxeAQuJJRt2Qc2Xl5h56Ts7RFxQ4uTMJywgNjNQvHnrbOYJjHyzkKRmIUkt
	YGRaxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHORaWjsY96z6oHeIkYmD8RCjBAez
	kgjv7DiNVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK83173pggJpCeWpGanphakFsFkmTg4pRqY
	grJ21pmsz9/1af5ytvqp2ULi7je19e+FqNscszt33PrOtp+FCu+SnjfKVn2099iRd8PbxfbU
	A9W5j3Usf9VsWH6EvS2zeurzGat+/Nd6IS8Re7d1w87L2+J5zCcecfx1d1ngLsmYSTMiK37W
	P5yy8eWb0hXvkw7Yb9fYd9JCUFRjb/uVJCO2OxWZstLHpixne7b05klT2R9vcm+xTGhIXLyz
	JMnszTGelyIqshH+H2+7qS2Mvutq+PjczfbkZr6if9MtQzS3n1lWZ9Rqx/5d71qvCqfXtylx
	S0X1ds9euH5rA0eAtu/qf/NOhJ9aajlZV0++4vitixd6LDZN/i9231xu45HqW272LwpC5U6I
	JCixFGckGmoxFxUnAgDsCISU4QIAAA==
X-CMS-MailID: 20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_222213_575029_F8DF00EE 
X-CRM114-Status: GOOD (  28.29  )
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

User can specify a smaller meta buffer than what the device is
wired to update/access. Kernel makes a copy of the meta buffer into
which the device does DMA.
As a result, the device overwrites the unrelated kernel memory, causing
random kernel crashes.

Same issue is possible for extended-lba case also. When user specifies a
short unaligned buffer, the kernel makes a copy and uses that for DMA.

Detect these situations and prevent corruption for unprivileged user
passthrough. No change to status-quo for privileged/root user.

Fixes: 63263d60e0f9 ("nvme: Use metadata for passthrough commands")
Cc: stable@vger.kernel.org

Reported-by: Vincent Fu <vincent.fu@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
Changes since v3:
- Block only unprivileged user
- Harden the checks by disallowing everything for which data length
  (nlb) can not be determined
- Separate the bounce buffer checks to a different function
- Factor in CSIs beyond NVM and ZNS

Changes since v2:
- Handle extended-lba case: short unaligned buffer IO
- Reduce the scope of check to only well-known commands
- Do not check early. Move it deeper so that check gets executed less
  often
- Combine two patches into one.

Changes since v1:
- Revise the check to exclude PRACT=1 case

 drivers/nvme/host/ioctl.c | 116 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d8ff796fd5f2..57160ca02e65 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -96,6 +96,76 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
 	return (void __user *)ptrval;
 }
 
+static inline bool nvme_nlb_in_cdw12(struct nvme_ns *ns, u8 opcode)
+{
+	u8 csi = ns->head->ids.csi;
+
+	if (csi != NVME_CSI_NVM && csi != NVME_CSI_ZNS)
+		return false;
+
+	switch (opcode) {
+	case nvme_cmd_read:
+	case nvme_cmd_write:
+	case nvme_cmd_compare:
+	case nvme_cmd_zone_append:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/*
+ * NVMe has no separate field to encode the metadata length expected
+ * (except when using SGLs).
+ *
+ * Because of that we can't allow to transfer arbitrary metadata, as
+ * a metadata buffer that is shorted than what the device expects for
+ * the command will lead to arbitrary kernel (if bounce buffering) or
+ * userspace (if not) memory corruption.
+ *
+ * Check that external metadata is only specified for the few commands
+ * where we know the length based of other fields, and that it fits
+ * the actual data transfer from/to the device.
+ */
+static bool nvme_validate_metadata_len(struct request *req, unsigned meta_len)
+{
+	struct nvme_ns *ns = req->q->queuedata;
+	struct nvme_command *c = nvme_req(req)->cmd;
+	u32 len_by_nlb;
+
+	/* Do not guard admin */
+	if (capable(CAP_SYS_ADMIN))
+		return true;
+
+	/* Block commands that do not have nlb in cdw12 */
+	if (!nvme_nlb_in_cdw12(ns, c->common.opcode)) {
+		dev_err(ns->ctrl->device,
+			"unknown metadata command %c\n", c->common.opcode);
+		return false;
+	}
+
+	/* Skip when PI is inserted or stripped and not transferred */
+	if (ns->ms == ns->pi_size &&
+	    (c->rw.control & cpu_to_le16(NVME_RW_PRINFO_PRACT)))
+		return true;
+
+	if (ns->features & NVME_NS_EXT_LBAS) {
+		dev_err(ns->ctrl->device,
+			"requires extended LBAs for metadata\n");
+		return false;
+	}
+
+	len_by_nlb = (le16_to_cpu(c->rw.length) + 1) * ns->ms;
+	if (meta_len < len_by_nlb) {
+		dev_err(ns->ctrl->device,
+			"metadata length (%u instad of %u) is too small.\n",
+			meta_len, len_by_nlb);
+		return false;
+	}
+
+	return true;
+}
+
 static void *nvme_add_user_metadata(struct request *req, void __user *ubuf,
 		unsigned len, u32 seed)
 {
@@ -104,6 +174,9 @@ static void *nvme_add_user_metadata(struct request *req, void __user *ubuf,
 	void *buf;
 	struct bio *bio = req->bio;
 
+	if (!nvme_validate_metadata_len(req, len))
+		return ERR_PTR(-EINVAL);
+
 	buf = kmalloc(len, GFP_KERNEL);
 	if (!buf)
 		goto out;
@@ -134,6 +207,41 @@ static void *nvme_add_user_metadata(struct request *req, void __user *ubuf,
 	return ERR_PTR(ret);
 }
 
+static bool nvme_validate_buffer_len(struct nvme_ns *ns, struct nvme_command *c,
+				     unsigned meta_len, unsigned data_len)
+{
+	u32 mlen_by_nlb, dlen_by_nlb;
+
+	/* Do not guard admin */
+	if (capable(CAP_SYS_ADMIN))
+		return true;
+
+	/* Block commands that do not have nlb in cdw12 */
+	if (!nvme_nlb_in_cdw12(ns, c->common.opcode)) {
+		dev_err(ns->ctrl->device,
+			"unknown metadata command %c.\n", c->common.opcode);
+		return false;
+	}
+
+	/* When PI is inserted or stripped and not transferred.*/
+	if (ns->ms == ns->pi_size &&
+	    (c->rw.control & cpu_to_le16(NVME_RW_PRINFO_PRACT)))
+		mlen_by_nlb = 0;
+	else
+		mlen_by_nlb = (le16_to_cpu(c->rw.length) + 1) * ns->ms;
+
+	dlen_by_nlb = (le16_to_cpu(c->rw.length) + 1) << ns->lba_shift;
+
+	if (data_len < (dlen_by_nlb + mlen_by_nlb)) {
+		dev_err(ns->ctrl->device,
+			"buffer length (%u instad of %u) is too small.\n",
+			data_len, dlen_by_nlb + mlen_by_nlb);
+		return false;
+	}
+
+	return true;
+}
+
 static int nvme_finish_user_metadata(struct request *req, void __user *ubuf,
 		void *meta, unsigned len, int ret)
 {
@@ -202,6 +310,14 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		}
 		*metap = meta;
 	}
+	/* Guard for a short bounce buffer */
+	if (bio->bi_private) {
+		if (!nvme_validate_buffer_len(ns, nvme_req(req)->cmd,
+					      meta_len, bufflen)) {
+			ret = -EINVAL;
+			goto out_unmap;
+		}
+	}
 
 	return ret;
 
-- 
2.25.1


