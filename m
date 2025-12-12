Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB30D49230
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 14:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vuD6qbHIgq9pKR7KgcghP9my143yTDO4Mb8hbD87NHw=; b=C9DmyWoXR3lxv9QH5jUTCXlL1b
	whQAUkJsOEQq5tHH/1e7kzniOEBjSHQBWhRbmA984Sydq3js0lzPhfMFup6nEyrM3HahP+WKOjfyB
	WEO/coFZ4uTTEP1+kNKrqRPnGXQShPBtjYqe5GeW9ovNKzTkuVRdCLLiaLkgHsRnGuD0jgy6cZLT1
	c8VM5uo6tDqxKKNWA/jzYDqdCu46djNIvq7Ms8/y/UaNrhujUWrUvWNq17gQG+N5cw9fyD1DhGGUU
	V9w0WwfnqcMubS7YRO12NIyJyS1Q2AX63CNgVTQWkDrOr685RJJ7YfomsQ0zdaJ60ejlU8Hw8MkgK
	TaeA07tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU4J6-00000000cdG-3Io4;
	Fri, 12 Dec 2025 14:39:44 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU4J3-00000000ccf-0upr
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 14:39:42 +0000
Received: from localhost (<unknown> [192.168.3.39])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 1ab4d11f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Dec 2025 15:39:34 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Dec 2025 15:39:34 +0100
Message-Id: <DEWBDGVMPTCV.3GCB8TB0YS9DT@bsdbackstore.eu>
Cc: "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: Let the blocklayer set timeouts for requests
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Sagi Grimberg" <sagi@grimberg.me>, "Heyne, Maximilian"
 <mheyne@amazon.de>, "Keith Busch" <kbusch@kernel.org>
X-Mailer: aerc
References: <20251204-tests-bryce-8b3b2823@mheyne-amazon>
 <aTGzL5t7Gu1tpebp@kbusch-mbp> <20251204-pause-lima-29ecb942@mheyne-amazon>
 <20251205-myopia-been-ed739f86@mheyne-amazon>
 <1b396ea8-8256-48bf-bee2-92e500f3ef80@grimberg.me>
In-Reply-To: <1b396ea8-8256-48bf-bee2-92e500f3ef80@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_063941_616056_A8E49585 
X-CRM114-Status: GOOD (  13.30  )
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

On Fri Dec 12, 2025 at 2:43 PM CET, Sagi Grimberg wrote:
>
> Perhaps you can simply add admin_timeout sysfs file for the controller=20
> that would alter
> the set->timeout and take the value from there in nvme_init_request

Curiously, this is something I was looking at recently.

Could it be done by calling blk_queue_rq_timeout() in sysfs and removing
"req->timeout =3D NVME_ADMIN_TIMEOUT;" from nvme_init_request() ?

From 1a36c2fcafc2502298d25da64cf3740721560f30 Mon Sep 17 00:00:00 2001
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Tue, 11 Nov 2025 09:13:58 +0100
Subject: [PATCH] nvme: add sysfs attribute to change admin timeout per nvme
 controller

Currently, there is no method to adjust the timeout values
on a per controller basis with nvme admin queues.
Add an admin_timeout attribute to nvme so that different
nvme controllers which may have different timeout
requirements can have custom admin timeouts set.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/sysfs.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..da83b13d2cdd 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -601,6 +601,36 @@ static ssize_t dctype_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(dctype);

+static ssize_t nvme_admin_timeout_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n",
+			jiffies_to_msecs(ctrl->admin_q->rq_timeout) / 1000);
+}
+
+static ssize_t nvme_admin_timeout_store(struct device *dev,
+			struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
+	u16 timeout;
+	int err;
+
+	err =3D kstrtou16(buf, 10, &timeout);
+	if (err || !timeout)
+		return -EINVAL;
+
+	blk_queue_rq_timeout(ctrl->admin_q, secs_to_jiffies(timeout));
+
+	return count;
+}
+
+static struct device_attribute dev_attr_admin_timeout =3D  \
+	__ATTR(admin_timeout, S_IRUGO | S_IWUSR, \
+	nvme_admin_timeout_show, nvme_admin_timeout_store);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -742,6 +772,7 @@ static struct attribute *nvme_dev_attrs[] =3D {
 	&dev_attr_kato.attr,
 	&dev_attr_cntrltype.attr,
 	&dev_attr_dctype.attr,
+	&dev_attr_admin_timeout.attr,
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
--
2.47.3



