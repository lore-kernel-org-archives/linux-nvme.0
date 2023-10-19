Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC57C001DF
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 21:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lqEsMCD2petOW7LvFR3PY5d0rpovBBpxs1upvL07Joc=; b=bQ03KhcM0cSBdcXABDFlxV+YaT
	m+wQVvKaJgdjKHevrgWJuYDzveCyaMlwd5miPc08SiHCAJ6t45d8upalLd+Mq9G4mVZzH7fL0Mncs
	wMwGUsRWYE1zjjZcP2VDi9Q5biHsK7MVYjOt6LCLVOSgIC44T5d65N7hCigFhR5SJ6Qvv+0a0+KhI
	7jdhJDwVOKAfl3PEuJ9cH/qLFkIxuVvByoZSBS4KTRq3yoheXGLvscybBl0p/P2v9AaLB7zh8qwVp
	hNDIiaIJ96V5jaOib5G/jAaVfuHI4sRyb+y6h0lAHHMlXKA+OpkyXfUfG77vuIQYDy6YKidXUFN42
	feWnU4wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtafI-000kdq-0F;
	Thu, 19 Oct 2023 21:34:48 +0000
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtafC-000kdB-19
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 21:34:44 +0000
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a3942461aso220607276.2
        for <linux-nvme@lists.infradead.org>; Thu, 19 Oct 2023 14:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697751278; x=1698356078; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lqEsMCD2petOW7LvFR3PY5d0rpovBBpxs1upvL07Joc=;
        b=bYDIJ7r7x9ot5d7XrWxBPHxeaGBOxbMsYgZGELOaokLmH5ajiCx/vsaOgtkLXvrmb9
         qkBiUGtd0EvF/z2IxgHk3chNqJKYtsEBPbGd9xCx17j7eOD3FFOXZz0hgYaaM1svzaM3
         7/u70BweGV7bGBhFZovAIrf8kFuH7nMaKi0Vvd0vPqwl+9fPGxGYNb1YF6ti2CgFwK6w
         bqaAnPPQ1fYk6Q/Cc69YZWVXnB7n9hyfBM/rvVdNOdPc0XICkQ+zZekyonNa/9WJZn8j
         v0SqqlNE55hkeIHncd8yU/iDTLTQ/DBplCJhPEhZ+1l8VX74Lh1hgQcuVLdQPeAdUZVa
         lNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697751278; x=1698356078;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lqEsMCD2petOW7LvFR3PY5d0rpovBBpxs1upvL07Joc=;
        b=W5IwYbAcRrbihNwUYczH5gLY0Rp6O6byJZWZ5A0bVSs7PQIwjrT8J2r5N+D98wqIKa
         Ijo8eY1tNCnfsey0ZUjXLn7Sge5YmM3DcK0WEDvXogTAdOp4XtIUkaQR4cMUMp3xIcgK
         qeGx9/5BuaiJ4fiKNw1D1i8SonS/P5ooT+M+0dFGW4ywop5E4JqVcSrH1z1sedD8xigN
         7iQbDwHuW+ii8Xx73NENf8j7YmiJYJK/aIbwqvwV3n1V0uHP7P5qFmSczhLQc4pr/RlQ
         n0SxZFUPpcKtTxS0epRn8GfaKRy66vxCkES3S7nuCUhJXtoa5BD+2bc6o5loNn2rSNhR
         yopQ==
X-Gm-Message-State: AOJu0YxfT0meUi1w8htnePiDhQDal8MOUTW0cDyhIIfaXwSlxr0PujI4
	p7TMsXy2uZb7oPN94VId0wgeDk/PfNjxIuKZ6A==
X-Google-Smtp-Source: AGHT+IEZOXJDte5mBKiSHod7tas1fWLJQLJRbTT4Mnc/qvcrMQZrSCM/hxqM5exEVwxnsM4TsX/4sGX1DymVjhGKgg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:d110:0:b0:d9c:c9a8:8c27 with SMTP
 id i16-20020a25d110000000b00d9cc9a88c27mr446ybg.13.1697751278223; Thu, 19 Oct
 2023 14:34:38 -0700 (PDT)
