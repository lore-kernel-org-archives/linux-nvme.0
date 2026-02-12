Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806BCEE36A7
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Feb 2026 16:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=npjI/hT5PYqcg+P0htyRpfMyqtv5byyZktOZ/apFN4o=; b=Zq0o29JCg+Weuwfytm5BBvkbgA
	ceMelGEKhg/9XDmZ9uWe57sKfseFHqKmTu5+Ohq4aDi6qieVUGy/AdcumkBy883P6TCeWw/D8WqfS
	OAoaLq63LDBRXDWl1P5HZxnAiYzE2sjAFjXQt+8JLjmBU81kL1kYPlpxeC5jRQ6wBD46hJaRwZ+an
	4DQLsdQgJsr7Q1m0SF6mF+4lwyfmZfiOE4aoAdHLpkN3WywG5JsoufJ1Ii7r8+JLc1nBxapucY5xt
	jBYARHC3nlo9FrSHRyNLusk/PWhGBjTGq8ro8IlyqH+IJWv83s1vF2OCFBkIjr9ol3azD8y/jgeAM
	W5GCHx2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqZr9-00000002O0G-3HVt;
	Thu, 12 Feb 2026 16:47:55 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqZr6-00000002Nxo-15ui
	for linux-nvme@lists.infradead.org;
	Thu, 12 Feb 2026 16:47:54 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CAdmMJ3388110
	for <linux-nvme@lists.infradead.org>; Thu, 12 Feb 2026 08:47:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=npjI/hT5PYqcg+P0htyRpfMyqtv5byyZktOZ/apFN4o=; b=sif3x2CEu0Jx
	QWqvJ/apRBUmz6Lwo5QcnkNJKMWuetxccJQlnIbc1y8tAEMa0YyMNXOSy9SgAv4T
	fW02lcpVOipbuKZyz/Dgo4QKBwxaHT055X7lvvTQtV/cdJSXjoYcZrc4Z/tFg6Us
	T1d5GMBrUP35Drd88n4BnlxcQAYvtTTuB+9iN/tbHi9xz9ELrINl/RRi36w0iShM
	+owdU4TD/H5WsbVoEFB3eRqwK7B1OAOOz+w6v3pAz9lw12AfKCsh02b/TzfLkyis
	1i9ItFzVp+jZhMUKvY2WD5jCVKDpNSRdpX7sW8RIz4e4dN+r3eT7/NWEQfeQjwSj
	BQJv91D6SQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c9da7khdn-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 12 Feb 2026 08:47:50 -0800 (PST)
Received: from twshared13080.31.frc3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 12 Feb 2026 16:47:47 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id E26BD7A6B564; Thu, 12 Feb 2026 08:47:35 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 3/3] nvme-pci: do not try to add queue maps at runtime
Date: Thu, 12 Feb 2026 08:47:33 -0800
Message-ID: <20260212164733.3006071-4-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212164733.3006071-1-kbusch@meta.com>
References: <20260212164733.3006071-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEyOCBTYWx0ZWRfXxaEdSiWomCbi
 TgqofwOdiXIUBlshnfixEnwVfvrrPhoX2ufF1AaQnhMVLrtngkgLoC7w47ykFy/NLtVTh3YNYb0
 Tf8y5F17zAHXDBnJXXfQs4FV0OsxfRlNHOKUvT5uba+wLvsldYnCCTSJ0wylN8ffd8VP5nnULsR
 GQoq1ka2kdqut0Hd8+O4iSYRgWsDpXH9YCSc6JDaeYmwc3D7QdC+KQ1K3t2j1gxKPtOo1C7wYXF
 KebfUK6EREyi+dD6sTLgzrod5gWrXGb6K+Cm7CsBkT+fPE0x0VcMpnHxjAN0YRoqa0ZLyZUUyad
 ghKUgEvFwcSJcgidPxpt+aPGOk3OOFzykoreJy4jMVK15+ETmMfjgDOaYeI66wPBHnM/PON6C7S
 o6mw+65IuJME3HsHQYBU/6VJNw9Q2oe1DFB0+sPMObaPEBWtbUMh3qq7LS8x2dDXTeG+hFPjzRE
 G816JXj4uKTo43FKLrg==
X-Authority-Analysis: v=2.4 cv=ddmNHHXe c=1 sm=1 tr=0 ts=698e0436 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=3PqamS-XlMzQfuyNXKMA:9
X-Proofpoint-ORIG-GUID: memTKHeNvmVVjgAx7VbqdX-9ji0FJUQ2
X-Proofpoint-GUID: memTKHeNvmVVjgAx7VbqdX-9ji0FJUQ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_084752_423227_E2F6703F 
X-CRM114-Status: GOOD (  12.46  )
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

The block layer allocates the set's maps once. We can't add special
purpose queues at runtime if they weren't allocated at initialization
time.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c63efa49132f9..0c1a8d7aa1c0b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2902,6 +2902,18 @@ static int nvme_setup_io_queues(struct nvme_dev *d=
ev)
 	dev->nr_write_queues =3D write_queues;
 	dev->nr_poll_queues =3D poll_queues;
=20
+	if (dev->ctrl.tagset) {
+		/*
+		 * The set's maps are allocated only once at initialization
+		 * time. We can't add special queues later if their mq_map
+		 * wasn't preallocated.
+		 */
+		if (dev->ctrl.tagset->nr_maps < 3)
+			dev->nr_poll_queues =3D 0;
+		if (dev->ctrl.tagset->nr_maps < 2)
+			dev->nr_write_queues =3D 0;
+	}
+
 	/*
 	 * The initial number of allocated queue slots may be too large if the
 	 * user reduced the special queue parameters. Cap the value to the
--=20
2.47.3


