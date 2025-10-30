Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B116CCF9E5
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Oct 2025 03:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gg57DbX152h+KFFdXgeP517P3SWQLEL3rJ/w0rVMxsg=; b=A0X6CcXm4PSzcsEmQyeEXI5tFD
	/ByPkehNpSqdeCwVFkmp4w0sWTE/nnaGsgdvP8skys6MLktS2U04LdO8RlnLQ2WGGXzanEATByf0m
	VGwPToS52M4TDSaqHc9wXaNK9FEr+5XK968/2V398KJlX6HYmWRHvd8GYeuaodYOjWPh3HtlcHv3j
	haN+S3q1bN/PGidItanWKOZkPg+nQ1aww0liyW/iCYlTz4sqLoT3bneOMMeYfPU4+UDLPhKhFGsDJ
	sA/tpVjy61eQDo+WByiljyPIg2DiXUeH+skLGSDl/1yXDXmo3PKuFc0nt9YHjOnvYG0u3/Vx7dmtV
	iRlvr79w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEJhO-00000003Qx6-3IG2;
	Thu, 30 Oct 2025 03:51:42 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEJhL-00000003QwL-3gL1
	for linux-nvme@lists.infradead.org;
	Thu, 30 Oct 2025 03:51:40 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-290deb0e643so4199065ad.2
        for <linux-nvme@lists.infradead.org>; Wed, 29 Oct 2025 20:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761796299; x=1762401099; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gg57DbX152h+KFFdXgeP517P3SWQLEL3rJ/w0rVMxsg=;
        b=jca8BvPiNZG+zgLxFueBE8akDpWbyPtktV2q0LYBROLtHHj0zj54quiUOnfZ0xbMhy
         6H833ara33aYJtpyHQcHDpbKNSO9GclpB5uT16CO4HaveCsP0c+uIxhG8NgRyVgK43U9
         h5l7PYTs+mmcwO4KkhATKJZAx+Whnx+825OUAdJVE8SpIcWv0KvGPcKyjKOUmVu+Y9xL
         ZklvrthaerjgQVJzrTUofLD/DsjCp6cVbDIRDJ9emRM0XTKuXva5vgm6qHCkqIudMPDw
         VNK0mbMQcvWIw8s0ITreBkcayErvGZxUKnNCq53gWrooRORQu3w+N4C2zi/o+r1LOekN
         WnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761796299; x=1762401099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gg57DbX152h+KFFdXgeP517P3SWQLEL3rJ/w0rVMxsg=;
        b=kEJCBdez0GWynixZYL4YYkoORtnBVbW4mVyaOhi4by2QobQqJv50ksIza+omAwLZrO
         rmrSFKasjFMHgLL/TUsVvkFeKS9GP4nxM+T2pnwoz1LN/UDyWIznbV068HvYBki2mQvb
         6idxDitGZex8DBeLoMmMNqkdqqN23C7O6xW77c90PCot8v6WLPZLhf8HJ/ZNGu58Tq5R
         VUUNn8DQoyzuu9JuLx25VdJFZgGzYLQUGquM4DGU+NHsc2aCV6fi88Yh/SQI8STZyC07
         f7UTUmM7Kr/guw6uXUneVx9vpqKwGCIfE5ZZSwzF5irUJzbspgGXEc6Ckk8EfLbUBrAd
         39ow==
X-Forwarded-Encrypted: i=1; AJvYcCXfGxwMssh3YvGidPKZ4UJ8owXbkXNiCfqQgnLTmJ54EZdK/osJQHo+4RZMaHV3kz0I8ze109LCPrkV@lists.infradead.org
X-Gm-Message-State: AOJu0YxsOgeF9Cpb4SB1y9IqSu3tL7Hkz3pIevXMGnoWXEVOS/9vzsXj
	9RZ0t/SYCHcy1/3/gn7xlkJkE/ToMfWXxDc6xvWoBzAh3V6Nz0EtIQjG
X-Gm-Gg: ASbGncuhPWhBX+coiOxWajpoiFEa0uayvxUjN51ChAgzcGWtZwJrvb3C3gWpJTUVQ59
	AT5XFOS7m6VOecUtxRUNHbjp977wTj8/cYmgWMd0nUCwYCHwPhrlKcHGAIbmMRIHJO/x54j4snu
	v4hHex9fCudD0E77A7yG/vEkndHNiHkj7ESzMWiBmbyixMuixt2FJmU7W9r5pJo2+Hgj6AKHN9b
	qY5Re2y+Z2KUMQVvYtbQ26eW2A88T6PsgJ9dIrfnvKGXH/pgRH+F+9qMzUuyOBLNjigGOwihV7G
	D5xXHDMj4sgpy2wprzr51FNh9RdI2GNiYv6qmtYe2+qNFXS4uxj6NZX7fIGGiNyJVQ3dKtb9tFT
	QQEYiIFj2JSFLNEfj6i/uIZTHhvdwdmOHqkS8wNwht20Jmf4kv5ta0+CHx6c2uZuLX8iFhuAGsY
	kRRy0ai9q1PwDtlzlcmKWwHGGUYJMciTM9iU2OtKP7QG/P62mUcj6TiDiSKJDfxX519s9J4/iVc
	XDL2p0liZNPdR7Cq8Fm
X-Google-Smtp-Source: AGHT+IECB4TP3ESqGiKQRZGuWO+zfnfT3ZOQklY1c2ma3P3YZVJziVDmG63qsEJkvCKs8lpqrnfA3w==
X-Received: by 2002:a17:903:2284:b0:294:90cf:699c with SMTP id d9443c01a7336-294dee209f0mr60182985ad.16.1761796299023;
        Wed, 29 Oct 2025 20:51:39 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3381sm167953225ad.16.2025.10.29.20.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 20:51:38 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 3/3] nvme: Allow reauth from sysfs
Date: Thu, 30 Oct 2025 13:51:14 +1000
Message-ID: <20251030035114.16840-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030035114.16840-1-alistair.francis@wdc.com>
References: <20251030035114.16840-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_205139_920064_6DA274A0 
X-CRM114-Status: GOOD (  13.89  )
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

From: Alistair Francis <alistair.francis@wdc.com>

Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
This can be done by writing the queue ID to te sysfs file.

echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/replace_psk

Note that only QID 0 (admin queue) is supported.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/host/sysfs.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..f6994f35324f 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -246,6 +246,32 @@ static ssize_t nuse_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(nuse);
 
+static ssize_t nvme_sysfs_replace_psk(struct device *dev,
+				      struct device_attribute *attr, const char *buf,
+				      size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	int qid, rc;
+
+	rc = kstrtoint(buf, 10, &qid);
+	if (rc)
+		return rc;
+
+	if (qid >= ctrl->queue_count)
+		return -EINVAL;
+
+	rc = nvme_auth_negotiate(ctrl, qid);
+	if (rc < 0)
+		return rc;
+
+	rc = nvme_auth_wait(ctrl, qid);
+	if (rc < 0)
+		return rc;
+
+	return count;
+}
+static DEVICE_ATTR(replace_psk, S_IWUSR, NULL, nvme_sysfs_replace_psk);
+
 static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
@@ -747,6 +773,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dhchap_ctrl_secret.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
+	&dev_attr_replace_psk.attr,
 	NULL
 };
 
@@ -776,6 +803,10 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 	if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
 		return 0;
 #endif
+	if (a == &dev_attr_replace_psk.attr) {
+		if (!ctrl->opts || !ctrl->opts->concat)
+			return 0;
+	}
 
 	return a->mode;
 }
-- 
2.51.0


