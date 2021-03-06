Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDDEC433E0
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 21:17:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B87650BB
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 21:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B87650BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mHDnWi1c6EtOrIbGmmdZScEv7sH5tMK+nx5qrKr+jjw=; b=PeZ1+A2wK1lQFsa88IFYBF496F
	CwoZvBp0WkxoUyMqS3bkt2eSdO1AftrpgMy3WW5GN+CPns7BZazWBA7IEmshhjuRqHGvCrMwED+GF
	OjsZW889Dh/gKgDtjglB5YubVnxPsce4Iuf88af5Vot2SVv97dtnH0Ane5w/VI58YlEqmf+D6NRJ8
	3AQWNElXFDZ4HZLX3qAzDvKsyymA9xAi1nu61Rp0E5w6TjXkXRiDeQ+AZZZy+gkFeSZby9Yq9X6Su
	kaByZ3nnmUmnOvr4NguH9Eg2pbVSx5kn4nROGnBW7vGy9O3sKv6hnRucKyj73PIUyYIl/Fn4Tiaq1
	Kv/fFf8A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIeIb-0050pS-44; Sat, 06 Mar 2021 21:17:21 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIeIT-0050mu-7O
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 21:17:15 +0000
Received: by mail-pl1-x62d.google.com with SMTP id a24so3075498plm.11
 for <linux-nvme@lists.infradead.org>; Sat, 06 Mar 2021 13:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rqpud1SFsFWm5tJtvYOt91rESzkjIUZuEwhsXZuiL2k=;
 b=cFRHp4GZvPkaf32JaVhyKF4FcOzwKX7QSR3qSSY6Taextb/iZn5Ru6nOQ4qmm1rzqz
 OVXWAt3quHrU3vWp+tQqT13gcfkF5kJEOP1sf0u8343N7osxXBRsVj1umBLVABgUgOvW
 SsCB+UltB1ELYNgPJDEQwBjbuYnOd8QwWKmiI+H82SoUE3IOGUjN/Z4AMXAT9YxlPwuv
 1p9wylTYC1w5/sh2YpFbV8FX1s8837kkVOMMQZCEA3dKwqbkJPx2BF78Vc6r43BPR1gK
 QezwYxOJRVUXvkDGM5ng8+yf2bv3XwSJaWauLc3TlkTy/tnMn5Hc+CM8PxKfUfQvFGev
 L0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rqpud1SFsFWm5tJtvYOt91rESzkjIUZuEwhsXZuiL2k=;
 b=eVNdH9thy1KywpfBdA/RpP6A1RoFscQyZoIGIKmtEnqNuNPKIiSY9ihIVWkPVMC05u
 63XT7EC5Q67x2MrrUYUJYh055X6mfy75CMqUnR/X2ww5flzfG1aRCV3TO/vatldgk8fW
 XpdEHwfzbtzjZ1o28eeO31apqb/4xb8jV/o7FOHK1pUT7okiQJUWMqziGs1MOtbRwSO/
 FfHKg644HawqZBNdx2sHYNsP3TI9gpFu8FfRASl/7b40C0mBLafU9xBRFHvOWyt/Tqbn
 Un94HzXskuPVA5lP7qe5yw7yrezhGLgGO5Q8d7CYpsJgPOHQVs/6vIy3njRKNYB9Y1YN
 yphA==
X-Gm-Message-State: AOAM531YEo1WcUdtVVH1Qnnjn0anIU5hHfH60j8MSjY8ygQm0iXTgZEp
 2KIiF0fBySz3I6KoWgG0A1Az87YbrJs=
X-Google-Smtp-Source: ABdhPJwdsZxqpYd5tYFwhtmSjCoAl0AsAsxSuvt0qQW1GJhGbRomedna6qHCLTui41mToKdSxzcB8w==
X-Received: by 2002:a17:90a:2e06:: with SMTP id
 q6mr13610439pjd.222.1615065429776; 
 Sat, 06 Mar 2021 13:17:09 -0800 (PST)
Received: from localhost.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id i22sm6282926pjz.56.2021.03.06.13.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Mar 2021 13:17:09 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: emilne@redhat.com, James Smart <jsmart2021@gmail.com>,
 stable@vger.kernel.org, Nigel Kirkland <nkirkland2304@gmail.com>
Subject: [PATCH] nvme-fc: fix racing controller reset and create association
Date: Sat,  6 Mar 2021 13:16:58 -0800
Message-Id: <20210306211658.67604-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_211713_378591_3EE383CA 
X-CRM114-Status: GOOD (  12.64  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Recent patch to prevent calling __nvme_fc_abort_outstanding_ios in
interrupt context results in a possible race condition. A controller
reset results in errored io completions, which schedules error
work. The change of error work to a work element allows it to fire
after the ctrl state transition tion to NVME_CTRL_CONNECTING, causing
any outstanding io (used to initialize the controller) to fail and
cause problems for connect_work.

Add a state check to only schedule error work if not in the RESETTING
state.

Fixes: 19fce0470f05 ("nvme-fc: avoid calling _nvme_fc_abort_outstanding_ios from interrupt context")
Cc: <stable@vger.kernel.org> # v5.10+

Signed-off-by: Nigel Kirkland <nkirkland2304@gmail.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 20dadd86e981..0f92bd12123e 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2055,7 +2055,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		nvme_fc_complete_rq(rq);
 
 check_error:
-	if (terminate_assoc)
+	if (terminate_assoc && ctrl->ctrl.state != NVME_CTRL_RESETTING)
 		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
 }
 
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
