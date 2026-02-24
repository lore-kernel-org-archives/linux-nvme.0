Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC82F4BB73
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 18:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WUhmbuDqZUMWEL8xl6csK1HhYyXb3sglBFpLNbSUWCw=; b=5FsR1+slEimf6G6T506+kotqjE
	Sd3jqMonS5ytoxS+s36uKFqc53OhnoJmCWQ03X07ya2VT10kLLjo+eJS9ytlCUrL/vQxp+XALMNar
	ki+TcLyasAG7aPy//4RUW2C7N47v5qFfUSjNujkzscWJAzEnSfZHiC9680+LDJlAd87OHepBknM8L
	diuxTR9ZqXmZA3e2dT80A2efiE20vZAd3PeFuiYRDJz1tYNBL8E29NAelZKqoiVJn0CYumBtIumBU
	lBa7FNQkbKKK2nxyC61XmPOIZfKy9MDrFZjsRAmEE7CL9djdgCXzUVSbDnjsihYeqmEFybeTevyYQ
	/M9xlQIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuxVw-00000002eww-0PYf;
	Tue, 24 Feb 2026 18:52:08 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuxVt-00000002ewB-46Ii
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 18:52:07 +0000
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-2ad3f12a496so447555ad.1
        for <linux-nvme@lists.infradead.org>; Tue, 24 Feb 2026 10:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771959124; x=1772563924; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUhmbuDqZUMWEL8xl6csK1HhYyXb3sglBFpLNbSUWCw=;
        b=RteMyArSELtXb3y+0HIvTfbLZZvXW/2YyehwifRyg14iFoMO7SuvEVL93S/M8kCaNV
         Kn/mfy3bHv7xfb8qeDwBoQ6/nsZy9hJJOdj1urafxQ9LViXXIuEGBQATK9u42CN+hS4S
         13Da/9BDuZXsJsdRKrAs+Nnfs3jzXpEUrojDXhbajPPRTeLwq/XsoWMCSO67jPUaTEJw
         EWis6XdSDDRWaQwHHiBC+ZEc2yeWvnpKMT0dN6alwToKTk11jI+t2o/1klSpvtL93Oes
         ROPBfeTWF+yzWqN6KQOqvI55sUSRLVAFDFzPrbT5J4ty1IsGLg/73BP90Upcy+OM60AK
         Fkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959124; x=1772563924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUhmbuDqZUMWEL8xl6csK1HhYyXb3sglBFpLNbSUWCw=;
        b=SPI9I/15LCTpnM9L6R/9647FjgawZ4rDVo2Fs3RuvHHGYAIkOMRA3EcP3wxoNrQakr
         9XtUDDxDt98cumkxPtH0rAEzptP831jzSdCb5wY68RFk/UBp5VR/C85q17O4Wh7lRPn1
         wwr57Y1day71I2GvYVBuGCb9biKfWz+Z2zv70lv6dU5kDTLPjhOkVE68eIV+T+lL047e
         /H6pZ2Skf4eEnT8OcxddJL4Ha7yFajfVbUG56vlyFpSlUxEGIDu3v+G6ZeSAwQlhk3VB
         5xS1TzzKymlewC1wPhf5I/hXfUSM/7B6/SFHfVN4Z6cGOGNDv1tVgczbDztKde4nqubx
         42Vw==
X-Gm-Message-State: AOJu0YwNZmyGbka00H9IjdRlwSscDawgt9TLU9EA0ZkuZBzsSaM4ZMfR
	Xxe/t+K7KQQ/oIUjnbr1V+HQm8IxUV3xqVwK3GgFbvspl4+f69TSp7y3BQLDrESN
X-Gm-Gg: ATEYQzw88VsypflsQpuNVbxpup8XUjUW/clquH25TG3e9bBATkm7eyY8q3K1jjCZB/h
	cIcaTmALN7i7fb2xu/4n2H44s3CJ2DafIuGdNCqlnq7iTL+DVpdZ96KzYJtj3uPMY14IGVWMWfh
	q33o8ArYab9VaEcg5+Okgr3HXK1QmjcWKMJBfnb96xjo6210saEpK32PWD421OQcn5+UttmCF+Y
	YMfIqKrbi+yxMZFJMhIVKZPTf96XvGn/PeBmrSV+mb9s2fRdLbTdjbZeeBNdpdior5eXP8/p+uX
	2nj4zlYE9rUdXqCZihu8NJ7vXYBmRg152oucwk6eyBJ4ml1TwEvypT6CmDSmLbgpCZCW1VXcgHq
	FogaWe78HdaMcUvLWJpB3CLNcDLRMRE/FKGOKhhydtU00aRMyALRDIdibDJOdqLm5pkMl8iF/FI
	EZbJblqnIqqL7B4S/6Ctu2aGXDlQaPi3ygW5zZKStXNEqQG2g=
X-Received: by 2002:a17:903:950:b0:2aa:d2f4:9c11 with SMTP id d9443c01a7336-2adbdc0fd6cmr8897365ad.5.1771959124203;
        Tue, 24 Feb 2026 10:52:04 -0800 (PST)
Received: from tokunori-X570-Taichi ([240b:10:2720:5500:7716:a9ad:62c7:16d9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad9f1d4b03sm29132775ad.29.2026.02.24.10.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:52:03 -0800 (PST)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme/ioctl: allow 64-bit results in io-passthru command
Date: Wed, 25 Feb 2026 03:51:20 +0900
Message-ID: <20260224185159.20247-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_105206_024170_A182BF5E 
X-CRM114-Status: GOOD (  12.99  )
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

Deprecated NVME_IOCTL_IO_CMD ioctl on the char device.
But nvme-cli still uses it and NVME_IOCTL_IO64_CMD for now.
So add NVME_IOCTL_IO64_CMD also to allow it.
  Note: 32/62-bit ioctl duplicated code should be refactored.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/ioctl.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 8844bbd39515..ff7df944ef53 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -845,6 +845,43 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
 	return ret;
 }
 
+static int nvme_dev_user_cmd64(struct nvme_ctrl *ctrl, void __user *argp,
+		bool open_for_write)
+{
+	struct nvme_ns *ns;
+	int ret, srcu_idx;
+
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	if (list_empty(&ctrl->namespaces)) {
+		ret = -ENOTTY;
+		goto out_unlock;
+	}
+
+	ns = list_first_or_null_rcu(&ctrl->namespaces, struct nvme_ns, list);
+	if (ns != list_last_entry(&ctrl->namespaces, struct nvme_ns, list)) {
+		dev_warn(ctrl->device,
+			"NVME_IOCTL_IO64_CMD not supported when multiple namespaces present!\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	dev_warn(ctrl->device,
+		"using deprecated NVME_IOCTL_IO64_CMD ioctl on the char device!\n");
+	if (!nvme_get_ns(ns)) {
+		ret = -ENXIO;
+		goto out_unlock;
+	}
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
+
+	ret = nvme_user_cmd64(ctrl, ns, argp, 0, open_for_write);
+	nvme_put_ns(ns);
+	return ret;
+
+out_unlock:
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
+	return ret;
+}
+
 long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg)
 {
@@ -859,6 +896,8 @@ long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 		return nvme_user_cmd64(ctrl, NULL, argp, 0, open_for_write);
 	case NVME_IOCTL_IO_CMD:
 		return nvme_dev_user_cmd(ctrl, argp, open_for_write);
+	case NVME_IOCTL_IO64_CMD:
+		return nvme_dev_user_cmd64(ctrl, argp, open_for_write);
 	case NVME_IOCTL_RESET:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
-- 
2.51.0


