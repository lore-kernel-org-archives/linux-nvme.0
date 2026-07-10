Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE1CC43458
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2026 02:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gt0/g7zZyJ9oxGVfpXChoCA6Z2B5Mn4pHu0Aa2usY6s=; b=XWg5Y8pH5ZI24/dZ0qRaOQ6vSz
	NYlbTSr/zQmWySDcaKfjzBKZ9a3nDryzbk1KZ8m2i4etkNYRnbOtYcyBrpb10cp0rxbj2TACMO9bW
	pyknzuOU3ath2+fVGoSbsR42aBp8vB6YZj/3mpVqt+4uDS37f2xxgiH1ej8X9R1ulh7Er2vZDHgR+
	jfm+GLzcCSijlvcnLAARI5ebcQcy80PB6i/+8N+35B7e8VlPV/JQ/l/17BNcABNqugAlDEo7EaZLv
	T9/8CBvCeB2q8RmUlVtX+lBnLb2IGjPl5HKsOyaoJMwHrb8OgH7ifz0hu0vAyHwCVFuJ9WGQ0wO/Q
	N7q2BudQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi10V-00000003xfj-2te0;
	Fri, 10 Jul 2026 02:30:27 +0000
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi10T-00000003xew-45Gc
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jul 2026 02:30:27 +0000
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-92e55b62640so18806385a.0
        for <linux-nvme@lists.infradead.org>; Thu, 09 Jul 2026 19:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650625; x=1784255425; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gt0/g7zZyJ9oxGVfpXChoCA6Z2B5Mn4pHu0Aa2usY6s=;
        b=ldo/n/8h+o8nzRIbrxCWiacCzT6V/ebYqFnTeZc2P4rMWScTJTMqtWP017gutYC68J
         kcW2cdq2jPx7A1lDU8qMo1OUN7BxNrLJIX96MoWE5mXOJ6PEX7HEtR1+C9S414GgIkC7
         8y7SJASkFghrYdNb/3HW/qYbHLqUFcGlo330IU47tz+BUb/WZcU2tfrwRFzIuayMNd54
         texoiatEBC/G+l7dDSo4wzHDdIcUBr/5+Ocgc3UFVElMfCcrIGKbuKILIHxgEizwSONo
         Pew/lHjN+DahH5aLjoclcgWotDp+mQa4bZ3LDZlmvSzUxUSUyND0Iul0JarhaJiIDxxv
         2yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650625; x=1784255425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gt0/g7zZyJ9oxGVfpXChoCA6Z2B5Mn4pHu0Aa2usY6s=;
        b=sqMJBHD5tEpz4KsXnpAB5y00ylnIioDpzPWnmyUzoAnbm5vnzVHYHdpKl0n/BkxbNa
         r3Hd7XNW+n0LzRtfmBefgb3OCE2iR+8HRyYbEfhNIzb+KHGC3+p/X5F/iTHbRJtuxQ/7
         OhZAYmwkEFL+t9bdHk1i5H7FPiOgVd5kCGusVkVPnf5lDWsuVujQURVrxuzmbednb75N
         ghLRidb1LD5Tde+DnrtBLTzxKSegN95PNCqo6s2bSKB1L+q0AhmXJS5Nze/9iODjj3KR
         BGr0LwY57sAGLgS4eEFOwLAQoS9Uh0+Y6aEqbwS5TB42J0IPQaQ/TfSDkf9nkM1H1pXH
         gFpw==
X-Forwarded-Encrypted: i=1; AHgh+RrCv78qBwfeuQ0qxSF11m3c9igO6ChGd7FWUqOyTMTsgRMSMe0lyRakpCbVeq0hty4UuPSiO4fGvbm3@lists.infradead.org
X-Gm-Message-State: AOJu0YyJAZOxKsvfHLYhPfVEd2SNb5qCkfVOgd8IQovPOV0lN4tkstLh
	sSxZ+nQJkRN5/Ew3wVGKFlKK+ryaTFsE0B1FQ9J1pDJmFeZshcHx7zrZ
X-Gm-Gg: AfdE7cmAbk6SPwH960zgLBLChWzJcsJ4SpZ3FlkNUYQy9rhhuE/Nsu6SwrrDIK9igm+
	KvN/d6betYMBo29fk3Ja9yHj0ZSes4lOcddO/vmwabwlmGPoZZ9WgICDyDB/36lT7pimkxdefWY
	XQZUforXq8nYkeeIvqFb19kcUsblHApH1cpEd4g/9sciAOheTsVO2zIYYeK4dIq44OMICPy/wtb
	D8X+yCvQZZZYVdHD3qLilWXWBhQRQYFmLtDQcjL4Y3ePl9eKcizt53rcWUbXfpmHO0EyF0IFiK6
	TPlBWMZM8OicIy+/zNpbFYj8B5b4MRC3tnIOLAPh2siK/ctdqshOHl1n/IhDFRrDY97mU0apNSa
	75ejsNGQeiJV3tVTiX0RR6NP3bhJD/BATkdwwZ/UBH0StHr7xzk6My6f8TeMYty0oEMWnEf8KmD
	gtDsQgUJdQA/08R9cOylTJBApNrdjHcS6h8qt5BmE5nSCvbXuIpj6O9mOhORw1X6mF6Frn3D0pc
	mmodrcEfGiQpGqP4KOxE6YbXBQTG4FN
