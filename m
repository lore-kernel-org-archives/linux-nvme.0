Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D02FC54F32
	for <linux-nvme@archiver.kernel.org>; Sat, 24 May 2025 09:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RyWZoytTO8gJnukbyJ8p6K0q5yPRbhN0XU/TjyAL9VI=; b=m8z3wWPWYp653q+CRv5q6eKeF/
	6TvzGjcEsqBbm1pmkQ8hJ9tDuD/gcuakUYSpevoFnsmhCK24WzxnHgWx0WhwMjAJ+7o6D/qCVKAoJ
	656iUVejiphCxFDR2wjlVE83kptmsACNkH8efEDhxdKZWL8UeXwtOVF0zD22ezHcbkHPFFkmyX8u6
	AMo8xobAVqrdD2ykGFCDL03HAciLxmnZrvVW4JEF0Ojce6MdIaZNncfAchpvrUS9GqH+K5DJVueRk
	JFTkrnnSoQ+pl3tjEka8J5OHrAj8r2gPa8l7ly2lpRKB6vwiddvzOvAXcAutQesalxO/WAK0/igEK
	e/R/ApSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIlAl-00000005fpr-1VwG;
	Sat, 24 May 2025 09:28:07 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIl04-00000005erE-3CTA
	for linux-nvme@lists.infradead.org;
	Sat, 24 May 2025 09:17:05 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-3109fb9f941so805270a91.3
        for <linux-nvme@lists.infradead.org>; Sat, 24 May 2025 02:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748078223; x=1748683023; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RyWZoytTO8gJnukbyJ8p6K0q5yPRbhN0XU/TjyAL9VI=;
        b=eTvCaxFjMVnvfqxDtwd3vBylJdoxJOcAeei3SDRDUtRctPlwbLuH3EnVb1zPr/DX7s
         lPAfLRKDAhuyLl3HTAcsBTAdARsseQFFKcM2qwDvC42aNHtTC7pX+8RoppxcjqIishtG
         74m27rcmeHy0qtqcf2NrxavDwbLtbfXvf8NxbzbHU6uar6L2HBE9p9lWEBnGYyvCzuF1
         NtuYoE/DXneJWpvAIqWoa7BDNPGrU+AqgI+FiA/mBpJRj+fPl6WjbFs8CEIvSteCgiwr
         +IxobArbN1Uv7d9mSl7sU6SwhKJIGp8PGRCsvMYrcNyEjeGiZdOh00CZTzp2/q7SkuCn
         SzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748078223; x=1748683023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RyWZoytTO8gJnukbyJ8p6K0q5yPRbhN0XU/TjyAL9VI=;
        b=bTIzNOS06E+Me5Ei6UGQLF+ohgNjyJfR+t9U6w2uP6+tgQI6c1L83owBKYs/gK2+UL
         ZeZCpk+Ik+pYrqXX7NOSAAO6+tBeHhyt9Wn95gsKr7YZVHR4K6oLgq4csuz57QeE+ciH
         ZHckGMvwHSqBK81bec0DyyOcaTqclUOXecq6sQX1u9SGVKsZwGqwqewWPP25XAaUpq6/
         7sjcfMEkyGwlPDuc/NefCIhramKEBY3RAas4+I53TncU+OZsfHSML69i1TSVriLsMojd
         0SpD4eKkrWn0Dkpmudw6RP/Tq1DxYirG8xj9gLxDSYoPc0xNjEwH9DfHORIp7XmuxQUM
         GNhQ==
X-Gm-Message-State: AOJu0Yx6jWAbxmPui3akhCqdv5xJ566xVuB9BbKZE4UrIsKla3P8Cpiz
	V/wvbVgc1DkST14ouS5yan55fB0BZfh0liZsUKWwvluLWRUiDpssu2r7DQpImg==
