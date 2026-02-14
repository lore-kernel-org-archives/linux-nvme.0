Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DC7EDF15A
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oVheserzpS3TkYHKpvBl78HcBp8VYTBPF64haSBCcyY=; b=xNWJCidV+t80fHKSBuD8B8FD+z
	8coMita0tzMLf2VVyrHO2BOwldQyaH4+9mxGlaUPlRmR9bYpvbgA3hbaxCp7qpI7Z+RA5FI5CP+t/
	XV0Q3T8WOWFujqPZtX6tt/5tXlQkzJoVKpfJW2/qwUK5UxaRkVzJW5tj+Tdoquj5GNGPV1l27algq
	T4LHwmE0xw/teJkifRZux/YTH4p/QW0XS99oE+MA9IyQVXjPB8VeuM18M8x5kSslrOWDRtVgZ9Dj/
	8gRYvKtMKqhaBVaf3qtg0hxjCKKx/iYJ5h9QKiLdVZfChy+lvhU8CsmnA+3tYz5rvq4f9tbhfxAQg
	AsxTEHmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gw-00000004FUH-14iE;
	Sat, 14 Feb 2026 04:28:46 +0000
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gl-00000004FBS-3cWC
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:37 +0000
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-1248d27f293so3710931c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043315; x=1771648115; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVheserzpS3TkYHKpvBl78HcBp8VYTBPF64haSBCcyY=;
        b=cOFonlnJ5etGctH6p5GdQFOvP9Hahtsch0Iv1hbmSfPPiUEDeVBWXxUeU91BrRIV4h
         PEAeZtYxkgJarUeQsJhZBJETA1JfP0/VrIvUb6x3EH6cg7RBHmfE/3ykK/NxzlFCD1qj
         CIOZGlCycNXA2xTq4YHY9FJRfPy2J4dnu4R8T6pNyKJvbza8v72EV9faWdRZ3JyUofCd
         Uab89xTqFay2Y4cYiGVc/Tcin48IzOFRBddCaHJi00d5uPRCG+co7sbuW0bMtR0wLx+8
         12glGsQggdAF22GlPrfpNHNRcvVy8k921jBdFqLKb7uRjlJrtW69WK4movhsO6mi8TKM
         IKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043315; x=1771648115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oVheserzpS3TkYHKpvBl78HcBp8VYTBPF64haSBCcyY=;
        b=wIMZzllyO8bNk1JxvvDjrIJ2eLdEaeds9Ua6SU87CP7aUGkCOt/U8IGq86gHB7dPMd
         25dO8snlgRfc6WQQVilhpyAxsOcNhuqDDyVKMlgbcS3ziglr/kT6QBW3b7pu0jFm5IOG
         59ccUih6tWNdf+mZ1Y98Di0XYBJkZg2sfxtVHNwfeGvTfC7vgVVhk8sD05OQgKreP2j4
         qAcuJDqLhde6oY3EhFaHo9nsyQTqUV1cY918NTF9uGN7mmRq57k82Yd3eqwve0DFafZD
         Zb2pPvPus/9+sOLBCsySq9dB9zERCU93pqyWLlGL/ELtAI/6gLowzQqZfRscoyImK9gc
         joEw==
X-Forwarded-Encrypted: i=1; AJvYcCWFpzNI8ieMQLhjb9jVt8oOsyk3dIfXL1A6X94gwE392R5laAHO4/oaCRLByjt+mclkB4FQnxaw59oF@lists.infradead.org
X-Gm-Message-State: AOJu0YyxxJ71Zqg29Rc8mjaRSyKr/jdkiD5PCCneKO7RhuXCS6AeLcuI
	pxasvaNPxk7C/O8WEWpP0z1GOkoRZz9UAU88ShAIAiNrEEltMVGzyv6ga9NRWxqHJC4=
