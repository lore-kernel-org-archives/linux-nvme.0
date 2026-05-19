Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0589CD4F3C
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 13:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vEc4OopQOqDDYx8k+nnSPHbpqCp4cyCWARWro1ltDWc=; b=yj8XaBt2rS05RYQCGDkA6l+7Y6
	2SEiT1JOFvSwE9OAhLpPDrg1xNYpSkrZijlwpBiloYPc7HmuBoSkBuqgv+Dex6djxe1IQEBO2hfUK
	VWBSDuslObfD7JplOAZCmoeeFZoUYfW4hur9cEBIHmPR3wi3AlIbk452fbgfOCyTQM7l5/DVcS4Iy
	Pr3gUGDN4DQ7kFiTNYJBewinncUdjwSYgDMQa1OtqXHe+KFabkBkOGJX5j8yXZEvVdsvruqwaCTt8
	UHydjKEzp2AinZX0NT1W21WWjkhDPPA/gBIhu1dxxWFz15pZnpbu4VhaVKN0zDGNLLxg9kxoZqKqh
	MSccVc6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPKln-00000001iEX-0Lje;
	Tue, 19 May 2026 13:46:03 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPKlk-00000001iDq-2sC3
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 13:46:01 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-8367df48711so1472980b3a.1
        for <linux-nvme@lists.infradead.org>; Tue, 19 May 2026 06:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779198359; x=1779803159; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vEc4OopQOqDDYx8k+nnSPHbpqCp4cyCWARWro1ltDWc=;
        b=GX/z2W9c5IaBHGidSKJvtcSLD+BpQODm88WU47oj0LBW9R2gPFUyPZXXpnmx1qugK4
         3wPgkQ2lG31UtpACqMAywG3GzX18vFo243tICig101oqtLwue//YDtxG9C1mPKEEnivI
         ZNPoIDrvA3LTcixH84KniaGfoiomI/IqzXwzzZahs4YKvY2d3M3+7dEjHEuANsnlN6na
         W4Yn9QJP8hWj2mS52bDvrxAtHpT+il85Xf6sojQ9LjkY7tnuUfQq3hhvkaetdKqEUqqT
         z44TICXFM4fXdjl7TKZVKTojVpccNIwA9Yx3gIpNS40p/+Vw2JJogaowfOBwNmpK13QY
         6sZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198359; x=1779803159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEc4OopQOqDDYx8k+nnSPHbpqCp4cyCWARWro1ltDWc=;
        b=tMjGfIo1b5NGYVEQ6N4ehIUFYdnAfuHOrBbO8oB4icBT9aqnqMpLITiiUivQu65WPK
         8EkQLqkn0h2nEXMVwvMbVEgfloFvw79chueYP/oLYMyhzgN1lPKyIT37oNPmiMnhohWR
         9RfqhMFMrjsKOQqNggojV/4v/9rZmMRyCAYNLqIF/P+5GaL5ZIkF+UtfNJS/N1ZEE+QE
         dek0aRTOvx9CGiMUCu9lddNDOkNDwGzLzwY//CVDZqRzCjZLSW4ZuRCT48U5j2VNrqmj
         CPtNBBZqVCP/zsFdNz9c5Qik1fojd8E0J3LWMwBx1LG3t4frvB24i8pWKuAulN6eFFfr
         sC2A==
X-Gm-Message-State: AOJu0Yx3iO0ALjtKcxBZZjXVJmkV+OrgpsG8zaVtADYuGQJFo7zlMI9G
	o7zEU2Sdfcbj3S2yIiKCiE0JF7yLvn54BN0pL3F6XMLbcgFdp7hc36pvT6zTjw==
X-Gm-Gg: Acq92OHPRsZjg+nMG6MRgw7Yl8j8oBl6/yNIVde17F4xm4CSJXiwOKUPKNw/EAMRThF
	wQB6Ux0XdUZ9HUvSRdjI6xj7KShWtuQjWILV4/ZjS9VwMhE+K8WiaPqdE3qneDUu5ChntXXQjN7
	XLSjfDon7ip51/d5QH+oOnoFieWqPlthcDUfe8vyq1A7f8hgA2FbpQfUkqbZTBrphY2NHLwqsEo
	tiAc+U3jo3lTHaQFUYxWjHuBfD9BmsBL4UnwTFm51V6Ii6gVQpPNOhbX2JcBWPyTzE8WzwkrxOd
	i4Rgyrd+0vR8bTzHbxOy7wOlnbv/3nda0b67XFZSO5ZH5fKDTxd50iVDcc/LfRJ71cJq+4ylmvJ
	AnzoWks/aLKEQjg1/lGPqY4hfFZOC9p525EjbanjSTKo2LdlwjUOE55/SqFQmRkgHx2oAxt8LOt
	leoSHboS0tidy0Zjei5F4LYJ0zYf4iCrOdujkcScbYAA==
