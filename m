Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77010FD8FFB
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 18:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zO70dOPDPwPIi1kCgLfEco61Rr4AdTL3sfPay6+nNNI=; b=rgHUjF19s10oDDkRoR/gOR8Kam
	xgyHkACUj3KXneUufAUiYRtEPBKfkelJ70ASUBUtPfDDxHAxGUZrsowF/63qeKaXc2IbV5we5/2Xo
	KxhdvZZPGJ3nuKa68sjD61mviq2vOwbJIbP7YTXQQA3UtflyGexaj7gqnMsRj87R//PzK2OYzJo29
	pna4Cq9hjuNuvDSOaDfKAS7ervkLTE2yvAMwvxLDR3lHJ+UCcLglATYkttUN3YCAf7yJtnNuHDk97
	QuqKFXjMQID2soDGq6rnrHhVpZHX2Sbu2XOxXRm/ytV8vtBy0gBNAALaqm4RI0fkrtHiKHKHEjDVJ
	Gzb/EWyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgA9-00000006yIb-2eKC;
	Thu, 26 Feb 2026 18:32:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgA7-00000006yHP-47Wr
	for linux-nvme@bombadil.infradead.org;
	Thu, 26 Feb 2026 18:32:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=zO70dOPDPwPIi1kCgLfEco61Rr4AdTL3sfPay6+nNNI=; b=qFM5vHAAQeGtUVAITDWduIU1oZ
	uPWWsNDA/RaXwJN6BlWzn7KQjeiPm20hCdncdmcVzOY/ni+o7sRCri1f+ims1udeQyM2wqql46VRz
	FNT0SmHv7FrhWRoj+gAfHnJXBalIJCrdmLThaS9wa9mzzX3u9QX0wfmJgzFo4uzrXYNdOk1B3SjiF
	Pgd9BsxRoA0VKwHpygaZYzh99srKhBTsrWAdx4Fpn5x/rtmiBpQMN8dptdlIjoOnE7w3jBEhNBatj
	MebH5fYrqVZ1wrIWM69ipy8VSuo5qg+/ep6YHMlzlxdfsT8BMgdUHaFfMtv0KU7LGs/S3CNv5HoM+
	o47ugePw==;
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgA3-0000000Bo2t-18nf
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 18:32:34 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QHblAm2065809
	for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 10:32:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=zO70dOPDPwPIi1kCgLfEco61Rr4AdTL3sfPay6+nNNI=; b=S16omX7yaI5U
	EvHHK7g2o+LvsTnhgkntqrCeG7RasDNfsE5/Jy/ihI0LQbea4hOtyB/Yn78756CT
	IKxva4Xi17Gad/0gwlWtF+gd2mVaMIYkhd1OorHHds38sB5Mei2awhoPNPRRQAoA
	mgK2JZYdXF3E4H8L94JjXKEx8LZdvvct6V30afhx2jyeGd5qxbY01t+N3QoCKDfu
	IA6+NUORZ5MIzJorRqIKT7/FUEtGY4RRyXrnnv34N5bnLBYG3N3iZd7ZyCkoLg3a
	9kgvG1XdagOx/dYRPhitMvbCHO3wxu7Caihv4dsDRYQ+CRNdn5Ncy+eji0NGKPSb
	6dW5YQNh4A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cjtr7rpa4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 10:32:27 -0800 (PST)
