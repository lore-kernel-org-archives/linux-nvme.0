Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D64C32771
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Sep 2022 15:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dylKzOs2G033RxAwH4HglXfKC3uER1GzyRkQaYWKytM=; b=EOCNo0TTSATw+XRx/gfvVMcuSI
	TTPvWDHQort/BhhZV2OPQTj1Xq0TsqxbmSuYewQgcFzTGnoZAqtlIYfPA3+GtTF7odF7erL4zyvbO
	w1PA1/+csWyTf/w7CpazexdlQmEqVotQIfkDz4XIM2l/Itt2rN5fekTnvYXdp/BLDZz+Wv0MTgp/9
	x9xqd9/84vxNeTTVbBuA7yYA3v4wPwtxZOA4nfbXsIHNGs5WhJuzuU3kLuLpeh0GII2Yysiyp9oci
	ejHap9IXMHEbdxL/sk1+d4STHYSb0TBUdgQzjzWJxJTyKbR3IKVFr0ZpY6eH5xLv8r6yvoBEY8ZTr
	IrSUXEKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpfK-005YuV-Bv; Mon, 26 Sep 2022 15:05:02 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpfB-005Yr2-82
	for linux-nvme@lists.infradead.org; Mon, 26 Sep 2022 15:04:59 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220926150442epoutp036ec280d00a6ffc3ee7f9b04b00e4ce1c~YcVdJST5P1824818248epoutp03I
	for <linux-nvme@lists.infradead.org>; Mon, 26 Sep 2022 15:04:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220926150442epoutp036ec280d00a6ffc3ee7f9b04b00e4ce1c~YcVdJST5P1824818248epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664204682;
	bh=dylKzOs2G033RxAwH4HglXfKC3uER1GzyRkQaYWKytM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E+mOkRsZ0e7+tlp/4txLbeLtX9vufJrWimViMBJuHiiXoStd9XgRnXu4IRVE034NF
	 2u2WdbZjiQZePWFdAyGRKLacTd6ql5emrOs9sp/l7bVnyY8monuteqwC8NsCmFt4rE
	 uj/acpXYcgFOfn7Fp+24Kw/ldAjqUpIiJTAhjcRg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20220926150441epcas5p4663c9d41d72e62b46646e715a23ded6a~YcVc3mTnG2423624236epcas5p4v;
	Mon, 26 Sep 2022 15:04:41 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4MbmJ76Kwjz4x9Pv; Mon, 26 Sep
	2022 15:04:39 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	30.D5.39477.78FB1336; Tue, 27 Sep 2022 00:04:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20220926150439epcas5p160506693c35f94eec80f26e34027988f~YcVawi1mZ2723327233epcas5p1l;
	Mon, 26 Sep 2022 15:04:39 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220926150439epsmtrp13f26b9a86618d3295ffc5648075678a2~YcVav309Y0808308083epsmtrp1n;
	Mon, 26 Sep 2022 15:04:39 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-25-6331bf87a371
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	DE.4C.18644.78FB1336; Tue, 27 Sep 2022 00:04:39 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220926150438epsmtip29e72941506c59e8456838af9ef25ea0e~YcVZeLYee2383623836epsmtip2K;
	Mon, 26 Sep 2022 15:04:37 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH for-next 1/2] nvme: add the permission-policy for command
 control