X-Received: by 2002:a05:6a00:a257:b0:83b:b0c2:17ea with SMTP id d2e1a72fcca58-83f33de53e6mr19977784b3a.37.1779198359207;
        Tue, 19 May 2026 06:45:59 -0700 (PDT)
Received: from n232-167-136.byted.org ([36.110.163.109])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f197995absm17232417b3a.27.2026.05.19.06.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:45:58 -0700 (PDT)
From: guzebing <guzebing1612@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Tokunori Ikegami <ikegami.t@gmail.com>,
	Guzebing <guzebing@bytedance.com>
Subject: [PATCH nvme-cli] nvme: check MUD support before firmware commit
Date: Tue, 19 May 2026 21:45:42 +0800
Message-Id: <20260519134542.1841435-1-guzebing1612@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_064600_729122_282F9233 
X-CRM114-Status: GOOD (  15.84  )
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

From: Guzebing <guzebing@bytedance.com>

Firmware Commit returns the Multiple Update Detected value in the command
completion. nvme-cli currently identifies the controller after the
command completes to decide whether to print that value.

That post-command Identify is fragile for immediate activation. A possible
Linux race looks like:

  nvme-cli thread              nvme driver AEN work
  ---------------              --------------------
  libnvme_exec_admin_passthru()
    -> Firmware Commit succeeds
                               nvme_handle_aen_notice()
                                 -> FW_ACT_STARTING
                                 -> nvme_change_ctrl_state(RESETTING)
                                 -> nvme_fw_act_work()
                                    -> nvme_quiesce_io_queues()
                                    -> wait for activation
  fw_commit_print_mud()
    -> fw_commit_support_mud()
       -> nvme_identify_ctrl()
          -> admin ioctl passthru
          -> nvme_user_cmd*()
          -> blk_mq_alloc_request()
          -> __nvme_check_ready()
             rejects user admin command while resetting

nvme-cli then prints "identify-ctrl: ..." after the successful
fw-commit output. The extra error makes it unclear whether Firmware
Commit itself failed, even though the command completion was already
successful.

The post-command Identify can also observe the wrong capability. MUD is
a bit in the Firmware Commit completion, so it should be interpreted
using the controller capability that applied when that command was
processed. If the old firmware does not report support for firmware
image overlap but the new firmware does, a post-activation Identify can
make nvme-cli interpret the old command completion using the new
firmware capability.

Read and cache SMUD before submitting Firmware Commit, and use the
cached value to decide whether to print the completion MUD value. This
ties MUD reporting to the firmware revision that accepted the command
and avoids a post-success Identify during firmware activation.

Fixes: b44729257 ("nvme: Check fw-commit command support MUD")
Signed-off-by: Guzebing <guzebing@bytedance.com>
---
 nvme.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/nvme.c b/nvme.c
index 6a8350b9a..560ca7b7f 100644
--- a/nvme.c
+++ b/nvme.c
@@ -5341,9 +5341,9 @@ static bool fw_commit_support_mud(struct libnvme_transport_handle *hdl)
 	return false;
 }
 
-static void fw_commit_print_mud(struct libnvme_transport_handle *hdl, __u64 result)
+static void fw_commit_print_mud(bool mud_supported, __u64 result)
 {
-	if (!fw_commit_support_mud(hdl))
+	if (!mud_supported)
 		return;
 
 	printf("Multiple Update Detected (MUD) Value: %#" PRIx64 "\n",
@@ -5403,6 +5403,7 @@ static int fw_commit(int argc, char **argv, struct command *acmd, struct plugin
 	struct libnvme_passthru_cmd cmd;
 	int err;
 	nvme_print_flags_t flags;
+	bool mud_supported;
 
 	struct config {
 		bool	ish;
@@ -5471,6 +5472,8 @@ static int fw_commit(int argc, char **argv, struct command *acmd, struct plugin
 		return -EINVAL;
 	}
 
+	mud_supported = fw_commit_support_mud(hdl);
+
 	nvme_init_fw_commit(&cmd, cfg.slot, cfg.action, cfg.bpid);
 	if (cfg.ish) {
 		if (libnvme_transport_handle_is_mi(hdl))
@@ -5489,7 +5492,7 @@ static int fw_commit(int argc, char **argv, struct command *acmd, struct plugin
 	if (cfg.action == 6 || cfg.action == 7)
 		printf(" bpid:%d", cfg.bpid);
 	printf("\n");
-	fw_commit_print_mud(hdl, cmd.result);
+	fw_commit_print_mud(mud_supported, cmd.result);
 
 	return err;
 }
-- 
2.20.1