X-Received: by 2002:a05:620a:4693:b0:92e:c116:bf10 with SMTP id af79cd13be357-92ecf95ea9emr984970385a.89.1783650624113;
        Thu, 09 Jul 2026 19:30:24 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf9d9bsm88854685a.28.2026.07.09.19.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:30:23 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: kwilczynski@kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] nvmet-pci: validate queue IDs against endpoint queues
Date: Thu,  9 Jul 2026 22:30:14 -0400
Message-ID: <20260710023015.3744082-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710023015.3744082-1-michael.bommarito@gmail.com>
References: <20260710023015.3744082-1-michael.bommarito@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_193026_034811_4254022A 
X-CRM114-Status: GOOD (  12.96  )
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

The NVMe PCI endpoint transport allocates SQ/CQ arrays using
ctrl->nr_queues, which is capped by endpoint interrupt capacity. Common
target admin validation only checks queue IDs against subsys->max_qid, so
a root-complex host can submit Create/Delete SQ/CQ commands with qids that
pass the common checks but index past the smaller endpoint transport
arrays.

Impact: A PCI root-complex host can crash an NVMe PCI endpoint target with
malformed queue IDs.

Reject queue IDs that are outside ctrl->nr_queues before indexing the
endpoint SQ/CQ arrays.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---

I reproduced this with a same-translation-unit KUnit/KASAN test. The stock
Create CQ path faults in nvmet_pci_epf_create_cq() after
nvmet_check_io_cqid() accepts qid 2 with max_qid 8 and nr_queues 2. The
patched checks reject malformed Create/Delete SQ/CQ cases while the benign
control still passes.
 drivers/nvme/target/pci-epf.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 4e9db96ebfecd..5bddda09c0538 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1267,10 +1267,15 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 		u16 cqid, u16 flags, u16 qsize, u64 pci_addr, u16 vector)
 {
 	struct nvmet_pci_epf_ctrl *ctrl = tctrl->drvdata;
-	struct nvmet_pci_epf_queue *cq = &ctrl->cq[cqid];
+	struct nvmet_pci_epf_queue *cq;
 	u16 status;
 	int ret;
 
+	if (cqid >= ctrl->nr_queues)
+		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+
+	cq = &ctrl->cq[cqid];
+
 	if (test_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags))
 		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
 
@@ -1348,7 +1353,12 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 static u16 nvmet_pci_epf_delete_cq(struct nvmet_ctrl *tctrl, u16 cqid)
 {
 	struct nvmet_pci_epf_ctrl *ctrl = tctrl->drvdata;
-	struct nvmet_pci_epf_queue *cq = &ctrl->cq[cqid];
+	struct nvmet_pci_epf_queue *cq;
+
+	if (cqid >= ctrl->nr_queues)
+		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+
+	cq = &ctrl->cq[cqid];
 
 	if (!test_and_clear_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags))
 		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
@@ -1367,10 +1377,16 @@ static u16 nvmet_pci_epf_create_sq(struct nvmet_ctrl *tctrl,
 		u16 sqid, u16 cqid, u16 flags, u16 qsize, u64 pci_addr)
 {
 	struct nvmet_pci_epf_ctrl *ctrl = tctrl->drvdata;
-	struct nvmet_pci_epf_queue *sq = &ctrl->sq[sqid];
-	struct nvmet_pci_epf_queue *cq = &ctrl->cq[cqid];
+	struct nvmet_pci_epf_queue *sq;
+	struct nvmet_pci_epf_queue *cq;
 	u16 status;
 
+	if (sqid >= ctrl->nr_queues || cqid >= ctrl->nr_queues)
+		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+
+	sq = &ctrl->sq[sqid];
+	cq = &ctrl->cq[cqid];
+
 	if (test_bit(NVMET_PCI_EPF_Q_LIVE, &sq->flags))
 		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
 
@@ -1419,7 +1435,12 @@ static u16 nvmet_pci_epf_create_sq(struct nvmet_ctrl *tctrl,
 static u16 nvmet_pci_epf_delete_sq(struct nvmet_ctrl *tctrl, u16 sqid)
 {
 	struct nvmet_pci_epf_ctrl *ctrl = tctrl->drvdata;
-	struct nvmet_pci_epf_queue *sq = &ctrl->sq[sqid];
+	struct nvmet_pci_epf_queue *sq;
+
+	if (sqid >= ctrl->nr_queues)
+		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+
+	sq = &ctrl->sq[sqid];
 
 	if (!test_and_clear_bit(NVMET_PCI_EPF_Q_LIVE, &sq->flags))
 		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
-- 
2.53.0

