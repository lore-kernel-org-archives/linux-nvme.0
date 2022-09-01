Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE86ECAAD4
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 00:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:CC:To:From:Subject:
	Mime-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=ArRzi/HQUaHkCfhJYBQkVmRhBXhrtrwh+XW/veC3mG4=; b=2mY9fllXUi11lVzsQRdxnXNGBV
	jN1H4lojaXyh3KzUnf+X2veQfFG5L6OBqCYh/jESQ1Tr23xN7ATraTrslCXLgL6eRQIYn7MCs8Lp9
	zUAn71L+X023MQTxTtQxPrJnQPHTjpyL8MdrGiz2Ktrvdp26NJ5ofa4kDhjKli3SD0/jnXZ3eRScR
	oUMzFNSuN24EW4yLZSKO4w13p0g1SuDgjxU6/bNdQsqD9NQYtuc1LSBMhfBtaaaJ6YU8ga/CmsGti
	hG0vd6gUmxKPW6DIlSTCQP6xSqwSuGRyAg90peO1EbizPE9MbsyHcaKeXtEFFclY8dwKrM/YB7jfu
	ntLtRKlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTY4P-008n26-PU; Thu, 01 Sep 2022 00:28:33 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTY4L-008n14-Qh
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 00:28:31 +0000
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220901002817epoutp03d14e3cf8d0d7af1c7620aa9fbeccfa4a~QlQHKTn5R1522315223epoutp03N
	for <linux-nvme@lists.infradead.org>; Thu,  1 Sep 2022 00:28:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220901002817epoutp03d14e3cf8d0d7af1c7620aa9fbeccfa4a~QlQHKTn5R1522315223epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1661992097;
	bh=ArRzi/HQUaHkCfhJYBQkVmRhBXhrtrwh+XW/veC3mG4=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=Mu2418+AQl2EMjglZvCrcgKgo0LYQDgMdiP6k3rGIJTtJVmuIxSAqTWFyZLr/XH/Q
	 4E5cJqU3Unuy01Ud2c2w0tRsGea/zKHuahEVHqeDNXK4kiHRHz3Nx04hqMxiR5oIHO
	 siXUqOFMQ7q6+TncOq8D1nktZ61YYy8VuQqYHDW4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20220901002816epcas2p358e8e500eefb7d431c0d0956250b2b71~QlQGP9ezl0583105831epcas2p3T;
	Thu,  1 Sep 2022 00:28:16 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4MJ22R6XG3z4x9Pt; Thu,  1 Sep
	2022 00:28:15 +0000 (GMT)
X-AuditID: b6c32a47-465ff70000003d30-5f-630ffc9f179c
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	8A.66.15664.F9CFF036; Thu,  1 Sep 2022 09:28:15 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] drivers/nvme/host: Fix namespace duplication check rule
From: Sungup Moon <sungup.moon@samsung.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sungup Moon
	<sungup.moon@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220901002815epcms2p6ae137d9de49bef5764f19c0fa7f3536e@epcms2p6>
