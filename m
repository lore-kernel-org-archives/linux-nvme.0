Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7529BC021B2
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 05:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WW5dHa7+uFgb2GgCT612fikzvZkwWoYKaCZBUFEuV44=; b=gsJfIyo049VzdgXPpSwktScraS
	OJ2FOCp4W98uDy1RKaVROVvyIFCuIFnhYDuEq/EJ0uShCH3NK5pm47J8O/IQIOGU2zAJbalENMLj9
	eQLJ8yd5I3oAaMWc7ypNYirubjxvLiy1ykUVRroiKm+HCIJDvuEH77oP7aHDhull40AGwwBpzEZBP
	z7tsOP4qq6MBIvfPhwiKltUja/0pjVQJIOddVgb8nZaFeYN2RfLkKmTBgwffgrisB0ALQUtzl7rvp
	USm54fqkzc6vhgVI+SLxjcib1gVgfNTEtcnfomNNdWJUa6cKM3fg+dCJfnmCTJLED2aEU7ruEewgb
	MKTGdMgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmnEo-0000000FzR8-3o01;
	Tue, 25 Feb 2025 05:12:10 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmnEm-0000000FzOk-0AEk
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 05:12:09 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250225051205epoutp0162c49edf28ac21d8615ce5d9b9398661~nW3HOUsD41511215112epoutp01l
	for <linux-nvme@lists.infradead.org>; Tue, 25 Feb 2025 05:12:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250225051205epoutp0162c49edf28ac21d8615ce5d9b9398661~nW3HOUsD41511215112epoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740460325;
	bh=WW5dHa7+uFgb2GgCT612fikzvZkwWoYKaCZBUFEuV44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=viy43hXoIYg+cJUTZHfh+EMgEZCTo/dHIkqBdP4R3Rjm676NveiJ2DBHOQXdRmcVR
	 DEmWplCWqYmGhPeYnp1/bMuiuG7mzMOtwYuIDszrgaDfqlPONvK0Fk2iZ6TgSpPiFE
	 MeeZ1SY43sj5vta3plsqPhGcLyWWgQqJlaiN/Y/w=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250225051204epcas5p3b53c8df5b0a9a1767e2b0d1b8ccca76b~nW3Gn-70Y0616406164epcas5p3R;
	Tue, 25 Feb 2025 05:12:04 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Z25Ll0rv9z4x9Pt; Tue, 25 Feb
	2025 05:11:59 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	34.E6.19933.E115DB76; Tue, 25 Feb 2025 14:11:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250225045516epcas5p3fa5712152300bf976d1bc0ab26211633~nWocCz3Mo3038830388epcas5p3w;
	Tue, 25 Feb 2025 04:55:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250225045516epsmtrp11422abd21c4b46eb83fabce65c9d7e79~nWocB-QNy1661216612epsmtrp1r;
	Tue, 25 Feb 2025 04:55:16 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-3e-67bd511eb825
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1A.BC.18729.43D4DB76; Tue, 25 Feb 2025 13:55:16 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250225045514epsmtip24c33748a5236887fa8051cab6e307c55~nWoaCaXLr3049830498epsmtip2N;
	Tue, 25 Feb 2025 04:55:14 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com
Cc: anuj1072538@gmail.com, nikh1092@linux.ibm.com,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, dm-devel@lists.linux.dev, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH v1 2/3] nvme: Fix incorrect block integrity sysfs values for
 non-PI namespaces
