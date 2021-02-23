Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3A1C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 22:11:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA1E64DFF
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 22:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA1E64DFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:From:Subject:Mime-Version:Message-Id:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DDMU54yajr9bJlWT3YW7cjinZeVF3MUtxCfk9w2yXcU=; b=vdgD4/w6hq+EV6NyB2b6Wsg7FO
	WEu+YlHS4yOVkTk8+ufHVVIT2vBQE9QwuDO6X1gNhDoi9mZByzz5olp+YdT1W3dSM8noKhM4K8tEw
	Jzw0VYwkFMzWdLd/TL0GS1hx0olWxK2N98fh2DX/oneX4vSiWTc66RDkb6j3lcCxzqw923Nqx39Qb
	9cS+b3Svf5W6NriuR56jbGUsYpnBhgIz/oKXtuv/6O3RmehKYqcmDICNHKcsLy5gXYvpP/F7Y5TW+
	uccI2xJOtDq9ljGQ5WEUo8s9AeYqZfjICaDgFpTcgrfoEdf+ElkBlWaE8w5TwXdncReBmm1JtIRWG
	VyuQyENA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEftT-0003Aw-Q5; Tue, 23 Feb 2021 22:10:59 +0000
Received: from mail-ej1-x64a.google.com ([2a00:1450:4864:20::64a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEftQ-0003Aa-Jd
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 22:10:57 +0000
Received: by mail-ej1-x64a.google.com with SMTP id v10so2183158ejh.15
 for <linux-nvme@lists.infradead.org>; Tue, 23 Feb 2021 14:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=rbCC4IVKgBMgORLfxVhqPoJtpfRUM6mch3HEimyzh0s=;
 b=akl36C0FLpjtj39wchx42pcz7JL0BJxBSSFCpqWbGsw/DFQp3/2Qp19IzR0thfwa7b
 +QmOhrWiESLjNSurffcHMGzsZdGgawpEu+Cd2zxtVL0bg2Qyx1LwRjWmL/q4GludfSk7
 9FWRlDVahMuQAI3kxoo6h8l7rURxlR0kHYuTAqVcR1yTJKIBgpJl+Ekw6Xa13OGEhczc
 Gj9MNW2AxX7kK1WsRQwsB6LFdDD83RlNLBCXIt3uczFuVy0qvc7J0sGM9AUpMYDiN882
 jfS6PfH/9VONBKdWpB5UxSKzwbdNMgQPpdVhrfNC4FEIpDTOWGN2sE1F32ICP+4flji2
 4mQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=rbCC4IVKgBMgORLfxVhqPoJtpfRUM6mch3HEimyzh0s=;
 b=K8z/5830wXq26mBfnNmvnG62fi3uv2GlyzLhLHx9vtZVamuoJtRo/EuM68QYXTIn5y
 1LeQlWc8mBuM4dNADilB3Y5PYjrwXEVvJp1Me8Gz4IQAIbwZ4iBoCVqJVCjvDF0QJb+s
 6fiU9lX8/eTdzR4A8o0WAdyQT/v4rZ35Aje3wc1vW6fHnuZWKBjx7Ajj8LdFfMzmPIeF
 8WxWiiN4ktSj+eVE/JjN6rF9mlmw1klIDsANhETYeMUpvZhxPWakssmbyNfBXULuf/g+
 H1q51dSjSyYe/b80OSEYLPjo7FPlUhlw5BuJtcACMylpRrEVBq1cdGORh4lDQTXKtXEn
 7PoQ==
X-Gm-Message-State: AOAM530M3g7o344NwsdvEHfbW6qCjBVmKN2dNe+3/shtmQMM6hcN9CpF
 ONAfVHwTt3TUz4QNGIwGJCINuhWDUBrgiRje3wM8KAamiMP9bfPEfcc2zfPJE22EaGcFpQCwfSy
 T1VwtoySgjJGK/q3z2VSjoBawtnvMHF8gYk3JJMSuBkfyGdGwV28SNwIkIbV9ZtkT+SbBdhyK7f
 o=
X-Google-Smtp-Source: ABdhPJwEqqm8ayGLMBB2thk0NneFtBpxzOaNNL4uFShJSyyss2JCN1i554ZIgMZomp8QBTXjAWWe0jJHDb+M
X-Received: from coin.lon.corp.google.com
 ([2a00:79e0:d:204:d145:a68e:c778:fae1])
 (user=pterjan job=sendgmr) by 2002:aa7:c410:: with SMTP id
 j16mr6724026edq.135.1614118253968; Tue, 23 Feb 2021 14:10:53 -0800 (PST)
Date: Tue, 23 Feb 2021 22:10:46 +0000
Message-Id: <20210223221046.3367795-1-pterjan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH] nvme: Add quirks for Lexar 256GB SSD
From: Pascal Terjan <pterjan@google.com>
To: linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_171056_681298_5BBBE873 
X-CRM114-Status: GOOD (  12.90  )
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
Cc: Pascal Terjan <pterjan@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add NVME_QUIRK_NO_NS_DESC_LIST to Lexar 256GB SSD to allow it to
work again, and add NVME_QUIRK_IGNORE_DEV_SUBNQN to avoid a warning.

[    0.637476] nvme nvme0: missing or invalid SUBNQN field.
[    0.638399] nvme nvme0: Identify Descriptors failed (16386)

Reported and tested in https://bugs.mageia.org/show_bug.cgi?id=28417

Signed-off-by: Pascal Terjan <pterjan@google.com>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7b6632c00ffd..9a56ec70e93a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3232,6 +3232,9 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
 		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
+	{ PCI_DEVICE(0x1b4b, 0x1092),	/* Lexar 256 GB SSD */
+		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST |
+				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1c58, 0x0003),	/* HGST adapter */
-- 
2.30.0.617.g56c4b15f3c-goog


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