Date: Thu, 01 Sep 2022 09:28:15 +0900
X-CMS-MailID: 20220901002815epcms2p6ae137d9de49bef5764f19c0fa7f3536e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmhe78P/zJBu+/GVn0b+lisfi/5xib
	xdSbWxkt5h96x2qxcvVRJovHk5qYLKYeVbeYdOgao8XlXXPYLOYve8puse71exaLi0e7WS3u
	fnrJatG97Q+jxdFDU9kd+D0mNr9j9zh/byOLx6ZVnWwem5fUe+y+2cDm0bdlFaPH501yAexR
	2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QGcrKZQl
	5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz
	9sz+z1KwSrhixaUtLA2Mz/i7GDk5JARMJL7MmsrUxcjFISSwg1Hi75yzQA4HB6+AoMTfHcIg
	NcICHhIvgb4FsYUEFCX+PutjhIjrSqz5P4UZxGYT0Ja4d+Yt2BwRgT5Gib7v51lBHGaB9YwS
	ty4sY4bYxisxo/0pC4QtLbF9+VZGCFtD4seyXqgaUYmbq9+yw9jvj82HqhGRaL13FqpGUOLB
	z91QcUmJpyc/QMXzJdp+L2IDWSwh0MEocf7hESaIhLnEn5fXwYbyCvhKrL35AOwIFgFVia75
	a6EOcpE4fOEl2FBmAXmJ7W/nMINCgllAU2L9Ln0QU0JAWeLILRaICj6JjsN/2WHe2jHvCdQm
	VYmLE3rYYF5cOa+BEaLVQ+LeWSNIGAZKrJ3Rxj6BUWEWIqRnIVk7C2HtAkbmVYxiqQXFuemp
	xUYFxvDITc7P3cQITsFa7jsYZ7z9oHeIkYmD8RCjBAezkgjv93M8yUK8KYmVValF+fFFpTmp
	xYcYTYEensgsJZqcD8wCeSXxhiaWBiZmZobmRqYG5krivC7ajMlCAumJJanZqakFqUUwfUwc
	nFINTF1fH0/7sMliU+08rukO89g79rxWlF25ZNPaS04i2VafTOexum7JP1o5S8tPOMPib8bT
	4G+/NpromC04c+tLx9G+afOt3e3+rV5UrmX9tOFUesDRBetL7skHsbErzXxgeiFncl5j55ws
	Tn6dPIeALcvcHAQue1xOmGiU9KHlOvOjQ8+3rJCOK5mafXr5sr2as0Vebf1519Kt7EX62/rq
	sF3TLyaKlx/P6cyw/52lpfg6zch9o1Z+jcLy6EAvvspF2b+9jii2Hb/Cu/9Vo7TekmMR0xJz
	914w0Y3cFhfW+McuoOqJzx4ORvfEvKuBC7juV8y9/pzz0LHZ+cvDd3iev8Jz/TBjJft5tY8M
	YT1aq5RYijMSDbWYi4oTAdWYkmlKBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220901002815epcms2p6ae137d9de49bef5764f19c0fa7f3536e
References: <CGME20220901002815epcms2p6ae137d9de49bef5764f19c0fa7f3536e@epcms2p6>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_172830_354841_902BC036 
X-CRM114-Status: GOOD (  21.01  )
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
Reply-To: sungup.moon@samsung.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Some NVMe device, use EUI64 and NGUID, has fixed value EUI64 on a
sub-system because of the bit size of ID. Current kernel check the
all IDs should have unique value in a sub-system and globally.
However, if an namespace has duplicate IDs (not all) in a sub-system,
current kernel raise "duplicate IDs in subsystem for nsid" error. But
NVMe Specification defines the namespace unique identifier like this:

When creating a namespace, the controller shall indicate a globally
unique value in one or more of the following:
a) the EUI64 field;
b) the NGUID field; or
c) a Namespace Identification Descriptor with the Namespace Identifier
Type field set to 3h
(reference: 7.11 Unique Identifier; NVM Express 1.4c spec)

So, I suggest the modified nvme_subsys_check_duplicate_ids function
checking uniqueness from all IDS to one more IDs.

Signed-off-by: Sungup Moon <sungup.moon@samsung.com>
---
 drivers/nvme/host/core.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af367b22871b..15f4071fce9d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3902,24 +3902,35 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
 	return NULL;
 }
 
+#define IDS_EQUAL(A, B) (memcmp(&(A), &(B), sizeof(A)) == 0)
+
 static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
 		struct nvme_ns_ids *ids)
 {
 	bool has_uuid = !uuid_is_null(&ids->uuid);
 	bool has_nguid = memchr_inv(ids->nguid, 0, sizeof(ids->nguid));
 	bool has_eui64 = memchr_inv(ids->eui64, 0, sizeof(ids->eui64));
+	bool duplicated;
 	struct nvme_ns_head *h;
 
 	lockdep_assert_held(&subsys->lock);
 
 	list_for_each_entry(h, &subsys->nsheads, entry) {
-		if (has_uuid && uuid_equal(&ids->uuid, &h->ids.uuid))
-			return -EINVAL;
-		if (has_nguid &&
-		    memcmp(&ids->nguid, &h->ids.nguid, sizeof(ids->nguid)) == 0)
-			return -EINVAL;
-		if (has_eui64 &&
-		    memcmp(&ids->eui64, &h->ids.eui64, sizeof(ids->eui64)) == 0)
+		duplicated = false;
+
+		if (has_uuid)
+			duplicated = duplicated &&
+				uuid_equal(&ids->uuid, &h->ids.uuid);
+
+		if (has_nguid)
+			duplicated = duplicated &&
+				IDS_EQUAL(ids->nguid, h->ids.nguid);
+
+		if (has_eui64)
+			duplicated = duplicated &&
+				IDS_EQUAL(ids->eui64, h->ids.eui64);
+
+		if (duplicated)
 			return -EINVAL;
 	}
 
-- 
2.34.1