X-Gm-Gg: ASbGncsQkU2JpcpQ1VY5bi6/3TW0oY4FMHYGgaQTTUqJWyfJT2UJ5KIvswDC4zB7tpn
	6oHj1xP/xNTT1a9wrscOHUSao0IvSVeCddYkXsiaRHWWwP3eHpv7y9lLbcBJOeL9M0Ms/FbdgWf
	JY5Mxk610my7PtOjsMIDlgHcjoFwh1q8Y4JmhKUkUxIn30Yd+sFBHrSRuk1Zpqr28ikE+waxOo3
	vutfEz/mKulNVrIcfft1SJaQk6/HmH2AJY91/37RWvHO/rop/g4nFDFGYLDwKHLORJ7AsjYP9D/
	9rDoCVtZxET9uFUIWgyG1m/8PvbopJ9GwFQqAUYL0l2w+4YZJs09m42PETO3aDTAgXVZ26dj/di
	fiQ==
X-Google-Smtp-Source: AGHT+IHixhO+vsaCwao66IHA6TTEFYvAfWW5KbAI+5TTkETtQVKgUfNRg/Kuaj47gQWSk/gSFiqU5Q==
X-Received: by 2002:a17:90b:4b06:b0:2fe:ba82:ca5 with SMTP id 98e67ed59e1d1-3110f0ec394mr3770300a91.11.1748078223273;
        Sat, 24 May 2025 02:17:03 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:1449:b175:df93:3b26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36513276sm8677604a91.44.2025.05.24.02.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 02:17:02 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme-pci: tagset and admin_tagset sysfs attributes
Date: Sat, 24 May 2025 18:14:41 +0900
Message-ID: <20250524091637.6938-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250524_021704_805489_11A8DC7F 
X-CRM114-Status: GOOD (  10.80  )
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

This is to dump the tagset requests in progress.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/pci.c | 68 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f1dd804151b1..971ababa58b9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -45,6 +45,11 @@
 #define NVME_MAX_META_SEGS 15
 #define NVME_MAX_NR_ALLOCATIONS	5
 
+struct nvme_sysfs_data {
+	char *buf;
+	int len;
+};
+
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0444);
 
@@ -2322,6 +2327,67 @@ static ssize_t hmb_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(hmb);
 
+static bool nvme_sysfs_request_show(struct request *req, void *data)
+{
+	struct nvme_sysfs_data *sysfs = data;
+	u8 opcode = nvme_req(req)->cmd->common.opcode;
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+	int len = sysfs_emit_at(sysfs->buf, sysfs->len,
+				"tag %d (%04x) opcode %#x (%s) QID %d req_op:%s(%u) size:%u state=%d\n",
+				req->tag, nvme_cid(req), opcode,
+				nvme_opcode_str(nvmeq->qid, opcode), nvmeq->qid,
+				blk_op_str(req_op(req)), req_op(req),
+				blk_rq_bytes(req), blk_mq_rq_state(req));
+
+	if (!len)
+		return false;
+
+	sysfs->len += len;
+
+	return true;
+}
+
+static ssize_t tagset_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvme_sysfs_data data = {
+		.buf = buf,
+	};
+
+	if (!ctrl->tagset)
+		return sysfs_emit(buf, "none\n");
+
+	blk_mq_tagset_busy_iter(ctrl->tagset, nvme_sysfs_request_show, &data);
+
+	if (!data.len)
+		return sysfs_emit(buf, "no request\n");
+
+	return data.len;
+}
+static DEVICE_ATTR_RO(tagset);
+
+static ssize_t admin_tagset_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvme_sysfs_data data = {
+		.buf = buf,
+	};
+
+	if (!ctrl->admin_tagset)
+		return sysfs_emit(buf, "none\n");
+
+	blk_mq_tagset_busy_iter(ctrl->admin_tagset, nvme_sysfs_request_show,
+				&data);
+
+	if (!data.len)
+		return sysfs_emit(buf, "no request\n");
+
+	return data.len;
+}
+static DEVICE_ATTR_RO(admin_tagset);
+
 static umode_t nvme_pci_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
@@ -2346,6 +2412,8 @@ static struct attribute *nvme_pci_attrs[] = {
 	&dev_attr_cmbloc.attr,
 	&dev_attr_cmbsz.attr,
 	&dev_attr_hmb.attr,
+	&dev_attr_tagset.attr,
+	&dev_attr_admin_tagset.attr,
 	NULL,
 };
 
-- 
2.48.1


