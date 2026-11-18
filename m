Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9F2606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GOrOkg6j;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fDkkhu30
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=+HNpTCd6sDt/VlgK5OmnmAY/0OzLR9lDcrSRtLpGGP4=; b=GOrOkg6jsTc9tVq/vwF9eOE5GJ
	+S7VS6f634BBzAx0XLLg9z8crdHIN2z/KnB6OmLauLILzh/cIJsfa7Pm7aa2u4TCusWP1FpZ+oY+V
	JmutsMHXuefwerYRzsw/mwpjFyhVHepCdVuF/uy2S1LMr5IuXFzNPxd1ReKRzMnzrBOLTXW4WRRsA
	X6ENi0pATTnV5YatKrJ25Ob4plUCS40JzCOmQuEwz1dr6xSTTDuoG8X7wrL4SqPG3mb7bLKQPooMW
	/QQA0RpXlDiLPEW94acs/43zUJFgTs06Cu4XcggX974rlprKM+syvfmn5no6mW0XUBE+/qKA10AOI
	L6yhhaeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTcWO-00000008UkI-2zSY;
	Wed, 18 Nov 2026 10:04:08 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTcWL-00000008Ujc-31ea
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 10:04:07 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-cdab938dc83so437959a12.3
        for <linux-nvme@lists.infradead.org>; Wed, 18 Nov 2026 02:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794996244; x=1795601044; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+HNpTCd6sDt/VlgK5OmnmAY/0OzLR9lDcrSRtLpGGP4=;
        b=fDkkhu306oOhq0+3s5H5qP0ddKNc0ARr5WiCWhZQaqiFlgKY8+b9/4Vt0ObhOKlJx3
         epfJNBey3Z/bGHn7cAbQ31ea2uMCe+56Y4ccQ+Mc/pLhISZkl2Cf/HdH6vVQI3p6p50T
         nxsazvHZQ1Zj7ELsXOoeBX6L80GKl2JNiuglKIj5fDsvmxwpXY8Lh5QgyZFEReMtW5gX
         aAlImk2Mp+KsghLEsvAwpslLsRQXJFZQsIo01UORi6ya1349Cx6t+Sc+7kpsJUlipdTS
         5a/nvmwB4P7hc0Mad+FltjWZKP7OtFkLLA7YkSg0oC/JHb9O2zx2TF6RbUPnbkzn44lD
         9Mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794996244; x=1795601044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+HNpTCd6sDt/VlgK5OmnmAY/0OzLR9lDcrSRtLpGGP4=;
        b=Zk7zhROwcfHmp44e7HGA0+mc+3rQ3fyssXlOk1wIBSLgGJHFEOgVj76BcaI4S3mkzR
         +wbgdvwIwB/XkY9OaxF8yUgYP7KGzUsQIzX8ogyew8rtpDP2smRx+EOoZz/9+cikx7CQ
         bO17nyEx6r0kjJPLmKKBDBo5C1OHEAk58XHScMSzF/qa+783b/QHzE/2RJw5eKR5MeD8
         v/TSECOELcq1Y+rk8rCTyotsZ8k7xIlENowCR7kmePVtDag48LFGLpFP7xiBOv/hR6g+
         yT/gUutsq8fH0H5gnQEnN6yr/AKrmedRy+tk49ChS1Y6PkN0CuZNpSGatPVd+vr5qK22
         jbNA==
X-Gm-Message-State: APuU4Z+bjhuplKgPpQlVLUJzjQGMP+Xjptqjvibh2SsYUo4QvWf5wf+7
	V8JdV6Nollb84wFdWSwPBOItA5JwL5tBpaHqtfaJDrB45diqu2fTwx3KzsawEd7B
X-Gm-Gg: AZFdTZebTGPriP/ySoajntMQYEawZKncizDDWEXysaZsFmoJytFzXSvUtinBjeYCl/6
	22ISLPcSvBYHWMfYA1QoHzWg0/lG0NwzW5blr6DUHtoSQpIsr3rwZTCd5UK2nraHpthePpaASMZ
	omvCVT1PpvWWTMNCsyVN8Y0Zm28JFucx+Cfr8woDzX16CTFYjkQwsA8IypSZ+js0mWRENzdFY8W
	TSPfl8NQ5YhwMLaGsOzyT12vpbXsBv+cEy/8ZbSYHAmIMbfzgvACpq4Aq67tcCQhW+TC0FH1F4n
	ma7+tsuBiXRzDFmEDyYsTY8fEhP2hQsqDVXO8qVclFx4w2tMu7N4uXxd3IGtS0Hti+OTYanFI3u
	6t64afgf1Naa0i0ZLQK8tdMdf4XnnRIhFqyX2PKb+/27dsSRlV+KV6p5CqdqS+twgeFuwX3glht
	cdAjq35P308+NueJ4Jto5zzwK21iE9QUe8e8f5Z/Zcq2alYRmBqESYDWguTTK/3qYwB9cnhkHC6
	kJ7S3XnlDZnHm9jOZKgKFCGPJ/OCp+9lEOod6IQ+LSqMWh92as6UNyFikVZ2CuLeB3V1SxkVW7u
	EH4j7Pdnh/NqPknngJ4olpA/2+P1yg==
