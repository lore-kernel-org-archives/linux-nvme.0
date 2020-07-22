Return-Path: <SRS0=li1X=BB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66729C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 23:32:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32ECB2080D
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 23:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="w0EIz9XH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32ECB2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BgpblXfkWxYZqn3SbOlSvsVMqrlh47xbF/ZR6Fa7A7g=; b=w0EIz9XH1aFeDn6j7oRcGWJK9
	crkY9hmKg1+ky8wOsouqo2h8TIlrZ95oHm6GALFb8v1VzN9yAY4EdKWJkDDuK3s+8I89f1CtdQLnk
	7Y5439OtB3Rh2xYyt2iivLrrMzbleCxhXK+o6CNyROSm04SJnjJAp9IEd5dV+cXzAvkJqOsxcH6UR
	h3BCZWZ5ZG2up71PO1G2inujyTVfolf18QIdKzTCCTstSSEruFM4zLNL40VGgq6S7A9IJ4nKvbuqC
	wloubIk9ibk/V1XdvPXWdbMQxBCZHoN/V+6fk90pW9ibZ6NMZpOdYcHtU2+6jyCCO6iIDe8W2phDT
	ooM+YFpIQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyOE7-0005Fw-8V; Wed, 22 Jul 2020 23:32:43 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyOE5-0005FL-1S
 for linux-nvme@lists.infradead.org; Wed, 22 Jul 2020 23:32:41 +0000
Received: by mail-wr1-f65.google.com with SMTP id 88so3451327wrh.3
 for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2020 16:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WzYNjG517igtMwFeS91EI7MDpMv9LCNxx3nPkY2RTEc=;
 b=tigB+rSjGlNn/C3Un2NIxwRbFbeMfbwx/gPNY8TlT2bH6w6851YvilRf/IqQ5/Axdo
 5pam7Re2Pmy/2H9IBuihynQWz8dWXQWVjjDo9tQRetZ0tpjy/vdNAWSbo0R9BBCDSIUJ
 Nq5yBMotBZ6/dxbqrlS1/ZfNJNoc1ov/f6Qw5sQvyl5ncYlEfzPCghWSrycGFCQAM6gV
 dfhYcHTNXMSYuPsUxuxAxQBK4wRSmYECB+O0Q9xTNnTLWnY5POYC7YnZ/MZF3idkZA+X
 WV9AUWnOD3x9vq7smZj7+hnlKmVpG84QVWwV1yGcoDOvIU4Z+7DvLN0HHyDJzR3qFWfA
 Sdyw==
X-Gm-Message-State: AOAM532V2eVKJjVpw+WdZWmKZirtJJL9Aa2uQqdyE6k6x9/mdyYt+KoA
 qNJXqpp/SZ9YkERQfQWCHej6PDbb
X-Google-Smtp-Source: ABdhPJxSrtO2zGW1WwCw6GH+25TMUl2L04fN/C1xUNKraYkExiojUIKlRKA8nvMJSdCTAzOpT11IxQ==
X-Received: by 2002:adf:e544:: with SMTP id z4mr1637893wrm.280.1595460759642; 
 Wed, 22 Jul 2020 16:32:39 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:45ba:2951:1398:d100])
 by smtp.gmail.com with ESMTPSA id p29sm1309108wmi.43.2020.07.22.16.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 16:32:39 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH v3 1/2] nvme: document nvme controller states
Date: Wed, 22 Jul 2020 16:32:18 -0700
Message-Id: <20200722233219.117326-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722233219.117326-1-sagi@grimberg.me>
References: <20200722233219.117326-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200722_193241_089450_2488ED04 
X-CRM114-Status: GOOD (  11.75  )
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
Cc: Anton Eidelman <anton@lightbitslabs.com>,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We are starting to see some non-trivial states
so lets start documenting them.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/nvme.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2ee91a3dd8e0..92629758b77c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -181,6 +181,20 @@ static inline u16 nvme_req_qid(struct request *req)
  */
 #define NVME_QUIRK_DELAY_AMOUNT		2300
 
+/*
+ * enum nvme_ctrl_state: Controller state
+ *
+ * @NVME_CTRL_NEW:		New controller just allocated, initial state
+ * @NVME_CTRL_LIVE:		Controller is connected and I/O capable
+ * @NVME_CTRL_RESETTING:	Controller is resetting (or scheduled reset)
+ * @NVME_CTRL_CONNECTING:	Controller is disconnected, now connecting the
+ *				transport
+ * @NVME_CTRL_DELETING:		Controller is deleting (or scheduled deletion)
+ * @NVME_CTRL_DEAD:		Controller is non-present/unresponsive during
+ *				shutdown or removal. In this case we forcibly
+ *				kill all inflight I/O as they have no chance to
+ *				complete
+ */
 enum nvme_ctrl_state {
 	NVME_CTRL_NEW,
 	NVME_CTRL_LIVE,
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
