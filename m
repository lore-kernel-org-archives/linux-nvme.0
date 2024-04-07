Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5C7CD11C2
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 09:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IZz3MC840yZiyjU2iCflebsmKP1jFfr+YX8wQcQ7who=; b=Dk8fBBMJ5JqrQpRkJ8EZDd9Foh
	uU4SVbGlRfd7brlkANIUWOzYPPHuXsv80ShLAZg8csCXfmQmZXCCwgzuovFeNFPsS+2/1nqKMMf35
	dzg1SuZPAc5zKChSkXlPzYagPqapyFN8bglqa3BOr81J4sSWaWMzZq6rBbp/ja1Ll+wGPg+IIIUpY
	TRlEALxajWnTnriv5U2H/h4cno5HZTO9TZXzqHMB6GdWvzz5yRnxjjMN/scm8cNoCWrT+hv+Y/hLF
	vdumuRbeO2LDtTOq23DBpJUEP8BJ2yuiH7TF1ufLQmrUMVnFnIvcJtXcS8h+9BsfmnSSBp8V3HGOr
	EY/86XZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtOcq-0000000CDYU-1AuT;
	Sun, 07 Apr 2024 09:15:44 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtOcm-0000000CDXr-410X
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 09:15:42 +0000
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so2940648a12.0
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 02:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712481339; x=1713086139; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IZz3MC840yZiyjU2iCflebsmKP1jFfr+YX8wQcQ7who=;
        b=e06A8jVZzBSZGqePDxi+Om4BEaFpYWJkWOZwC8F5tyoD1FhnUr+o0eadVt9ArnvTsa
         lJxBCF0JEzD9lTvMR9MlJS/zjZfLfhGis3+W5vg8bbEVrlbmTugks2Q2TH9ejh109Bl+
         uRYeKRES25iYuycBIp1dVukPrhcXJWTUT27ni0au4ynk+mGbPzSjACbdKxniB4WzdFI/
         3snBUQQwLniK5plw7afdClWs9/Y4ZdzL5ziG7UI2FfJFS7PMRkhZeO+Wm27CnUaxdu4o
         0ls/0i+Ef0ywR6ymzAWyc9TKo9PplEKIaUvMvNKR4MnH0GZgUYfNcFtEjFRgd7hmu44R
         HH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712481339; x=1713086139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZz3MC840yZiyjU2iCflebsmKP1jFfr+YX8wQcQ7who=;
        b=SNBCp6CF43VGKlpN5BErHSrgRH4jRG6Gb5Fp3m8T3ALhppJaf2uL6jhxWB22fpYj/C
         LXvktU8C4vRKaGhNk9VEZGjtkNYTALIWop4314E/GOBiRUzQ9zhATHLv9ICfEQRDKABi
         g+VGNIPV6Zg+RQL5UJmLChAP9TtzOgim236ftNCzK7DPWaIGCHg1x8602FwzmJAsapI1
         9eTMSr+Mhi0i7p+Yg/H2aTqk92t8L+8i1fYl5kR5jIW9HTJfHnoB9X0tKg/ZMWZCQOzZ
         tlxAWVopOxoCBriPPBdTSv6SL0FGqjsWdJm7JHAuGGUCkZmQ/xTy0t4l8MmbNCAukCkh
         ZUzw==
X-Gm-Message-State: AOJu0Yxs1CxcStYex9RKx+XX8nvkI4hNfYR+XrXUojSjio0UkRdYCDkb
	bWbBajLIwEynbWlw1pjfBkM/bvCrs4sPYeXVhT+n5RF/3A58j+LQ
X-Google-Smtp-Source: AGHT+IG/v6pXK0c/WnbmNuveLTIDxp62sKFRmQTKE5oyK98ydkDjwD6izLdX3yaiAqsJRY89kjBBSA==
X-Received: by 2002:a05:6a20:5529:b0:1a7:509b:2a2d with SMTP id ko41-20020a056a20552900b001a7509b2a2dmr3494266pzb.12.1712481339436;
        Sun, 07 Apr 2024 02:15:39 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:402c:cd44:6086:c23a])
        by smtp.gmail.com with ESMTPSA id gd5-20020a17090b0fc500b002a29160df67sm4293667pjb.27.2024.04.07.02.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 02:15:39 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-nvme@lists.infradead.org,
	stable@vger.kernel.org,
	"min15.li" <min15.li@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH for 5.15.y] nvme: fix miss command type check
Date: Sun,  7 Apr 2024 18:15:28 +0900
Message-Id: <20240407091528.5025-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_021541_035294_E34C7930 
X-CRM114-Status: GOOD (  14.57  )
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

From: "min15.li" <min15.li@samsung.com>

commit 31a5978243d24d77be4bacca56c78a0fbc43b00d upstream.

In the function nvme_passthru_end(), only the value of the command
opcode is checked, without checking the command type (IO command or
Admin command). When we send a Dataset Management command (The opcode
of the Dataset Management command is the same as the Set Feature
command), kernel thinks it is a set feature command, then sets the
controller's keep alive interval, and calls nvme_keep_alive_work().

Signed-off-by: min15.li <min15.li@samsung.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Fixes: b58da2d270db ("nvme: update keep alive interval when kato is modified")
Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8f06e5c1706b..960a31e3307a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1185,7 +1185,7 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return effects;
 }
 
-static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+static void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 			      struct nvme_command *cmd, int status)
 {
 	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
@@ -1201,6 +1201,8 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		nvme_queue_scan(ctrl);
 		flush_work(&ctrl->scan_work);
 	}
+	if (ns)
+		return;
 
 	switch (cmd->common.opcode) {
 	case nvme_admin_set_features:
@@ -1235,7 +1237,7 @@ int nvme_execute_passthru_rq(struct request *rq)
 	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
 	ret = nvme_execute_rq(disk, rq, false);
 	if (effects) /* nothing to be done for zero cmd effects */
-		nvme_passthru_end(ctrl, effects, cmd, ret);
+		nvme_passthru_end(ctrl, ns, effects, cmd, ret);
 
 	return ret;
 }
-- 
2.40.1


