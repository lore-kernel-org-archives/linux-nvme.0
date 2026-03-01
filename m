Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C568FD0055
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Mar 2026 05:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qHC8NfDCgiQTtJudYMCLR0FG9AzrzsHi2Tw5zWA401I=; b=o7OeRoqld1zpxW7nfIKQ2miS+u
	tWLBr2pjT83vNkL2DzdT/qV5cjS2rsta9OESnXAuHSxNTzkUbLzjNRM7WvjsOoh9Rta0mq5yulsLG
	XG2pmC4X/z1+odP3er0kCbatg8DgPW93goQ1NmyRuiW5YnGEt9OgPJXq9vWYSv1eDbmyYS8GCUj8+
	S6pDn33b36bCcmzhuc+vpf63hMSeWdmLTD5mjTDEUTltjVzfrkkI0C6iXI3t6uZpliMr+MJjIuQrq
	Sl5Qhdxq4JV6BhrXRUJ9UCSXneeyLnfo7EVbdZWsOABFwNvK+mR3Qwcpz2eNOPbqpTG6egIa8gWWL
	vOupQpYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwYz9-0000000Aq5g-1flr;
	Sun, 01 Mar 2026 05:04:55 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwYz2-0000000Aq5J-1Syj
	for linux-nvme@lists.infradead.org;
	Sun, 01 Mar 2026 05:04:49 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-8272ccb554fso2784560b3a.2
        for <linux-nvme@lists.infradead.org>; Sat, 28 Feb 2026 21:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772341487; x=1772946287; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qHC8NfDCgiQTtJudYMCLR0FG9AzrzsHi2Tw5zWA401I=;
        b=ChS0nqlAnoj9B0Fyp34cu4OZxO97h49DSmnf9MlGxIzO+lDn4SryoUvrC89H2GnjP3
         2HjP1kDq4G5cER7rKV5jJp3Svbdm1lYIv00feMbauxuqJEqX8N2T7Wgod5aAPNJDJrCF
         TzQmfJONyUqw216pPGhI67AjCJjsom51IQUAzwGqSX+5gEbeJG6Zs+lgxAbsLDALgcAB
         +snwn6c28FfDY0PNX3S7dpIuORdK2/yPrVRqkK76ytEJPVWXWT98JWbrmXggmxZa1b8n
         KnIaAxD91vT9cHCAPec3nga4itAK/NThDNauaLcG3705QrN96hD7VQGuPAYAKaQCxkNf
         q/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772341487; x=1772946287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHC8NfDCgiQTtJudYMCLR0FG9AzrzsHi2Tw5zWA401I=;
        b=aGsqoYbHCiWctqtmASUwUM1Mc7RomQGN+YdsI8Wm7/6awafxcvCwLaANtBkWACOvVg
         50Im5MuImgR7I10eEa0oYdUip7KnFU1Q8JwbVlVo97xrPewWLl0nOC2P0CwCzzcjvWhn
         PcY/Gpb4IK8HSyqzItjDEemJRzEjDnxNvKtCcX23chw7ngcCZTSxNR/2EX78jP7xqeUq
         fI5h63OdUHy5r+qB2xzOBWJPe+w6VRoM/TC2RFaLJEWUD+nqU7NKrI5pFtc14qEuz1iq
         4Oe0U63v/aSU6UpJG3wBAT1bleN1PYwk7sr8W7/HrExvOZw6heSeCD3eMVRcwepgi2Of
         ervw==
X-Gm-Message-State: AOJu0YyMStGN4XqKhKmmaFRd+R3v3ep9KHjRP7n+RpdwihfszRAIPFjX
	d6kChN+M5s0MqIBKIqD6InbvQjjrKkxwrcf2Vcs0GTAgNt3T1D6HkJyOGX/lKQ==
X-Gm-Gg: ATEYQzwucK21MisqgpaW7TGOLWERXcDlanY8wunQ0plfdJA7lqm0+y1v55Byxa17H/2
	1KnPP2aag6zxid0CwL7IQbb6HyttkiVhkG+2pIuwdE1lo3XYZGRcD2PoLS7AUbn7gMhpSQXywJQ
	TRkr8dbpuRWU5ttvdaqDhRK5kKdXBR2sb0pXWbqWD7oBkhTMyzvjwx7ADmNtxi9QLeGLfN331O3
	Yy2KdBze908kec6XKLDW+7hBFtK4WE7Vmqtqd+6s5LIkM+I2Y4KysjeJCJ9xeoIy40/T+2vHDFm
	SZ6+Dp7AuqzGLRcjeE641piG5uNl9GNs2z6cBCfDytQ54Go2Cqe27ZrAmc0MZTWaevihWUjqtRm
	RPgjPMluDVxXmdfN+f7o9LQeRVQVOUUj57C4J/ZkUoC0UxEqkj7i/8/UbVcqCMJN16JOuBscTbk
	kzJ5G1jbYCGbxLlxDb8KE1qVzfd1Q7EYrQdHUz
X-Received: by 2002:a05:6a00:4c81:b0:81f:3ae9:3f71 with SMTP id d2e1a72fcca58-8274d9d0704mr6541628b3a.28.1772341486751;
        Sat, 28 Feb 2026 21:04:46 -0800 (PST)
Received: from tokunori-X570-Taichi ([240b:10:2720:5500:7dbc:adce:1626:8eb9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d5689csm12297158b3a.13.2026.02.28.21.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 21:04:46 -0800 (PST)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org,
	Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH v2] nvme/ioctl: allow 64-bit results in io-passthru command
Date: Sun,  1 Mar 2026 14:03:46 +0900
Message-ID: <20260301050440.307679-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260228_210448_411615_46034535 
X-CRM114-Status: GOOD (  10.72  )
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

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/ioctl.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 8844bbd39515..d756503c4645 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -809,7 +809,7 @@ int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
 }
 
 static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
-		bool open_for_write)
+		bool open_for_write, bool is64bit)
 {
 	struct nvme_ns *ns;
 	int ret, srcu_idx;
@@ -836,7 +836,10 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
 	}
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 
-	ret = nvme_user_cmd(ctrl, ns, argp, 0, open_for_write);
+	if (is64bit)
+		ret = nvme_user_cmd64(ctrl, ns, argp, 0, open_for_write);
+	else
+		ret = nvme_user_cmd(ctrl, ns, argp, 0, open_for_write);
 	nvme_put_ns(ns);
 	return ret;
 
@@ -858,7 +861,9 @@ long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 	case NVME_IOCTL_ADMIN64_CMD:
 		return nvme_user_cmd64(ctrl, NULL, argp, 0, open_for_write);
 	case NVME_IOCTL_IO_CMD:
-		return nvme_dev_user_cmd(ctrl, argp, open_for_write);
+		return nvme_dev_user_cmd(ctrl, argp, open_for_write, false);
+	case NVME_IOCTL_IO64_CMD:
+		return nvme_dev_user_cmd(ctrl, argp, open_for_write, true);
 	case NVME_IOCTL_RESET:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
-- 
2.51.0


