Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9219CCD4F25
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2026 14:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LeBs0NUZFt7DCr4wjWB/a7pqUelnuLpdnbnklaG9Krc=; b=cK7R2Wx3+fe5rfdU7zRqZb8yjP
	cft+RuwnE2SxZzcazTkUc3Ph9O3FC3vwMbo53G/IxT1FgZN8JaNC+3jT/l3wm1a3RtizJHMs+4fIo
	iPh0N5NY8+FuQMHlRTxwDmB7VCk2QrZVzvHbd/jag71Hgo+i0y0NnRFLtmMVqyLWjwUFb/DuOMmy6
	nyYj73dc8MPmwYJunws6+sJ/X8n1KUcC/2QOk12bckrrTPUXgA49KEcwLOJylmxXIrbmGLuCRRU/i
	o+aFT3Q3Uc/XXfN7n+gzKhYJ0pHsdY5YybY5/DKzvPjDNzEcDSVE5oc2aUubkSUPIv45bX+LTkWUT
	jTbaM+6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNXKC-00000005mbS-49LY;
	Thu, 14 May 2026 14:46:08 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNXKA-00000005man-0UXa
	for linux-nvme@lists.infradead.org;
	Thu, 14 May 2026 14:46:07 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E7d46k2014114
	for <linux-nvme@lists.infradead.org>; Thu, 14 May 2026 07:46:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=LeBs0NUZFt7DCr4wjW
	B/a7pqUelnuLpdnbnklaG9Krc=; b=MHus5Tz5b8RO0/svBcjv/rPK5SbA/fC/9n
	kJtm4zTatHrGA7C7lki7sBIJpitUGa9P8nX6SWviLjhVBydQ3UAdN/YngfHBtXKa
	lHPPuuCFuLw1nk+tauIZC1MZZL79h10MYlIjC0RgyCwYmJqEDaH0T1ati7wreym6
	msxIUmeSWe+10QYfpdXqRaVJMr0HGAyUlv0hSHovqUi1zacvaDrRzVLy7qd5+lci
	CUS9icbnj77RjKRQyYTFg37iCVwSiLOsPkC8Bk6eiE8VaylHKuKZMexreoiRgZGQ
	Zr2mZvvOK7Pnzehe+DWglhCegEShQwi/INEpH734rZuC5xu2M7aA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e3nvs7x1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 14 May 2026 07:46:03 -0700 (PDT)
Received: from twshared124658.16.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 14 May 2026 14:46:03 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id A1B64197139EA; Thu, 14 May 2026 07:45:47 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH] nvme-pci: serialize polling interrupt queue with shutdown
Date: Thu, 14 May 2026 07:45:44 -0700
Message-ID: <20260514144544.1752178-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BMKDalQG c=1 sm=1 tr=0 ts=6a05e02b cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=VwQbUJbxAAAA:8 a=qgo5mpPwsKqrPU-Jxr4A:9
X-Proofpoint-GUID: bV1fbw6EOlcc1Z14FiKFK5uQd-HS9pA6
X-Proofpoint-ORIG-GUID: bV1fbw6EOlcc1Z14FiKFK5uQd-HS9pA6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE0OSBTYWx0ZWRfX0EGQw3ShQTTv
 gs2/07oaC8Aw8FyebRzNvpc1B1MIZzySqr8oni/XA1ZWI8zO4vE3yFaUW35wZPKlIZEglyExJ0D
 EBoB+YVfQGBpr/OKZNyAq8GbjpSGXRFIrMJMIWtH/PjM1UZjCIdg67mH7/+8TfawtvEpo4TVXAp
 x6vJxp8Bwm+y9z9/DUjQmzRoBzr1lRUJ5twnLCVQz58iM1fe93b2cbeE+ws1kALPCzRCiwHii2d
 3aFVOO3jZ/eaOHsAQ0ZT5mfUV+8lOJCCH1XibC8R5opB55Cxf1up+Vo1QjJWW/5gT46Izx767fj
 oxAe5bsECzBS8Adk+GBVas6ijsBLC3mEyVE9KCIhlL/9e7YkwyIZ9tlUzSo5WBU74QSDk8T6eab
 YNJ7dbc6nuFSP8hNj4oH+nxHvyCRMEux8TZEzsFaELlYfoCrAHhjiRAd6x35Uwdbp+Pz8nGawit
 +CI68xslpT/qkGeBHsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_074606_275484_54E61207 
X-CRM114-Status: GOOD (  12.24  )
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

Polling an interrupt driven completion queue temporarilly disables the
irq. If this occurs concurrently with another thread disabling the
device, the irq vector may have been freed, which makes it available for
reuse. Reenabling the irq after polling the queue may be referencing a
stale irq at that point.

Fix this race by ensuring nvme_poll_irqdisable() can not run
concurrently with nvme_dev_disable(), and skip polling the completion
queue if the queue has already been disabled.

Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 139a10cd687f9..34845d73cb3ab 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1885,8 +1885,12 @@ static enum blk_eh_timer_return nvme_timeout(struc=
t request *req)
 	 */
 	if (test_bit(NVMEQ_POLLED, &nvmeq->flags))
 		nvme_poll(req->mq_hctx, NULL);
-	else
-		nvme_poll_irqdisable(nvmeq);
+	else {
+		mutex_lock(&dev->shutdown_lock);
+		if (test_bit(NVMEQ_ENABLED, &nvmeq->flags))
+			nvme_poll_irqdisable(nvmeq);
+		mutex_unlock(&dev->shutdown_lock);
+	}
=20
 	if (blk_mq_rq_state(req) !=3D MQ_RQ_IN_FLIGHT) {
 		dev_warn(dev->ctrl.device,
--=20
2.53.0-Meta