Date: Tue, 25 Feb 2025 10:16:52 +0530
Message-Id: <20250225044653.6867-3-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225044653.6867-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmlq584N50g1VfmS0+fv3NYtE04S+z
	xeq7/WwWCxbNZbFYufook8WkQ9cYLfbe0raYv+wpu0X39R1sFsuP/2OyuHvxKbMDt8fOWXfZ
	PS6fLfXYtKqTzWPCogOMHpuX1Hu82DyT0WP3zQY2j49Pb7F49G1ZxejxeZNcAFdUtk1GamJK
	apFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0MFKCmWJOaVAoYDE
	4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMx90v2AsW
	clW83n2buYHxBEcXIyeHhICJxJI13exdjFwcQgK7GSVu72hmgXA+MUrcmzkDyvnGKNG4aC0T
	TMvMp5dZIRJ7GSUmfnwD1f+ZUWLRg/tsIFVsAuoSR563MoLYIgIBErNOX2EEKWIWOMso8bfx
	PwtIQlggQeLD7l9AYzk4WARUJd6/KgIJ8wpYSGy8d4QNYpu8xMxL39lBbE4BS4kJh3pZIWoE
	JU7OfAI2hhmopnnrbGaQ+RICKzkk9p6+xgrR7CLx7ecXqLOFJV4d38IOYUtJvOxvg7LTJX5c
	fgpVUyDRfGwfI4RtL9F6qp8Z5DZmAU2J9bv0IcKyElNPrWOC2Msn0fv7CVQrr8SOeTC2kkT7
	yjlQtoTE3nMNULaHxOzjPxkhgdXDKPFg8yGmCYwKs5D8MwvJP7MQVi9gZF7FKJlaUJybnlps
	WmCUl1oOj+bk/NxNjOBUrOW1g/Hhgw96hxiZOBgPMUpwMCuJ8HJm7kkX4k1JrKxKLcqPLyrN
	SS0+xGgKDO+JzFKiyfnAbJBXEm9oYmlgYmZmZmJpbGaoJM7bvLMlXUggPbEkNTs1tSC1CKaP
	iYNTqoFpXr/95kMlj5/N3fO0a7rLarcP0ebiT3gjTTLsr1VXqfn7STWINO6PVROanlS9tfrA
	1rWuF+/Xnnrn87Gz8fPuzjN1nVMrJi1+vjlBX62g40HBL5sXqke/rntWrvFk36aT55v4A7d/
	cHWOunJR+na3tVj8PaEVfdvFPjY7PMk4pXreqWd2/lXF5/9KXqm53loUpSsRs/P2vhuPnk14
	ML18xgL+zw4c7Ey8/B+vb7wwe/4ZiQ83uk6e2G6zsHid5BvfrdL7N1pf6xA7fSLnVn2HNtv9
	wr+aq8p6nLZt+yN8SJvv1s4Kh0sFu5uPpfmarSvxNvmw5qK9+QU1h9bDB1MXH2DadPUxi4/f
	hhKrsnyRNCWW4oxEQy3mouJEAMEBpCdOBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSvK6J7950gzMvDS0+fv3NYtE04S+z
	xeq7/WwWCxbNZbFYufook8WkQ9cYLfbe0raYv+wpu0X39R1sFsuP/2OyuHvxKbMDt8fOWXfZ
	PS6fLfXYtKqTzWPCogOMHpuX1Hu82DyT0WP3zQY2j49Pb7F49G1ZxejxeZNcAFcUl01Kak5m
	WWqRvl0CV8bj7hfsBQu5Kl7vvs3cwHiCo4uRk0NCwERi5tPLrF2MXBxCArsZJY7/OcUKkZCQ
	OPVyGSOELSyx8t9zdoiij4wSW8/MZgNJsAmoSxx53gpUxMEhIhAi0XPEBKSGWeAyo8SUV1/A
	BgkLxEksOn2CGaSGRUBV4v2rIpAwr4CFxMZ7R9gg5stLzLz0nR3E5hSwlJhwqJcVpFwIqObC
	ymiIckGJkzOfsIDYzEDlzVtnM09gFJiFJDULSWoBI9MqRsnUguLc9NxiwwLDvNRyveLE3OLS
	vHS95PzcTYzgONHS3MG4fdUHvUOMTByMhxglOJiVRHg5M/ekC/GmJFZWpRblxxeV5qQWH2KU
	5mBREucVf9GbIiSQnliSmp2aWpBaBJNl4uCUamAScxWV1VyY3nwm0O+T/OnZcdPO9bWo1n1c
	+GiWr+0ZZ1eeOqMnMi+29CZmVMh8WbptHefrPVXZHbMdVt15sifg0CvV1duY3l2eLP1Lfs87
	I7cGm316arPuMqXt7XaWfvGwj+Nit+ubq2+VVr0SmpByynDStSbzI9M9Wxf+4dAOjbjhN09K
	bY7wvktlKzZZz91ub3bPyuqL/pFPH1Vzi7LC5Z9IbNw/1Xa6VO/bxjvFcyK8WKNWtfoc2rVk
	7d0Fqn++tnNX3ij9fM3Mts16s8aWDdfX2Cf9d/XdOuOlW2qt5WINE9bdoSZR4QX6Hn0PTGwf
	8G8vv64yv1H8s6i0VVYwZ/aZBbx8C7M4GDfNztNWYinOSDTUYi4qTgQAsp+yOwIDAAA=
X-CMS-MailID: 20250225045516epcas5p3fa5712152300bf976d1bc0ab26211633
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250225045516epcas5p3fa5712152300bf976d1bc0ab26211633
References: <20250225044653.6867-1-anuj20.g@samsung.com>
	<CGME20250225045516epcas5p3fa5712152300bf976d1bc0ab26211633@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_211208_394070_16D821D4 
X-CRM114-Status: GOOD (  17.47  )
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

Commit 9f4aa46f2a74
("block: invert the BLK_INTEGRITY{GENERATE,VERIFY} flags") caused
read_verify and write_generate to report 1 for NVMe namespaces
without PI support. This happens because BLK_INTEGRITY_NOGENERATE and
BLK_INTEGRITY_NOVERIFY were not explicitly set.

Fix this by initializing these flags by default and clearing them only
when the namespace supports PI.

Fixes: 9f4aa46f2a74 ("block: invert the BLK_INTEGRITY_{GENERATE,VERIFY} flags")
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 818d4e49aab5..fe599a811d38 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1799,6 +1799,7 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
 
 	memset(bi, 0, sizeof(*bi));
 
+	bi->flags = BLK_INTEGRITY_NOGENERATE | BLK_INTEGRITY_NOVERIFY;
 	if (!head->ms)
 		return true;
 
@@ -1850,6 +1851,9 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
 		break;
 	}
 
+	if (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE)
+		bi->flags &= ~(BLK_INTEGRITY_NOGENERATE |
+			       BLK_INTEGRITY_NOVERIFY);
 	bi->tuple_size = head->ms;
 	bi->pi_offset = info->pi_offset;
 	return true;
-- 
2.25.1


