Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5484C433E3
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 06:54:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4B6619CF
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 06:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4B6619CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MK6EHaUdwdkox1KXAldxD/UPGAi1dgfhh6NOBa210Q4=; b=mQB5eoYBy+KM3h5k8df/zzT3dx
	ocePYrxof3aaJdop8f1S+PZj2ErKIEeAZOv96GHS8fv83p6aAYEIfO31MtJaJ/22tYEhe62KQUel5
	c8at8PiEwCWTbdQIRY70NF40XEYQOLnqHurqYh/0pzv7RTrCpi4YlZHEiPL9EsPz1E2YbkONdYSje
	oihunPxlKpE2NGmQTjJdQsu8HLy+qkz5w4Y3N9sK5JwWTblICvulnaZcHl0NlS0GLjw9DZEFqnrI1
	pWLcsIELHlFlMxiv2vEaW0VwbKyhjzl1FORfle+6te0XctPhIU2V445WHUxvZr0W3VKGQVjnruC20
	0rlNCYig==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRUkM-005i0L-0y; Wed, 31 Mar 2021 06:54:34 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRUil-005har-Sk
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 06:52:58 +0000
Received: by mail-pg1-x52f.google.com with SMTP id f10so13488766pgl.9
 for <linux-nvme@lists.infradead.org>; Tue, 30 Mar 2021 23:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qfGDkfFMVyS8kERpIWhUG9SrhUeKfEuQtbhAVDL/FYc=;
 b=msSy3prM/THK4ZNzBLe5kBTjD0rpBhDT2QttnjBMwDpJkWzIz87var2lvIPKOtnfbs
 CGxEPUs+seSu5a+o1tbGmGnqI7wSPW9aQ+PhsVUdVetCjlYzCzLiTWoqdY/Qgj691lro
 Dn2iaQl+7ao54dNEg6qyDb8Ab3dJbRA+jvIMao8/JsJjHW6dHM9f4HsaTU9bHqBJDLAL
 3vP91KMVmOgP5qimGM4pD/lTrKMM4x6Jg1iDwUc5obRoBTdfek6pySRNI1KtLsfknRTD
 TZQwZoKA8XjeGGJHHM66OdzAutmp4kgyd9gBnQ7lA9JNtOMexWM9D4Lp2KQtBQs3QZ7o
 HAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qfGDkfFMVyS8kERpIWhUG9SrhUeKfEuQtbhAVDL/FYc=;
 b=pCVanUuWgiCt90vwZPYT11iKfKW0AEHTaI+MUchZB5EEYUwTV3Qn5moRbXUQLTAzzg
 lfroJKV22VIbL75zmZ5kiP20P2KSGM/aqjrjWcXU903M9NFYbUt1UC+aVedqJrBi8aiX
 xRw9MqQ3tFEz9zeizQEi3t0w9qANsDl+VbpVUx9x6kbBUXwY3o20ZXWrhYTaQK49yeRv
 O4h2O5q8jPbz6wGDvdI8GxgrA6CUAPGOauHl75Pmcjc2AoyjRQ5cashXiBXUieEP9XHq
 Qh1H/bOYiai2/hp6+ykYbSA9OeacsVSpsj2gXbwetMK9nryrXiPShZf253sQk6/qflXZ
 25RA==
X-Gm-Message-State: AOAM533GI1yhAnDfc2Y35+/VDA1dchxFkT1B2PAAHojEymQ3XjAqqrSg
 Nc0K1nM774xkGGSVqiJBxkQ=
X-Google-Smtp-Source: ABdhPJw0vXK01CAGDAQ1tVnscuA7JM8aVH96Gkc2XcmBqEGUbI4KljueFN0Yf1sVRv9l+qvLO3Kdag==
X-Received: by 2002:aa7:824c:0:b029:21d:7b2d:174a with SMTP id
 e12-20020aa7824c0000b029021d7b2d174amr1612402pfn.51.1617173574083; 
 Tue, 30 Mar 2021 23:52:54 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id l10sm984180pfc.125.2021.03.30.23.52.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Mar 2021 23:52:53 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: sagi@grimberg.me,
	hch@lst.de,
	chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org,
	houpu.main@gmail.com
Subject: [PATCH v2] nvmet: return proper error code from discovery ctrl
Date: Wed, 31 Mar 2021 14:52:39 +0800
Message-Id: <20210331065239.45337-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_075256_425745_305F025B 
X-CRM114-Status: GOOD (  11.11  )
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

Return NVME_SC_INVALID_FIELD from discovery controller like normal
controller when executing identify or get log page command.

Signed-off-by: Hou Pu <houpu.main@gmail.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

---
v2:
* Drop patch 2/2 from the series which is already fixed for 5.13.
* Modify commit message suggested by Chaitanya.
* Add "Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>".

---
 drivers/nvme/target/discovery.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 682854e0e079..4845d12e374a 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -178,12 +178,14 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	if (req->cmd->get_log_page.lid != NVME_LOG_DISC) {
 		req->error_loc =
 			offsetof(struct nvme_get_log_page_command, lid);
-		status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		goto out;
 	}
 
 	/* Spec requires dword aligned offsets */
 	if (offset & 0x3) {
+		req->error_loc =
+			offsetof(struct nvme_get_log_page_command, lpo);
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		goto out;
 	}
@@ -250,7 +252,7 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
 
 	if (req->cmd->identify.cns != NVME_ID_CNS_CTRL) {
 		req->error_loc = offsetof(struct nvme_identify, cns);
-		status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		goto out;
 	}
 
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
