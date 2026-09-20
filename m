Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF921C982DA
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 18:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+9AGoVe097CFQTljKQVnFARTDua53EnwrZ8dQWbEJDU=; b=pewTAVDEHw89QX0dWP33kFmkl9
	HbC9bRlsT+KFBtFzerftZbtq4UigSPz8XNctyMmsnespo69LjVgf1sF9hjeYOhBLMqlnBEjkGKH3N
	YlBTdl/0aepQlxlORzcdGSO7BPv+DD+f/Hzz3XD1uzeozo2+EnIc1ZdykDkan/LSDrLRQwWDitaJO
	nUd42YFN0fJLVgMClse+rhqZkDf4p3t7262DPfFy3vQIBGVjdPgC3pSFbMF/Ki91CquOy1eBqCbNI
	KgCsQ285qJdgL8HmJVLHjH0lnA7FzZ5vZpc1FIGp15Q1HqQvIElQw6ZvZ3PLNxIV60mlsjXsm3xma
	fpYk5qQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJ2-00000000DoY-1DzA;
	Sun, 20 Sep 2026 18:30:28 +0000
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MIz-00000000Dlq-2CHR
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 18:30:26 +0000
Received: by mail-pz2-x0e.google.com with SMTP id 41be03b00d2f7-cc1cea34f01so1925603a12.1
        for <linux-nvme@lists.infradead.org>; Sun, 20 Sep 2026 11:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789929024; x=1790533824; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+9AGoVe097CFQTljKQVnFARTDua53EnwrZ8dQWbEJDU=;
        b=EPGcmHqOJ+8F641jCE00VambMT+c2LLtHOpjHYL3Xap4IbK6oAfUn8fGSa7El5G166
         pEAyZtX2kmeOBLFXoRa/JC3VnuZZMQiFm0X//uf18ar4s2grw8xNvA2PFcGVAMfWIOyT
         ROAsynLYhJTjrgcxB2P6+ULdX94tWzDgk+kBW49Xz7Z1SCSWKTgcJ6IAkQBVhm8FyYVc
         5sMX0DZ4mBaOz097oPzly6+0LlmPVYpOo6VbJYEDjjq78IO4rXbDpFSk19/YoMAbrNz1
         zLUgH3Wgh7lECbgzl9lreK1uY8zGRn8JgUV5DnM09mfF+pS2GY9IaMr3mD0jz5oO6EZ3
         iSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789929024; x=1790533824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+9AGoVe097CFQTljKQVnFARTDua53EnwrZ8dQWbEJDU=;
        b=oazeV3wPvrRqQqTSdm3ohEZ9DCM6/+d+G4kFFPx8pMRqgLPBGylwa5gNP8auek3TGY
         aXHQIfVRSiaVFwVTaeB0/LhKKttud2jyePcUMiaMLkJ7vwibJeSofwTziGnH+/nFiy/n
         okA7VLStEUftt8j0v2uOq6H4BSmGAbF7ebGOSCC0s23RYWfNth1jC71EtW+7prlWO1eA
         PtQC6AsPel4/DvDmxB7pByEsLobmseGUKGZmpfIDIrEkf8qPXNTO4Qn+W4N1pM7HHazc
         0gPXywfMCf1pGED2clyHnWZVflDQwtDQn04rbwJV5kVdcrBZ9Cv14x0AEmqI9B5uqTSH
         ro6g==
X-Forwarded-Encrypted: i=1; AKwUvBzyDSGZPdm3lHxXsM2MXu4N493SfhXVuMkVqcnfLjPuBZFPFlr/RZPVUtecNpfhPwtj+CIEihGn0mBn@lists.infradead.org
X-Gm-Message-State: AFuF++lqt0tu4LlA4F25f/l3jzvhbLGjKGN6U6vPng0dCE50yxNp4ufD
	q9amwPl6ZYzEk9nHADJ7R9DmTuyEbiNjHI9hmynQTclzbJwldnyYVv3IYMQhauvX1c8=
