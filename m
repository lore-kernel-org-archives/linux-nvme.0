Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C58EC48BC4
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Feb 2024 04:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=D8duw2NlY40F5QIBvKI4vq/UQLXR9lmXpn65yNjy7ow=; b=RWlg8u3q2NPSSm
	XK92niyACLc3q13YIEnUYFmI+VvXTk4mKjWRdPcy38tQTv/oBzAJQKNPmrkxTdGXmb+qz9fCT+yNo
	xSrFolIJNdJQEijcHPHTgLQ00VYKN+p45q4E/Uhd27883gMXJAswXJg24MKqvgGfN6VSnMVNuNwlr
	CVszB7SCYC4gKiSNoOaPFK+pUxIlkrYH4VSa9866BYtyrWZqLlzhqdUKNAiv4jEoza8fkZ477007q
	SKBNkQBEVkJogicnH0GEXerAkNQncpV1bc9CBD4N+JZ+swWdr3+UuJB5t7g9B2ldGunlgtDCrDHsB
	DVP+GIj/qrVTj2P6KFRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdMpt-00000007nL8-3Bni;
	Fri, 23 Feb 2024 04:06:57 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdMpa-00000007nIp-3GKb
	for linux-nvme@lists.infradead.org;
	Fri, 23 Feb 2024 04:06:49 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240223040633epoutp04cb2018cf300178886699b06f5953b932~2Yk1y8jE30340903409epoutp04C
	for <linux-nvme@lists.infradead.org>; Fri, 23 Feb 2024 04:06:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240223040633epoutp04cb2018cf300178886699b06f5953b932~2Yk1y8jE30340903409epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708661193;
	bh=D8duw2NlY40F5QIBvKI4vq/UQLXR9lmXpn65yNjy7ow=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ib/52IOX2VRlK57MHKlL0pMIENay2NnEvZysnERZi5D+3pPkids2UsCqfHIjYi7kW
	 VIlxmSV53uTA9tjDkvSp/jDrYcpuj1HE6WqrFwmziqolutEiT1KNoG9Zlr5eid17A4
	 JjxJtalPUk6awtW/1IVjt7m7wqJH1G7zXCZDyfHo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240223040632epcas5p487a20d960206d1536dd7302502006feb~2Yk1UI4bp1507615076epcas5p44;
	Fri, 23 Feb 2024 04:06:32 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TgxK26H3Nz4x9Pv; Fri, 23 Feb
	2024 04:06:30 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1C.86.09634.6C918D56; Fri, 23 Feb 2024 13:06:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240219043044epcas5p357dd2ded89cd5698a2b3726a5214a315~1KU0d4FUx2790727907epcas5p3n;
	Mon, 19 Feb 2024 04:30:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240219043044epsmtrp198251cc10ae384698d01900834dcaf1a~1KU0dMQK12405124051epsmtrp1Z;
	Mon, 19 Feb 2024 04:30:44 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-40-65d819c64abd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	66.FF.08755.479D2D56; Mon, 19 Feb 2024 13:30:44 +0900 (KST)