X-Gm-Gg: AZuq6aJIA2vg67WuM2wAaCX8FWyXz92wb1IRT/pxpMG5dW8NPtpPGHDmtYsIzrZadVB
	B9MoJsUygGsyqo/oF0ypagbJq0o2hwTebH9LlWa93a+IJO4uPN1n9l3Jqa3JL4giJa6THHnIXaL
	BBEf4lLENOC99UpSsh06xM6p0qEJsdxQtHcsUDjSg6y5GFXDw/Y9QU50BxQ/+czpopdQbz49Cpt
	JWs7LWIiXnfKQAHFLOqWzrRAA48G4hmkXkf+333x57WFAIhjReyJEe0LxBDvpZnz8Dx5jXmpUpF
	QPnmDCqbXNJqHB4euK5oHMdOYx5OeCE/BZWgOSWkgsEZ+5MvnAhcxdg6kz6dE2PHngLyggU/kH4
	JwrKVZFPinnd/IXQh8Jw6qnkHxlG0rYQNi1vGVMCvVO9d/NTxgrpygdfZnyrgcGFBFUbEmFYvr3
	kISRpaMH6uVH2k781R6k2Vv7FQFJhfnOYD3qtZWWuwHJH28w==
X-Received: by 2002:a05:7022:b93:b0:11d:f682:e475 with SMTP id a92af1059eb24-1273aea73d4mr1856668c88.40.1771043314988;
        Fri, 13 Feb 2026 20:28:34 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:34 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
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
Subject: [PATCH v3 17/21] nvme: Add support for CQT to nvme host
Date: Fri, 13 Feb 2026 20:25:18 -0800
Message-ID: <20260214042753.4073668-18-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202835_917257_5B52B5CD 
X-CRM114-Status: GOOD (  14.37  )
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

TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
Time) which is used along with KATO (Keep Alive Timeout) to set an upper
limit for attempting Cross-Controller Recovery. Add ctrl->cqt and
read its value from controller identify response. Update fence timeout
to consider ctrl->cqt.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/core.c  | 1 +
 drivers/nvme/host/nvme.h  | 5 +++--
 drivers/nvme/host/sysfs.c | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a9fcde1b411b..0680d05900c1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3739,6 +3739,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->ciu = id->ciu;
 	ctrl->cirn = le64_to_cpu(id->cirn);
 	atomic_set(&ctrl->ccr_limit, id->ccrl);
+	ctrl->cqt = le16_to_cpu(id->cqt);
 
 	ctrl->oacs = le16_to_cpu(id->oacs);
 	ctrl->oncs = le16_to_cpu(id->oncs);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index af6a4e83053e..a7f382e35821 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -336,6 +336,7 @@ struct nvme_ctrl {
 	u32 max_zone_append;
 #endif
 	u16 crdt[3];
+	u16 cqt;
 	u16 oncs;
 	u8 dmrl;
 	u8 ciu;
@@ -1245,8 +1246,8 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 static inline unsigned long nvme_fence_timeout_ms(struct nvme_ctrl *ctrl)
 {
 	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
-		return 3 * ctrl->kato * 1000;
-	return 2 * ctrl->kato * 1000;
+		return 3 * ctrl->kato * 1000 + ctrl->cqt;
+	return 2 * ctrl->kato * 1000 + ctrl->cqt;
 }
 
 #endif /* _NVME_H */
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 1e4261144933..0234e11730bb 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -387,6 +387,7 @@ nvme_show_int_function(numa_node);
 nvme_show_int_function(queue_count);
 nvme_show_int_function(sqsize);
 nvme_show_int_function(kato);
+nvme_show_int_function(cqt);
 
 static ssize_t nvme_sysfs_ciu_show(struct device *dev,
 					  struct device_attribute *attr,
@@ -759,6 +760,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_sqsize.attr,
 	&dev_attr_ciu.attr,
 	&dev_attr_cirn.attr,
+	&dev_attr_cqt.attr,
 	&dev_attr_hostnqn.attr,
 	&dev_attr_hostid.attr,
 	&dev_attr_ctrl_loss_tmo.attr,
-- 
2.52.0


