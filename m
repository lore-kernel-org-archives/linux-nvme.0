Return-Path: <SRS0=1xwY=4M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E598AC38BE0
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 18:49:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE76320836
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 18:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nV/tWkAM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMKfdyym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE76320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=GYgrCTqQnsYIl9AlkC/ePBaFL9lpBY07PB9uOy10uB8=; b=nV/tWkAMQL/03QhCCCswpKCfYM
	6k/1scbT8eEsTLeQlrCaoZvDr2lt/M+aKOuQvXywh9EAKRaOSMyAWl52/nDudITwlUfNcPrC9zMXl
	3JX8YK2tT/kZNysyoGOBe5B0k32P4QZsdyVvJO26ktZB1rxYFpeOmilyF14SykNeOXOA6ThbprZjQ
	BCWiXauuL0b84F87d422jQ5EgPRsWrBUVjvqHoFjGurbpt1B3q+LCrkYhMuBeY08cY3yMehandx0r
	Loga1vieqBcB5xPcdqaNyyIp3avP5BB6HAn9MSi4BZjeahdYqurwDX0aUwY5ZqW5slG3DHk95jFEN
	VzG7ENDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6In6-0007Kb-DN; Mon, 24 Feb 2020 18:49:16 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6In1-0007Eu-IQ
 for linux-nvme@lists.infradead.org; Mon, 24 Feb 2020 18:49:13 +0000
Received: by mail-wr1-x442.google.com with SMTP id u6so11684810wrt.0
 for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2020 10:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=w/Pj1GIxyEFeOuGofpXNX67FrG4852WRobzW9KxAvjA=;
 b=NMKfdyymwE5DQ2ioCAoTp7bnkXk5v0maYAS/c/T1Lufg6YIEKPJX2WjJ5Dv1tk4sR3
 wAb760yFaNBJIh+YiPuYIcDn06zMj4bJBs8tnSjYoHNLH2c32pTa2bPqk7uwJYlHboXu
 iNCj/RE58P1AWDo+9grQrqk2g6R7Cr9twLMJcI6nA14491skdLqrvG1ai3xR5Csdq1kA
 h0XylDv0BZqBaoib4y0+SqIIIxWJkkH+bKqAis+DEMXJRBrun0sJ0k+QIP8zbDiTZrAb
 TnhS7THQLU2BxYMK/MXernAIv/AMSWVEcfMSWB0c3+Xx3Gt0ds1G5VhYc1aWcTVzwTpB
 w95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=w/Pj1GIxyEFeOuGofpXNX67FrG4852WRobzW9KxAvjA=;
 b=BtLtNdLg6JZc34MzGJRbCj2j+BRrEACGb84VgbRVIQ/DomUMydZ9uLLdwBPyJBJTuO
 rFAiroYiblrWz0WzDRE2Rwhh4rFzSafs945d5qctP3UyVrI2ufeF5DM0aSvA+6CRpFJ1
 N9WOhUaBB4WxmxBF0yGxGXZQxswZarvuq3q2SVw1O5FIoKJGUcdO8JDOd6DuaScVLqKS
 AmbTm/c3IENS+ZxHnIOAsOravg2eXt8yJe64unuN2vTQFJk4ekjugXU5o9pA91YNVfhp
 aSE7zmG9yXKx9Shj5s72u2sQM/1dwn3Or/GyNEAS3e1lfUmYEDnlztw/bZMwq9BJEIPa
 jKZA==
X-Gm-Message-State: APjAAAUKxTXJPh5kBnwLB8+KDb+ABzp2hJSE17nDDbPVt0GzQpt/TrN3
 FwvCcsVwufFoKcrkeN+RS0bNT+zx
X-Google-Smtp-Source: APXvYqwGi/jT4fP6Al3cXHqSmyvR06xtKzPOvK3lex6FWPOCX8Ws7hkZ+f0xlkhFJg4IpbX1ICLM/g==
X-Received: by 2002:adf:a285:: with SMTP id s5mr71728351wra.118.1582570150011; 
 Mon, 24 Feb 2020 10:49:10 -0800 (PST)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id l8sm460047wmj.2.2020.02.24.10.49.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Feb 2020 10:49:09 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [RFC 1/6] nvme: Add ns to nvme_request struct
Date: Mon, 24 Feb 2020 10:48:54 -0800
Message-Id: <20200224184859.20995-2-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200224184859.20995-1-jsmart2021@gmail.com>
References: <20200224184859.20995-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200224_104911_604505_EA1FCB47 
X-CRM114-Status: GOOD (  12.83  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: James Smart <jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

To facilitate obtaining status about the namespace issuing the request,
add a ns pointer to the nvme_request structure.

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/nvme/host/core.c | 2 ++
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84914223c537..a42c0ab37ef4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -475,6 +475,7 @@ static inline void nvme_clear_nvme_request(struct request *req)
 	if (!(req->rq_flags & RQF_DONTPREP)) {
 		nvme_req(req)->retries = 0;
 		nvme_req(req)->flags = 0;
+		nvme_req(req)->ns = NULL;
 		req->rq_flags |= RQF_DONTPREP;
 	}
 }
@@ -758,6 +759,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 	blk_status_t ret = BLK_STS_OK;
 
 	nvme_clear_nvme_request(req);
+	nvme_req(req)->ns = ns;
 
 	memset(cmd, 0, sizeof(*cmd));
 	switch (req_op(req)) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1024fec7914c..11336ec6d27b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -139,6 +139,7 @@ struct nvme_request {
 	u8			flags;
 	u16			status;
 	struct nvme_ctrl	*ctrl;
+	struct nvme_ns		*ns;
 };
 
 /*
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