X-Gm-Gg: AYBFou33ACbIY2UWf0f0nFfn8kG+CmtGaJY0z7K7qqTgKYEd9BvjRAQ6DJx23d0SP/9
	J4G55CmBQdS4SqP8FjQpktzZ5oW5M3CIV3ayDQzTQ2MKjF/fu4CrG6L0uSIDI9bcc2SzpBXE1eQ
	XMG31KLSfRTFDOZU8cH1+Q2fp7gT1ovZcXVR2bN//T6er285wro/FOwgAHv+kKgFPRuwYa8a7zY
	NoMdj/8JAJQ7ZMAk3Cy57dtfoOeLs4d9XPFIT3IfUsdaGX+bPpv3UzJMGxAK7aMYBc69hR7ady1
	cTDlJoG2f8Y9giVI9JWt6W8VwGu9175Qte6TX5CJNPPjEYemlpa6AcQj3CTYv9PWOS0cHMt7FZv
	XMVBN1Hxiwp284cByEv+N8YY848J75/zidWBuONDNoQCNxhyz6UXfTUYJ/d7nlnYnzxNMw9EF3u
	DfnvlfDyO/j4MBmtsUc2mMeEkC3RnNg6htLnAlxvrlOiRSEqtgzwsyhhngSbyUz/vRQOY=
X-Received: by 2002:a05:6a20:9e4a:b0:3da:e1b5:2baa with SMTP id adf61e73a8af0-3dd8c3f80bcmr14827589637.2.1789929024412;
        Sun, 20 Sep 2026 11:30:24 -0700 (PDT)
Received: from ceto ([2607:fb90:9c20:5ac0::1d8c])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-144da432647sm20924589c88.5.2026.09.20.11.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:30:23 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v6 06/18] nvme: Rapid Path Failure Recovery read controller identify fields
Date: Sun, 20 Sep 2026 11:28:04 -0700
Message-ID: <20260920182936.2317916-7-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920182936.2317916-1-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_113025_560570_4794A3E6 
X-CRM114-Status: GOOD (  14.04  )
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

TP8028 Rapid Path Failure added new fields to controller identify
response. Read CIU (Controller Instance Uniquifier), CIRN (Controller
Instance Random Number), and CCRL (Cross-Controller Reset Limit) from
controller identify response. Expose CIU and CIRN as sysfs attributes
so the values can be used directly by user if needed.

Also add the nvme_fence_timeout_ms() helper that derives a fencing
timeout from the controller keep-alive timeout (kato).

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c  |  4 ++++
 drivers/nvme/host/nvme.h  | 10 ++++++++++
 drivers/nvme/host/sysfs.c | 23 +++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 758245c799a1..ae7c04b77a3e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3666,6 +3666,10 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->crdt[1] = le16_to_cpu(id->crdt2);
 	ctrl->crdt[2] = le16_to_cpu(id->crdt3);
 
+	ctrl->ciu = id->ciu;
+	ctrl->cirn = le64_to_cpu(id->cirn);
+	ctrl->ccrl = id->ccrl;
+
 	ctrl->oacs = le16_to_cpu(id->oacs);
 	ctrl->oncs = le16_to_cpu(id->oncs);
 	ctrl->mtfa = le16_to_cpu(id->mtfa);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2cff9fcbf740..cb9d7f45188f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -393,11 +393,14 @@ struct nvme_ctrl {
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
+	u8 ccrl;
 	u8 vwc;
 	u32 vs;
 	u32 sgls;
@@ -1339,4 +1342,11 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
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
index 02a2490a9ed7..b60f5b66a1d1 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -487,6 +487,27 @@ nvme_show_int_function(queue_count);
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
@@ -941,6 +962,8 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_numa_node.attr,
 	&dev_attr_queue_count.attr,
 	&dev_attr_sqsize.attr,
+	&dev_attr_ciu.attr,
+	&dev_attr_cirn.attr,
 	&dev_attr_hostnqn.attr,
 	&dev_attr_hostid.attr,
 	&dev_attr_ctrl_loss_tmo.attr,
-- 
2.55.0


