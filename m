Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A0BD29FB2
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 19:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fFGZ0sYYFsGCnTMv4S29PKuw5mxfEDY6J90QuiyCqko=; b=175WeicKdYHFtH+J27Lpn9aZrQ
	Pos/Iahog7bmp+T1ZAdArLGVwwmeli4KVSZUG/0LrjEjXrRFLLGr3QiDWFEnl5D4TacwdEg0fzZgz
	Foo5slFa4221tFNc7bTRddqWKSeNisvznCL2UcGtm1eCfvmLC/AFs5Vk0D99jUmG5ToxuIQeoHBYx
	V3qXSW8uVL9S0tvejaqg4z2G8Ff/qeXqqPMubZBVGyPkCWH6hnOcRJVUQxd+uM2IR0uyywY7U9N9B
	7o5Jsasz6f4RmToYE4E8r9XsoAj9gxMP4qYCnyUbvxbfmRgAeD9/ulny442CCaNPJhU+4SR3r3EiA
	oKTFbMSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRFQ6-00000008XBG-2IZk;
	Thu, 04 Dec 2025 19:55:18 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRFQ3-00000008XAm-13fB
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 19:55:16 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so1173671b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 04 Dec 2025 11:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764878114; x=1765482914; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fFGZ0sYYFsGCnTMv4S29PKuw5mxfEDY6J90QuiyCqko=;
        b=L2Y9KBwsjC1vb1Y+F6Jai810t6QJnH8UAtOML3kGIP5YQ5rDapNk1WJv1e+uOC9wxp
         xFj8FiNfl5xOPbrmWQ4DG5KbmtbxLcogOtkkBb7+wPKui2pbI+vF3XrBUxrqJXPtRIpV
         V0QTmpWflEHXD6tlRVYPtx/rJ1f2V85ckZ8Vqfc3fjb1XKqGlw80z4zY5AwAU7lejiel
         JhuTaW8O9liEGveRub0E9zVI22KsOa9dxvcC+sZ1ZnISGnZNQv3E9/sr+odT/XkOsSrE
         efZr6fZPJRj1P3nRhFkINvtkwDfdtCea0hD4h/qI4ojuHAk7V6gBN+9ImmCnzNpkUS7K
         tVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764878114; x=1765482914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFGZ0sYYFsGCnTMv4S29PKuw5mxfEDY6J90QuiyCqko=;
        b=nA25xqBu5PqvhVt2PeVLAf2b7POb7NmQuJfnXgVVYSQUKTT5UQpmhAcPCgfQY4Q/vL
         lLJ258sB23fsmVSLkJdFviyYXk/oAacLwbewK+ne8K1P7B8esutFiDELkEQUMF+kRgXf
         65HHxPo91tM1Np0HPDhVHlE+yPdkuFDoNGEfgxzu7wPwWExCSDgxfz/kFq4XbBwuwQKO
         JaLj9pbW7LLanGeJMOF1g7S5DSO4g2cIjIHn2YKBzIw4h/88jmg+My1MV8e/yql8XdVV
         g9gnSZJBTU4Q7tf+IZGiw8trOrofVee6lB3Y4OXD42Kgw2821nKOer4pOZWQejpVqeOd
         E4dA==
X-Gm-Message-State: AOJu0YxBD2BJ81KiZtqufjLWpS+x0gZT6sRpDU+P++TqEvRmLRXZCwOJ
	rkZu9DJHR8goolZiJBmXo0T3qaqOTf9IwQuh3pud99b+2WKRUxmd34qiwD1k9w==
X-Gm-Gg: ASbGncun7CPx7bwS1SNlJzdvW8apqif5tJr5Q6L/0FKQWZx8bbNWjx+w2IUsGkKcHYt
	mQYI/PDGEq4XVkgg+me3SN/9eyitOX/8Ywu8cl1C4zZOpsY4ltZ94GOA/T7uXIIui1o1QFrEepT
	xpKXVsWr/xTBRAml8r/Vxt1b/OQW1YiPityFg2IBlRcZl1cAijubSlUn+t3FapQjbWDPtSc2nqg
	i08QcEqD3WJ6n+DXGT9k4fceqwNzuc1OeaeyaK3hJopjINnUKZhnEHWiWrQEvbcz8FM08pP8/B/
	VzzsF3hkwj1EQJXxWzUBn9umyi6FHE5yzNZBeM01V1T3GaRaE7nPXuU4qsbCL93w4VIExqmTkt3
	kIL7oJtB1Q4c6fRANFte35R1Amw4muRsT0KUyaTzYSbEjZ9ZufuhfnTteO0d7eSlbGOTmoHjVYZ
	v35Lh4HURbV+QOk0VtqROCSAu/En/fWGxoD9mWG38/t7s14i3bZzCXKpZuwfnAMtTWs3HIjAo=