Received: from twshared26368.04.snb1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 26 Feb 2026 18:32:25 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id C931190B6941; Thu, 26 Feb 2026 10:32:16 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <nilay@linux.ibm.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/3] nvme-multipath: rescan siblings on last path removal
Date: Thu, 26 Feb 2026 10:32:15 -0800
Message-ID: <20260226183216.2098584-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226183216.2098584-1-kbusch@meta.com>
References: <20260226183216.2098584-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: gTV9iJdE87e4PQMWOvVWkT69K9e2tmBt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE2OSBTYWx0ZWRfX9yD77SCDd9Y1
 GAMT06TulhgGtXYgxzswVzXvXQVIaNI24i7hlE06gyIWEX4NrRAdTXvvrSQgSF1H+F2RN7Q9FzW
 6duUh1budiaVMNVVUyPuRnSvwJPesrUfAnaarSdXdRuaxLkhqnw34D4vH9S8/kcN54JDA2sRxte
 Wktuav54HPEUqHjmlb2TkT6mqr4xqPy0wv02IWm97yOhn1VMXlacdCAA+T9gGRziptlgQFobOUk
 H1e+C/iHm5d4WPFwRECglHKJMH74jfExPX5vaGDCo+U6/SWuMZ1rwYxA1kI5/MvJSXxrg+00CqI
 XHvXIMW1WAALtkis5WWslGTMEWrxNz43SLCxkf8gxcTG/OwQ8aK8uQxxgqJBhXLnaAY55hezVO3
 X+p5N2oUL3rzNMIT/zFGRs7el7dT99Uwkgam0RpBOfoN6yoCPxNbilRUYbADAimcS67Ju17DjFn
 Ka2DUzTJYzzHg/ZXahQ==
X-Proofpoint-ORIG-GUID: gTV9iJdE87e4PQMWOvVWkT69K9e2tmBt
X-Authority-Analysis: v=2.4 cv=Xrn3+FF9 c=1 sm=1 tr=0 ts=69a091bb cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=8yUaMuhik-1QLHZ5_1wA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_183231_850915_0742632E 
X-CRM114-Status: GOOD (  15.68  )
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

When a controller's scan removes the last path to a multipath namespace
head, sibling controllers in the same subsystem may need to rescan. A
concurrent scan on another controller could have encountered the stale
head with mismatched identifiers (e.g. from a recycled NSID) and failed
to set up the namespace. Without notification, the sibling won't retry
until the next AEN or explicit rescan.

After a scan that performed last-path removals, notify all controllers
in the subsystem to rescan by requeueing their scan work. This ensures
that recycled NSIDs are promptly discovered by sibling controllers.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 19 ++++++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3de52f1d27234..5bb4b18511b7b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4262,8 +4262,10 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	mutex_unlock(&ns->ctrl->namespaces_lock);
 	synchronize_srcu(&ns->ctrl->srcu);
=20
-	if (last_path)
+	if (last_path) {
 		nvme_mpath_remove_disk(ns->head);
+		set_bit(NVME_CTRL_SCAN_REMOVED_NS, &ns->ctrl->flags);
+	}
 	nvme_put_ns(ns);
 }
=20
@@ -4530,6 +4532,21 @@ static void nvme_scan_work(struct work_struct *wor=
k)
 	}
 	mutex_unlock(&ctrl->scan_lock);
=20
+	/*
+	 * If the scan removed the last path to a namespace, notify all
+	 * controllers in the subsystem to rescan. A controller that is
+	 * concurrently scanning may have missed the namespace due to the
+	 * stale head still occupying the NSID in the subsystem list.
+	 */
+	if (test_and_clear_bit(NVME_CTRL_SCAN_REMOVED_NS, &ctrl->flags)) {
+		struct nvme_ctrl *tmp;
+
+		mutex_lock(&ctrl->subsys->lock);
+		list_for_each_entry(tmp, &ctrl->subsys->ctrls, subsys_entry)
+			nvme_queue_scan(tmp);
+		mutex_unlock(&ctrl->subsys->lock);
+	}
+
 	/* Requeue if we have missed AENs */
 	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
 		nvme_queue_scan(ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9971045dbc05e..e73cc2e67ac51 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -329,6 +329,7 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_SKIP_ID_CNS_CS	=3D 4,
 	NVME_CTRL_DIRTY_CAPABILITY	=3D 5,
 	NVME_CTRL_FROZEN		=3D 6,
+	NVME_CTRL_SCAN_REMOVED_NS	=3D 7,
 };
=20
 struct nvme_ctrl {
--=20
2.47.3


