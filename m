Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA6AC54EBC
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jan 2023 14:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=R4b4EPkdRWUUjgqA7T04PUXUczW2+piir3kCLNH8c6w=; b=sd7O3Vk57nY1ydMtnw4BSnq3Vw
	StcAP3880fanHJOuDFgh1sqi0dtcs6EPL9XbaFr5MxpAa8AYYsAWTVHLOTCQq6NyDY6L4vpXihP/B
	kZ4wvgMjn1QURC5yfYv+aHQClpFbw0AILw6nKje/QjG3dwTxF9s0qcBoiwk4b8iBJHcVHQvGRMOfc
	YwFxtK7/tvODR6nIEtlrDjg7tEvdO3VEcsTBEIWpOq+o9zO6t1MsPHEEGDgd8+uzxuaxVFf41H/eQ
	0gV2fQHuSD8htvOd59OsBHS/MBfxgPMYf1fSykrE9wdBPNw8ZIMsJXVoMRRjvw2mvnqX074gQlq40
	5AGNB+tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFFkG-007Kcp-Vy; Tue, 10 Jan 2023 14:36:57 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFFk7-007KX9-Tp
	for linux-nvme@lists.infradead.org; Tue, 10 Jan 2023 14:36:51 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230110143638euoutp01320c6f5c5327689274e77df897a81f1f~4_VN91kSY3023430234euoutp01k
	for <linux-nvme@lists.infradead.org>; Tue, 10 Jan 2023 14:36:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230110143638euoutp01320c6f5c5327689274e77df897a81f1f~4_VN91kSY3023430234euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1673361398;
	bh=R4b4EPkdRWUUjgqA7T04PUXUczW2+piir3kCLNH8c6w=;
	h=From:To:Cc:Subject:Date:References:From;
	b=vj9fHhNZyJGNuQw+SlxiTejcDpA3plVlo/tCNMZSEHuJtq21sIEoCpn3Wi1kJ/RQh
	 9oZn17SaUWZO9rtKBg0ohxPvslJaSqlIe0oXxGwnrOgeSfNoW3/Z5E+LEzPGEgEE74
	 B6lrPhl/OukQ8bOHzq3vLkf4UnP+rIHunu7k68bs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230110143637eucas1p28f0c3737e9bc89cacc4efde5292e2a39~4_VNLQdE00230702307eucas1p2h;
	Tue, 10 Jan 2023 14:36:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 06.A6.56180.5F77DB36; Tue, 10
	Jan 2023 14:36:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2~4_VMxKnHZ1940819408eucas1p1L;
	Tue, 10 Jan 2023 14:36:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230110143637eusmtrp1254629674830a830237a3444e6bec537~4_VMwfUdt2765827658eusmtrp1M;
	Tue, 10 Jan 2023 14:36:37 +0000 (GMT)
X-AuditID: cbfec7f2-ab5ff7000000db74-05-63bd77f55590
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 14.D0.52424.5F77DB36; Tue, 10
	Jan 2023 14:36:37 +0000 (GMT)
Received: from localhost (unknown [106.210.248.241]) by eusmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20230110143637eusmtip2e7b0ee7656712050d83a71862abedfa6~4_VMirkDu0980009800eusmtip2J;
	Tue, 10 Jan 2023 14:36:36 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, bvanassche@acm.org,
	linux-block@vger.kernel.org, damien.lemoal@opensource.wdc.com,
	gost.dev@samsung.com, snitzer@kernel.org, Pankaj Raghav
	<p.raghav@samsung.com>
