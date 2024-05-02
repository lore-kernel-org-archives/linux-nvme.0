Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D15C4345F
	for <linux-nvme@archiver.kernel.org>; Thu,  2 May 2024 06:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5yvzRUi4kT07sESTxQmM+T2+pb5jLhgO3q51FsVcYGQ=; b=YMKTO/4C+npEmbRrp6N2VpVGUR
	sPbGtzJ2WI4SYWEJ15vldaeSWmnfewNg0wLG+xE+oELZYlClAsoTNH7iNS0FUt2s8Is5KSphyL79H
	f07OC+Y1fvJDOWv92eiSeAxat0cKwO4+0iZOGVYSJFIXJMeqham+npfZAK/QT4PAXK4bvX6qfyQbU
	016nWHWhXFnYhZ9JB84MMuB9eVbIWb2KZFbSNEJOMlGKMRm3ROQFdaEKEsawGnBgkiYycIb4Thzhs
	3LmnNTpENRCn0epooZvGdbDKnOEwu6NMudxC759LHHpf3tk9emT67Wv2WjTXHegU46BIG8qRzNBkF
	9zJqpZQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2Q96-0000000BgHG-3Kcs;
	Thu, 02 May 2024 06:42:20 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2Q93-0000000BgEb-0axm
	for linux-nvme@lists.infradead.org;
	Thu, 02 May 2024 06:42:19 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240502064153epoutp032b8851292960e1a56a5fb78669d48869~LmNKmySPW1711617116epoutp038
	for <linux-nvme@lists.infradead.org>; Thu,  2 May 2024 06:41:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240502064153epoutp032b8851292960e1a56a5fb78669d48869~LmNKmySPW1711617116epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714632113;
	bh=5yvzRUi4kT07sESTxQmM+T2+pb5jLhgO3q51FsVcYGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLVhJYtCmW04Bjl2wIAM6HL2liyA3FSAQ39WLcKmSVmysQr+PKN1B3rozzHhYb21Q
	 7Cw7UdjKMyCbAaIhZU0QuK3jcg5OySLBAJ09fOPJ7LOkm438ssD8TWhWh1AYUIavoG
	 +M5mmEFfIwDHAErYf6YupymEI87v0+LEBH3y5lb8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240502064153epcas5p472482ecfd6f388977bb5d3be88d79760~LmNKYJHVW0689306893epcas5p4u;
	Thu,  2 May 2024 06:41:53 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VVPVR4KPNz4x9QB; Thu,  2 May
	2024 06:41:51 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4B.65.09665.FA533366; Thu,  2 May 2024 15:41:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240502064151epcas5p3834c50bcaea2c8db2d24fc30b0957ff0~LmNIbQ7Ed0237302373epcas5p36;
	Thu,  2 May 2024 06:41:51 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240502064151epsmtrp142725e2eba9a07890fc355fb81735ae9~LmNIaoioe1132611326epsmtrp1Z;
	Thu,  2 May 2024 06:41:51 +0000 (GMT)
X-AuditID: b6c32a4b-5cdff700000025c1-57-663335affd83
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	09.90.07541.FA533366; Thu,  2 May 2024 15:41:51 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240502064150epsmtip1db6e19ce2f8e70f362374b98aa42fe1a~LmNHh2LKG2095420954epsmtip1D;
	Thu,  2 May 2024 06:41:50 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 2/2] nvme: reduce a repeated ZNS check