X-Received: by 2002:a17:90b:52c3:b0:3b0:a3eb:75a0 with SMTP id 98e67ed59e1d1-3b3d07a007bmr2172110a91.23.1794996244214;
        Wed, 18 Nov 2026 02:04:04 -0800 (PST)
Received: from Ubuntu.netapp.com ([136.226.252.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d0b6b42dsm3684559a91.0.2026.11.18.02.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:04:03 -0800 (PST)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hare@kernel.org
Subject: [PATCH] nvme-sysfs: serialize DH-HMAC-CHAP secret updates
Date: Wed, 18 Nov 2026 15:33:47 +0530
Message-ID: <20261118100347.14832-1-marting@netapp.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_020405_771707_1A3814AA 
X-CRM114-Status: GOOD (  13.03  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dhchap_secret_store() and dhchap_ctrl_secret_store() free/replace the
stored secret and swap ctrl->host_key / ctrl->ctrl_key, but hold
dhchap_auth_mutex only around the key assignment; the free/replace and
the show handlers run unlocked. Concurrent writes to the same attribute
can thus double-free the secret or the old key, and a concurrent show()
can read the secret as it is freed (use-after-free).

Hold dhchap_auth_mutex across the whole update, and in the show handlers.
Keep nvme_auth_stop() outside the mutex, since it waits for
dhchap_auth_work, which itself takes dhchap_auth_mutex.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261116100244.7824-1-marting@netapp.com?part=1
Signed-off-by: Martin George <marting@netapp.com>
---
 drivers/nvme/host/sysfs.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 35f871e3e0c0..5801431f4649 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -819,10 +819,16 @@ static ssize_t dhchap_secret_show(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 	struct nvmf_ctrl_options *opts = ctrl->opts;
+	int ret;
 
+	mutex_lock(&ctrl->dhchap_auth_mutex);
 	if (!opts->dhchap_secret)
-		return sysfs_emit(buf, "none\n");
-	return sysfs_emit(buf, "%s\n", opts->dhchap_secret);
+		ret = sysfs_emit(buf, "none\n");
+	else
+		ret = sysfs_emit(buf, "%s\n", opts->dhchap_secret);
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
+
+	return ret;
 }
 
 static ssize_t dhchap_secret_store(struct device *dev,
@@ -844,24 +850,27 @@ static ssize_t dhchap_secret_store(struct device *dev,
 		return -ENOMEM;
 	memcpy(dhchap_secret, buf, count);
 	nvme_auth_stop(ctrl);
+	mutex_lock(&ctrl->dhchap_auth_mutex);
 	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
 		struct nvme_dhchap_key *key, *host_key;
 		int ret;
 
 		ret = nvme_auth_parse_key(dhchap_secret, &key);
 		if (ret) {
+			mutex_unlock(&ctrl->dhchap_auth_mutex);
 			kfree_sensitive(dhchap_secret);
 			return ret;
 		}
 		kfree_sensitive(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
 		host_key = ctrl->host_key;
-		mutex_lock(&ctrl->dhchap_auth_mutex);
 		ctrl->host_key = key;
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		nvme_auth_free_key(host_key);
-	} else
+	} else {
+		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		kfree_sensitive(dhchap_secret);
+	}
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
@@ -876,10 +885,16 @@ static ssize_t dhchap_ctrl_secret_show(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 	struct nvmf_ctrl_options *opts = ctrl->opts;
+	int ret;
 
+	mutex_lock(&ctrl->dhchap_auth_mutex);
 	if (!opts->dhchap_ctrl_secret)
-		return sysfs_emit(buf, "none\n");
-	return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
+		ret = sysfs_emit(buf, "none\n");
+	else
+		ret = sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
+
+	return ret;
 }
 
 static ssize_t dhchap_ctrl_secret_store(struct device *dev,
@@ -901,24 +916,27 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 		return -ENOMEM;
 	memcpy(dhchap_secret, buf, count);
 	nvme_auth_stop(ctrl);
+	mutex_lock(&ctrl->dhchap_auth_mutex);
 	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
 		struct nvme_dhchap_key *key, *ctrl_key;
 		int ret;
 
 		ret = nvme_auth_parse_key(dhchap_secret, &key);
 		if (ret) {
+			mutex_unlock(&ctrl->dhchap_auth_mutex);
 			kfree_sensitive(dhchap_secret);
 			return ret;
 		}
 		kfree_sensitive(opts->dhchap_ctrl_secret);
 		opts->dhchap_ctrl_secret = dhchap_secret;
 		ctrl_key = ctrl->ctrl_key;
-		mutex_lock(&ctrl->dhchap_auth_mutex);
 		ctrl->ctrl_key = key;
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		nvme_auth_free_key(ctrl_key);
-	} else
+	} else {
+		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		kfree_sensitive(dhchap_secret);
+	}
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-- 
2.53.0