Subject: [PATCH v2 0/3] block zoned cleanups
Date: Tue, 10 Jan 2023 15:36:32 +0100
Message-Id: <20230110143635.77300-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djP87pfy/cmGxxeomKx+m4/m8W0Dz+Z
	LX6fPc9scfPATiaLlauPMlnsvaVtMX/ZU3aLz0tb2C1O3JJ24PS4fMXb4/LZUo9NqzrZPDYv
	qffYfbOBzWNn631Wj74tqxg9Pm+SC+CI4rJJSc3JLEst0rdL4Mq4u+grS8F/jopz0xcwNzDO
	Ye9i5OSQEDCRaHmyCcjm4hASWMEo8fJJOxuE84VRYkX7dhYI5zOjxL0Vl9lgWm739DNDJJYz
	Sly/d5ARwnnJKPH0QjeQw8HBJqAl0dgJtkNEQFhif0cr2CRmgeuMEtOnXWYBSQgL6Ej86dgL
	NpVFQFXiQtt3RhCbV8BS4vaWXqht8hIzL31nh4gLSpyc+QSslxko3rx1NtgVEgJnOCT2Pupi
	hGhwkZj1sxHKFpZ4dXwL1KcyEqcn97BA2NUST2/8hmpuYZTo37meDeRqCQFrib4zOSAms4Cm
	xPpd+hBRR4n+u4oQJp/EjbeCEBfwSUzaNp0ZIswr0dEmBDFbSWLnzydQOyUkLjfNgdrpIbHz
	4ESwp4QEYiVmP1jAOoFRYRaSv2Yh+WsWwgkLGJlXMYqnlhbnpqcWG+allusVJ+YWl+al6yXn
	525iBCak0/+Of9rBOPfVR71DjEwcjIcYJTiYlUR4V3LuSRbiTUmsrEotyo8vKs1JLT7EKM3B
	oiTOO2Pr/GQhgfTEktTs1NSC1CKYLBMHp1QDk4DH0e7gu5eMZVr4zc5H7HNIituWUr9LUoq9
	wSAsq13cySf7/tQ9B9cHcgaYP8zVdnsSOHPvwv9sX5xrrs9hEPA9msZfOv3EUg2p2InlPzeL
	TdS1nJScFKT8Q3KVw/GprMf+bN4dM8+2RWPbw71GVxp7bjmEbVHh5InZkvVdeX1kqPpjljWf
	Cgy+7q08HR+sk/m3xDF2RnWb/tno0ikhU3V4zfkM1H89NBcVj2TZsotVYmm+QPPe89vftoeU
	dE5xlg5SXxNyc0KMytXSmb83MRfMm3pt0kF3t+OCqywCihXuvrzK/93238ndMb6/d20vLrmV
	6e3k2FCwZ5WzwF3D0AsrUk6pf/l1gunSvDofJZbijERDLeai4kQAoMoTXbcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsVy+t/xe7pfy/cmG1xczmmx+m4/m8W0Dz+Z
	LX6fPc9scfPATiaLlauPMlnsvaVtMX/ZU3aLz0tb2C1O3JJ24PS4fMXb4/LZUo9NqzrZPDYv
	qffYfbOBzWNn631Wj74tqxg9Pm+SC+CI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2
	j7UyMlXSt7NJSc3JLEst0rdL0Mu4u+grS8F/jopz0xcwNzDOYe9i5OSQEDCRuN3Tz9zFyMUh
	JLCUUWLZpZuMEAkJidsLm6BsYYk/17rYIIqeM0osf3sEqJuDg01AS6KxE2yQCFDN/o5WFpAa
	ZoH7jBJ/Nr1iAkkIC+hI/OnYywZiswioSlxo+w42lFfAUuL2ll42iAXyEjMvfQebySygKbF+
	lz5EiaDEyZlPWEBsZqCS5q2zmScw8s9CqJqFpGoWkqoFjMyrGEVSS4tz03OLjfSKE3OLS/PS
	9ZLzczcxAiNn27GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRHelZx7koV4UxIrq1KL8uOLSnNSiw8x
	mgJdPZFZSjQ5Hxi7eSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFIN
	TOrq8r6r10bkb7jha19yOKRUp/DoNIUAmctMovNOrj3zaJHTslM587ce/xat3Hv0UOK3F8I3
	p56f7DHfuc0w+HAmx8a9J6ZOZknkUA2Unt9nlKNxb7fgynt7Tc6XO63aM93oTIj4f9XGHq5H
	/LeqZVdsfbNH6MmWGL7With5Gzbwz+70n6Y3eUN3TomcX87CzRks77TuvmdoTTKJL5k0X7Vo
	ZshfdZnHUkuU1+4p33XweJOO8GeZwE9ZO1nfRmhUzp8mEhkXcm13z7OXP/k0WWqjjm5r/JbZ
	UVvqxPdZ36E5PH9iUXflZ+Y5uVYOk0O0i7xO31S3s9nwS1bydsPyr/faDGuu2NwyPhKjvTpm
	gRJLcUaioRZzUXEiAA5hEkYlAwAA
X-CMS-MailID: 20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2
References: <CGME20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230110_063648_268286_7AA21589 
X-CRM114-Status: GOOD (  12.54  )
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

Hi Jens,
  It is still unclear whether the support for non-po2 zone size devices
  will be added anytime soon [1]. I have extracted out the cleanup
  patches that doesn't do any functional change but improves the
  readability by adding helpers. This also helps a bit to
  maintain off-tree support as there is an interest to have this feature
  in some companies.

[1] https://lore.kernel.org/lkml/20220923173618.6899-1-p.raghav@samsung.com/

Changes since v1:
- Remove blk_is_zoned() check in bdev_{is_zone_start, offset_from_zone_start} (Damien)
- Minor spelling and variable name changes (Bart and Johannes)
- Remove zonefs patch for now (Damien)
- Send dm patches separately(Christoph)

Pankaj Raghav (3):
  block: remove superfluous check for request queue in bdev_is_zoned()
  block: add a new helper bdev_{is_zone_start, offset_from_zone_start}
  block: introduce bdev_zone_no helper

 block/blk-core.c          |  2 +-
 block/blk-zoned.c         |  4 ++--
 drivers/nvme/target/zns.c |  3 +--
 include/linux/blkdev.h    | 22 +++++++++++++++++-----
 4 files changed, 21 insertions(+), 10 deletions(-)

-- 
2.25.1