Date: Thu, 19 Oct 2023 21:34:35 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOqgMWUC/x3NQQqEMAxA0atI1gbaqjh6FXGhNWoWUyUpxUG8+
 xSXb/P/DUrCpNAXNwglVj5Chi0L8PsUNkJessEZV1ljO9QowZ8/XIQTiWJIX8L90IirR49TU7u 5qudPaw3kyCm08vUOhvF5/p5i6cRwAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697751277; l=2895;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=E7cZpx/98qOWGlojxJVSbMIF5mbCSTqGliFRklJggj8=; b=r5nMNcuHW5ecWZu9xGiqdmwQIceKXPadUITLieWfMFjmPqvtIMR7d5OaDyBK0FmycCu8pXiod
 LiUxzFjDcRrDIgL6K4o0W5CUFygua5UAEfx8VqQx05b4PaeO3KaJgSh
X-Mailer: b4 0.12.3
Message-ID: <20231019-strncpy-drivers-nvme-host-fc-c-v1-1-5805c15e4b49@google.com>
Subject: [PATCH] nvme-fc: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231019_143442_413942_CC29D947 
X-CRM114-Status: GOOD (  14.83  )
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

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

Let's instead use strscpy() [2] as it guarantees NUL-termination on the
destination buffer.

Moreover, there is no need to use:

|       min(FCNVME_ASSOC_HOSTNQN_LEN, NVMF_NQN_SIZE));

I imagine this was originally done to make sure the destination buffer
is NUL-terminated by ensuring we copy a number of bytes less than the
size of our destination, thus leaving some NUL-bytes at the end.

However, with strscpy(), we no longer need to do this and we can instead
opt for the more idiomatic strscpy() usage of:

| strscpy(dest, src, sizeof(dest))

Also, no NUL-padding is required as lsop is zero-allocated:

|       lsop = kzalloc((sizeof(*lsop) +
|                        sizeof(*assoc_rqst) + sizeof(*assoc_acc) +
|                        ctrl->lport->ops->lsrqst_priv_sz), GFP_KERNEL);

... and assoc_rqst points to a field in lsop:

|       assoc_rqst = (struct fcnvme_ls_cr_assoc_rqst *)&lsop[1];

Therefore, any additional NUL-byte assignments (like the ones that
strncpy() makes) are redundant.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
Similar-to: https://lore.kernel.org/all/20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com/
---
Note: build-tested only.
---
 drivers/nvme/host/fc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a15b37750d6e..680585253f7c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1218,10 +1218,10 @@ nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
 	/* Linux supports only Dynamic controllers */
 	assoc_rqst->assoc_cmd.cntlid = cpu_to_be16(0xffff);
 	uuid_copy(&assoc_rqst->assoc_cmd.hostid, &ctrl->ctrl.opts->host->id);
-	strncpy(assoc_rqst->assoc_cmd.hostnqn, ctrl->ctrl.opts->host->nqn,
-		min(FCNVME_ASSOC_HOSTNQN_LEN, NVMF_NQN_SIZE));
-	strncpy(assoc_rqst->assoc_cmd.subnqn, ctrl->ctrl.opts->subsysnqn,
-		min(FCNVME_ASSOC_SUBNQN_LEN, NVMF_NQN_SIZE));
+	strscpy(assoc_rqst->assoc_cmd.hostnqn, ctrl->ctrl.opts->host->nqn,
+		sizeof(assoc_rqst->assoc_cmd.hostnqn));
+	strscpy(assoc_rqst->assoc_cmd.subnqn, ctrl->ctrl.opts->subsysnqn,
+		sizeof(assoc_rqst->assoc_cmd.subnqn));
 
 	lsop->queue = queue;
 	lsreq->rqstaddr = assoc_rqst;

---
base-commit: dab3e01664eaddae965699f1fec776609db0ea9d
change-id: 20231019-strncpy-drivers-nvme-host-fc-c-a542b34b8710

Best regards,
--
Justin Stitt <justinstitt@google.com>


