Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6405ECAAD4
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 00:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:CC:To:From:Subject:
	Mime-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=F+DSRmrJxDlQ34jLvI5bieObIeH2rYC6PXiOIfkWjjU=; b=qnoZbORGe745VTDpp7b8KW7Q3B
	G11K1Zj9THwtj0uDMvW95rvbn6wT4pLTYnETDGDH61gb2GazT4Q0oXCoUMxCNpEX+/Vy3LopSROe2
	sfimpWS3YS+g4tGVwbOBN056OvTXlgHJQbSr4kBpO+LplydbtjFzLI7lTaVmtxQPk4CzRlbjFrWuB
	G6M8e9HxOKGYS/0DuOZthdauM2nQFexMZ7gDD1NYkPeUucY683ikNsEG1sAypYrRxjpiE3nkBvLPw
	BNw/Ot48j4yg4UCAeom8o0XTZ05zT5CSt41OzbpOG14dFjvYfOFDT4uRcNhWGray54I6YMSno4Kvk
	OzkT7qTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTYP4-008oJ4-W3; Thu, 01 Sep 2022 00:49:55 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTYP1-008oIK-MX
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 00:49:53 +0000
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220901004947epoutp0154b46cac4d93747d44ff65f4c9603545~Qli4ye3c52562825628epoutp01N
	for <linux-nvme@lists.infradead.org>; Thu,  1 Sep 2022 00:49:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220901004947epoutp0154b46cac4d93747d44ff65f4c9603545~Qli4ye3c52562825628epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1661993387;
	bh=F+DSRmrJxDlQ34jLvI5bieObIeH2rYC6PXiOIfkWjjU=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=AIR9crDXAJg0t0vY3/MfDeNNiActLEPmM9+agiEKgU7AIWrT59gDP+upWk6Aw/Ssy
	 v3a6c5WpPVyBGeIRGA+umcYl3KyOqV6vpzBB4CikeLTI0218syvCg0Wj5xXDQc2u0U
	 i0DIj+BkF/uLpwZW+RGLmOkInqfGjEiwLw1xEAcE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20220901004947epcas2p4298714009c3c8aacc0135baba32c4f3e~Qli4jnZC01107511075epcas2p4Z;
	Thu,  1 Sep 2022 00:49:47 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4MJ2W94pSzz4x9Py; Thu,  1 Sep
	2022 00:49:41 +0000 (GMT)
X-AuditID: b6c32a46-aa5ff70000018104-72-631001a56c3d
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	02.1E.33028.5A100136; Thu,  1 Sep 2022 09:49:41 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2] drivers/nvme/host: Fix namespace duplication check rule
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
Message-ID: <20220901004941epcms2p4e5e1c53484889619f050a02d8e671eca@epcms2p4>
Date: Thu, 01 Sep 2022 09:49:41 +0900
X-CMS-MailID: 20220901004941epcms2p4e5e1c53484889619f050a02d8e671eca
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmhe5SRoFkg3OHVC3+7znGZrFy9VEm
	i0mHrjFaXN41h81i/rKn7BbrXr9nsbj76SWrA7vHxOZ37B7n721k8di0qpPNY/OSeo/dNxvY
	PPq2rGL0+LxJLoA9KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
	xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5e
	aomVoYGBkSlQYUJ2RvPuT8wFy8UrTrzqZm1gPC7QxcjJISFgIrFp+mLWLkYuDiGBHYwSG1a1
	ADkcHLwCghJ/dwiD1AgLeEu03t3FDmILCShK/H3WxwgR15VY838KM4jNJqAtce/MWyaQOSIC
	fYwSfd/Pgw1lFljPKHHrwjJmiG28EjPan7JA2NIS25dvZYSwNSR+LOuFqhGVuLn6LTuM/f7Y
	fKgaEYnWe2ehagQlHvzcDRWXlHh68gNUPF+i7fciNpDFEgIdjBLnHx5hgkiYS/x5eR1sKK+A
	r8TWH2/ZQGwWAVWJfV+vsULUuEjsmvcW7DhmAXmJ7W/nMINCgllAU2L9Ln0QU0JAWeLILagK
	PomOw3/ZYd7aMe8J1CZViYsTethgXlw5r4ERotVD4t5ZI0gYBkrMbDrFPIFRYRYipGchWTsL
	Ye0CRuZVjGKpBcW56anFRgVG8MhNzs/dxAhOmlpuOxinvP2gd4iRiYPxEKMEB7OSCO/3czzJ
	QrwpiZVVqUX58UWlOanFhxhNgR6eyCwlmpwPTNt5JfGGJpYGJmZmhuZGpgbmSuK8LtqMyUIC
	6YklqdmpqQWpRTB9TBycUg1MvVr3siUbDrox1m4ra2N2ffK0XN956oo/d3TnbJH7dHqDb+BJ
	l+PxgY73a2NynCdeC51o1bDIvbfofMpZO/7DB6Zuu8v5v2oGE+unxADF050607c8Wj/h7m1n
	3XvKzef7WcI+aE5hur2etYV1vl9uk8Oz4ycmPOTzKZh6o54xYUPb3gDWH9OvlTkuUGk6f8PH
	bEJicKJn2AGFr0ZPfLJLPu3YKM0grVmssWpexr4VSklZbSkfvvxacFVi6o7tv47WPcs7/Paj
	lrPo+/1n857Z6kVcPMrGmnL2x16lqRbfgjfMvWSz5ueKMJ63mR/vl3z4dqXn+dWSyWfmsE5h
	WnNuzX4d8y88ZXeN5sw44GT5N1qJpTgj0VCLuag4EQAQr2NuIwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220901002815epcms2p6ae137d9de49bef5764f19c0fa7f3536e
References: <CGME20220901002815epcms2p6ae137d9de49bef5764f19c0fa7f3536e@epcms2p4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_174952_227442_E2A47840 
X-CRM114-Status: GOOD (  23.79  )
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

I missed the initializing of "duplicated" variable, so I reissue the
version2 patch.

Signed-off-by: Sungup Moon <sungup.moon@samsung.com>
---
 drivers/nvme/host/core.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af367b22871b..8c2faa2881a4 100644
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
+       bool duplicated;
        struct nvme_ns_head *h;

        lockdep_assert_held(&subsys->lock);

        list_for_each_entry(h, &subsys->nsheads, entry) {
-               if (has_uuid && uuid_equal(&ids->uuid, &h->ids.uuid))
-                       return -EINVAL;
-               if (has_nguid &&
-                   memcmp(&ids->nguid, &h->ids.nguid, sizeof(ids->nguid)) == 0)
-                       return -EINVAL;
-               if (has_eui64 &&
-                   memcmp(&ids->eui64, &h->ids.eui64, sizeof(ids->eui64)) == 0)
+               duplicated = has_uuid || has_nguid || has_eui64;
+
+               if (has_uuid)
+                       duplicated = duplicated &&
+                               uuid_equal(&ids->uuid, &h->ids.uuid);
+
+               if (has_nguid)
+                       duplicated = duplicated &&
+                               IDS_EQUAL(ids->nguid, h->ids.nguid);
+
+               if (has_eui64)
+                       duplicated = duplicated &&
+                               IDS_EQUAL(ids->eui64, h->ids.eui64);
+
+               if (duplicated)
                        return -EINVAL;
        }

--
2.34.1