Date: Thu,  2 May 2024 12:04:38 +0530
Message-Id: <20240502063438.422046-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240502063438.422046-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmhu56U+M0g9WzlSxWrj7KZHH0/1s2
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8+rasYgxgjcq2yUhNTEkt
	UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
	VtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzjg29xZzwQ+u
	ioMX1jE2MP7h6GLk5JAQMJHY+PEUexcjF4eQwG5GiU+3HkM5nxglbixZDOV8Y5R4+fAtE0zL
	9wXbWSESexklFq9YxgThfGaUaPkwDaiFg4NNQFPiwuRSkAYRAWOJzpUNLCA2s4C7xO0nPWCD
	hAXMJHoufGcDsVkEVCXar/1hB7F5BSwl2t/sYoNYJi8x89J3sDingJXE8jt/mCBqBCVOznwC
	NVNeonnrbGaQGyQE7rFLzL62nxmi2UXi5spmqKuFJV4d38IOYUtJvOxvg7KTJS7NPAdVUyLx
	eM9BKNteovVUPzPIL8xAv6zfpQ+xi0+i9/cTJpCwhACvREebEES1osS9SU9ZIWxxiYczlkDZ
	HhJHF1yABk8vo8SFw22MExjlZyF5YRaSF2YhbFvAyLyKUTK1oDg3PbXYtMA4L7UcHrHJ+bmb
	GMFpUMt7B+OjBx/0DjEycTAeYpTgYFYS4Z2yUD9NiDclsbIqtSg/vqg0J7X4EKMpMIwnMkuJ
	JucDE3FeSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWpRTB9TBycUg1MJRuM7uWr
	ZRtGTUq2W8DAqr7o7Unn5P1FPQsyJ6m6r05/osdSs2+ThIGkqJ1wYbL4k/hG+T2p7f8YQlRr
	uoT9Txc4a04WDIiq2XgwM++eRopTzWqPohVv/58uvBf7Z9+3VheePM6g3/kPvnVWKs0R+XFO
	R9bX7uYEp/nsl64FTStMV5G8Ptl83q/c/HcKtWweeyZwNQTbP3uSUK9noNkTb6xV8NnbYtGJ
	+e8+u3r1X8x76aq8r/HY+WPnKwJ07vSfTmrl0AnJqj9wRqi5RcvYeRnvlKJFXS4Hj9Q8Yr8t
	cj7G81WTlNmF9b//htr0MBV0JO2R3dj/ZJq/95IXp1V5niwU3q/pofZq29lvNUosxRmJhlrM
	RcWJADdkDR8MBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSnO56U+M0gy33eCxWrj7KZHH0/1s2
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8+rasYgxgjeKySUnNySxL
	LdK3S+DKODb3FnPBD66KgxfWMTYw/uHoYuTkkBAwkfi+YDtrFyMXh5DAbkaJ6d/uMEEkxCWa
	r/1gh7CFJVb+e84OUfSRUeLbgXUsXYwcHGwCmhIXJpeC1IgImEvsu/CcFSTMLOApsX6iPEhY
	WMBMoufCdzYQm0VAVaL92h+wkbwClhLtb3axQYyXl5h56TtYnFPASmL5nT9gJwgB1bzoX8oK
	US8ocXLmExYQmxmovnnrbOYJjAKzkKRmIUktYGRaxSiZWlCcm56bbFhgmJdarlecmFtcmpeu
	l5yfu4kRHL5aGjsY783/p3eIkYmD8RCjBAezkgjvlIX6aUK8KYmVValF+fFFpTmpxYcYpTlY
	lMR5DWfMThESSE8sSc1OTS1ILYLJMnFwSjUwdfm/LRUUC6yPDl988eaWLzbrl6pbxDXnqB75
	fYjXeoU++ybdDwszSmR1Qt+HXn/F/dG4pte3c/Wlcy95D35UY/xy0Wvt+ZZr513OfGzpn7T5
	l/eDvjqFspgCU2lz1ilrFij6S17M27z7vJbU6Ute6Wl5QisMC7de7araF9z29+Rnx6ZQnR+X
	NaJ5Vqh6XE6vvjuDJadvjvusc+84JjzJvXST8dJfyRfCVxKk5laFv/58X+iL854Jse8zQg3t
	GWoZfzzfYss085FxyamDCedPTLl11uK/4+XL75ybz0SsOVKeWXCmfcuuLxteLtTRSmBUWubq
	tHr52qsqv27IVL9YfcNh21VFgVumUkwVx5tu2CuxFGckGmoxFxUnAgCPolo7zgIAAA==
X-CMS-MailID: 20240502064151epcas5p3834c50bcaea2c8db2d24fc30b0957ff0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240502064151epcas5p3834c50bcaea2c8db2d24fc30b0957ff0
References: <20240502063438.422046-1-joshi.k@samsung.com>
	<CGME20240502064151epcas5p3834c50bcaea2c8db2d24fc30b0957ff0@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240501_234218_028450_8CCB8F91 
X-CRM114-Status: GOOD (  14.39  )
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

Modify nvme_update_ns_info_block() to eliminate the repeated check for
ZNS.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8ae0a2dc5eda..7f4df3932ca4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2081,6 +2081,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	sector_t capacity;
 	unsigned lbaf;
 	int ret;
+	bool is_zns;
 
 	ret = nvme_identify_ns(ns->ctrl, info->nsid, &id);
 	if (ret)
@@ -2100,8 +2101,9 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 			goto out;
 	}
 
-	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-	    ns->head->ids.csi == NVME_CSI_ZNS) {
+	is_zns = IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
+		 ns->head->ids.csi == NVME_CSI_ZNS;
+	if (is_zns) {
 		ret = nvme_query_zone_info(ns, lbaf, &zi);
 		if (ret < 0)
 			goto out;
@@ -2119,8 +2121,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (!nvme_update_disk_info(ns, id, &lim))
 		capacity = 0;
 	nvme_config_discard(ns, &lim);
-	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-	    ns->head->ids.csi == NVME_CSI_ZNS)
+	if (is_zns)
 		nvme_update_zone_info(ns, &lim, &zi);
 	ret = queue_limits_commit_update(ns->disk->queue, &lim);
 	if (ret) {
-- 
2.25.1


