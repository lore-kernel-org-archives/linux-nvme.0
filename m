Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166F0C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 20:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yZwAcMb7nvm5kT10B/5We7Ift1xV1Z3biqKS4IGAik0=; b=GfQEj4tZffgPea8Bz2h7MyFsZ/
	vaHyvs604V5zQwfxzwA6/9d7n8u9GzOPl+uB8tw6qJ62aDT7vPBY7iuPlrdPF8qpKsHtdFMLgAYqZ
	Mc6f0FP5mWb2flQoDb3SMTVb9x29DF/gr9871WnxZ1iM2ZAICbnc2Hz5xhdeKURRmnvMt0Wv+3Dgm
	BAsjK7LdzOJzXfNYVBZearA92SN29AFgvZdYiVQcyOGKfjXEQdAwxWl3loxHWX5vvvgTyN40X7hdJ
	Z6FQBVA63wuZ/A9kdTDOGFim9HtTy83a+wu4WJB9XmeljTh+5HIICkA5bcEXxINp5A9YsxvE/bYxf
	/s/HlzBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzl3D-009ftA-Gt; Fri, 10 Jun 2022 20:16:11 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzl39-009frl-Tw
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 20:16:09 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25AIDwCC029035
	for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 13:16:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=yZwAcMb7nvm5kT10B/5We7Ift1xV1Z3biqKS4IGAik0=;
 b=R1g4AndrsLF0QN5ADX8A51Nc86xdhtJWrXWSICpv58MHs4FJ4rRl9lDMKKRNDK3u5/g8
 RyQJ4p5LYyvkLfT6lda5QSJJbesVsDGaGDDv5rl8qWo+NK5EnJxUDkgAG5YG1gPkayg7
 mq7ojV2cfpDedZF7Evugh7ygJd47cGu7S2U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gmb208pds-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 13:16:06 -0700
Received: from twshared18317.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 13:16:04 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 1FEAC4E9D6A8; Fri, 10 Jun 2022 12:58:31 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch
	<kbusch@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCHv6 08/11] iov: introduce iov_iter_aligned
Date: Fri, 10 Jun 2022 12:58:27 -0700
Message-ID: <20220610195830.3574005-9-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220610195830.3574005-1-kbusch@fb.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 34l6K8XyHTo-roZ1PWv3p73o5Z4FvSiZ
X-Proofpoint-ORIG-GUID: 34l6K8XyHTo-roZ1PWv3p73o5Z4FvSiZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_08,2022-06-09_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_131608_126867_A0161BC1 
X-CRM114-Status: GOOD (  19.03  )
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

The existing iov_iter_alignment() function returns the logical OR of
address and length. For cases where address and length need to be
considered separately, introduce a helper function that a caller can
specificy length and address masks that indicate if the iov is
unaligned.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/uio.h |  2 +
 lib/iov_iter.c      | 92 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 739285fe5a2f..34ba4a731179 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -219,6 +219,8 @@ size_t _copy_mc_to_iter(const void *addr, size_t byte=
s, struct iov_iter *i);
 #endif
=20
 size_t iov_iter_zero(size_t bytes, struct iov_iter *);
+bool iov_iter_is_aligned(const struct iov_iter *i, unsigned addr_mask,
+			unsigned len_mask);
 unsigned long iov_iter_alignment(const struct iov_iter *i);
 unsigned long iov_iter_gap_alignment(const struct iov_iter *i);
 void iov_iter_init(struct iov_iter *i, unsigned int direction, const str=
uct iovec *iov,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6dd5330f7a99..a39b24496878 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1268,6 +1268,98 @@ void iov_iter_discard(struct iov_iter *i, unsigned=
 int direction, size_t count)
 }
 EXPORT_SYMBOL(iov_iter_discard);
=20
+static bool iov_iter_aligned_iovec(const struct iov_iter *i, unsigned ad=
dr_mask,
+				   unsigned len_mask)
+{
+	size_t size =3D i->count;
+	size_t skip =3D i->iov_offset;
+	unsigned k;
+
+	for (k =3D 0; k < i->nr_segs; k++, skip =3D 0) {
+		size_t len =3D i->iov[k].iov_len - skip;
+
+		if (len > size)
+			len =3D size;
+		if (len & len_mask)
+			return false;
+		if ((unsigned long)(i->iov[k].iov_base + skip) & addr_mask)
+			return false;
+
+		size -=3D len;
+		if (!size)
+			break;
+	}
+	return true;
+}
+
+static bool iov_iter_aligned_bvec(const struct iov_iter *i, unsigned add=
r_mask,
+				  unsigned len_mask)
+{
+	size_t size =3D i->count;
+	unsigned skip =3D i->iov_offset;
+	unsigned k;
+
+	for (k =3D 0; k < i->nr_segs; k++, skip =3D 0) {
+		size_t len =3D i->bvec[k].bv_len - skip;
+
+		if (len > size)
+			len =3D size;
+		if (len & len_mask)
+			return false;
+		if ((unsigned long)(i->bvec[k].bv_offset + skip) & addr_mask)
+			return false;
+
+		size -=3D len;
+		if (!size)
+			break;
+	}
+	return true;
+}
+
+/**
+ * iov_iter_is_aligned() - Check if the addresses and lengths of each se=
gments
+ * 	are aligned to the parameters.
+ *
+ * @i: &struct iov_iter to restore
+ * @addr_mask: bit mask to check against the iov element's addresses
+ * @len_mask: bit mask to check against the iov element's lengths
+ *
+ * Return: false if any addresses or lengths intersect with the provided=
 masks
+ */
+bool iov_iter_is_aligned(const struct iov_iter *i, unsigned addr_mask,
+			 unsigned len_mask)
+{
+	if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i)))
+		return iov_iter_aligned_iovec(i, addr_mask, len_mask);
+
+	if (iov_iter_is_bvec(i))
+		return iov_iter_aligned_bvec(i, addr_mask, len_mask);
+
+	if (iov_iter_is_pipe(i)) {
+		unsigned int p_mask =3D i->pipe->ring_size - 1;
+		size_t size =3D i->count;
+
+		if (size & len_mask)
+			return false;
+		if (size && allocated(&i->pipe->bufs[i->head & p_mask])) {
+			if (i->iov_offset & addr_mask)
+				return false;
+		}
+
+		return true;
+	}
+
+	if (iov_iter_is_xarray(i)) {
+		if (i->count & len_mask)
+			return false;
+		if ((i->xarray_start + i->iov_offset) & addr_mask)
+			return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(iov_iter_is_aligned);
+
 static unsigned long iov_iter_alignment_iovec(const struct iov_iter *i)
 {
 	unsigned long res =3D 0;
--=20
2.30.2


