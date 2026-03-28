Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4A110F3DC3
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2026 00:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ob2hvujo7HUb7R0D4J+lODKhe78Bpwesdjiwn3j8SZY=; b=QH1a8cTBsESyyvf2ci/bxhVJyv
	xw4x62F0iN1PnC/lEf5TaaSLGQ6qDluoEGyYB99/MscUZe/NxVnIcp6Y3GHNwws80ll3qJulIOR4y
	LisyowHrZBzmo9HeBpUuO5CxLvmH0uW7jVre8vPuiyQlqcm9yh7Hyww3RQ0qn0jBpRhgy4QURNlek
	cJeoB7psrwzuigq4OJnEnE/D1JhvjpFtY34oDDKU3hSVugKPc3GiyJ00zN4323dsjMi03jpBM5Lbq
	Q+O1hpM0jOLQbd9sixMuXGaMPy1YiMjQBi4EDEDO4PT4LapRjuLGXHX0Yb0IbCReJR4nkwtm7LpCw
	fbRuAtUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoO-00000008Nu5-44xK;
	Sat, 28 Mar 2026 00:46:00 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoN-00000008NrL-00DT
	for linux-nvme@lists.infradead.org;
	Sat, 28 Mar 2026 00:46:00 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2aecc6b0861so17398225ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 27 Mar 2026 17:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774658758; x=1775263558; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ob2hvujo7HUb7R0D4J+lODKhe78Bpwesdjiwn3j8SZY=;
        b=GPFYMc0b4T1GV/hvQKUbTV1cGZ571uglLTUfQ8yq9Sl3nvUgMuhmRHWv7nvNRFMlym
         bcKHX9PRxrz0RKFu0RFXYDMXBtajx7HEt29rkdkoFsK69wlo5M4j2pWbiWGprLRFx/AX
         YV5HG8pedGolemb2WClibvdA/H9INQcGnOrTCAjbklJUNf52q+qYCLZ04hT538xMzFff
         1uUrX+kUhvX6xNq3lfKrBpYaX9tWZ0YAK8WobtzIfakdmaiFBs+Gv2sQdPDC4T8XvATr
         cUPP88OqjWzh0RUZDEjDdYAb9rL8cjTe/m5FRW/U/j/KffrWzSA3o98sWktdIcl5O/er
         tTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774658758; x=1775263558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ob2hvujo7HUb7R0D4J+lODKhe78Bpwesdjiwn3j8SZY=;
        b=dfyFfCRLHRdJZXZWqA1zU1JPfPZ/P4rz5GT+MQLx+90XVtup5uxDiAwqlE769QN2fW
         Bewm3b6RLTYmlMmPYi2M7iE7ZR8hUkRkmYg7LahQ7Rg8YPIyTikcM/wkESbY1HOY3nPV
         oz1yd7Ex3gMVzzRMI43AFD5XOVQFHns8ADpsriJI5iBFnQR9aPv8Pcb1H7qqJKG+BIfV
         1cn1amhqr3mysExQljoNGYHnQpIwwKPJHqEsvKscXENwTX3vFN1NRGv70oMIRCRCuqP5
         Gl/dV8STFKjw1dfZjPTgFHzwodqbC1cIM3R6GM5A9E4LC87kx1PYL+JXBgm6KGDCgd0r
         tJhA==
X-Forwarded-Encrypted: i=1; AJvYcCWuL+KZ2WEHTyXVozyBOb082S83fAp61/aWK6QnHUgAEWvntM4XpYpalzNbSAIUveVPvj3DGiCWGyv7@lists.infradead.org
X-Gm-Message-State: AOJu0YxyUX6UAxM0jxb01b71xtr3DyVf81hJWfK7ILJqa4EIHmWWCwNZ
	AvTrtKGXOVmSo72Y9y9KJtIuS9oTlHNVbnXBIM3YGtWqA156hZnnE57iWhguJ81ZWok=