Received: from localhost.sa.corp.samsungelectronics.net (unknown
	[107.99.41.223]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240219043043epsmtip145b70931e3eefe641a47b9cafd08ad8c~1KUzIVMYD0350803508epsmtip1b;
	Mon, 19 Feb 2024 04:30:43 +0000 (GMT)
From: sathya.m@samsung.com
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, d.palani@samsung.com,
	prakash.bv@samsung.com, anshul@samsung.com, Sathyavathi M
	<sathya.m@samsung.com>
Subject: [PATCH v2 1/1] nvme-pci: Verify the CMB's Controller Base Address.
Date: Mon, 19 Feb 2024 04:32:25 +0530
Message-Id: <1708297345-6550-1-git-send-email-sathya.m@samsung.com>
X-Mailer: git-send-email 1.8.3.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmlu4xyRupBj+fG1r8nj6F1eL/nmNs
	Fm+/PmCzWLn6KJPFpEPXGC3mL3vKbnFvRhe7xbrX71kstl5ewO7A6TGx+R27x/l7G1k8Nq3q
	ZPPYvKTeY/fNBjaPvi2rGAPYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU
	8hJzU22VXHwCdN0yc4CuUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfm
	FpfmpevlpZZYGRoYGJkCFSZkZ0w594ip4BZPxbb+WewNjDO4uhg5OSQETCQ+zNrLCmILCexm
	lHixRKqLkQvI/sQocebuYWYI5xujxK+H/WwwHUfe72eESOxllHh9qA/KaWOS2Lb/IAtIFZuA
	lMTT5slgtoiAo8SrFc/ZQIqYBfoYJU69/wTUwcEhLOAtcXeZC0gNi4CqxI5VPcwgNq+As8TZ
	nV9ZILYpSEx5+B7sDAmBY+wSi3ZNY4dIuEg8nrgGqkhY4tXxLVBxKYmX/W1Qdr7EmUlHGCHs
	Eol5O5uh4vYSF/f8ZQK5gVlAU2L9Ln2IsKzE1FPrmEBsZgE+id7fT5gg4rwSO+bB2EoSJz6/
	hbIlJNbsh4SdhICHxIxXB9gg4RgrsXHRY6YJjLKzEDYsYGRcxSiZWlCcm55abFpgmJdaDo+o
	5PzcTYzgxKbluYPx7oMPeocYmTgYDzFKcDArifCylF9JFeJNSaysSi3Kjy8qzUktPsRoCgyz
	icxSosn5wNSaVxJvaGJpYGJmZmZiaWxmqCTO+7p1boqQQHpiSWp2ampBahFMHxMHp1QDk4y0
	yXbe8pfCT9NmbTzP/1dPa8kjPwWLozv3WvQtLJQ45OLymL1yEvOBO7ZzReTcFplertdUOxHO
	qfXFpIHdTMJk5UfFqjnbP8ZXKqbyO88q3dstd2jph2vinT8dBaz2hN78UHQwYuMWw4XOXk/j
	O9hz67d8WzHv18a2TTc0JqkzXFpva3WznzV48tz15wxtJvs0v/j0t7ZyUfCSW+eua7wtrDg8
	s3GRg1n9s9jO7g3aiz6I7apYf25XUlbpXybhe0zH91aXClpMXq9TcnzujLdnJp/tuxiRdbr6
	OJPfiyi2G/kpmgpPVq84vWdl3i51KWvdbW0x7b+mOzscEl/5RCHwaGTgN7NGjSvLw22YbZRY
	ijMSDbWYi4oTATWwWaX1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42LZdlhJTrfk5qVUg6vv9Sx+T5/CavF/zzE2
	i7dfH7BZrFx9lMli0qFrjBbzlz1lt7g3o4vdYt3r9ywWWy8vYHfg9JjY/I7d4/y9jSwem1Z1
	snlsXlLvsftmA5tH35ZVjAFsUVw2Kak5mWWpRfp2CVwZU849Yiq4xVOxrX8WewPjDK4uRk4O
	CQETiSPv9zN2MXJxCAnsZpRou/KCCSIhIbF79XsWCFtYYuW/5+wQRS1MEl/6PzCDJNgEpCSe
	Nk8GKxIRcJc4+rKBCaSIWWASo8TEO5uAOjg4hAW8Je4ucwGpYRFQldixqgesl1fAWeLszq9Q
	CxQkpjx8zzyBkWcBI8MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgINPS3MG4fdUH
	vUOMTByMhxglOJiVRHjdmy6kCvGmJFZWpRblxxeV5qQWH2KU5mBREucVf9GbIiSQnliSmp2a
	WpBaBJNl4uCUamA6OqUt3WUxzzqxu72SQfwvVv4w7QrlKb/3N0e5Rnxyoc+E61M0rzxwtNOp
	aJ55eHsTw4mF7w68fvi4T5+r92PCyxDvN5tX9v+wVfz92+ltv4fj74TPj6RNjKaY3rgrMneS
	61pGC82o2+ascnKbj+gKi1nyr6o+phrCNPUKZ9YvbsULqn8utraU/QmbUxxdbrqCoc347ZVQ
	8YL7jDkC17/9Xl33601g3JM8M90Di+6dEHPS+bD7Wd2GVVUmfJtWFlv7n3b6rhjEqP1CJKD/
	NsddHqdWy59RJ95MCN+m7P28jo2fvbLyQOBJ6VqV5i8BMtcPnvGISM5J0Pj+bFej9+S4y+zB
	1fvvFVyvYVjwuVqJpTgj0VCLuag4EQCCZndioQIAAA==
X-CMS-MailID: 20240219043044epcas5p357dd2ded89cd5698a2b3726a5214a315
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240219043044epcas5p357dd2ded89cd5698a2b3726a5214a315
References: <CGME20240219043044epcas5p357dd2ded89cd5698a2b3726a5214a315@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_200647_519431_65677711 
X-CRM114-Status: GOOD (  15.99  )
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

From: Sathyavathi M <sathya.m@samsung.com>

As per the NVMe Base Specification, CMB should not be enabled if
the CMB's Controller Base Address(CMBMSC.CBA) is invalid. This patch
detects if the CMB's Controller Base Address is valid or not.

Signed-off-by: Sathyavathi M <sathya.m@samsung.com>
---
 drivers/nvme/host/pci.c | 2 ++
 include/linux/nvme.h    | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e6267a6..5e508db 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1856,6 +1856,8 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 		hi_lo_writeq(NVME_CMBMSC_CRE | NVME_CMBMSC_CMSE |
 			     (pci_bus_address(pdev, bar) + offset),
 			     dev->bar + NVME_REG_CMBMSC);
+		if (readl(dev->bar + NVME_REG_CMBSTS) & NVME_CMBSTS_CBAI)
+			return;
 	}
 
 	/*
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index bc605ec..b55cacd 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -145,6 +145,7 @@ enum {
 	NVME_REG_CMBMSC = 0x0050,	/* Controller Memory Buffer Memory
 					 * Space Control
 					 */
+	NVME_REG_CMBSTS	= 0x0058,	/* Controller Memory Buffer Status */
 	NVME_REG_CRTO	= 0x0068,	/* Controller Ready Timeouts */
 	NVME_REG_PMRCAP	= 0x0e00,	/* Persistent Memory Capabilities */
 	NVME_REG_PMRCTL	= 0x0e04,	/* Persistent Memory Region Control */
@@ -245,6 +246,10 @@ enum {
 	NVME_CAP_CRMS_CRIMS	= 1ULL << 60,
 };
 
+enum {
+	NVME_CMBSTS_CBAI	= 1 << 0,
+};
+
 struct nvme_id_power_state {
 	__le16			max_power;	/* centiwatts */
 	__u8			rsvd2;
-- 
1.8.3.1