X-Google-Smtp-Source: AGHT+IFlprDjqQY7sgD9BnpIiqqaHtQfj+I/Av3oM3JlSQ607UcG/22eC2lV+/v1aH5ULHDziVaxTQ==
X-Received: by 2002:a05:7022:628f:b0:11a:23fb:16e2 with SMTP id a92af1059eb24-11df643c6e0mr3231998c88.9.1764878113920;
        Thu, 04 Dec 2025 11:55:13 -0800 (PST)
Received: from dhcp-10-231-55-133.dhcp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2f3csm9664083c88.5.2025.12.04.11.55.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Dec 2025 11:55:13 -0800 (PST)
From: Justin Tee <justintee8345@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Justin Tee <justintee8345@gmail.com>,
	Aristeu Rozanski <aris@redhat.com>,
	Daniel Wagner <wagi@kernel.org>,
	"Ewan D . Milne" <emilne@redhat.com>
Subject: [PATCH 1/1] nvmet-fcloop: Check remoteport port_state before calling done callback
Date: Thu,  4 Dec 2025 12:26:13 -0800
Message-Id: <20251204202613.14908-1-justintee8345@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_115515_293688_2B4C76C4 
X-CRM114-Status: GOOD (  14.84  )
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

In nvme_fc_handle_ls_rqst_work, the lsrsp->done callback is only set when
remoteport->port_state is FC_OBJSTATE_ONLINE.  Otherwise, the
nvme_fc_xmt_ls_rsp's LLDD call to lport->ops->xmt_ls_rsp is expected to
fail and the nvme-fc transport layer itself will directly call
nvme_fc_xmt_ls_rsp_free instead of relying on LLDD's done callback to free
the lsrsp resources.

Update the fcloop_t2h_xmt_ls_rsp routine to check remoteport->port_state.
If online, then lsrsp->done callback will free the lsrsp.  Else, return
-ENODEV to signal the nvme-fc transport to handle freeing lsrsp.

Cc: Aristeu Rozanski <aris@redhat.com>
Cc: Daniel Wagner <wagi@kernel.org>
Cc: Ewan D. Milne <emilne@redhat.com>
Closes: https://lore.kernel.org/linux-nvme/21255200-a271-4fa0-b099-97755c8acd4c@work/
Fixes: 10c165af35d2 ("nvmet-fcloop: call done callback even when remote port is gone")
Signed-off-by: Justin Tee <justintee8345@gmail.com>
---
 drivers/nvme/target/fcloop.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index c30e9a3e014f..38bd2db3d6bb 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -491,6 +491,7 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 	struct fcloop_rport *rport = remoteport->private;
 	struct nvmet_fc_target_port *targetport = rport->targetport;
 	struct fcloop_tport *tport;
+	int ret = 0;
 
 	if (!targetport) {
 		/*
@@ -500,12 +501,18 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 		 * We end up here from delete association exchange:
 		 * nvmet_fc_xmt_disconnect_assoc sends an async request.
 		 *
-		 * Return success because this is what LLDDs do; silently
-		 * drop the response.
+		 * Return success when remoteport is still online because this
+		 * is what LLDDs do and silently drop the response.  Otherwise,
+		 * return with error to signal upper layer to perform the lsrsp
+		 * resource cleanup.
 		 */
-		lsrsp->done(lsrsp);
+		if (remoteport->port_state == FC_OBJSTATE_ONLINE)
+			lsrsp->done(lsrsp);
+		else
+			ret = -ENODEV;
+
 		kmem_cache_free(lsreq_cache, tls_req);
-		return 0;
+		return ret;
 	}
 
 	memcpy(lsreq->rspaddr, lsrsp->rspbuf,
-- 
2.38.0