X-Gm-Gg: ATEYQzxry0HT2FDiywzukFKig8LEzA3/xj3UdFbW+Hr7ckgnOhNMpQqm8vpG9OKbVvo
	rt4GCkmz17+8If6p/xf8FIf+ZnT+X0V0S9sYET4jPqZzaPClQQmNSo5hGEB5eZ0lGojueaZ2jDA
	oxZ9Tcq+t9MGw4Glwvvf9nQHQ9ogsaIbnGDDhQ4s9nYaAbX4tDMYw0jPG4HZ8Tpeh/5EgTUabAd
	AYBvWyw6QZF2FclQc7IdaU8rfn3npp2zMqAmjxha1lDhqSRsUzUoEoibq81oMhXv909D/kdfB12
	8CRNYd0itlkD9ME8bR23dGZlHTboLoaAF3g4Ni5lnCyoPTsjf91ejvMJ6JysVy3JtoRjg6w/N/r
	B4a/zWtgS9HEyJYPlvkm4DdJ9IbbrMierxWDy9iWYBkyVpLUf9/ROg8PG9r0ZP8SfdC7X0+nV4S
	chaJdZCgnxJAk+YsqgbA==
X-Received: by 2002:a17:902:fc85:b0:2b0:5990:cf1e with SMTP id d9443c01a7336-2b0cdcc8706mr41302025ad.33.1774658758053;
        Fri, 27 Mar 2026 17:45:58 -0700 (PDT)
Received: from ceto ([2601:640:8202:6fb0::9c63])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b242683064sm5342705ad.33.2026.03.27.17.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 17:45:57 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v4 06/15] nvme: Rapid Path Failure Recovery read controller identify fields
Date: Fri, 27 Mar 2026 17:43:37 -0700
Message-ID: <20260328004518.1729186-7-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260328004518.1729186-1-mkhalfella@purestorage.com>
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_174559_040232_A0983CA8 
X-CRM114-Status: GOOD (  12.33  )
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

TP8028 Rapid path failure added new fileds to controller identify
response. Read CIU (Controller Instance Uniquifier), CIRN (Controller
Instance Random Number), and CCRL (Cross-Controller Reset Limit) from
controller identify response. Expose CIU and CIRN as sysfs attributes
so the values can be used directrly by user if needed.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c  |  4 ++++
 drivers/nvme/host/nvme.h  | 10 ++++++++++
 drivers/nvme/host/sysfs.c | 23 +++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 766e9cc4ffca..7a07c23aefdb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3567,6 +3567,10 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->crdt[1] = le16_to_cpu(id->crdt2);
 	ctrl->crdt[2] = le16_to_cpu(id->crdt3);
 
+	ctrl->ciu = id->ciu;
+	ctrl->cirn = le64_to_cpu(id->cirn);
+	atomic_set(&ctrl->ccr_limit, id->ccrl);
+
 	ctrl->oacs = le16_to_cpu(id->oacs);
 	ctrl->oncs = le16_to_cpu(id->oncs);
 	ctrl->mtfa = le16_to_cpu(id->mtfa);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9971045dbc05..234f3872a212 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -382,11 +382,14 @@ struct nvme_ctrl {
 	u16 crdt[3];
 	u16 oncs;
 	u8 dmrl;
+	u8 ciu;
 	u32 dmrsl;
+	u64 cirn;
 	u16 oacs;
 	u16 sqsize;
 	u32 max_namespaces;
 	atomic_t abort_limit;
+	atomic_t ccr_limit;
 	u8 vwc;
 	u32 vs;
 	u32 sgls;
@@ -1280,4 +1283,11 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
 }
 
+static inline unsigned long nvme_fence_timeout_ms(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
+		return 3 * ctrl->kato * 1000;
+	return 2 * ctrl->kato * 1000;
+}
+
 #endif /* _NVME_H */
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 16c6fea4b2db..f182a26b38b0 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -388,6 +388,27 @@ nvme_show_int_function(queue_count);
 nvme_show_int_function(sqsize);
 nvme_show_int_function(kato);
 
+static ssize_t nvme_sysfs_ciu_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%02x\n", ctrl->ciu);
+}
+static DEVICE_ATTR(ciu, S_IRUSR, nvme_sysfs_ciu_show, NULL);
+
+static ssize_t nvme_sysfs_cirn_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%016llx\n", ctrl->cirn);
+}
+static DEVICE_ATTR(cirn, S_IRUSR, nvme_sysfs_cirn_show, NULL);
+
+
 static ssize_t nvme_sysfs_delete(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
@@ -756,6 +777,8 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_numa_node.attr,
 	&dev_attr_queue_count.attr,
 	&dev_attr_sqsize.attr,
+	&dev_attr_ciu.attr,
+	&dev_attr_cirn.attr,
 	&dev_attr_hostnqn.attr,
 	&dev_attr_hostid.attr,
 	&dev_attr_ctrl_loss_tmo.attr,
-- 
2.52.0