Date: Mon, 26 Sep 2022 20:24:29 +0530
Message-Id: <20220926145430.81658-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926145430.81658-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTU7d9v2GyweWTuhar7/azWdw8sJPJ
	YuXqo0wWR/+/ZbOYdOgao8X8ZU/ZLda9fs/iwO5x/t5GFo/LZ0s9Nq3qZPPYvKTeY/fNBjaP
	vi2rGAPYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0y
	c4BOUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoY
	GJkCFSZkZ0zb/J6pYB9/xd2O2WwNjFd5uhg5OSQETCSetF9h7GLk4hAS2M0oseBOJzOE84lR
	on/7MajMZ0aJg/uXscG0fDh9HMwWEtjFKNHXBGUDFTV/U+pi5OBgE9CUuDC5FCQsIuAi8bnn
	AiuIzSwQL3Hz72awcmGBYIkZrU2MIDaLgKrEpjmLwGxeAQuJCXe3MEKskpeYeek7O4jNKWAp
	sWTFIVaIGkGJkzOfsEDMlJdo3job7GgJgY/sEuefzIVqdpG4MKmJGcIWlnh1fAs7hC0l8bK/
	DcpOlrg08xwThF0i8XjPQSjbXqL1VD8zyC/MQL+s36UPsYtPovf3EyaQsIQAr0RHmxBEtaLE
	vUlPWSFscYmHM5ZA2R4SK/ZfZIcEYQ+jxOHPK1gnMMrPQvLCLCQvzELYtoCReRWjZGpBcW56
	arFpgVFeajk8WpPzczcxgtOjltcOxocPPugdYmTiYDzEKMHBrCTCm3JRN1mINyWxsiq1KD++
	qDQntfgQoykwjCcyS4km5wMTdF5JvKGJpYGJmZmZiaWxmaGSOO/iGVrJQgLpiSWp2ampBalF
	MH1MHJxSDUxRHAXlUhPOvnzG4r9Xe5Ls7j8/99btmCi/Le7x09u3xL32dXQ9tvd2sD//58Pk
	k4XFm60ucc684XX0xLfS2tim52oGwQm2qj4KKx5s5/zz+4LINyuXO/O+z9677NL/69/eaPV9
	5a4qETixmZVpwsTQa1f3pu5m27LNhism+//e/xtXiX75vDR18Q7DXXu3Oj8Rnh2Z8d9R4Pul
	A/ZtYvwNeUsmZ1yr/lLoOHHCowUtD7gFTnFu3vAlrCg/5XbLO4fpd9vidkpzSn+IPHP1msDz
	BwcmL0757x1lduzRPZkXeuUnfwSIKegmT0pYasC/i7ln9c7oHz/kXiz7nb81/6dc48QHvnWv
	3eQKIme6HpL+OkuJpTgj0VCLuag4EQBdlt/CGAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvG77fsNkg85Fwhar7/azWdw8sJPJ
	YuXqo0wWR/+/ZbOYdOgao8X8ZU/ZLda9fs/iwO5x/t5GFo/LZ0s9Nq3qZPPYvKTeY/fNBjaP
	vi2rGAPYorhsUlJzMstSi/TtErgypm1+z1Swj7/ibsdstgbGqzxdjJwcEgImEh9OH2frYuTi
	EBLYwSjx5dINNoiEuETztR/sELawxMp/z9khij4ySpw/eIuli5GDg01AU+LC5FKQGhEBL4nb
	L58zg9jMAokS748+ZgWxhQUCJa40LQSbySKgKrFpziJGEJtXwEJiwt0tjBDz5SVmXvoOtotT
	wFJiyYpDYL1CQDUvL9xkhagXlDg58wkLxHx5ieats5knMArMQpKahSS1gJFpFaNkakFxbnpu
	sWGBUV5quV5xYm5xaV66XnJ+7iZGcHBrae1g3LPqg94hRiYOxkOMEhzMSiK8KRd1k4V4UxIr
	q1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpg2sW/4XbPzL5jYbmJ
	v2w6wwqOFgs03ttyNMuyyfDfPIfu/SGSXCtbnEXYNLPtxF+Waq9df3qyuX7Ouk8Nd0XXep7W
	eNuwzfBV84SbH3d+SDp7RlU0s+zF2quBC8pnBW1/vbuIR40jRzfS4a20xQbbkEjXiXXat7TM
	3mbOXBdTc5h5ufTkrmsrVodO+mjaLe43edOXmo/5m359N/rb7fm4Z32Ng6pC8Vyx9PLLqt2f
	uuZq+vze+1zEUe9S7PQXOs56/94smrd8XyD3ujOuCifcuRYJGE3V2q93+Xay6ddHn3Taujjq
	eTPde9Refl0ccTLWl4ODt+1fx6pln+8bvul92bGO30RbXehH6lGjW22GSizFGYmGWsxFxYkA
	xn0tY90CAAA=
X-CMS-MailID: 20220926150439epcas5p160506693c35f94eec80f26e34027988f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220926150439epcas5p160506693c35f94eec80f26e34027988f
References: <20220926145430.81658-1-joshi.k@samsung.com>
	<CGME20220926150439epcas5p160506693c35f94eec80f26e34027988f@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_080453_778651_D1FED6C5 
X-CRM114-Status: GOOD (  16.25  )
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

If CAP_SYS_ADMIN is present, nothing else is checked as before.
Otherwise takes the decision to allow the command based on following
rules:
- any admin-cmd is not allowed
- vendor-specific and fabric commmand are not allowed
- io-commands that can write are allowed if matching FMODE_WRITE
permission is present
- io-commands that read are allowed

Add a helper nvme_cmd_allowed that implements above policy. This is a prep
patch.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 19 +++++++++++++++++++
 include/linux/nvme.h      |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 548aca8b5b9f..6ca6477dd899 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -20,6 +20,25 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
 	return (void __user *)ptrval;
 }
 
+bool nvme_cmd_allowed(struct nvme_ns *ns, u8 opcode, fmode_t mode)
+{
+	/* root can do anything */
+	if (capable(CAP_SYS_ADMIN))
+		return true;
+	/* admin commands are not allowed */
+	if (ns == NULL)
+		return false;
+	/* exclude vendor-specific io and fabrics commands */
+	if (opcode >= nvme_cmd_vendor_start ||
+			opcode== nvme_fabrics_command)
+		return false;
+	/* allow write cmds only if matching FMODE is present */
+	if (opcode & 1)
+		return mode & FMODE_WRITE;
+	/* allow read cmds */
+	return true;
+}
+
 static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 		unsigned len, u32 seed, bool write)
 {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index ae53d74f3696..8396eb7ecb68 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -797,6 +797,7 @@ enum nvme_opcode {
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
+	nvme_cmd_vendor_start	= 0x80,
 };
 
 #define nvme_opcode_name(opcode)	{ opcode, #opcode }
-- 
2.25.1


